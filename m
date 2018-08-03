Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1flTkx-0000cT-Ld
 for linux-um@lists.infradead.org; Fri, 03 Aug 2018 06:40:13 +0000
From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] um: NULL check before kfree is not needed
Date: Fri, 3 Aug 2018 14:39:11 +0800
Message-ID: <20180803063911.23384-1-yuehaibing@huawei.com>
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
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, christophe.jaillet@wanadoo.fr, keescook@chromium.org
Cc: YueHaibing <yuehaibing@huawei.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

kfree(NULL) is safe,so this removes NULL check before freeing the mem

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/um/drivers/vector_kern.c | 15 +++++----------
 arch/um/drivers/vector_user.c |  6 ++----
 arch/um/kernel/irq.c          |  3 +--
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 50ee3bb..c84133c 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1118,16 +1118,11 @@ static int vector_net_close(struct net_device *dev)
 		os_close_file(vp->fds->tx_fd);
 		vp->fds->tx_fd = -1;
 	}
-	if (vp->bpf != NULL)
-		kfree(vp->bpf);
-	if (vp->fds->remote_addr != NULL)
-		kfree(vp->fds->remote_addr);
-	if (vp->transport_data != NULL)
-		kfree(vp->transport_data);
-	if (vp->header_rxbuffer != NULL)
-		kfree(vp->header_rxbuffer);
-	if (vp->header_txbuffer != NULL)
-		kfree(vp->header_txbuffer);
+	kfree(vp->bpf);
+	kfree(vp->fds->remote_addr);
+	kfree(vp->transport_data);
+	kfree(vp->header_rxbuffer);
+	kfree(vp->header_txbuffer);
 	if (vp->rx_queue != NULL)
 		destroy_queue(vp->rx_queue);
 	if (vp->tx_queue != NULL)
diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index 4d6a78e..3d8cdbd 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -267,8 +267,7 @@ static struct vector_fds *user_init_raw_fds(struct arglist *ifspec)
 		os_close_file(rxfd);
 	if (txfd >= 0)
 		os_close_file(txfd);
-	if (result != NULL)
-		kfree(result);
+	kfree(result);
 	return NULL;
 }
 
@@ -434,8 +433,7 @@ static struct vector_fds *user_init_socket_fds(struct arglist *ifspec, int id)
 	if (fd >= 0)
 		os_close_file(fd);
 	if (result != NULL) {
-		if (result->remote_addr != NULL)
-			kfree(result->remote_addr);
+		kfree(result->remote_addr);
 		kfree(result);
 	}
 	return NULL;
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 6b7f382..8360fa3 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -244,8 +244,7 @@ static void garbage_collect_irq_entries(void)
 			to_free = NULL;
 		}
 		walk = walk->next;
-		if (to_free != NULL)
-			kfree(to_free);
+		kfree(to_free);
 	}
 }
 
-- 
2.7.0



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

