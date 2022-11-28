Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBB5C46467
	for <linux-um@archiver.kernel.org>; Mon, 28 Nov 2022 13:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:In-Reply-To:
	Subject:cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7hNkifqAc3SmKJOKaaLJcBoQLmhXyykX9sPtRS7uMU8=; b=Pdvm9Ybujql/CJALkEzJ+7JcRV
	Hsxc6qEFOAq11F9U2dJqinPYXg2VDdk2+D1xVK24ut+qW6/LmyLX23OLHDW0XGv/z2T8fkmZGMH3Q
	R/iRwHErbpQ8g2B4lPq3RTdDJliprXyi+aYJMcy7yJw2kCseI4UN8BwKzdNdRnboBl6o23nZOVkjk
	uLDrcm/MhZ60XtBOErOtbdxlrP0k68eC8w+GUA0qzfFmB5fsLYBJC/JY2BydCOY7ln/6fLaMuTrlq
	PaimD91UbhXDzllr9uZnEyqx47E/BE6oNTtOeiiD4/EcjTPFAFezv52dTqfEi3bNYgychXn2XqcT+
	dpGEL5eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozeYW-001zWn-Ay; Mon, 28 Nov 2022 13:52:20 +0000
Received: from albert.telenet-ops.be ([2a02:1800:110:4::f00:1a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozeYS-001zPJ-T5
	for linux-um@lists.infradead.org; Mon, 28 Nov 2022 13:52:19 +0000
Received: from ramsan.of.borg ([84.195.186.194])
	by albert.telenet-ops.be with bizsmtp
	id pps4280044C55Sk06ps4Bh; Mon, 28 Nov 2022 14:52:04 +0100
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.93)
	(envelope-from <geert@linux-m68k.org>)
	id 1ozeYF-001tsE-NU; Mon, 28 Nov 2022 14:52:03 +0100
Date: Mon, 28 Nov 2022 14:52:03 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To: linux-kernel@vger.kernel.org
cc: linux-um@lists.infradead.org, Taras Chornyi <tchornyi@marvell.com>, 
    netdev@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.1-rc7
In-Reply-To: <20221128134525.3580246-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2211281451020.453065@ramsan.of.borg>
References: <CAHk-=wgUZwX8Sbb8Zvm7FxWVfX6CGuE7x+E16VKoqL7Ok9vv7g@mail.gmail.com> <20221128134525.3580246-1-geert@linux-m68k.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221128_055217_097412_6534C027 
X-CRM114-Status: GOOD (  13.89  )
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

On Mon, 28 Nov 2022, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.1-rc7[1] to v6.1-rc6[3], the summaries are:
>  - build errors: +6/-0

   + /kisskb/src/arch/um/include/asm/processor-generic.h: error: called object is not a function or function pointer: 94:18 => 94:19, 94:18

um-x86_64-gcc12/um-all{mod,yes}config (in kfd_cpumask_to_apic_id(), seen
before with um-x86_64/um-all{mod,yes}config)

   + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: 'struct cpuinfo_um' has no member named 'x86_cache_size':  => 88:22
   + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: control reaches end of non-void function [-Werror=return-type]:  => 89:1
   + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: implicit declaration of function '__copy_user_nocache' [-Werror=implicit-function-declaration]:  => 100:2

um-x86_64/um-all{mod,yes}config (seen before on v6.1-rc4)

   + /kisskb/src/drivers/net/ethernet/marvell/prestera/prestera_flower.c: error: 'rule' is used uninitialized [-Werror=uninitialized]:  => 480:34
   + /kisskb/src/drivers/spi/spi-stm32-qspi.c: error: 'op' is used uninitialized [-Werror=uninitialized]:  => 523:27, 564:27

um-x86_64-gcc12/um-all{mod,yes}config

The latter looks completely bogus to me, unless there's a bug in the UML
implementation of memcpy() and memset(), which are used to initialize
"op".

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/b7b275e60bcd5f89771e865a8239325f86d9927d/ (all 152 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/eb7081409f94a9a8608593d0fb63a1aa3d6f95d8/ (149 out of 152 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
