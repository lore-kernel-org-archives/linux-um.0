Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84463CD5BD5
	for <linux-um@archiver.kernel.org>; Thu, 28 May 2026 08:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ENxjtq2SNsml1+RlRIgf3/UJi0mDvR9nG+YCmNcsr3Y=; b=lF3ZAMX6GJkrP8eCnLK4vVcpLA
	Nul10VWBIUDXplYJQG08LdyWKfFMW0soiH0R0U4cHHZr/RCHV3sQ2wrJnxOuaQC2kSMefgB2GNRoT
	haqfQVpTEbRHUwn8ew8oQbyWNndNUeRiBf7NlozwgDvUClRiVHD9FkR08rk5FgpS+0fg30Jj/rf5j
	7S6mdNdFrDQ5L8+9qn/iqpBqo80gTgd19j9lzwS6PCN2F1DzUcKE0/X6dtUq5MRfb5ntI+CTmbyP8
	cgN//X5kxLhmgPAHjGGFjcvIJCT4wp1MqNMQWneIPs41zjUhukZY7b0ViRQ/El3CL30Q7RuLFzgqW
	qOnWtLqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSVhO-00000005Kxb-0Tuz;
	Thu, 28 May 2026 08:02:38 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSVhL-00000005Kwf-1VMK
	for linux-um@lists.infradead.org;
	Thu, 28 May 2026 08:02:36 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1wSVhG-000QAt-MD; Thu, 28 May 2026 08:02:30 +0000
Received: from [192.168.21.56]
	by jain.kot-begemot.co.uk with esmtp (Exim 4.98.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1wSUDC-00000001dG3-3ZRq;
	Thu, 28 May 2026 09:02:29 +0100
Message-ID: <5318a8f9-eadf-4cc5-978b-8749d44d0acb@cambridgegreys.com>
Date: Thu, 28 May 2026 09:02:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: vector: avoid NULL queue dereference in legacy RX
 mode
To: Henry Barreto <contato@henrybarreto.dev>,
 Richard Weinberger <richard@nod.at>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Tiwei Bie <tiwei.btw@antgroup.com>, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org, Henry Barreto <me@henrybarreto.dev>
References: <20260527213524.45903-1-contato@henrybarreto.dev>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <20260527213524.45903-1-contato@henrybarreto.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_010235_399045_D711C1BD 
X-CRM114-Status: GOOD (  19.27  )
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



On 27/05/2026 22:35, Henry Barreto wrote:
> From: Henry Barreto <me@henrybarreto.dev>
> 
> Bringing a UML vector netdev up can panic in vector_net_open() with a
> fault in _raw_spin_lock().
> 
> vector_net_open() calls vector_reset_stats(), which takes the RX and TX
> queue locks. However, queue allocation depends on runtime transport
> options. With tap transport, vector RX/TX queues are not created and the
> legacy header buffers are used instead. Taking a queue lock then
> dereferences a NULL queue pointer.
> 
> Take the queue locks in vector_reset_stats() only when the corresponding
> queue exists. Also move the RX queue lock in vector_poll() into the
> VECTOR_RX path, so legacy RX does not touch rx_queue.
> 
> Fixes: 612a8c8e0b43 ("um: vector: Replace locks guarding queue depth with atomics")
> Signed-off-by: Henry Barreto <me@henrybarreto.dev>
> ---
>   arch/um/drivers/vector_kern.c | 26 ++++++++++++++++++--------
>   1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index 25d9258fa592..70762f15d093 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -110,19 +110,26 @@ static void vector_reset_stats(struct vector_private *vp)
>   	 * in vector_poll.
>   	 */
>   
> -	spin_lock(&vp->rx_queue->head_lock);
> +	if (vp->rx_queue)
> +		spin_lock(&vp->rx_queue->head_lock);
> +
>   	vp->estats.rx_queue_max = 0;
>   	vp->estats.rx_queue_running_average = 0;
>   	vp->estats.rx_encaps_errors = 0;
>   	vp->estats.sg_ok = 0;
>   	vp->estats.sg_linearized = 0;
> -	spin_unlock(&vp->rx_queue->head_lock);
> +
> +	if (vp->rx_queue)
> +		spin_unlock(&vp->rx_queue->head_lock);
> +
>   
>   	/* TX stats are modified with TX head_lock held
>   	 * in vector_send.
>   	 */
>   
> -	spin_lock(&vp->tx_queue->head_lock);
> +	if (vp->tx_queue)
> +		spin_lock(&vp->tx_queue->head_lock);
> +
>   	vp->estats.tx_timeout_count = 0;
>   	vp->estats.tx_restart_queue = 0;
>   	vp->estats.tx_kicks = 0;
> @@ -130,7 +137,10 @@ static void vector_reset_stats(struct vector_private *vp)
>   	vp->estats.tx_flow_control_xoff = 0;
>   	vp->estats.tx_queue_max = 0;
>   	vp->estats.tx_queue_running_average = 0;
> -	spin_unlock(&vp->tx_queue->head_lock);
> +
> +	if (vp->tx_queue)
> +		spin_unlock(&vp->tx_queue->head_lock);
> +
>   }
>   
>   static int get_mtu(struct arglist *def)
> @@ -1168,15 +1178,15 @@ static int vector_poll(struct napi_struct *napi, int budget)
>   
>   	if ((vp->options & VECTOR_TX) != 0)
>   		tx_enqueued = (vector_send(vp->tx_queue) > 0);
> -	spin_lock(&vp->rx_queue->head_lock);
> -	if ((vp->options & VECTOR_RX) > 0)
> +	if ((vp->options & VECTOR_RX) > 0) {
> +		spin_lock(&vp->rx_queue->head_lock);
>   		err = vector_mmsg_rx(vp, budget);
> -	else {
> +		spin_unlock(&vp->rx_queue->head_lock);
> +	} else {
>   		err = vector_legacy_rx(vp);
>   		if (err > 0)
>   			err = 1;
>   	}
> -	spin_unlock(&vp->rx_queue->head_lock);
>   	if (err > 0)
>   		work_done += err;
>   

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


