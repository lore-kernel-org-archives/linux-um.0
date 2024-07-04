Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C536C3271E
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 16:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9ATa20vENxLNEk04ESYJkNcAoEtJyAP5Lt/OAbQ3qHA=; b=yByrR/b6rT6K7+OgPue4TUtoek
	YA29cIBjvHtOU2kgcEi8tyFRNaqrHeqwvdn+Ls8n9erSuyit/+tG5O9pn2C2hwzXwqMfYrc8PudNR
	zp/LUUTmRWOUD0TVi5wlFuzy+WocvbuAKWUbQC+41TXcxBuR4/oXJoci7y5oUaPoEr/kpCI1dcfP4
	+ELHsIxSfWAD6eQr8OZQaPeqCg3kclbE3vwZjW00sSSxejDcfHYWPygXjeoXTUiiCKA19N6ondm3b
	YaomrmanfOL7pIpb4lO6qIJ/rxGXbG8wek6EYXO1qWKEvg7IX8IbjhO7FoqIzVOdO7KOINN/aWv8C
	jOOvkyfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPP4G-0000000Dnzw-2OSt;
	Thu, 04 Jul 2024 16:12:20 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPP48-0000000DnzA-2PoJ
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 16:12:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9ATa20vENxLNEk04ESYJkNcAoEtJyAP5Lt/OAbQ3qHA=;
	t=1720109532; x=1721319132; b=Jaw1NF3OR8aHB9tjWORPvfFqcx75FGQlmIsHB4VOFglwVxD
	Nr2ZC8f76toQQvHNJiyZjg91Cl75snBpQA+TOtv+6TqfT0z/knlv+OhGVMT+n1kTEFyG5JgUgUDoW
	Q1+qI+UPac24HyHCGw2TqPk7X9MDurEDkwCbfMbgejRZYUx2dB9iZaVpE8UURr7Iv3t+CqbOrZnEO
	5w6KbS4UEpe31YqohkXnOXuzP6U++IjV1tvKtnm9VM7gEz5luQpcp8RFUm2XyF7kA9LXnjzI2aVhM
	V/cic3oLGhg9TvojcHFKyk3q6cIjDkuwaIpaCRu2JkyX3PG8BPNB97QHOUONiRbw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sPP41-0000000DLZ1-3I4p;
	Thu, 04 Jul 2024 18:12:06 +0200
Message-ID: <44d28d25de3d11458aef2755b44350d344a1caf8.camel@sipsolutions.net>
Subject: Re: [PATCH v2] um: vector: Replace locks guarding queue depth with
 atomics
From: Johannes Berg <johannes@sipsolutions.net>
To: anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Cc: richard@nod.at
Date: Thu, 04 Jul 2024 18:12:04 +0200
In-Reply-To: <20240704122259.1869198-1-anton.ivanov@cambridgegreys.com>
References: <20240704122259.1869198-1-anton.ivanov@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_091212_642123_E0E82E29 
X-CRM114-Status: GOOD (  21.97  )
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

On Thu, 2024-07-04 at 13:22 +0100, anton.ivanov@cambridgegreys.com
wrote:
>=20
> @@ -675,11 +657,20 @@ static void prep_queue_for_rx(struct vector_queue *=
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
> +
> +	/* RX is always emptied 100% during each cycle, so we do not
> +	 * want to do the tail wraparound math for it
> +	 */
> +
> +	qi->head =3D qi->tail =3D 0;
> +
> +	for (i =3D 0; i < queue_depth; i++) {
>  		/* it is OK if allocation fails - recvmmsg with NULL data in
>  		 * iov argument still performs an RX, just drops the packet
>  		 * This allows us stop faffing around with a "drop buffer"
> @@ -689,7 +680,8 @@ static void prep_queue_for_rx(struct vector_queue *qi=
)
>  		skbuff_vector++;
>  		mmsg_vector++;
>  	}
> -	qi->queue_depth =3D 0;
> +	wmb(); /* Ensure that RX processing elsewhere sees the changes */
> +	atomic_set(&qi->queue_depth, 0);
>  }

I don't understand this.

prep_queue_for_rx() is called by vector_mmsg_rx(), not in parallel or in
a different thread or something, inside the NAPI polling. All it does is
reset the queue to empty with all the SKBs allocated.

After that, prep_queue_for_rx() calls uml_vector_recvmmsg() [1] which
fills the SKBs, and then vector_mmsg_rx() itself consumes them by going
over it and calling napi_gro_receive() (or whatever else).

There's no parallelism here? The RX queue wouldn't even need locking or
atomic instructions at all at this point, since it's just "refill
buffers, fill buffers, release buffers to network stack".

What am I missing?


[1] btw, it should pass 'budget' to uml_vector_recvmmsg(), not the depth
(qi->max_depth), and possibly even pass that to prep_queue_for_rx(), but
that's a different patch.

>  static struct vector_device *find_device(int n)
> @@ -987,7 +979,7 @@ static int vector_mmsg_rx(struct vector_private *vp, =
int budget)
>  	 * many do we need to prep the next time prep_queue_for_rx() is called.
>  	 */
> =20
> -	qi->queue_depth =3D packet_count;
> +	atomic_add(packet_count, &qi->queue_depth);

and that also means my earlier analysis was just confused - there's no
need for _add here, _set is fine - in fact even non-atomic would be
fine.

> @@ -1176,6 +1168,7 @@ static int vector_poll(struct napi_struct *napi, in=
t budget)
> =20
>  	if ((vp->options & VECTOR_TX) !=3D 0)
>  		tx_enqueued =3D (vector_send(vp->tx_queue) > 0);
> +	spin_lock(&vp->rx_queue->head_lock);
>  	if ((vp->options & VECTOR_RX) > 0)
>  		err =3D vector_mmsg_rx(vp, budget);
>  	else {
> @@ -1183,6 +1176,7 @@ static int vector_poll(struct napi_struct *napi, in=
t budget)
>  		if (err > 0)
>  			err =3D 1;
>  	}
> +	spin_unlock(&vp->rx_queue->head_lock);

that's needed for ... stats?

johannes

