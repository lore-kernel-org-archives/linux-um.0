Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7F5C41513
	for <linux-um@archiver.kernel.org>; Wed, 29 May 2024 08:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GoGsu9HoHxrzQDkQViIw41HuSUOX6Krq6zTNB3ZFjX0=; b=NBzUndLmpbGFUVlh64ShtqFQM7
	Jb6tIWLiZeoz8LqpNc5/M0P46XXOm2zGaD0ZXRrQYZ4d3u1D1VG+TrytDc2b5G7qBJKWnajrBJE8E
	RCTA9UhSWAv0hlpgIYAC1JrU8KZWJyWBXx6bxWVLvxaHf340TEtQJ0YoJtrHLmuRHkUghywguNHJH
	nuDTADHiAe8Wdij3XrOTKCXqPy5J4MTKtgHA4OGG5jlhSTF6ri5g4lJQOsP3/tLSRW9zxhVkrmlIs
	85xA05IDVW62QPod0sXPxT43BO7oWOjcxZIYzxLVn/8vyGwITTmywi9cdUN+DdX0wnEwK55Cmchiy
	XVJdek7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCEJJ-00000003GsA-2sss;
	Wed, 29 May 2024 08:05:25 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCEJA-00000003Glo-0PdK
	for linux-um@lists.infradead.org;
	Wed, 29 May 2024 08:05:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8C59562769;
	Wed, 29 May 2024 08:05:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3FAC2BD10;
	Wed, 29 May 2024 08:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716969914;
	bh=blmbzNIoOv7Q3qES0R0/fx18waY7Hk11DTOByTzWHdc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SFYbjMJRJ6TIxFXkpgxG4GyzyI/tGBapJQlaGBsNH35uF5q0J/+ufhABOEt5aku5A
	 OGZ/sMeIOSXH403CaXaX972OKhKJYoQKJJDBM5BKOy6U8Nl6vudfsO6HMEQn0f+nwQ
	 EEJNnQcb59MH+bO1MBxpMjGfNAxOzKZEQYEFEGgG3tXhnEMyC0CEKrwsbiSwmPGa0h
	 XlxMBzvwrj6cpKyibCWOGaP3KUxu2jy3ox/5rATAy/QYehwu9ehrekMkeR3fcUmmMZ
	 Z5STO7HCskML/36YIjpBFP0Bm0HiT4KQ6nulMQvLBqHtZ3L7qdm7OgC52ERnL5CdaG
	 wz7IMJehNc1hg==
Message-ID: <f39216c0-f11d-4d4a-ae40-b4cf82e4760e@kernel.org>
Date: Wed, 29 May 2024 17:05:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] block: take io_opt and io_min into account for
 max_sectors
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, Josef Bacik
 <josef@toxicpanda.com>, Ilya Dryomov <idryomov@gmail.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 linux-um@lists.infradead.org, linux-block@vger.kernel.org,
 nbd@other.debian.org, ceph-devel@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org
References: <20240529050507.1392041-1-hch@lst.de>
 <20240529050507.1392041-3-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240529050507.1392041-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_010516_334781_0D73E64F 
X-CRM114-Status: GOOD (  17.24  )
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

On 5/29/24 14:04, Christoph Hellwig wrote:
> The soft max_sectors limit is normally capped by the hardware limits and
> an arbitrary upper limit enforced by the kernel, but can be modified by
> the user.  A few drivers want to increase this limit (nbd, rbd) or
> adjust it up or down based on hardware capabilities (sd).
> 
> Change blk_validate_limits to default max_sectors to the optimal I/O
> size, or upgrade it to the preferred minimal I/O size if that is
> larger than the kernel default if no optimal I/O size is provided based
> on the logic in the SD driver.
> 
> This keeps the existing kernel default for drivers that do not provide
> an io_opt or very big io_min value, but picks a much more useful
> default for those who provide these hints, and allows to remove the
> hacks to set the user max_sectors limit in nbd, rbd and sd.
> 
> Note that rd picks a different value for the optimal I/O size vs the
> user max_sectors value, so this is a bit of a behavior change that
> could use careful review from people familiar with rbd.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


