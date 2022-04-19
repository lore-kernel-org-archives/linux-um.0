Return-Path: <linux-mtd-bounces+geert=linux-m68k.org@lists.infradead.org>
Message-ID: <530b0d48-96fc-e157-38f5-a87d85c7d2c6@oracle.com>
Date: Tue, 19 Apr 2022 20:02:18 +0800
Subject: Re: [PATCH 08/27] btrfs: use bdev_max_active_zones instead of open
 coding it
References: <20220415045258.199825-1-hch@lst.de>
 <20220415045258.199825-9-hch@lst.de>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220415045258.199825-9-hch@lst.de>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+geert=linux-m68k.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org, linux-block@vger.kernel.org, drbd-dev@lists.linbit.com, nbd@other.debian.org, ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com, linux-mm@kvack.org, Johannes Thumshirn <johannes.thumshirn@wdc.com>, David Sterba <dsterba@suse.com>
List-ID: <linux-um.lists.infradead.org>

On 4/15/22 12:52, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Acked-by: David Sterba <dsterba@suse.com>

LGTM.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


> ---
>   fs/btrfs/zoned.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 1b1b310c3c510..f72cad7391a11 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -350,7 +350,6 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
>   	struct btrfs_fs_info *fs_info = device->fs_info;
>   	struct btrfs_zoned_device_info *zone_info = NULL;
>   	struct block_device *bdev = device->bdev;
> -	struct request_queue *queue = bdev_get_queue(bdev);
>   	unsigned int max_active_zones;
>   	unsigned int nactive;
>   	sector_t nr_sectors;
> @@ -410,7 +409,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
>   	if (!IS_ALIGNED(nr_sectors, zone_sectors))
>   		zone_info->nr_zones++;
>   
> -	max_active_zones = queue_max_active_zones(queue);
> +	max_active_zones = bdev_max_active_zones(bdev);
>   	if (max_active_zones && max_active_zones < BTRFS_MIN_ACTIVE_ZONES) {
>   		btrfs_err_in_rcu(fs_info,
>   "zoned: %s: max active zones %u is too small, need at least %u active zones",


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

