Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IsetU-00014U-2O for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Nov 2007 05:36:32 -0800
Received: from ro-out-1112.google.com ([72.14.202.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IsetS-0008CQ-E7
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Nov 2007 05:36:31 -0800
Received: by ro-out-1112.google.com with SMTP id o35so221369rog
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 15 Nov 2007 05:36:27 -0800 (PST)
Date: Thu, 15 Nov 2007 21:34:21 +0800
From: WANG Cong <xiyou.wangcong@gmail.com>
Message-ID: <20071115133421.GD2489@hacking>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [SPAM] [uml-devel] [Patch] UML: building error fix
Reply-To: WANG Cong <xiyou.wangcong@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@karaya.com>, user-mode-linux-devel@lists.sourceforge.net


include/asm-um/arch points to the non-existed include/asm-i386 directory.
This patch fixed it.

Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>
Cc: Jeff Dike <jdike@karaya.com>

---

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 31999bc..ba6813a 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -168,7 +168,7 @@ ifneq ($(KBUILD_SRC),)
 	$(Q)mkdir -p $(objtree)/include/asm-um
 	$(Q)ln -fsn $(srctree)/include/asm-$(HEADER_ARCH) include/asm-um/arch
 else
-	$(Q)cd $(TOPDIR)/include/asm-um && ln -fsn ../asm-$(SUBARCH) arch
+	$(Q)cd $(TOPDIR)/include/asm-um && ln -fsn ../asm-$(HEADER_ARCH) arch
 endif
 
 $(objtree)/$(ARCH_DIR)/include:

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
