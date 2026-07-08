Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFA4C44501
	for <linux-um@archiver.kernel.org>; Wed,  8 Jul 2026 21:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kcBzFv6UQNpvLv0B/9fxsmBCsaF3luDIfOX4WPfJ0LI=; b=hL01jfMqPjgI+Q7m2v95QZkfZq
	3Osqub5GinRpub1G4S2fToJjaZdOtseVe/dMQueKYv56wn4DflMNajom6RXbvCC9z7jvBAPtAF7Q5
	+Msd7cj9J+Q02dXZ6yKdDYK1HtOkob8Ku0c788igFHptYrXFmTPmOyuYjFqhgoHu/6ffIrAqS9zC5
	6TI6zGWvW6akZUomy1AwjZfDTKAlCwT7Pykn/pLPMH0PQLX56OG8Ahsts7BnCqfqsYsHOhrdy9JLq
	LQwxgirwIutmy7dTA2m7mDk+pZ8WQEVQXV1ndwzdC3rWmKiMiIaqwlwUm1Shw2uqeL1F+XHIyhHTx
	/AZOnmsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whZiL-00000000RHt-3GaS;
	Wed, 08 Jul 2026 21:21:53 +0000
Received: from xs1.mindbit.ro ([80.86.107.70] helo=mail.mindbit.ro)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whZiH-00000000RGw-3qkZ;
	Wed, 08 Jul 2026 21:21:51 +0000
Received: from bat.kanata.rendec.net (unknown [24.114.111.125])
	by mail.mindbit.ro (Postfix) with ESMTPSA id 861B2C343F;
	Thu,  9 Jul 2026 00:21:24 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro 861B2C343F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1783545706;
	bh=kcBzFv6UQNpvLv0B/9fxsmBCsaF3luDIfOX4WPfJ0LI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=H73P2hvfJZwIoqeJMs+L8qKs84L6aXmcpvOfF+kp0m/siC+vpb3dmh5/rQGzQvZb1
	 KAdLUM9HsIAVBSvQjur23GoqyvDR1vgkeRT+zXhGdund4eNITGlrejtsuhMxfFKCAR
	 IZ2RR1YudeVpqiP4/BJTXsJStEaItfFAHRrFL/MeBdH47TYEEwHpIXXyM29AJ0RJba
	 vDIsPAjX9g3lfxQFYB1UHQ6gSu4bIZDX60YvEcwW27AO+k2CzGxaM5EC7xOeYYIbCf
	 SQX7lGJfXcy7EYovUwRvpU/bXxv/k8y5ltB87qAr3f6aIyyUbl73d4R/VmW3qRZE22
	 yV9hYRdOWZEFg==
Message-ID: <28fb0a8fd840bbf5223c60fea156584cb0f0f208.camel@rendec.net>
Subject: Re: [patch 09/18] entry: Remove syscall_enter_from_user_mode()
From: Radu Rendec <radu@rendec.net>
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Michael Ellerman
 <mpe@ellerman.id.au>,  Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, Huacai Chen	
 <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley
 <pjw@kernel.org>,  Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org, Sven Schnelle <svens@linux.ibm.com>, 
	linux-s390@vger.kernel.org, x86@kernel.org, Mark Rutland
 <mark.rutland@arm.com>,  Jinjie Ruan <ruanjinjie@huawei.com>, Andy
 Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas	 <catalin.marinas@arm.com>, Guo
 Ren <guoren@kernel.org>, Geert Uytterhoeven	 <geert@linux-m68k.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>,  Helge Deller	 <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger
 <richard@nod.at>, Chris Zankel <chris@zankel.net>,
 linux-arm-kernel@lists.infradead.org, 	linux-alpha@vger.kernel.org,
 linux-csky@vger.kernel.org, 	linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, 	linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, 	linux-um@lists.infradead.org, Arnd Bergmann
 <arnd@arndb.de>, Vineet Gupta	 <vgupta@kernel.org>, Will Deacon
 <will@kernel.org>, Brian Cain <bcain@kernel.org>,  Michal Simek
 <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, "David S. Miller"
 <davem@davemloft.net>,  Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-arch@vger.kernel.org, Michal =?ISO-8859-1?Q?Such=E1nek?=	
 <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>, 
	linux-doc@vger.kernel.org
Date: Wed, 08 Jul 2026 17:21:19 -0400
In-Reply-To: <20260707190254.132654198@kernel.org>
References: <20260707181957.433213175@kernel.org>
	 <20260707190254.132654198@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_142150_134240_6C1A02EE 
X-CRM114-Status: GOOD (  28.23  )
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

On Tue, 2026-07-07 at 21:06 +0200, Thomas Gleixner wrote:
> All architecture use either:
>=20
> =C2=A0=C2=A0=C2=A0 nr =3D enter_from_user_mode_randomize_stack(regs, nr);

You probably mean syscall_enter_from_user_mode_randomize_stack.

>=20
> or
>=20
> =C2=A0=C2=A0=C2=A0 enter_from_user_mode_randomize_stack(regs);
> =C2=A0=C2=A0=C2=A0 nr =3D syscall_enter_from_user_mode_work(regs, nr);
>=20
> Remove the now unused function.
>=20
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
> =C2=A0Documentation/core-api/entry.rst |=C2=A0=C2=A0 17 +++++++++-------
> =C2=A0include/linux/entry-common.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
40 +++------------------------------------
> =C2=A0include/linux/irq-entry-common.h |=C2=A0=C2=A0=C2=A0 6 ++---
> =C2=A03 files changed, 17 insertions(+), 46 deletions(-)
>=20
> --- a/Documentation/core-api/entry.rst
> +++ b/Documentation/core-api/entry.rst
> @@ -68,7 +68,7 @@ low-level C code must not be instrumente
> =C2=A0=C2=A0 noinstr void syscall(struct pt_regs *regs, int nr)
> =C2=A0=C2=A0 {
> =C2=A0	arch_syscall_enter(regs);
> -	nr =3D syscall_enter_from_user_mode(regs, nr);
> +	nr =3D syscall_enter_from_user_mode_randomize_stack(regs, nr);
> =C2=A0
> =C2=A0	instrumentation_begin();
> =C2=A0	if (!invoke_syscall(regs, nr) && nr !=3D -1)
> @@ -78,12 +78,14 @@ low-level C code must not be instrumente
> =C2=A0	syscall_exit_to_user_mode(regs);
> =C2=A0=C2=A0 }
> =C2=A0
> -syscall_enter_from_user_mode() first invokes enter_from_user_mode() whic=
h
> -establishes state in the following order:
> +syscall_enter_from_user_mode_randomize_stack() first invokes
> +enter_from_user_mode_randomize_stack() which establishes state in the
> +following order:
> =C2=A0
> =C2=A0=C2=A0 * Lockdep
> =C2=A0=C2=A0 * RCU / Context tracking
> =C2=A0=C2=A0 * Tracing
> +=C2=A0 * Apply stack randomization
> =C2=A0
> =C2=A0and then invokes the various entry work functions like ptrace, secc=
omp, audit,
> =C2=A0syscall tracing, etc. After all that is done, the instrumentable in=
voke_syscall
> @@ -99,10 +101,11 @@ that it invokes exit_to_user_mode() whic
> =C2=A0=C2=A0 * RCU / Context tracking
> =C2=A0=C2=A0 * Lockdep
> =C2=A0
> -syscall_enter_from_user_mode() and syscall_exit_to_user_mode() are also
> -available as fine grained subfunctions in cases where the architecture c=
ode
> -has to do extra work between the various steps. In such cases it has to
> -ensure that enter_from_user_mode() is called first on entry and
> +syscall_enter_from_user_mode_randomize_stack() and
> +syscall_exit_to_user_mode() are also available as fine grained subfuncti=
ons
> +in cases where the architecture code has to do extra work between the
> +various steps. In such cases it has to ensure that
> +enter_from_user_mode_randomize_stack() is called first on entry and
> =C2=A0exit_to_user_mode() is called last on exit.
> =C2=A0
> =C2=A0Do not nest syscalls. Nested syscalls will cause RCU and/or context=
 tracking
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -19,7 +19,7 @@
> =C2=A0#endif
> =C2=A0
> =C2=A0/*
> - * SYSCALL_WORK flags handled in syscall_enter_from_user_mode()
> + * SYSCALL_WORK flags handled in syscall_enter_from_user_mode_work()
> =C2=A0 */
> =C2=A0#define SYSCALL_WORK_ENTER	(SYSCALL_WORK_SECCOMP |			\
> =C2=A0				 SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
> @@ -205,42 +205,10 @@ do {									\
> =C2=A0	_ret;								\
> =C2=A0})
> =C2=A0
> -/**
> - * syscall_enter_from_user_mode - Establish state and check and handle w=
ork
> - *				=C2=A0 before invoking a syscall
> - * @regs:	Pointer to currents pt_regs
> - * @syscall:	The syscall number
> - *
> - * Invoked from architecture specific syscall entry code with interrupts
> - * disabled. The calling code has to be non-instrumentable. When the
> - * function returns all state is correct, interrupts are enabled and the
> - * subsequent functions can be instrumented.
> - *
> - * This is the combination of enter_from_user_mode() and
> - * syscall_enter_from_user_mode_work() to be used when there is no
> - * architecture specific work to be done between the two.
> - *
> - * Returns: The original or a modified syscall number. See
> - * syscall_enter_from_user_mode_work() for further explanation.
> - */
> -static __always_inline long syscall_enter_from_user_mode(struct pt_regs =
*regs, long syscall)
> -{
> -	long ret;
> -
> -	enter_from_user_mode(regs);
> -
> -	instrumentation_begin();
> -	local_irq_enable();
> -	ret =3D syscall_enter_from_user_mode_work(regs, syscall);
> -	instrumentation_end();
> -
> -	return ret;
> -}
> -
> =C2=A0/*
> - * If SYSCALL_EMU is set, then the only reason to report is when
> - * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).=C2=A0 This syscall
> - * instruction has been already reported in syscall_enter_from_user_mode=
().
> + * If SYSCALL_EMU is set, then the only reason to report is when SINGLES=
TEP is
> + * set (i.e. PTRACE_SYSEMU_SINGLESTEP).=C2=A0 This syscall instruction h=
as been
> + * already reported in syscall_enter_from_user_mode_work().
> =C2=A0 */
> =C2=A0static __always_inline bool report_single_step(unsigned long work)
> =C2=A0{
> --- a/include/linux/irq-entry-common.h
> +++ b/include/linux/irq-entry-common.h
> @@ -49,9 +49,9 @@
> =C2=A0 * Defaults to an empty implementation. Can be replaced by architec=
ture
> =C2=A0 * specific code.
> =C2=A0 *
> - * Invoked from syscall_enter_from_user_mode() in the non-instrumentable
> - * section. Use __always_inline so the compiler cannot push it out of li=
ne
> - * and make it instrumentable.
> + * Invoked from enter_from_user_mode_syscall_and_randomize_stack() in th=
e
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Probably syscall_enter_from_user_mode_randomize_stack()? But the
reality is it's only ever invoked from enter_from_user_mode(), which is
below in the same file (include/linux/irq-entry-common.h).

Granted, that's an always inline function, and it's used by both macros
you added (since the second one uses the first one).

> + * non-instrumentable section. Use __always_inline so the compiler canno=
t push
> + * it out of line and make it instrumentable.
> =C2=A0 */
> =C2=A0static __always_inline void arch_enter_from_user_mode(struct pt_reg=
s *regs);
> =C2=A0


