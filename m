Return-Path: <linux-mtd-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH 14/27] block: add a bdev_max_zone_append_sectors helper
Date: Wed, 6 Apr 2022 09:58:44 +0000
Message-ID: <PH0PR04MB74161D2CCC5AD43AF09264799BE79@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220406060516.409838-1-hch@lst.de>
 <20220406060516.409838-15-hch@lst.de>
Content-Language: en-US
MIME-Version: 1.0
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
Cc: "dm-devel@redhat.com" <dm-devel@redhat.com>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>, "nbd@other.debian.org" <nbd@other.debian.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>, "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, "cluster-devel@redhat.com" <cluster-devel@redhat.com>, "jfs-discussion@lists.sourceforge.net" <jfs-discussion@lists.sourceforge.net>, "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>, "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>, "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>
List-ID: <linux-um.lists.infradead.org>

Looks good,
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

