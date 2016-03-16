Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <elicooper@gmx.com>) id 1ag78O-0003ig-RV
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Mar 2016 08:48:52 +0000
Received: from mout.gmx.net ([212.227.15.18])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ag78N-0002yJ-Ri
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Mar 2016 08:48:52 +0000
From: Eli Cooper <elicooper@gmx.com>
Date: Wed, 16 Mar 2016 16:48:29 +0800
Message-Id: <1458118109-3178-4-git-send-email-elicooper@gmx.com>
In-Reply-To: <1458118109-3178-1-git-send-email-elicooper@gmx.com>
References: <1458118109-3178-1-git-send-email-elicooper@gmx.com>
Subject: [uml-devel] [PATCH v2 3/3] um: fix ptrace PTRACE_GETFPREGS and
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
 arch/x86/um/ptrace_32.c |  5 +++--
 arch/x86/um/ptrace_64.c | 16 ++++++++--------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/um/ptrace_32.c b/arch/x86/um/ptrace_32.c
index 47c78d5..ebd4dd6 100644
--- a/arch/x86/um/ptrace_32.c
+++ b/arch/x86/um/ptrace_32.c
@@ -194,7 +194,8 @@ static int get_fpregs(struct user_i387_struct __user *buf, struct task_struct *c
 	int err, n, cpu = ((struct thread_info *) child->stack)->cpu;
 	struct user_i387_struct fpregs;
 
-	err = save_fp_registers(userspace_pid[cpu], (unsigned long *) &fpregs);
+	err = save_i387_registers(userspace_pid[cpu],
+				  (unsigned long *) &fpregs);
 	if (err)
 		return err;
 
@@ -214,7 +215,7 @@ static int set_fpregs(struct user_i387_struct __user *buf, struct task_struct *c
 	if (n > 0)
 		return -EFAULT;
 
-	return restore_fp_registers(userspace_pid[cpu],
+	return restore_i387_registers(userspace_pid[cpu],
 				    (unsigned long *) &fpregs);
 }
 
diff --git a/arch/x86/um/ptrace_64.c b/arch/x86/um/ptrace_64.c
index a629694..faab418 100644
--- a/arch/x86/um/ptrace_64.c
+++ b/arch/x86/um/ptrace_64.c
@@ -222,14 +222,14 @@ int is_syscall(unsigned long addr)
 static int get_fpregs(struct user_i387_struct __user *buf, struct task_struct *child)
 {
 	int err, n, cpu = ((struct thread_info *) child->stack)->cpu;
-	long fpregs[HOST_FP_SIZE];
+	struct user_i387_struct fpregs;
 
-	BUG_ON(sizeof(*buf) != sizeof(fpregs));
-	err = save_fp_registers(userspace_pid[cpu], fpregs);
+	err = save_i387_registers(userspace_pid[cpu],
+				  (unsigned long *) &fpregs);
 	if (err)
 		return err;
 
-	n = copy_to_user(buf, fpregs, sizeof(fpregs));
+	n = copy_to_user(buf, &fpregs, sizeof(fpregs));
 	if (n > 0)
 		return -EFAULT;
 
@@ -239,14 +239,14 @@ static int get_fpregs(struct user_i387_struct __user *buf, struct task_struct *c
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
+	return restore_i387_registers(userspace_pid[cpu],
+				      (unsigned long *) &fpregs);
 }
 
 long subarch_ptrace(struct task_struct *child, long request,
-- 
2.7.2


------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785231&iu=/4140
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

