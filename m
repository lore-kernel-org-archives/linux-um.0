Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9713C3065C
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 09:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pJqeZxCOEjrB60LjZgdlcR0EtyylZAmQ26dYoIT6rmo=; b=toSWLgdgOQK6io8bCWaBbt4kIp
	Rqa5QUmZUKQ4rRmaYk4LogNPm5CLL7NsmdBxHol+2LoZOXnPdrUQSEVOL4D22mezvozGHo/8iV2WQ
	BpD0ROJYWT1VdwIh6dwVGHubhtRBqh82HbyhXqlKztBHnhkpSZ/IdLCY0QPjOEtrINam9fR6fVU/k
	M0MMPUpRuogLz2c3SHxBCoWUEy/d7XzurKZZQ9NhJtUABZDxDe1tWEW+v67MSPTKcthj+//UlDLO4
	KQCQqFxSBg7vQSdQLtUXjY1zLF3W2r2Quxd+PJ2Kf8paU/w7S4A8MxzNAiun6OqQRHoL1RtUrl/C9
	QQwl3g3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPJ27-0000000CmWh-45Dq;
	Thu, 04 Jul 2024 09:45:43 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPJ24-0000000CmW3-1KRX
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 09:45:42 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1sPJ1r-005cp3-By; Thu, 04 Jul 2024 09:45:27 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1sPJ1l-007Vqk-1c;
	Thu, 04 Jul 2024 10:45:27 +0100
Message-ID: <8b581760-1ac3-4aa0-9257-aac2799e02c0@cambridgegreys.com>
Date: Thu, 4 Jul 2024 10:45:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: vector: Replace locks guarding queue depth with
 atomics
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: richard@nod.at
References: <20240704072154.1716301-1-anton.ivanov@cambridgegreys.com>
 <43f01cf5b1e55730ee06a42136a8814a61a84951.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <43f01cf5b1e55730ee06a42136a8814a61a84951.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_024540_401144_E007521A 
X-CRM114-Status: GOOD (  47.56  )
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



On 04/07/2024 10:17, Johannes Berg wrote:
> Hi Anton,
> 
> Thanks for taking a look! Also thanks for the other explanation.
> 
> On Thu, 2024-07-04 at 08:21 +0100, anton.ivanov@cambridgegreys.com
> wrote:
>> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>
>> UML vector drivers use ring buffer structures which map
>> preallocated skbs onto mmsg vectors for use with sendmmsg
>> and recvmmsg. They are designed around a single consumer,
>> single producer pattern allowing simultaneous enqueue and
>> dequeue.
> 
> Right, I didn't grok that from just the code yesterday :)
> 
>> Lock debugging with preemption showed possible races when
>> locking the queue depth. This patch addresses this by
>> removing extra locks while making queue depth inc/dec and
>> access atomic.
> 
> I don't think this is fully correct in SMP, and I think we should fix it
> even if we don't have SMP (yet?)
> 
> See, the other thing about spinlocks is that they serve as barriers, and
> I don't think the atomics you use have "enough" of them (per the docs in
> atomic_t.txt)?
> 
> If you have concurrent producers and consumers, you really want the
> producer to actually have fully prepared the data before it's visible to
> the consumer, which means you need to have a full barrier before
> incrementing queue_length.

Indeed. I will add that for v2.

> 
> But you're now incrementing it by just atomic_add(), and atomic_t.txt
> says:
> 
>   - RMW operations that have no return value are unordered;
> 
> So I think the producer should have
> 
> 	/*
> 	 * adding to queue_length makes the prepared buffers
> 	 * visible to the consumer, ensure they're actually
> 	 * completely written/visible before
> 	 */
> 	smp_mb__before_atomic();
> 	atomic_add(...);
> 
> Or so?
> 
> 
>> +	atomic_sub(advance, &qi->queue_depth);
>>   
>> -	if (qi->queue_depth == 0) {
>> -		qi->head = 0;
>> -		qi->tail = 0;
>> -	}
>> -	queue_depth = qi->queue_depth;
>> -	spin_unlock(&qi->tail_lock);
>> -	return queue_depth;
>> +	return atomic_read(&qi->queue_depth);
> 
> Or just use atomic_sub_return()? Though that also implies a barrier,
> which I think isn't needed on the consumer side.

Let me have a look at it once again. IIRC you need only producer barriers.

> 
> However I think it's clearer to just remove the return value and make
> this function void.
> 
>>   static int vector_advancetail(struct vector_queue *qi, int advance)
>>   {
>> -	int queue_depth;
>> -
>>   	qi->tail =
>>   		(qi->tail + advance)
>>   			% qi->max_depth;
>> -	spin_lock(&qi->head_lock);
>> -	qi->queue_depth += advance;
>> -	queue_depth = qi->queue_depth;
>> -	spin_unlock(&qi->head_lock);
>> -	return queue_depth;
>> +	atomic_add(advance, &qi->queue_depth);
>> +	return atomic_read(&qi->queue_depth);
>>   }
> 
> Or maybe here instead of the barrier use atomic_add_return() which
> implies a full barrier on both sides, but I don't think you need that,
> the barrier before is enough?
> 
> 
>> @@ -411,61 +386,58 @@ static int vector_send(struct vector_queue *qi)
>>   	int result = 0, send_len, queue_depth = qi->max_depth;
>>   
>>   	if (spin_trylock(&qi->head_lock)) {
> [...]
>> +		/* update queue_depth to current value */
>> +		queue_depth = atomic_read(&qi->queue_depth);
>> +		while (queue_depth > 0) {
> 
> I think it'd be clearer to write this as
> 
> 	while ((queue_depth = atomic_read(...))) {
> 
> and simply not modify the queue_depth to the return value of
> consume_vector_skbs() here:
> 
> [...]
> 
>> +			if (result > 0) {
>> +				queue_depth =
>> +					consume_vector_skbs(qi, result);
>> +				/* This is equivalent to an TX IRQ.
>> +				 * Restart the upper layers to feed us
>> +				 * more packets.
>>   				 */
>> -				if (result != send_len) {
>> -					vp->estats.tx_restart_queue++;
>> -					break;
>> -				}
>> +				if (result > vp->estats.tx_queue_max)
>> +					vp->estats.tx_queue_max = result;
>> +				vp->estats.tx_queue_running_average =
>> +					(vp->estats.tx_queue_running_average + result) >> 1;
>> +			}
>> +			netif_wake_queue(qi->dev);
>> +			/* if TX is busy, break out of the send loop,
>> +			 *  poll write IRQ will reschedule xmit for us
>> +			 */
>> +			if (result != send_len) {
>> +				vp->estats.tx_restart_queue++;
>> +				break;
>>   			}
>>   		}
> 
> The loop doesn't need queue_depth until it goes back to the beginning
> anyway.
> 
> (it probably also never even executes twice unless you actually have SMP
> or preemption?)

It does. If half of the vector is at the end of the array which is used to
imitate a ring buffer and the other half is at the beginning. Quite a common
condition actually.

There is an extra issue there - stats. I need to double-check the locking when
they are being fetched.

> 
>> @@ -675,11 +647,13 @@ static void prep_queue_for_rx(struct vector_queue *qi)
>>   	struct vector_private *vp = netdev_priv(qi->dev);
>>   	struct mmsghdr *mmsg_vector = qi->mmsg_vector;
>>   	void **skbuff_vector = qi->skbuff_vector;
>> -	int i;
>> +	int i, queue_depth;
>> +
>> +	queue_depth = atomic_read(&qi->queue_depth);
>>   
>> -	if (qi->queue_depth == 0)
>> +	if (queue_depth == 0)
>>   		return;
>> -	for (i = 0; i < qi->queue_depth; i++) {
>> +	for (i = 0; i < queue_depth; i++) {
>>   		/* it is OK if allocation fails - recvmmsg with NULL data in
>>   		 * iov argument still performs an RX, just drops the packet
>>   		 * This allows us stop faffing around with a "drop buffer"
>> @@ -689,7 +663,7 @@ static void prep_queue_for_rx(struct vector_queue *qi)
>>   		skbuff_vector++;
>>   		mmsg_vector++;
>>   	}
>> -	qi->queue_depth = 0;
>> +	atomic_set(&qi->queue_depth, 0);
> 
> atomic_read() and then atomic_set() rather than atomic_sub() seems
> questionable, but you didn't have locks here before so maybe this is
> somehow logically never in parallel? But it is done in NAPI polling via
> vector_mmsg_rx(), so not sure I understand.
> 
>> @@ -987,7 +961,7 @@ static int vector_mmsg_rx(struct vector_private *vp, int budget)
>>   	 * many do we need to prep the next time prep_queue_for_rx() is called.
>>   	 */
>>   
>> -	qi->queue_depth = packet_count;
>> +	atomic_add(packet_count, &qi->queue_depth);
>>   
>>   	for (i = 0; i < packet_count; i++) {
>>   		skb = (*skbuff_vector);
> 
> especially since here you _did_ convert to atomic_add().
> 
> johannes
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

