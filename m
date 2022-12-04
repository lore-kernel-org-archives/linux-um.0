Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4B6C4321E
	for <linux-um@archiver.kernel.org>; Sun,  4 Dec 2022 16:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4at30IgEf5TJ+ue/McGf9+CNvf1Y6tMmQmxG4VlKQk8=; b=xjAP+PLeG++Y0u
	0rVdh4rhx5iNi8NcQGvgKs5faI8dMpQZtnPZY/yTCaip5cRs2IHH97c3Tx9OaxHg3IH28pb8R2WbE
	rjHpUXT80qqS3iiDy4L5iRF8zcUyKCmXb/5jd8W4XUWFcvma8x+A50/V9+hpQRSTeYYV3pyf8Cxzg
	tMzdiG7HAjDBL6YIyVii7QlD/lKnDf9+f0yFOHHwlWnaw6WvhTkGysLrpexKGQB6abuOSTjjIpBgU
	teQ+lDr1Osbs9bXty4iNSwWfK5sgtDVtUGJ7ZhnP3gV6jO1XuKin4boCT7BbieC8dL09aHRuO7vDe
	pykHTfRwlB6pvQK9d0jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p1raa-009YTw-AD; Sun, 04 Dec 2022 16:11:36 +0000
Received: from [2601:1c2:d80:3110::a2e7]
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p1rZI-009Y2B-Lh; Sun, 04 Dec 2022 16:10:16 +0000
Message-ID: <12a78373-024a-1e50-01c1-10985815ff1f@infradead.org>
Date: Sun, 4 Dec 2022 08:10:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] infiniband: disable IB HW for UML
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 Christoph Hellwig <hch@infradead.org>, linux-rdma@vger.kernel.org,
 Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
References: <20221202211940.29111-1-rdunlap@infradead.org>
 <Y4ye8YOWk0V/BqKL@unreal>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Y4ye8YOWk0V/BqKL@unreal>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org



On 12/4/22 05:21, Leon Romanovsky wrote:
> On Fri, Dec 02, 2022 at 01:19:40PM -0800, Randy Dunlap wrote:
>> Disable all of drivers/infiniband/hw/ for UML builds until someone
>> needs it and provides patches to support it.
>>
>> This prevents build errors in hw/qib/qib_wc_x86_64.c.
>>
>> Fixes: 68f5d3f3b654 ("um: add PCI over virtio emulation driver")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Suggested-by: Leon Romanovsky <leon@kernel.org>
>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>> Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
>> Cc: Christoph Hellwig <hch@infradead.org>
>> Cc: linux-rdma@vger.kernel.org
>> Cc: Jeff Dike <jdike@addtoit.com>
>> Cc: Richard Weinberger <richard@nod.at>
>> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>> Cc: Johannes Berg <johannes@sipsolutions.net>
>> Cc: linux-um@lists.infradead.org
>> ---
>> v2: just disable infiniband/hw/, not all of infiniband.
>>
>>  drivers/infiniband/Kconfig |    2 ++
>>  1 file changed, 2 insertions(+)
> 
> I added rdmavt to the mix and applied.

Sounds good. Thanks.

> https://lore.kernel.org/linux-rdma/20221130200958.25305-1-rdunlap@infradead.org/
> 
> diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
> index 6ee97c898231..a5827d11e934 100644
> --- a/drivers/infiniband/Kconfig
> +++ b/drivers/infiniband/Kconfig
> @@ -95,8 +95,8 @@ source "drivers/infiniband/hw/qedr/Kconfig"
>  source "drivers/infiniband/hw/qib/Kconfig"
>  source "drivers/infiniband/hw/usnic/Kconfig"
>  source "drivers/infiniband/hw/vmw_pvrdma/Kconfig"
> -endif # !UML
>  source "drivers/infiniband/sw/rdmavt/Kconfig"
> +endif # !UML
>  source "drivers/infiniband/sw/rxe/Kconfig"
>  source "drivers/infiniband/sw/siw/Kconfig"
>  endif
> (END)

-- 
~Randy

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
