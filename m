Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04CBC28B2F
	for <linux-um@archiver.kernel.org>; Tue, 11 Mar 2025 21:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OJ/N6RDNJhsKkhEU6U2fwKdV9v3px1FNP1P5wQQOOck=; b=CqiglAAvwcYePBQwGm7wf3LVDR
	ETehNiwb+mwX1viTKrB1DpSWCIRQ6BpKkzIMF27YOv//DUSRJ9RU/KispkxaqIyVrTbco+dxZK/Uh
	jHMvwUJ9e+IeZ/Ni/ayv/kDhtlxhykdJztx919QD3jhA6bZ6TFeY73JVFChPIp2Z4BAxF6dWf6Q+i
	dIEkB7v6EWI0QfwfPI6GrAtkiuyRWlaF7qezxsx3BjZ1rFnWkn08OIY1IJEuxONi61/a3mSGvaASF
	g5tWi4vGEiJUPQ7kTR0Kwvq1u1UvGnuuu36trKJgZG+Sly3MZO63FlL7E2XcAbety+1zv1AG9YeTK
	a0Hberjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ts7MD-000000072Cg-1Omu;
	Tue, 11 Mar 2025 21:41:49 +0000
Received: from mail-ua1-f54.google.com ([209.85.222.54])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ts7M9-000000072Br-2xsU;
	Tue, 11 Mar 2025 21:41:47 +0000
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-860f0e91121so270307241.0;
        Tue, 11 Mar 2025 14:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741729303; x=1742334103;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJ/N6RDNJhsKkhEU6U2fwKdV9v3px1FNP1P5wQQOOck=;
        b=sDilF1hoqrEoQcnXNJnIB/bwJa7YefcS6xPRNfVNuYwtLQb1of9ugbgyedqo+9evkU
         fyxJ6Gk7V58wdo5dQKKjwwOedb/vd/BipVv0HJDreT9JtsSkfkc52OHEIEqNEsrQpnlJ
         vyHPiAo8OtcKS8T6NGWxEwxsQwQRYMmvUFq8SkYsgt4uhFIGhdX/XfyGRDfahjcN1U5D
         bROQgPGva3ZCdcji29JbPBAYnWzhniHQ0mTUhlU+U6VtRohS0puFGViw1er/r0UFjEAe
         0ceIHC6SsPB1NH5eU1S6EquMXD/uFasKv419aG+wi/RidzcfxNKVh8JDqQzJhikfFo/A
         2SSg==
X-Forwarded-Encrypted: i=1; AJvYcCW07+vUusCyOWOHg39SswcPoVrFC7+Y883DFYfVAhPuaUX9ooD/TTjulnF6NiKET71JaXDyuJLUpSxLW10=@lists.infradead.org, AJvYcCXOFTePPaSIhan25hpn6NdyFujz6Jadyz0J5ZwCi3aaeoUUMwAO8e7iY/d/x3sVHIbiCi/C4bJEuoffM34nkcko@lists.infradead.org, AJvYcCXYC/H0t+TCUdPob3HLa/be3CiBNsrXljL2h5OH/nqn5p6OU2UDYFQs6IKH7A8bDK4OtzHTP/rbc6w=@lists.infradead.org, AJvYcCXgXYpOAiBScrBcU+SPHLEDhJgSJkBtW9OmZOxo4Q9bFb0FaV9ZG8cnEf28nxcqNN11MZV/8PgO0hR7t2AlDGA=@lists.infradead.org
X-Gm-Message-State: AOJu0YxqCGT98oWTWSMLmFCed0iWZvaEhhxAEsnbqCx43YExNi9ytkBz
	rP6HGulIcjVAKuj8SXyX7uXu0K1+FJ0Tuaj4qkA1/f+Cs9ZZ6tJQpyzg5iqr
X-Gm-Gg: ASbGnctRISkqSIwPZwcfm7MKMQWUJqhhQO7CtZ+4UQLOiwHy01aeYKKLtvSVs7lsZwV
	v2dCz75t6Uz0l13fdmzFdcCjhuutMiIluJlaH83W6G95adJJq9xuO1XTMnB9rf8D4isuRynV8OF
	qSO0Xpp3QNLQfM6IPWfNETUzcj4xsCrHeTxlKsOfI+PsZgjjc/tA8i7Mtq/tU5Irq/Bd94Gg46Y
	UsK2LnOm8mKe2+PvJJR64+m4hhV+6S7eYD3/GipStFL6ivLjg+9naPFRnw8ikq7gy2/o1DHeI5S
	1ryBsJU5cyD0hNhc22WW5WsMkNVm9U8QEvb+5RHzpyn6qgQQcdI9eDf+zrBBCOt1Y6xAeCiWuEq
	VIJachsiowqg=
X-Google-Smtp-Source: AGHT+IHQiuBftTVNptHPzu9JVwcFeN8OPYs82dsifnTaxDeYniIc9QrAtNbRfE78+1bqHnU3eJeP8A==
X-Received: by 2002:a05:6102:5124:b0:4b6:9ba:72c0 with SMTP id ada2fe7eead31-4c34dd17143mr3604884137.1.1741729303327;
        Tue, 11 Mar 2025 14:41:43 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c2fb452ad0sm2490970137.9.2025.03.11.14.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 14:41:43 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-524038ba657so270807e0c.0;
        Tue, 11 Mar 2025 14:41:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZbmiBiZnB7vTW6lwgtkBDqFsAsQj5jP7mQ70qUyWDfpDBORJ1wz1lcpU0usF0sD0c/48ER2LO0dpa/RTD1WQ=@lists.infradead.org, AJvYcCVe6RfnDlhHMq4Ve3J72hIt7oRdl/dlxuppAZJjmTSWfcdfRW5WrxfwI4xBpX1KkilYLWgEfMi/Yyc=@lists.infradead.org, AJvYcCWdoKojHPp9Ui8FBFCr0um2b2vgB5IHcM1UjjWsEDlBPYDfoBBZrcRj56RA88j9mwbjx7z90W2x2Vvy+ic=@lists.infradead.org, AJvYcCXzWJhz7SU/jIHvF6nIh6wzP6aoMOq/pq9IWueOZqKU9bjjCpTMDR41ata6eYYSmd88+nQaeejuR6Hi0tZo3xOC@lists.infradead.org
X-Received: by 2002:a05:6122:489c:b0:523:e4c6:dddb with SMTP id
 71dfb90a1353d-52419478380mr4380371e0c.0.1741729302782; Tue, 11 Mar 2025
 14:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250306185124.3147510-1-rppt@kernel.org> <20250306185124.3147510-11-rppt@kernel.org>
 <cee346ec-5fa5-4d0b-987b-413ee585dbaa@sirena.org.uk> <Z9Cl8JKkRGhaRrgM@kernel.org>
 <5e40219b-f149-4e0f-aa10-c09fa183945e@sirena.org.uk>
In-Reply-To: <5e40219b-f149-4e0f-aa10-c09fa183945e@sirena.org.uk>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Mar 2025 22:41:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUGnBeo69NkYsv35YHp6H9GJSu-hoES2A8_0WhpX1zFhQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jp2UP71Gi3RsrYhaKY-FGNeXSzj4L3BI-snK3mtBDJzZMW7SrRY1lIN6cU
Message-ID: <CAMuHMdUGnBeo69NkYsv35YHp6H9GJSu-hoES2A8_0WhpX1zFhQ@mail.gmail.com>
Subject: Re: [PATCH 10/13] arch, mm: set high_memory in free_area_init()
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Guo Ren <guoren@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, 
	Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>, 
	Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	x86@kernel.org, Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_144145_744017_DB6142CA 
X-CRM114-Status: GOOD (  26.67  )
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

Hi Mark,

On Tue, 11 Mar 2025 at 22:33, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Mar 11, 2025 at 11:06:56PM +0200, Mike Rapoport wrote:
> > On Tue, Mar 11, 2025 at 05:51:06PM +0000, Mark Brown wrote:
> > > This patch appears to be causing breakage on a number of 32 bit arm
> > > platforms, including qemu's virt-2.11,gic-version=3.  Affected platforms
> > > die on boot with no output, a bisect with qemu points at this commit and
> > > those for physical platforms appear to be converging on the same place.
>
> > Can you share how this can be reproduced with qemu?
>
> https://lava.sirena.org.uk/scheduler/job/1184953
>
> Turns out it's actually producing output on qemu:
>
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 6.14.0-rc6-next-20250311 (tuxmake@tuxmake) (arm-linux-gnueabihf-gcc (Debian 13.3.0-5) 13.3.0, GNU ld (GNU Binutils for Debian) 2.43.1) #1 SMP @1741691801
> [    0.000000] CPU: ARMv7 Processor [414fc0f0] revision 0 (ARMv7), cr=10c5387d
> [    0.000000] CPU: div instructions available: patching division code
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
> [    0.000000] OF: fdt: Machine model: linux,dummy-virt
> [    0.000000] random: crng init done
> [    0.000000] earlycon: pl11 at MMIO 0x09000000 (options '')
> [    0.000000] printk: legacy bootconsole [pl11] enabled
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] efi: UEFI not found.
> [    0.000000] cma: Reserved 64 MiB at 0x00000000
>
> - I'd only been sampling the logs for the physical platforms, none of
> which had shown anything.

Hangs that early need "earlycon", which the qemu boot above does have.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

