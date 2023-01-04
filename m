Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1EBC46467
	for <linux-um@archiver.kernel.org>; Wed,  4 Jan 2023 08:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:To:Subject:MIME-Version:
	Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cVW9u6jegHfPQLKUFH4GA5rQ2xjMhvi1X3YvzgGPXeM=; b=H12awPEqqP1gnuqt4HKGaFyqvi
	ynUQEMlDVA9/UalPFdHJ7lY0UxI9zAi+pvO7JNnb2XaLyNHS8qJSwHabn2+bw9BM0Hp66KI26nwMl
	mAvnSuaq+bJMXllgpiaJYAGsrb+/72vbC92qDZCJqirVMgwfEgHQlj04K++8r6C2AZD57waEmUxib
	Z0QTkb6xtCO6R886o0rzF70z8J19rSHnai7AQh+cGMVupGo2lUvpTPzWsvyzlAmNLVIcFp/p4KIs2
	FEcILpvBkHN3e7fpI3jqVDiSA+M6ZeTIR3r7K1SjY3jdCZ6nRwD8CLsKGDPT0QHtImYiH/oSHbW3/
	IGnvATKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCzM6-007jKQ-1l; Wed, 04 Jan 2023 08:42:38 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCz9t-007eWT-AO
	for linux-um@lists.infradead.org; Wed, 04 Jan 2023 08:30:03 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1pCz9j-005EGa-9e; Wed, 04 Jan 2023 08:29:51 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1pCz9f-00617y-UC; Wed, 04 Jan 2023 08:29:50 +0000
Message-ID: <7bd5ca75-5e97-5afb-5da2-fd35d7ef8b80@cambridgegreys.com>
Date: Wed, 4 Jan 2023 08:29:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2] um: vector: Fix memory leak in vector_config
Content-Language: en-US
To: Miaoqian Lin <linmq006@gmail.com>, Richard Weinberger <richard@nod.at>,
 Johannes Berg <johannes@sipsolutions.net>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230104081408.4074275-1-linmq006@gmail.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <20230104081408.4074275-1-linmq006@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230104_003001_496607_9F4146DB 
X-CRM114-Status: GOOD (  14.28  )
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



On 04/01/2023 08:14, Miaoqian Lin wrote:
> kstrdup() return newly allocated copy of the string.
> Call kfree() to release the memory when uml_parse_vector_ifspec() fails.
> 
> Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> changes in v2:
> - only call kfree() when uml_parse_vector_ifspec() fails.
> ---
>   arch/um/drivers/vector_kern.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index ded7c47d2fbe..131b7cb29576 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -767,6 +767,7 @@ static int vector_config(char *str, char **error_out)
>   
>   	if (parsed == NULL) {
>   		*error_out = "vector_config failed to parse parameters";
> +		kfree(params);
>   		return -EINVAL;
>   	}
>   

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
