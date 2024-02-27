Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A605C5478C
	for <linux-um@archiver.kernel.org>; Tue, 27 Feb 2024 21:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FjjMr/gBxFj+dMQL3GVk8vDb+wPW9nf9Ij7pdIMqb9w=; b=UN0ksagKwC52WmxEC9TZDmnJ1X
	Rtk/87rFvB99LU7mvnBS6MkMRF1lHTC2UqUrzcBxE3sJA4ciF2i5RCybkqdXvqKxltAWJDc/Gpbmm
	Dq9diAEF1+kpWYv6Hi89botbZnLf757iftu4R6MtRLCoKPvYa36tokjcruyfoCdjSS2ijEdsoBlGV
	yedJHOELZnnEvm4bw+PbHxU8kmbbWv1X9GSG6QY/OeLvL0kewvBHPPjTuK+m+mP5+pwFORLWFCzqO
	K4EllaLH8l0J8OBK2IXAmhYwLaeNLmWRfFSrDn1t64YKkWYLVyu/ohY27LfIdmOVpWkELnOFOs001
	lKdjJi5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf4tk-00000006slT-0nld;
	Tue, 27 Feb 2024 21:22:00 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf4th-00000006sip-1U4k
	for linux-um@lists.infradead.org;
	Tue, 27 Feb 2024 21:21:58 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5cfcf509fbdso2207497a12.1
        for <linux-um@lists.infradead.org>; Tue, 27 Feb 2024 13:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709068915; x=1709673715; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjjMr/gBxFj+dMQL3GVk8vDb+wPW9nf9Ij7pdIMqb9w=;
        b=WEM5yZ5rISGzXDCdKsiF5viIfCRspP/Wvi/5Vi0VFIZxo/iYh4Ib9jRmjKCBXnsLWk
         Yl/Wr1cypwAS1GgePspF47F9H6nqC/Ilze3tpE5Q7rUflH3pFp6C348AnesKooel6A57
         10amHZ0+2Qluyo4FpxlNSi8r3UhT2GwClt8va+ns4V3O/qfoAo39d8M5J2vBwxOJQAnA
         TUvrkMi1MWeh5ni8jxlKMJZ/c3kvbyoqniT++uObK8D7bUfRjbkb38XfKQS5YkOv7ut/
         TwztN+RptRzms4/V6ds3TcxTae1+cc64FqBMOTlGtX977NQ4KDyW73q/joe+uKSuyLvW
         mUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709068915; x=1709673715;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjjMr/gBxFj+dMQL3GVk8vDb+wPW9nf9Ij7pdIMqb9w=;
        b=cPjLzHG3PLjg2ibcGBSAFEIBq6bvxhIlPllbaTaqDwf/mqyVBLqLO5xjB3ZePQAntl
         vCvi+7YRPlHlzEBhsBJ3bk7o8+sQKNdYBOQ5QKqhdg6tqdgVXMGvcP5WCcMx5v6F/wQz
         22tdjUE+0N2Qx5JjQSd9RjMvaFlPAeDOXNBlNHxLXY1OmnUvo73Aep0N4p87QyFt7/an
         gfQghia5pap2B2r1BwXUUISQ8J05vIfeMqmUyOW7j8nrsax7NoqvQazfElRYzaNzQy7g
         zKlCCdlBtvgD1uPDWZKpJzxFVp94bsKUt8qqYRU7jUC+jlDsz+5vGnH2ORPAwuo5zSi0
         gqTg==
X-Gm-Message-State: AOJu0YzAybm0jZBl5IvDi95vXfhYDE8RWZjZku8Rwt8VX8dOIoB4DTII
	C5M3QALxcQuizqE7tC4+zJhTm3p77r4JclsYYWSxO1YdvZLtCCJUGp4k8k55D/3w72rhvCDgzbK
	h
X-Google-Smtp-Source: AGHT+IEZAGavcZZtXdcIkiylMu4LEvh2cNN62sm+yVcp6Yc3JZRc/+EsVnsDUENSeCCwb7KDsy9F7A==
X-Received: by 2002:a05:6a21:33a5:b0:1a1:5:e8de with SMTP id yy37-20020a056a2133a500b001a10005e8demr6800533pzb.4.1709068915052;
        Tue, 27 Feb 2024 13:21:55 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id r10-20020a635d0a000000b005dc36279d6dsm6125145pgb.73.2024.02.27.13.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 13:21:53 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, Christoph Hellwig <hch@lst.de>
Cc: linux-um@lists.infradead.org, linux-block@vger.kernel.org
In-Reply-To: <20240222072417.3773131-1-hch@lst.de>
References: <20240222072417.3773131-1-hch@lst.de>
Subject: Re: ubd cleanups
Message-Id: <170906891332.1104664.7977100251649709745.b4-ty@kernel.dk>
Date: Tue, 27 Feb 2024 14:21:53 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_132157_429267_1D7A3852 
X-CRM114-Status: UNSURE (   9.05  )
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


On Thu, 22 Feb 2024 08:24:10 +0100, Christoph Hellwig wrote:
> this series cleans up the uml ubd drivers and gets rid of more blk_queue_*
> calls.  It is a against Jens' for-6.9/block branch.
> 
> Diffstat:
>  ubd_kern.c |  127 +++++++++++++++++++++----------------------------------------
>  1 file changed, 44 insertions(+), 83 deletions(-)
> 
> [...]

Applied, thanks!

[1/7] ubd: remove the ubd_gendisk array
      commit: 32621ad7a7ea4c3add1dd6bd27b62c2b22500d54
[2/7] ubd: remove ubd_disk_register
      commit: 0267e9cac6de0c25ec1b6e3fef4fd8a87a4774a2
[3/7] ubd: move setting the nonrot flag to ubd_add
      commit: b8b364d2af7483ad82975cf35d5201efe1efa29f
[4/7] ubd: move setting the variable queue limits to ubd_add
      commit: 58ebe3e748353960fcc3b2661273737f45d197b1
[5/7] ubd: move set_disk_ro to ubd_add
      commit: 5e4e1ff820e855a328cf2efb795c079f3a58abbe
[6/7] ubd: remove the queue pointer in struct ubd
      commit: f3c17dcc43e207e4fba511e9e63d52f7098ad6f3
[7/7] ubd: open the backing files in ubd_add
      commit: fb5d1d389c9e78d68f1f71f926d6251017579f5b

Best regards,
-- 
Jens Axboe




