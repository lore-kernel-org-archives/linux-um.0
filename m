Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jE0MK-0008PV-3c
 for linux-um@lists.infradead.org; Tue, 17 Mar 2020 00:45:29 +0000
From: Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH 2/2] um: ubd: Retry buffer read on any kind of error
Date: Mon, 16 Mar 2020 20:45:07 -0400
Message-Id: <20200317004507.1513370-3-krisman@collabora.com>
In-Reply-To: <20200317004507.1513370-1-krisman@collabora.com>
References: <20200317004507.1513370-1-krisman@collabora.com>
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
To: jdike@addtoit.com
Cc: Martyn Welch <martyn.welch@collabora.com>, richard@nod.at, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Gabriel Krisman Bertazi <krisman@collabora.com>, anton.ivanov@cambridgegreys.com

Should bulk_req_safe_read return an error, we want to retry the read,
otherwise, even though no IO will be done, os_write_file might still end
up writing garbage to the pipe.

Cc: Martyn Welch <martyn.welch@collabora.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 arch/um/drivers/ubd_kern.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 0f5d0a699a49..d259f0728003 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1591,11 +1591,11 @@ int io_thread(void *arg)
 			&io_remainder_size,
 			UBD_REQ_BUFFER_SIZE
 		);
-		if (n < 0) {
-			if (n == -EAGAIN) {
+		if (n <= 0) {
+			if (n == -EAGAIN)
 				ubd_read_poll(-1);
-				continue;
-			}
+
+			continue;
 		}
 
 		for (count = 0; count < n/sizeof(struct io_thread_req *); count++) {
-- 
2.25.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

