Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D76FC54E64
	for <linux-um@archiver.kernel.org>; Thu, 28 Mar 2024 14:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p0xtxm8qaQeod5CvMerKJ67YGof9TwVw9ygd6+yikuo=; b=xu5Sh3FuN1PPbHi8ecKZk+d0md
	Hgs4OpoWSLhRXyshD1KhMa0zVLhSMlEPwfiCD474ER9rLO4BblD/JSDqUrcG2z4xd4I1nKofd8wWI
	RqKH0712DMiaFOCAseT9NbiQj4hqjlZtw+hxIbl4dezG3S+CVD7lH3EELm54gmd9DNRq9AiM//HDR
	PCI95ppRjNYTePnfs6AOJ1+XBZxor/Ol+t7DIg/SmJ+4M5rrVPm0GN/x5Ei8000PJW6SE1++jjCTY
	Bx282P67QfCZUQOVbekpJ4jb4EZCiYUlGcinYuTTKH6wMUPJH5DsotRr0r88z1ExzL2Y/EYUsnuss
	OSzyEJ8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpqvR-0000000EMb1-3hVW;
	Thu, 28 Mar 2024 14:40:17 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpqvO-0000000EMaB-3PNp
	for linux-um@lists.infradead.org;
	Thu, 28 Mar 2024 14:40:16 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1rpqvL-00FZuk-9Z; Thu, 28 Mar 2024 14:40:11 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1rpqvG-005LNP-2g;
	Thu, 28 Mar 2024 14:40:10 +0000
Message-ID: <8fadcc0e-2587-4628-bfb9-8794ef01cac3@cambridgegreys.com>
Date: Thu, 28 Mar 2024 14:40:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] um: Enable preemption in UML
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: richard@nod.at
References: <20230928091042.1422353-1-anton.ivanov@cambridgegreys.com>
 <4ffdc415c692236dc13302b5fc0290316a17b7cc.camel@sipsolutions.net>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <4ffdc415c692236dc13302b5fc0290316a17b7cc.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_074014_888211_A9C3DF72 
X-CRM114-Status: GOOD (  14.47  )
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



On 28/03/2024 09:27, Johannes Berg wrote:
> 
>> @@ -23,7 +23,7 @@ struct thread_info {
>>   	int			preempt_count;  /* 0 => preemptable,
>>   						   <0 => BUG */
>>   	struct thread_info	*real_thread;    /* Points to non-IRQ stack */
>> -	unsigned long aux_fp_regs[FP_SIZE];	/* auxiliary fp_regs to save/restore
>> +	unsigned long aux_fp_regs[FP_SIZE] __aligned(64);	/* auxiliary fp_regs to save/restore
>>   						   them out-of-band */
> 
> nit: that comment looks strange now, maybe pull it up before the member?
> 
>   /* auxiliary ... out-of-band */
>   unsigned long aux_fp_regs[...] __aligned(64);
> 

Ack.

> 
>> +#ifdef CONFIG_64BIT
>> +	if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVEOPT)))
>> +		__builtin_ia32_xsaveopt64(&current_thread_info()->aux_fp_regs, KNOWN_387_FEATURES);
>> +	else {
>> +		if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVE)))
>> +			__builtin_ia32_xsave64(&current_thread_info()->aux_fp_regs, KNOWN_387_FEATURES);
>> +		else
>> +			__builtin_ia32_fxsave64(&current_thread_info()->aux_fp_regs);
>> +	}
> 
> Why not write this as a chain?
> 
> 	if (likely(cpu_has(...))
> 		__builtin_ia32_xsaveopt64(...);
> 	else if (likely(cpu_has(...)))
> 		__builtin_ia32_xave64(...);
> 	else
> 		__builtin_ia32_fxsave64(...);
> 
> 
> and IMHO pulling the "&current_thread_info()->aux_fp_regs" that appears
> on all three of them into a local variable would make that more readable
> too.

Ack.

> 
>> +#else
>> +	if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVEOPT)))
>> +		__builtin_ia32_xsaveopt(&current->aux_fp_regs, KNOWN_387_FEATURES);
>> +	else {
>> +		if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVE)))
>> +			__builtin_ia32_xsave(&current->aux_fp_regs, KNOWN_387_FEATURES);
>> +		else
>> +			__builtin_ia32_fxsave(&current->aux_fp_regs);
>> +	}
>> +#endif
> 
> And all of the above also applies for 32-bit,

Ack.

> 
>> +void kernel_fpu_end(void)
> 
> and this as well.
> 
> johannes
> 
> 

Will fix, rebase, retest and resubmit.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

