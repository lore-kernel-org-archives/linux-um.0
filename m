Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BD9C43458
	for <linux-um@archiver.kernel.org>; Thu,  9 Jul 2026 16:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GEOL8DOWD1Msvjz7k5cAG0xDAOqwGsu0BnpwMff10wU=; b=JAL2+zHBYdrLBXM2nnuDJ9HlkD
	fGR6YOtpdkcSMume3Z4JnHixqSvL4/XjNmyHEbpTGFjKeKvYZMlZ4LUmNKpn8sggHXzYQPkuST4bL
	AWRiL3rc2apd+CZ0RzqsESRFln9q/pd1KGJ0QAvStwIU0/4uKVILuiudJ1rXOUlQkXGffvpCZfW25
	sF1v083CDH/56Lg7HzyDvb5xN8bYEEVHyY/Alhe7oaAvhMHISfCIDnD1w3OC6KZwsnQ82iPYYu3HM
	YYp4iP6txdb43dvhZY8pRTDbFmqYQ20u78z3DvKaVvMfoyxgfaRX2CuEsm2npSt3pAIADi1ll9jJH
	3Xjbrwcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whrad-000000032WN-3QNv;
	Thu, 09 Jul 2026 16:27:07 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whrab-000000032V3-3zrY
	for linux-um@lists.infradead.org;
	Thu, 09 Jul 2026 16:27:07 +0000
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-493ce08a75bso8681935e9.1
        for <linux-um@lists.infradead.org>; Thu, 09 Jul 2026 09:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783614423; x=1784219223; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GEOL8DOWD1Msvjz7k5cAG0xDAOqwGsu0BnpwMff10wU=;
        b=AeIAtOBk9ppvRbASqtFmqsdVQfMtDivwmws+YytjgA9HJz/wdmFbBoIiFKHFAqF+vS
         99pkJb1Q12cuQPTmQpCS3kftHi6w6yQptvVO94YJ1Xbchm1r3e8fV1yrJAIwi8uqgcn5
         S8+R8wRAkSFDUUCXGND0tK8bx0HP90yYDJ9DlCx8PLmYERl2HUxZNFbEGBUCgxQOzlu0
         6xFEwrwplrEITF890qj2tDh1X6EMlUj8BzkErlYcZ/WYPai5ZdhD9J/z2aeoNXGmnIOV
         etef50DkFdmN1OcnzJBotB9zUUD6Z24f/csEkT//H4GwOSe9KZVstjpP2RlGtIV7rnYE
         yXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783614423; x=1784219223;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GEOL8DOWD1Msvjz7k5cAG0xDAOqwGsu0BnpwMff10wU=;
        b=XM9oSFda6kvzJc8SZJUYckysDVbFf/UudNudpJp9yPH+28snQl95opKlodEGPLwH7o
         cT1SNEGS7ERYRZcVp4TNRXx+7xgTMbBxAkilKeh1yKv3tPfslf9WSKf53N6JFXGw1SIz
         fkipkRQh5LaIp7klnByjATve7vxx2XV0TMD4iQQ5eoYV3WRM8VqQSHxXQqYvuooZVlVr
         93XLIcL1/I2ObbmXmKriImImtHIHNLjuM46V08zjFLDsRT2jgyiGOZavyUxoUGItSrpJ
         8W72fOtSpjBzlUF5hDajeNoLGqx/8Zmkl7uklgvdSoNCR6TYLOsM4QRD9s/bN2RzXOz2
         Nq4w==
X-Forwarded-Encrypted: i=1; AHgh+RrCENUwHWUucolHL2UKgLxGBcl1cmS0Ldtd/K06oPI2vxJSYnPLMILnHsOfrx9S/iKMkJo9GJnzCQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwwExoHLrprTC83xjsSIQW6gUglJWSbvjrlUDVPcGhO6/iCDOw6
	SfKrrQCvnfaWfdi7TvYDThWhbLPy0ZzPfXhzjUEyVnfsbtptdxwlMoxn
X-Gm-Gg: AfdE7ckWV/zqHMBooquW4WRV6r6zrtsEC9sZV9bAjDslWuRheK0uztBtFtZ+KY5ppHT
	FPtWjKTjEzumv7qtwU4tpV4KpL/j6faELb8E91cgGkU+VQb/Ll+4EJureNZuo2OdkmcfS6yz1Ne
	rbHTymJPY5Q8qEeLanLelMxVVRVwM3cWlxGPIROrD7eMdCSRzPtb41FHpxX6/u9SXC5cRBHggGh
	m9OmCIIwLZUm37G6jE8++xz5B8mUkD7caK22yP6gsQ0BXulNo55TGZbGa5SvFmTwDQkXBIg9lHY
	RFq0y7yK34iqkHoMJ8C+c/RN9TpUHvPcrNiCDPQA4qTz48CuFpmu17EfykcLHKtpxtUPm/MAlnr
	ids/Oj6V40Ph++K5QGz3F9yLqSs9VClgN08xg6/t8i4M7CrENCj8oSEVAhzlNWn2kUGSz6DvzFw
	PN2eFAHdJ5szZhEPgQxQ4FmqAgA7qQ/6sTTvpn45aJ1vNMsQ==
X-Received: by 2002:a05:600d:6405:10b0:493:eec0:2b8c with SMTP id 5b1f17b1804b1-493eec02c80mr19641245e9.12.1783614423204;
        Thu, 09 Jul 2026 09:27:03 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb670a41sm70023415e9.0.2026.07.09.09.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:27:02 -0700 (PDT)
Date: Thu, 9 Jul 2026 17:26:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, LKML
 <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde
 <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Kees Cook
 <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Sven Schnelle
 <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, Andy
 Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Guo Ren
 <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas
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
 linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
Subject: Re: [patch 13/18] entry: Make trace_syscall_enter() return type
 bool
Message-ID: <20260709172659.7040db33@pumpkin>
In-Reply-To: <87ik6pqdkf.ffs@fw13>
References: <20260707181957.433213175@kernel.org>
	<20260707190254.338083894@kernel.org>
	<ak5ySpil83TNWxeq@kunlun.suse.cz>
	<87se5tqkyp.ffs@fw13>
	<87ik6pqdkf.ffs@fw13>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_092706_029249_5DA19E7D 
X-CRM114-Status: GOOD (  30.99  )
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

On Thu, 09 Jul 2026 01:14:24 +0200
Thomas Gleixner <tglx@kernel.org> wrote:

> On Wed, Jul 08 2026 at 22:34, Thomas Gleixner wrote:
> > On Wed, Jul 08 2026 at 17:52, Michal Such=C3=A1nek wrote:
> > Q: Is it perfect?
> > A: No
> >
> > Q: Can it be made perfect?
> > A: No, because you can't change history and established practice.
> >
> > Just for illustration. Changing the logic in trace_syscall_enter() to:
> >
> > --- a/kernel/entry/syscall-common.c
> > +++ b/kernel/entry/syscall-common.c
> > @@ -9,13 +9,15 @@
> > =20
> >  bool trace_syscall_enter(struct pt_regs *regs, long *syscall)
> >  {
> > +	long orig_syscall =3D *syscall;
> > +
> >  	trace_sys_enter(regs, *syscall);
> >  	/*
> >  	 * Probes or BPF hooks in the tracepoint may have changed the
> >  	 * system call number. Reread it.
> >  	 */
> >  	*syscall =3D syscall_get_nr(current, regs);
> > -	return *syscall !=3D -1L;
> > +	return *syscall =3D=3D orig_syscall || *syscall !=3D -1L;
> >  }
> > =20
> >  void trace_syscall_exit(struct pt_regs *regs, long ret)
> >
> > does not make #2 magically go away. It's still the same problem whether
> > you like it or not. =20
>=20
> And just to be entirely clear, the syscall() interface has to be correct
> in the first place, but then it's all about performance.
>=20
> So the sequence of:
>=20
>    pt_regs =3D PUSH_REGS();
>    syscall =3D pt_regs->syscall_reg;
>    pt_regs->result =3D -ENOSYS;
>=20
>    arch_syscall(pt_regs, syscall) {
>       if (likely(syscall_enter_from_user_mode(pt_regs, &syscall) {

I guess most architectures inline that to avoid the &syscall.
Otherwise you'd want:
	syscall =3D syscall_enter_from_user_mode(pt_regs, syscall);
with the 'error' return being selected to fail the test below
(which -1L converted to ~0UL will do nicely).

	David

>          if (syscall < SYSCALL_max)
>             pt_regs->result =3D invoke_syscall(pt_regs, syscall);
>       }
>       ,,,,
>    }
>    pt_regs->($RETURN_VALUE) =3D pt_regs->result;
>    POP_REGS();
>    return;
>=20
> is the correct and obviuosly most efficient way idependent of the -1L
> return value overload in the original implementation, which this series
> gets rid of for clarity.
>=20
> If an architecture decide[sd] to do otherwise and makes up it's own rules
> which only cover parts of the problem then it _is_ an architecture
> problem and not something which has to be solved by claiming that every
> architecture has to implement the same nonsense as you falsely claimed
> in your RFC^WPOC^Whack thread:
>=20
>   "However, the API should be specified in a way that does not require
>    everyone implementing such flag."
>=20
> There is _ZERO_ requirement for any architecture to implement that
> flag. Just because S390 decided it's a brilliant idea to do so does not
> make it a requirement for everyone.
>=20
> No. Every other architecture got it right because they looked at the
> historical patterns despite having correct documentation at hand.
>=20
> Feel free to prove me wrong with actual facts.
>=20
> Thanks,
>=20
>         tglx
>=20


