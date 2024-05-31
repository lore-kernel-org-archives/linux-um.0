Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FE8C25B7E
	for <linux-um@archiver.kernel.org>; Fri, 31 May 2024 05:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JVsbvbWVzhW4lOB/n8DqKnhIsWgMgTEnhFS4SBP0cNU=; b=I1RZkIttiVoOHj2WfT4JqnR5gL
	nGBptfB/XfeQKVN5jMy1sq8Fj/ZSDRUF/vBq32opK9/jbart2rYyyCuePcvRVjkmfYNiF2lZd3bX4
	9Hnb5D7ZQYqtPPk6RQE1J8oiFT8OvfJCFDrAOgMSKrcvNmytiXXLjFrxdmJWhQmVOYUZNmE4ZG/ab
	ThB2j4lXFLxfB7rcsOrATXT1mv/ws555OHt/n5hF2oLZKqcdFn9WBgv2vSjvFIaQSCTqp/ZzjSpI2
	cjk190t1s7r8axxjR8x+NBvMlCsNChaheePAH5npLyMg+qPQuH9purdsl3JAFy9QwDjp8URLLnWEB
	NRQAqWLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCv8I-00000009JFL-2kvo;
	Fri, 31 May 2024 05:48:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCv8E-00000009JDs-2Cok
	for linux-um@lists.infradead.org;
	Fri, 31 May 2024 05:48:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0721C68BEB; Fri, 31 May 2024 07:48:33 +0200 (CEST)
Date: Fri, 31 May 2024 07:48:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Josef Bacik <josef@toxicpanda.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	Roger Pau Monn?? <roger.pau@citrix.com>,
	linux-um@lists.infradead.org, linux-block@vger.kernel.org,
	nbd@other.debian.org, ceph-devel@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 09/12] sd: convert to the atomic queue limits API
Message-ID: <20240531054832.GB17396@lst.de>
References: <20240529050507.1392041-1-hch@lst.de> <20240529050507.1392041-10-hch@lst.de> <1a1854bb-1f28-44d1-a4ac-30872bd6c3c8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a1854bb-1f28-44d1-a4ac-30872bd6c3c8@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_224850_922555_FB365A38 
X-CRM114-Status: GOOD (  19.21  )
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

On Thu, May 30, 2024 at 10:16:33AM +0100, John Garry wrote:
>> -static void sd_config_write_same(struct scsi_disk *);
>> +static void sd_config_discard(struct scsi_disk *sdkp, struct queue_limits *lim,
>> +		unsigned int mode);
>
> Are there any reasons why we keep forward declarations like this? AFAICS, 
> this sd_config_discard forward declaration could be removed.

Mostly to avoid churn.  This is a series that needs to feed into the
block tree, so I don't want major churn in sd.c.  Maybe after the dust
has settled it would be nice to bring sd.c into a natural order.

>> -	blk_queue_max_write_zeroes_sectors(q, sdkp->max_ws_blocks *
>> -					 (logical_block_size >> 9));
>> +	lim->max_write_zeroes_sectors =
>> +		sdkp->max_ws_blocks * (logical_block_size >> 9);
>
> Would it be ok to use SECTOR_SHIFT here? A similar change is made in 
> sd_config_discard(), above

Sure.

>> +		sd_config_discard(sdkp, lim, sd_discard_mode(sdkp));
>>   	}
>>      out:
>> @@ -3278,10 +3290,10 @@ static void sd_read_block_limits_ext(struct scsi_disk *sdkp)
>>   }
>>     /**
>
> below is not a kernel doc comment

And that is on the one hand intentional to avoid documenting all the
obvious paramters in a local function, but on the other hand requires
removing the double *. Fixed.

>>   @@ -3683,28 +3696,33 @@ static int sd_revalidate_disk(struct gendisk 
>> *disk)
>>   	q->limits.max_dev_sectors = logical_to_sectors(sdp, dev_max);
>
>
> is setting q->limits.max_dev_sectors directly proper?

No, and I've already fixed it in my local tree.


