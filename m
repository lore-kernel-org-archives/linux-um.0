Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95253CAC592
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 16:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f+sTjpO0cIpsChCn8JbuHptxP7HKcKjnaPUPmSOiAZ4=; b=aEAT6diVgexqCqyvHsdeWiyPkg
	5zp1G5Gx1W+nrdt/itQUFHGjO4DhUzNOjUU4kRKzGo4kSGsXPp6OOUswHdluF59qHlZeIV0lgisLY
	udsxYRCdZtECF9jzRDgHZ6nuh03Kdxu/NVgNvQ6J0pxW6UFwMXPjbidgGVCQBeRgnHntEekkSmZdQ
	qn+2FI+st/+ZPKtSrTxBdGuaoWck4SUAJ2JEeC8hZGBVjlBhd1OnFre1nBOSE7dWCL0+G64r4MgoL
	AkoX/Ct1teY8zgI6IPAIAFwhCfu6obLLrBCNcps6CJVWu4HlY8v5jAFz3+p+f0sLEaMXfMWu2d2/Y
	OzM8YCgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyC4m-000000057I8-0nwp;
	Mon, 15 Sep 2025 16:29:12 +0000
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyC4j-000000057GQ-3dYg
	for linux-um@lists.infradead.org;
	Mon, 15 Sep 2025 16:29:11 +0000
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-88432e1af6dso379783539f.2
        for <linux-um@lists.infradead.org>; Mon, 15 Sep 2025 09:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1757953748; x=1758558548; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f+sTjpO0cIpsChCn8JbuHptxP7HKcKjnaPUPmSOiAZ4=;
        b=EBf/2LrYkXw6SqImG0CcxHw4asj9UNf2bISXn+mKO+XKL2q1QsVo736VDOyzH3zG66
         CI3I+JKebk+qZLei400uX8ktOMGr/wSjTrAd+fTBQedvqC5bD0iCjCJaQ0+qdU1CBDjL
         vLTQU7Pf+U7cgVUthWrFHVWyqYi0HbFU6+VD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757953748; x=1758558548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f+sTjpO0cIpsChCn8JbuHptxP7HKcKjnaPUPmSOiAZ4=;
        b=r+vWTnNkhulXLK/Ax1oUcDaIuv/eqa0zenP+PnewIX1Q3/0Su8zEJNHJI5yB6mKuFM
         bKqtL3Km8OdVff7LkTpL800Uy4qAS9grvpqEONDs3ccHdcLQd03Bd7s6NxfM7F8z9kg3
         8IA7pMAGQKRhA0QJRzxiDtvyL4R6o2atup63tNjxE19xpaw30yjuyC4LgJF3ozJUlE9R
         Torfi6lMbxgCmPmulvYG6llD9RxTemavHaa2hckzBvQe1kv+uL71ATv92XGK49cn7BDR
         RtNlcwU5vPqWqLpxGrVlZICJ6MiCUg0yMXkQ+g3K0A/jOqcjzh1vwnH1y3lWFc+2Fa3K
         WhOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6+RWNfwCqZq07A1tPBNFT1YqrsqBk95sYm4sahNMz0mj0nhGEpjwD74JnPPU6FYU0tegfqv/hsQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yynsy/V9lAj7pI8EoljULtEj4CCXVHZFHbFC+AX1bJwSO6i+psa
	/JJmnp3i7bvTrSRK2cFrB++roC2CnxaqPy8Emu/Ah2tkQJxxMnz40NiIIHOzkQg/Xcw=
X-Gm-Gg: ASbGncvuThaSHWUqIbgPV8awOpi7MExUOtrVPLYE+U0wp9FuTHidLFuVfGolrQ5mm7f
	6HmhwYeN/hOh1+O83W4CmY9LYn/FYTdfqJRa4bhhAwmQQx2k/9T+BDUE86aY/nSul1jrASM1zjZ
	yNKHd4yqr9yyN/dyF2RvH/vNg0d2KzNvg1gEgpvkhTRUJbpUjFWeAxCQdd1RC0vXcyKJXWFlxdU
	qhVs+uEUZD7yGpUKEabDTFZ7lw+Z7Rb2G8vyP32Kre/AO/v26zdaa0eXpSss7EJImqonWUnuaVr
	vIvTroM1OaQHWhjVzn+zsPircY8RsBivaZeTB4gJWsxtazvFL4TG6qs3H7QRHAJUTPXBxm7dvdz
	SkPm2kqBR45QhSvOxWAEZCBz+MfOGWoP4miYL/s1nU9hkARY=
X-Google-Smtp-Source: AGHT+IEJzZF0BGCbIvlEszdewtPyiyEjXRaiR+hdFvugN44tYVhlRO+VJIO/vMCzUnVJIaBknAPoVg==
X-Received: by 2002:a05:6602:140f:b0:887:48b8:fe74 with SMTP id ca18e2360f4ac-89034dd42c9mr1343262539f.17.1757953747088;
        Mon, 15 Sep 2025 09:29:07 -0700 (PDT)
Received: from [10.212.145.175] ([12.216.155.19])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-88f2f6c62a5sm465640039f.22.2025.09.15.09.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 09:29:06 -0700 (PDT)
Message-ID: <3dc95227-2be9-48a0-bdea-3f283d9b2a38@linuxfoundation.org>
Date: Mon, 15 Sep 2025 10:29:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2] kunit: Enable PCI on UML without triggering
 WARN()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
References: <20250908-kunit-uml-pci-v2-1-d8eba5f73c9d@linutronix.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250908-kunit-uml-pci-v2-1-d8eba5f73c9d@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_092909_939100_9713B614 
X-CRM114-Status: GOOD (  23.33  )
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

On 9/8/25 01:03, Thomas Weißschuh wrote:
> Various KUnit tests require PCI infrastructure to work. All normal
> platforms enable PCI by default, but UML does not. Enabling PCI from
> .kunitconfig files is problematic as it would not be portable. So in
> commit 6fc3a8636a7b ("kunit: tool: Enable virtio/PCI by default on UML")
> PCI was enabled by way of CONFIG_UML_PCI_OVER_VIRTIO=y. However
> CONFIG_UML_PCI_OVER_VIRTIO requires additional configuration of
> CONFIG_UML_PCI_OVER_VIRTIO_DEVICE_ID or will otherwise trigger a WARN() in
> virtio_pcidev_init(). However there is no one correct value for
> UML_PCI_OVER_VIRTIO_DEVICE_ID which could be used by default.
> 
> This warning is confusing when debugging test failures.
> 
> On the other hand, the functionality of CONFIG_UML_PCI_OVER_VIRTIO is not
> used at all, given that it is completely non-functional as indicated by
> the WARN() in question. Instead it is only used as a way to enable
> CONFIG_UML_PCI which itself is not directly configurable.
> 
> Instead of going through CONFIG_UML_PCI_OVER_VIRTIO, introduce a custom
> configuration option which enables CONFIG_UML_PCI without triggering
> warnings or building dead code.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
> ---
> Changes in v2:
> - Rebase onto v6.17-rc1
> - Pick up review from Johannes
> - Link to v1: https://lore.kernel.org/r/20250627-kunit-uml-pci-v1-1-a622fa445e58@linutronix.de
> ---
>   lib/kunit/Kconfig                           | 7 +++++++
>   tools/testing/kunit/configs/arch_uml.config | 5 ++---
>   2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> index c10ede4b1d2201d5f8cddeb71cc5096e21be9b6a..1823539e96da30e165fa8d395ccbd3f6754c836e 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -106,4 +106,11 @@ config KUNIT_DEFAULT_TIMEOUT
>   	  If unsure, the default timeout of 300 seconds is suitable for most
>   	  cases.
>   
> +config KUNIT_UML_PCI
> +	bool "KUnit UML PCI Support"
> +	depends on UML
> +	select UML_PCI
> +	help
> +	  Enables the PCI subsystem on UML for use by KUnit tests.

I am applying this patch for 6.18-rc1.

Please send a patch to fix the following warning on top of this one based
on

https://web.git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=kunit

WARNING: please write a help paragraph that fully describes the config symbol with at least 4 lines
#136: FILE: lib/kunit/Kconfig:109:
+config KUNIT_UML_PCI
+	bool "KUnit UML PCI Support"
+	depends on UML
+	select UML_PCI
+	help
+	  Enables the PCI subsystem on UML for use by KUnit tests.

thanks,
-- Shuah

