Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ipt5k-00068S-Ow for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Nov 2007 14:09:46 -0800
Received: from wa-out-1112.google.com ([209.85.146.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ipt5i-0005Be-6W
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Nov 2007 14:09:44 -0800
Received: by wa-out-1112.google.com with SMTP id k22so4207250waf
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 07 Nov 2007 14:09:40 -0800 (PST)
Message-ID: <ea9232d10711071409i349826aao20aa2f3694d87994@mail.gmail.com>
Date: Wed, 7 Nov 2007 23:09:34 +0100
From: Magotari <magotari@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] uml: remove an unused variable in
	arch_switch_{to, tls}
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
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net

This patch removes a variable which was not used in two functions.
Yet another code cleanup, nothing really significant.

Please note that I could not test this on x86_64. I don't have the
hardware for it.

Karol Swietlicki

Signed-off-by: Karol Swietlicki <magotari@gmail.com>
---

diff -upNr linux-2.6.24-rc1/arch/um/kernel/process.c
linux-2.6.23/arch/um/kernel/process.c
--- linux-2.6.24-rc1/arch/um/kernel/process.c	2007-10-24
05:50:57.000000000 +0200
+++ linux-2.6.23/arch/um/kernel/process.c	2007-11-07 19:01:28.000000000 +0100
@@ -83,7 +83,7 @@ static inline void set_current(struct ta
 		{ external_pid(task), task });
 }

-extern void arch_switch_to(struct task_struct *from, struct task_struct *to);
+extern void arch_switch_to(struct task_struct *to);

 void *_switch_to(void *prev, void *next, void *last)
 {
@@ -99,7 +99,7 @@ void *_switch_to(void *prev, void *next,
 		switch_threads(&from->thread.switch_buf,
 			       &to->thread.switch_buf);

-		arch_switch_to(current->thread.prev_sched, current);
+		arch_switch_to(current);

 		if (current->thread.saved_task)
 			show_regs(&(current->thread.regs));
@@ -173,7 +170,7 @@ void fork_handler(void)
 	 * arch_switch_to isn't needed. We could want to apply this to
 	 * improve performance. -bb
 	 */
-	arch_switch_to(current->thread.prev_sched, current);
+	arch_switch_to(current);

 	current->thread.prev_sched = NULL;

 int arch_handle_signal(int sig, struct uml_pt_regs *regs)
diff -upNr linux-2.6.24-rc1/arch/um/sys-i386/ptrace.c
linux-2.6.23/arch/um/sys-i386/ptrace.c
--- linux-2.6.24-rc1/arch/um/sys-i386/ptrace.c	2007-10-24
05:50:57.000000000 +0200
+++ linux-2.6.23/arch/um/sys-i386/ptrace.c	2007-11-07 19:00:52.000000000 +0100
@@ -8,11 +8,11 @@
 #include "asm/uaccess.h"
 #include "skas.h"

-extern int arch_switch_tls(struct task_struct *from, struct task_struct *to);
+extern int arch_switch_tls(struct task_struct *to);

-void arch_switch_to(struct task_struct *from, struct task_struct *to)
+void arch_switch_to(struct task_struct *to)
 {
-	int err = arch_switch_tls(from, to);
+	int err = arch_switch_tls(to);
 	if (!err)
 		return;

diff -upNr linux-2.6.24-rc1/arch/um/sys-i386/tls.c
linux-2.6.23/arch/um/sys-i386/tls.c
--- linux-2.6.24-rc1/arch/um/sys-i386/tls.c	2007-10-24 05:50:57.000000000 +0200
+++ linux-2.6.23/arch/um/sys-i386/tls.c	2007-11-07 19:01:56.000000000 +0100
@@ -172,7 +172,7 @@ void clear_flushed_tls(struct task_struc
  * SKAS patch.
  */

-int arch_switch_tls(struct task_struct *from, struct task_struct *to)
+int arch_switch_tls(struct task_struct *to)
 {
 	if (!host_supports_tls)
 		return 0;
Files linux-2.6.24-rc1/arch/um/sys-i386/user-offsets.gcno and
linux-2.6.23/arch/um/sys-i386/user-offsets.gcno differ
diff -upNr linux-2.6.24-rc1/arch/um/sys-x86_64/syscalls.c
linux-2.6.23/arch/um/sys-x86_64/syscalls.c
--- linux-2.6.24-rc1/arch/um/sys-x86_64/syscalls.c	2007-10-24
05:50:57.000000000 +0200
+++ linux-2.6.23/arch/um/sys-x86_64/syscalls.c	2007-11-07
18:57:42.000000000 +0100
@@ -105,7 +105,7 @@ long sys_clone(unsigned long clone_flags
 	return ret;
 }

-void arch_switch_to(struct task_struct *from, struct task_struct *to)
+void arch_switch_to(struct task_struct *to)
 {
 	if ((to->thread.arch.fs == 0) || (to->mm == NULL))
 		return;

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
