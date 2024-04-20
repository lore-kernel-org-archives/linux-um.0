Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9717EC4345F
	for <linux-um@archiver.kernel.org>; Sat, 20 Apr 2024 13:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hIk9MkyOCvIGRlqWvTZ9i+HZUx/nxgjt5VWpOtUlMf8=; b=Uijh7Ek8kUXb7mv2Hyr04tjN5o
	KHwyabTl3L/elQ6vk0ACAjIGHzBBQrLpMmti7Azb8zd+pG0fk2qWRJUSE2lFbkuIz2hrlyDErrmHU
	xm7CZP7dzwIcmUlMP0zMGbWrd0ufGrcgUeP+GUr+TH1SDpTOUwcCmpJOgzNnPKPdOi02zb80mKyJc
	4NQlN4l01BYOUrttuaerEkzwGdcQFUjMiUACHVzg4NQC4cuylppuvst0kkuZQ13wVpl10P0YHoNFX
	IRzK+gnho2KrlntqeUrTov9a6fXo/6kVn3IJe6EN1xWTPPS+NuZGJIK5Xcicgu806vEhkUs73CNRx
	lKB867VQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryALf-00000008W70-3pic;
	Sat, 20 Apr 2024 13:01:43 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryALa-00000008W6D-30fU
	for linux-um@lists.infradead.org;
	Sat, 20 Apr 2024 13:01:40 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1ry9k7-000HF0-4M; Sat, 20 Apr 2024 12:22:55 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1ry9k4-006X1A-0r;
	Sat, 20 Apr 2024 13:22:54 +0100
Message-ID: <f70c5eda-0d2f-4845-843d-d770e4ed507f@cambridgegreys.com>
Date: Sat, 20 Apr 2024 13:22:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] um: Enable preemption in UML
Content-Language: en-US
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org
Cc: richard@nod.at, johannes@sipsolutions.net
References: <20240403062754.124752-1-anton.ivanov@cambridgegreys.com>
 <4d5e9840b3603dbee17a1218bdcc4f8cea3c4240.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
In-Reply-To: <4d5e9840b3603dbee17a1218bdcc4f8cea3c4240.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240420_060138_797655_FC763557 
X-CRM114-Status: GOOD (  19.69  )
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

On 19/04/2024 14:47, Benjamin Berg wrote:
> Hi,
> 
> On Wed, 2024-04-03 at 07:27 +0100, anton.ivanov@cambridgegreys.com
> wrote:
>> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>
>> 1. Preemption requires saving/restoring FPU state. This patch
>> adds support for it using GCC intrinsics as well as appropriate
>> storage space in the thread structure. We reuse the space
>> which is already allocated for the userspace threads in the
>> thread_info structure.
> 
> Do we need to store the FPU state even? 

Everybody else does :)

> After all, we cannot simply
> overwrite userspace FPU registers in UML.

Correct, but you can have kernel threads as well.
> 
> Seriously wondering about that. It seems to me it would be sufficient
> to ensure that only one kernel task is in a
> kern_fpu_begin()/kern_fpu_end() section at any point in time.

So what happens if you have a task which wants fpu and cannot get it at 
this point?

> 
> Now, I don't know how preempt_disable()/preempt_enable() behaves
> exactly. But I would assume it makes such a guarantee and then we can
> simply map kern_fpu_begin to preempt_disable and kern_fpu_end to
> preempt_enable.
> 
>> 2. irq critical sections need preempt_disable()/preempt_enable().

Yes. Otherwise RAID, crypto, ipsec can mess up things.

>>
>> 3. TLB critical sections need preempt_disable()/preempt_enable().

I think I added those.

>>
>> 4. UML TLB flush is also invoked during a fork. This happens
>> with interrupts and preempt disabled which disagrees with the
>> standard mm locking via rwsem. The mm lock for this code path
>> had to be replaced with an rcu.
> 
> Hopefully that flush during fork will be gone soon :-)

Hurrah!!!

> 
> Benjamin
> 
>> [...]
> 
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


