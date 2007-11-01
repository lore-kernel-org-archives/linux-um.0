Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ing70-00006P-SR for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Nov 2007 12:53:54 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ing6y-0006xL-83
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Nov 2007 12:53:54 -0700
Date: Thu, 1 Nov 2007 15:53:26 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071101195326.GA8888@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 2/4] UML - Fix kernel vs libc symbols clash
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
To: stable@kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

commit 2a772652c3971745228a2e40e6575ae594c88365
Author: Jeff Dike <jdike@addtoit.com>
Date:   Tue Oct 16 01:26:45 2007 -0700

    uml: fix an IPV6 libc vs kernel symbol clash
    
    On some systems, with IPV6 configured, there is a clash between the kernel's
    in6addr_any and the one in libc.
    
    This is handled in the usual (gross) way of defining the kernel symbol out of
    the way on the gcc command line.
    
    Signed-off-by: Jeff Dike <jdike@linux.intel.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/um/Makefile |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 989224f..c3a399e 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -60,7 +60,8 @@ SYS_DIR		:= $(ARCH_DIR)/include/sysdep-$(SUBARCH)
 
 CFLAGS += $(CFLAGS-y) -D__arch_um__ -DSUBARCH=\"$(SUBARCH)\"	\
 	$(ARCH_INCLUDE) $(MODE_INCLUDE) -Dvmap=kernel_vmap	\
-	-Din6addr_loopback=kernel_in6addr_loopback
+	-Din6addr_loopback=kernel_in6addr_loopback \
+	-Din6addr_any=kernel_in6addr_any
 
 AFLAGS += $(ARCH_INCLUDE)
 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
