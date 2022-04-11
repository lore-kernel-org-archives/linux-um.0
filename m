Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Mon, 11 Apr 2022 08:01:41 -0600
From: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 24/27] block: remove QUEUE_FLAG_DISCARD
Message-ID: <YlQ0xbtIcf8gti43@kbusch-mbp.dhcp.thefacebook.com>
References: <20220409045043.23593-1-hch@lst.de>
 <20220409045043.23593-25-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220409045043.23593-25-hch@lst.de>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org, linux-block@vger.kernel.org, drbd-dev@lists.linbit.com, nbd@other.debian.org, ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com, linux-mm@kvack.org, "Martin K . Petersen" <martin.petersen@oracle.com>, Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>, Coly Li <colyli@suse.de>

On Sat, Apr 09, 2022 at 06:50:40AM +0200, Christoph Hellwig wrote:
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index efb85c6d8e2d5..7e07dd69262a7 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1607,10 +1607,8 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
>  	struct request_queue *queue = disk->queue;
>  	u32 size = queue_logical_block_size(queue);
>  
> -	if (ctrl->max_discard_sectors == 0) {
> -		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, queue);
> +	if (ctrl->max_discard_sectors == 0)
>  		return;
> -	}

I think we need to update the queue limit in this condition. While unlikley,
the flag was cleared here in case the device changed support for discard from
the previous reset. 

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

