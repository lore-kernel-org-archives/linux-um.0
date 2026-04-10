Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE5FF45A08
	for <linux-um@archiver.kernel.org>; Fri, 10 Apr 2026 20:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Bg1THXuqlaX4hybh4CmPAceCR0tZGm2LDqqlEfk6Eg0=; b=OSogIb/0QNPjZWsMX0hfVqmQYF
	xOXDDPf2aK62QH+pzsZlCyAXHSGI7HR8jzj4iwW/HKq52sCWeZKzJBuWy57gyDVpMWho8oPV9QJfI
	lWLRhiIpc65hnr20cETuuWjiAj5WumJ2B+s4m4Er4KxBubt3fXucl2QCrZuldAaXWMplsvWLgW5Oz
	pIB1MsjNDtLCpr2Pp3+X772lcJOg3aVW/gpN8fWd1LWpnXoS0xyo7nKd0NPa0YiKTWQULVIp9oVWj
	a+3wxBtI/CLpFr4qBHz1nU3lOQKUqEFaLWRdeDOR+3jMJMDeB/p3lI/TgxvUrp5mjr9ZljBEMHRLn
	oITIo2ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wBIV6-0000000ClwZ-3hwu;
	Fri, 10 Apr 2026 20:30:48 +0000
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wBIV4-0000000Clw3-1Iq5
	for linux-um@lists.infradead.org;
	Fri, 10 Apr 2026 20:30:47 +0000
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-8a1e1817db6so20422086d6.2
        for <linux-um@lists.infradead.org>; Fri, 10 Apr 2026 13:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775853044; x=1776457844; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bg1THXuqlaX4hybh4CmPAceCR0tZGm2LDqqlEfk6Eg0=;
        b=XrM46eS2oBpDOK4XTkKf5tC3Z8ruXVbze3eJ4W7eQB7ujg5mrRzkyzZVMldbE30Ofa
         xs5O/2I1un9eNQ20blQ1sFPZHvotuYNNO6i3LWM2HWwE1ImFL0QbVVObbwSZDD/QEyqo
         CRGf8EAVX1SGQjlpBXZsfdtXPoA+fvyLB2jVJ+Ab6ochsdDaeFcjjt7o4Wo41DFxuvWV
         l6aYagWvOGJYzO7hbaEJ1oY+TsAk1Js2Lo0n/nUrsP7b83NY1sCoYJDEgl1UTfLiE3Rz
         EWP+COuqQ1ZDtX9ETJ02DhqJan1rwF/kxnoz72Ycg+XwtYin4h+58aeVhbPRXHf914qw
         zEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775853044; x=1776457844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bg1THXuqlaX4hybh4CmPAceCR0tZGm2LDqqlEfk6Eg0=;
        b=HtMPMR77Ij6tQQfE117oKK9am9Jqf+PmDS7AFjZ8C3BZveBwcJUDSh0A6IZCFG+r8Z
         vW9bKxTM2f31sAtUL0J+OLNi4P5havJHI5Uf8Ykmsje6Jcbwv5R7XUyawtQzO4cghPNt
         ++Vjzpm84FhdXEiqExSHc7tQIaAF8zPUsLQLoiYclLkInY1Q2e9uMWztxYW8SfC673aS
         yJGxzzGmBZYqfr1Ax0DNCOW/Qy7ReEsBqUvIG1bjcH9XDlFRD3Dy6TCWMt8AfyDkUSF5
         W03FHAu7siZ2bV0ME2H56vh4eO0c8YlgXpYTn1pSf3w8K7xTa1o/QxJwUpJ8b2tbQPyC
         Xmcw==
X-Gm-Message-State: AOJu0YwT+61kM7dBJw4PbgCBNOGiXv+BQuhCp+5HO53Vbc4g8+zCix6r
	JI37VtY84SM+kx1W7RQ1Lmbr5rCMgRNJII6AC+bWyyBL4vojawfnYTam
X-Gm-Gg: AeBDieupVQDbScETaeEfxsJHKLvm42tYHXmYvPEnOA2S9O+STuQODZgg9H22SIG7K0L
	xaQhzIMlRXryU5qEtzjCSX7noeqCkwiBsaGwt53yV6RFy2RbNz4pjI1xAnhMyEG5cRrQ3zow5M7
	e5cSPl8k5/rc5Znt1Ub3Lx5U/kuGLmGncVezUvI/d/Sf6+z9v2YsIFv/YGWHNh1e8ZPCE5K9JvD
	xH6r3xAGO7lhjoYoHFUj+YHrpOhw3eCBlpUPnXAOekeZ7fVZ/mua2rxQFq2TlVET/T+FcPi6FMg
	lgN32VoFTHJGPyBK1je+8KORO2gmwQj3mowL4bDPDbxFfugufXqiQkb7JwY3JIMS0jFN98Fl670
	RxUsmUTPsS3Q/Ink3AcwyeZKPJxj80pIhiXMQhRsDhlDOQPRQhYGcgI//novP/MyD83jQYrFbdH
	2wo+TSNG5Phv6OWXFHN49oiyZVOSKwpnmUiTuIBTuEPzpNMx94XrMck2ulqxcJ+/fin2FqeL0Ye
	kLRjvm3xWe0pYrVfz3a9Qrvs+s8oOs8RWqPgw==
X-Received: by 2002:a05:6214:4706:b0:8a0:a3fb:862c with SMTP id 6a1803df08f44-8ac86162c8amr60783576d6.8.1775853044441;
        Fri, 10 Apr 2026 13:30:44 -0700 (PDT)
Received: from workstation1 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84c9c37csm30845756d6.36.2026.04.10.13.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 13:30:43 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: [PATCH] um: vector: fix NULL pointer derefs in queue-less transports
Date: Fri, 10 Apr 2026 16:30:28 -0400
Message-ID: <20260410203028.3717914-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260410_133046_361556_7695711E 
X-CRM114-Status: GOOD (  14.20  )
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

TAP transport sets neither VECTOR_RX nor VECTOR_TX, so
vector_net_open() never allocates rx_queue or tx_queue.  HYBRID sets
VECTOR_RX but not VECTOR_TX, so tx_queue is NULL there too.

vector_reset_stats(), vector_poll(), vector_get_ethtool_stats(), and
vector_get_ringparam() unconditionally deref these queue pointers,
causing a NULL pointer crash on SMP or with any lock debugging option.

Guard all queue pointer accesses with NULL checks.

Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
Cc: stable@vger.kernel.org
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Found while enabling KCOV and lockdep on UML for a network-stack
test lab.  Tested boot with SMP=y + PROVE_LOCKING + DEBUG_SPINLOCK +
DEBUG_LOCK_ALLOC + LOCKDEP + KCOV, all with vec0:transport=tap.

Without the fix, the same config panics at addr 0x18 (SMP, no debug),
0x1c (DEBUG_SPINLOCK), or 0x30 (lockdep) -- all offsets into a NULL
vector_queue pointer.

 arch/um/drivers/vector_kern.c | 48 +++++++++++++++++------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 2cc90055499a5..6134c376e57be 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -105,25 +105,18 @@ static const struct {
 
 static void vector_reset_stats(struct vector_private *vp)
 {
-	/* We reuse the existing queue locks for stats */
-
-	/* RX stats are modified with RX head_lock held
-	 * in vector_poll.
-	 */
-
-	spin_lock(&vp->rx_queue->head_lock);
+	if (vp->rx_queue)
+		spin_lock(&vp->rx_queue->head_lock);
 	vp->estats.rx_queue_max = 0;
 	vp->estats.rx_queue_running_average = 0;
 	vp->estats.rx_encaps_errors = 0;
 	vp->estats.sg_ok = 0;
 	vp->estats.sg_linearized = 0;
-	spin_unlock(&vp->rx_queue->head_lock);
-
-	/* TX stats are modified with TX head_lock held
-	 * in vector_send.
-	 */
+	if (vp->rx_queue)
+		spin_unlock(&vp->rx_queue->head_lock);
 
-	spin_lock(&vp->tx_queue->head_lock);
+	if (vp->tx_queue)
+		spin_lock(&vp->tx_queue->head_lock);
 	vp->estats.tx_timeout_count = 0;
 	vp->estats.tx_restart_queue = 0;
 	vp->estats.tx_kicks = 0;
@@ -131,7 +124,8 @@ static void vector_reset_stats(struct vector_private *vp)
 	vp->estats.tx_flow_control_xoff = 0;
 	vp->estats.tx_queue_max = 0;
 	vp->estats.tx_queue_running_average = 0;
-	spin_unlock(&vp->tx_queue->head_lock);
+	if (vp->tx_queue)
+		spin_unlock(&vp->tx_queue->head_lock);
 }
 
 static int get_mtu(struct arglist *def)
@@ -1163,7 +1157,8 @@ static int vector_poll(struct napi_struct *napi, int budget)
 
 	if ((vp->options & VECTOR_TX) != 0)
 		tx_enqueued = (vector_send(vp->tx_queue) > 0);
-	spin_lock(&vp->rx_queue->head_lock);
+	if (vp->rx_queue)
+		spin_lock(&vp->rx_queue->head_lock);
 	if ((vp->options & VECTOR_RX) > 0)
 		err = vector_mmsg_rx(vp, budget);
 	else {
@@ -1171,7 +1166,8 @@ static int vector_poll(struct napi_struct *napi, int budget)
 		if (err > 0)
 			err = 1;
 	}
-	spin_unlock(&vp->rx_queue->head_lock);
+	if (vp->rx_queue)
+		spin_unlock(&vp->rx_queue->head_lock);
 	if (err > 0)
 		work_done += err;
 
@@ -1421,10 +1417,10 @@ static void vector_get_ringparam(struct net_device *netdev,
 {
 	struct vector_private *vp = netdev_priv(netdev);
 
-	ring->rx_max_pending = vp->rx_queue->max_depth;
-	ring->tx_max_pending = vp->tx_queue->max_depth;
-	ring->rx_pending = vp->rx_queue->max_depth;
-	ring->tx_pending = vp->tx_queue->max_depth;
+	ring->rx_max_pending = vp->rx_queue ? vp->rx_queue->max_depth : 0;
+	ring->tx_max_pending = vp->tx_queue ? vp->tx_queue->max_depth : 0;
+	ring->rx_pending = ring->rx_max_pending;
+	ring->tx_pending = ring->tx_max_pending;
 }
 
 static void vector_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
@@ -1466,11 +1462,15 @@ static void vector_get_ethtool_stats(struct net_device *dev,
 	 * to date.
 	 */
 
-	spin_lock(&vp->tx_queue->head_lock);
-	spin_lock(&vp->rx_queue->head_lock);
+	if (vp->tx_queue)
+		spin_lock(&vp->tx_queue->head_lock);
+	if (vp->rx_queue)
+		spin_lock(&vp->rx_queue->head_lock);
 	memcpy(tmp_stats, &vp->estats, sizeof(struct vector_estats));
-	spin_unlock(&vp->rx_queue->head_lock);
-	spin_unlock(&vp->tx_queue->head_lock);
+	if (vp->rx_queue)
+		spin_unlock(&vp->rx_queue->head_lock);
+	if (vp->tx_queue)
+		spin_unlock(&vp->tx_queue->head_lock);
 }
 
 static int vector_get_coalesce(struct net_device *netdev,
-- 
2.53.0


