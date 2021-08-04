Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 15/15] nvme: use bvec_virt
Date: Wed,  4 Aug 2021 11:56:34 +0200
Message-Id: <20210804095634.460779-16-hch@lst.de>
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

Use bvec_virt instead of open coding it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dfd9dec0c1f6..02ce94b2906b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -968,12 +968,11 @@ void nvme_cleanup_cmd(struct request *req)
 {
 	if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
 		struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
-		struct page *page = req->special_vec.bv_page;
 
-		if (page == ctrl->discard_page)
+		if (req->special_vec.bv_page == ctrl->discard_page)
 			clear_bit_unlock(0, &ctrl->discard_page_busy);
 		else
-			kfree(page_address(page) + req->special_vec.bv_offset);
+			kfree(bvec_virt(&req->special_vec));
 	}
 }
 EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

