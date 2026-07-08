Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E28C44503
	for <linux-um@archiver.kernel.org>; Wed,  8 Jul 2026 17:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oMlf4rzg7sFMgtBO8f/rqo4QHF22NzBws1cUSUO+r80=; b=uszBRDJ3nptZxYwLfiIFjPIGGE
	GsVQdRVw3MeifgDswbMIYJJHy2VaIXZwBMaGw0DEhKe5CD+Mo02IGQQe/4uH/iduodp7V84wT3HjM
	nqK5kE/J9L7Eb7UsOfzB4+DZNh/rkFuUNvCWaM4Wk+rP3Fu3zD5Qobhgp5qTL0x3t/Q4qLxrDjf4R
	66prbo9qpyY4qmRowGhKJ3bqlrLnCr3iRCefx34O9nnEg/1gdGlyU8nfkbG8k+2Pei0jze01XF0vF
	zLLuME/NUEis92BSN75esVJkmGMUpp9V8lHXWb9ArxdwGOGndy0/R6N620suiHotWeYpMZcKmP9Pz
	EhidUSDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whW1K-000000006C6-0kd1;
	Wed, 08 Jul 2026 17:25:14 +0000
Received: from xs1.mindbit.ro ([80.86.107.70] helo=mail.mindbit.ro)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whW1G-000000006Ak-0SDf;
	Wed, 08 Jul 2026 17:25:11 +0000
Received: from bat.kanata.rendec.net (unknown [24.114.111.125])
	by mail.mindbit.ro (Postfix) with ESMTPSA id 1E89DC2B1F;
	Wed,  8 Jul 2026 20:24:38 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro 1E89DC2B1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1783531507;
	bh=oMlf4rzg7sFMgtBO8f/rqo4QHF22NzBws1cUSUO+r80=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=OJuzJLG2oJHC8E6/z6u4YL1brifg3n0KypZd9zeBUsdEd6uLxd+9vUKIXm8fNb+sD
	 40TB/onHyQSWEZ0oPdpje/xAjGna37MjawhgGr3bVxva9cjLjk1XfUhqToNdmtUx7z
	 YMvmViVzUq9/FTET4wtq/Yhx/L0ZlUxPuNUXmfoDanL5GBZtufQoF3ZbsskDV434aw
	 kxDRuhqvAGGem4j2hDVIoI59nXr2IxQ3aAqoNF0TEbKK88RSrx6CqBol40sxnwMfxK
	 rd7e4S6y5Zb6OYXlWmLIfxqvBAfINm0f8D7u03YVplchQ7tuJ84O05FoHalkh1Nik9
	 f0YRdybiCZuUQ==
Message-ID: <db4b8c27df9be997f935928f2624a863a1f998d6.camel@rendec.net>
Subject: Re: [patch 02/18] randomize_kstack: Provide
 add_random_kstack_offset_irqsoff()
From: Radu Rendec <radu@rendec.net>
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
 Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde
 <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,  Huacai Chen
 <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
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
Date: Wed, 08 Jul 2026 13:24:33 -0400
In-Reply-To: <20260707190253.768842729@kernel.org>
References: <20260707181957.433213175@kernel.org>
	 <20260707190253.768842729@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_102510_328407_D7EE7987 
X-CRM114-Status: GOOD (  14.46  )
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
> add_random_kstack_offset() uses get/put_cpu_var() which is pointless
> overhead when it is invoked from low level entry code with interrupts
> disabled.
>=20
> Provide a irqsoff() variant, which avoids that.
>=20
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Kees Cook <kees@kernel.org>
> ---
> =C2=A0include/linux/randomize_kstack.h |=C2=A0=C2=A0 19 +++++++++++++++++=
++
> =C2=A01 file changed, 19 insertions(+)
>=20
> --- a/include/linux/randomize_kstack.h
> +++ b/include/linux/randomize_kstack.h
> @@ -77,8 +77,27 @@ static __always_inline u32 get_kstack_of
> =C2=A0	}								\
> =C2=A0} while (0)
> =C2=A0
> +/**
> + * add_random_kstack_offset_irqsoff - Increase stack utilization by a ra=
ndom offset.
> + *
> + * This should be used in the syscall entry path after user registers ha=
ve been
> + * stored to the stack. Interrupts must be still disabled.
> + */
> +#define add_random_kstack_offset_irqsoff()					\
> +do {										\
> +	lockdep_assert_irqs_disabled();						\
> +	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,		\
> +				&randomize_kstack_offset)) {			\
> +		u32 offset =3D prandom_u32_state(raw_cpu_ptr(&kstack_rnd_state));	\
> +		u8 *ptr =3D __kstack_alloca(KSTACK_OFFSET_MAX(offset));		\
> +		/* Keep allocation even after "ptr" loses scope. */		\
> +		asm volatile("" :: "r"(ptr) : "memory");			\
> +	}									\
> +} while (0)
> +
> =C2=A0#else /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
> =C2=A0#define add_random_kstack_offset()		do { } while (0)
> +#define add_random_kstack_offset_irqsoff()	do { } while (0)
> =C2=A0#endif /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
> =C2=A0
> =C2=A0#endif

Reviewed-by: Radu Rendec <radu@rendec.net>

