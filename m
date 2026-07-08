Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADA4C44503
	for <linux-um@archiver.kernel.org>; Wed,  8 Jul 2026 20:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=apD89r/ATd0i91X5PLxPXmWRbZb01NLEEn83tYTPdj8=; b=lUVDHu9zwXAtkAdlAjKy7MjjB3
	DpFUnt6Zk1K8XcZfaL5gd2ZyoBQj+g/j+okhHVfLklMK0Ut/lqbHWI27xv2av9NOtYkK2eBifyr+d
	x4oBYnyOIl+fJB7DARJKdAsy5lNI1NYKPICbIEITbbp0Rh0E96x8lCQVcFSbplU7Bk/yN8+2zO3xr
	SsTDQGWi7+Cuk7DXiSi2CIZJxh1Ncpr7pUN6ddGpgfEXqvrpsioGrmPZMNnX7xwgIaLganmdZwUBI
	AGmRNhSZxH57Jxxgf6zwYv38Ikaf0B32hYSeJAzwaR6wEL57J4KRQvV+OMGiWmc7A/Q+2+YbOUYaJ
	qRDtLsvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whZN1-00000000PPT-0hEH;
	Wed, 08 Jul 2026 20:59:51 +0000
Received: from xs1.mindbit.ro ([80.86.107.70] helo=mail.mindbit.ro)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whZMy-00000000POA-2Sdk;
	Wed, 08 Jul 2026 20:59:49 +0000
Received: from bat.kanata.rendec.net (unknown [24.114.111.125])
	by mail.mindbit.ro (Postfix) with ESMTPSA id EEAC6C3450;
	Wed,  8 Jul 2026 23:59:23 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro EEAC6C3450
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1783544386;
	bh=apD89r/ATd0i91X5PLxPXmWRbZb01NLEEn83tYTPdj8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=QFBhNiYBGqyqIPaE0Z//h9Otg8dr2LXIHvr8YLUlcTh/kNU/NIbu5jC1lBV3pHdLh
	 Ytm1aPdmx5IPwKpmRwSjzNZATFEnv+SX4IQqX325g318JKX/ahM7OZftwyNPWkKh+8
	 Vevi8c0s6FZB90ZqbVizrkH3lX3FU2ik1T1I5Ls6uZhVB+87d+ps/uU5qQR8vbqmGm
	 WzIaaobCMK1Q68zS0EMjVKisaOGjotqeY2kfDArzrlfOxIAdRTtnnfA8P+I6Lpe81U
	 e7IwFFdqW2LVSX+vRtsYW7C8+F7/fgH4EcUIK6C4eJGLJR5jk9VqhbYq1bnaYAPt14
	 W5V6aNnbwuOcA==
Message-ID: <caeb49cd840279c9fcfae417d1cf239abde20f9e.camel@rendec.net>
Subject: Re: [patch 08/18] x86/syscall: Use
 [syscall_]enter_from_user_mode_randomize_stack()
From: Radu Rendec <radu@rendec.net>
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, Michael Ellerman	
 <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, Huacai Chen	
 <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley
 <pjw@kernel.org>,  Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org, Sven Schnelle <svens@linux.ibm.com>, 
	linux-s390@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Jinjie
 Ruan	 <ruanjinjie@huawei.com>, Andy Lutomirski <luto@kernel.org>, Oleg
 Nesterov	 <oleg@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Guo Ren	 <guoren@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>, Yoshinori Sato	
 <ysato@users.sourceforge.jp>, Richard Weinberger <richard@nod.at>, Chris
 Zankel	 <chris@zankel.net>, linux-arm-kernel@lists.infradead.org, 
	linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta	
 <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian Cain
 <bcain@kernel.org>,  Michal Simek <monstr@monstr.eu>, Dinh Nguyen
 <dinguyen@kernel.org>, "David S. Miller" <davem@davemloft.net>,  Andreas
 Larsson <andreas@gaisler.com>, linux-snps-arc@lists.infradead.org,
 linux-hexagon@vger.kernel.org, 	linux-openrisc@vger.kernel.org,
 sparclinux@vger.kernel.org, 	linux-arch@vger.kernel.org, Michal
 =?ISO-8859-1?Q?Such=E1nek?=	 <msuchanek@suse.de>, Jonathan Corbet
 <corbet@lwn.net>, 	linux-doc@vger.kernel.org
Date: Wed, 08 Jul 2026 16:59:18 -0400
In-Reply-To: <20260707190254.079478122@kernel.org>
References: <20260707181957.433213175@kernel.org>
	 <20260707190254.079478122@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_135948_805159_B0C0C5D6 
X-CRM114-Status: GOOD (  18.63  )
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
> These functions integrate the stack randomization.
>=20
> syscall_enter_from_user_mode_randomize_stack() has the advantage that the
> randomization happens early right after enter_from_user_mode().
>=20
> In both cases also the overhead of get/put_cpu_var() in
> add_random_kstack_offset() is avoided.
>=20
> No functional change.
>=20
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: x86@kernel.org
> ---
> =C2=A0arch/x86/entry/syscall_32.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 19 +++++--------------
> =C2=A0arch/x86/entry/syscall_64.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 3 +--
> =C2=A0arch/x86/include/asm/entry-common.h |=C2=A0=C2=A0=C2=A0 1 -
> =C2=A03 files changed, 6 insertions(+), 17 deletions(-)
>=20
> --- a/arch/x86/entry/syscall_32.c
> +++ b/arch/x86/entry/syscall_32.c
> @@ -142,10 +142,9 @@ static __always_inline bool int80_is_ext
> =C2=A0	 * int80_is_external() below which calls into the APIC driver.
> =C2=A0	 * Identical for soft and external interrupts.
> =C2=A0	 */
> -	enter_from_user_mode(regs);
> +	enter_from_user_mode_randomize_stack(regs);
> =C2=A0
> =C2=A0	instrumentation_begin();
> -	add_random_kstack_offset();
> =C2=A0
> =C2=A0	/* Validate that this is a soft interrupt to the extent possible *=
/
> =C2=A0	if (unlikely(int80_is_external()))
> @@ -210,11 +209,9 @@ DEFINE_FREDENTRY_RAW(int80_emulation)
> =C2=A0{
> =C2=A0	int nr;
> =C2=A0
> -	enter_from_user_mode(regs);
> +	enter_from_user_mode_randomize_stack(regs);
> =C2=A0
> =C2=A0	instrumentation_begin();
> -	add_random_kstack_offset();
> -
> =C2=A0	/*
> =C2=A0	 * FRED pushed 0 into regs::orig_ax and regs::ax contains the
> =C2=A0	 * syscall number.
> @@ -252,10 +249,10 @@ DEFINE_FREDENTRY_RAW(int80_emulation)
> =C2=A0	 * orig_ax, the int return value truncates it. This matches
> =C2=A0	 * the semantics of syscall_get_nr().
> =C2=A0	 */
> -	nr =3D syscall_enter_from_user_mode(regs, nr);
> +	nr =3D syscall_enter_from_user_mode_randomize_stack(regs, nr);
> +
> =C2=A0	instrumentation_begin();
> =C2=A0
> -	add_random_kstack_offset();
> =C2=A0	do_syscall_32_irqs_on(regs, nr);
> =C2=A0
> =C2=A0	instrumentation_end();
> @@ -268,15 +265,9 @@ static noinstr bool __do_fast_syscall_32
> =C2=A0	int nr =3D syscall_32_enter(regs);
> =C2=A0	int res;
> =C2=A0
> -	/*
> -	 * This cannot use syscall_enter_from_user_mode() as it has to
> -	 * fetch EBP before invoking any of the syscall entry work
> -	 * functions.
> -	 */
> -	enter_from_user_mode(regs);
> +	enter_from_user_mode_randomize_stack(regs);
> =C2=A0
> =C2=A0	instrumentation_begin();
> -	add_random_kstack_offset();
> =C2=A0	local_irq_enable();
> =C2=A0	/* Fetch EBP from where the vDSO stashed it. */
> =C2=A0	if (IS_ENABLED(CONFIG_X86_64)) {
> --- a/arch/x86/entry/syscall_64.c
> +++ b/arch/x86/entry/syscall_64.c
> @@ -86,10 +86,9 @@ static __always_inline bool do_syscall_x
> =C2=A0/* Returns true to return using SYSRET, or false to use IRET */
> =C2=A0__visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
> =C2=A0{
> -	nr =3D syscall_enter_from_user_mode(regs, nr);
> +	nr =3D syscall_enter_from_user_mode_randomize_stack(regs, nr);
> =C2=A0
> =C2=A0	instrumentation_begin();
> -	add_random_kstack_offset();
> =C2=A0
> =C2=A0	if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr) && nr !=
=3D -1) {
> =C2=A0		/* Invalid system call, but still a system call. */
> --- a/arch/x86/include/asm/entry-common.h
> +++ b/arch/x86/include/asm/entry-common.h
> @@ -2,7 +2,6 @@
> =C2=A0#ifndef _ASM_X86_ENTRY_COMMON_H
> =C2=A0#define _ASM_X86_ENTRY_COMMON_H
> =C2=A0
> -#include <linux/randomize_kstack.h>
> =C2=A0#include <linux/user-return-notifier.h>
> =C2=A0
> =C2=A0#include <asm/nospec-branch.h>

Reviewed-by: Radu Rendec <radu@rendec.net>

