Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE72C2BD09
	for <linux-um@archiver.kernel.org>; Mon,  1 Jul 2024 19:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8NyQHQ6wPCoxnqMbo7dC96nXBwe9RNEEyFiip5hv+RA=; b=ME3eYBg17UeIXh7AHu1jw3g251
	Uge6v79vjfi3LyolzdoEkqR1PixyydyUHYjdRu8e5HeNlTh86yH+pVZwCAor6vmFYTeJ1b4mBQHl9
	MIzKaWPBszF51DVhOirTB7G06h2+yyNJVI23rHh9GhvR383EKv+SwHAzupu3bFLhtLmzQsC5VeIvq
	J9SH5KCqjOx+Q6UB9la47meofC9/AOgLg4yx5N0RGOxYRpwzKiCU9J9AUoyPMXpC6/L8S3mXEdnNG
	U8ZngxoEt6ApdcJQ3b6e1wdo5bLdR04rAO/62nP+SH8GU/lsT5cF0th6lDGxq+lMWmadake5z4jAj
	G/0i9rdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOMkS-00000004eMS-3A1q;
	Mon, 01 Jul 2024 19:31:36 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOMkO-00000004eKc-2a0V
	for linux-um@lists.infradead.org;
	Mon, 01 Jul 2024 19:31:34 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1sOMBc-005RNa-AM; Mon, 01 Jul 2024 18:55:36 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1sOMBW-00HSY8-0l;
	Mon, 01 Jul 2024 19:55:36 +0100
Message-ID: <733d5ed2-d085-4422-9d46-4c14426f56c4@cambridgegreys.com>
Date: Mon, 1 Jul 2024 19:55:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] um: Enable preemption in UML
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: richard@nod.at
References: <20240403062754.124752-1-anton.ivanov@cambridgegreys.com>
 <6969757a8347ad5171a651fb668a28613b08176d.camel@sipsolutions.net>
 <4137d6ba7d380fed13f8edc1147211b4511e8bfb.camel@sipsolutions.net>
 <c6056c4a2d1cb549ae2c0b010de912e8ff38ec8f.camel@sipsolutions.net>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
In-Reply-To: <c6056c4a2d1cb549ae2c0b010de912e8ff38ec8f.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_123132_686902_C6205AD3 
X-CRM114-Status: GOOD (  10.30  )
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

On 01/07/2024 17:35, Johannes Berg wrote:
> On Mon, 2024-07-01 at 17:56 +0200, Johannes Berg wrote:
>> Hmm. I also see a ton of this:
>>
>> BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1525
>> in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 538, name: chan-switch.sh
>> preempt_count: 2, expected: 0
>> RCU nest depth: 0, expected: 0
>> no locks held by chan-switch.sh/538.
>> irq event stamp: 0
>> hardirqs last  enabled at (0): [<0000000000000000>] 0x0
>> hardirqs last disabled at (0): [<000000006004b961>] copy_process+0xbb7/0x2790
>> softirqs last  enabled at (0): [<000000006004b961>] copy_process+0xbb7/0x2790
>> softirqs last disabled at (0): [<0000000000000000>] 0x0
>> Preemption disabled at:
>> [<0000000060084b04>] preempt_count_add+0x11f/0x126
>> CPU: 0 PID: 538 Comm: chan-switch.sh Tainted: G        W  O       6.10.0-rc2 #11
>> Stack:
>>   714c7e40 605f2a9d 00000000 00000000
>>   ffffff00 607d2edc 00000000 60db7a48
>>   714c7e70 60620823 0000022c 606161d1
>> Call Trace:
>>   [<606161d1>] ? _printk+0x0/0x94
>>   [<6002fa2f>] show_stack+0xfe/0x159
>>   [<605f2a9d>] ? dump_stack_print_info+0xe1/0xf0
>>   [<60620823>] dump_stack_lvl+0x77/0xbe
>>   [<606161d1>] ? _printk+0x0/0x94
>>   [<60084b04>] ? preempt_count_add+0x11f/0x126
>>   [<60620884>] dump_stack+0x1a/0x1c
>>   [<60085b82>] __might_resched+0x3b0/0x3d2
>>   [<60085ca0>] __might_sleep+0xfc/0x107
>>   [<60627212>] down_read+0x34/0x224
>>   [<60032256>] force_flush_all+0x71/0x10d
>
> Which is, however, addressed by my own patchset
>
> https://patchwork.ozlabs.org/project/linux-um/list/?series=374492
>
> though it doesn't apply completely cleanly any more.
>
> johannes
>
As Benjamin pointed out we no longer need this, so we can junk this 
patch at this point. If there will be any need to save/restore FPU in 
kernel context, I will revisit it.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


