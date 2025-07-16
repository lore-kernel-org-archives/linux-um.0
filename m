Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D59C83F1B
	for <linux-um@archiver.kernel.org>; Wed, 16 Jul 2025 23:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DeMkf81B5yNrigfNCgydML/LD6DZlbT9djSrJqCL3NI=; b=dTIHA6y/2EFR7/3xXQP+Kyv3z5
	Uz2oyoMYPB6HuQJeD9PILChIPpl/Cp1U3H2H4bAKQL2Ja8RfYmy7/Pkn8dYjNi9kYdEjGNq0G0abQ
	WAPhad5d8SuitAPvgvGFA8RxhxAdNTzWj1wy5wgwreZLOhAuF/tOJLF8GzATH/9wtvvEHD6Xp8gJ3
	yPDybn639z/38snlGdVTHXV2LlgFhlegPCS9LU04IyP8oyjDRMiNTrYIHj4EnGejPLb80L+ZAjkjH
	gh3HpSDj/pvnIufSXMPWM4W5Aq1VrFc0p0z4g9aUoAOkSp+YnwmT7tirCdHXhaTS1usTD5YwPYmQx
	iIzKtUFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucBDy-00000008qNw-3ywu;
	Wed, 16 Jul 2025 23:07:42 +0000
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucBDw-00000008qNf-0YZ9;
	Wed, 16 Jul 2025 23:07:40 +0000
Message-ID: <4a6fd102-f8e0-42f3-b789-6e3340897032@infradead.org>
Date: Wed, 16 Jul 2025 16:07:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Jul 16 (drivers/vfio/cdx/intr.c)
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-um@lists.infradead.org, Linux KVM <kvm@vger.kernel.org>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250716212558.4dd0502b@canb.auug.org.au>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250716212558.4dd0502b@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 7/16/25 4:25 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20250715:
> 

on ARCH=um SUBARCH=x86_64:

../drivers/vfio/cdx/intr.c: In function ‘vfio_cdx_msi_enable’:
../drivers/vfio/cdx/intr.c:41:15: error: implicit declaration of function ‘msi_domain_alloc_irqs’; did you mean ‘msi_domain_get_virq’? [-Wimplicit-function-declaration]
   41 |         ret = msi_domain_alloc_irqs(dev, MSI_DEFAULT_DOMAIN, nvec);
      |               ^~~~~~~~~~~~~~~~~~~~~
      |               msi_domain_get_virq
../drivers/vfio/cdx/intr.c: In function ‘vfio_cdx_msi_disable’:
../drivers/vfio/cdx/intr.c:135:9: error: implicit declaration of function ‘msi_domain_free_irqs_all’ [-Wimplicit-function-declaration]
  135 |         msi_domain_free_irqs_all(dev, MSI_DEFAULT_DOMAIN);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~


Those missing functions are provided by CONFIG_GENERIC_MSI_IRQ
(which is not set).

Should VFIO_CDX select GENERIC_MSI_IRQ or just not build on ARCH=um?


-- 
~Randy


