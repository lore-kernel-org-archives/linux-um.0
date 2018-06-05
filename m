Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab5.miniserver.com ([78.31.111.25]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fQAMI-0001zd-MO
 for linux-um@lists.infradead.org; Tue, 05 Jun 2018 11:42:40 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH] Fix initialization of vector queues in UML
Date: Tue,  5 Jun 2018 09:27:30 +0100
Message-Id: <20180605082730.30919-1-anton.ivanov@cambridgegreys.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: richard.weinberger@gmail.com, dan.carpenter@oracle.com, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

UML vector drivers could derefence uninitialized memory
when cleaning up after a queue allocation failure.

Reported by Dan Capenter dan.carpenter@oracle.com

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/vector_kern.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 02168fe25105..8b852928959b 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -504,15 +504,19 @@ static struct vector_queue *create_queue(
 
 	result = kmalloc(sizeof(struct vector_queue), GFP_KERNEL);
 	if (result == NULL)
-		goto out_fail;
+		return NULL;
 	result->max_depth = max_size;
 	result->dev = vp->dev;
 	result->mmsg_vector = kmalloc(
 		(sizeof(struct mmsghdr) * max_size), GFP_KERNEL);
+	if (result->mmsg_vector == NULL)
+		goto out_mmsg_fail;
 	result->skbuff_vector = kmalloc(
 		(sizeof(void *) * max_size), GFP_KERNEL);
-	if (result->mmsg_vector == NULL || result->skbuff_vector == NULL)
-		goto out_fail;
+	if (result->skbuff_vector == NULL)
+		goto out_skb_fail;
+
+	/* further failures can be handled safely by destroy_queue*/
 
 	mmsg_vector = result->mmsg_vector;
 	for (i = 0; i < max_size; i++) {
@@ -563,6 +567,11 @@ static struct vector_queue *create_queue(
 	result->head = 0;
 	result->tail = 0;
 	return result;
+out_skb_fail:
+	kfree(result->mmsg_vector);
+out_mmsg_fail:
+	kfree(result);
+	return NULL;
 out_fail:
 	destroy_queue(result);
 	return NULL;
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

