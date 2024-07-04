Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9468C3271F
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 07:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RLRoaIXMs6CO10f/nw+4to6ny+d4lTJKaE6acHrBDvU=; b=UigpSasSiujWZf2eDaOs7GqlSo
	7aS+DwzfzdZo55ORsJb6MHnUolaEXPnCxDR/JbkWSd6Gb2kOfBkuL8KXbPttHRt3JA62N53+hgRv5
	wTPy8csZxYADQZsJdMYW7Or5pY2xMF2qB3XfTrXO1SgVL2DVyHA90r9rcGfThXmAVegmIZh5ydpNo
	sRETiJ5UMZkI1AOqn3JUfV4IkoHxquFAl+2/MECAmFgY3apDARJlFqD8TQ9MoC5a9ZEtj5wa7t8HY
	jPuO2YO/JyTTWJQzFD34lGU7t3YLxKIONmaJuxG1pGgKEl8U5FtEZ5JKYcHOI6yg+OIWazBkxyYAd
	CcVV+SJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPGnR-0000000CRAt-0nDj;
	Thu, 04 Jul 2024 07:22:25 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPGnO-0000000CRAR-3MJ0
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 07:22:24 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1sPGnM-005cBp-LM; Thu, 04 Jul 2024 07:22:20 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1sPGnC-007CZR-1a;
	Thu, 04 Jul 2024 08:22:17 +0100
From: anton.ivanov@cambridgegreys.com
To: linux-um@lists.infradead.org
Cc: johannes@sipsolutions.net,
	richard@nod.at,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [PATCH] um: vector: Replace locks guarding queue depth with atomics
Date: Thu,  4 Jul 2024 08:21:54 +0100
Message-Id: <20240704072154.1716301-1-anton.ivanov@cambridgegreys.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_002223_028174_122BECDB 
X-CRM114-Status: GOOD (  24.80  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

UML vector drivers use ring buffer structures which map
preallocated skbs onto mmsg vectors for use with sendmmsg
and recvmmsg. They are designed around a single consumer,
single producer pattern allowing simultaneous enqueue and
dequeue.

Lock debugging with preemption showed possible races when
locking the queue depth. This patch addresses this by
removing extra locks while making queue depth inc/dec and
access atomic.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/vector_kern.c | 158 ++++++++++++++--------------------
 arch/um/drivers/vector_kern.h |   4 +-
 2 files changed, 69 insertions(+), 93 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index dc2feae789cb..5c9bf458fe0a 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -22,6 +22,7 @@
 #include <linux/interrupt.h>
 #include <linux/firmware.h>
 #include <linux/fs.h>
+#include <asm/atomic.h>
 #include <uapi/linux/filter.h>
 #include <init.h>
 #include <irq_kern.h>
@@ -232,12 +233,6 @@ static int get_transport_options(struct arglist *def)
 
 static char *drop_buffer;
 
-/* Array backed queues optimized for bulk enqueue/dequeue and
- * 1:N (small values of N) or 1:1 enqueuer/dequeuer ratios.
- * For more details and full design rationale see
- * http://foswiki.cambridgegreys.com/Main/EatYourTailAndEnjoyIt
- */
-
 
 /*
  * Advance the mmsg queue head by n = advance. Resets the queue to
@@ -247,27 +242,14 @@ static char *drop_buffer;
 
 static int vector_advancehead(struct vector_queue *qi, int advance)
 {
-	int queue_depth;
-
 	qi->head =
 		(qi->head + advance)
 			% qi->max_depth;
 
 
-	spin_lock(&qi->tail_lock);
-	qi->queue_depth -= advance;
-
-	/* we are at 0, use this to
-	 * reset head and tail so we can use max size vectors
-	 */
+	atomic_sub(advance, &qi->queue_depth);
 
-	if (qi->queue_depth == 0) {
-		qi->head = 0;
-		qi->tail = 0;
-	}
-	queue_depth = qi->queue_depth;
-	spin_unlock(&qi->tail_lock);
-	return queue_depth;
+	return atomic_read(&qi->queue_depth);
 }
 
 /*	Advance the queue tail by n = advance.
@@ -277,16 +259,11 @@ static int vector_advancehead(struct vector_queue *qi, int advance)
 
 static int vector_advancetail(struct vector_queue *qi, int advance)
 {
-	int queue_depth;
-
 	qi->tail =
 		(qi->tail + advance)
 			% qi->max_depth;
-	spin_lock(&qi->head_lock);
-	qi->queue_depth += advance;
-	queue_depth = qi->queue_depth;
-	spin_unlock(&qi->head_lock);
-	return queue_depth;
+	atomic_add(advance, &qi->queue_depth);
+	return atomic_read(&qi->queue_depth);
 }
 
 static int prep_msg(struct vector_private *vp,
@@ -339,9 +316,7 @@ static int vector_enqueue(struct vector_queue *qi, struct sk_buff *skb)
 	int iov_count;
 
 	spin_lock(&qi->tail_lock);
-	spin_lock(&qi->head_lock);
-	queue_depth = qi->queue_depth;
-	spin_unlock(&qi->head_lock);
+	queue_depth = atomic_read(&qi->queue_depth);
 
 	if (skb)
 		packet_len = skb->len;
@@ -411,61 +386,58 @@ static int vector_send(struct vector_queue *qi)
 	int result = 0, send_len, queue_depth = qi->max_depth;
 
 	if (spin_trylock(&qi->head_lock)) {
-		if (spin_trylock(&qi->tail_lock)) {
-			/* update queue_depth to current value */
-			queue_depth = qi->queue_depth;
-			spin_unlock(&qi->tail_lock);
-			while (queue_depth > 0) {
-				/* Calculate the start of the vector */
-				send_len = queue_depth;
-				send_from = qi->mmsg_vector;
-				send_from += qi->head;
-				/* Adjust vector size if wraparound */
-				if (send_len + qi->head > qi->max_depth)
-					send_len = qi->max_depth - qi->head;
-				/* Try to TX as many packets as possible */
-				if (send_len > 0) {
-					result = uml_vector_sendmmsg(
-						 vp->fds->tx_fd,
-						 send_from,
-						 send_len,
-						 0
-					);
-					vp->in_write_poll =
-						(result != send_len);
-				}
-				/* For some of the sendmmsg error scenarios
-				 * we may end being unsure in the TX success
-				 * for all packets. It is safer to declare
-				 * them all TX-ed and blame the network.
-				 */
-				if (result < 0) {
-					if (net_ratelimit())
-						netdev_err(vp->dev, "sendmmsg err=%i\n",
-							result);
-					vp->in_error = true;
-					result = send_len;
-				}
-				if (result > 0) {
-					queue_depth =
-						consume_vector_skbs(qi, result);
-					/* This is equivalent to an TX IRQ.
-					 * Restart the upper layers to feed us
-					 * more packets.
-					 */
-					if (result > vp->estats.tx_queue_max)
-						vp->estats.tx_queue_max = result;
-					vp->estats.tx_queue_running_average =
-						(vp->estats.tx_queue_running_average + result) >> 1;
-				}
-				netif_wake_queue(qi->dev);
-				/* if TX is busy, break out of the send loop,
-				 *  poll write IRQ will reschedule xmit for us
+		/* update queue_depth to current value */
+		queue_depth = atomic_read(&qi->queue_depth);
+		while (queue_depth > 0) {
+			/* Calculate the start of the vector */
+			send_len = queue_depth;
+			send_from = qi->mmsg_vector;
+			send_from += qi->head;
+			/* Adjust vector size if wraparound */
+			if (send_len + qi->head > qi->max_depth)
+				send_len = qi->max_depth - qi->head;
+			/* Try to TX as many packets as possible */
+			if (send_len > 0) {
+				result = uml_vector_sendmmsg(
+					 vp->fds->tx_fd,
+					 send_from,
+					 send_len,
+					 0
+				);
+				vp->in_write_poll =
+					(result != send_len);
+			}
+			/* For some of the sendmmsg error scenarios
+			 * we may end being unsure in the TX success
+			 * for all packets. It is safer to declare
+			 * them all TX-ed and blame the network.
+			 */
+			if (result < 0) {
+				if (net_ratelimit())
+					netdev_err(vp->dev, "sendmmsg err=%i\n",
+						result);
+				vp->in_error = true;
+				result = send_len;
+			}
+			if (result > 0) {
+				queue_depth =
+					consume_vector_skbs(qi, result);
+				/* This is equivalent to an TX IRQ.
+				 * Restart the upper layers to feed us
+				 * more packets.
 				 */
-				if (result != send_len) {
-					vp->estats.tx_restart_queue++;
-					break;
-				}
+				if (result > vp->estats.tx_queue_max)
+					vp->estats.tx_queue_max = result;
+				vp->estats.tx_queue_running_average =
+					(vp->estats.tx_queue_running_average + result) >> 1;
+			}
+			netif_wake_queue(qi->dev);
+			/* if TX is busy, break out of the send loop,
+			 *  poll write IRQ will reschedule xmit for us
+			 */
+			if (result != send_len) {
+				vp->estats.tx_restart_queue++;
+				break;
 			}
 		}
 		spin_unlock(&qi->head_lock);
@@ -589,7 +561,7 @@ static struct vector_queue *create_queue(
 	}
 	spin_lock_init(&result->head_lock);
 	spin_lock_init(&result->tail_lock);
-	result->queue_depth = 0;
+	atomic_set(&result->queue_depth, 0);
 	result->head = 0;
 	result->tail = 0;
 	return result;
@@ -675,11 +647,13 @@ static void prep_queue_for_rx(struct vector_queue *qi)
 	struct vector_private *vp = netdev_priv(qi->dev);
 	struct mmsghdr *mmsg_vector = qi->mmsg_vector;
 	void **skbuff_vector = qi->skbuff_vector;
-	int i;
+	int i, queue_depth;
+
+	queue_depth = atomic_read(&qi->queue_depth);
 
-	if (qi->queue_depth == 0)
+	if (queue_depth == 0)
 		return;
-	for (i = 0; i < qi->queue_depth; i++) {
+	for (i = 0; i < queue_depth; i++) {
 		/* it is OK if allocation fails - recvmmsg with NULL data in
 		 * iov argument still performs an RX, just drops the packet
 		 * This allows us stop faffing around with a "drop buffer"
@@ -689,7 +663,7 @@ static void prep_queue_for_rx(struct vector_queue *qi)
 		skbuff_vector++;
 		mmsg_vector++;
 	}
-	qi->queue_depth = 0;
+	atomic_set(&qi->queue_depth, 0);
 }
 
 static struct vector_device *find_device(int n)
@@ -987,7 +961,7 @@ static int vector_mmsg_rx(struct vector_private *vp, int budget)
 	 * many do we need to prep the next time prep_queue_for_rx() is called.
 	 */
 
-	qi->queue_depth = packet_count;
+	atomic_add(packet_count, &qi->queue_depth);
 
 	for (i = 0; i < packet_count; i++) {
 		skb = (*skbuff_vector);
@@ -1234,7 +1208,7 @@ static int vector_net_open(struct net_device *dev)
 			vp->rx_header_size,
 			MAX_IOV_SIZE
 		);
-		vp->rx_queue->queue_depth = get_depth(vp->parsed);
+		atomic_set(&vp->rx_queue->queue_depth, get_depth(vp->parsed));
 	} else {
 		vp->header_rxbuffer = kmalloc(
 			vp->rx_header_size,
diff --git a/arch/um/drivers/vector_kern.h b/arch/um/drivers/vector_kern.h
index 2a1fa8e0f3e1..1b8de936056d 100644
--- a/arch/um/drivers/vector_kern.h
+++ b/arch/um/drivers/vector_kern.h
@@ -14,6 +14,7 @@
 #include <linux/ctype.h>
 #include <linux/workqueue.h>
 #include <linux/interrupt.h>
+#include <asm/atomic.h>
 
 #include "vector_user.h"
 
@@ -44,7 +45,8 @@ struct vector_queue {
 	struct net_device *dev;
 	spinlock_t head_lock;
 	spinlock_t tail_lock;
-	int queue_depth, head, tail, max_depth, max_iov_frags;
+	atomic_t queue_depth;
+	int head, tail, max_depth, max_iov_frags;
 	short options;
 };
 
-- 
2.39.2


