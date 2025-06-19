Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35A6C7115B
	for <linux-um@archiver.kernel.org>; Thu, 19 Jun 2025 15:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xPiEC10vt+C3d4JrfwHhX5jQ1R9dywxnsGyCGhLFouo=; b=O3c18Z+jkiFr9AZktlSABQURob
	e6iBewK87WZtN1LMOS4YtIH/hb26+kpP0E+erZKJz7HphVYO3lYfmujEvvj7VehlO8/jGPphTVS2l
	B79GIrPlItyhwRX6TzKzWHLEHhSvS2wX/7f2BhQEZ+yQ59ZDu5FblhYthYesNIvT3BYQQKCLldtK1
	LWabrtbU/nn4u3ycGMCdIxGGxvR8MW/DQtn3nwNQpr0nQu8G2BVX8fi0DePzdQAdhiXkK/beNFscE
	PYhqTcBqHZ9SoBBZXY9M882wBtXDWACGHdkcV73VihPhtM1LJyVvuEDqn98PdjraxI6CsRHr0cqxt
	Vo3+DQOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSHSZ-0000000DTA1-00Z6;
	Thu, 19 Jun 2025 15:45:51 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSDfl-0000000Cvdx-0rTB
	for linux-um@lists.infradead.org;
	Thu, 19 Jun 2025 11:43:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=xPiEC10vt+C3d4JrfwHhX5jQ1R9dywxnsGyCGhLFouo=;
	t=1750333392; x=1751542992; b=mBDZzgfExZ25vuZw0zSMyTmZiM311Yd5pMu2Pxoq9uejWjp
	g/TWBuYPFEELN6JELWEgOlbSCVcDZFaMNS/qNsNbryJ0Y/wQwItbEVHZ/2VLdBRO5O5pm0STpwR5o
	SxPxDWbq/Mi6rPIIWick4rf6WkTxY7PXOnCqvmElje15CJaj73g53t+lYHWY/m6o+0EghljusGyJD
	G41fBDEZTUuq2JAVS30gk1jTw4Dg/39v/9jSQ5xU5rVgyLNXkT5KuTd9sh8alaN1DYAuF1lDoTmjU
	6q+7XRHzSA2hPZ4MHqtCOMHD2MJ0H/VVD10ORS1MV/qbTObRGMQH89HsIbtDL1Ww==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uSDfg-000000010Rp-3WFP;
	Thu, 19 Jun 2025 13:43:09 +0200
Message-ID: <a81b27bdf40fba54b28325bdb28f697c48a005d6.camel@sipsolutions.net>
Subject: Re: [PATCH v7 10/13] x86/um: nommu: signal handling
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org
Cc: ricarkol@google.com, Liam.Howlett@oracle.com
Date: Thu, 19 Jun 2025 13:43:06 +0200
In-Reply-To: <7714247990d673226ce0f42ca838d8ec338cf882.1737348400.git.thehajime@gmail.com>
References: <cover.1737348399.git.thehajime@gmail.com>
	 <7714247990d673226ce0f42ca838d8ec338cf882.1737348400.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250619_044313_629238_9DEB878B 
X-CRM114-Status: GOOD (  37.88  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Hi,

I am not sure that fxsaveq/fxrstorq is guaranteed to be sufficient. I
don't think that catches some of the newer AVX registers for example.

At the same time, dealing with all that properly could be rather
annoying. I don't really have a solution for that, normal UM does not
need to deal with many of those details =E2=80=A6

Benjamin=20

On Mon, 2025-01-20 at 15:00 +0900, Hajime Tazaki wrote:
> This commit updates the behavior of signal handling under !MMU
> environment. It adds the alignment code for signal frame as the frame
> is used in userspace as-is.
>=20
> floating point register is carefully handling upon entry/leave of
> syscall routine so that signal handlers can read/write the contents of
> the register.
>=20
> It also adds the follow up routine for SIGSEGV as a signal delivery runs
> in the same stack frame while we have to avoid endless SIGSEGV.
>=20
> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> ---
> =C2=A0arch/um/include/shared/kern_util.h=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
4 +
> =C2=A0arch/um/nommu/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0arch/um/nommu/os-Linux/signal.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 13 ++
> =C2=A0arch/um/nommu/trap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 188 +++++++++++=
+++++++++++++++
> =C2=A0arch/um/os-Linux/signal.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 25 +++-
> =C2=A0arch/x86/um/nommu/do_syscall_64.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 6 +
> =C2=A0arch/x86/um/nommu/os-Linux/mcontext.c |=C2=A0 11 ++
> =C2=A0arch/x86/um/shared/sysdep/mcontext.h=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0arch/x86/um/shared/sysdep/ptrace.h=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
2 +-
> =C2=A09 files changed, 243 insertions(+), 9 deletions(-)
> =C2=A0create mode 100644 arch/um/nommu/trap.c
>=20
> diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/=
kern_util.h
> index 1dd3d02c4e39..3569ca1603a8 100644
> --- a/arch/um/include/shared/kern_util.h
> +++ b/arch/um/include/shared/kern_util.h
> @@ -71,8 +71,12 @@ void kasan_map_memory(void *start, size_t len);
> =C2=A0static inline void arch_sigsys_handler(int sig, struct siginfo *si,=
 void *mc)
> =C2=A0{
> =C2=A0}
> +static inline void arch_sigsegv_handler(int sig, struct siginfo *unused_=
si, void *mc)
> +{
> +}
> =C2=A0#else
> =C2=A0extern void arch_sigsys_handler(int sig, struct siginfo *si, void *=
mc);
> +extern void arch_sigsegv_handler(int sig, struct siginfo *si, void *mc);
> =C2=A0#endif
> =C2=A0
> =C2=A0#endif
> diff --git a/arch/um/nommu/Makefile b/arch/um/nommu/Makefile
> index baab7c2f57c2..096221590cfd 100644
> --- a/arch/um/nommu/Makefile
> +++ b/arch/um/nommu/Makefile
> @@ -1,3 +1,3 @@
> =C2=A0# SPDX-License-Identifier: GPL-2.0
> =C2=A0
> -obj-y :=3D os-Linux/
> +obj-y :=3D trap.o os-Linux/
> diff --git a/arch/um/nommu/os-Linux/signal.c b/arch/um/nommu/os-Linux/sig=
nal.c
> index 1674962e509d..b9e3070f2c36 100644
> --- a/arch/um/nommu/os-Linux/signal.c
> +++ b/arch/um/nommu/os-Linux/signal.c
> @@ -5,6 +5,7 @@
> =C2=A0#include <os.h>
> =C2=A0#include <sysdep/mcontext.h>
> =C2=A0#include <sys/ucontext.h>
> +#include <as-layout.h>
> =C2=A0
> =C2=A0void arch_sigsys_handler(int sig, struct siginfo *si, void *ptr)
> =C2=A0{
> @@ -13,3 +14,15 @@ void arch_sigsys_handler(int sig, struct siginfo *si, =
void *ptr)
> =C2=A0	/* hook syscall via SIGSYS */
> =C2=A0	set_mc_sigsys_hook(mc);
> =C2=A0}
> +
> +void arch_sigsegv_handler(int sig, struct siginfo *si, void *ptr)
> +{
> +	mcontext_t *mc =3D (mcontext_t *) ptr;
> +
> +	/* !MMU specific part; detection of userspace */
> +	if (mc->gregs[REG_RIP] > uml_reserved &&
> +	=C2=A0=C2=A0=C2=A0 mc->gregs[REG_RIP] < high_physmem) {
> +		/* !MMU: force handle signals after rt_sigreturn() */
> +		set_mc_userspace_relay_signal(mc);
> +	}
> +}
> diff --git a/arch/um/nommu/trap.c b/arch/um/nommu/trap.c
> new file mode 100644
> index 000000000000..cda71ecb1115
> --- /dev/null
> +++ b/arch/um/nommu/trap.c
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/mm.h>
> +#include <linux/sched/signal.h>
> +#include <linux/hardirq.h>
> +#include <linux/module.h>
> +#include <linux/uaccess.h>
> +#include <linux/sched/debug.h>
> +#include <asm/current.h>
> +#include <asm/tlbflush.h>
> +#include <arch.h>
> +#include <as-layout.h>
> +#include <kern_util.h>
> +#include <os.h>
> +#include <skas.h>
> +
> +/*
> + * Note this is constrained to return 0, -EFAULT, -EACCES, -ENOMEM by
> + * segv().
> + */
> +int handle_page_fault(unsigned long address, unsigned long ip,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int is_write, int is_user, int *code_ou=
t)
> +{
> +	/* !MMU has no pagefault */
> +	return -EFAULT;
> +}
> +
> +static void show_segv_info(struct uml_pt_regs *regs)
> +{
> +	struct task_struct *tsk =3D current;
> +	struct faultinfo *fi =3D UPT_FAULTINFO(regs);
> +
> +	if (!unhandled_signal(tsk, SIGSEGV))
> +		return;
> +
> +	pr_warn_ratelimited("%s%s[%d]: segfault at %lx ip %p sp %p error %x",
> +			=C2=A0=C2=A0=C2=A0 task_pid_nr(tsk) > 1 ? KERN_INFO : KERN_EMERG,
> +			=C2=A0=C2=A0=C2=A0 tsk->comm, task_pid_nr(tsk), FAULT_ADDRESS(*fi),
> +			=C2=A0=C2=A0=C2=A0 (void *)UPT_IP(regs), (void *)UPT_SP(regs),
> +			=C2=A0=C2=A0=C2=A0 fi->error_code);
> +}
> +
> +static void bad_segv(struct faultinfo fi, unsigned long ip)
> +{
> +	current->thread.arch.faultinfo =3D fi;
> +	force_sig_fault(SIGSEGV, SEGV_ACCERR, (void __user *) FAULT_ADDRESS(fi)=
);
> +}
> +
> +void fatal_sigsegv(void)
> +{
> +	force_fatal_sig(SIGSEGV);
> +	do_signal(&current->thread.regs);
> +	/*
> +	 * This is to tell gcc that we're not returning - do_signal
> +	 * can, in general, return, but in this case, it's not, since
> +	 * we just got a fatal SIGSEGV queued.
> +	 */
> +	os_dump_core();
> +}
> +
> +/**
> + * segv_handler() - the SIGSEGV handler
> + * @sig:	the signal number
> + * @unused_si:	the signal info struct; unused in this handler
> + * @regs:	the ptrace register information
> + *
> + * The handler first extracts the faultinfo from the UML ptrace regs str=
uct.
> + * If the userfault did not happen in an UML userspace process, bad_segv=
 is called.
> + * Otherwise the signal did happen in a cloned userspace process, handle=
 it.
> + */
> +void segv_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs=
 *regs)
> +{
> +	struct faultinfo *fi =3D UPT_FAULTINFO(regs);
> +
> +	/* !MMU specific part; detection of userspace */
> +	/* mark is_user=3D1 when the IP is from userspace code. */
> +	if (UPT_IP(regs) > uml_reserved && UPT_IP(regs) < high_physmem)
> +		regs->is_user =3D 1;
> +
> +	if (UPT_IS_USER(regs) && !SEGV_IS_FIXABLE(fi)) {
> +		show_segv_info(regs);
> +		bad_segv(*fi, UPT_IP(regs));
> +		return;
> +	}
> +	segv(*fi, UPT_IP(regs), UPT_IS_USER(regs), regs);
> +}
> +
> +/*
> + * We give a *copy* of the faultinfo in the regs to segv.
> + * This must be done, since nesting SEGVs could overwrite
> + * the info in the regs. A pointer to the info then would
> + * give us bad data!
> + */
> +unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
> +		=C2=A0=C2=A0 struct uml_pt_regs *regs)
> +{
> +	int si_code;
> +	int err;
> +	int is_write =3D FAULT_WRITE(fi);
> +	unsigned long address =3D FAULT_ADDRESS(fi);
> +
> +	if (!is_user && regs)
> +		current->thread.segv_regs =3D container_of(regs, struct pt_regs, regs)=
;
> +
> +	if (current->mm =3D=3D NULL) {
> +		show_regs(container_of(regs, struct pt_regs, regs));
> +		panic("Segfault with no mm");
> +	} else if (!is_user && address > PAGE_SIZE && address < TASK_SIZE) {
> +		show_regs(container_of(regs, struct pt_regs, regs));
> +		panic("Kernel tried to access user memory at addr 0x%lx, ip 0x%lx",
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 address, ip);
> +	}
> +
> +	if (SEGV_IS_FIXABLE(&fi))
> +		err =3D handle_page_fault(address, ip, is_write, is_user,
> +					&si_code);
> +	else {
> +		err =3D -EFAULT;
> +		/*
> +		 * A thread accessed NULL, we get a fault, but CR2 is invalid.
> +		 * This code is used in __do_copy_from_user() of TT mode.
> +		 * XXX tt mode is gone, so maybe this isn't needed any more
> +		 */
> +		address =3D 0;
> +	}
> +
> +	if (!err)
> +		goto out;
> +	else if (!is_user && arch_fixup(ip, regs))
> +		goto out;
> +
> +	if (!is_user) {
> +		show_regs(container_of(regs, struct pt_regs, regs));
> +		panic("Kernel mode fault at addr 0x%lx, ip 0x%lx",
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 address, ip);
> +	}
> +
> +	show_segv_info(regs);
> +
> +	if (err =3D=3D -EACCES) {
> +		current->thread.arch.faultinfo =3D fi;
> +		force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
> +	} else {
> +		WARN_ON_ONCE(err !=3D -EFAULT);
> +		current->thread.arch.faultinfo =3D fi;
> +		force_sig_fault(SIGSEGV, si_code, (void __user *) address);
> +	}
> +
> +out:
> +	if (regs)
> +		current->thread.segv_regs =3D NULL;
> +
> +	return 0;
> +}
> +
> +void relay_signal(int sig, struct siginfo *si, struct uml_pt_regs *regs)
> +{
> +	int code, err;
> +
> +	if (!UPT_IS_USER(regs)) {
> +		if (sig =3D=3D SIGBUS)
> +			pr_err("Bus error - the host /dev/shm or /tmp mount likely just ran o=
ut of space\n");
> +		panic("Kernel mode signal %d", sig);
> +	}
> +
> +	arch_examine_signal(sig, regs);
> +
> +	/* Is the signal layout for the signal known?
> +	 * Signal data must be scrubbed to prevent information leaks.
> +	 */
> +	code =3D si->si_code;
> +	err =3D si->si_errno;
> +	if ((err =3D=3D 0) && (siginfo_layout(sig, code) =3D=3D SIL_FAULT)) {
> +		struct faultinfo *fi =3D UPT_FAULTINFO(regs);
> +
> +		current->thread.arch.faultinfo =3D *fi;
> +		force_sig_fault(sig, code, (void __user *)FAULT_ADDRESS(*fi));
> +	} else {
> +		pr_err("Attempted to relay unknown signal %d (si_code =3D %d) with err=
no %d\n",
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sig, code, err);
> +		force_sig(sig);
> +	}
> +}
> +
> +void winch(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
> +{
> +	do_IRQ(WINCH_IRQ, regs);
> +}
> diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
> index 97efdabe1e45..3997d827bf4c 100644
> --- a/arch/um/os-Linux/signal.c
> +++ b/arch/um/os-Linux/signal.c
> @@ -37,12 +37,6 @@ static void sig_handler_common(int sig, struct siginfo=
 *si, mcontext_t *mc)
> =C2=A0	int save_errno =3D errno;
> =C2=A0
> =C2=A0	r.is_user =3D 0;
> -	if (sig =3D=3D SIGSEGV) {
> -		/* For segfaults, we want the data from the sigcontext. */
> -		get_regs_from_mc(&r, mc);
> -		GET_FAULTINFO_FROM_MC(r.faultinfo, mc);
> -	}
> -
> =C2=A0	/* enable signals if sig isn't IRQ signal */
> =C2=A0	if ((sig !=3D SIGIO) && (sig !=3D SIGWINCH))
> =C2=A0		unblock_signals_trace();
> @@ -177,8 +171,25 @@ static void sigsys_handler(int sig, struct siginfo *=
unused_si, mcontext_t *mc)
> =C2=A0	arch_sigsys_handler(sig, unused_si, mc);
> =C2=A0}
> =C2=A0
> +static void sigsegv_handler(int sig, struct siginfo *unused_si, mcontext=
_t *mc)
> +{
> +	struct uml_pt_regs r;
> +	int save_errno =3D errno;
> +
> +	r.is_user =3D 0;
> +
> +	/* For segfaults, we want the data from the sigcontext. */
> +	get_regs_from_mc(&r, mc);
> +	GET_FAULTINFO_FROM_MC(r.faultinfo, mc);
> +
> +	segv_handler(sig, unused_si, &r);
> +	arch_sigsegv_handler(sig, unused_si, mc);
> +
> +	errno =3D save_errno;
> +}
> +
> =C2=A0static void (*handlers[_NSIG])(int sig, struct siginfo *si, mcontex=
t_t *mc) =3D {
> -	[SIGSEGV] =3D sig_handler,
> +	[SIGSEGV] =3D sigsegv_handler,
> =C2=A0	[SIGBUS] =3D sig_handler,
> =C2=A0	[SIGILL] =3D sig_handler,
> =C2=A0	[SIGFPE] =3D sig_handler,
> diff --git a/arch/x86/um/nommu/do_syscall_64.c b/arch/x86/um/nommu/do_sys=
call_64.c
> index 796beb0089fc..48b3d29e2db1 100644
> --- a/arch/x86/um/nommu/do_syscall_64.c
> +++ b/arch/x86/um/nommu/do_syscall_64.c
> @@ -48,6 +48,9 @@ __visible void do_syscall_64(struct pt_regs *regs)
> =C2=A0	/* set fs register to the original host one */
> =C2=A0	os_x86_arch_prctl(0, ARCH_SET_FS, (void *)host_fs);
> =C2=A0
> +	/* save fp registers */
> +	asm volatile("fxsaveq %0" : "=3Dm"(*(struct _xstate *)regs->regs.fp));
> +
> =C2=A0	if (likely(syscall < NR_syscalls)) {
> =C2=A0		PT_REGS_SET_SYSCALL_RETURN(regs,
> =C2=A0				EXECUTE_SYSCALL(syscall, regs));
> @@ -66,6 +69,9 @@ __visible void do_syscall_64(struct pt_regs *regs)
> =C2=A0	set_thread_flag(TIF_SIGPENDING);
> =C2=A0	interrupt_end();
> =C2=A0
> +	/* restore fp registers */
> +	asm volatile("fxrstorq %0" : : "m"((current->thread.regs.regs.fp)));
> +
> =C2=A0	/* restore back fs register to userspace configured one */
> =C2=A0	os_x86_arch_prctl(0, ARCH_SET_FS,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (void *)(current->thread.regs.regs=
.gp[FS_BASE
> diff --git a/arch/x86/um/nommu/os-Linux/mcontext.c b/arch/x86/um/nommu/os=
-Linux/mcontext.c
> index c4ef877d5ea0..955e7d9f4765 100644
> --- a/arch/x86/um/nommu/os-Linux/mcontext.c
> +++ b/arch/x86/um/nommu/os-Linux/mcontext.c
> @@ -6,6 +6,17 @@
> =C2=A0#include <sysdep/mcontext.h>
> =C2=A0#include <sysdep/syscalls.h>
> =C2=A0
> +static void __userspace_relay_signal(void)
> +{
> +	/* XXX: dummy syscall */
> +	__asm__ volatile("call *%0" : : "r"(__kernel_vsyscall), "a"(39) :);
> +}
> +
> +void set_mc_userspace_relay_signal(mcontext_t *mc)
> +{
> +	mc->gregs[REG_RIP] =3D (unsigned long) __userspace_relay_signal;
> +}
> +
> =C2=A0void set_mc_sigsys_hook(mcontext_t *mc)
> =C2=A0{
> =C2=A0	mc->gregs[REG_RCX] =3D mc->gregs[REG_RIP];
> diff --git a/arch/x86/um/shared/sysdep/mcontext.h b/arch/x86/um/shared/sy=
sdep/mcontext.h
> index 15e9ff287021..0efe5ddf95af 100644
> --- a/arch/x86/um/shared/sysdep/mcontext.h
> +++ b/arch/x86/um/shared/sysdep/mcontext.h
> @@ -9,6 +9,7 @@
> =C2=A0extern void get_regs_from_mc(struct uml_pt_regs *, mcontext_t *);
> =C2=A0#ifndef CONFIG_MMU
> =C2=A0extern void set_mc_sigsys_hook(mcontext_t *mc);
> +extern void set_mc_userspace_relay_signal(mcontext_t *mc);
> =C2=A0#endif
> =C2=A0
> =C2=A0#ifdef __i386__
> diff --git a/arch/x86/um/shared/sysdep/ptrace.h b/arch/x86/um/shared/sysd=
ep/ptrace.h
> index 8f7476ff6e95..7d553d9f05be 100644
> --- a/arch/x86/um/shared/sysdep/ptrace.h
> +++ b/arch/x86/um/shared/sysdep/ptrace.h
> @@ -65,7 +65,7 @@ struct uml_pt_regs {
> =C2=A0	int is_user;
> =C2=A0
> =C2=A0	/* Dynamically sized FP registers (holds an XSTATE) */
> -	unsigned long fp[];
> +	unsigned long fp[] __attribute__((aligned(16)));
> =C2=A0};
> =C2=A0
> =C2=A0#define EMPTY_UML_PT_REGS { }


