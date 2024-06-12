Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E78C27C77
	for <linux-um@archiver.kernel.org>; Wed, 12 Jun 2024 15:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0JAgWI6yypeQvJHtBsLjxy9EsiTAtsBZFfQkPH4VMNc=; b=kn1Cj1j1w4jOhmJL2FdOzZWqG7
	ZLhdJ1soQnMMSNLCfrv0Yn0Vf3snubu0LuMbdVly47NXJNvIm++m0Qj8dLs0vdmNfMBG1bTdFqL7N
	Nn298c4jhX6LlDTIKJ5qFjWrC9+JJyTNrWU+s7zQ7TBDTc1KNpfypypRg/NRBd3Z3SJsv6yxUPL3l
	lm0u836DaDLakNnLI/DkkXfi+y3EaNfnszvDiWiEa7pSHzTU9FX9ZNfyXX6cSLkzgZPc/I2CilnKt
	QRkTk6moroUSeXdOlWXOQq0Ch+jkC2WfOFnZ4FRDYX2V/5XHHqc5nJWlwdKBqcyKnPSzLTYzOdiH8
	MoFiKYgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHQKk-0000000DGDf-3X8Z;
	Wed, 12 Jun 2024 15:56:22 +0000
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHQKh-0000000DGBQ-1q4Y
	for linux-um@lists.infradead.org;
	Wed, 12 Jun 2024 15:56:21 +0000
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-6b09072c9d9so5996d6.1
        for <linux-um@lists.infradead.org>; Wed, 12 Jun 2024 08:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1718207778; x=1718812578; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0JAgWI6yypeQvJHtBsLjxy9EsiTAtsBZFfQkPH4VMNc=;
        b=rX7Bsud9E9W0KKEvRVo9vvePC5oHluX/AQX63C1qV5YfkT+kP1M2N9koFyDpxTruG+
         noq+TYDb1dy8XBnF7LqyPkoF5phpMnSIAKHq4Mi7DJ/Tv9M9V1uR43PoZ0fnNX2DMpf4
         COBnzcz8xnnA1TNMGpIZ7/JaF6lhnh6TEeEic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718207778; x=1718812578;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0JAgWI6yypeQvJHtBsLjxy9EsiTAtsBZFfQkPH4VMNc=;
        b=iwMuwZ1bL5dPsjNzpPGhU14aAfvpUkoftFqAc2GCz3NpjvSwCaVhKk8NhGLkgRAP/2
         vmgqsjdBV6f1N7byE0jOeHfH0Zwpppxt/tF3kcUC+5jSIWtSa+B+4WgUQ9y/S4Ucnx2P
         jzTG5ODpG16celRQ4FTRNYo8e+MylWNz0OY9PIaFy7TY2FNzlBfhj9KBHikZRkwYQmIT
         Zh/e1H3s1gHELmN9DwLxWcJ4+hoNYwi1WgU5a4adEsw6e3k5r+rqFY1gLzNJd8wz5tfk
         lpAnLry6EsQUiCynXPMcuWzOkVRHztH8l0Z+jNJE7YCjlK6H549AVah1ueqkdbi0t15f
         qnKg==
X-Forwarded-Encrypted: i=1; AJvYcCWEiOaYOlk4sVjuVRhdb8BgcX3DO83L9EbBRFy3A+czSC29pnqCvzRoVKFwfnT3EhGVqP3nx0xWpk/M9IvdmBrsUmDXE8hTjyQzsrHx
X-Gm-Message-State: AOJu0YyEbpMYjYaliKJq7BwZpw9jgZwmWRQuaYQwYN0DwrmyFpnE4OlO
	PK2GYWBZcsiu9wGcjrw70Gfo0PcxQX/kJkMnAQwuygN7DPmH+4MCTWGIlf4zaVM=
X-Google-Smtp-Source: AGHT+IH3vJ/Cfk8LzYoeLv9cXT/SgN6Pt3X56xC7VVYFazmjn8i4deMSmAqg4iM25NKqjeo5TBvU1g==
X-Received: by 2002:a05:6214:2a47:b0:6b0:7365:dde0 with SMTP id 6a1803df08f44-6b2a33de160mr1306776d6.18.1718207777691;
        Wed, 12 Jun 2024 08:56:17 -0700 (PDT)
Received: from localhost ([213.195.124.163])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b0884337e9sm22877866d6.16.2024.06.12.08.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 08:56:17 -0700 (PDT)
Date: Wed, 12 Jun 2024 17:56:15 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Weinberger <richard@nod.at>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
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
Subject: Re: [PATCH 10/26] xen-blkfront: don't disable cache flushes when
 they fail
Message-ID: <ZmnFH17bTV2Ot_iR@macbook>
References: <20240611051929.513387-1-hch@lst.de>
 <20240611051929.513387-11-hch@lst.de>
 <ZmlVziizbaboaBSn@macbook>
 <20240612150030.GA29188@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240612150030.GA29188@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_085619_496317_BB496FEF 
X-CRM114-Status: GOOD (  31.77  )
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

On Wed, Jun 12, 2024 at 05:00:30PM +0200, Christoph Hellwig wrote:
> On Wed, Jun 12, 2024 at 10:01:18AM +0200, Roger Pau Monné wrote:
> > On Tue, Jun 11, 2024 at 07:19:10AM +0200, Christoph Hellwig wrote:
> > > blkfront always had a robust negotiation protocol for detecting a write
> > > cache.  Stop simply disabling cache flushes when they fail as that is
> > > a grave error.
> > 
> > It's my understanding the current code attempts to cover up for the
> > lack of guarantees the feature itself provides:
> 
> > So even when the feature is exposed, the backend might return
> > EOPNOTSUPP for the flush/barrier operations.
> 
> How is this supposed to work?  I mean in the worst case we could
> just immediately complete the flush requests in the driver, but
> we're really lying to any upper layer.

Right.  AFAICT advertising "feature-barrier" and/or
"feature-flush-cache" could be done based on whether blkback
understand those commands, not on whether the underlying storage
supports the equivalent of them.

Worst case we can print a warning message once about the underlying
storage failing to complete flush/barrier requests, and that data
integrity might not be guaranteed going forward, and not propagate the
error to the upper layer?

What would be the consequence of propagating a flush error to the
upper layers?

> > Such failure is tied on whether the underlying blkback storage
> > supports REQ_OP_WRITE with REQ_PREFLUSH operation.  blkback will
> > expose "feature-barrier" and/or "feature-flush-cache" without knowing
> > whether the underlying backend supports those operations, hence the
> > weird fallback in blkfront.
> 
> If we are just talking about the Linux blkback driver (I know there
> probably are a few other implementations) it won't every do that.
> I see it has code to do so, but the Linux block layer doesn't
> allow the flush operation to randomly fail if it was previously
> advertised.  Note that even blkfront conforms to this as it fixes
> up the return value when it gets this notsupp error to ok.

Yes, I'm afraid it's impossible to know what the multiple incarnations
of all the scattered blkback implementations possibly do (FreeBSD,
NetBSD, QEMU and blktap at least I know of).

> > Overall blkback should ensure that REQ_PREFLUSH is supported before
> > exposing "feature-barrier" or "feature-flush-cache", as then the
> > exposed features would really match what the underlying backend
> > supports (rather than the commands blkback knows about).
> 
> Yes.  The in-tree xen-blkback does that, but even without that the
> Linux block layer actually makes sure flushes sent by upper layers
> always succeed even when not supported.

Given the description of the feature in the blkif header, I'm afraid
we cannot guarantee that seeing the feature exposed implies barrier or
flush support, since the request could fail at any time (or even from
the start of the disk attachment) and it would still sadly be a correct
implementation given the description of the options.

Thanks, Roger.

