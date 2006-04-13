Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FU6PF-0001Pb-SN for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Apr 2006 11:19:01 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FU6PE-0000ws-Jk
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Apr 2006 11:19:01 -0700
Message-Id: <200604131720.k3DHK2N3004679@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [RFC] PATCH 1/4 - Time virtualization : namespace
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
Date: Thu, 13 Apr 2006 13:20:00 -0400
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Add time namespace, which contains an offset from the system time.  
In a namespace, gettimeofday gets the system time and adds the
namespace offset to it.  settimeofday, which is unprivileged in a
namespace, calculates the difference between the system time and the
new namespace time and sets that as the namespace offset.

Index: linux-2.6.17-mm-vtime/kernel/time.c
===================================================================
--- linux-2.6.17-mm-vtime.orig/kernel/time.c	2006-04-13 13:48:03.000000000 -0400
+++ linux-2.6.17-mm-vtime/kernel/time.c	2006-04-13 13:48:32.000000000 -0400
@@ -103,6 +103,11 @@ asmlinkage long sys_gettimeofday(struct 
 	if (likely(tv != NULL)) {
 		struct timeval ktv;
 		do_gettimeofday(&ktv);
+		if(current->time_ns != NULL){
+			s64 now = timeval_to_ns(&ktv);
+			now += current->time_ns->offset;
+			ktv = ns_to_timeval(now);
+		}
 		if (copy_to_user(tv, &ktv, sizeof(ktv)))
 			return -EFAULT;
 	}
@@ -158,6 +163,18 @@ int do_sys_settimeofday(struct timespec 
 	if (tv && !timespec_valid(tv))
 		return -EINVAL;
 
+	if(current->time_ns != NULL){
+		struct timeval now;
+		s64 old, new;
+
+		do_gettimeofday(&now);
+		old = timeval_to_ns(&now);
+		new = timespec_to_ns(tv);
+		current->time_ns->offset = new - old;
+
+		return 0;
+	}
+
 	error = security_settime(tv, tz);
 	if (error)
 		return error;
Index: linux-2.6.17-mm-vtime/include/linux/sched.h
===================================================================
--- linux-2.6.17-mm-vtime.orig/include/linux/sched.h	2006-04-13 13:48:03.000000000 -0400
+++ linux-2.6.17-mm-vtime/include/linux/sched.h	2006-04-13 13:48:32.000000000 -0400
@@ -715,6 +715,11 @@ enum sleep_type {
 	SLEEP_INTERRUPTED,
 };
 
+struct time_ns {
+	atomic_t counter;
+	s64 offset;
+};
+
 struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
 	struct thread_info *thread_info;
@@ -838,6 +843,7 @@ struct task_struct {
 /* signal handlers */
 	struct signal_struct *signal;
 	struct sighand_struct *sighand;
+	struct time_ns *time_ns;
 
 	sigset_t blocked, real_blocked;
 	sigset_t saved_sigmask;		/* To be restored with TIF_RESTORE_SIGMASK */
Index: linux-2.6.17-mm-vtime/include/linux/init_task.h
===================================================================
--- linux-2.6.17-mm-vtime.orig/include/linux/init_task.h	2006-04-13 13:48:03.000000000 -0400
+++ linux-2.6.17-mm-vtime/include/linux/init_task.h	2006-04-13 13:48:32.000000000 -0400
@@ -98,6 +98,7 @@ extern struct group_info init_groups;
 	.tasks		= LIST_HEAD_INIT(tsk.tasks),			\
 	.ptrace_children= LIST_HEAD_INIT(tsk.ptrace_children),		\
 	.ptrace_list	= LIST_HEAD_INIT(tsk.ptrace_list),		\
+	.time_ns	= NULL,						\
 	.real_parent	= &tsk,						\
 	.parent		= &tsk,						\
 	.children	= LIST_HEAD_INIT(tsk.children),			\



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
