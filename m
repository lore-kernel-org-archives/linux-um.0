Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD3CC25B76
	for <linux-um@archiver.kernel.org>; Tue, 11 Jun 2024 05:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WhW2ERJjBec0Ifs1w3WEYUaBRX1+73WAhyQmrUQLWdA=; b=IpCiQW0htUtaMWn1cY7AlWQcir
	ii06DrZGmwqgJArKVw83dTYZDTPbAAvBfSORTBFlxIVHCvTao17U+uOShxtXGd1XISM1ZB0Zw6StE
	xWH/EjkMqKHlDsNpS1CwON036I8fBWl0T27yKGO/9vFUO05e+HuNWlS5YSiooUGuOlkIx9Hn9TPA+
	46iAjF/LLGf6GOefs8zNafad9ZJBK3eZzmOuXDoVsm/1/g0/idZTkXGQ+kZCod4XTkixzmhpD/plA
	A89d6IYh3wkiWjV1XCbfBs/atrXISt0hRUmiAtgMnGzjZLXAfurUumq4bqBRpJc9JzXVBTwyru/bp
	uDY/wGkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGuPy-00000007a1X-16xw;
	Tue, 11 Jun 2024 05:51:38 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGuPs-00000007a0e-13yF;
	Tue, 11 Jun 2024 05:51:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1ABDF60C8C;
	Tue, 11 Jun 2024 05:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8B3C2BD10;
	Tue, 11 Jun 2024 05:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718085090;
	bh=n/truQQNALnyrE4ZbwFnrA1tq2cozaH91kaKcSN3ADo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ANn0WrF5kOQJZxWO+lYlEGkU5hVzQiFb2dNu1fRL0d2IWY3RReTj+asObSRTOVsDn
	 nik3p07qhEGu9jO0A5uH0hbRiLwLOJ3d6qy5Lpfrdzdf1JpR8Qb6Y+TeigefvpTdHC
	 PaMP9CtOKbfsr2fBnfzUYFtnczoPg5lf2QS4Trvu+DMNLb/UDOZQCC9uHBx6LdmPM8
	 /dgqDFvO1q4KPpY9GF6hhisUoWhTc6hasUEAygvr3guCne7aOz50r92/yOBM880RPV
	 /mezANfcSB8zUh/+nThd+2qNqFJrJ+m45Wswa5U72/uWVWbOFnW/S5hmwY1Gx82O5w
	 +K3mqL1+sk3wQ==
Message-ID: <40ca8052-6ac1-4c1b-8c39-b0a7948839f8@kernel.org>
Date: Tue, 11 Jun 2024 14:51:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/26] sd: move zone limits setup out of
 sd_read_block_characteristics
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Richard Weinberger <richard@nod.at>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
 Yu Kuai <yukuai3@huawei.com>, Vineeth Vijayan <vneethv@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org,
 drbd-dev@lists.linbit.com, nbd@other.debian.org,
 linuxppc-dev@lists.ozlabs.org, ceph-devel@vger.kernel.org,
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
References: <20240611051929.513387-1-hch@lst.de>
 <20240611051929.513387-3-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240611051929.513387-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_225134_208770_72F128DB 
X-CRM114-Status: GOOD (  21.80  )
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

On 6/11/24 2:19 PM, Christoph Hellwig wrote:
> Move a bit of code that sets up the zone flag and the write granularity
> into sd_zbc_read_zones to be with the rest of the zoned limits.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/scsi/sd.c     | 21 +--------------------
>  drivers/scsi/sd_zbc.c | 13 ++++++++++++-
>  2 files changed, 13 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 85b45345a27739..5bfed61c70db8f 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -3308,29 +3308,10 @@ static void sd_read_block_characteristics(struct scsi_disk *sdkp,
>  		blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, q);
>  	}
>  
> -
> -#ifdef CONFIG_BLK_DEV_ZONED /* sd_probe rejects ZBD devices early otherwise */
> -	if (sdkp->device->type == TYPE_ZBC) {
> -		lim->zoned = true;
> -
> -		/*
> -		 * Per ZBC and ZAC specifications, writes in sequential write
> -		 * required zones of host-managed devices must be aligned to
> -		 * the device physical block size.
> -		 */
> -		lim->zone_write_granularity = sdkp->physical_block_size;
> -	} else {
> -		/*
> -		 * Host-aware devices are treated as conventional.
> -		 */
> -		lim->zoned = false;
> -	}
> -#endif /* CONFIG_BLK_DEV_ZONED */
> -
>  	if (!sdkp->first_scan)
>  		return;
>  
> -	if (lim->zoned)
> +	if (sdkp->device->type == TYPE_ZBC)

Nit: use sd_is_zoned() here ?

>  		sd_printk(KERN_NOTICE, sdkp, "Host-managed zoned block device\n");
>  	else if (sdkp->zoned == 1)
>  		sd_printk(KERN_NOTICE, sdkp, "Host-aware SMR disk used as regular disk\n");
> diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
> index 422eaed8457227..e9501db0450be3 100644
> --- a/drivers/scsi/sd_zbc.c
> +++ b/drivers/scsi/sd_zbc.c
> @@ -598,8 +598,19 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, struct queue_limits *lim,
>  	u32 zone_blocks = 0;
>  	int ret;
>  
> -	if (!sd_is_zoned(sdkp))
> +	if (!sd_is_zoned(sdkp)) {
> +		lim->zoned = false;

Maybe we should clear the other zone related limits here ? If the drive is
reformatted/converted from SMR to CMR (FORMAT WITH PRESET), the other zone
limits may be set already, no ?

>  		return 0;
> +	}
> +
> +	lim->zoned = true;
> +
> +	/*
> +	 * Per ZBC and ZAC specifications, writes in sequential write required
> +	 * zones of host-managed devices must be aligned to the device physical
> +	 * block size.
> +	 */
> +	lim->zone_write_granularity = sdkp->physical_block_size;
>  
>  	/* READ16/WRITE16/SYNC16 is mandatory for ZBC devices */
>  	sdkp->device->use_16_for_rw = 1;

-- 
Damien Le Moal
Western Digital Research


