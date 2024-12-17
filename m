Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC7AE7717F
	for <linux-um@archiver.kernel.org>; Tue, 17 Dec 2024 20:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=661pQ3oC9KDKUA82aKeSZ2nZDACXmlz+oSIgkXicVWA=; b=NPiK7E8APMKhFFHt14S09FfC2j
	wDBhzIfLGTrjilpn6XWFH0/NxD5PkHrvn6ZS+rOV+wEm+9L2Qkzg3NO5sHw86Cu75X7xqZmIjzsMv
	XT2Kc95sGsj4ITIySdGbN7FydiINFssFjeFKS9OIJTSHoS5R04x0Xt3pn93MVK+m9Ud2zBPPtWC4X
	TyXenbhKuBsPNyHirJVd0p+9LyEAk235asbsXPEj68OBk0vwAwFGApULpZlNXg+OuG65Zr2/N9mhx
	lTS2DDCV+tOc3pfL1CaXi94s80Y1qImiN6oBFrqXreSAHIZlOxuKknT5hFQKTRabcNgjdQ/D1ntUK
	6TCO4CSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNeWZ-0000000EmjS-0EWS;
	Tue, 17 Dec 2024 20:50:35 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNeWW-0000000Emj5-1UN7
	for linux-um@lists.infradead.org;
	Tue, 17 Dec 2024 20:50:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=661pQ3oC9KDKUA82aKeSZ2nZDACXmlz+oSIgkXicVWA=; t=1734468632; x=1735678232; 
	b=tBn8yHakpdO8UDRO0B08pSpsTbiJEgWrkAF60YBNXaskUxe2rud3zVdjng8FAUBGv+FDmbZ54ev
	EzktKjIBt0BEJ88ZVHe+FH1z9py5C663KRfZqlxGQEoLfMLJDRiAY5zyBZwaF5EzUuOUgQqa/yVep
	hNCaxPY6kyJWuv6xhGlxCME3hT2j4ncJW4zvWRgPLazYa7CUuuU5upeyc5ug46Ql2794RH1OxReip
	ebzX8ZjSI0sU4JqBIR6ycX7SjP9C/j5FYsdI/mKF8FCrevbOsUV3xvkHOuGIvfGFVxa3m+7KSMV0h
	ZaeDxEIy9fSIBbe2m9e1/94XRmXcoFJlLtGw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tNeWT-00000002OcN-1tEQ;
	Tue, 17 Dec 2024 21:50:29 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH] um: rtc: use RTC time when calculating the alarm
Date: Tue, 17 Dec 2024 21:49:06 +0100
Message-ID: <20241217204906.1408011-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_125032_396384_21166141 
X-CRM114-Status: GOOD (  12.14  )
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

The kernel realtime and the current RTC time may have a (small) offset.
Should the kernel time be slightly in the future, then the timeout is
zero. This is problematic in time-travel mode, as a zero timeout can be
correctly configured and time never advances.

Replace the kernel realtime read with a read of the actual persistent
RTC clock. Also, for time-travel, calculate the exact nanoseconds needed
for the clock to advance.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Co-developed-by: Avraham Stern <avraham.stern@intel.com>
---
 arch/um/drivers/rtc_kern.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/rtc_kern.c b/arch/um/drivers/rtc_kern.c
index 134a58f93c85..9158c936c128 100644
--- a/arch/um/drivers/rtc_kern.c
+++ b/arch/um/drivers/rtc_kern.c
@@ -51,6 +51,7 @@ static int uml_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 static int uml_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
 {
+	struct timespec64 ts;
 	unsigned long long secs;
 
 	if (!enable && !uml_rtc_alarm_enabled)
@@ -58,7 +59,8 @@ static int uml_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
 
 	uml_rtc_alarm_enabled = enable;
 
-	secs = uml_rtc_alarm_time - ktime_get_real_seconds();
+	read_persistent_clock64(&ts);
+	secs = uml_rtc_alarm_time - ts.tv_sec;
 
 	if (time_travel_mode == TT_MODE_OFF) {
 		if (!enable) {
@@ -73,7 +75,8 @@ static int uml_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
 
 		if (enable)
 			time_travel_add_event_rel(&uml_rtc_alarm_event,
-						  secs * NSEC_PER_SEC);
+						  secs * NSEC_PER_SEC -
+						  ts.tv_nsec);
 	}
 
 	return 0;
-- 
2.47.1


