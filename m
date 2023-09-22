Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53E4C04AAB
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 11:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JDPRzrYlXQIRxnadWErTLRrLmPku4lorBRMU3L6th9M=; b=seKd9nG2r78kLU
	f8YHWjN8bgLYjC7tZDmzHGcKhwJDf3HTeTquAWTIODETAVdUxIfig0xQmLt+ngy6k3SEfaPWqDZ2M
	VOsnCnj5BLVxNrsUxFjSAtqSw69/e+aFBPG+O1dDQOgeG8/GzArWEM7bVO2dJ2NM+BbsXkWDI+cwJ
	xTzHOJ4svy5jPLWmGVyfPCOvV14sevRyunemTMYW3yzgZPE5XEXNyqqb7WYWhzfZFcqHPc1xQcmhS
	XFkpNCna/W0laIgpg1G8X1CUJ6UIRbhgqDUk+qkoRWTuY+RcdIWgysFul/hBfGO5vz6BkPzXRjV42
	OlrJtockbmxeD0JP+IDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjekf-008zym-24;
	Fri, 22 Sep 2023 11:55:17 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjekc-008zyO-36
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 11:55:16 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjeka-002c15-Sk; Fri, 22 Sep 2023 11:55:13 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjekY-002Los-6e; Fri, 22 Sep 2023 12:55:12 +0100
Message-ID: <11be1452-9cca-2370-a5e2-a25380817866@cambridgegreys.com>
Date: Fri, 22 Sep 2023 12:55:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6] um: Enable preemption in UML
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: richard@nod.at
References: <20230922105609.545573-1-anton.ivanov@cambridgegreys.com>
 <389fbd9de31ccdaad52674b7de06312e57f2cd54.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <389fbd9de31ccdaad52674b7de06312e57f2cd54.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_045515_003022_8A83892B 
X-CRM114-Status: GOOD (  24.25  )
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



On 22/09/2023 12:22, Johannes Berg wrote:
>>
>> 4. UML TLB flush is also invoked during a fork. This happens
>> with interrupts and preempt disabled which disagrees with the
>> standard mm locking via rwsem. The mm lock for this code path
>> had to be replaced with an rcu.
> 
> For the record, even if I figured out this gets rid of the complaints,
> I'm not entirely happy with this - yeah it's safe now, but it still
> feels entirely wrong.
> 
> But I guess we can also do this and then remove it entirely like the
> patch I just posted. Order probably doesn't matter much.

Indeed.

We opened the can of worms. It will be a while until they are all in bigger
and more comfortable new quarters.

> 
> (Note my patch removes the locking completely since it's now invoked by
> the kernel even under write mmap lock.)

Ack.

> 
>> diff --git a/arch/um/kernel/fpu.c b/arch/um/kernel/fpu.c
>> new file mode 100644
>> index 000000000000..4817276b2a26
>> --- /dev/null
>> +++ b/arch/um/kernel/fpu.c
> 
>> +#ifdef CONFIG_64BIT
>> +	if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVEOPT)))
>> +		__builtin_ia32_xsaveopt64(&current->thread.fpu, KNOWN_387_FEATURES);
>> +	else {
>> +		if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVE)))
>> +			__builtin_ia32_xsave64(&current->thread.fpu, KNOWN_387_FEATURES);
>> +		else
>> +			__builtin_ia32_fxsave64(&current->thread.fpu);
> 
> :)
> 
> OK, I'll stop mentioning it ;-)
> 
>> +EXPORT_SYMBOL_GPL(kernel_fpu_end);
>> +
> 
> git am complained here about blank line at EOF
> 
>> @@ -597,8 +609,13 @@ void force_flush_all(void)
>>   	struct vm_area_struct *vma;
>>   	VMA_ITERATOR(vmi, mm, 0);
>>   
>> -	mmap_read_lock(mm);
>> +	/* We use a RCU lock instead of a mm lock, because
>> +	 * this can be invoked out of critical/atomic sections
>> +	 * and that does not agree with the sleepable semantics
>> +	 * of the standard semaphore based mm lock.
>> +	 */
>> +	rcu_read_lock();
> 
> Yeah I guess ... Seems like a very mechanical description of what's
> going on, rather than a description of why this is correct (which
> assumes no preempt and no SMP)?
> 
> I'd have preferred that, but with the patch I just posted we'll just
> kill this entirely so it doesn't matter in the end.
> 
> johannes
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
