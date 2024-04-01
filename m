Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CB2CD1288
	for <linux-um@archiver.kernel.org>; Mon,  1 Apr 2024 11:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=REYLSSPl3HAZZ6VAY/+hq9TrYv8ZstlMccIloC6fHHA=; b=iE3zitX/iWhiAoi7BFFccix7jB
	pHFgDiVHxHgri2mCv1LvbX6TtKC2XLaw8inqC+ANHtowQZeGJYjZLFxl7cl3iXVkbwfP189GCNYWC
	115ipIuiHIOw1RNSNJ2zreyfwx6NVo0uHE54aWJOVSKSww3wV36PUHYDOBVg4RAh46szxXkYrg6oC
	nVPttEIxAd18X4eFuVIkcC278e0NTXLgfb5EId/khC7XTylGKfUOmLvpTDuj6YMwh/XKuTYmGo0HC
	9eR0ETXfxxXX16W57Bx6oEOVoYwGLlPNRDd2JodK9nvt2xTOIL88p1x+j6qPknA3hqasxXSiHwRIt
	Sz0EmZCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrFTS-00000007WrW-2P3D;
	Mon, 01 Apr 2024 11:05:10 +0000
Received: from out0-218.mail.aliyun.com ([140.205.0.218])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrFTO-00000007Wq1-0URt
	for linux-um@lists.infradead.org;
	Mon, 01 Apr 2024 11:05:08 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047202;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---.X.JOBTr_1711969484;
Received: from 30.230.81.244(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.X.JOBTr_1711969484)
          by smtp.aliyun-inc.com;
          Mon, 01 Apr 2024 19:04:51 +0800
Message-ID: <39038eba-ecd7-4332-b7a0-bfd2c963f5ef@antgroup.com>
Date: Mon, 01 Apr 2024 19:04:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] um: Enable preemption in UML
To: anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Cc: richard@nod.at, johannes@sipsolutions.net
References: <20240328195038.1403093-1-anton.ivanov@cambridgegreys.com>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <20240328195038.1403093-1-anton.ivanov@cambridgegreys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240401_040506_395203_3A05DD11 
X-CRM114-Status: UNSURE (   6.21  )
X-CRM114-Notice: Please train this message.
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

On 3/29/24 3:50 AM, anton.ivanov@cambridgegreys.com wrote:
[...]
> +
> +void kernel_fpu_begin(void)
> +{
> +	preempt_disable();
> +
> +	WARN_ON(this_cpu_read(in_kernel_fpu));
> +
> +	this_cpu_write(in_kernel_fpu, true);
> +
> +#ifdef CONFIG_64BIT
> +	if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVEOPT)))
> +		__builtin_ia32_xsaveopt64(&current_thread_info()->aux_fp_regs, KNOWN_387_FEATURES);
> +	else if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVE)))
> +			__builtin_ia32_xsave64(&current_thread_info()->aux_fp_regs, KNOWN_387_FEATURES);

Only need two levels of indentation (i.e. two tabs) here.

> +	else
> +		__builtin_ia32_fxsave64(&current_thread_info()->aux_fp_regs);
> +#else
> +	if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVEOPT)))
> +		__builtin_ia32_xsaveopt(&current->aux_fp_regs, KNOWN_387_FEATURES);
> +	else if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVE)))
> +			__builtin_ia32_xsave(&current->aux_fp_regs, KNOWN_387_FEATURES);

Ditto.

> +	else
> +		__builtin_ia32_fxsave(&current->aux_fp_regs);
> +#endif
> +}
> +EXPORT_SYMBOL_GPL(kernel_fpu_begin);
> +
[...]
>  
> @@ -466,6 +475,8 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
>  
>  	address &= PAGE_MASK;
>  
> +	preempt_disable();
> +
>  	pgd = pgd_offset(mm, address);
>  	if (!pgd_present(*pgd))
>  		goto kill;
> @@ -520,6 +531,7 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
>  
>  	*pte = pte_mkuptodate(*pte);
>  
> +	preempt_enable();
>  	return;
>  
>  kill:

Preemption isn't enabled in the error path.

Regards,
Tiwei

