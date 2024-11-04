Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD71D1BDDA
	for <linux-um@archiver.kernel.org>; Mon,  4 Nov 2024 18:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CTLFYHN8t979OFYR2S87Eawk+1knpNYQfq+zser50B0=; b=1+uFZxo0pg00arr0GvtJzjCbOy
	ZykcTlDCnpvuQbPW4KpU0ttxiTcs7KgY74PBcDYxChomm8Q4oNUt/e+MSgw9EpQZYh7zf7BHl8URZ
	FyUr3RBeFOfv5DlXCg3WRAPk3e3onrE6x0bdm0jFMya8LAUztiuG068FaeqRH44z4QYWZBZSyO9Jd
	iSg12oXYg0oSDlJ9n9z4zWcayPMyK3X47YWKARq8qmLDuUEV+TunfMsE/gZFWNOmxdJEfff6iFSUV
	CTIluVCCPs6pC5mjmNcRw3iWhqlc0o3iCIv90ksOlxUSXjDaJO1TXMBCTfLxjNf9PZD4FdiFaLBsE
	w5pfdsJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t81NR-0000000EdNi-0aYa;
	Mon, 04 Nov 2024 18:00:33 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t80vT-0000000EXem-1YZu
	for linux-um@lists.infradead.org;
	Mon, 04 Nov 2024 17:31:41 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1t80MF-00Dwhu-Vt; Mon, 04 Nov 2024 16:55:16 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1t80MD-00C1ZX-0k;
	Mon, 04 Nov 2024 16:55:15 +0000
Message-ID: <8b4f592c-bdc9-4a2b-bf97-afe11b840d4b@cambridgegreys.com>
Date: Mon, 4 Nov 2024 16:55:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] um: ubd: Initialize ubd's disk pointer in ubd_add
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at,
 johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241104163203.435515-1-tiwei.btw@antgroup.com>
 <20241104163203.435515-2-tiwei.btw@antgroup.com>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <20241104163203.435515-2-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_093139_430926_A1ED58E0 
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org



On 04/11/2024 16:32, Tiwei Bie wrote:
> Currently, the initialization of the disk pointer in the ubd structure
> is missing. It should be initialized with the allocated gendisk pointer
> in ubd_add().
> 
> Fixes: 32621ad7a7ea ("ubd: remove the ubd_gendisk array")
> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> ---
>   arch/um/drivers/ubd_kern.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index 2b8d04e67600..f19173da64d8 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -898,6 +898,8 @@ static int ubd_add(int n, char **error_out)
>   	if (err)
>   		goto out_cleanup_disk;
>   
> +	ubd_dev->disk = disk;
> +
>   	return 0;
>   
>   out_cleanup_disk:

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

