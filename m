Return-Path: <linux-mtd-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Thu, 7 Apr 2022 17:26:56 +0200
From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH 26/27] block: uncouple REQ_OP_SECURE_ERASE from
 REQ_OP_DISCARD
Message-ID: <20220407152656.GM15609@twin.jikos.cz>
References: <20220406060516.409838-1-hch@lst.de>
 <20220406060516.409838-27-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220406060516.409838-27-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Reply-To: dsterba@suse.cz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+geert=linux-m68k.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org, linux-block@vger.kernel.org, drbd-dev@lists.linbit.com, nbd@other.debian.org, ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com, linux-mm@kvack.org
List-ID: <linux-um.lists.infradead.org>

On Wed, Apr 06, 2022 at 08:05:15AM +0200, Christoph Hellwig wrote:
> Secure erase is a very different operation from discard in that it is
> a data integrity operation vs hint.  Fully split the limits and helper
> infrastructure to make the separation more clear.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-core.c                    |  2 +-
>  block/blk-lib.c                     | 64 ++++++++++++++++++++---------
>  block/blk-mq-debugfs.c              |  1 -
>  block/blk-settings.c                | 16 +++++++-
>  block/fops.c                        |  2 +-
>  block/ioctl.c                       | 43 +++++++++++++++----
>  drivers/block/drbd/drbd_receiver.c  |  5 ++-
>  drivers/block/rnbd/rnbd-clt.c       |  4 +-
>  drivers/block/rnbd/rnbd-srv-dev.h   |  2 +-
>  drivers/block/xen-blkback/blkback.c | 15 +++----
>  drivers/block/xen-blkback/xenbus.c  |  5 +--
>  drivers/block/xen-blkfront.c        |  5 ++-
>  drivers/md/bcache/alloc.c           |  2 +-
>  drivers/md/dm-table.c               |  8 ++--
>  drivers/md/dm-thin.c                |  4 +-
>  drivers/md/md.c                     |  2 +-
>  drivers/md/raid5-cache.c            |  6 +--
>  drivers/mmc/core/queue.c            |  2 +-
>  drivers/nvme/target/io-cmd-bdev.c   |  2 +-
>  drivers/target/target_core_file.c   |  2 +-
>  drivers/target/target_core_iblock.c |  2 +-

For

>  fs/btrfs/extent-tree.c              |  4 +-

Acked-by: David Sterba <dsterba@suse.com>

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

