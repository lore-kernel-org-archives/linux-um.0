Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D34606A319
	for <linux-um@archiver.kernel.org>; Tue, 20 Oct 2026 08:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qcHopwEx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0HS6tT3KdrhmD3sjNiNbCvEXsKi2u4/Jhk//K3aXK8A=; b=qcHopwExCwqGJzBqbFuSMf2c9G
	o/4j/K2qY3u39dSDlnPbi2AExtgfGs56urhl/6P0qS27GAVgSxgISmor86IF2wbEk3TtcQMGCHszo
	Yg2MgdC0CZUTEpFm7U2v38JnwXVG/25JYRHNs0DCUmZJLWIqETTjZPhS2EkjdIjcUdfhu5akBq+kw
	i5reKbkcPW8Yp+jFY6FwfH3kyMzJAQPH4ymMQ5u+7bHOF8/DVt/R5QnpRVPtsOWWq0GikBwa8P49i
	0RpW8/Rbphv1kXElA3bBi4zG3Aiv4q1LTMDaWmQ9nyAZCRiO9JodInRZjApcSbDrYrQZzmrcvMgty
	Ure6PIng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ4nG-000000096tN-1Zs0;
	Tue, 20 Oct 2026 08:01:58 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ4n9-000000096rz-3Zlu
	for linux-um@lists.infradead.org;
	Tue, 20 Oct 2026 08:01:57 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1xJ4PP-008pey-S5; Tue, 20 Oct 2026 07:37:19 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1xJ46y-00000002MYI-39we;
	Tue, 20 Oct 2026 08:37:18 +0100
Message-ID: <e1418f63-6815-4732-b07f-934414ebd124@cambridgegreys.com>
Date: Tue, 20 Oct 2026 08:37:17 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: vector: use kmalloc_objs() for the message vector
To: Hungyu Lin <dennylin0707@gmail.com>, Richard Weinberger <richard@nod.at>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261020072035.8980-1-dennylin0707@gmail.com>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
In-Reply-To: <20261020072035.8980-1-dennylin0707@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_010151_900656_406F4247 
X-CRM114-Status: GOOD (  11.42  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 20/10/2026 08:20, Hungyu Lin wrote:
> Allocate mmsg_vector with kmalloc_objs() so the element size is derived
> from the destination type and the allocation helper handles multiplication
> overflow. The default allocation flags remain GFP_KERNEL.
> 
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>   arch/um/drivers/vector_kern.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index e902e78c5ff6..d6127944b202 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -528,8 +528,7 @@ static struct vector_queue *create_queue(
>   		return NULL;
>   	result->max_depth = max_size;
>   	result->dev = vp->dev;
> -	result->mmsg_vector = kmalloc(
> -		(sizeof(struct mmsghdr) * max_size), GFP_KERNEL);
> +	result->mmsg_vector = kmalloc_objs(*result->mmsg_vector, max_size);
>   	if (result->mmsg_vector == NULL)
>   		goto out_mmsg_fail;
>   	result->skbuff_vector = kmalloc(
> 
> base-commit: 4ad423aa2108485f8bc5dde51fdf9c1ed979ee4b
> 
> 
Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661

