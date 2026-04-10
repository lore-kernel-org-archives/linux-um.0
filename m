Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783B8F45A0D
	for <linux-um@archiver.kernel.org>; Fri, 10 Apr 2026 20:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ni2X+zRZY5FUog1RXnNGZZG7nRAwLpLm4d56uNXlyqg=; b=vBBAHKKWmYXug7OKO47mBU+3MQ
	E5b1QicUz1kezghCMXtLDYTFvopISbNH82wC/bBn6V5KopwkqVCrqP/u3txdRFh90kv6T5Yc55Mvt
	CuDN8tmVWebmDa1hEv1XMNN/VNKT1zlWgD2f6boZvNpUvXhVDON1Ah+nUNCx4E2LHk6XYWYizB3UO
	G5QZ8aHaWs+E0+uxpnhiX4916iyH/H4d1W/BF5uOsPtfjxkW+synXbWyWi1iFBLIn4J6bAxvojJQW
	2IOWPNdWSo70bhFIMAtqrU9ZnORP1WWRFZ3BUH6ZkMGVKrCkueiEWpxdqFLsX1IgDs3RQ05c5gp/u
	u9/tJWuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wBIbR-0000000Cm9A-3kI1;
	Fri, 10 Apr 2026 20:37:21 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wBIbO-0000000Cm8p-2sly
	for linux-um@lists.infradead.org;
	Fri, 10 Apr 2026 20:37:20 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1wBIbC-00EzFn-Bq; Fri, 10 Apr 2026 20:37:06 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1wBHUe-0000000EGm3-3AmX;
	Fri, 10 Apr 2026 21:37:05 +0100
Message-ID: <364a0f17-c733-4ef0-8d8f-1bd9e00dcae9@cambridgegreys.com>
Date: Fri, 10 Apr 2026 21:37:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: vector: fix NULL pointer derefs in queue-less
 transports
To: Michael Bommarito <michael.bommarito@gmail.com>, richard@nod.at,
 johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260410203028.3717914-1-michael.bommarito@gmail.com>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
In-Reply-To: <20260410203028.3717914-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260410_133718_754834_18E2E24C 
X-CRM114-Status: GOOD (  19.56  )
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

On 10/04/2026 21:30, Michael Bommarito wrote:
> TAP transport sets neither VECTOR_RX nor VECTOR_TX, so
> vector_net_open() never allocates rx_queue or tx_queue.  HYBRID sets
> VECTOR_RX but not VECTOR_TX, so tx_queue is NULL there too.
>
> vector_reset_stats(), vector_poll(), vector_get_ethtool_stats(), and
> vector_get_ringparam() unconditionally deref these queue pointers,
> causing a NULL pointer crash on SMP or with any lock debugging option.
>
> Guard all queue pointer accesses with NULL checks.
>
> Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
> Cc: stable@vger.kernel.org
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Assisted-by: Claude:claude-opus-4-6
> Assisted-by: Codex:gpt-5-4
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> Found while enabling KCOV and lockdep on UML for a network-stack
> test lab.  Tested boot with SMP=y + PROVE_LOCKING + DEBUG_SPINLOCK +
> DEBUG_LOCK_ALLOC + LOCKDEP + KCOV, all with vec0:transport=tap.
>
> Without the fix, the same config panics at addr 0x18 (SMP, no debug),
> 0x1c (DEBUG_SPINLOCK), or 0x30 (lockdep) -- all offsets into a NULL
> vector_queue pointer.
>
>   arch/um/drivers/vector_kern.c | 48 +++++++++++++++++------------------
>   1 file changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index 2cc90055499a5..6134c376e57be 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -105,25 +105,18 @@ static const struct {
>   
>   static void vector_reset_stats(struct vector_private *vp)
>   {
> -	/* We reuse the existing queue locks for stats */
> -
> -	/* RX stats are modified with RX head_lock held
> -	 * in vector_poll.
> -	 */
> -
> -	spin_lock(&vp->rx_queue->head_lock);
> +	if (vp->rx_queue)
> +		spin_lock(&vp->rx_queue->head_lock);
>   	vp->estats.rx_queue_max = 0;
>   	vp->estats.rx_queue_running_average = 0;
>   	vp->estats.rx_encaps_errors = 0;
>   	vp->estats.sg_ok = 0;
>   	vp->estats.sg_linearized = 0;
> -	spin_unlock(&vp->rx_queue->head_lock);
> -
> -	/* TX stats are modified with TX head_lock held
> -	 * in vector_send.
> -	 */
> +	if (vp->rx_queue)
> +		spin_unlock(&vp->rx_queue->head_lock);
>   
> -	spin_lock(&vp->tx_queue->head_lock);
> +	if (vp->tx_queue)
> +		spin_lock(&vp->tx_queue->head_lock);
>   	vp->estats.tx_timeout_count = 0;
>   	vp->estats.tx_restart_queue = 0;
>   	vp->estats.tx_kicks = 0;
> @@ -131,7 +124,8 @@ static void vector_reset_stats(struct vector_private *vp)
>   	vp->estats.tx_flow_control_xoff = 0;
>   	vp->estats.tx_queue_max = 0;
>   	vp->estats.tx_queue_running_average = 0;
> -	spin_unlock(&vp->tx_queue->head_lock);
> +	if (vp->tx_queue)
> +		spin_unlock(&vp->tx_queue->head_lock);
>   }
>   
>   static int get_mtu(struct arglist *def)
> @@ -1163,7 +1157,8 @@ static int vector_poll(struct napi_struct *napi, int budget)
>   
>   	if ((vp->options & VECTOR_TX) != 0)
>   		tx_enqueued = (vector_send(vp->tx_queue) > 0);
> -	spin_lock(&vp->rx_queue->head_lock);
> +	if (vp->rx_queue)
> +		spin_lock(&vp->rx_queue->head_lock);
>   	if ((vp->options & VECTOR_RX) > 0)
>   		err = vector_mmsg_rx(vp, budget);
>   	else {
> @@ -1171,7 +1166,8 @@ static int vector_poll(struct napi_struct *napi, int budget)
>   		if (err > 0)
>   			err = 1;
>   	}
> -	spin_unlock(&vp->rx_queue->head_lock);
> +	if (vp->rx_queue)
> +		spin_unlock(&vp->rx_queue->head_lock);
>   	if (err > 0)
>   		work_done += err;
>   
> @@ -1421,10 +1417,10 @@ static void vector_get_ringparam(struct net_device *netdev,
>   {
>   	struct vector_private *vp = netdev_priv(netdev);
>   
> -	ring->rx_max_pending = vp->rx_queue->max_depth;
> -	ring->tx_max_pending = vp->tx_queue->max_depth;
> -	ring->rx_pending = vp->rx_queue->max_depth;
> -	ring->tx_pending = vp->tx_queue->max_depth;
> +	ring->rx_max_pending = vp->rx_queue ? vp->rx_queue->max_depth : 0;
> +	ring->tx_max_pending = vp->tx_queue ? vp->tx_queue->max_depth : 0;
> +	ring->rx_pending = ring->rx_max_pending;
> +	ring->tx_pending = ring->tx_max_pending;
>   }
>   
>   static void vector_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
> @@ -1466,11 +1462,15 @@ static void vector_get_ethtool_stats(struct net_device *dev,
>   	 * to date.
>   	 */
>   
> -	spin_lock(&vp->tx_queue->head_lock);
> -	spin_lock(&vp->rx_queue->head_lock);
> +	if (vp->tx_queue)
> +		spin_lock(&vp->tx_queue->head_lock);
> +	if (vp->rx_queue)
> +		spin_lock(&vp->rx_queue->head_lock);
>   	memcpy(tmp_stats, &vp->estats, sizeof(struct vector_estats));
> -	spin_unlock(&vp->rx_queue->head_lock);
> -	spin_unlock(&vp->tx_queue->head_lock);
> +	if (vp->rx_queue)
> +		spin_unlock(&vp->rx_queue->head_lock);
> +	if (vp->tx_queue)
> +		spin_unlock(&vp->tx_queue->head_lock);
>   }
>   
>   static int vector_get_coalesce(struct net_device *netdev,

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661


