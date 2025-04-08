Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B671FC3600C
	for <linux-um@archiver.kernel.org>; Tue,  8 Apr 2025 07:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6vzT2cM1MX5Wxb3hbIxixLDlOfTq7jM1ODYfPRiUdJI=; b=NoubzDd7awnYh16DPrei72Fat+
	9XKmLSNHzDgti4JsvsfzaxVqsQF9oTT4o9HLXa3EhMJpcy2k1Wu3M1YhveyLq4G8inshOA3MDcgw5
	/nLGiiomHPUTPWHe1cXvbMgRa+httFOiWFIJQnDsxXlSGdJTVRgOvMqospZ5tidiOqZUC5WBUfivt
	0k3CD+q3CHEeX1CWXHtOjIwG4yP2OuDbpBogcYPKvFV9wfEBSjuVtxkFLJWeQA3BBSaIkebUctd/b
	j6uRI1WLzVyE3Gc6RTXbnSWopAJTKUdjTx7gp+QFdtUf/2DI3q61CE2RizkqunRQA6EtOAT6og/v4
	kmVheBdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u23mH-000000039tZ-0zSl;
	Tue, 08 Apr 2025 07:53:49 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u23g3-000000038pP-0WiN
	for linux-um@lists.infradead.org;
	Tue, 08 Apr 2025 07:47:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=6vzT2cM1MX5Wxb3hbIxixLDlOfTq7jM1ODYfPRiUdJI=; t=1744098441; x=1745308041; 
	b=NQh205TIm2jIVVEnJGH0/b+3Q3szFDQbkqd07lm0WbWxfonQt9ecPYyDq8rEhSmBvFjvw1SF7Ku
	2VTmBcHGlSn08oUCRtmKaiaafofIBdNsaw26gZw1e3dvdN5Y/3Zi3N3Xpec06p64F3ESUdqDUfICS
	i+oMYPpYpJ71/Lu7hi0jxXjgvMTlG3hvSr8Lq5EtzqRm+WZreZI+EXr0KOum4yHeJ+KypXb8VJmM3
	6BM4ThCd/zd6+2lfqi4xV62x8wCC8yoiyyKmTT9+YAbS2YEESfNa3dmnfr3fCwKjKgjQvDMTcHLQM
	VHG9p77Oixtj8jXZW7owiP6jWsSrfzfC4ziQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1u23fy-00000003Ylg-1foB;
	Tue, 08 Apr 2025 09:47:18 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 1/2] um: do not send SIGALRM to userspace in time-travel mode
Date: Tue,  8 Apr 2025 09:45:23 +0200
Message-ID: <20250408074524.300153-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250408_004723_441819_842EF00D 
X-CRM114-Status: GOOD (  13.03  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

We send a SIGALRM to userspace processes to interrupt them. Really,
doing so is only needed if they are actually executing at the time (to
ensure we return to kernelspace). Unfortunately, we do not have that
information readily available. We can however be sure that this is never
the case when we are in time-travel mode with infinite CPU.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/kernel/time.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 1394568c0210..ae0fa2173778 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -856,11 +856,16 @@ static struct clock_event_device timer_clockevent = {
 
 static irqreturn_t um_timer(int irq, void *dev)
 {
-	if (get_current()->mm != NULL)
-	{
-        /* userspace - relay signal, results in correct userspace timers */
+	/*
+	 * Interrupt the (possibly) running userspace process, technically this
+	 * should only happen if userspace is currently executing.
+	 * With infinite CPU time-travel, we can only get here when userspace
+	 * is not executing. Do not notify there and avoid spurious scheduling.
+	 */
+	if (time_travel_mode != TT_MODE_INFCPU &&
+	    time_travel_mode != TT_MODE_EXTERNAL &&
+	    get_current()->mm)
 		os_alarm_process(get_current()->mm->context.id.pid);
-	}
 
 	(*timer_clockevent.event_handler)(&timer_clockevent);
 
-- 
2.49.0


