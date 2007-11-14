Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IsNRJ-0007xs-3Y for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Nov 2007 10:58:17 -0800
Received: from mail.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IsNRI-0003wk-BP
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Nov 2007 10:58:17 -0800
From: <gregkh@suse.de>
Date: Wed, 14 Nov 2007 10:58:00 -0800
In-Reply-To: <20071101195326.GA8888@c2.user-mode-linux.org>
Message-Id: <20071114185809.114D614540D0@imap.suse.de>
Subject: [uml-devel] patch uml-fix-kernel-vs-libc-symbols-clash.patch queued
	to -stable tree
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jdike@addtoit.com, akpm@linux-foundation.org, gregkh@suse.de, jdike@linux.intel.com, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, user-mode-linux-devel@lists.sourceforge.net
Cc: stable@kernel.org, stable-commits@vger.kernel.org


This is a note to let you know that we have just queued up the patch titled

     Subject: UML - Fix kernel vs libc symbols clash

to the 2.6.23-stable tree.  Its filename is

     uml-fix-kernel-vs-libc-symbols-clash.patch

A git repo of this tree can be found at 
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary


From stable-bounces@linux.kernel.org Thu Nov  1 12:54:06 2007
From: Jeff Dike <jdike@addtoit.com>
Date: Thu, 1 Nov 2007 15:53:26 -0400
Subject: UML - Fix kernel vs libc symbols clash
To: stable@kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Message-ID: <20071101195326.GA8888@c2.user-mode-linux.org>
Content-Disposition: inline


From: Jeff Dike <jdike@addtoit.com>

commit 818f6ef407b448cef63294b9d0f6f8a2af9cb817 in mainline.

uml: fix an IPV6 libc vs kernel symbol clash

On some systems, with IPV6 configured, there is a clash between the kernel's
in6addr_any and the one in libc.

This is handled in the usual (gross) way of defining the kernel symbol out of
the way on the gcc command line.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/um/Makefile |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -60,7 +60,8 @@ SYS_DIR		:= $(ARCH_DIR)/include/sysdep-$
 
 CFLAGS += $(CFLAGS-y) -D__arch_um__ -DSUBARCH=\"$(SUBARCH)\"	\
 	$(ARCH_INCLUDE) $(MODE_INCLUDE) -Dvmap=kernel_vmap	\
-	-Din6addr_loopback=kernel_in6addr_loopback
+	-Din6addr_loopback=kernel_in6addr_loopback \
+	-Din6addr_any=kernel_in6addr_any
 
 AFLAGS += $(ARCH_INCLUDE)
 


Patches currently in stable-queue which might be from jdike@addtoit.com are

queue-2.6.23/uml-stop-using-libc-asm-page.h.patch
queue-2.6.23/uml-fix-kernel-vs-libc-symbols-clash.patch
queue-2.6.23/uml-stop-using-libc-asm-user.h.patch

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
