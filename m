Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C687FC47074
	for <linux-um@archiver.kernel.org>; Tue,  2 Jan 2024 01:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AiGwSYUXI9fxcYVwvEl26RBkMK69KBi7r4UwJQYgdE4=; b=ETYnjRNEtninAsRnItk5L2BS15
	ppLIlTjwwB9i9683qmWWZvU7CjiI592OEx+GHsYJ8Tm72ycU2oJqlh8YmXWPQDVhhBj1QbXiDnr/v
	sya7BYzWwq/gjrpXfMpGJcg4Pji86ocBWRVI6CBcc6P4JpRXnkuxDBoUPxbNEYjqueX+Apx1Wuw/0
	2Ax8GUnAPssUvKd7yiXG5jkl6ZWpS0r0QHXE7dBqaqCLCkxQErS3KbYr8HQMOMxPCPZqHCnWmc7vL
	SorltWDGEsKxzVZbtv1M2q13vbc2nxO8aC6MswIn7uu+RlWX876YqnnGH6Jg60l8IbyAbHiHALpgM
	02gdEk1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKTNy-006sin-31;
	Tue, 02 Jan 2024 01:16:02 +0000
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKTNt-006shy-10
	for linux-um@lists.infradead.org;
	Tue, 02 Jan 2024 01:15:58 +0000
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-2045bedb806so6338279fac.3
        for <linux-um@lists.infradead.org>; Mon, 01 Jan 2024 17:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704158150; x=1704762950; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AiGwSYUXI9fxcYVwvEl26RBkMK69KBi7r4UwJQYgdE4=;
        b=THe+j+mBI178+xWXShb7Aq11yR11zEMGbct6rolvy5eymhvyFg/O5oD0UqRr1ynACG
         bjwNVvKk00tUWkbV3Fj8mnfpX76Nrivb9xBd33FZ7q4b5pABSqZs6mztkWLDnixut+ku
         V/84EXMW1StobpOBuunkMzjIYlKfuIVuPGrZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704158150; x=1704762950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiGwSYUXI9fxcYVwvEl26RBkMK69KBi7r4UwJQYgdE4=;
        b=MJPsVWfQlQWdab1G7qRG7j6m5ZXlFW8OTwDWoEj3Do9SChqx9nDupzGrImS2LZnMtH
         LKAuLp9uELc4nGcdkNqrNIkzH/ItGaPa169pcrEAlVd+cWa2aOhE3goiSMY+JRZaspzs
         pMnbzbBhfVN66sXt6RiM7Qhpe4C2OdR7Twb1bGTADEE8zjMbyi/Sh9ghUz/6lA0EYgHm
         RWf9BSp5N8BIKWe6TaycqLgpqZ/1RyFqu/fzy6H6FBWoaXJIHsWwnyH4j5b6nk4cwww2
         4Fy2PhYEzA2UYn//Pte9eLsR6hE/eDceCNSgPNwzjMJV32Sy9RoZ3Jk86reGfNJt5L6E
         nuow==
X-Gm-Message-State: AOJu0Yw6CtOe47qxTw+651V0SG8HMFdS7tjZEngERcXi1OBrCaTKjdgC
	a/YofFs3dSIDnXXFtmbN6MQX7A8zv10T
X-Google-Smtp-Source: AGHT+IH9S0eoxCJzaBceLRCqYyMLMz41Ex8ouKxN6Dp7H2vys3Lzl953E5tC2NyCU5dsGbkan5tlDA==
X-Received: by 2002:a05:6871:8983:b0:204:5246:eda6 with SMTP id tj3-20020a056871898300b002045246eda6mr19443277oab.69.1704158150228;
        Mon, 01 Jan 2024 17:15:50 -0800 (PST)
Received: from google.com (KD124209171220.ppp-bb.dion.ne.jp. [124.209.171.220])
        by smtp.gmail.com with ESMTPSA id si6-20020a17090b528600b0028b5812c477sm25447407pjb.35.2024.01.01.17.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 17:15:49 -0800 (PST)
Date: Tue, 2 Jan 2024 10:15:43 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Coly Li <colyli@suse.de>, Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-um@lists.infradead.org,
	linux-block@vger.kernel.org, nbd@other.debian.org,
	linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 7/9] zram: use the default discard granularity
Message-ID: <20240102011543.GA21409@google.com>
References: <20231228075545.362768-1-hch@lst.de>
 <20231228075545.362768-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228075545.362768-8-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_171557_431950_5C7FC312 
X-CRM114-Status: GOOD (  10.38  )
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

On (23/12/28 07:55), Christoph Hellwig wrote:
> 
> The discard granularity now defaults to a single sector, so don't set
> that value explicitly

Hmm, but sector size != PAGE_SIZE

[..]

> @@ -2227,7 +2227,6 @@ static int zram_add(void)
>  					ZRAM_LOGICAL_BLOCK_SIZE);
>  	blk_queue_io_min(zram->disk->queue, PAGE_SIZE);
>  	blk_queue_io_opt(zram->disk->queue, PAGE_SIZE);
> -	zram->disk->queue->limits.discard_granularity = PAGE_SIZE;

