Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH 15/27] block: add a bdev_max_zone_append_sectors helper
Date: Fri, 15 Apr 2022 05:43:08 +0000
Message-ID: <29b7e5b3-172b-c006-94c3-ad23e058e438@nvidia.com>
References: <20220415045258.199825-1-hch@lst.de>
 <20220415045258.199825-16-hch@lst.de>
In-Reply-To: <20220415045258.199825-16-hch@lst.de>
Content-Language: en-US
Content-ID: <6CDFF86F90989C4A95462B2BEA592E1A@namprd12.prod.outlook.com>
MIME-Version: 1.0
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
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "dm-devel@redhat.com" <dm-devel@redhat.com>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>, "nbd@other.debian.org" <nbd@other.debian.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>, "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, "cluster-devel@redhat.com" <cluster-devel@redhat.com>, "jfs-discussion@lists.sourceforge.net" <jfs-discussion@lists.sourceforge.net>, "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>, "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>, "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Damien Le Moal <damien.lemoal@opensource.wdc.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Johannes Thumshirn <johannes.thumshirn@wdc.com>

On 4/14/22 21:52, Christoph Hellwig wrote:
> Add a helper to check the max supported sectors for zone append based on
> the block_device instead of having to poke into the block layer internal
> request_queue.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

