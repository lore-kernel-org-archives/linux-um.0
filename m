Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JtWDZ-0003Ul-OD for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 May 2008 16:05:05 -0700
Received: from mx1.redhat.com ([66.187.233.31])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JtWDY-0005Hp-7H
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 May 2008 16:05:05 -0700
Date: Tue, 6 May 2008 19:04:43 -0400
From: Ulrich Drepper <drepper@redhat.com>
Message-Id: <200805062304.m46N4h6d007206@devserv.devel.redhat.com>
Subject: [uml-devel] [PATCH] fix UML on x86-64
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
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, tglx@linutronix.de, mingo@elte.hu

This patch breaks UML for me on x86-64 running Fedora 8 (gcc 4.1.2):

commit 22eecde2f9034764a3fd095eecfa3adfb8ec9a98
Author: Ingo Molnar <mingo@elte.hu>
Date:   Thu May 1 12:06:54 2008 +0200

    uml: fix gcc problem
    
    this is what caused gcc 4.3 to throw an internal error when
    OPTIMIZE_INLINING was enabled ...
    
    Signed-off-by: Ingo Molnar <mingo@elte.hu>
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


If you want to use the option for gcc 4.3 then do it, but only for those
versions.  I haven't tested whether gcc 4.2 and 4.3 works, I just know
that gcc 4.1.2 needs the option for some reason.


Signed-off-by: Ulrich Drepper <drepper@redhat.com>

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 01b97c1..3f52a8c 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -77,9 +77,9 @@ include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
 KERNEL_DEFINES = $(strip -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask \
 			 -Dmktime=kernel_mktime $(ARCH_KERNEL_DEFINES))
 KBUILD_CFLAGS += $(KERNEL_DEFINES)
-# Disable unit-at-a-time mode on pre-gcc-4.0 compilers, it makes gcc use
+# Disable unit-at-a-time mode on pre-gcc-4.3 compilers, it makes gcc use
 # a lot more stack due to the lack of sharing of stacklots:
-KBUILD_CFLAGS += $(shell if [ $(call cc-version) -lt 0400 ] ; then \
+KBUILD_CFLAGS += $(shell if [ $(call cc-version) -lt 0430 ] ; then \
 			echo $(call cc-option,-fno-unit-at-a-time); fi ;)
 
 PHONY += linux

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
