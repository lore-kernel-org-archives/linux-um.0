Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <martin.partel@gmail.com>) id 1ScjoL-0000XM-4L
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2012 21:00:05 +0000
Received: from mail-lpp01m010-f47.google.com ([209.85.215.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ScjoK-0008Ty-3W
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2012 21:00:05 +0000
Received: by lags15 with SMTP id s15so884006lag.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 07 Jun 2012 13:59:57 -0700 (PDT)
Message-ID: <4FD1164B.6060307@gmail.com>
Date: Thu, 07 Jun 2012 23:59:55 +0300
From: =?ISO-8859-1?Q?Martin_P=E4rtel?= <martin.partel@gmail.com>
MIME-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH] um: pass siginfo to guest process
To: user-mode-linux-devel@lists.sourceforge.net

Signal handlers in UML guest processes now get correct siginfo_t fields
for SIGTRAP, SIGFPE, SIGILL and SIGBUS. Specifically, si_addr and si_code
are now correct where previously they were si_addr =3D NULL and si_code =3D=
 128.

Signed-off-by: Martin P=E4rtel <martin.partel@gmail.com>
---
diff -uprN -X linux-3.4.1/Documentation/dontdiff -x config.c -x config.tmp =
linux-3.4.1/arch/um/include/shared/as-layout.h linux-3.4.1-mod/arch/um/incl=
ude/shared/as-layout.h
--- linux-3.4.1/arch/um/include/shared/as-layout.h	2012-06-01 10:18:44.0000=
00000 +0300
+++ linux-3.4.1-mod/arch/um/include/shared/as-layout.h	2012-06-07 18:48:21.=
469563959 +0300
@@ -60,7 +60,8 @@ extern unsigned long host_task_size;
 =

 extern int linux_main(int argc, char **argv);
 =

-extern void (*sig_info[])(int, struct uml_pt_regs *);
+struct siginfo;
+extern void (*sig_info[])(int, struct siginfo *si, struct uml_pt_regs *);
 =

 #endif
 =

diff -uprN -X linux-3.4.1/Documentation/dontdiff -x config.c -x config.tmp =
linux-3.4.1/arch/um/include/shared/kern_util.h linux-3.4.1-mod/arch/um/incl=
ude/shared/kern_util.h
--- linux-3.4.1/arch/um/include/shared/kern_util.h	2012-06-01 10:18:44.0000=
00000 +0300
+++ linux-3.4.1-mod/arch/um/include/shared/kern_util.h	2012-06-07 22:55:35.=
737822291 +0300
@@ -9,6 +9,8 @@
 #include "sysdep/ptrace.h"
 #include "sysdep/faultinfo.h"
 =

+struct siginfo;
+
 extern int uml_exitcode;
 =

 extern int ncpus;
@@ -22,7 +24,7 @@ extern void free_stack(unsigned long sta
 =

 extern int do_signal(void);
 extern void interrupt_end(void);
-extern void relay_signal(int sig, struct uml_pt_regs *regs);
+extern void relay_signal(int sig, struct siginfo *si, struct uml_pt_regs *=
regs);
 =

 extern unsigned long segv(struct faultinfo fi, unsigned long ip,
 			  int is_user, struct uml_pt_regs *regs);
@@ -33,7 +35,6 @@ extern unsigned int do_IRQ(int irq, stru
 extern int smp_sigio_handler(void);
 extern void initial_thread_cb(void (*proc)(void *), void *arg);
 extern int is_syscall(unsigned long addr);
-extern void timer_handler(int sig, struct uml_pt_regs *regs);
 =

 extern void timer_handler(int sig, struct uml_pt_regs *regs);
 =

@@ -60,7 +61,7 @@ extern void syscall_trace(struct uml_pt_
 extern int singlestepping(void *t);
 =

 extern void segv_handler(int sig, struct uml_pt_regs *regs);
-extern void bus_handler(int sig, struct uml_pt_regs *regs);
+extern void bus_handler(int sig, struct siginfo *si, struct uml_pt_regs *r=
egs);
 extern void winch(int sig, struct uml_pt_regs *regs);
 extern void fatal_sigsegv(void) __attribute__ ((noreturn));
 =

diff -uprN -X linux-3.4.1/Documentation/dontdiff -x config.c -x config.tmp =
linux-3.4.1/arch/um/kernel/trap.c linux-3.4.1-mod/arch/um/kernel/trap.c
--- linux-3.4.1/arch/um/kernel/trap.c	2012-06-01 10:18:44.000000000 +0300
+++ linux-3.4.1-mod/arch/um/kernel/trap.c	2012-06-07 23:30:11.905858447 +03=
00
@@ -244,7 +244,7 @@ unsigned long segv(struct faultinfo fi,
 	return 0;
 }
 =

-void relay_signal(int sig, struct uml_pt_regs *regs)
+void relay_signal(int sig, struct siginfo *si, struct uml_pt_regs *regs)
 {
 	if (!UPT_IS_USER(regs)) {
 		if (sig =3D=3D SIGBUS)
@@ -256,14 +256,15 @@ void relay_signal(int sig, struct uml_pt
 	arch_examine_signal(sig, regs);
 =

 	current->thread.arch.faultinfo =3D *UPT_FAULTINFO(regs);
-	force_sig(sig, current);
+	force_sig_info(sig, si, current);
 }
 =

-void bus_handler(int sig, struct uml_pt_regs *regs)
+void bus_handler(int sig, struct siginfo *si, struct uml_pt_regs *regs)
 {
 	if (current->thread.fault_catcher !=3D NULL)
 		UML_LONGJMP(current->thread.fault_catcher, 1);
-	else relay_signal(sig, regs);
+	else
+		relay_signal(sig, si, regs);
 }
 =

 void winch(int sig, struct uml_pt_regs *regs)
diff -uprN -X linux-3.4.1/Documentation/dontdiff -x config.c -x config.tmp =
linux-3.4.1/arch/um/os-Linux/signal.c linux-3.4.1-mod/arch/um/os-Linux/sign=
al.c
--- linux-3.4.1/arch/um/os-Linux/signal.c	2012-06-01 10:18:44.000000000 +03=
00
+++ linux-3.4.1-mod/arch/um/os-Linux/signal.c	2012-06-07 23:32:13.693860567=
 +0300
@@ -13,18 +13,55 @@
 #include "kern_util.h"
 #include "os.h"
 #include "sysdep/mcontext.h"
+#include "internal.h"
 =

-void (*sig_info[NSIG])(int, struct uml_pt_regs *) =3D {
+static void winch_ignore_siginfo(int sig,
+				 siginfo_t *si,
+				 struct uml_pt_regs *regs)
+{
+	winch(sig, regs);
+}
+
+static void segv_handler_ignore_siginfo(int sig,
+					siginfo_t *si,
+					struct uml_pt_regs *regs)
+{
+	segv_handler(sig, regs);
+}
+
+static void sigio_handler_ignore_siginfo(int sig,
+					 siginfo_t *si,
+					 struct uml_pt_regs *regs)
+{
+	sigio_handler(sig, regs);
+}
+
+static void timer_handler_ignore_siginfo(int sig,
+					 siginfo_t *si,
+					 struct uml_pt_regs *regs)
+{
+	timer_handler(sig, regs);
+}
+
+static void alarm_handler_ignore_siginfo(int sig,
+					 siginfo_t *si,
+					 mcontext_t *mc)
+{
+	alarm_handler(sig, mc);
+}
+
+
+void (*sig_info[NSIG])(int, siginfo_t *, struct uml_pt_regs *) =3D {
 	[SIGTRAP]	=3D relay_signal,
 	[SIGFPE]	=3D relay_signal,
 	[SIGILL]	=3D relay_signal,
-	[SIGWINCH]	=3D winch,
+	[SIGWINCH]	=3D winch_ignore_siginfo,
 	[SIGBUS]	=3D bus_handler,
-	[SIGSEGV]	=3D segv_handler,
-	[SIGIO]		=3D sigio_handler,
-	[SIGVTALRM]	=3D timer_handler };
+	[SIGSEGV]	=3D segv_handler_ignore_siginfo,
+	[SIGIO]		=3D sigio_handler_ignore_siginfo,
+	[SIGVTALRM]	=3D timer_handler_ignore_siginfo };
 =

-static void sig_handler_common(int sig, mcontext_t *mc)
+static void sig_handler_common(int sig, siginfo_t *si, mcontext_t *mc)
 {
 	struct uml_pt_regs r;
 	int save_errno =3D errno;
@@ -40,7 +77,7 @@ static void sig_handler_common(int sig,
 	if ((sig !=3D SIGIO) && (sig !=3D SIGWINCH) && (sig !=3D SIGVTALRM))
 		unblock_signals();
 =

-	(*sig_info[sig])(sig, &r);
+	(*sig_info[sig])(sig, si, &r);
 =

 	errno =3D save_errno;
 }
@@ -60,7 +97,7 @@ static void sig_handler_common(int sig,
 static int signals_enabled;
 static unsigned int signals_pending;
 =

-void sig_handler(int sig, mcontext_t *mc)
+void sig_handler(int sig, siginfo_t *si, mcontext_t *mc)
 {
 	int enabled;
 =

@@ -72,7 +109,7 @@ void sig_handler(int sig, mcontext_t *mc
 =

 	block_signals();
 =

-	sig_handler_common(sig, mc);
+	sig_handler_common(sig, si, mc);
 =

 	set_signals(enabled);
 }
@@ -119,7 +156,7 @@ void set_sigstack(void *sig_stack, int s
 		panic("enabling signal stack failed, errno =3D %d\n", errno);
 }
 =

-static void (*handlers[_NSIG])(int sig, mcontext_t *mc) =3D {
+static void (*handlers[_NSIG])(int sig, siginfo_t *si, mcontext_t *mc) =3D=
 {
 	[SIGSEGV] =3D sig_handler,
 	[SIGBUS] =3D sig_handler,
 	[SIGILL] =3D sig_handler,
@@ -128,11 +165,11 @@ static void (*handlers[_NSIG])(int sig,
 =

 	[SIGIO] =3D sig_handler,
 	[SIGWINCH] =3D sig_handler,
-	[SIGVTALRM] =3D alarm_handler
+	[SIGVTALRM] =3D alarm_handler_ignore_siginfo
 };
 =

 =

-static void hard_handler(int sig, siginfo_t *info, void *p)
+static void hard_handler(int sig, siginfo_t *si, void *p)
 {
 	struct ucontext *uc =3D p;
 	mcontext_t *mc =3D &uc->uc_mcontext;
@@ -161,7 +198,7 @@ static void hard_handler(int sig, siginf
 		while ((sig =3D ffs(pending)) !=3D 0){
 			sig--;
 			pending &=3D ~(1 << sig);
-			(*handlers[sig])(sig, mc);
+			(*handlers[sig])(sig, si, mc);
 		}
 =

 		/*
@@ -273,9 +310,12 @@ void unblock_signals(void)
 		 * Deal with SIGIO first because the alarm handler might
 		 * schedule, leaving the pending SIGIO stranded until we come
 		 * back here.
+		 *
+		 * SIGIO's handler doesn't use siginfo or mcontext,
+		 * so they can be NULL.
 		 */
 		if (save_pending & SIGIO_MASK)
-			sig_handler_common(SIGIO, NULL);
+			sig_handler_common(SIGIO, NULL, NULL);
 =

 		if (save_pending & SIGVTALRM_MASK)
 			real_alarm_handler(NULL);
diff -uprN -X linux-3.4.1/Documentation/dontdiff -x config.c -x config.tmp =
linux-3.4.1/arch/um/os-Linux/skas/process.c linux-3.4.1-mod/arch/um/os-Linu=
x/skas/process.c
--- linux-3.4.1/arch/um/os-Linux/skas/process.c	2012-06-01 10:18:44.0000000=
00 +0300
+++ linux-3.4.1-mod/arch/um/os-Linux/skas/process.c	2012-06-07 23:31:12.681=
859505 +0300
@@ -346,6 +346,7 @@ void userspace(struct uml_pt_regs *regs)
 	int err, status, op, pid =3D userspace_pid[0];
 	/* To prevent races if using_sysemu changes under us.*/
 	int local_using_sysemu;
+	siginfo_t si;
 =

 	if (getitimer(ITIMER_VIRTUAL, &timer))
 		printk(UM_KERN_ERR "Failed to get itimer, errno =3D %d\n", errno);
@@ -404,13 +405,17 @@ void userspace(struct uml_pt_regs *regs)
 =

 		if (WIFSTOPPED(status)) {
 			int sig =3D WSTOPSIG(status);
+
+			ptrace(PTRACE_GETSIGINFO, pid, 0, &si);
+
 			switch (sig) {
 			case SIGSEGV:
 				if (PTRACE_FULL_FAULTINFO ||
 				    !ptrace_faultinfo) {
 					get_skas_faultinfo(pid,
 							   &regs->faultinfo);
-					(*sig_info[SIGSEGV])(SIGSEGV, regs);
+					(*sig_info[SIGSEGV])(SIGSEGV, &si,
+							     regs);
 				}
 				else handle_segv(pid, regs);
 				break;
@@ -418,14 +423,14 @@ void userspace(struct uml_pt_regs *regs)
 			        handle_trap(pid, regs, local_using_sysemu);
 				break;
 			case SIGTRAP:
-				relay_signal(SIGTRAP, regs);
+				relay_signal(SIGTRAP, &si, regs);
 				break;
 			case SIGVTALRM:
 				now =3D os_nsecs();
 				if (now < nsecs)
 					break;
 				block_signals();
-				(*sig_info[sig])(sig, regs);
+				(*sig_info[sig])(sig, &si, regs);
 				unblock_signals();
 				nsecs =3D timer.it_value.tv_sec *
 					UM_NSEC_PER_SEC +
@@ -439,7 +444,7 @@ void userspace(struct uml_pt_regs *regs)
 			case SIGFPE:
 			case SIGWINCH:
 				block_signals();
-				(*sig_info[sig])(sig, regs);
+				(*sig_info[sig])(sig, &si, regs);
 				unblock_signals();
 				break;
 			default:


---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

