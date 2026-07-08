Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB88C44503
	for <linux-um@archiver.kernel.org>; Wed,  8 Jul 2026 22:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6Cz8BOTHw08E9NcS2yyN9pfUWQWxwh/AbZG3/5oSlNo=; b=o3ieumVMTl+mqydA+P8Z0q4TUU
	vRWFTUrq3+el11o6ePtFOTIUrrBUHxyVab5Dy9LjwxnhVeKhE4zcrHnbLcTGN2c2XNcpcM78MnPvO
	Zs+cbCMzOn23glnIBlu5EfeFF+GmBDCMVdT5lYx5Uk70n96oroPqCDmHFTRQR9HdGy7TffvcuDXGi
	fW9P7vYLs+6A1HTZRXsQrkocbFvA7UcHck4SgNmEGzfSBOLKuM5DcP7bhGRP6Cx0JWdm+tsnBQKUC
	Dxi99fLNWzSaGVq703FcOZSa2AAXLCK/GIHUEx83QvZsHcJPTSr00X7s9xD05sGt8mfzrSkGpdwHR
	trnVxBNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whaRE-00000000WPI-18Ie;
	Wed, 08 Jul 2026 22:08:16 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whaRD-00000000WOl-0IpH;
	Wed, 08 Jul 2026 22:08:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 137E040751;
	Wed,  8 Jul 2026 22:08:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A72C1F000E9;
	Wed,  8 Jul 2026 22:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783548494;
	bh=6Cz8BOTHw08E9NcS2yyN9pfUWQWxwh/AbZG3/5oSlNo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=FHRxCIVTukQAG3miFmDwBEU6I209sFjCARp6kEzFqtKLvTVeoIbUSsC2eSN9qIdnR
	 VQXn9bZShPRC0JvYyhaNRqG/HqxM+0wwkl21YMKvZbZEbwDcCKokdsns9i9ZzyHYbj
	 JPwH4nZrvGyAqtNPEHE5kgl0uyruw7Hao0EDZtv1yI13czTm2pC4iPHCUKvnl9ttoA
	 FQw80n5mm74fyWAHSi+eqhPD70ioINDjajTGwworQYlA/8+7sT+AhOFmASXWzYgLLf
	 IhREvhCoeEVhqiVsSYxwG/avxpiZWCQ9oe9o7pb6I/zkL58DG4nCbi8UNCb/vvui/f
	 nhrMJDrJBHLcg==
From: Thomas Gleixner <tglx@kernel.org>
To: Radu Rendec <radu@rendec.net>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org, Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org, x86@kernel.org, Mark Rutland
 <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, Andy
 Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Guo
 Ren <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger
 <richard@nod.at>, Chris Zankel <chris@zankel.net>,
 linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann
 <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Will Deacon
 <will@kernel.org>, Brian Cain <bcain@kernel.org>, Michal Simek
 <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
 linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 09/18] entry: Remove syscall_enter_from_user_mode()
In-Reply-To: <28fb0a8fd840bbf5223c60fea156584cb0f0f208.camel@rendec.net>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.132654198@kernel.org>
 <28fb0a8fd840bbf5223c60fea156584cb0f0f208.camel@rendec.net>
Date: Thu, 09 Jul 2026 00:08:11 +0200
Message-ID: <87mrw1qgms.ffs@fw13>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, Jul 08 2026 at 17:21, Radu Rendec wrote:

> On Tue, 2026-07-07 at 21:06 +0200, Thomas Gleixner wrote:
>> All architecture use either:
>>=20
>> =C2=A0=C2=A0=C2=A0 nr =3D enter_from_user_mode_randomize_stack(regs, nr);
>
> You probably mean syscall_enter_from_user_mode_randomize_stack.

Duh. I obviously got that wrong in a hurry. Thanks for pointing it out!
>> =C2=A0static __always_inline bool report_single_step(unsigned long work)
>> =C2=A0{
>> --- a/include/linux/irq-entry-common.h
>> +++ b/include/linux/irq-entry-common.h
>> @@ -49,9 +49,9 @@
>> =C2=A0 * Defaults to an empty implementation. Can be replaced by archite=
cture
>> =C2=A0 * specific code.
>> =C2=A0 *
>> - * Invoked from syscall_enter_from_user_mode() in the non-instrumentable
>> - * section. Use __always_inline so the compiler cannot push it out of l=
ine
>> - * and make it instrumentable.
>> + * Invoked from enter_from_user_mode_syscall_and_randomize_stack() in t=
he
>                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> Probably syscall_enter_from_user_mode_randomize_stack()? But the
> reality is it's only ever invoked from enter_from_user_mode(), which is
> below in the same file (include/linux/irq-entry-common.h).

Yes. Indeed.



