Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448A2C7EE29
	for <linux-um@archiver.kernel.org>; Tue,  2 May 2023 14:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:From:
	Subject:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XerOCQw7VxVUWxqw9FbGGDH+tFSwx+V7BShOAi//jn8=; b=jo3h6jAza6/SCh
	cRZrgQsuFz0RXIXGyN3wNN02cV5YUb4iucLP7prUZPYS/rOa/BGazAWwX0L9A/H8q7w0Mt32AL+qA
	F6LobU9YuDOP+rhJtYKDGNrWmeiDGDQ+IVGxP0Tek0KdSFiTu4PWC+ipAXYEqXfGwgaycs7ctD60t
	Zah1H9wTj7JdRp10fZEeKez9GlRZGjPgThH+EtEfUuT2RD0gQNiLmSlZQvv3bb3n5bvuHqyzZFgYk
	qEN8xcZ34NPVif99Ajq4DXf62VU8N0QtNE/RBFET6c8RaPmgca0R3X4T2cqFdepu0qSkN85LXyFxG
	wlaGZAtUZIgg4rwlasCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptqvw-001oVW-1f;
	Tue, 02 May 2023 14:24:48 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptqvs-001oUD-1o;
	Tue, 02 May 2023 14:24:45 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1aaed87d8bdso19867795ad.3;
        Tue, 02 May 2023 07:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683037483; x=1685629483;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1aeen3ZK+Eot6IC/oOTAkZg5Jx6a7diThkYUUdZei0=;
        b=o7eV6bV5rpKciv6EIj9ga4Omoc8JiajzV/SXD9s6GTpCIHwLsqIeUrnFZuC+xAIaiW
         WjEsJu1B2GKv/VlyiP9foiCAZE6F++nD+BWDCHQtjX8GXp25FXxTTDqEhJfEaCmCRZnW
         r/TojnhdtU1uIxMuMFFOdIT7Ow7MxYnqTZbrKtm4QgaRKGsCrFqUlZThCmVisJrJf8LM
         /bNVZ2wUIhggAaUQvPy2HmP3xLnCZxM2nh9Oy/B1JiqMdIiCPGs2rAsKMpXcHd+3R9I1
         ZjnOJ4VKyNowo/00zxs8soF2kfewUpLu4llf08zWCp8MVLdUhOzj6mQ/SdBcj0q0dUoG
         ml+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683037483; x=1685629483;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s1aeen3ZK+Eot6IC/oOTAkZg5Jx6a7diThkYUUdZei0=;
        b=hHftRP2lyufTvo1nDd72xBAnWYhhdOJOW86VyFrfBzow6krWgriM35F9w/jwkAf8oT
         25BR4legCIRE2FFLloABF9Eq1etGkZFCVG6NJZzMsrETMXDk8eCyaO4B5ZhPWqDIxZKp
         5liPo1Lk4ACAWScfIO4op9xi4y55mogE5Urv6MO3hpP4IlbdtgoDsbmYYdB6C7ovPNLH
         D/t/rzX6gaZHdxmRZIuY0Ypstslmd1IspgOwtR6aB2vZt2dxz8+J/madxXiIVehW/ytS
         TmDGm5+Peypf7yd29lmWJD4bJYqfWI65Kst34voBHsd1SBJB7Nm8AjeuxrvVV5WR0rr5
         dHcw==
X-Gm-Message-State: AC+VfDyAvVWwBT6nEy52wgO6aLhsaXOJCYksG1V4BPDWPs1BaHm4/iwy
	LRa9RqTHTZz+A6+Mxllq21M=
X-Google-Smtp-Source: ACHHUZ7J8Aas1J2Rc20jnb1KGckFkPjq+j4uXL85mWslpQ5/EpkOpe4cYomHtpe0qtAoy+AsMW7sBg==
X-Received: by 2002:a17:902:d349:b0:1a9:2823:dad3 with SMTP id l9-20020a170902d34900b001a92823dad3mr18355696plk.42.1683037482638;
        Tue, 02 May 2023 07:24:42 -0700 (PDT)
Received: from localhost (118-208-214-188.tpgi.com.au. [118.208.214.188])
        by smtp.gmail.com with ESMTPSA id x10-20020a170902b40a00b001ab05aaaf8fsm2012505plr.104.2023.05.02.07.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 07:24:41 -0700 (PDT)
Mime-Version: 1.0
Date: Wed, 03 May 2023 00:24:24 +1000
Message-Id: <CSBUZL6M3MSS.316JRNGXVMLB@wheely>
Subject: Re: [PATCH] Remove HAVE_VIRT_CPU_ACCOUNTING_GEN option
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Palmer Dabbelt" <palmer@dabbelt.com>
Cc: "Arnd Bergmann" <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <vgupta@kernel.org>,
 <linux-snps-arc@lists.infradead.org>, <bcain@quicinc.com>,
 <linux-hexagon@vger.kernel.org>, <chenhuacai@kernel.org>,
 <loongarch@lists.linux.dev>, <geert@linux-m68k.org>,
 <linux-m68k@lists.linux-m68k.org>, <monstr@monstr.eu>,
 <tsbogend@alpha.franken.de>, <linux-mips@vger.kernel.org>,
 <dinguyen@kernel.org>, <jonas@southpole.se>,
 <stefan.kristiansson@saunalahti.fi>, <shorne@gmail.com>,
 <linux-openrisc@vger.kernel.org>, <James.Bottomley@HansenPartnership.com>,
 <deller@gmx.de>, <linux-parisc@vger.kernel.org>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
 <linux-riscv@lists.infradead.org>, <ysato@users.sourceforge.jp>,
 <dalias@libc.org>, <glaubitz@physik.fu-berlin.de>,
 <linux-sh@vger.kernel.org>, <davem@davemloft.net>,
 <sparclinux@vger.kernel.org>, <richard@nod.at>,
 <anton.ivanov@cambridgegreys.com>, <johannes@sipsolutions.net>,
 <linux-um@lists.infradead.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
 <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
 <hpa@zytor.com>, <khilman@baylibre.com>, <frederic@kernel.org>
X-Mailer: aerc 0.14.0
References: <20230429063348.125544-1-npiggin@gmail.com>
 <mhng-7ec0443b-2201-41b7-996c-78c3a61f0230@palmer-ri-x1c9a>
In-Reply-To: <mhng-7ec0443b-2201-41b7-996c-78c3a61f0230@palmer-ri-x1c9a>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230502_072444_599573_E680969C 
X-CRM114-Status: GOOD (  24.10  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Sun Apr 30, 2023 at 6:14 AM AEST, Palmer Dabbelt wrote:
> On Fri, 28 Apr 2023 23:33:48 PDT (-0700), npiggin@gmail.com wrote:
> > This option was created in commit 554b0004d0ec4 ("vtime: Add
> > HAVE_VIRT_CPU_ACCOUNTING_GEN Kconfig") for architectures to indicate
> > they support the 64-bit cputime_t required for VIRT_CPU_ACCOUNTING_GEN.
> >
> > The cputime_t type has since been removed, so this doesn't have any
> > meaning. Remove it.
> >
> > Cc: linux-arch@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Vineet Gupta <vgupta@kernel.org>
> > Cc: linux-snps-arc@lists.infradead.org
> > Cc: Brian Cain <bcain@quicinc.com>
> > Cc: linux-hexagon@vger.kernel.org
> > Cc: Huacai Chen <chenhuacai@kernel.org>
> > Cc: loongarch@lists.linux.dev
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: linux-m68k@lists.linux-m68k.org
> > Cc: Michal Simek <monstr@monstr.eu>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: linux-mips@vger.kernel.org
> > Cc: Dinh Nguyen <dinguyen@kernel.org>
> > Cc: Jonas Bonn <jonas@southpole.se>
> > Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> > Cc: Stafford Horne <shorne@gmail.com>
> > Cc: linux-openrisc@vger.kernel.org
> > Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> > Cc: Helge Deller <deller@gmx.de>
> > Cc: linux-parisc@vger.kernel.org
> > Cc: Paul Walmsley <paul.walmsley@sifive.com>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Albert Ou <aou@eecs.berkeley.edu>
> > Cc: linux-riscv@lists.infradead.org
> > Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> > Cc: Rich Felker <dalias@libc.org>
> > Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > Cc: linux-sh@vger.kernel.org
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: sparclinux@vger.kernel.org
> > Cc: Richard Weinberger <richard@nod.at>
> > Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> > Cc: Johannes Berg <johannes@sipsolutions.net>
> > Cc: linux-um@lists.infradead.org
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: x86@kernel.org
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Kevin Hilman <khilman@baylibre.com>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> > Hi,
> >
> > Could we tidy this? I don't know what tree it can go in, timers,
> > sched, asm-generic, probably doesn't matter.
> >
> > The only thing this actually does is gate VIRT_CPU_ACCOUNTING_GEN and
> > NO_HZ_FULL so if your arch has some other issue that requires this
> > then the documentation needs to change. Any concerns from the archs?
> > I.e., 32-bit that does *not* define HAVE_VIRT_CPU_ACCOUNTING_GEN
> > which looks to be:
> >
> > arc
> > hexagon
> > loongarch 32-bit with SMP
> > m68k
> > microblaze
> > mips 32-bit with SMP
> > nios2
> > openrisc
> > parisc 32-bit
> > riscv 32-bit
>
> Nothing's jumping out, though I haven't tested this yet so I'm not 100%.  
> I assume this isn't aimed for this merge window, given the timing?  

No, maybe the next one though.

> Probably best to give this sort of thing time to bake in linux-next, but 
> I doubt anyone is even paying attention to rv32/NO_HZ_FULL so no big 
> deal either way on my end.
>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com> # RISC-V

Thanks,
Nick

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
