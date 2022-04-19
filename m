Return-Path: <linux-mtd-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Tue, 19 Apr 2022 14:55:17 +0200
From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH 27/27] direct-io: remove random prefetches
Message-ID: <20220419125517.GB2348@twin.jikos.cz>
References: <20220415045258.199825-1-hch@lst.de>
 <20220415045258.199825-28-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220415045258.199825-28-hch@lst.de>
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

On Fri, Apr 15, 2022 at 06:52:58AM +0200, Christoph Hellwig wrote:
> Randomly poking into block device internals for manual prefetches isn't
> exactly a very maintainable thing to do.  And none of the performance
> criticil direct I/O implementations still use this library function
> anyway, so just drop it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

That the direct io function needed a valid bdev just for the prefetch
but nothing else was one of the reasons we had to keep the latest_bdev
in btrfs, so good riddance.

You may want to add the reference to the patch that added the prefetch,
65dd2aa90aa1 ("dio: optimize cache misses in the submission path") and
also remove #include <linux/prefetch.h> as there are no more uses of
prefetch in the file.

With that

Reviewed-by: David Sterba <dsterba@suse.com>

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

