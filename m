Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A94C433FE
	for <linux-um@archiver.kernel.org>; Wed, 16 Nov 2022 16:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V2cRZwVY/3ggBd2qXkUFn+oSUn3qAIjVl15NOWgEb8U=; b=oAYApoa79EURts
	sNiBX9q1Z3E3CzzE2Tygpzxl+3mE2miwdoGwoVIN0l8WNyevsnUz8znN82YvnUyq1YOvZlKNWfK4P
	yNAJm6EvA4H3PGFLfm8rz3WKopEgDpVub3QOuHcs3nb4MuX/OHhLtxr6qiQyErvnFFAAYGXqUVIqK
	mxORs66VdEWKPMmF30fGs/LbcsuRZNVj5SYX6tussASjeBbuSjz4jrVYUrK/ksVT5A1LlO/uSEjbo
	9YjmE+7xi2+SGy5Xq1mpaZkr9kzBzRuohHdSFF0kes5x9DBCVtEF2Agc8DkxnG42hc5dqMnt9Du7D
	UVMNRDhgE+XAHpmym4jQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovLL0-005tS7-Nf; Wed, 16 Nov 2022 16:32:34 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovLKy-005tQe-BN
	for linux-um@lists.infradead.org; Wed, 16 Nov 2022 16:32:34 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1ovKyw-002vdR-5F; Wed, 16 Nov 2022 16:09:46 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1ovKyt-002AiB-IG; Wed, 16 Nov 2022 16:09:45 +0000
Message-ID: <9a106cdc-03ea-cec6-1ef7-3c6fbf5ae753@cambridgegreys.com>
Date: Wed, 16 Nov 2022 16:09:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH -next] um: vector: Fix memory leak in vector_config
Content-Language: en-US
To: Xiang Yang <xiangyang3@huawei.com>, patchwork@huawei.com,
 kuba@kernel.org, richard@nod.at, johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221115073225.161592-1-xiangyang3@huawei.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <20221115073225.161592-1-xiangyang3@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_083232_417829_C2F9B8DE 
X-CRM114-Status: GOOD (  13.57  )
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



On 15/11/2022 07:32, Xiang Yang wrote:
> If the return value of the uml_parse_vector_ifspec function is NULL,
> we should call kfree(params) to prevent memory leak.
> 
> Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
> Signed-off-by: Xiang Yang <xiangyang3@huawei.com>
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

Acked-By: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
