Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C30C30653
	for <linux-um@archiver.kernel.org>; Wed,  3 Jul 2024 16:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fycvKmLgeiYd1SRgq+dLQenVWrb2UcKrh6RMo5yFYo8=; b=QlT/7NC/6S26hrnHVzyHmshZJr
	TGmwcPQjEQzOLVh7JONe9HxaIMu4nUGr6B3w05Y3mSKO8kv/uxhV9cK1trw3++BYzik3oJG94UP2B
	tii65xsaLe6EDEzsjZQJEi/pZXSqJltSKu/snhm2rIOhtJbBnrVTZys2Wrh0hVo6wnfSN3A3Le6oh
	I/S1SpF3u4r6FpCcYV3ig79a9alQzAtwkjH88mjZi7TOk0Wp2UNh1QhNEFl1cXFs39S633yxHZ4qW
	AJo/i89dWtkK792dd92JBJVM2w87VlLbtE22swzlP+K/lYuCH3VSBS2W7fcN+l4267BJ7+j57g3vQ
	CqIq74sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP37l-0000000AtGf-45B8;
	Wed, 03 Jul 2024 16:46:29 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP37j-0000000AtGA-1ZLH
	for linux-um@lists.infradead.org;
	Wed, 03 Jul 2024 16:46:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=fycvKmLgeiYd1SRgq+dLQenVWrb2UcKrh6RMo5yFYo8=; t=1720025187; x=1721234787; 
	b=dRqyIPf+1jrrgekpO7WYvXsE7N/PCi0bCcsZJZ0EMEvxHSftC5xihSVzH/uLzGEBWfo4YmTHQWS
	PiyywiMrkdmpnQt7sEGO6JlVVISCmVkunDJAc6NmO54l+Jyo3YQTVArU4lPQQs7OS+gqeqcX0Wxv+
	DF5FN+VS7820deVKdK769VPj5OodPYYC8QSnmfiyP4prDSzfkWxpwETAKTM4CTdyIdyD8aYnoaea3
	qmCWsZ69dQoq4D8vFcfsyYlv3MjZDEc2a2YCdeqayFEcHNf/9dEk88QATZs+bPGbexEEFv8Tdgvmn
	POmABiXVM7iCHEbbqxi2ygwbddJhq1ZQQUzw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sP37g-00000009d05-3MBs;
	Wed, 03 Jul 2024 18:46:25 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] um: vector: always reset vp->opened
Date: Wed,  3 Jul 2024 18:46:23 +0200
Message-ID: <20240703184622.df40c5c38461.Id4e20b48938c6019d99e6133227a34ac059db466@changeid>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_094627_438514_3FE5D838 
X-CRM114-Status: GOOD (  10.60  )
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

If open fails, we have already set vp->opened, but it's
not reset so that any further attempts will just return
-ENXIO. Reset vp->opened even if close has nothing to do.

This helps e.g. with slirp4netns handling only a single
connection, you can then restart it and open the device
again.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/vector_kern.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 0861e32d2fbd..2d473282ab51 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1119,6 +1119,8 @@ static int vector_net_close(struct net_device *dev)
 	netif_stop_queue(dev);
 	del_timer(&vp->tl);
 
+	vp->opened = false;
+
 	if (vp->fds == NULL)
 		return 0;
 
@@ -1157,7 +1159,6 @@ static int vector_net_close(struct net_device *dev)
 		destroy_queue(vp->tx_queue);
 	kfree(vp->fds);
 	vp->fds = NULL;
-	vp->opened = false;
 	vp->in_error = false;
 	return 0;
 }
-- 
2.45.2


