Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2F7C25B74
	for <linux-um@archiver.kernel.org>; Thu, 30 May 2024 19:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gIZD+XBfeoiXCs+vsIOauc0JAFtw0ViQpf0RwIfdqeI=; b=g7e6DbksqMhhHsKIkMDOhYMQ/r
	i52TSWvMLyzDnJUjT5j7e+NaxjRyQQb9GaeEAARC5AXnv95jZtdlelHrMg9eUT8ORx7BZLYNlSCES
	q886jdPJTSmUdT+iRdTmJY+QXgzRvYjUxq8Mz95cQKSdjCsMZS6nfqQ6p2B+qYv/zU6u28g0jTV1W
	Y3o5PkvBKCc8aEZRiQuIR6ByQkvOgwMnPUW6/qGcBF19vo4+BpXXN3RElTWeJCdhayq5QcThNSZ8N
	+tybGTBDyKG3t4B2+/GCXx4aZNM7RRPQtzZNe4p+cBwjHbUYyUvQ2iauUhEihgs75bpQjwP5hz1ph
	Au7pMbMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sClkA-00000008Gfj-3mZG;
	Thu, 30 May 2024 19:47:22 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sClk8-00000008GfB-0tka
	for linux-um@lists.infradead.org;
	Thu, 30 May 2024 19:47:21 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Vqxbk6tSqz6Cnk9T;
	Thu, 30 May 2024 19:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717098428; x=1719690429; bh=gIZD+XBfeoiXCs+vsIOauc0J
	AFtw0ViQpf0RwIfdqeI=; b=LeBK1nTDoaUU8KAvyoiidxeqI1H8VC7yltJTPW4y
	XkYIFoLA0Xsv871K8AMKv1pruRb7L5Vojxd3TXpVjOmpzCKnxzsAzPwXavUCLmiG
	5Io9SoOjP5YKnml8f0lVeIWDw6umtR8N2JBzgwVMlGiuo36RH4kWKMRKIp7SrKHq
	49OVo1TUglVJnZ/FHnf1DulkWr6IflF9OncnRDnJq9pnqGyM16QVtbsNy1ahrI3q
	GKMmq9vzmNV1PmpyA8YGpgIcN378oHvXWXKo5o6AkOKWk1xSeOKUZJjERmaxIpao
	1jHLbCjdnG+qM70N4r3Tjg99XIgFTQPKTwcpUYGYirs6RQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tO0K_eu1GhdP; Thu, 30 May 2024 19:47:08 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VqxbZ4pbBz6Cnk9F;
	Thu, 30 May 2024 19:47:06 +0000 (UTC)
Message-ID: <8d927897-0436-4f47-9b03-c3e9adb90f40@acm.org>
Date: Thu, 30 May 2024 12:47:06 -0700
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
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240529050507.1392041-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_124720_300544_5958A30B 
X-CRM114-Status: GOOD (  16.66  )
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
             ^^
             rbd?

> user max_sectors value, so this is a bit of a behavior change that
> could use careful review from people familiar with rbd.

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


