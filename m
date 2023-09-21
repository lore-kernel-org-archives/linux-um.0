Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02544E706FD
	for <linux-um@archiver.kernel.org>; Thu, 21 Sep 2023 09:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3UFXHTPVL5lVW8Sgg4nPwvC5Vk6Yp5Q2j7vqcNOfWeI=; b=qP3C0gj8vKYbgV
	8vgCH41X4KBKHTIitgjBQkRd/5YeXIkd9tRLt+NfbqVyOUDmQKaTQFR02kibssiPyF51+oqqMGG42
	uVJC69m2EkT5zjMEhVediCj+7NrY37JBIbva0SRd3x4/tN6kOTLxI41XabgnDVX+ATRKZhDYGJLCn
	8QN3Vthpx3rZGi3Ccqpd+jDoTGOWrONOX2vofmAXq0dqPcTtzsB5fDD1Cha9MqvFOitV8wY5GveQZ
	P529bS52nEOtIyHUiZIix5Updil+E1ajeEeTCVIsH4hwneged5TZbqPPnsuF8X5xsezaLcNz2GKJf
	z66HTTRZU5tbGUaWLN+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjGCQ-005cQ4-0F;
	Thu, 21 Sep 2023 09:42:18 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjGCM-005cP6-21
	for linux-um@lists.infradead.org;
	Thu, 21 Sep 2023 09:42:16 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjGCK-002YMV-VX; Thu, 21 Sep 2023 09:42:13 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjGCI-000oP0-92; Thu, 21 Sep 2023 10:42:12 +0100
Message-ID: <ef73ff84-545a-b073-fcd5-87492828280a@cambridgegreys.com>
Date: Thu, 21 Sep 2023 10:42:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] um: Enable preemption in UML
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: richard@nod.at
References: <20230921092836.190291-1-anton.ivanov@cambridgegreys.com>
 <15376711a221bbeaf45a278f56b944dcc9b6f2cc.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <15376711a221bbeaf45a278f56b944dcc9b6f2cc.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_024214_667717_49332486 
X-CRM114-Status: GOOD (  24.86  )
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



On 21/09/2023 10:35, Johannes Berg wrote:
> Hi,
> 
> Haven't chimed in here before, but thanks for looking at this! I
> actually really wanted at least the things you get for debug from this
> in the past, so much appreciated.
> 
> I think I actually tried a simpler approach and it kind of even worked,
> but my userspace likely has very little FPU usage.
> 
> 
>> +/* UML knows about 387 features up to and including AVX512, tile, etc are not yet
>> + * supported.
>> + */
> 
> Do you ensure that somehow? Warn if it's there at least? I may have
> missed that.

We can if we want. We can just cut-off feature reflection into the kernel in the
setup. Presently it reflects all features. That can be filtered if we want to.
For example - x86 has boot flags to disable xrestore and xrestoreopt

> 
> Or is it just for the saving? But what if you don't save enough and the
> host CPU has more?

This is just for the saving. AFAIK no linux module touches _TILE and the other recent
fancy stuff. The host kernel source looks that way.

> 
> 
>> +void kernel_fpu_begin(void)
>> +{
>> +#if defined(PREEMPT) || defined(PREEMPT_VOLUNTRARY)
> 
> maybe leave it as an inline in case it'd be empty, i.e. neither of these
> are defined?
> 
>> +	preempt_disable();
>> +
>> +	WARN_ON(this_cpu_read(in_kernel_fpu));
>> +
>> +	this_cpu_write(in_kernel_fpu, true);
>> +
>> +#ifdef CONFIG_64BIT
>> +	if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVEOPT)))
>> +		__builtin_ia32_xsaveopt64(&current->thread.fpu, KNOWN_387_FEATURES);
>> +	else {
>> +		if (cpu_has(&boot_cpu_data, X86_FEATURE_XSAVE))
>> +			__builtin_ia32_xsave64(&current->thread.fpu, KNOWN_387_FEATURES);
>> +		else
>> +			__builtin_ia32_fxsave64(&current->thread.fpu);
>> +	}
> 
> nit: you could make all of these else if chains, and avoid the braces:
> 
> if (likely(...))
> 	...
> else if (cpu_has(...))
> 	...
> else
> 	...
> 
> 
>> +void kernel_fpu_end(void)
> 
> same comments as above apply here.
> 
> 
>>   void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
>>   {
>> +	preempt_disable();
>>   	_sigio_handler(regs, irqs_suspended);
>> +	preempt_enable();
>>
> 
> I may have to look at those time-travel bits here :)

Yes. I was going to ask you to double check if they all work as intended.

Basic use seems without tt seems OK.

> 
> Thanks,
> johannes
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
