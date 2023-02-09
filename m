Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C12C636D3
	for <linux-um@archiver.kernel.org>; Thu,  9 Feb 2023 19:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1RjTlR35f26WJihd4zQ7E0Wm6/J5BGX4bSi0/hS/H08=; b=PHlys40uvDejOF
	/tRjrduUMdiMzQQwtBVpTXtcPoSIUfGac0eorkhOwLen9Ew/v36Vxo1engeVIMenRirlTBG34NILZ
	kb03I+XrAIHqa7plS3rFd5qX7k1rzr6yV8dsxCDiwvCfUKm4+8VPH7KM5nk5R/BeUYQqTEVjn4ANg
	kNbDeyAyeeYB6nvMjILpzHtvzoAtuFwoEEm7/E/X6v0bB9ZjvF9q+vYRqc0vPipw2f9Se+0CmzliM
	JgU2yDEnBDtTrRUSdAmFW5AEf/9l+X2Wj5fy7q5Vzi1jEySslMqWb4ao0h35G3B7DX3lR8jDScClz
	AVDjY732ptukE3Ny+7gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQCC3-002vke-JZ; Thu, 09 Feb 2023 19:02:51 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQCC1-002vjd-9O
	for linux-um@lists.infradead.org; Thu, 09 Feb 2023 19:02:50 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1pQCBu-007WLV-2x; Thu, 09 Feb 2023 19:02:42 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1pQCBr-0075G5-8A; Thu, 09 Feb 2023 19:02:41 +0000
Message-ID: <cc1d4868-ee89-519b-9415-1ee2f442d73e@cambridgegreys.com>
Date: Thu, 9 Feb 2023 19:02:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] uml: vector: Remove unused definitions
 VECTOR_{WRITE,HEADERS}
Content-Language: en-US
To: Carlos Bilbao <carlos.bilbao@amd.com>, richard@nod.at,
 johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230209181638.3781977-1-carlos.bilbao@amd.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
In-Reply-To: <20230209181638.3781977-1-carlos.bilbao@amd.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230209_110249_378364_84F57149 
X-CRM114-Status: GOOD (  10.91  )
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

On 09/02/2023 18:16, Carlos Bilbao wrote:
> Remove definitions of VECTOR_WRITE and VECTOR_HEADERS since no longer used.
> 
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>   arch/um/drivers/vector_user.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/um/drivers/vector_user.h b/arch/um/drivers/vector_user.h
> index 3a73d17a0161..59ed5f9e6e41 100644
> --- a/arch/um/drivers/vector_user.h
> +++ b/arch/um/drivers/vector_user.h
> @@ -68,8 +68,6 @@ struct vector_fds {
>   };
>   
>   #define VECTOR_READ	1
> -#define VECTOR_WRITE	(1 < 1)
> -#define VECTOR_HEADERS	(1 < 2)
>   
>   extern struct arglist *uml_parse_vector_ifspec(char *arg);
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
