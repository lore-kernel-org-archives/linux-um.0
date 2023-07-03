Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7782EB64DD
	for <linux-um@archiver.kernel.org>; Mon,  3 Jul 2023 10:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VG0VKjHUkFDVd3vUxFgx05X1Mbxp+At/Gy5IFiPk5cI=; b=1ttQYa68Uj/kLN
	njd/aHkqG5cyZeSy888fpG67PKARz8k6jwe+oCjkLzrjsNGo7p+7XYxA7iVNVr2k/WbH4IlWtOwH9
	C+nFXXtEBQotBqJw7fiyGopmFGuVAH9BieMw1a9Bf0OfFtxYULSzkg65Y+wYsb/pSVNJFz6Tq4yPa
	XddE3G0I3CLqqe/gX8RJoI9hrkU2h8I0fsxXGBM4D383l1PafmRU1EAPZjisUvW3MDwg8Jp8f/Hii
	OC5j7+IjrWRhHSoWeBpM+0I9pbk9HjHIut0x/6zJQjNk8OTkun7uq7mp+avcaQeguEZbwxizHWMUz
	WWtuLI/Y54sm/Al4EQDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGGve-00AGsl-0g;
	Mon, 03 Jul 2023 10:37:10 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGGva-00AGr9-1o
	for linux-um@lists.infradead.org;
	Mon, 03 Jul 2023 10:37:08 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qGGXt-00GBFP-J6; Mon, 03 Jul 2023 10:12:39 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qGGXs-009cOI-P3; Mon, 03 Jul 2023 11:12:38 +0100
Message-ID: <69e863ac-192d-2f63-62bb-8decdd719282@cambridgegreys.com>
Date: Mon, 3 Jul 2023 11:12:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1] drivers: use free_netdev before return
Content-Language: en-US
To: Minjie Du <duminjie@vivo.com>, richard@nod.at, johannes@sipsolutions.net,
 sfr@canb.auug.org.au, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org, machel@vivo.com
Cc: opensource.kernel@vivo.com
References: <20230703094135.6443-1-duminjie@vivo.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <20230703094135.6443-1-duminjie@vivo.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_033706_598673_42ABC365 
X-CRM114-Status: GOOD (  11.66  )
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



On 03/07/2023 10:41, Minjie Du wrote:
> We fixed a bug where the variable dev
> was not freed before return.
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>   arch/um/drivers/vector_kern.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index 131b7cb29..af7f6fd4c 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -1655,6 +1655,7 @@ static void vector_eth_configure(
>   	return;
>   
>   out_undo_user_init:

undo_user_init looks like an orphan from older code versions.

It should go away completely - jump to out_free_netdev instead.

> +	free_netdev(dev);
>   	return;
>   out_free_netdev:
>   	free_netdev(dev);

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
