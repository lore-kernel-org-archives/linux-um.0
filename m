Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from [43.155.65.254] (helo=smtpbg.qq.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEFQe-009vPO-RA
	for linux-um@lists.infradead.org; Wed, 20 Jul 2022 19:32:21 +0000
From: Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] ubd:do not initialise statics to 0.
Date: Thu, 21 Jul 2022 03:29:16 +0800
Message-Id: <20220720192916.7564-1-gaoxin@cdjrlc.com>
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
To: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net
Cc: axboe@kernel.dk, martin.petersen@oracle.com, hoeppner@linux.ibm.com, kch@nvidia.com, frederic.danis@collabora.com, mcgrof@kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Xin Gao <gaoxin@cdjrlc.com>

do not initialise statics to 0.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 arch/um/drivers/ubd_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index c4344b67628d..ae2fb671ba72 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1555,7 +1555,7 @@ static void do_io(struct io_thread_req *req, struct io_desc *desc)
 int kernel_fd = -1;
 
 /* Only changed by the io thread. XXX: currently unused. */
-static int io_count = 0;
+static int io_count;
 
 int io_thread(void *arg)
 {
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

