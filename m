Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941C2CD4F54
	for <linux-um@archiver.kernel.org>; Wed, 27 May 2026 21:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fphW4rHUVe+C56qeFdS/zmuB1kF3LRQ0KTlNnIQ1XGQ=; b=bdt9yvtMzm2Ub5TAjWatQhGEcA
	xfXdmngbQ5lt+rg1z3b8aeAOhr71WX8AMUODddcH/M1OPfNo5lsRwa6APtyUjMbtAR12wgr09WPkt
	B/pDqtZFDOJ49AqzQEmqApYI2d6VZvGeqmuoxGSA94EUmxfK8H/bf4KWktbA0EGnr/Z7SIhwQhS5K
	AAUsQhrZXhgxKdCos2QvxsNHtCURYYe7+iTcGeaiwJIiiEabJFNzBvmsnlsivf1BfzP8C6HZK/SeO
	xk0uBmsSD9tx+opN6XX3eHgFY5mx4SiNP7CuLdxI14Yti9K9An32tQRRnT52LfJ0MwLehtqqRtzjq
	nfTuG3dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSLv0-00000004lRg-0xiC;
	Wed, 27 May 2026 21:36:02 +0000
Received: from smtp805.umblergrid.com ([170.233.86.165])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSLuw-00000004lRD-2rPF
	for linux-um@lists.infradead.org;
	Wed, 27 May 2026 21:36:00 +0000
Received: by smtp805.umblergrid.com id h2th4i3cs18j for <linux-um@lists.infradead.org>; Wed, 27 May 2026 18:29:35 -0300 (envelope-from <contato@henrybarreto.dev>)
Received: from UBMSA01.spo2.umbler.com (smtp3001.umbler.com [187.84.237.185])
	by UBCNTSCOUT01.umbler.com (8.15.2/8.15.2/Debian-8) with ESMTP id 64RLZjR5047187
	for <linux-um@lists.infradead.org>; Wed, 27 May 2026 18:35:47 -0300
Received: by UBMSA01.spo2.umbler.com (Postfix, from userid 999)
	id 18A27200EB; Wed, 27 May 2026 18:35:45 -0300 (-03)
Received: from dellg155510 (unknown [201.182.197.232])
	by UBMSA01.spo2.umbler.com (Postfix) with ESMTPSA id 649792005E;
	Wed, 27 May 2026 18:35:31 -0300 (-03)
From: Henry Barreto <contato@henrybarreto.dev>
To: Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
        Tiwei Bie <tiwei.btw@antgroup.com>, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, Henry Barreto <me@henrybarreto.dev>
Subject: [PATCH] um: vector: avoid NULL queue dereference in legacy RX mode
Date: Wed, 27 May 2026 18:35:24 -0300
Message-ID: <20260527213524.45903-1-contato@henrybarreto.dev>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bayes-Prob: 0.0001 (Score 0, tokens from: outgoing, base:default, @@RPTN)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_143558_898771_5154C8D6 
X-CRM114-Status: GOOD (  11.76  )
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

From: Henry Barreto <me@henrybarreto.dev>

Bringing a UML vector netdev up can panic in vector_net_open() with a
fault in _raw_spin_lock().

vector_net_open() calls vector_reset_stats(), which takes the RX and TX
queue locks. However, queue allocation depends on runtime transport
options. With tap transport, vector RX/TX queues are not created and the
legacy header buffers are used instead. Taking a queue lock then
dereferences a NULL queue pointer.

Take the queue locks in vector_reset_stats() only when the corresponding
queue exists. Also move the RX queue lock in vector_poll() into the
VECTOR_RX path, so legacy RX does not touch rx_queue.

Fixes: 612a8c8e0b43 ("um: vector: Replace locks guarding queue depth with atomics")
Signed-off-by: Henry Barreto <me@henrybarreto.dev>
---
 arch/um/drivers/vector_kern.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 25d9258fa592..70762f15d093 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -110,19 +110,26 @@ static void vector_reset_stats(struct vector_private *vp)
 	 * in vector_poll.
 	 */
 
-	spin_lock(&vp->rx_queue->head_lock);
+	if (vp->rx_queue)
+		spin_lock(&vp->rx_queue->head_lock);
+
 	vp->estats.rx_queue_max = 0;
 	vp->estats.rx_queue_running_average = 0;
 	vp->estats.rx_encaps_errors = 0;
 	vp->estats.sg_ok = 0;
 	vp->estats.sg_linearized = 0;
-	spin_unlock(&vp->rx_queue->head_lock);
+
+	if (vp->rx_queue)
+		spin_unlock(&vp->rx_queue->head_lock);
+
 
 	/* TX stats are modified with TX head_lock held
 	 * in vector_send.
 	 */
 
-	spin_lock(&vp->tx_queue->head_lock);
+	if (vp->tx_queue)
+		spin_lock(&vp->tx_queue->head_lock);
+
 	vp->estats.tx_timeout_count = 0;
 	vp->estats.tx_restart_queue = 0;
 	vp->estats.tx_kicks = 0;
@@ -130,7 +137,10 @@ static void vector_reset_stats(struct vector_private *vp)
 	vp->estats.tx_flow_control_xoff = 0;
 	vp->estats.tx_queue_max = 0;
 	vp->estats.tx_queue_running_average = 0;
-	spin_unlock(&vp->tx_queue->head_lock);
+
+	if (vp->tx_queue)
+		spin_unlock(&vp->tx_queue->head_lock);
+
 }
 
 static int get_mtu(struct arglist *def)
@@ -1168,15 +1178,15 @@ static int vector_poll(struct napi_struct *napi, int budget)
 
 	if ((vp->options & VECTOR_TX) != 0)
 		tx_enqueued = (vector_send(vp->tx_queue) > 0);
-	spin_lock(&vp->rx_queue->head_lock);
-	if ((vp->options & VECTOR_RX) > 0)
+	if ((vp->options & VECTOR_RX) > 0) {
+		spin_lock(&vp->rx_queue->head_lock);
 		err = vector_mmsg_rx(vp, budget);
-	else {
+		spin_unlock(&vp->rx_queue->head_lock);
+	} else {
 		err = vector_legacy_rx(vp);
 		if (err > 0)
 			err = 1;
 	}
-	spin_unlock(&vp->rx_queue->head_lock);
 	if (err > 0)
 		work_done += err;
 
-- 
2.54.0


