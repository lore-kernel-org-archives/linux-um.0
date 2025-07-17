Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B18C83F1B
	for <linux-um@archiver.kernel.org>; Thu, 17 Jul 2025 06:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GAKiwOJ1iHtP7/BKK42T12euA+Mx9VznVRPmGcAF52s=; b=DEPlMgXwdq7dOhIPZBUU85HtN7
	W02RHEyNsY/mClGiW3wS5w5LDMD9X0BPVQexLAwEU4BzTEtfcvPUT1dVtQgdR4CTXchxcvZVVza2L
	eb1LxAw5+F+aOvDoFaENf6uxN2ySYt5vvzG9T8XYzFsZWxSWWYBOTuk/Q/V8dRWI4rQPrIMB4JwJN
	w8jPB9QJeqP1Ov6Z1VYAnBxlH4VAXDhVdrJUn/hLopDrU2+ieC5qUQuWpr/+oshQGqA/vUOMvLupO
	3RRGT5zy3gdCXQA+uudNJ51XqsbotWe25B8VMaxAm5xO5t4BiEJ8RzkquGM2kNhGAP0qQiyrnN9ZC
	DtEmQ8lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucITS-00000009KtQ-34LE;
	Thu, 17 Jul 2025 06:52:10 +0000
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucITQ-00000009Ks0-0px7
	for linux-um@lists.infradead.org;
	Thu, 17 Jul 2025 06:52:09 +0000
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-6070a8f99ffso70832a12.3
        for <linux-um@lists.infradead.org>; Wed, 16 Jul 2025 23:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752735126; x=1753339926; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GAKiwOJ1iHtP7/BKK42T12euA+Mx9VznVRPmGcAF52s=;
        b=NqvW1JHbwDBzMpJWMwJuQLyWixaTVoacIyREbwEGVgAi0nZVwQnglFspL1CEqOvisd
         JJul1bXIyk31ft2W7u5U06rPev9HxXgvZi4AvlCAgxOh/2qGpyIKOEattPsFt1HLonMl
         gHDGxa/rv+JZ+LW2A9WVKDLdN5BYKOPX0gRsr0oLzN/6ZvWcQF1RVjcHF2m1/VQgoHNq
         Q+aKFk21hzTWO1cVnCRFr0jY+UamH8M79gsraWarCsjEY7qxinPqD+8IXSzFKyE3t72/
         AbqdX+0Hc9QIVlfkZ1qcDD1flB7m2QNTKX5MqDJlEn7EAYa1P7HlhpgLI1XOfIE6K8DA
         QRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752735126; x=1753339926;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GAKiwOJ1iHtP7/BKK42T12euA+Mx9VznVRPmGcAF52s=;
        b=B6p5XFcx6y2LsMskqj3SMnOjzhM/yTIYH4yetG1TDwQTBArEZF3e1vRxn0rjFu0Jxa
         BsMl+jZC/Ulp6qgfXXjM+6YJdAT88T0+xaCubpx3dncG4fqwBuH4KdIjZUvOnmZeT1RW
         FouytaO3guhryNSNrfi63W3k+SlKToDEWAc8tOueR0TAdEut5UliKzgDH51xZLfXV2kS
         rRAXS6360+vKRccTH+a0+7ej3nwqoMKSzXB8mptG+ziuoQZV6D3z+TR0STrT7r9spTma
         wVm+n+PVA4/YEHm8AAU0Shfrh8BuDDOBv6Y06BxL++vGrPWKc+rj/VQTAvgJn9LYMq2A
         AkDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9PVduShv7MqaQWgSBbcht+UZHfjXBfjh5Ct7As8yVKVGgZchfMGlsGOb969bmuVK64+w/jSXWjA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzc+vDXAuBgRMEsGblepXN5u0h/V9SdVc4w7EiSB01MwjA9xVhH
	iG2w6ezE3xfD6bVav+AU1f9ybqnvVCWiJ8KaL1d2hlyTxQz5C9YjgERFjTgVOPMHnSY=
X-Gm-Gg: ASbGncttwdVill3DhHqlIDrjzxvJax3lMjhHq6q/6WDXicMlkR3lTrRda9JpJHznfwG
	zb0tkQV8Em/zZeqnB31nz7IHWRnowVSgCQuiL8cItZxO431rMIN62Oo3eQBj/bTqp2DsbEG7sw3
	fZ36BDKZeF1We8GAFLba+EDX4bUFPV0vpdQExWjkKpFUt2ACIHMEIRJ52s2WMbxqLKBfGVlx5Bq
	X4lzp4pMNP1lOY0TxsEa5eA/RUprVpqvMgZTieCJLRYJFXNX3j1S07W2uPpl9Zq5tLB8VHZB2Qc
	gHfe7vpnlvSHSQVBfFYambWQ2LzWZfVnybLdWqcrPpOb5ww6h/8tBYX/CcY+eov5RUbx2t2E/TC
	wcYD/yihEDpiJUtg47P2e8L2g6nE/8YhcJ7IZIXmDv1QrQ/a/yRrs
X-Google-Smtp-Source: AGHT+IHDmHt87Z4pWyoF707n1KL/8xK3Tw04QOD37t7QY9/Fch26OgA/ABV9exObOWcKcNLXM/hzQQ==
X-Received: by 2002:a17:907:1b03:b0:ade:328a:95d1 with SMTP id a640c23a62f3a-ae9c9b21003mr213021966b.10.1752735126446;
        Wed, 16 Jul 2025 23:52:06 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec55e1e0dcsm41040566b.65.2025.07.16.23.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 23:52:05 -0700 (PDT)
Message-ID: <135b57cf-76bf-4ed1-8392-eec43711801b@linaro.org>
Date: Thu, 17 Jul 2025 08:52:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Jul 16 (drivers/vfio/cdx/intr.c)
To: Randy Dunlap <rdunlap@infradead.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-um@lists.infradead.org, Linux KVM <kvm@vger.kernel.org>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>
References: <20250716212558.4dd0502b@canb.auug.org.au>
 <4a6fd102-f8e0-42f3-b789-6e3340897032@infradead.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <4a6fd102-f8e0-42f3-b789-6e3340897032@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250716_235208_268917_DA705EAA 
X-CRM114-Status: GOOD (  11.32  )
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

On 17/07/2025 01:07, Randy Dunlap wrote:
> 
> 
> On 7/16/25 4:25 AM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20250715:
>>
> 
> on ARCH=um SUBARCH=x86_64:
> 
> ../drivers/vfio/cdx/intr.c: In function ‘vfio_cdx_msi_enable’:
> ../drivers/vfio/cdx/intr.c:41:15: error: implicit declaration of function ‘msi_domain_alloc_irqs’; did you mean ‘msi_domain_get_virq’? [-Wimplicit-function-declaration]
>    41 |         ret = msi_domain_alloc_irqs(dev, MSI_DEFAULT_DOMAIN, nvec);
>       |               ^~~~~~~~~~~~~~~~~~~~~
>       |               msi_domain_get_virq
> ../drivers/vfio/cdx/intr.c: In function ‘vfio_cdx_msi_disable’:
> ../drivers/vfio/cdx/intr.c:135:9: error: implicit declaration of function ‘msi_domain_free_irqs_all’ [-Wimplicit-function-declaration]
>   135 |         msi_domain_free_irqs_all(dev, MSI_DEFAULT_DOMAIN);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> Those missing functions are provided by CONFIG_GENERIC_MSI_IRQ
> (which is not set).
> 
> Should VFIO_CDX select GENERIC_MSI_IRQ or just not build on ARCH=um?


I think this will be also resolved with my change to select
GENERIC_MSI_IRQ by CDX_BUS, but to be fair, I think that VFIO_CDX should
also select GENERIC_MSI_IRQ. My reasoning is that:
1. GENERIC_MSI_IRQ is non-user selectable, thus it is supposed to be
selected by Kconfig entries
2. Every explicit user of a code should select such symbol, not rely on
someone else selecting it.

I will send a patch proposing this.

Best regards,
Krzysztof

