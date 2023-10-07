Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E15E9371B
	for <linux-um@archiver.kernel.org>; Sat,  7 Oct 2023 06:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vq7EMwYVcyLet8wID94LeQp3SmfXDdC239yyZKnRkuk=; b=Km3Mp/Sr7OPmcW
	CmQxoPccbXeidOhh5SZgHsrj+P9J+QFnKF6LQS+YFE+wVuGMEgsc9qL0iEnJntYYb7HYlqmy5sfPL
	3R291OqxUmuE5QRS5wYLLh3kUwo2Db7Y2b9DwoJU6JjT4CBbuc3SB4uDbKcZjIkWzTzHnRVHLtxE9
	TcztK3Urlaz+n0LGAEZcRxImGG48ZBln4L6WziCsjoW+4l99I+sbjoohzM0kDGZ280dlkXoenCq4N
	wFg49rNxb8B6dTa8SDRgPUZsRoMG5myY23moDpAgHnpCvVydD0ZoMbUuVzIm2eI7E/Dzv5Rlquhcy
	/vUa/fqMo1zXRzkrOGRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qp193-0075ST-2l;
	Sat, 07 Oct 2023 06:50:37 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qp18z-0075RC-27
	for linux-um@lists.infradead.org;
	Sat, 07 Oct 2023 06:50:36 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qp0YY-003YDr-MS; Sat, 07 Oct 2023 06:12:54 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qp0YU-00EeYm-0R;
	Sat, 07 Oct 2023 07:12:54 +0100
Message-ID: <c6c0dea2-bbf6-80a6-1888-c1fa4718d4c2@cambridgegreys.com>
Date: Sat, 7 Oct 2023 07:12:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] um: vector: fix return value check in vector_mmsg_rx
Content-Language: en-US
To: Ma Ke <make_ruc2021@163.com>, richard@nod.at, johannes@sipsolutions.net,
 xiangyang3@huawei.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231007005104.3994678-1-make_ruc2021@163.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
In-Reply-To: <20231007005104.3994678-1-make_ruc2021@163.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231006_235033_695363_F138805D 
X-CRM114-Status: GOOD (  15.84  )
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

On 07/10/2023 01:51, Ma Ke wrote:
> In vector_mmsg_rx, to avoid an unexpected result returned by
> pskb_trim, we should check the return value of pskb_trim().
> 
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>   arch/um/drivers/vector_kern.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index 131b7cb29576..c280ce5ea6ce 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -1013,8 +1013,8 @@ static int vector_mmsg_rx(struct vector_private *vp, int budget)
>   					skb->ip_summed = CHECKSUM_UNNECESSARY;
>   				}
>   			}
> -			pskb_trim(skb,
> -				mmsg_vector->msg_len - vp->rx_header_size);
> +			if (pskb_trim(skb, mmsg_vector->msg_len - vp->rx_header_size))
> +				return 0;
>   			skb->protocol = eth_type_trans(skb, skb->dev);
>   			/*
>   			 * We do not need to lock on updating stats here

That does not look right. You can have errors when processing an 
individual packet. That is not a reason to bail and you should process 
the next ones. This way you just dropped the rest of the RX vector (up 
to 64 packets at default settings).

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
