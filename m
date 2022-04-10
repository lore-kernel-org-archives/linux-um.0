Return-Path: <linux-mtd-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Sun, 10 Apr 2022 08:27:26 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 26/27] block: decouple REQ_OP_SECURE_ERASE from
 REQ_OP_DISCARD
Message-ID: <20220410062726.GB16234@lst.de>
References: <20220409045043.23593-1-hch@lst.de>
 <20220409045043.23593-27-hch@lst.de>
 <f01ac878-9b0d-972b-70dc-6f3f61b9947b@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f01ac878-9b0d-972b-70dc-6f3f61b9947b@suse.de>
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
To: Coly Li <colyli@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, dm-devel@redhat.com, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org, linux-block@vger.kernel.org, drbd-dev@lists.linbit.com, nbd@other.debian.org, ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, Jens Axboe <axboe@kernel.dk>, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com, linux-mm@kvack.org, "Martin K . Petersen" <martin.petersen@oracle.com>, Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, David Sterba <dsterba@suse.com>
List-ID: <linux-um.lists.infradead.org>

On Sat, Apr 09, 2022 at 10:32:52PM +0800, Coly Li wrote:
>> Acked-by: Coly Li <colyli@suse.de> [drbd]
>
> Hi Christoph,
>
> My ACK is for bcache, not drbd here.

Fixed.

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

