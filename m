Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA73C25B76
	for <linux-um@archiver.kernel.org>; Tue, 11 Jun 2024 08:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9CyZ1q0qKpbTi0q0ed0vVvII/IKPqBaRSde2KXNO+Aw=; b=JEqR4FU1pfOMcCVw/0rurtIMyl
	WDn/26BZ3sAwa3wiDs1CjRBF9HXpuafo89xpadyJNCqTm4R38E+P+zN4lcGE5UyLhss2KEjV7NhQ0
	tnqMPksK2SKNcmLgCZMFloyG1AN4uIdQlwEoyx796HFpYHaFG8HzUPH2l2noa1ORi5G8SDJpq/KEI
	gtEOxeDvL0biyn3eGHx/D/IlHTJ54tD4SrDjIJNjHoPYA1D+Zp0UzWD69LBimvD5MoIltJr/hSGYW
	8b3YCA5cMMh16msCW4OAGw8bns9tq2ORz678+cG4kCqZqMSzqfzQzXcUguwneo6Vz5tobQ4BjwzAh
	bj4sC9lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGwoC-000000085ld-3lVP;
	Tue, 11 Jun 2024 08:24:48 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGwo9-000000085iW-0reU;
	Tue, 11 Jun 2024 08:24:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8C529CE1986;
	Tue, 11 Jun 2024 08:24:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FE3C2BD10;
	Tue, 11 Jun 2024 08:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718094282;
	bh=aa39oj6grsQuWCvXe8Xg/GJ/V11Jvezu/rMLECj5P4s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aV9kUDMWPWfXNXmeOO+XWzXEhkoXq7ADFSgqT6UOp6QmIpyBhYF9XRI2luZ1jDGrm
	 fjnG6eWakSd1CNbsGjF5O5LrabvpJGoxEOU9IkGiZiHR46HxhFdMHk0kIvmZI9wx0L
	 JOsygBPd1TdA6IDc/8xDg7nKHyfJ/2D590dnIGGMTWnavCtGtya+9Az2pKzwaIFhFJ
	 j4onYH3Luprc5hdFhkVV5RWd7C4hgmyLZChJZgAFOBU129M9EEZQ0rLACWD8TZ/l9S
	 OXq+G88IRiQo0zQ3DlC2WKDuqnhjQLUQDaVvY8Aat/yU/aTyp6lpmYzMIDEOv1I7i1
	 CT8Dtiuz6hADg==
Message-ID: <d457fc95-9231-4bc8-a2dd-2991aa8732ec@kernel.org>
Date: Tue, 11 Jun 2024 17:24:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/26] block: move the pci_p2pdma flag to queue_limits
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
 <20240611051929.513387-25-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240611051929.513387-25-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_012445_465723_D3B2C3A5 
X-CRM114-Status: UNSURE (   7.26  )
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

On 6/11/24 2:19 PM, Christoph Hellwig wrote:
> Move the pci_p2pdma flag into the queue_limits feature field so that it
> can be set atomically and all I/O is frozen when changing the flag.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


