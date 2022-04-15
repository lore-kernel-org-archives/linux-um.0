Return-Path: <linux-mtd-bounces+geert=linux-m68k.org@lists.infradead.org>
Message-ID: <d7a39cfc-9b28-f0d6-bf62-4351c55daec2@opensource.wdc.com>
Date: Fri, 15 Apr 2022 14:08:20 +0900
MIME-Version: 1.0
Subject: Re: [PATCH 27/27] direct-io: remove random prefetches
Content-Language: en-US
References: <20220415045258.199825-1-hch@lst.de>
 <20220415045258.199825-28-hch@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
In-Reply-To: <20220415045258.199825-28-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+geert=linux-m68k.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org, linux-block@vger.kernel.org, drbd-dev@lists.linbit.com, nbd@other.debian.org, ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com, linux-mm@kvack.org
List-ID: <linux-um.lists.infradead.org>

On 4/15/22 13:52, Christoph Hellwig wrote:
> Randomly poking into block device internals for manual prefetches isn't
> exactly a very maintainable thing to do.  And none of the performance
> criticil direct I/O implementations still use this library function

s/criticil/critical

> anyway, so just drop it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>


-- 
Damien Le Moal
Western Digital Research

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

