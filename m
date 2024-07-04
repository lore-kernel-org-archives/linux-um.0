Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FEFC30653
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 07:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6GndiVeT1AhSHubZONmnFV3TOE75XHNgdZLorBW+BDk=; b=IdGkrKJnvQhMrlXLPp3cxXdPVo
	nW0iedLeVGHaizPR+F0m2yJ1J08Ap9jS9ORnmTjJh/mDTnN9Tv34QSvSFzoN4GxhE1sZk1GjVsq7I
	EMvRfErhg6qatYCdRjNFwc3nwFNPSxLSjYe4VWj/9m4qNsusDrszCHAdn3QXq7GCcYyWS2sz1IlV+
	Z6opKYu5Jh2wUzeOZrYLoWvqDUFaNTh4nDSWP664kIYqthRpoo4Sdh+P3MmKHlZ9FNyN33CWHNBfo
	Gh8Y8YRLESkr+RFDp9qud0AY9GxVF8zOyc5JigqLy1HYgSIWOPKDQDMt/MjaKrZ4um8tCXQ+TDwCi
	FDNIswEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPGSb-0000000CP4d-30Kd;
	Thu, 04 Jul 2024 07:00:53 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPGSY-0000000CP49-1zH7
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 07:00:52 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1sPGSW-005c79-Pb; Thu, 04 Jul 2024 07:00:48 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1sPGSU-0079I9-0M;
	Thu, 04 Jul 2024 08:00:48 +0100
Message-ID: <508f29fd-67bb-4b1a-b248-d57b78c9ad52@kot-begemot.co.uk>
Date: Thu, 4 Jul 2024 08:00:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: vector: always reset vp->opened
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20240703184622.df40c5c38461.Id4e20b48938c6019d99e6133227a34ac059db466@changeid>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <20240703184622.df40c5c38461.Id4e20b48938c6019d99e6133227a34ac059db466@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_000050_551783_DD7B35B3 
X-CRM114-Status: GOOD (  15.07  )
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



On 03/07/2024 17:46, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> If open fails, we have already set vp->opened, but it's
> not reset so that any further attempts will just return
> -ENXIO. Reset vp->opened even if close has nothing to do.
> 
> This helps e.g. with slirp4netns handling only a single
> connection, you can then restart it and open the device
> again.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   arch/um/drivers/vector_kern.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index 0861e32d2fbd..2d473282ab51 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -1119,6 +1119,8 @@ static int vector_net_close(struct net_device *dev)
>   	netif_stop_queue(dev);
>   	del_timer(&vp->tl);
>   
> +	vp->opened = false;
> +
>   	if (vp->fds == NULL)
>   		return 0;
>   
> @@ -1157,7 +1159,6 @@ static int vector_net_close(struct net_device *dev)
>   		destroy_queue(vp->tx_queue);
>   	kfree(vp->fds);
>   	vp->fds = NULL;
> -	vp->opened = false;
>   	vp->in_error = false;
>   	return 0;
>   }
Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

