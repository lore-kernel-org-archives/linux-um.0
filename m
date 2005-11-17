Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EcqCe-0008NV-7a for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 12:17:52 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EcqCc-00078r-L5
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 12:17:52 -0800
Message-Id: <200511172110.jAHLAPRZ010194@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/4] UML - Eliminate use of local in clone stub
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 17 Nov 2005 16:10:25 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

[ These four patches are 2.6.15 material, as they fix various crashes and 
a compile failure ]

We have a bug in the i386 stub_syscall6 which pushes ebp before the
system call and pops it afterwards.  Because we use syscall6 to
remap the stack, the old contents of the stack (and the former value
of ebp) are no longer available.  Some versions of gcc make from a
real local, accessed through ebp, despite my efforts to make it
obvious that references to from are really constants.
This patch attempts to make it even more obvious by eliminating from
and using a macro to access the stub's data explicitly with
constants.
My original thinking on this was to replace syscall6 with a
remap_stack interface which saved ebp someplace and restored it
afterwards.  The problem is that there are no registers to put it
in, except for esp.  That could work, since we can store a constant
in esp after the mmap because we just replaced the stack.  However,
this approach seems a tad cleaner.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/kernel/skas/clone.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/skas/clone.c	2005-11-17 14:58:30.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/skas/clone.c	2005-11-17 14:58:54.000000000 -0500
@@ -13,11 +13,13 @@
 /* This is in a separate file because it needs to be compiled with any
  * extraneous gcc flags (-pg, -fprofile-arcs, -ftest-coverage) disabled
  */
+
+#define STUB_DATA(field) (((struct stub_data *) UML_CONFIG_STUB_DATA)->field)
+
 void __attribute__ ((__section__ (".__syscall_stub")))
 stub_clone_handler(void)
 {
 	long err;
-	struct stub_data *from = (struct stub_data *) UML_CONFIG_STUB_DATA;
 
 	err = stub_syscall2(__NR_clone, CLONE_PARENT | CLONE_FILES | SIGCHLD,
 			    UML_CONFIG_STUB_DATA + PAGE_SIZE / 2 -
@@ -30,15 +32,15 @@ stub_clone_handler(void)
 		goto out;
 
 	err = stub_syscall3(__NR_setitimer, ITIMER_VIRTUAL,
-			    (long) &from->timer, 0);
+			    (long) &STUB_DATA(timer), 0);
 	if(err)
 		goto out;
 
 	err = stub_syscall6(STUB_MMAP_NR, UML_CONFIG_STUB_DATA, PAGE_SIZE,
 			    PROT_READ | PROT_WRITE, MAP_FIXED | MAP_SHARED,
-			    from->fd, from->offset);
+			    STUB_DATA(fd), STUB_DATA(offset));
  out:
 	/* save current result. Parent: pid; child: retcode of mmap */
-	from->err = err;
+	STUB_DATA(err) = err;
 	trap_myself();
 }



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
