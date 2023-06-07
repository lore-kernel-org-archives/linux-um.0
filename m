Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD7FC7EE29
	for <linux-um@archiver.kernel.org>; Wed,  7 Jun 2023 12:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K8zYPChJzZe+02cmvsz9ExEj5+4pBycc8ya1oQgbhFo=; b=z+k5O9wnNN5Bzi
	duh9bZm37/lCP/fSaBj/f5rJHCOHUTyj1O4SrALlJ8GezMBWbeHqhtzqfPZf4lgzcY+JF/paRXXlq
	+5CcB7fzc3no/mN+VOO1DS+GYXxUEhJNoYSLZO2GSgjwHb0+cyibXwF7wDPeltEHDwpxgJ1M0cC3T
	fhwWN7CNh4FO2hHKnFdDKSAoroKgt7vnulMeRR42/jZQkumABzDmIYfQSZD4NnNDnUdM4fcPJ0sNz
	u7Y9dB0DIND5hJaKICH0JxeoqPQszqPLBZnhQ6zVntdaWt36p3GMBMnLnXk6ZXfOy/zWtUJeEk6/8
	udHUqFlTQO7Zy4dOxAhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6s8c-005q2o-1I;
	Wed, 07 Jun 2023 12:19:42 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6s8Y-005pzv-1Y;
	Wed, 07 Jun 2023 12:19:39 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0679A1FDAC;
	Wed,  7 Jun 2023 12:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686140377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hIcAmuwwomlFKuWyJzT2ZczfUfDqBv+dd3ElI46NTH0=;
	b=nwl1WimOwPcjF98AEDnJ2K0z5H5r6S9PZV0NMxPrxeO+b6iUxsJL+D1fFXUbalAwuKeyE3
	zDs72n/QwOPnZMi8nk3pSIarBQVHhZeQACSX9v+viDkwrv0NDl02wL5QLAw6mpY+lpJvKO
	GLq8dP5GTUTOdUeWCMUzXQ+Ee2PhJ1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686140377;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hIcAmuwwomlFKuWyJzT2ZczfUfDqBv+dd3ElI46NTH0=;
	b=E1AF4AwgkO2HnPq1es8OnevAsUmnYalHeDtF1c1JN6GfSa26Y5PIvIwVLzXxB76McWsDjz
	R09PGSzfxNnSgdAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7EEB13776;
	Wed,  7 Jun 2023 12:19:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id LXmULNh1gGTYQAAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 07 Jun 2023 12:19:36 +0000
Message-ID: <9d7ae46b-f963-3412-cf5c-4d11c54eea58@suse.de>
Date: Wed, 7 Jun 2023 14:19:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 09/31] block: pass a gendisk to ->open
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
 <20230606073950.225178-10-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230606073950.225178-10-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_051938_670857_BCB187A1 
X-CRM114-Status: GOOD (  13.17  )
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
> ->open is only called on the whole device.  Make that explicit by
> passing a gendisk instead of the block_device.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/um/drivers/ubd_kern.c          |  5 ++---
>   arch/xtensa/platforms/iss/simdisk.c |  4 ++--
>   block/bdev.c                        |  2 +-
>   drivers/block/amiflop.c             |  8 ++++----
>   drivers/block/aoe/aoeblk.c          |  4 ++--
>   drivers/block/ataflop.c             | 16 +++++++--------
>   drivers/block/drbd/drbd_main.c      |  6 +++---
>   drivers/block/floppy.c              | 30 +++++++++++++++--------------
>   drivers/block/nbd.c                 |  8 ++++----
>   drivers/block/pktcdvd.c             |  6 +++---
>   drivers/block/rbd.c                 |  4 ++--
>   drivers/block/rnbd/rnbd-clt.c       |  4 ++--
>   drivers/block/swim.c                | 10 +++++-----
>   drivers/block/swim3.c               | 10 +++++-----
>   drivers/block/ublk_drv.c            |  4 ++--
>   drivers/block/z2ram.c               |  6 ++----
>   drivers/block/zram/zram_drv.c       | 13 +++++--------
>   drivers/cdrom/gdrom.c               |  4 ++--
>   drivers/md/bcache/super.c           |  4 ++--
>   drivers/md/dm.c                     |  4 ++--
>   drivers/md/md.c                     |  6 +++---
>   drivers/mmc/core/block.c            |  4 ++--
>   drivers/mtd/mtd_blkdevs.c           |  4 ++--
>   drivers/mtd/ubi/block.c             |  4 ++--
>   drivers/nvme/host/core.c            |  4 ++--
>   drivers/nvme/host/multipath.c       |  4 ++--
>   drivers/s390/block/dasd.c           |  4 ++--
>   drivers/s390/block/dcssblk.c        |  7 +++----
>   drivers/scsi/sd.c                   | 12 ++++++------
>   drivers/scsi/sr.c                   |  6 +++---
>   include/linux/blkdev.h              |  2 +-
>   31 files changed, 102 insertions(+), 107 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
