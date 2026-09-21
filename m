Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CD3C982ED
	for <linux-um@archiver.kernel.org>; Mon, 21 Sep 2026 23:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tQDZ6AIonlJapi64jOgwfZ2ZiR0Ik2/cRl4FexYf1PY=; b=pv3OIal9uRSdLs3r7l/kJ3zrMS
	Om/76MNZLQVBX/RzUNjMqFZhiPZ/ZGIVpzJVHDA1eYPoy5CoD/j/dZv2bD54InYrnX8RCh8+F0IFt
	yn8eF8wIvOlZMwLxfX6JuokqjwoEqxwAFI0TOPpqzZUCWI8KAHix03j1PzVC8X9mEZ1ZlhoFIZJ4i
	vDCZidvzDqmmCTXdWJkrpJPw3o8E9/fpaOKy3IdP8MciEZz6KL85evKl973bWt1P8TR0cihpk+yz3
	5d2zpwup2tF2sdPyReGcvcIzeJKVags9ZMv0oi7IierYcs+f/CUXrruV/oHEYX+bfIuwiwjNXfJo7
	2ecY6wEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8n7E-00000003ddr-30pV;
	Mon, 21 Sep 2026 23:08:04 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8n7D-00000003ddd-0cF3
	for linux-um@bombadil.infradead.org;
	Mon, 21 Sep 2026 23:08:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=tQDZ6AIonlJapi64jOgwfZ2ZiR0Ik2/cRl4FexYf1PY=; b=HNo/yQTQi+mf2WMP4oAgpMz+qw
	AIobE5/3kpC7y2oK1eSnelBSfcMVthUJhF54Tyv4G+9cEhKJ8F/365+EXR8vEDookn0xbj+jEk6ID
	iARPZgS32mxBAOXNnzX49edh+6GzlWRj2nbcuv+Y1Hr83EHFfSjiflZWJyiIEVPxak0ega4aNnYLV
	iq4gXOHfP4ARE4fMuh0qY20eI1CAJAx6AKAc537OeTs63niD2kWE7hOLpdOH1z/lsRTp21Tat0gaa
	FYWOtYcQ28M3XtPyMk8atgVTNFBmrKqTFShWYvvUpb/QlPUZpBQai+PVaWqr9N8PX1cr+18UPocGB
	Ol8hKPQw==;
Received: from [2a01:4f8:242:246e::2] (helo=sipsolutions.net)
	by casper.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8n79-00000005uHx-3dXg
	for linux-um@lists.infradead.org;
	Mon, 21 Sep 2026 23:08:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=tQDZ6AIonlJapi64jOgwfZ2ZiR0Ik2/cRl4FexYf1PY=; t=1790032078; x=1791241678; 
	b=MOBc4VjPIMcFFh9/8a4plyDCktFxL0wfB7QXQQ+ftOL+yuC0t70SNcAv2YfVpYaUHzJn1kDtyCM
	FYbZLRTT5R09aWGEUcBo83gXD/0zguJouoYIs/9No/6yNo5Pbd3l5K4xb0DwTsv2uIWX2ht/zQfcr
	ljmQWuMsCTqIxNuUtKDerIG2M3wuiuxj6J+t1A0wt+i1W04yIovCgB6B3Npql4Iz8ettkwq8kB0wy
	h8LsfPbwAgyaG7BgKQLNr71UJlgo/xtQmYt4Rxsc9nLn5H7u3qBYrwiaUV3NX8p6zfik07VjIygqP
	EE3uLrvGGCWT/m4zy2XfFb4GX4SjbI+HU+WQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x8n6s-000000068zG-2xxC;
	Tue, 22 Sep 2026 01:07:42 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] um: add perf-event support
Date: Tue, 22 Sep 2026 01:07:40 +0200
Message-ID: <20260921230739.587996-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_000800_023602_01F597E9 
X-CRM114-Status: GOOD (  11.14  )
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

Enable HAVE_PERF_EVENTS without any hardware events (since
there's no hardware), that just needs to select the symbol
and provide an empty asm/perf_event.h.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/Kconfig                  | 1 +
 arch/um/include/asm/perf_event.h | 7 +++++++
 2 files changed, 8 insertions(+)
 create mode 100644 arch/um/include/asm/perf_event.h

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index d9541d13d9eb..8fec92f56a82 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -27,6 +27,7 @@ config UML
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_PAGE_SIZE_4KB
+	select HAVE_PERF_EVENTS
 	select NO_DMA if !UML_DMA_EMULATION
 	select OF_EARLY_FLATTREE if OF
 	select GENERIC_IRQ_SHOW
diff --git a/arch/um/include/asm/perf_event.h b/arch/um/include/asm/perf_event.h
new file mode 100644
index 000000000000..9f774e2db198
--- /dev/null
+++ b/arch/um/include/asm/perf_event.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_PERF_EVENT_H
+#define __UM_PERF_EVENT_H
+
+/* nothing here - clearly no real hardware support */
+
+#endif /* __UM_PERF_EVENT_H */
-- 
2.55.0


