Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE27C25B74
	for <linux-um@archiver.kernel.org>; Thu, 30 May 2024 20:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mbOtu3q9zjV5nBmJEGmUM2ChlXZYTtjXht6IjdlxuYo=; b=U34hI9rLNHUi4gvdr9hdxORbyk
	iNiMyQye8JPYAx9/kvzIQK0lfvRIWKI31+LB33l+f49Nb1UPUSCRaBri7faUDikbYvwLywHMrFzMY
	5DuhlrSZRqE9oQGEuA7zEeiU6Q3zLoQJBkq+rQ/46jQuDu8XBW7n4E+GdPS2V8dNPrSYyxAK0KME6
	v5o6ttvJ3HA5gTfD9TBRTMXae+YMOD/zwOUr0Q5+OAmKo+rAbblvFgbJ72jofd8Qngvu+48ysaUZv
	xJVSdqi8/XJXBCVxX1Jd79nSeoESvKQzW5OEhc1xCwH4d87kTOqf9dxthrFNokyeLeAHxbbkqbjP9
	249BhCdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sClyZ-00000008I1Z-2TA7;
	Thu, 30 May 2024 20:02:15 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sClyW-00000008I18-1IY3
	for linux-um@lists.infradead.org;
	Thu, 30 May 2024 20:02:13 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Vqxwz1Qt3z6Cnk9T;
	Thu, 30 May 2024 20:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717099326; x=1719691327; bh=mbOtu3q9zjV5nBmJEGmUM2Ch
	lXZYTtjXht6IjdlxuYo=; b=F/EUZ7ZoluH2NApSjB6LS4U+IseVIwCjj1+dB0GQ
	Hzd/jksY/Fw5Zro8gliSKkstCF1FjokCnbsfexxZKJdkTxEAEPIYDNL8Qr6xEnV9
	rJ7hsYcQWK7x55L8pxb/1Sxg7HUnHdJTyGXoCBAKmGZJnKsfm9hEfmMr40tWPhVi
	H6OveqevfRhZsr+gmDFCxlYpIB9o9xQP2SQ9BKfuKoYQ2KM6iZ+h17N6LqEDIWcJ
	VpoHnGJGnHY0dmLgFjDoWjP/wCgsZwF0k5CVqOvxoLdxfHwd8lS4d6WQoZn/kYPz
	/dr2Nfj8gmo+hFuTTKGCcdGS7oOPWkNQF2/83ZmILBkUCA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id TbhOJyciqa7X; Thu, 30 May 2024 20:02:06 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Vqxwr3ZGLz6Cnk9F;
	Thu, 30 May 2024 20:02:04 +0000 (UTC)
Message-ID: <6d52dd83-0cad-448e-8a22-b6f0e1bcac46@acm.org>
Date: Thu, 30 May 2024 13:02:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] sd: simplify the disable case in sd_config_discard
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
 <20240529050507.1392041-7-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240529050507.1392041-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_130212_602957_D7EA25F7 
X-CRM114-Status: UNSURE (   7.63  )
X-CRM114-Notice: Please train this message.
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

On 5/28/24 22:04, Christoph Hellwig wrote:
> Fall through to the main call to blk_queue_max_discard_sectors given that
> max_blocks has been initialized to zero above instead of duplicating the
> call.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


