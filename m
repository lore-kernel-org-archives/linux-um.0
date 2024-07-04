Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CF2C30653
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 20:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mHDEo+k4QRc7DUwnodsAiiiS4blv9UYhfYzvRzand6Y=; b=glC0omsqvG33hjfCfoQpm30wDw
	hSFDD1AjFNXelyBY3Rrk1h75uBqsxHkHeM+AdXOtKkTCCBKbEqtp7VEz4sBdkdUrzbWkYhN8QQwCD
	w5qrfCV45m1hHJi27H7xmCw8u9aB6TgbqNRb4lHknK5V/qB8OjXm7pzEAbaiKAJxQ2qAnvBdY4wwH
	Tnw4q6zwRE3T4pIG6/1aWix2sPswLhTw0b3VOMTKn+AFxjIUOaN8WMiPdkQYn/shfdJlWw3FQ+HbS
	R6dJk6B/tS6mbX3tc+zvF1nl87YYzTEzmTaYfBw1vC7sv+0SuKkv9R6tuhNJIVdXUjjyJY6UZi56I
	b493qYag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPSt0-0000000EMQw-1pq9;
	Thu, 04 Jul 2024 20:16:58 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPSsv-0000000EMQM-2Sru
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 20:16:56 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1sPSss-005ezJ-HK
	for linux-um@lists.infradead.org; Thu, 04 Jul 2024 20:16:50 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1sPSsn-008lBL-1u
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 21:16:50 +0100
Message-ID: <958adfdb-dfd0-48ef-bf63-e4d759e07f25@kot-begemot.co.uk>
Date: Thu, 4 Jul 2024 21:16:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] um: vector: Replace locks guarding queue depth with
 atomics
To: linux-um@lists.infradead.org
References: <20240704122259.1869198-1-anton.ivanov@cambridgegreys.com>
 <44d28d25de3d11458aef2755b44350d344a1caf8.camel@sipsolutions.net>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <44d28d25de3d11458aef2755b44350d344a1caf8.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_131654_938290_A30B6200 
X-CRM114-Status: GOOD (  29.63  )
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

On 04/07/2024 17:12, Johannes Berg wrote:
> On Thu, 2024-07-04 at 13:22 +0100, anton.ivanov@cambridgegreys.com
> wrote:
>> @@ -675,11 +657,20 @@ static void prep_queue_for_rx(struct vector_queue *qi)
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
>> +
>> +	/* RX is always emptied 100% during each cycle, so we do not
>> +	 * want to do the tail wraparound math for it
>> +	 */
>> +
>> +	qi->head = qi->tail = 0;
>> +
>> +	for (i = 0; i < queue_depth; i++) {
>>   		/* it is OK if allocation fails - recvmmsg with NULL data in
>>   		 * iov argument still performs an RX, just drops the packet
>>   		 * This allows us stop faffing around with a "drop buffer"
>> @@ -689,7 +680,8 @@ static void prep_queue_for_rx(struct vector_queue *qi)
>>   		skbuff_vector++;
>>   		mmsg_vector++;
>>   	}
>> -	qi->queue_depth = 0;
>> +	wmb(); /* Ensure that RX processing elsewhere sees the changes */
>> +	atomic_set(&qi->queue_depth, 0);
>>   }
> I don't understand this.
>
> prep_queue_for_rx() is called by vector_mmsg_rx(), not in parallel or in
> a different thread or something, inside the NAPI polling. All it does is
> reset the queue to empty with all the SKBs allocated.
>
> After that, prep_queue_for_rx() calls uml_vector_recvmmsg() [1] which
> fills the SKBs, and then vector_mmsg_rx() itself consumes them by going
> over it and calling napi_gro_receive() (or whatever else).
>
> There's no parallelism here? The RX queue wouldn't even need locking or
> atomic instructions at all at this point, since it's just "refill
> buffers, fill buffers, release buffers to network stack".
>
> What am I missing?

You are not missing anything.

The rx and tx are using the same infra to map vectors to skbs arrays.

I can make the RX use a set of lockless and atomicless functions, but 
this means duplicating some of the code.

>
>
> [1] btw, it should pass 'budget' to uml_vector_recvmmsg(), not the depth
> (qi->max_depth), and possibly even pass that to prep_queue_for_rx(), but
> that's a different patch.
Good point. Let's sort out the locking and parallelism first.
>
>>   static struct vector_device *find_device(int n)
>> @@ -987,7 +979,7 @@ static int vector_mmsg_rx(struct vector_private *vp, int budget)
>>   	 * many do we need to prep the next time prep_queue_for_rx() is called.
>>   	 */
>>   
>> -	qi->queue_depth = packet_count;
>> +	atomic_add(packet_count, &qi->queue_depth);
> and that also means my earlier analysis was just confused - there's no
> need for _add here, _set is fine - in fact even non-atomic would be
> fine.
>
>> @@ -1176,6 +1168,7 @@ static int vector_poll(struct napi_struct *napi, int budget)
>>   
>>   	if ((vp->options & VECTOR_TX) != 0)
>>   		tx_enqueued = (vector_send(vp->tx_queue) > 0);
>> +	spin_lock(&vp->rx_queue->head_lock);
>>   	if ((vp->options & VECTOR_RX) > 0)
>>   		err = vector_mmsg_rx(vp, budget);
>>   	else {
>> @@ -1183,6 +1176,7 @@ static int vector_poll(struct napi_struct *napi, int budget)
>>   		if (err > 0)
>>   			err = 1;
>>   	}
>> +	spin_unlock(&vp->rx_queue->head_lock);
> that's needed for ... stats?

Yes, unfortunately.

I am reusing the lock.

And that one may be accessed in parallel :(

>
> johannes
>
>

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/


