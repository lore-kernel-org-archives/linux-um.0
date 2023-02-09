Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDC6C636D6
	for <linux-um@archiver.kernel.org>; Thu,  9 Feb 2023 17:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dZrQZBbPEdpM/17BR21TAH8q4Lv3bTNLKurnGJpuQMs=; b=Hq4H7L09HcH+jS
	2ju0znfIV1Y8c/HZKp8H7pE5fRp4PSgUdARzt5FIrr8RL7Va7wtdKCFm49qxRANRvk+zCTa25/pr4
	KD5ZqtDIBIN+jEwtZ/KJ9LGEB/okU7RpD8bAgBrZbSZyG8vxQxi9GC9hRYe6BtxOlIKSwzPjUTLXz
	e8twRZgCQRQ4fuJyXYB9+J2UBKiDU/key356jROM/osbE5QunlnPB7pX/vsO7H37EPRE9BqaKJtys
	GYdHIcFo9bw9m4ZB3Sfo24zQxCIUnSYYXq603U4ttyJh3qynOb3NzXlQ6Q0+yUFbLFisjCTt8eY8X
	+H8fv5IA4t/QdBIfNipg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQAml-002aSW-SD; Thu, 09 Feb 2023 17:32:39 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQAmi-002aRR-T7
	for linux-um@lists.infradead.org; Thu, 09 Feb 2023 17:32:38 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1pQASy-007WDm-Nc; Thu, 09 Feb 2023 17:12:12 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1pQASw-006zQ5-00; Thu, 09 Feb 2023 17:12:12 +0000
Message-ID: <2faee789-80d0-656f-64ce-3e090ba9d7c2@cambridgegreys.com>
Date: Thu, 9 Feb 2023 17:12:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] uml: vector: fix definitios of VECTOR_WRITE and
 VECTOR_HEADERS
Content-Language: en-US
To: Carlos Bilbao <carlos.bilbao@amd.com>, richard@nod.at,
 johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230209161916.3729757-1-carlos.bilbao@amd.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
In-Reply-To: <20230209161916.3729757-1-carlos.bilbao@amd.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230209_093236_968995_AD2F990A 
X-CRM114-Status: GOOD (  13.75  )
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

On 09/02/2023 16:19, Carlos Bilbao wrote:
> Fix definitions of VECTOR_WRITE and VECTOR_HEADERS with proper bitwise
> operand for bit shift.
> 
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>   arch/um/drivers/vector_user.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/drivers/vector_user.h b/arch/um/drivers/vector_user.h
> index 3a73d17a0161..f7d3956f5c15 100644
> --- a/arch/um/drivers/vector_user.h
> +++ b/arch/um/drivers/vector_user.h
> @@ -68,8 +68,8 @@ struct vector_fds {
>   };
>   
>   #define VECTOR_READ	1
> -#define VECTOR_WRITE	(1 < 1)
> -#define VECTOR_HEADERS	(1 < 2)
> +#define VECTOR_WRITE	(1 << 1)
> +#define VECTOR_HEADERS	(1 << 2)
>   
>   extern struct arglist *uml_parse_vector_ifspec(char *arg);
>   

I need to have a look at the code how it even worked before. Will ack 
after that.
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
