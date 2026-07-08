Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2489BC44503
	for <linux-um@archiver.kernel.org>; Wed,  8 Jul 2026 20:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=up349XAcstBbuMmtgpGoCSrvvL3bQC70drCvWmoD2ds=; b=iHAZTVjOt3qKm0+PnL5gZt6wnF
	cg0YF5rsMTEbgMAst/9e3rYGjQETY7nXiIaZxDG+VgDM+6TYSqQyR/35nH3TbET2YWvb5VueWDqsO
	WFmQgIIptu8YhCUVCOJX7i5Yx5NQdbqwRg9Ccp+VjLY2FGRkaJqe2Vn8sl/IW1UlCxxwL1CiPk60O
	1Tc4vZ6BaIl8Yp9oVYhfAnyW74WQJaylZYkt4BTEC1LFH2iyrx2DJQPh71BG0W8QT93cle5a6476y
	UuX+UhEIA1SU3xQmmQTpyuVT78+cu9c82WbzYYMMZQnkNsiVVnyuSNfaZyufweVI4y+zRYz+JHdy5
	ToHsYpzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whZKo-00000000Oz7-1H6Q;
	Wed, 08 Jul 2026 20:57:34 +0000
Received: from xs1.mindbit.ro ([80.86.107.70] helo=mail.mindbit.ro)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whZKk-00000000OyS-3WdF;
	Wed, 08 Jul 2026 20:57:32 +0000
Received: from bat.kanata.rendec.net (unknown [24.114.111.125])
	by mail.mindbit.ro (Postfix) with ESMTPSA id 276CAC3437;
	Wed,  8 Jul 2026 23:57:05 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro 276CAC3437
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1783544246;
	bh=up349XAcstBbuMmtgpGoCSrvvL3bQC70drCvWmoD2ds=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ynS36ddUdp8eq69SvUl6OgUXVC9QL2tj6JdfNjNoPXNVKwC/3CN8EubMigM7yTWhw
	 wN2l7xiScOadwqXH8k1Mr6pkHvNMtNLdr91wDtAcHVTHHdPCMoFrB5PPDCaDQEpQ/7
	 nrAG0UN1qXnV/0+w7ire/3DQ71IknBguOljyr+0fQFSjwNiLglUjXiqoASKEjWfiP9
	 hdpfN4vBD8SgIx0jZq/vsbn+u9RcOw90ghJIPsraTy3Kmn5rysmmntnF1EMEJ6MLYT
	 FeMAfAFofJ6Q5u7zyyWHuX3D2olPOI2XjVzaGihUsp+73EBHAshY/LugN1FUs+Ocpp
	 c1dTfe4hj1cHA==
Message-ID: <a8aea664b6dbe92a3ae0c2f084f5c9b1ce591792.camel@rendec.net>
Subject: Re: [patch 06/18] riscv/syscall: Use
 syscall_enter_from_user_mode_randomize_stack()
From: Radu Rendec <radu@rendec.net>
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 Michael Ellerman <mpe@ellerman.id.au>,  Shrikanth Hegde
 <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Kees Cook
 <kees@kernel.org>, Huacai Chen	 <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev, Sven Schnelle	 <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org, x86@kernel.org, Mark Rutland	
 <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, Andy
 Lutomirski	 <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Richard
 Henderson	 <richard.henderson@linaro.org>, Russell King
 <linux@armlinux.org.uk>,  Catalin Marinas <catalin.marinas@arm.com>, Guo
 Ren <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,  Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,  Richard Weinberger	
 <richard@nod.at>, Chris Zankel <chris@zankel.net>, 
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann	
 <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Will Deacon
 <will@kernel.org>,  Brian Cain <bcain@kernel.org>, Michal Simek
 <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,  "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org, 	linux-hexagon@vger.kernel.org,
 linux-openrisc@vger.kernel.org, 	sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, Michal =?ISO-8859-1?Q?Such=E1nek?=	
 <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>, 
	linux-doc@vger.kernel.org
Date: Wed, 08 Jul 2026 16:57:00 -0400
In-Reply-To: <20260707190253.974626922@kernel.org>
References: <20260707181957.433213175@kernel.org>
	 <20260707190253.974626922@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_135731_052712_593272BA 
X-CRM114-Status: GOOD (  13.30  )
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
> syscall_enter_from_user_mode_randomize_stack() replaces
> syscall_enter_from_user_mode() and the subsequent invocation of
> add_random_kstack_offset().
>=20
> The advantage is that it applies the stack randomization right after
> enter_from_user_mode() and thereby avoids the overhead of get/put_cpu_var=
()
> as that code is invoked with interrupts disabled.
>=20
> No functional change.
>=20
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Paul Walmsley <pjw@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: linux-riscv@lists.infradead.org
> ---
> =C2=A0arch/riscv/kernel/traps.c |=C2=A0=C2=A0=C2=A0 5 +----
> =C2=A01 file changed, 1 insertion(+), 4 deletions(-)
>=20
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -7,7 +7,6 @@
> =C2=A0#include <linux/kernel.h>
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/irqflags.h>
> -#include <linux/randomize_kstack.h>
> =C2=A0#include <linux/sched.h>
> =C2=A0#include <linux/sched/debug.h>
> =C2=A0#include <linux/sched/signal.h>
> @@ -333,9 +332,7 @@ void do_trap_ecall_u(struct pt_regs *reg
> =C2=A0
> =C2=A0		riscv_v_vstate_discard(regs);
> =C2=A0
> -		syscall =3D syscall_enter_from_user_mode(regs, syscall);
> -
> -		add_random_kstack_offset();
> +		syscall =3D syscall_enter_from_user_mode_randomize_stack(regs, syscall=
);
> =C2=A0
> =C2=A0		if (syscall >=3D 0 && syscall < NR_syscalls) {
> =C2=A0			syscall =3D array_index_nospec(syscall, NR_syscalls);

Reviewed-by: Radu Rendec <radu@rendec.net>

