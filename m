Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2774BC27C77
	for <linux-um@archiver.kernel.org>; Mon, 17 Jun 2024 06:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hNzbOz053bc4tNZD6AvzhkaAlR04h0xIiBtO2+1AIcI=; b=yMaYVX86ybnTb0tTf/C+OtFgO9
	F5pBgPX3HdpjScvUhTpO9HSHohiKAHNoK8A/mKJ6c/jMJBXdLQ9WzqCFkA7MrRJ8c1Y7knXCVwT3S
	XSfDeTzM64cMHe1sGaSgbRpDC2OeAyR6cmtUsfJGdrvj6x8xAaggXNffL0mQFWwIyBsUuqJG5aVAW
	3dqKbahjAn/88agHjsV5ZQiy+LSO2sk6wtr7Mo7ZKFe0sF87E1am6Om6kJ8QBFonIqHKAvU+VSxTY
	7qDDwpSY8DqRmfj7MzLOcEUceiROEvPrlirSqBLkhNEybxpEmqlMDLgA5IeSvJafwWfB+UUtYGBmR
	Yjy6+Ecw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ5p5-00000009RPZ-3Vf9;
	Mon, 17 Jun 2024 06:26:35 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ5p2-00000009RN2-0Udv;
	Mon, 17 Jun 2024 06:26:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id D5232CE0E70;
	Mon, 17 Jun 2024 06:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897D7C2BD10;
	Mon, 17 Jun 2024 06:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718605589;
	bh=5ukl1My1jMqhSyTqZEFqdGlI+72qAecy5V2ti5Kc46U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OVa4VXa4gPyN4KTWboLud3pwf0TJbbk/rQ5BM4+Ufc5q6edplugfrWWUEhonGkfMR
	 QHtsT5neG8mJ3vHyVK4COzgFtMwuBSA3Ltr1Kmgg0P9h/SDaPK/4D4vixnSs7AOdoo
	 HP6agM24471d/vJb4Hh8SFe0zewqIqWCGc3aXNawn13hq27CQJOtkzwEi0TWYKBp4l
	 c0TLeE0D0RKiKV3rNJyqOIzjVOG/87Bt7edT59MQLl5UfWjsDRSx6vZMzrYnvW4QJA
	 /RoDuAqhbb/WQma0tOFHLAJHwURkZ+Z0rxy3rGxoovWXWM4rnyYIVDHULrocVjTDvQ
	 k66Zct4kG1uEw==
Message-ID: <c9871979-de72-49ca-879b-5f2bd773d517@kernel.org>
Date: Mon, 17 Jun 2024 15:26:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/26] block: move the nowait flag to queue_limits
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
References: <20240617060532.127975-1-hch@lst.de>
 <20240617060532.127975-20-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240617060532.127975-20-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240616_232632_576857_37884785 
X-CRM114-Status: UNSURE (   9.89  )
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

On 6/17/24 15:04, Christoph Hellwig wrote:
> Move the nowait flag into the queue_limits feature field so that it can
> be set atomically with the queue frozen.
> 
> Stacking drivers are simplified in that they now can simply set the
> flag, and blk_stack_limits will clear it when the features is not
> supported by any of the underlying devices.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


