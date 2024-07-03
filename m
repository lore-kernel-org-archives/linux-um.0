Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756E8C2BD09
	for <linux-um@archiver.kernel.org>; Wed,  3 Jul 2024 16:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Tn1UU9v+NFQD2yGlIKC9eH/4d9EC2c3TWh1gvVr9iEc=; b=nlFRrh+Ch46EihM5zxfqetQKzE
	CzhlarGrkDtMzoF7KzbE293xI/Rjy/xCKkTG9GQ2gFpSN/Qy1mUp9oDnz5w+oqh1CfCXl2HtsYiPe
	KKQYoGJhp2kbMnLnKmEqX7KShs4AxwKasTHfksOunlVfOxUlMyfL+XfeTcUKd5M6tvYUwNcPQBHLL
	XB1mJ/CwuQKYH+j33GLe1qqDXjBKfp+Mm7DWY7rfIRwQfb7rWE6unRuQo2vwGaviSqL/npY1yEWVv
	hLIdNXuyZtLr16o2+gxzkgsVnLcqgyF+m/mHgbGuANLn2kWe3yZL7TpGKSANi3vzx5wEIOpPQA+fn
	NHwuJsXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP33D-0000000Asoe-3Z1j;
	Wed, 03 Jul 2024 16:41:47 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP33B-0000000AsoH-039E
	for linux-um@lists.infradead.org;
	Wed, 03 Jul 2024 16:41:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=Tn1UU9v+NFQD2yGlIKC9eH/4d9EC2c3TWh1gvVr9iEc=; t=1720024904; x=1721234504; 
	b=T5t4wjcwdpoZTdDo0q2PeP/oreO1rJxBXmWRjWtANn64IksB5IHmOUFVpUOEs5fE09Ry7MABkXg
	34XWRhHU3htqXrxswmeuC8EVHZ7ynJpYCA4VInEMH5UWN9odz8r8sLSX6wOrnYu6OQXX/4EiXCFul
	Pcjb8tIHEcDjtjODHZ7pDP5kFBX/MvCRBbFs+MxHy6o3O2XXSJrm3DzASNtbv+iNzoXf2YljCznYc
	v+RlYF2KZtRade6d1jPttlogxUKDAIN5PWOQ1I4FtQOTgpf4019HXgb17hp+aUYYaQaPErMbcGYEC
	hZCE9JPu+PgrmhnnobqXkID8Q7KjVOLvI9sw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sP338-00000009bwM-14Xw;
	Wed, 03 Jul 2024 18:41:42 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] um: vector: remove vp->lock
Date: Wed,  3 Jul 2024 18:41:40 +0200
Message-ID: <20240703184139.88e0baf9a4fe.I9cf5f2c4e35abd06cc89bf2e990fa755eb8e5f0f@changeid>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_094145_077187_8C145640 
X-CRM114-Status: GOOD (  11.34  )
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

From: Johannes Berg <johannes.berg@intel.com>

This lock is useless, all the places that are using
it for some locking will already hold the RTNL. Just
remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/vector_kern.c | 14 +-------------
 arch/um/drivers/vector_kern.h |  1 -
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 4279793b11b7..a46f7f6d131e 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1158,10 +1158,8 @@ static int vector_net_close(struct net_device *dev)
 		destroy_queue(vp->tx_queue);
 	kfree(vp->fds);
 	vp->fds = NULL;
-	spin_lock_irqsave(&vp->lock, flags);
 	vp->opened = false;
 	vp->in_error = false;
-	spin_unlock_irqrestore(&vp->lock, flags);
 	return 0;
 }
 
@@ -1207,13 +1205,9 @@ static int vector_net_open(struct net_device *dev)
 	int err = -EINVAL;
 	struct vector_device *vdevice;
 
-	spin_lock_irqsave(&vp->lock, flags);
-	if (vp->opened) {
-		spin_unlock_irqrestore(&vp->lock, flags);
+	if (vp->opened)
 		return -ENXIO;
-	}
 	vp->opened = true;
-	spin_unlock_irqrestore(&vp->lock, flags);
 
 	vp->bpf = uml_vector_user_bpf(get_bpf_file(vp->parsed));
 
@@ -1387,8 +1381,6 @@ static int vector_net_load_bpf_flash(struct net_device *dev,
 		return -1;
 	}
 
-	spin_lock(&vp->lock);
-
 	if (vp->bpf != NULL) {
 		if (vp->opened)
 			uml_vector_detach_bpf(vp->fds->rx_fd, vp->bpf);
@@ -1417,15 +1409,12 @@ static int vector_net_load_bpf_flash(struct net_device *dev,
 	if (vp->opened)
 		result = uml_vector_attach_bpf(vp->fds->rx_fd, vp->bpf);
 
-	spin_unlock(&vp->lock);
-
 	return result;
 
 free_buffer:
 	release_firmware(fw);
 
 flash_fail:
-	spin_unlock(&vp->lock);
 	if (vp->bpf != NULL)
 		kfree(vp->bpf->filter);
 	kfree(vp->bpf);
@@ -1631,7 +1620,6 @@ static void vector_eth_configure(
 	INIT_WORK(&vp->reset_tx, vector_reset_tx);
 
 	timer_setup(&vp->tl, vector_timer_expire, 0);
-	spin_lock_init(&vp->lock);
 
 	/* FIXME */
 	dev->netdev_ops = &vector_netdev_ops;
diff --git a/arch/um/drivers/vector_kern.h b/arch/um/drivers/vector_kern.h
index 2a1fa8e0f3e1..806df551be0b 100644
--- a/arch/um/drivers/vector_kern.h
+++ b/arch/um/drivers/vector_kern.h
@@ -71,7 +71,6 @@ struct vector_estats {
 
 struct vector_private {
 	struct list_head list;
-	spinlock_t lock;
 	struct net_device *dev;
 	struct napi_struct		napi	____cacheline_aligned;
 
-- 
2.45.2


