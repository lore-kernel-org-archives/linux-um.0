Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4847CC4332F
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 10:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JdtsObb2VFiVINa11jTvFF/VfCut7YbPf+MmlLgLiAc=; b=k7n1iQWHIGeoLl
	kP3mtPSU+wgvibKrB6s5fkHGyo6owUcE9DI0roxzyqnUnzuRulrmlEfT//z/q1plypNJP6ala8OZt
	ZZEPtduDqw5AQyoPH0tkOnLX995o2m1LdA3sBjIbfujBEiO0VEcd13Dp13uFPFiS5mlQLovXuaDbX
	FJB84JEig+vFyky7iWN+V/vX9s9OEg3tXn6WG0xYFS70+S1pa9v1TwYbGP71yTMSsEf2ZFSXU/mUS
	caWA5uvRX2NZYE+7J/F2idM1TnSQ5lmEAqJyD6WGC5LARy958XCqN4YrhPkIb3Fu11/Nnp8qWyUZn
	037JHdK9PWyDl8qGHVFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQFU-007g98-SZ; Tue, 22 Nov 2022 10:11:28 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQF3-007feV-4C
	for linux-um@lists.infradead.org; Tue, 22 Nov 2022 10:11:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=5L1D6OT+aIBztZuiRFU8yv3CLkxmEuW5lEpp3nLtTtg=;
	t=1669111857; x=1670321457; b=NeKzY+PE0MbjydYKukdK1s2YwtDJJOp86dd0ri9dckkTnum
	M+ZUCoUWkGTSvZ88kL/TsN7EdU1FP3V4naPoeDpiyz35mIH4hTFsiI2qeABFxOrThDqHxDyPhS8fw
	rarESW97S4ZCDhp2bDJvTJHt7eepgNvViT3XUdT+drXAV36o2WTiWxvdEA5Cp5ZISI1wRdXyapL17
	Cw133aInAbmS5mHrAMXJnLNBnRcCh6IZyao6ObqjcoDIAjCgcou0OEK8XupL6F/CfYD5ZjvEBWpnG
	p1HvngnZkG5hgg1P+BAxa5WG4szd3/72rIxcofYZl7Ny2K9RtKRWT0pvNLCWyezg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1oxQEt-006IGn-0q;
	Tue, 22 Nov 2022 11:10:51 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v2 22/28] um: Add UML_SECCOMP configuration option
Date: Tue, 22 Nov 2022 11:07:53 +0100
Message-Id: <20221122100759.208290-23-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122100759.208290-1-benjamin@sipsolutions.net>
References: <20221122100759.208290-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_021101_273246_025D38DD 
X-CRM114-Status: UNSURE (   9.17  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Benjamin Berg <benjamin@sipsolutions.net>

Add the UML_SECCOMP configuration options. The next commits will add the
support itself in smaller chunks.

Only x86_64 will be supported for now.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/Kconfig | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 78de31ac1da7..e67c6402dd4b 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -234,6 +234,25 @@ config KASAN_SHADOW_OFFSET
 	  set to a large value. On low-memory systems, try 0x7fff8000, as it fits
 	  into the immediate of most instructions, improving performance.
 
+config UML_SECCOMP
+	bool "seccomp based process tracing"
+	default n
+	depends on 64BIT
+	help
+	  Enable this option will enable seccomp based tracing of processes.
+
+	  UML must call syscalls from within the userspace processes when
+	  mapping physical memory in response to page faults. Using seccomp
+	  based tracing permits delaying these host syscalls until userspace
+	  processes are resumed in order to run a task, thereby avoiding
+	  overhead for the host by saving context switches.
+
+	  This feature speeds up e.g. fork() heavy workloads considerably.
+	  However, the current implementation is not safe as userspace
+	  processes can trigger any syscall to the host OS.
+
+	  If in doubt say N, as the feature has security implications.
+
 endmenu
 
 source "arch/um/drivers/Kconfig"
-- 
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
