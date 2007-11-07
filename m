Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ippln-00007d-1G for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Nov 2007 10:36:56 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ipplk-0004P5-Cu
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Nov 2007 10:36:55 -0800
Date: Wed, 7 Nov 2007 13:36:38 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071107183638.GA8467@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 2/5] UML - Allow LFLAGS on command line
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
To: Andrew Morton <akpm@osdl.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Allow LFLAGS to be given to make and have the expected effect.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/Makefile |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6/arch/um/Makefile
===================================================================
--- linux-2.6.orig/arch/um/Makefile	2007-11-06 10:46:55.000000000 -0500
+++ linux-2.6/arch/um/Makefile	2007-11-07 12:44:29.000000000 -0500
@@ -130,7 +130,9 @@ CPPFLAGS_vmlinux.lds = -U$(SUBARCH) -DST
 # The wrappers will select whether using "malloc" or the kernel allocator.
 LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
 
-CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS)
+LD_FLAGS_CMDLINE = $(foreach opt,$(LFLAGS),-Wl,$(opt))
+
+CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE)
 define cmd_vmlinux__
 	$(CC) $(CFLAGS_vmlinux) -o $@ \
 	-Wl,-T,$(vmlinux-lds) $(vmlinux-init) \

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
