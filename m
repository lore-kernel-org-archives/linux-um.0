Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8Na1-0002Du-AI for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 11:07:49 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D8NZz-0001dk-9a for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 11:07:49 -0800
Message-Id: <200503072037.j27Kbjbc003962@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 5/16] UML - Fix some usercopy confusion
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
Date: Mon, 07 Mar 2005 15:37:45 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This fixes a couple of copy-user problems spotted by Al Viro.  
copy_sc_from_user_tt was doing a copy_from_user to do an in-kernel 
assignment.  I commented this, at the request of Chris Wedgewood.
sys_ipc had a void *__user ptr which should have been void __user *ptr.
Finally, there were a couple of bogus __user annotations on unsigned longs, 
which were never going to be passed into copy_user.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/sys-i386/signal.c
===================================================================
--- linux-2.6.11.orig/arch/um/sys-i386/signal.c	2005-03-05 12:07:34.000000000 -0500
+++ linux-2.6.11/arch/um/sys-i386/signal.c	2005-03-05 12:10:27.000000000 -0500
@@ -108,6 +108,15 @@
 #endif
 
 #ifdef CONFIG_MODE_TT
+
+/* These copy a sigcontext to/from userspace.  They copy the fpstate pointer,
+ * blowing away the old, good one.  So, that value is saved, and then restored
+ * after the sigcontext copy.  In copy_from, the variable holding the saved
+ * fpstate pointer, and the sigcontext that it should be restored to are both
+ * in the kernel, so we can just restore using an assignment.  In copy_to, the
+ * saved pointer is in the kernel, but the sigcontext is in userspace, so we
+ * copy_to_user it.
+ */
 int copy_sc_from_user_tt(struct sigcontext *to, struct sigcontext *from,
 			 int fpsize)
 {
@@ -120,11 +129,9 @@
 	sigs = to->oldmask;
 	err = copy_from_user(to, from, sizeof(*to));
 	to->oldmask = sigs;
-	if(to_fp != NULL){
-		err |= copy_from_user(&to->fpstate, &to_fp,
-				      sizeof(to->fpstate));
+	to->fpstate = to_fp;
+	if(to_fp != NULL)
 		err |= copy_from_user(to_fp, from_fp, fpsize);
-	}
 	return(err);
 }
 
@@ -138,8 +145,7 @@
 	from_fp = from->fpstate;
 	err = copy_to_user(to, from, sizeof(*to));
 	if(from_fp != NULL){
-		err |= copy_to_user(&to->fpstate, &to_fp,
-					 sizeof(to->fpstate));
+		err |= copy_to_user(&to->fpstate, &to_fp, sizeof(to->fpstate));
 		err |= copy_to_user(to_fp, from_fp, fpsize);
 	}
 	return(err);
@@ -303,7 +309,7 @@
 
 long sys_sigreturn(struct pt_regs regs)
 {
-	unsigned long __user sp = PT_REGS_SP(&current->thread.regs);
+	unsigned long sp = PT_REGS_SP(&current->thread.regs);
 	struct sigframe __user *frame = (struct sigframe *)(sp - 8);
 	sigset_t set;
 	struct sigcontext __user *sc = &frame->sc;
Index: linux-2.6.11/arch/um/sys-i386/syscalls.c
===================================================================
--- linux-2.6.11.orig/arch/um/sys-i386/syscalls.c	2005-03-05 12:07:31.000000000 -0500
+++ linux-2.6.11/arch/um/sys-i386/syscalls.c	2005-03-05 12:10:27.000000000 -0500
@@ -88,7 +88,7 @@
  * This is really horribly ugly.
  */
 long sys_ipc (uint call, int first, int second,
-	     int third, void *__user ptr, long fifth)
+	     int third, void __user *ptr, long fifth)
 {
 	int version, ret;
 
Index: linux-2.6.11/arch/um/sys-x86_64/signal.c
===================================================================
--- linux-2.6.11.orig/arch/um/sys-x86_64/signal.c	2005-03-05 12:07:34.000000000 -0500
+++ linux-2.6.11/arch/um/sys-x86_64/signal.c	2005-03-05 12:10:27.000000000 -0500
@@ -237,7 +237,7 @@
 
 long sys_rt_sigreturn(struct pt_regs *regs)
 {
-	unsigned long __user sp = PT_REGS_SP(&current->thread.regs);
+	unsigned long sp = PT_REGS_SP(&current->thread.regs);
 	struct rt_sigframe __user *frame =
 		(struct rt_sigframe __user *)(sp - 8);
 	struct ucontext __user *uc = &frame->uc;



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
