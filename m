Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CDSHr-0001mu-4I for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Oct 2004 11:37:47 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CDSHp-0001Wq-Qc for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Oct 2004 11:37:47 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <8B6FF516CBA0194AB0996705076B02520F7C46@ABGEX01E.abg.fsc.net>
From: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
Subject: [uml-devel] Security patch 2 of 3
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
Date: Fri, 1 Oct 2004 20:20:36 +0200
Content-Transfer-Encoding: 8bit
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, BlaisorBlade <blaisorblade_spam@yahoo.it>

This patch moves the flag "singlestep_syscall" from
thread.mode.tt.singlestep_syscall to thread.singlestep_syscall.
The flag is not yet used in SKAS mode. The change is for
preparation only, it doesn't change the kernels behavior.

Bodo

By the way: in the meantime I modified my mailer's settings to
wrap lines only if they are longer than 132 characters. But what
I get from the mailing list still seems to be broken. I don't know
whether the mail sent directly to Jeff and BlaisorBlade is OK.
Please let me know. Maybe our mail server wraps lines?


--- linux-2.6.9-rc2-orig/include/asm-um/processor-generic.h
2004-09-27 18:20:18.000000000 +0200
+++ linux-2.6.9-rc2/include/asm-um/processor-generic.h	2004-10-01
17:54:44.527677537 +0200
@@ -25,6 +25,7 @@
 	unsigned long cr2;
 	int err;
 	unsigned long trap_no;
+	int singlestep_syscall;
 	void *fault_addr;
 	void *fault_catcher;
 	struct task_struct *prev_sched;
@@ -37,7 +38,6 @@
 			int extern_pid;
 			int tracing;
 			int switch_pipe[2];
-			int singlestep_syscall;
 			int vm_seq;
 		} tt;
 #endif
--- linux-2.6.9-rc2-orig/arch/um/kernel/signal_kern.c	2004-09-30
21:07:11.000000000 +0200
+++ linux-2.6.9-rc2/arch/um/kernel/signal_kern.c	2004-10-01
17:58:13.816091409 +0200
@@ -135,7 +135,7 @@
 	 */
 	if((current->ptrace & PT_DTRACE) && 
 	   is_syscall(PT_REGS_IP(&current->thread.regs)))
- 		(void)
CHOOSE_MODE(current->thread.mode.tt.singlestep_syscall = 1, 0);
+ 		current->thread.singlestep_syscall = 1;
 
 	return( handled_sig);
 }
--- linux-2.6.9-rc2-orig/arch/um/kernel/tt/process_kern.c
2004-09-27 18:20:17.000000000 +0200
+++ linux-2.6.9-rc2/arch/um/kernel/tt/process_kern.c	2004-10-01
18:00:11.519640212 +0200
@@ -528,7 +528,7 @@
 {
 	struct task_struct *task = t;
 
-	if(task->thread.mode.tt.singlestep_syscall)
+	if(task->thread.singlestep_syscall)
 		return(0);
 	return(task->ptrace & PT_DTRACE);
 }
--- linux-2.6.9-rc2-orig/arch/um/kernel/tt/syscall_kern.c
2004-09-27 19:24:56.000000000 +0200
+++ linux-2.6.9-rc2/arch/um/kernel/tt/syscall_kern.c	2004-10-01
18:01:35.530756886 +0200
@@ -30,8 +30,8 @@
 		res = -ENOSYS;
 	else res = EXECUTE_SYSCALL(syscall, regs);
 
-	if(current->thread.mode.tt.singlestep_syscall){
-		current->thread.mode.tt.singlestep_syscall = 0;
+	if(current->thread.singlestep_syscall){
+		current->thread.singlestep_syscall = 0;
 		current->ptrace &= ~PT_DTRACE;
 		force_sig(SIGTRAP, current);
 	}


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
