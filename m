Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0BBC27C53
	for <linux-um@archiver.kernel.org>; Sun, 16 Jun 2024 23:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jaVSr5+ai9pJ2P3Tv5jw5LED8s5BUQrL5U1FpV5B61w=; b=b+7n+OGp4MYqb5fgisuaecgy+Z
	RA+iokgQKMHbPbJGdMgJEbp0AxXFZ2XbJMRM51HuE4M8ovsa0+2L0akQa9aL7u1Q4XW9TqtCKLfBo
	7Ki/F9uvssKzYlNbkjmq64Kek6e0tE1diLNKaTWfzTKJXs4S+yjs72T89xMQirvWQOUSOzXimNiYs
	d4JhPvfSI/5T+8C2HxhPrXOGc9Y1CLtjicUkNdUrxLiQ7taNMaaxB0KBzF80ZjiWCV6nk3FHfUpQ2
	0GAsnKyR1Uf305Cz5652lVPoXGGUlJiSNC5Gi2rXU/owwPZ4VV/FQJ1y4xUEPf65UyyEhpUTie5fR
	dPw/uxGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIysC-00000008U9D-3nAn;
	Sun, 16 Jun 2024 23:01:20 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIys5-00000008U7y-3PlU;
	Sun, 16 Jun 2024 23:01:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 522C7CE0E5D;
	Sun, 16 Jun 2024 23:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CAA0C2BD10;
	Sun, 16 Jun 2024 23:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718578869;
	bh=K48GiByJehCmQjwi20pmfnU+WsCyr4S6WxHNS+fcYIA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gczAGXT2JgNBboue0aH6XDCajaGt0Tn9T6RNwUC8NdBoTEgjtTbwpmUfCPkjFQ9wM
	 MM968k+DIaMHgn73yxqDo9X2C3EJ5/755Y+99nXMZx497l32DWuxyKEgkUS1Mfauzi
	 zlSFlVj6tWpctoPTJ+wOY0xCMexSj4HtxdjXI3+rZfPjj6bie6Cukz6u7sVo5A7bEU
	 9rKTuHOjY9Tr5Ii5b3jprMmIgspdDlLslR4qSbgMPqGu86/2ypBmGpS+m4Lh9tPaWA
	 jbUd1obFjKTKufNm0BQAftChaDznmaK4Iq8S3q+7ZRNQrBkFu3/tvjG2xwv4gQQlB4
	 JHm9Ls++1gm6g==
Message-ID: <5a697233-0611-459d-b889-2e0133bbb541@kernel.org>
Date: Mon, 17 Jun 2024 08:01:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/26] sd: move zone limits setup out of
 sd_read_block_characteristics
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>,
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
 <20240611051929.513387-3-hch@lst.de>
 <40ca8052-6ac1-4c1b-8c39-b0a7948839f8@kernel.org>
 <20240613093918.GA27629@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240613093918.GA27629@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240616_160114_072003_7983A4B2 
X-CRM114-Status: GOOD (  13.36  )
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

On 6/13/24 18:39, Christoph Hellwig wrote:
> On Tue, Jun 11, 2024 at 02:51:24PM +0900, Damien Le Moal wrote:
>>> +	if (sdkp->device->type == TYPE_ZBC)
>>
>> Nit: use sd_is_zoned() here ?
> 
> Actually - is there much in even keeping sd_is_zoned now that the
> host aware support is removed?  Just open coding the type check isn't
> any more code, and probably easier to follow.

Removing this helper is fine by me. There are only 2 call sites in sd.c and the
some of 4 calls in sd_zbc.c are not really needed:
1) The call in sd_zbc_print_zones() is not needed at all since this function is
called only for a zoned drive from sd_zbc_revalidate_zones().
2) The calls in sd_zbc_report_zones() and sd_zbc_cmnd_checks() are probably
useless as these are called only for zoned drives in the first place. The checks
would be useful only for passthrough commands, but then we do not really care
about these and the user will get a failure anyway if it tries to do ZBC
commands on non-ZBC drives.
3) That leaves only the call in sd_zbc_read_zones() but that check can probably
be moved to sd.c to conditionally call  sd_zbc_read_zones().

-- 
Damien Le Moal
Western Digital Research


