Return-Path: <linux-kernel-owner@vger.kernel.org>
From: ira.weiny@intel.com
Subject: [PATCH RFC PKS/PMEM 47/58] drivers/mtd: Utilize new kmap_thread()
Date: Fri,  9 Oct 2020 12:50:22 -0700
Message-Id: <20201009195033.3208459-48-ira.weiny@intel.com>
In-Reply-To: <20201009195033.3208459-1-ira.weiny@intel.com>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Ira Weiny <ira.weiny@intel.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, kexec@lists.infradead.org, linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org, devel@driverdev.osuosl.org, linux-efi@vger.kernel.org, linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-um@lists.infradead.org, linux-ntfs-dev@lists.sourceforge.net, reiserfs-devel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-nilfs@vger.kernel.org, cluster-devel@redhat.com, ecryptfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-afs@lists.infradead.org, linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, xen-devel@lists.xenproject.org, linux-cachefs@redhat.com, samba-technical@lists.samba.org, intel-wired-lan@lists.osuosl.org
List-ID: <linux-um.lists.infradead.org>

From: Ira Weiny <ira.weiny@intel.com>

These kmap() calls are localized to a single thread.  To avoid the over
head of global PKRS updates use the new kmap_thread() call.

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/mtd/mtd_blkdevs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 0c05f77f9b21..4b18998273fa 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -88,14 +88,14 @@ static blk_status_t do_blktrans_request(struct mtd_blktrans_ops *tr,
 			return BLK_STS_IOERR;
 		return BLK_STS_OK;
 	case REQ_OP_READ:
-		buf = kmap(bio_page(req->bio)) + bio_offset(req->bio);
+		buf = kmap_thread(bio_page(req->bio)) + bio_offset(req->bio);
 		for (; nsect > 0; nsect--, block++, buf += tr->blksize) {
 			if (tr->readsect(dev, block, buf)) {
-				kunmap(bio_page(req->bio));
+				kunmap_thread(bio_page(req->bio));
 				return BLK_STS_IOERR;
 			}
 		}
-		kunmap(bio_page(req->bio));
+		kunmap_thread(bio_page(req->bio));
 		rq_flush_dcache_pages(req);
 		return BLK_STS_OK;
 	case REQ_OP_WRITE:
@@ -103,14 +103,14 @@ static blk_status_t do_blktrans_request(struct mtd_blktrans_ops *tr,
 			return BLK_STS_IOERR;
 
 		rq_flush_dcache_pages(req);
-		buf = kmap(bio_page(req->bio)) + bio_offset(req->bio);
+		buf = kmap_thread(bio_page(req->bio)) + bio_offset(req->bio);
 		for (; nsect > 0; nsect--, block++, buf += tr->blksize) {
 			if (tr->writesect(dev, block, buf)) {
-				kunmap(bio_page(req->bio));
+				kunmap_thread(bio_page(req->bio));
 				return BLK_STS_IOERR;
 			}
 		}
-		kunmap(bio_page(req->bio));
+		kunmap_thread(bio_page(req->bio));
 		return BLK_STS_OK;
 	default:
 		return BLK_STS_IOERR;
-- 
2.28.0.rc0.12.gb6a658bd00c9


