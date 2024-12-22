Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80E8E7718D
	for <linux-um@archiver.kernel.org>; Sun, 22 Dec 2024 00:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G56dFj5BRaIttSoRxhRi+K83W3sP81bwdAaZ6QoaIrc=; b=gjPytW/ii5kwNUrCS49PgxHRQp
	EHJ2qr1br/5mmH70axAEmpee4X7WEO2bV4Q0nKi0/HHixMyyQEhSaCOkoNoxBkAhVFWrPVGvIOtj3
	WBoTw5ddovv7q9O+qFfRD1PxqTOGScNZ5v4cWW3OBKjBvDQ/7llH8hUfWiCLzUGtXhBaJ20ksDgvD
	Dgs1I1NU04nJCTPt0y2apGR6doc5gq3ZZysRUMFB1rLz63dEpEmxnQ+WjHe51Xt1ZtR4Va5KLc6hX
	5DadKB6Nq8lOn+kLJuJpitGAEpi/cdoiC4VxxAFYN5Vy5sK+ntW2c3lZ+sD2smc+Rht3C1HV7nyKP
	lsvxcF7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tPACr-00000007cAc-0OrL;
	Sun, 22 Dec 2024 00:52:29 +0000
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tPACn-00000007c9n-3YdL;
	Sun, 22 Dec 2024 00:52:27 +0000
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-6eff8289d0eso27694917b3.0;
        Sat, 21 Dec 2024 16:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734828744; x=1735433544; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G56dFj5BRaIttSoRxhRi+K83W3sP81bwdAaZ6QoaIrc=;
        b=FGASEvmUrZZyY2avjPCCV8kOxTz6tTHO6xo/zK8EPkJlDiK+4yJ8u2W76I6Nax7USV
         /2Pe2vww6IhBYSsI/y/SC2+q0NpOsAtnbUO0lPwDmz1DobuCNwFNj2X9rrCiFg2VbdEx
         n8wIbSYMEFL7AYEAGCnQ9IU1tvxLqPo1JXXnR8qiC36T3HpNNIlx5bcVoJE/x6juxygX
         moHcmwuRwsl677csl4x5B4uyHczN2Ig7rakQWXFZYvHkpR13P9zIgCd2iIFioHbmONvC
         XxP8NgMq6/jh7c72y56o1Jys4odHpaR9v/J22lp4klrWMf93fZbHgCM1nOuuhKho3BLK
         8S1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734828744; x=1735433544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G56dFj5BRaIttSoRxhRi+K83W3sP81bwdAaZ6QoaIrc=;
        b=TPXY0YFV+D2A2baBvy0cJ3kGXVRPnOa+gTcIKUF234g5KpzM6P8/TNT2I2YTcEbEhA
         zbBejT1ihoeUBCkgJlAsKwI2Y0/vRhuiKB0GynNh+7abF03p7INTb+bhHQyY7lYyLs3E
         zPbufMMZvVLwl9Cs6EMArqRAPxN3nWMMG5vC+LGQlDKVjTGgnAiRJ42Hi82E/Q3WD5T2
         vEx+yZ4x39qduVos+ZLIq8V7pBe1Co0mYhg0OXA6fVgjeKfABOXbk8FgqEo0EXBuZAGW
         AZ1mSB36QWvqKFmRUITKVrDmcynkfVwy+Et+VYBw3s1Ul13e8zsmfPsFV4l6k8qNgZur
         J5cQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+pa/bIdcZPSzAmYzFJ+ActKWr9YDfqVPli06/joKAkA8nAW60PHLIgqajf7HvIffeori2wHrFkbY6y2P9LdAt@lists.infradead.org, AJvYcCX4MLM3GYo4GcJMwI99WoKg+Qz97XWryyJ3uoBpULo4NX1D0fPhXih3cHcz383kUoNH7Pq8GzELuOE=@lists.infradead.org, AJvYcCXnmX2DhpHmgB9OGJunFXu3/klQzodP2Vr3ffBPCvLwiotVkdcpMg0r49aCDq46TIc3EnPCa5rs14XNGek=@lists.infradead.org
X-Gm-Message-State: AOJu0YwDvjL9ntqkYGik0PcJfbjUFYAbgFOfbRbL9auDHPlsHN35RMZM
	p8UlbkpIv5N+YXgrOZfcc5HtZjdn9MdSyzR1H0+e2vocvcYp5rmoq/aqZObFxjqPFvvTaVS2qFF
	o0YcakS/VMYW3l8C3C7g3uVKErAk=
X-Gm-Gg: ASbGncst9bKDrcNXEn6pDytJAnm7EREZYl1f0mmicD4y8Qk6MG9Qxv7UsV/Lj25PHbs
	pTk/xMqCgh6qoxAEhLD0ihLeEBq38JUBrjQ9+ZX0=
X-Google-Smtp-Source: AGHT+IHH5gTAOmFubOYjlrK+2+jdIvePBlyZPYVyBZBy90RljxEGCQgcvHQMo3bTypvAoytVk58QJl8i95oeqQUdh1w=
X-Received: by 2002:a05:690c:4e82:b0:6f0:21d6:4497 with SMTP id
 00721157ae682-6f3f80d911amr42730727b3.9.1734828744363; Sat, 21 Dec 2024
 16:52:24 -0800 (PST)
MIME-Version: 1.0
References: <20241221104304.2655909-1-guoweikang.kernel@gmail.com> <CAMuHMdXbB-ksxZ9+YRz86wazPGSM09ZFX7JZoyH--=UDndS=TQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXbB-ksxZ9+YRz86wazPGSM09ZFX7JZoyH--=UDndS=TQ@mail.gmail.com>
From: Weikang Guo <guoweikang.kernel@gmail.com>
Date: Sun, 22 Dec 2024 08:52:14 +0800
Message-ID: <CAOm6qn=aN_n3jRc79wr-AGVaQXCbZoyE0yXYcZfw28-uBv+zuQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/memblock: Add memblock_alloc_or_panic interface
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Sam Creasey <sammy@sammy.net>, 
	Huacai Chen <chenhuacai@kernel.org>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Oreoluwa Babatunde <quic_obabatun@quicinc.com>, 
	rafael.j.wysocki@intel.com, Palmer Dabbelt <palmer@rivosinc.com>, 
	Hanjun Guo <guohanjun@huawei.com>, Easwar Hariharan <eahariha@linux.microsoft.com>, 
	Johannes Berg <johannes.berg@intel.com>, Ingo Molnar <mingo@kernel.org>, 
	Dave Hansen <dave.hansen@intel.com>, Christian Brauner <brauner@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Richard Henderson <richard.henderson@linaro.org>, 
	Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	WANG Xuerui <kernel@xen0n.name>, Michael Ellerman <mpe@ellerman.id.au>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	Helge Deller <deller@gmx.de>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Geoff Levand <geoff@infradead.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Andreas Larsson <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, kasan-dev@googlegroups.com, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241221_165225_904549_0815503B 
X-CRM114-Status: GOOD (  25.19  )
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

Geert Uytterhoeven <geert@linux-m68k.org> wrote on Saturday, 21
December 2024 at 22:10
>
> Hi Guo,
>
> On Sat, Dec 21, 2024 at 11:43=E2=80=AFAM Guo Weikang
> <guoweikang.kernel@gmail.com> wrote:
> > Before SLUB initialization, various subsystems used memblock_alloc to
> > allocate memory. In most cases, when memory allocation fails, an immedi=
ate
> > panic is required. To simplify this behavior and reduce repetitive chec=
ks,
> > introduce `memblock_alloc_or_panic`. This function ensures that memory
> > allocation failures result in a panic automatically, improving code
> > readability and consistency across subsystems that require this behavio=
r.
> >
> > Signed-off-by: Guo Weikang <guoweikang.kernel@gmail.com>
>
> Thanks for your patch!
>
> > --- a/include/linux/memblock.h
> > +++ b/include/linux/memblock.h
> > @@ -417,6 +417,20 @@ static __always_inline void *memblock_alloc(phys_a=
ddr_t size, phys_addr_t align)
> >                                       MEMBLOCK_ALLOC_ACCESSIBLE, NUMA_N=
O_NODE);
> >  }
> >
> > +static __always_inline void *__memblock_alloc_or_panic(phys_addr_t siz=
e,
> > +                                                      phys_addr_t alig=
n,
> > +                                                      const char *func=
)
> > +{
> > +       void *addr =3D memblock_alloc(size, align);
> > +
> > +       if (unlikely(!addr))
> > +               panic("%s: Failed to allocate %llu bytes\n", func, size=
);
> > +       return addr;
> > +}
>
> Please make this out-of-line, and move it to mm/memblock.c, so we have
> just a single copy in the final binary.
>
Got it, I'll make the change
> > +
> > +#define memblock_alloc_or_panic(size, align)    \
> > +        __memblock_alloc_or_panic(size, align, __func__)
> > +
> >  static inline void *memblock_alloc_raw(phys_addr_t size,
> >                                                phys_addr_t align)
> >  {
> > diff --git a/init/main.c b/init/main.c
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

Best regards
             Guo

