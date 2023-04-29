Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA5AC7EE23
	for <linux-um@archiver.kernel.org>; Sat, 29 Apr 2023 20:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Mime-Version:Message-ID:To:From:CC:In-Reply-To:
	Subject:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=xt50aFKYKjIp9F3IBPaj2F/z6YzcJGPhXOWtb7YN838=; b=tWIIOMxg7Ti1lXXRtNODSIF5ro
	Nlri2wjmC2I3882ndcyMBYYc692+0tESpxCO1qcQIv+32bujmtdqvhLQ+1f+oOJA52o1H89ZS4EO1
	w9UfvocVsj1srOnfnL33puQmujAROOVdOMYa4J/dEKqZxD2oprzCQrIMKHi1N+uVdIbSBg63O+Tno
	zI1QSmsNLSY15VcKZwd+aeww2IVWBusvwwfWSg4QjdXS98H8ERHaaizNq41QiOfADwGq+rBNPkIe9
	qRwMQK/K4gEHoMXGO2gSFI3b1dTXR2p1w2JAD3r+fvrUPOrxBouxnO2afwxWt1WEzCmnuIxVmcPzT
	n9dI+rsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1psqxg-00D5tu-1Q;
	Sat, 29 Apr 2023 20:14:28 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1psqxd-00D5t3-2L
	for linux-um@lists.infradead.org;
	Sat, 29 Apr 2023 20:14:27 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-247048f86c7so832725a91.2
        for <linux-um@lists.infradead.org>; Sat, 29 Apr 2023 13:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1682799264; x=1685391264;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EvNXrGU7f9AyBgQxPAxIH8w5LQ2sGDY5VhYCeQmIsvg=;
        b=ztXNyujPGJ3TImj9rkWYO2n2FifWKitTQShNykqcCXMnlMDmDVUdGDZxkkAjoc2LxT
         wjlkNuWu5MpGZ0hx2IY/BfGicm00cVl+x8sMPYhvJYOTMhGVFNRcq+t2+IhK1Zbg1HBm
         TwPyb5IfXHXgdYm4kQQJO8mCutMWnoA0MAQG1HObQV2DkWdvKA82EPwFFy15NEoVvzDJ
         YaFLlQv2/hnRBo+Kg2l+LFcBMREq5GVfs5levwZlW+i9w9qFVpvKUrXtIKJRJqUd1KUC
         DRDHp5Z7Fs9kgbXLfeVSACxaLJ8vDKqbLXNf+pwsIg4BCZFLNo8FmqNy+hScbEds+O2l
         SL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682799264; x=1685391264;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvNXrGU7f9AyBgQxPAxIH8w5LQ2sGDY5VhYCeQmIsvg=;
        b=fCj3n/4+RdwMDUEUojcUfQsmVqon5mQ2UuX6xmsTGzMpeeUYWZsGXK6/BRCAQtzsoz
         ib0hgs8bmE5NBohZySvjTGfikmQH9x1zvtjaXgzmRSBHN0h5nUKnhSAr16r6CmS1zCa9
         p4GZ//9JoLn7wcskII12JrzGnlYITCweua7Ea7vZWQpMAWDvBGC0QdAIjWUOhAAy2FIM
         wMn4C2mkOOZRmdPaqLEDqcmRnNw7jZiRiv9uHh3ZteuLReyZr8Y/ZRWcd/9OXd/PGw1S
         PFNooyG4s++izN2W+8BZDZ6GR4wXaoU79k6CizehvWIlkBKvsZq2xzfRM+XbKxOcAP3b
         A7Fg==
X-Gm-Message-State: AC+VfDx4esXFxisuBlAbj4Sa6OoRE718NXGD57gxBOg0G8RgP9ebLtl4
	aBOQ+8N+uEBqxm7U438HtqcCVg==
X-Google-Smtp-Source: ACHHUZ7pgoIToYashe1bFzQ1hUq7/0xuSIbhdV55MwhX+AUZI7FSn+oK96sUBgsJukxkcTmiriVdYg==
X-Received: by 2002:a17:902:ef45:b0:1a6:dd9a:62c5 with SMTP id e5-20020a170902ef4500b001a6dd9a62c5mr8875345plx.10.1682799264493;
        Sat, 29 Apr 2023 13:14:24 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902740200b001a4f7325466sm15179442pll.276.2023.04.29.13.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:14:23 -0700 (PDT)
Date: Sat, 29 Apr 2023 13:14:23 -0700 (PDT)
X-Google-Original-Date: Sat, 29 Apr 2023 13:14:07 PDT (-0700)
Subject: Re: [PATCH] Remove HAVE_VIRT_CPU_ACCOUNTING_GEN option
In-Reply-To: <20230429063348.125544-1-npiggin@gmail.com>
CC: Arnd Bergmann <arnd@arndb.de>, npiggin@gmail.com, linux-arch@vger.kernel.org,
  linux-kernel@vger.kernel.org, vgupta@kernel.org, linux-snps-arc@lists.infradead.org, bcain@quicinc.com,
  linux-hexagon@vger.kernel.org, chenhuacai@kernel.org, loongarch@lists.linux.dev, geert@linux-m68k.org,
  linux-m68k@lists.linux-m68k.org, monstr@monstr.eu, tsbogend@alpha.franken.de, linux-mips@vger.kernel.org,
  dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
  linux-openrisc@vger.kernel.org, James.Bottomley@HansenPartnership.com, deller@gmx.de,
  linux-parisc@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
  linux-riscv@lists.infradead.org, ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de,
  linux-sh@vger.kernel.org, davem@davemloft.net, sparclinux@vger.kernel.org, richard@nod.at,
  anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, linux-um@lists.infradead.org, tglx@linutronix.de,
  mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
  khilman@baylibre.com, frederic@kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: npiggin@gmail.com
Message-ID: <mhng-7ec0443b-2201-41b7-996c-78c3a61f0230@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230429_131425_786546_B68A3131 
X-CRM114-Status: GOOD (  20.59  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Fri, 28 Apr 2023 23:33:48 PDT (-0700), npiggin@gmail.com wrote:
> This option was created in commit 554b0004d0ec4 ("vtime: Add
> HAVE_VIRT_CPU_ACCOUNTING_GEN Kconfig") for architectures to indicate
> they support the 64-bit cputime_t required for VIRT_CPU_ACCOUNTING_GEN.
>
> The cputime_t type has since been removed, so this doesn't have any
> meaning. Remove it.
>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Vineet Gupta <vgupta@kernel.org>
> Cc: linux-snps-arc@lists.infradead.org
> Cc: Brian Cain <bcain@quicinc.com>
> Cc: linux-hexagon@vger.kernel.org
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: loongarch@lists.linux.dev
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: linux-mips@vger.kernel.org
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: linux-openrisc@vger.kernel.org
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-parisc@vger.kernel.org
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: linux-um@lists.infradead.org
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> Hi,
>
> Could we tidy this? I don't know what tree it can go in, timers,
> sched, asm-generic, probably doesn't matter.
>
> The only thing this actually does is gate VIRT_CPU_ACCOUNTING_GEN and
> NO_HZ_FULL so if your arch has some other issue that requires this
> then the documentation needs to change. Any concerns from the archs?
> I.e., 32-bit that does *not* define HAVE_VIRT_CPU_ACCOUNTING_GEN
> which looks to be:
>
> arc
> hexagon
> loongarch 32-bit with SMP
> m68k
> microblaze
> mips 32-bit with SMP
> nios2
> openrisc
> parisc 32-bit
> riscv 32-bit

Nothing's jumping out, though I haven't tested this yet so I'm not 100%.  
I assume this isn't aimed for this merge window, given the timing?  
Probably best to give this sort of thing time to bake in linux-next, but 
I doubt anyone is even paying attention to rv32/NO_HZ_FULL so no big 
deal either way on my end.

Acked-by: Palmer Dabbelt <palmer@rivosinc.com> # RISC-V

> sh
> sparc 32-bit
> um 32-bit
> x86 32-bit
>
> Thanks,
> Nick

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
