Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <martin.partel@gmail.com>) id 1SwBCX-0002WO-34
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 31 Jul 2012 12:05:25 +0000
Received: from mail-lb0-f175.google.com ([209.85.217.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SwBCR-0008Nm-Dk
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 31 Jul 2012 12:05:25 +0000
Received: by lbol5 with SMTP id l5so4084259lbo.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 31 Jul 2012 05:05:12 -0700 (PDT)
Message-ID: <5017C9F5.5070105@gmail.com>
Date: Tue, 31 Jul 2012 15:05:09 +0300
From: =?ISO-8859-1?Q?Martin_P=E4rtel?= <martin.partel@gmail.com>
MIME-Version: 1.0
References: <4FDB6EDD.1010102@gmail.com>
	<CAFLxGvxtN8wdP7g1jowqpAFbewATmTo8ZOWgPkZ6CrFYVQvXtQ@mail.gmail.com>
	<4FE2D6CD.3030601@gmail.com>
In-Reply-To: <4FE2D6CD.3030601@gmail.com>
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
Subject: Re: [uml-devel] [PATCH v3] um: pass siginfo to guest process
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

What's the status with this?


On 06/21/2012 11:09 AM, Martin P=E4rtel wrote:
> UML guest processes now get correct siginfo_t for SIGTRAP, SIGFPE,
> SIGILL and SIGBUS. Specifically, si_addr and si_code are now correct
> where previously they were si_addr =3D NULL and si_code =3D 128.
>
> Signed-off-by: Martin P=E4rtel <martin.partel@gmail.com>
> ---
> Removed _ignore_siginfo wrappers as requested.
>
> diff -uprN -X linux-3.4.1/Documentation/dontdiff -x config.c -x config.tm=
p linux-3.4.1/arch/um/include/shared/as-layout.h linux-3.4.1-mod/arch/um/in=
clude/shared/as-layout.h
> --- linux-3.4.1/arch/um/include/shared/as-layout.h	2012-06-01 10:18:44.00=
0000000 +0300
> +++ linux-3.4.1-mod/arch/um/include/shared/as-layout.h	2012-06-15 13:55:3=
2.817111341 +0300
> @@ -60,7 +60,8 @@ extern unsigned long host_task_size;
>
>   extern int linux_main(int argc, char **argv);
>
> -extern void (*sig_info[])(int, struct uml_pt_regs *);
> +struct siginfo;
> +extern void (*sig_info[])(int, struct siginfo *si, struct uml_pt_regs *);
>
>   #endif
>
> diff -uprN -X linux-3.4.1/Documentation/dontdiff -x config.c -x config.tm=
p linux-3.4.1/arch/um/include/shared/irq_user.h linux-3.4.1-mod/arch/um/inc=
lude/shared/irq_user.h
> --- linux-3.4.1/arch/um/include/shared/irq_user.h	2012-06-01 10:18:44.000=
000000 +0300
> +++ linux-3.4.1-mod/arch/um/include/shared/irq_user.h	2012-06-21 10:40:17=
.579071501 +0300
> @@ -20,7 +20,8 @@ struct irq_fd {
>
>   enum { IRQ_READ, IRQ_WRITE };
>
> -extern void sigio_handler(int sig, struct uml_pt_regs *regs);
> +struct siginfo;
> +extern void sigio_handler(int sig, struct siginfo *unused_si, struct uml=
_pt_regs *regs);
>   extern void free_irq_by_fd(int fd);
>   extern void reactivate_fd(int fd, int irqnum);
>   extern void deactivate_fd(int fd, int irqnum);
> diff -uprN -X linux-3.4.1/Documentation/dontdiff -x config.c -x config.tm=
p linux-3.4.1/arch/um/include/shared/kern_util.h linux-3.4.1-mod/arch/um/in=
clude/shared/kern_util.h
> --- linux-3.4.1/arch/um/include/shared/kern_util.h	2012-06-01 10:18:44.00=
0000000 +0300
> +++ linux-3.4.1-mod/arch/um/include/shared/kern_util.h	2012-06-21 10:31:2=
3.204318601 +0300
> @@ -9,6 +9,8 @@
>   #include "sysdep/ptrace.h"
>   #include "sysdep/faultinfo.h"
>
> +struct siginfo;
> +
>   extern int uml_exitcode;
>
>   extern int ncpus;
> @@ -22,7 +24,7 @@ extern void free_stack(unsigned long sta
>
>   extern int do_signal(void);
>   extern void interrupt_end(void);
> -extern void relay_signal(int sig, struct uml_pt_regs *regs);
> +extern void relay_signal(int sig, struct siginfo *si, struct uml_pt_regs=
 *regs);
>
>   extern unsigned long segv(struct faultinfo fi, unsigned long ip,
>   			  int is_user, struct uml_pt_regs *regs);
> @@ -33,9 +35,8 @@ extern unsigned int do_IRQ(int irq, stru
>   extern int smp_sigio_handler(void);
>   extern void initial_thread_cb(void (*proc)(void *), void *arg);
>   extern int is_syscall(unsigned long addr);
> -extern void timer_handler(int sig, struct uml_pt_regs *regs);
>
> -extern void timer_handler(int sig, struct uml_pt_regs *regs);
> +extern void timer_handler(int sig, struct siginfo *unused_si, struct uml=
_pt_regs *regs);
>
>   extern int start_uml(void);
>   extern void paging_init(void);
> @@ -59,9 +60,9 @@ extern unsigned long from_irq_stack(int
>   extern void syscall_trace(struct uml_pt_regs *regs, int entryexit);
>   extern int singlestepping(void *t);
>
> -extern void segv_handler(int sig, struct uml_pt_regs *regs);
> -extern void bus_handler(int sig, struct uml_pt_regs *regs);
> -extern void winch(int sig, struct uml_pt_regs *regs);
> +extern void segv_handler(int sig, struct siginfo *unused_si, struct uml_=
pt_regs *regs);
> +extern void bus_handler(int sig, struct siginfo *si, struct uml_pt_regs =
*regs);
> +extern void winch(int sig, struct siginfo *unused_si, struct uml_pt_regs=
 *regs);
>   extern void fatal_sigsegv(void) __attribute__ ((noreturn));
>
>
> diff -uprN -X linux-3.4.1/Documentation/dontdiff -x config.c -x config.tm=
p linux-3.4.1/arch/um/kernel/irq.c linux-3.4.1-mod/arch/um/kernel/irq.c
> --- linux-3.4.1/arch/um/kernel/irq.c	2012-06-01 10:18:44.000000000 +0300
> +++ linux-3.4.1-mod/arch/um/kernel/irq.c	2012-06-21 10:30:42.036317885 +0=
300
> @@ -30,7 +30,7 @@ static struct irq_fd **last_irq_ptr =3D &a
>
>   extern void free_irqs(void);
>
> -void sigio_handler(int sig, struct uml_pt_regs *regs)
> +void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_reg=
s *regs)
>   {
>   	struct irq_fd *irq_fd;
>   	int n;
> diff -uprN -X linux-3.4.1/Documentation/dontdiff -x config.c -x config.tm=
p linux-3.4.1/arch/um/kernel/time.c linux-3.4.1-mod/arch/um/kernel/time.c
> --- linux-3.4.1/arch/um/kernel/time.c	2012-06-01 10:18:44.000000000 +0300
> +++ linux-3.4.1-mod/arch/um/kernel/time.c	2012-06-21 10:31:15.852318471 +=
0300
> @@ -13,7 +13,7 @@
>   #include "kern_util.h"
>   #include "os.h"
>
> -void timer_handler(int sig, struct uml_pt_regs *regs)
> +void timer_handler(int sig, struct siginfo *unused_si, struct uml_pt_reg=
s *regs)
>   {
>   	unsigned long flags;
>
> diff -uprN -X linux-3.4.1/Documentation/dontdiff -x config.c -x config.tm=
p linux-3.4.1/arch/um/kernel/trap.c linux-3.4.1-mod/arch/um/kernel/trap.c
> --- linux-3.4.1/arch/um/kernel/trap.c	2012-06-01 10:18:44.000000000 +0300
> +++ linux-3.4.1-mod/arch/um/kernel/trap.c	2012-06-21 10:30:13.880317394 +=
0300
> @@ -158,7 +158,7 @@ void fatal_sigsegv(void)
>   	os_dump_core();
>   }
>
> -void segv_handler(int sig, struct uml_pt_regs *regs)
> +void segv_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs=
 *regs)
>   {
>   	struct faultinfo * fi =3D UPT_FAULTINFO(regs);
>
> @@ -244,8 +244,11 @@ unsigned long segv(struct faultinfo fi,
>   	return 0;
>   }
>
> -void relay_signal(int sig, struct uml_pt_regs *regs)
> +void relay_signal(int sig, struct siginfo *si, struct uml_pt_regs *regs)
>   {
> +	struct faultinfo *fi;
> +	struct siginfo clean_si;
> +
>   	if (!UPT_IS_USER(regs)) {
>   		if (sig =3D=3D SIGBUS)
>   			printk(KERN_ERR "Bus error - the host /dev/shm or /tmp "
> @@ -255,18 +258,40 @@ void relay_signal(int sig, struct uml_pt
>
>   	arch_examine_signal(sig, regs);
>
> -	current->thread.arch.faultinfo =3D *UPT_FAULTINFO(regs);
> -	force_sig(sig, current);
> +	memset(&clean_si, 0, sizeof(clean_si));
> +	clean_si.si_signo =3D si->si_signo;
> +	clean_si.si_errno =3D si->si_errno;
> +	clean_si.si_code =3D si->si_code;
> +	switch (sig) {
> +	case SIGILL:
> +	case SIGFPE:
> +	case SIGSEGV:
> +	case SIGBUS:
> +	case SIGTRAP:
> +		fi =3D UPT_FAULTINFO(regs);
> +		clean_si.si_addr =3D (void __user *) FAULT_ADDRESS(*fi);
> +		current->thread.arch.faultinfo =3D *fi;
> +#ifdef __ARCH_SI_TRAPNO
> +		clean_si.si_trapno =3D si->si_trapno;
> +#endif
> +		break;
> +	default:
> +		printk(KERN_ERR "Attempted to relay unknown signal %d (si_code =3D %d)=
\n",
> +			sig, si->si_code);
> +	}
> +
> +	force_sig_info(sig, &clean_si, current);
>   }
>
> -void bus_handler(int sig, struct uml_pt_regs *regs)
> +void bus_handler(int sig, struct siginfo *si, struct uml_pt_regs *regs)
>   {
>   	if (current->thread.fault_catcher !=3D NULL)
>   		UML_LONGJMP(current->thread.fault_catcher, 1);
> -	else relay_signal(sig, regs);
> +	else
> +		relay_signal(sig, si, regs);
>   }
>
> -void winch(int sig, struct uml_pt_regs *regs)
> +void winch(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
>   {
>   	do_IRQ(WINCH_IRQ, regs);
>   }
> diff -uprN -X linux-3.4.1/Documentation/dontdiff -x config.c -x config.tm=
p linux-3.4.1/arch/um/os-Linux/internal.h linux-3.4.1-mod/arch/um/os-Linux/=
internal.h
> --- linux-3.4.1/arch/um/os-Linux/internal.h	2012-06-01 10:18:44.000000000=
 +0300
> +++ linux-3.4.1-mod/arch/um/os-Linux/internal.h	2012-06-21 10:32:11.95631=
9450 +0300
> @@ -1 +1 @@
> -void alarm_handler(int, mcontext_t *);
> +void alarm_handler(int sig, struct siginfo *unused_si, mcontext_t *mc);
> diff -uprN -X linux-3.4.1/Documentation/dontdiff -x config.c -x config.tm=
p linux-3.4.1/arch/um/os-Linux/signal.c linux-3.4.1-mod/arch/um/os-Linux/si=
gnal.c
> --- linux-3.4.1/arch/um/os-Linux/signal.c	2012-06-01 10:18:44.000000000 +=
0300
> +++ linux-3.4.1-mod/arch/um/os-Linux/signal.c	2012-06-21 10:34:42.6683220=
74 +0300
> @@ -13,8 +13,9 @@
>   #include "kern_util.h"
>   #include "os.h"
>   #include "sysdep/mcontext.h"
> +#include "internal.h"
>
> -void (*sig_info[NSIG])(int, struct uml_pt_regs *) =3D {
> +void (*sig_info[NSIG])(int, siginfo_t *, struct uml_pt_regs *) =3D {
>   	[SIGTRAP]	=3D relay_signal,
>   	[SIGFPE]	=3D relay_signal,
>   	[SIGILL]	=3D relay_signal,
> @@ -24,7 +25,7 @@ void (*sig_info[NSIG])(int, struct uml_p
>   	[SIGIO]		=3D sigio_handler,
>   	[SIGVTALRM]	=3D timer_handler };
>
> -static void sig_handler_common(int sig, mcontext_t *mc)
> +static void sig_handler_common(int sig, siginfo_t *si, mcontext_t *mc)
>   {
>   	struct uml_pt_regs r;
>   	int save_errno =3D errno;
> @@ -40,7 +41,7 @@ static void sig_handler_common(int sig,
>   	if ((sig !=3D SIGIO) && (sig !=3D SIGWINCH) && (sig !=3D SIGVTALRM))
>   		unblock_signals();
>
> -	(*sig_info[sig])(sig, &r);
> +	(*sig_info[sig])(sig, si, &r);
>
>   	errno =3D save_errno;
>   }
> @@ -60,7 +61,7 @@ static void sig_handler_common(int sig,
>   static int signals_enabled;
>   static unsigned int signals_pending;
>
> -void sig_handler(int sig, mcontext_t *mc)
> +void sig_handler(int sig, siginfo_t *si, mcontext_t *mc)
>   {
>   	int enabled;
>
> @@ -72,7 +73,7 @@ void sig_handler(int sig, mcontext_t *mc
>
>   	block_signals();
>
> -	sig_handler_common(sig, mc);
> +	sig_handler_common(sig, si, mc);
>
>   	set_signals(enabled);
>   }
> @@ -85,10 +86,10 @@ static void real_alarm_handler(mcontext_
>   		get_regs_from_mc(&regs, mc);
>   	regs.is_user =3D 0;
>   	unblock_signals();
> -	timer_handler(SIGVTALRM, &regs);
> +	timer_handler(SIGVTALRM, NULL, &regs);
>   }
>
> -void alarm_handler(int sig, mcontext_t *mc)
> +void alarm_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
>   {
>   	int enabled;
>
> @@ -119,7 +120,7 @@ void set_sigstack(void *sig_stack, int s
>   		panic("enabling signal stack failed, errno =3D %d\n", errno);
>   }
>
> -static void (*handlers[_NSIG])(int sig, mcontext_t *mc) =3D {
> +static void (*handlers[_NSIG])(int sig, siginfo_t *si, mcontext_t *mc) =
=3D {
>   	[SIGSEGV] =3D sig_handler,
>   	[SIGBUS] =3D sig_handler,
>   	[SIGILL] =3D sig_handler,
> @@ -132,7 +133,7 @@ static void (*handlers[_NSIG])(int sig,
>   };
>
>
> -static void hard_handler(int sig, siginfo_t *info, void *p)
> +static void hard_handler(int sig, siginfo_t *si, void *p)
>   {
>   	struct ucontext *uc =3D p;
>   	mcontext_t *mc =3D &uc->uc_mcontext;
> @@ -161,7 +162,7 @@ static void hard_handler(int sig, siginf
>   		while ((sig =3D ffs(pending)) !=3D 0){
>   			sig--;
>   			pending &=3D ~(1 << sig);
> -			(*handlers[sig])(sig, mc);
> +			(*handlers[sig])(sig, si, mc);
>   		}
>
>   		/*
> @@ -273,9 +274,12 @@ void unblock_signals(void)
>   		 * Deal with SIGIO first because the alarm handler might
>   		 * schedule, leaving the pending SIGIO stranded until we come
>   		 * back here.
> +		 *
> +		 * SIGIO's handler doesn't use siginfo or mcontext,
> +		 * so they can be NULL.
>   		 */
>   		if (save_pending & SIGIO_MASK)
> -			sig_handler_common(SIGIO, NULL);
> +			sig_handler_common(SIGIO, NULL, NULL);
>
>   		if (save_pending & SIGVTALRM_MASK)
>   			real_alarm_handler(NULL);
> diff -uprN -X linux-3.4.1/Documentation/dontdiff -x config.c -x config.tm=
p linux-3.4.1/arch/um/os-Linux/skas/process.c linux-3.4.1-mod/arch/um/os-Li=
nux/skas/process.c
> --- linux-3.4.1/arch/um/os-Linux/skas/process.c	2012-06-01 10:18:44.00000=
0000 +0300
> +++ linux-3.4.1-mod/arch/um/os-Linux/skas/process.c	2012-06-15 13:56:58.2=
61111142 +0300
> @@ -346,6 +346,7 @@ void userspace(struct uml_pt_regs *regs)
>   	int err, status, op, pid =3D userspace_pid[0];
>   	/* To prevent races if using_sysemu changes under us.*/
>   	int local_using_sysemu;
> +	siginfo_t si;
>
>   	if (getitimer(ITIMER_VIRTUAL, &timer))
>   		printk(UM_KERN_ERR "Failed to get itimer, errno =3D %d\n", errno);
> @@ -404,13 +405,17 @@ void userspace(struct uml_pt_regs *regs)
>
>   		if (WIFSTOPPED(status)) {
>   			int sig =3D WSTOPSIG(status);
> +
> +			ptrace(PTRACE_GETSIGINFO, pid, 0, &si);
> +
>   			switch (sig) {
>   			case SIGSEGV:
>   				if (PTRACE_FULL_FAULTINFO ||
>   				    !ptrace_faultinfo) {
>   					get_skas_faultinfo(pid,
>   							   &regs->faultinfo);
> -					(*sig_info[SIGSEGV])(SIGSEGV, regs);
> +					(*sig_info[SIGSEGV])(SIGSEGV, &si,
> +							     regs);
>   				}
>   				else handle_segv(pid, regs);
>   				break;
> @@ -418,14 +423,14 @@ void userspace(struct uml_pt_regs *regs)
>   			        handle_trap(pid, regs, local_using_sysemu);
>   				break;
>   			case SIGTRAP:
> -				relay_signal(SIGTRAP, regs);
> +				relay_signal(SIGTRAP, &si, regs);
>   				break;
>   			case SIGVTALRM:
>   				now =3D os_nsecs();
>   				if (now < nsecs)
>   					break;
>   				block_signals();
> -				(*sig_info[sig])(sig, regs);
> +				(*sig_info[sig])(sig, &si, regs);
>   				unblock_signals();
>   				nsecs =3D timer.it_value.tv_sec *
>   					UM_NSEC_PER_SEC +
> @@ -439,7 +444,7 @@ void userspace(struct uml_pt_regs *regs)
>   			case SIGFPE:
>   			case SIGWINCH:
>   				block_signals();
> -				(*sig_info[sig])(sig, regs);
> +				(*sig_info[sig])(sig, &si, regs);
>   				unblock_signals();
>   				break;
>   			default:
> diff -uprN -X linux-3.4.1/Documentation/dontdiff -x config.c -x config.tm=
p linux-3.4.1/arch/um/os-Linux/time.c linux-3.4.1-mod/arch/um/os-Linux/time=
.c
> --- linux-3.4.1/arch/um/os-Linux/time.c	2012-06-01 10:18:44.000000000 +03=
00
> +++ linux-3.4.1-mod/arch/um/os-Linux/time.c	2012-06-21 10:33:21.748320666=
 +0300
> @@ -87,7 +87,7 @@ static int after_sleep_interval(struct t
>
>   static void deliver_alarm(void)
>   {
> -	alarm_handler(SIGVTALRM, NULL);
> +	alarm_handler(SIGVTALRM, NULL, NULL);
>   }
>
>   static unsigned long long sleep_time(unsigned long long nsecs)
>


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

