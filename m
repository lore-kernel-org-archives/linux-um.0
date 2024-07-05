Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A0AC30658
	for <linux-um@archiver.kernel.org>; Fri,  5 Jul 2024 06:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=euyFff8MLAETkSI4QFP2AvRoCSKrdhta1oHJzGG26d8=; b=h29LbsS5v5qMIARn8RsupnSSQ6
	nM77+rLFHhoN5kPDdzjHC5rJC3k0UuOKi6M1BxUWgUlzzPeIc5hKTlks6ceBlh4lWxp1tIyljfQGH
	4xE+JdMl6CK8bWCT/2HhvYDmSFD1MIXw1L/rpB/MN1Y/0FnlguZRiMoazgqal+gWWE3C2MOdEOj7/
	4LOiZT4JhRi2akGvQfnisa43fqLZ7DT7epbWs9hlUCiXZRs5DbPPJVHi8SbICAfQvw6OX1reG/tcQ
	eudJBfMHlmD5NPjbhlequmWBhAhPBPpARiQvm87E0D2f1VG0MzXZrqBKxgQqyPGbCn+hhkFWg9tOG
	CWXaZEiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPcV8-0000000F3mI-3rSJ;
	Fri, 05 Jul 2024 06:32:58 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPcV5-0000000F3lu-0MNY
	for linux-um@lists.infradead.org;
	Fri, 05 Jul 2024 06:32:57 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1sPcV0-005gqe-3N; Fri, 05 Jul 2024 06:32:50 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1sPcUu-009wGp-0w;
	Fri, 05 Jul 2024 07:32:49 +0100
Message-ID: <ebeae9df-7d67-4f5e-ae67-d33104157f0c@kot-begemot.co.uk>
Date: Fri, 5 Jul 2024 07:32:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] um: vector: Replace locks guarding queue depth with
 atomics
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
References: <20240704122259.1869198-1-anton.ivanov@cambridgegreys.com>
 <44d28d25de3d11458aef2755b44350d344a1caf8.camel@sipsolutions.net>
 <958adfdb-dfd0-48ef-bf63-e4d759e07f25@kot-begemot.co.uk>
 <c56aeb3368830bffd400fc2c701234130fdea485.camel@sipsolutions.net>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <c56aeb3368830bffd400fc2c701234130fdea485.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_233255_156379_832B233D 
X-CRM114-Status: GOOD (  13.39  )
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

On 04/07/2024 23:55, Johannes Berg wrote:
> On Thu, 2024-07-04 at 21:16 +0100, Anton Ivanov wrote:
>
>>>> -	qi->queue_depth = 0;
>>>> +	wmb(); /* Ensure that RX processing elsewhere sees the changes */
>>>> +	atomic_set(&qi->queue_depth, 0);
>>>>    }
>>> I don't understand this.
>>>
>>> prep_queue_for_rx() is called by vector_mmsg_rx(), not in parallel or in
>>> a different thread or something, inside the NAPI polling. All it does is
>>> reset the queue to empty with all the SKBs allocated.
>>>
>>> After that, prep_queue_for_rx() calls uml_vector_recvmmsg() [1] which
>>> fills the SKBs, and then vector_mmsg_rx() itself consumes them by going
>>> over it and calling napi_gro_receive() (or whatever else).
>>>
>>> There's no parallelism here? The RX queue wouldn't even need locking or
>>> atomic instructions at all at this point, since it's just "refill
>>> buffers, fill buffers, release buffers to network stack".
>>>
>>> What am I missing?
>> You are not missing anything.
>>
>> The rx and tx are using the same infra to map vectors to skbs arrays.
>>
>> I can make the RX use a set of lockless and atomicless functions, but
>> this means duplicating some of the code.
> Right. No need to duplicate I'd say, but I don't see then a need to add
> a wmb() barrier here? It's confusing me because there's nothing
> accessing it in parallel.

Ack. Will clean it up for v3.

>
> johannes
>

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/


