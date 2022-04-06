Return-Path: <linux-mtd-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Wed, 6 Apr 2022 09:04:46 +0200
Subject: Re: [PATCH 15/27] block: use bdev_alignment_offset in
 part_alignment_offset_show
Message-ID: <20220406070446.GA1722@ts.fujitsu.com>
References: <20220406060516.409838-1-hch@lst.de>
 <0b7ae3df301c4fdd8d37f773d8d1eb93@FR3P281MB0843.DEUP281.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0b7ae3df301c4fdd8d37f773d8d1eb93@FR3P281MB0843.DEUP281.PROD.OUTLOOK.COM>
From: Alan.Robinson@fujitsu.com (Alan Robinson)
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Reply-To: Alan.Robinson@fujitsu.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+geert=linux-m68k.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "jfs-discussion@lists.sourceforge.net" <jfs-discussion@lists.sourceforge.net>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>, "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "cluster-devel@redhat.com" <cluster-devel@redhat.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "nbd@other.debian.org" <nbd@other.debian.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

Hi Christoph,

On Wed, Apr 06, 2022 at 06:05:04AM +0000, Christoph Hellwig wrote:
> From: Christoph Hellwig <hch@lst.de>
> Subject: [PATCH 15/27] block: use bdev_alignment_offset in
>  part_alignment_offset_show
> 
> Replace the open coded offset calculation with the proper helper.
> This is an ABI change in that the -1 for a misaligned partition is
> properly propagated, which can be considered a bug fix and maches

s/maches/matches/

> what is done on the whole device.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/partitions/core.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index 2ef8dfa1e5c85..240b3fff521e4 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -200,11 +200,7 @@ static ssize_t part_ro_show(struct device *dev,
>  static ssize_t part_alignment_offset_show(struct device *dev,
>  					  struct device_attribute *attr, char *buf)
>  {
> -	struct block_device *bdev = dev_to_bdev(dev);
> -
> -	return sprintf(buf, "%u\n",
> -		queue_limit_alignment_offset(&bdev_get_queue(bdev)->limits,
> -				bdev->bd_start_sect));
> +	return sprintf(buf, "%u\n", bdev_alignment_offset(dev_to_bdev(dev)));

Should this now be %d instead of %u, there are one or two examples of
both in the rest of the patch series.

Alan


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

