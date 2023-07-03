Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66800EB64DD
	for <linux-um@archiver.kernel.org>; Mon,  3 Jul 2023 13:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oh7mXc2sLTvHFu1OWOe3C0z5Ki7wCJTOxTUMWwcpckg=; b=w1AtHiLka7GsU7
	4HSnXSeMpJc01cKa6TPnYZe3410d+lFM0D1G8nW88qRkJTypewQiN3D3OXOIAZp7L2+q8WALnQDHQ
	A/PeeO9/G8WfDZ37Yl/HK6KmFcOFXB4stF1ewktZZP2sHxQZQJWJ3jO+BWKTaZHQX/hK2LUhQRUMD
	Yoo5Y8kPVtC8W+OrJedN3wadHdNrNCVUT6yjGquWZck80qOD1aRrxF5x59xsfuRtkb4MraouQT0f/
	frLiNJnqwhvnKBa2nLtoBtSS591HCRV/ah1Okm/YgmouGij5fuxDTCHyBfPLunKCoE8hWnq1fvfix
	3Y835rSacQF8F6AXU4RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGJT4-00Ac1V-1M;
	Mon, 03 Jul 2023 13:19:50 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGJT1-00Ac0q-1Z
	for linux-um@lists.infradead.org;
	Mon, 03 Jul 2023 13:19:49 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qGJSt-00GBX4-SU; Mon, 03 Jul 2023 13:19:41 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qGJSt-009o8A-0T; Mon, 03 Jul 2023 14:19:41 +0100
Message-ID: <aa29acfe-0973-54dc-a4d8-2b0f06dc805c@cambridgegreys.com>
Date: Mon, 3 Jul 2023 14:19:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] drivers: use free_netdev before return
Content-Language: en-US
To: Minjie Du <duminjie@vivo.com>, richard@nod.at, johannes@sipsolutions.net,
 sfr@canb.auug.org.au, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org, 11162212@vivo.com
Cc: opensource.kernel@vivo.com
References: <20230703131129.8588-1-duminjie@vivo.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <20230703131129.8588-1-duminjie@vivo.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_061947_544033_4544B394 
X-CRM114-Status: GOOD (  12.51  )
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



On 03/07/2023 14:11, Minjie Du wrote:
> We will replace the old version of
> undo_user_init and use out_free_netdev
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>   arch/um/drivers/vector_kern.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index af7f6fd4c..7ae6ab8df 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -1646,7 +1646,7 @@ static void vector_eth_configure(
>   	err = register_netdevice(dev);
>   	rtnl_unlock();
>   	if (err)
> -		goto out_undo_user_init;
> +		goto out_free_netdev;
>   
>   	spin_lock(&vector_devices_lock);
>   	list_add(&device->list, &vector_devices);
> @@ -1654,9 +1654,6 @@ static void vector_eth_configure(
>   
>   	return;
>   
> -out_undo_user_init:
> -	free_netdev(dev);
> -	return;
>   out_free_netdev:
>   	free_netdev(dev);
>   out_free_device:

Acked-By: "Anton Ivanov" <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
