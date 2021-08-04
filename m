Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 01/15] bvec: add a bvec_virt helper
Date: Wed,  4 Aug 2021 11:56:20 +0200
Message-Id: <20210804095634.460779-2-hch@lst.de>
In-Reply-To: <20210804095634.460779-1-hch@lst.de>
References: <20210804095634.460779-1-hch@lst.de>
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
To: Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Geoff Levand <geoff@infradead.org>, Ilya Dryomov <idryomov@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Song Liu <song@kernel.org>, Mike Snitzer <snitzer@redhat.com>, Coly Li <colyli@suse.de>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Phillip Lougher <phillip@squashfs.org.uk>, linux-block@vger.kernel.org, dm-devel@redhat.com, linux-um@lists.infradead.org, ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org

Add a helper to get the virtual address for a bvec.  This avoids that
all callers need to know about the page + offset representation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/bvec.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index f9fa43b940ff..0e9bdd42dafb 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -229,4 +229,16 @@ static inline void memzero_bvec(struct bio_vec *bvec)
 	memzero_page(bvec->bv_page, bvec->bv_offset, bvec->bv_len);
 }
 
+/**
+ * bvec_virt - return the virtual address for a bvec
+ * @bvec: bvec to return the virtual address for
+ *
+ * Note: the caller must ensure that @bvec->bv_page is not a highmem page.
+ */
+static inline void *bvec_virt(struct bio_vec *bvec)
+{
+	WARN_ON_ONCE(PageHighMem(bvec->bv_page));
+	return page_address(bvec->bv_page) + bvec->bv_offset;
+}
+
 #endif /* __LINUX_BVEC_H */
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

