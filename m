Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F9FC47073
	for <linux-um@archiver.kernel.org>; Fri, 29 Dec 2023 15:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yQjXtcB6Oq3k74ay/cs5vR/HD/xg6rvyoXPDzdeumLU=; b=IGncjVV2RsKz2cBxKoOpTkO3Jy
	EY23P2AL/71w/AQMNapHVH224TpAe2IEY5tpOXAtV1Ko8CWQRVQXrv7/bj5Diby7YbfcDti5d/2UV
	lLcIMkq4dlf8251++C8K3ao69DttDJSG0lugLembLsVUoUaCVx8PXh7UGhTxP/MBh97cqDsO6qda+
	QduCDxooSCBLl90WZ4pPfCFQmxt4iY6d84G4E5u5Yo2ENJoDQa4t147EHfB8gEBh++Pj4+ex65c3L
	B/Mogb2cHFcQ4rlnmFcL6xCqCxnkvQzC9JJgv4lsil3XYGDTo84aIY9S6Ix/xIwR8/2rXL5fbqLx+
	SPL8ynIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rJF2P-0018BV-1Q;
	Fri, 29 Dec 2023 15:44:41 +0000
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rJF2L-0018AZ-0P
	for linux-um@lists.infradead.org;
	Fri, 29 Dec 2023 15:44:39 +0000
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7bb5be6742fso4711839f.1
        for <linux-um@lists.infradead.org>; Fri, 29 Dec 2023 07:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703864675; x=1704469475; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQjXtcB6Oq3k74ay/cs5vR/HD/xg6rvyoXPDzdeumLU=;
        b=ABzLgOVTFx5Sm/Rfpevm1RUtEgFrseYi/PfARgyJM7y6elc0NABBLXA449IFrJc1qV
         3pBq/mAfmmaQcSRzVa343KGJKkwPSW642FKxO57L+NjUywJ5MC0+Rw4hOktBnxwB0N9j
         MQO+yqA+uhmR6XK1zpj9sdfYWmZsMvfMWBhZ+T0tZJD5vzUXihRQyDQtPU0PnIP25YA7
         Oi6u7MTlgQuJNIIfXL8RqnJiJ5KII0I67N0CVe0SKNOdphagUHP+p7TUEn3LR6Vl8H4l
         M0/PYVHOApQ9Lbb+GKADaZvtoUpUNe+S6O9gAScvA2jFIF8abYvJCkIuPcGKvE/zhEhQ
         ne8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703864675; x=1704469475;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQjXtcB6Oq3k74ay/cs5vR/HD/xg6rvyoXPDzdeumLU=;
        b=ofu/iOqcuweBZZZ7pKl62JSdx1rRkmwJPye87t0HEncem1R1jdJsM80VFOuzUHXXPr
         DESNa7YLxsgHwcdEGJJPZIrKfSERtcJjpCJ+rjlnIQF4UCCPtgagndhBNUIsUxskHOcg
         9ucfctfqftB8ZR3Q/yyFUCj1SpbhTcmnVZZsYHW1CwVoh7UCW+z+d2Iq5qTCLOCyJC/u
         A8sTeKnOfueie6yyngWObN/PUM2NKrOiTIrgsIP7J05MNPfdWMA/V3A3cOHXfwMnFCAU
         G7go+AesCotAA2CzWB1FNbFVuN15CksvUA7RYrII2irNlapVrD3jhmWeUDGcK9pkDwPj
         f6xg==
X-Gm-Message-State: AOJu0YyGpKTqid4ks/51yql7LCxufLUZdvmLzrUAwNQwCI0XNpOS6IoX
	6f+TnFybW54xag85wOl/nzU5E4oQBzCTV9l3A8txwv74iO4PbA==
X-Google-Smtp-Source: AGHT+IHAm0ro/JYGZ86leiXTCWBYht33pHhUQxq1wRsVw6jMpELsHFapyFrv/5iAU4fxQiP4l1Rgag==
X-Received: by 2002:a05:6e02:1d13:b0:35f:da7a:3797 with SMTP id i19-20020a056e021d1300b0035fda7a3797mr22028997ila.1.1703864675229;
        Fri, 29 Dec 2023 07:44:35 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id z11-20020a634c0b000000b005ce6b79ab6asm1526889pga.82.2023.12.29.07.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 07:44:34 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Josef Bacik <josef@toxicpanda.com>, Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Coly Li <colyli@suse.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, linux-um@lists.infradead.org, 
 linux-block@vger.kernel.org, nbd@other.debian.org, 
 linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org
In-Reply-To: <20231228075545.362768-1-hch@lst.de>
References: <20231228075545.362768-1-hch@lst.de>
Subject: Re: provide a sane discard_granularity default
Message-Id: <170386467352.1470147.12182761923584971917.b4-ty@kernel.dk>
Date: Fri, 29 Dec 2023 08:44:33 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231229_074437_504741_EE8E8D66 
X-CRM114-Status: GOOD (  10.71  )
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


On Thu, 28 Dec 2023 07:55:36 +0000, Christoph Hellwig wrote:
> this series defaults the discard_granularity to the sector size as
> that is a very logical default for devices that have no further
> restrictions.  This removes the need for trivial drivers to set
> a discard granularity and cleans up the interface.
> 
> Diffstat:
>  arch/um/drivers/ubd_kern.c    |    1 -
>  block/blk-merge.c             |    6 +-----
>  block/blk-settings.c          |    5 ++++-
>  drivers/block/nbd.c           |    6 +-----
>  drivers/block/null_blk/main.c |    1 -
>  drivers/block/zram/zram_drv.c |    1 -
>  drivers/md/bcache/super.c     |    1 -
>  drivers/mtd/mtd_blkdevs.c     |    4 +---
>  8 files changed, 7 insertions(+), 18 deletions(-)
> 
> [...]

Applied, thanks!

[1/9] block: remove two comments in bio_split_discard
      commit: 928a5dd3a849dc6d8298835bdcb25c360d41bccb
[2/9] bcache: discard_granularity should not be smaller than a sector
      commit: 5e7169e7f7c0989304dbe8467a1d703d614c64db
[3/9] block: default the discard granularity to sector size
      commit: 3c407dc723bbf914f3744b0c2bb82265b411a50c
[4/9] ubd: use the default discard granularity
      commit: 599d9d4eab7c3d5dc6f1e0f8f052fee9eaa54e50
[5/9] nbd: use the default discard granularity
      commit: 1e2ab2e8a98c9e0629b5b8bff8ee6f2cb3e8daac
[6/9] null_blk: use the default discard granularity
      commit: 724325477f8a48ce1defc2a49998bbc19fe85c88
[7/9] zram: use the default discard granularity
      commit: 3753039def5d0d1c43af847b507ba9b782db183a
[8/9] bcache: use the default discard granularity
      commit: 105c1a5f6ccef7f52f9e76664407ef96218272eb
[9/9] mtd_blkdevs: use the default discard granularity
      commit: 31e4fac930814f2f92eb6ebac9c4d4e3b09f7aaf

Best regards,
-- 
Jens Axboe




