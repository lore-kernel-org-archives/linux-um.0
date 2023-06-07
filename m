Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E86C7EE25
	for <linux-um@archiver.kernel.org>; Wed,  7 Jun 2023 12:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1psIJ/StM5EoLYJjZl5Vdq+dC2xbDAk5HZ127fJ2DFo=; b=yWAXVUVNkIxzD4
	1zQugkqR72uOFr1OzRflKs4VUHxmYtwt1MH6xnrpoWkSKK+kDMdNFN11AFsJJYFulqb3Ie1AALfLG
	kuc46u2RcznniY6JFbnNynb6OxlZvuhst4NDuljNuUwh0CEC8YNkMosQsjYLAfIgDG8aIm5oLqsvE
	qWdxP8NFdkdzLcRmZ7XCW4DnCqlGS/s93KOVSpialTXeRmyL/c5rnkEHrWRRJj1y5vZggqG00YWOL
	SzntQIRcQb2AlUuNY18umP2UPDlgYkzzliW78hAE4MYFTdUFs98YZfRkarFcCFMi4EtGOs6N4w+Gz
	lpA5uxM8a3rxbRT4b0VQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6s4G-005ods-22;
	Wed, 07 Jun 2023 12:15:12 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6s4B-005obw-2B;
	Wed, 07 Jun 2023 12:15:09 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6E490219FA;
	Wed,  7 Jun 2023 12:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686140106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TCf1JgyrYBVXKyreePtxys/QiUi87JN83HRlMRb2lYE=;
	b=CRDzZNeTguzVV10MP0Cz5mjZfwsyQGQRMvccEpkjxWr6pSG/xzALuvyRhI1wD2mh48HhAY
	65ExpR0IOIaw9C+DUYtbqHHrUH6NcON5dQBfQeEvRNslIYmedAR1Bqhfpw8oom/MiT3gFY
	nXlAz/paj0eO5VYqifRjRAxjliakFbI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686140106;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TCf1JgyrYBVXKyreePtxys/QiUi87JN83HRlMRb2lYE=;
	b=OtqJFtTN6bvGkX0HHZPsY0QQ3cDJ9AcCdim3RmTqYjZmzFRMxXuf8vsckjvqb94lWEJnay
	LXsic/Ff7fLJ9eDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3BD8013776;
	Wed,  7 Jun 2023 12:15:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id biNSDsp0gGSBPgAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 07 Jun 2023 12:15:06 +0000
Message-ID: <3db66acd-112a-906b-5e2f-25ab843253cc@suse.de>
Date: Wed, 7 Jun 2023 14:15:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 07/31] block: pass a gendisk on bdev_check_media_change
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>, Josef Bacik <josef@toxicpanda.com>,
 "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>,
 Phillip Potter <phil@philpotter.co.uk>, Coly Li <colyli@suse.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
 linux-block@vger.kernel.org, linux-um@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-8-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230606073950.225178-8-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_051507_857203_F5EBA471 
X-CRM114-Status: GOOD (  12.11  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On 6/6/23 09:39, Christoph Hellwig wrote:
> bdev_check_media_change should only ever be called for the whole device.
> Pass a gendisk to make that explicit and rename the function to
> disk_check_media_change.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/disk-events.c     | 18 +++++++++---------
>   drivers/block/amiflop.c |  2 +-
>   drivers/block/ataflop.c |  6 +++---
>   drivers/block/floppy.c  | 16 ++++++++--------
>   drivers/block/swim.c    |  2 +-
>   drivers/block/swim3.c   |  2 +-
>   drivers/cdrom/gdrom.c   |  2 +-
>   drivers/md/md.c         |  2 +-
>   drivers/scsi/sd.c       |  9 ++++-----
>   drivers/scsi/sr.c       |  2 +-
>   include/linux/blkdev.h  |  2 +-
>   11 files changed, 31 insertions(+), 32 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
