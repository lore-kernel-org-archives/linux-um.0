Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F04CED27C
	for <linux-um@archiver.kernel.org>; Tue,  8 Oct 2024 08:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TmLP/WI1VtrRBkIucS2941CxDdB37ieasR6WFFSWafs=; b=USi2x2gUy+K2tb6cjVuyDWjV0/
	iseZzlJbmgsFddC0EtHAtd9MBc6QEyQTTEk1BSUptPsRRn0Jvce1lUvYiJP1PUeOVRw9BzMMZPmNB
	ALip8JhpZVocGBYJxr48CTB/S1EFWBb5+H3SsRkr44ZewdL55Rs+GnPMB07jQfmweIl/xIYRXiHDw
	re+Jbd5c05wslcnEKg5LIdYEQU/6J7sRIYDBh4ZndKwmMJMwU9ZV/RTPU7UYelkZfGY+izKCHYEkX
	3Vtln8OUVkTFNpSkQn36P2BPxDWMCzDanqnQACXgTA93iLQKWZwc0zm021LD7aa3EU+LKKHnA7bze
	2qu+2Ocg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sy5nd-000000056Yw-1UlT;
	Tue, 08 Oct 2024 08:42:33 +0000
Received: from relay5-d.mail.gandi.net ([2001:4b98:dc4:8::225])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sy5eg-000000053ue-3GeC;
	Tue, 08 Oct 2024 08:33:24 +0000
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9EFBD1C000A;
	Tue,  8 Oct 2024 08:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728376392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TmLP/WI1VtrRBkIucS2941CxDdB37ieasR6WFFSWafs=;
	b=POSKCKOpM0S5Rro9I7JX/yFDGVQEbxnQfOlbhvDuVflBTc9b0oQzIQp7fKtzf6mJwdOQ+0
	Ea9yaFhepRPa3MqaYNcDO/VEW6QLHJqANEHtweXO5D876vZq8tICxDlfjrmrbTDnklWsBz
	0pAYroBCDAgXQON2fmL69ED1dgdlzDy5jho/yQO5tqH0EdwHwUBc86MuNxTZZ0aBcTJr+T
	UHYVDWD5LAAELveRyE4v2cHZeoPtNyyU8w7VYOZiIGEcGGrpmUancBz/ZYPglMSFDCCVy6
	Izc1kwXhCGbPtsztfFaqEyh0UYZq966m3DrL4DrW+CqDmsEUQlcF0xSAXpcASQ==
Date: Tue, 8 Oct 2024 10:33:06 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Julian Vetter <jvetter@kalrayinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Guo Ren <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG
 Xuerui <kernel@xen0n.name>, Andrew Morton <akpm@linux-foundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Richard Henderson
 <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, "James E . J . Bottomley"
 <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Richard
 Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Niklas
 Schnelle <schnelle@linux.ibm.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-alpha@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-sound@vger.kernel.org, Yann Sionneau
 <ysionneau@kalrayinc.com>
Subject: Re: [PATCH v8 13/14] mtd: Add HAS_IOMEM || INDIRECT_IOMEM
 dependency
Message-ID: <20241008103306.44123824@xps-13>
In-Reply-To: <20241008075023.3052370-14-jvetter@kalrayinc.com>
References: <20241008075023.3052370-1-jvetter@kalrayinc.com>
	<20241008075023.3052370-14-jvetter@kalrayinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_013321_080595_B73E660E 
X-CRM114-Status: GOOD (  18.34  )
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

Hi Julian,

jvetter@kalrayinc.com wrote on Tue,  8 Oct 2024 09:50:21 +0200:

> The UM arch doesn't have HAS_IOMEM=3Dy, so the build fails because the
> functions memcpy_fromio and memcpy_toio are not defined anymore. These
> functions are only build for targets which have HAS_IOMEM=3Dy or
> INDIRECT_IOMEM=3Dy. So, depend on either of the two.

There are many mtd drivers using memcpy_fromio and memcpy_toio, I'm not
sure I get why only this subset of drivers would be impacted?

Also, from a general standpoint, I don't see with a good eye the
proliferation of the use of || INDIRECT_IOMEM just for the um
architecture:

$ git grep HAS_IOMEM | wc -l
611
$ git grep INDIRECT_IOMEM | wc -l
15

I believe the Kconfig symbol should adapt to reflect the fact that IO
operations are fine, regardless of their type ("direct" or "indirect")
rather than move the load on the individual drivers.

> Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
> Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
> ---
> Changes for v8:
> - New patch
> ---
>  drivers/mtd/chips/Kconfig | 4 ++++
>  drivers/mtd/lpddr/Kconfig | 1 +
>  2 files changed, 5 insertions(+)
>=20
> diff --git a/drivers/mtd/chips/Kconfig b/drivers/mtd/chips/Kconfig
> index 19726ebd973d..78afe7ccf005 100644
> --- a/drivers/mtd/chips/Kconfig
> +++ b/drivers/mtd/chips/Kconfig
> @@ -4,6 +4,7 @@ menu "RAM/ROM/Flash chip drivers"
> =20
>  config MTD_CFI
>  	tristate "Detect flash chips by Common Flash Interface (CFI) probe"
> +	depends on HAS_IOMEM || INDIRECT_IOMEM
>  	select MTD_GEN_PROBE
>  	select MTD_CFI_UTIL
>  	help
> @@ -16,6 +17,7 @@ config MTD_CFI
> =20
>  config MTD_JEDECPROBE
>  	tristate "Detect non-CFI AMD/JEDEC-compatible flash chips"
> +	depends on HAS_IOMEM || INDIRECT_IOMEM
>  	select MTD_GEN_PROBE
>  	select MTD_CFI_UTIL
>  	help
> @@ -211,12 +213,14 @@ config MTD_CFI_UTIL
> =20
>  config MTD_RAM
>  	tristate "Support for RAM chips in bus mapping"
> +	depends on HAS_IOMEM || INDIRECT_IOMEM
>  	help
>  	  This option enables basic support for RAM chips accessed through
>  	  a bus mapping driver.
> =20
>  config MTD_ROM
>  	tristate "Support for ROM chips in bus mapping"
> +	depends on HAS_IOMEM || INDIRECT_IOMEM
>  	help
>  	  This option enables basic support for ROM chips accessed through
>  	  a bus mapping driver.
> diff --git a/drivers/mtd/lpddr/Kconfig b/drivers/mtd/lpddr/Kconfig
> index 0395aa6b68f1..f35dd8052abc 100644
> --- a/drivers/mtd/lpddr/Kconfig
> +++ b/drivers/mtd/lpddr/Kconfig
> @@ -4,6 +4,7 @@ menu "LPDDR & LPDDR2 PCM memory drivers"
> =20
>  config MTD_LPDDR
>  	tristate "Support for LPDDR flash chips"
> +	depends on HAS_IOMEM || INDIRECT_IOMEM
>  	select MTD_QINFO_PROBE
>  	help
>  	  This option enables support of LPDDR (Low power double data rate)


Thanks,
Miqu=C3=A8l

