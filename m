Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE83C44501
	for <linux-um@archiver.kernel.org>; Wed,  8 Jul 2026 17:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z81AqF8sZ0HbKd4OyTLskHjABuyT0Tc0putXPru6w9M=; b=vFT0g/HfmABYuHsWzeXLLYfiFe
	+k6z4oBVNPKrufbEv6wdsv65Mz0ytHNxCFoxC5x/IeMUffoZYGOxmH0GjICB3Y8+Qm4rJo7xM6lJN
	eE2CDxC/ctMnPU9gXSQ59zPSnMNTe7xi/8nLaq6WvHakyw3TOY+Ofyq8NaKKPnN0fvKJqxm+0wwDW
	2HauPamiomXEabPjA2emH0NnfjXJPVY33yZPkj7/bb71iSFV9YxF/p19NgciMMAWQpdLwiUIEyYar
	V2GD5XlPHNeybiI+tx3gvCdeAhDvuqBs0mOPEpmT5v3n1b2r0afPM9julws+/Cb0zdAIvmYPwWfsw
	4GL7U9Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whVzx-000000005s7-2V6D;
	Wed, 08 Jul 2026 17:23:49 +0000
Received: from xs1.mindbit.ro ([80.86.107.70] helo=mail.mindbit.ro)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whVzu-000000005ol-390V;
	Wed, 08 Jul 2026 17:23:48 +0000
Received: from bat.kanata.rendec.net (unknown [24.114.111.125])
	by mail.mindbit.ro (Postfix) with ESMTPSA id C6722C2A01;
	Wed,  8 Jul 2026 20:23:07 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro C6722C2A01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1783531415;
	bh=Z81AqF8sZ0HbKd4OyTLskHjABuyT0Tc0putXPru6w9M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=MwinUj84iH00nexlmnhmDgR8X+WQik+DrvADedzcPZ9CeQY6xX1Fx3GoyEAx9wrw+
	 Qdscs2HlxOLAQsUWmM9C8f5DrkHkoVgKYwJs+XQ2tFPd5t4en+6vUqgSLYxSBdIwBj
	 555LvdKRH7m1aCTa5jMD6siDGQdvrKp961ZSe90G1chGvdgdtY0LoAvKa+i9v8wU5c
	 bWRF7OLablSVqprq4HLnjHYPD0Doh6wC1fnDaN+ZveYxw8RUEs8Ut6dFJfZDIKl5We
	 w78c65fWXzE8Q1+/ZRaJSLn4ncOl+TKAdXUve5QtEGG7DQ85WMF0AHi0oAnduE4Xgt
	 l68qBKty9jNkA==
Message-ID: <4614d1281cace737e3e117bd7242253475a30f58.camel@rendec.net>
Subject: Re: [patch 01/18] powerpc: Move stack randomization after
 syscall_enter_from_user_mode()
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
Date: Wed, 08 Jul 2026 13:22:58 -0400
In-Reply-To: <20260707190253.718191130@kernel.org>
References: <20260707181957.433213175@kernel.org>
	 <20260707190253.718191130@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_102347_102031_3C97D788 
X-CRM114-Status: GOOD (  12.27  )
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

On Tue, 2026-07-07 at 21:05 +0200, Thomas Gleixner wrote:
> add_random_kstack_offset() is invoked before syscall_enter_from_user_mode=
()
> establishes state. That's wrong because add_random_kstack_offset() calls
> into instrumentable code.
>=20
> Move it after syscall_enter_from_user_mode() to ensure that state is
> correctly established.
>=20
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
> =C2=A0arch/powerpc/kernel/syscall.c |=C2=A0=C2=A0=C2=A0 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -19,8 +19,8 @@ notrace long system_call_exception(struc
> =C2=A0	long ret;
> =C2=A0	syscall_fn f;
> =C2=A0
> -	add_random_kstack_offset();
> =C2=A0	r0 =3D syscall_enter_from_user_mode(regs, r0);
> +	add_random_kstack_offset();
> =C2=A0
> =C2=A0	if (unlikely(r0 >=3D NR_syscalls)) {
> =C2=A0		if (unlikely(trap_is_unsupported_scv(regs))) {

Reviewed-by: Radu Rendec <radu@rendec.net>

