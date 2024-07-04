Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7618DC30653
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 09:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yrasoxLuGXWl5avWOaRy+3FGhIlNUy9A9z4QcqyQ8KI=; b=cCbw8bZqnn77/Kq4tduqOINTRD
	RVEnalf0xGi5ycAtbU1vXJBVBmGoFhfiyfJxapK5nUF/0dlD6fMn/zlS4qdTAv7VGFzrGOIBi7GJr
	a2Kxh0ksLHsSsM3JQ1ThNpmu0K7F9WUzhZ54AZVfrXsauSgik0KloNtWPNWMQnyJzlMveuz4rMJWt
	7lKSy/QaPQV+ywhsLgZMkbay1lf9WwykVtA/yv+B6cq3ARyQsG0iCCVPEg+kksxinm3ONagxr0U26
	dni+u3Jw8L/0dW4YEVRjqH/oBrnXWTpGJ4J+jUnUsHF+PT7rWLtP1HASqKaIQaTMwueML8xt/NMHf
	qoFg1CVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPIao-0000000Cipp-1YLl;
	Thu, 04 Jul 2024 09:17:30 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPIam-0000000Ciou-01hy
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 09:17:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=yrasoxLuGXWl5avWOaRy+3FGhIlNUy9A9z4QcqyQ8KI=;
	t=1720084645; x=1721294245; b=Eqe8YKtKaLpqcRCdMdFXWq9jWik4YoHEe0xAo+ihX35Lb24
	tyiPdCKq5rfvaBenJGLtJDRQzrdqVPiV7qgihUpv4z664nzLDThAcRTUDxMcfr2CxpAwNgmDfNNOY
	J6JbKPdxNoev/zk0xcFmW6Xxsofe1ecDRAbJ/6uL3YJCXK3NNVSmfNzerVFsou9UvZsIeD7tZ3OsL
	cggmwb19A8yoWtvZCXAyjhglQL6FFrJYhVd2RMMQZQCusobXgJEIHK9OxiHDJdcuX4vIPokcWKVvj
	dUqid2gMgeEi7sICCxzMPPIXVsdSyU8gLSaOo5fREKA+H+RQf/tlV94auCn8DtRw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sPIae-0000000CKi3-0bS0;
	Thu, 04 Jul 2024 11:17:20 +0200
Message-ID: <43f01cf5b1e55730ee06a42136a8814a61a84951.camel@sipsolutions.net>
Subject: Re: [PATCH] um: vector: Replace locks guarding queue depth with
 atomics
From: Johannes Berg <johannes@sipsolutions.net>
To: anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Cc: richard@nod.at
Date: Thu, 04 Jul 2024 11:17:18 +0200
In-Reply-To: <20240704072154.1716301-1-anton.ivanov@cambridgegreys.com>
References: <20240704072154.1716301-1-anton.ivanov@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_021728_070587_E0A20316 
X-CRM114-Status: GOOD (  34.34  )
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

Hi Anton,

Thanks for taking a look! Also thanks for the other explanation.

On Thu, 2024-07-04 at 08:21 +0100, anton.ivanov@cambridgegreys.com
wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>=20
> UML vector drivers use ring buffer structures which map
> preallocated skbs onto mmsg vectors for use with sendmmsg
> and recvmmsg. They are designed around a single consumer,
> single producer pattern allowing simultaneous enqueue and
> dequeue.

Right, I didn't grok that from just the code yesterday :)

> Lock debugging with preemption showed possible races when
> locking the queue depth. This patch addresses this by
> removing extra locks while making queue depth inc/dec and
> access atomic.

I don't think this is fully correct in SMP, and I think we should fix it
even if we don't have SMP (yet?)

See, the other thing about spinlocks is that they serve as barriers, and
I don't think the atomics you use have "enough" of them (per the docs in
atomic_t.txt)?

If you have concurrent producers and consumers, you really want the
producer to actually have fully prepared the data before it's visible to
the consumer, which means you need to have a full barrier before
incrementing queue_length.

But you're now incrementing it by just atomic_add(), and atomic_t.txt
says:

 - RMW operations that have no return value are unordered;

So I think the producer should have

	/*
	 * adding to queue_length makes the prepared buffers
	 * visible to the consumer, ensure they're actually
	 * completely written/visible before
	 */
	smp_mb__before_atomic();
	atomic_add(...);

Or so?


> +	atomic_sub(advance, &qi->queue_depth);
> =20
> -	if (qi->queue_depth =3D=3D 0) {
> -		qi->head =3D 0;
> -		qi->tail =3D 0;
> -	}
> -	queue_depth =3D qi->queue_depth;
> -	spin_unlock(&qi->tail_lock);
> -	return queue_depth;
> +	return atomic_read(&qi->queue_depth);

Or just use atomic_sub_return()? Though that also implies a barrier,
which I think isn't needed on the consumer side.

However I think it's clearer to just remove the return value and make
this function void.

>  static int vector_advancetail(struct vector_queue *qi, int advance)
>  {
> -	int queue_depth;
> -
>  	qi->tail =3D
>  		(qi->tail + advance)
>  			% qi->max_depth;
> -	spin_lock(&qi->head_lock);
> -	qi->queue_depth +=3D advance;
> -	queue_depth =3D qi->queue_depth;
> -	spin_unlock(&qi->head_lock);
> -	return queue_depth;
> +	atomic_add(advance, &qi->queue_depth);
> +	return atomic_read(&qi->queue_depth);
>  }

Or maybe here instead of the barrier use atomic_add_return() which
implies a full barrier on both sides, but I don't think you need that,
the barrier before is enough?


> @@ -411,61 +386,58 @@ static int vector_send(struct vector_queue *qi)
>  	int result =3D 0, send_len, queue_depth =3D qi->max_depth;
> =20
>  	if (spin_trylock(&qi->head_lock)) {
[...]
> +		/* update queue_depth to current value */
> +		queue_depth =3D atomic_read(&qi->queue_depth);
> +		while (queue_depth > 0) {

I think it'd be clearer to write this as

	while ((queue_depth =3D atomic_read(...))) {

and simply not modify the queue_depth to the return value of
consume_vector_skbs() here:

[...]

> +			if (result > 0) {
> +				queue_depth =3D
> +					consume_vector_skbs(qi, result);
> +				/* This is equivalent to an TX IRQ.
> +				 * Restart the upper layers to feed us
> +				 * more packets.
>  				 */
> -				if (result !=3D send_len) {
> -					vp->estats.tx_restart_queue++;
> -					break;
> -				}
> +				if (result > vp->estats.tx_queue_max)
> +					vp->estats.tx_queue_max =3D result;
> +				vp->estats.tx_queue_running_average =3D
> +					(vp->estats.tx_queue_running_average + result) >> 1;
> +			}
> +			netif_wake_queue(qi->dev);
> +			/* if TX is busy, break out of the send loop,
> +			 *  poll write IRQ will reschedule xmit for us
> +			 */
> +			if (result !=3D send_len) {
> +				vp->estats.tx_restart_queue++;
> +				break;
>  			}
>  		}

The loop doesn't need queue_depth until it goes back to the beginning
anyway.

(it probably also never even executes twice unless you actually have SMP
or preemption?)

> @@ -675,11 +647,13 @@ static void prep_queue_for_rx(struct vector_queue *=
qi)
>  	struct vector_private *vp =3D netdev_priv(qi->dev);
>  	struct mmsghdr *mmsg_vector =3D qi->mmsg_vector;
>  	void **skbuff_vector =3D qi->skbuff_vector;
> -	int i;
> +	int i, queue_depth;
> +
> +	queue_depth =3D atomic_read(&qi->queue_depth);
> =20
> -	if (qi->queue_depth =3D=3D 0)
> +	if (queue_depth =3D=3D 0)
>  		return;
> -	for (i =3D 0; i < qi->queue_depth; i++) {
> +	for (i =3D 0; i < queue_depth; i++) {
>  		/* it is OK if allocation fails - recvmmsg with NULL data in
>  		 * iov argument still performs an RX, just drops the packet
>  		 * This allows us stop faffing around with a "drop buffer"
> @@ -689,7 +663,7 @@ static void prep_queue_for_rx(struct vector_queue *qi=
)
>  		skbuff_vector++;
>  		mmsg_vector++;
>  	}
> -	qi->queue_depth =3D 0;
> +	atomic_set(&qi->queue_depth, 0);

atomic_read() and then atomic_set() rather than atomic_sub() seems
questionable, but you didn't have locks here before so maybe this is
somehow logically never in parallel? But it is done in NAPI polling via
vector_mmsg_rx(), so not sure I understand.

> @@ -987,7 +961,7 @@ static int vector_mmsg_rx(struct vector_private *vp, =
int budget)
>  	 * many do we need to prep the next time prep_queue_for_rx() is called.
>  	 */
> =20
> -	qi->queue_depth =3D packet_count;
> +	atomic_add(packet_count, &qi->queue_depth);
> =20
>  	for (i =3D 0; i < packet_count; i++) {
>  		skb =3D (*skbuff_vector);

especially since here you _did_ convert to atomic_add().

johannes

