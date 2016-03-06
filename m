Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <elicooper@gmx.com>) id 1acZnl-0008M9-Fx
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Mar 2016 14:36:57 +0000
Received: from mout.gmx.net ([212.227.15.15])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1acZnk-00061o-FF for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Mar 2016 14:36:57 +0000
From: Eli Cooper <elicooper@gmx.com>
Date: Sun,  6 Mar 2016 22:36:27 +0800
Message-Id: <1457274987-20078-4-git-send-email-elicooper@gmx.com>
In-Reply-To: <1457274987-20078-1-git-send-email-elicooper@gmx.com>
References: <1457274987-20078-1-git-send-email-elicooper@gmx.com>
Subject: [uml-devel] [PATCH 3/3] um: fix ptrace PTRACE_GETFPREGS and
	PTRACE_SETFPREG support
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>

This patch makes ptrace in UML responde to PTRACE_GETFPREGS/_SETFPREG
requests with a user_i387_struct (thus independent from HOST_FP_SIZE), and
by calling save_i387_registers() and restore_i387_registers() instead of
the extended save_fp_registers() and restore_fp_registers() functions.

Signed-off-by: Eli Cooper <elicooper@gmx.com>
---
 arch/x86/um/ptrace_32.c |  4 ++--
 arch/x86/um/ptrace_64.c | 14 ++++++--------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/um/ptrace_32.c b/arch/x86/um/ptrace_32.c
index 47c78d5..2eeaf2c 100644
--- a/arch/x86/um/ptrace_32.c
+++ b/arch/x86/um/ptrace_32.c
@@ -194,7 +194,7 @@ static int get_fpregs(struct user_i387_struct __user *buf, struct task_struct *c
 	int err, n, cpu = ((struct thread_info *) child->stack)->cpu;
 	struct user_i387_struct fpregs;
 
-	err = save_fp_registers(userspace_pid[cpu], (unsigned long *) &fpregs);
+	err = save_i387_registers(userspace_pid[cpu],
+				  (unsigned long *) &fpregs);
 	if (err)
 		return err;
 
@@ -214,7 +214,7 @@ static int set_fpregs(struct user_i387_struct __user *buf, struct task_struct *c
 	if (n > 0)
 		return -EFAULT;
 
-	return restore_fp_registers(userspace_pid[cpu],
+	return restore_i387_registers(userspace_pid[cpu],
 				    (unsigned long *) &fpregs);
 }
 
diff --git a/arch/x86/um/ptrace_64.c b/arch/x86/um/ptrace_64.c
index a629694..14c9ab1 100644
--- a/arch/x86/um/ptrace_64.c
+++ b/arch/x86/um/ptrace_64.c
@@ -222,14 +222,13 @@ int is_syscall(unsigned long addr)
 static int get_fpregs(struct user_i387_struct __user *buf, struct task_struct *child)
 {
 	int err, n, cpu = ((struct thread_info *) child->stack)->cpu;
-	long fpregs[HOST_FP_SIZE];
+	struct user_i387_struct fpregs;
 
-	BUG_ON(sizeof(*buf) != sizeof(fpregs));
-	err = save_fp_registers(userspace_pid[cpu], fpregs);
+	err = save_i387_registers(userspace_pid[cpu], &fpregs);
 	if (err)
 		return err;
 
-	n = copy_to_user(buf, fpregs, sizeof(fpregs));
+	n = copy_to_user(buf, &fpregs, sizeof(fpregs));
 	if (n > 0)
 		return -EFAULT;
 
@@ -239,14 +238,13 @@ static int get_fpregs(struct user_i387_struct __user *buf, struct task_struct *c
 static int set_fpregs(struct user_i387_struct __user *buf, struct task_struct *child)
 {
 	int n, cpu = ((struct thread_info *) child->stack)->cpu;
-	long fpregs[HOST_FP_SIZE];
+	struct user_i387_struct fpregs;
 
-	BUG_ON(sizeof(*buf) != sizeof(fpregs));
-	n = copy_from_user(fpregs, buf, sizeof(fpregs));
+	n = copy_from_user(&fpregs, buf, sizeof(fpregs));
 	if (n > 0)
 		return -EFAULT;
 
-	return restore_fp_registers(userspace_pid[cpu], fpregs);
+	return restore_i387_registers(userspace_pid[cpu], &fpregs);
 }
 
 long subarch_ptrace(struct task_struct *child, long request,
-- 
2.7.2


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

