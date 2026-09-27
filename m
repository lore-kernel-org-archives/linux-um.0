Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05968C9830E
	for <linux-um@archiver.kernel.org>; Sun, 27 Sep 2026 23:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=o2sN14JO9HCt3Wj9/9g5JpbpB8lC5AOjB18kb3LjB2U=; b=XqLeLn44fo8IXvJb1rVZ+Dr0Ov
	5LqZ8dDx72ftcABhMuuHGuJqtwyBixD/HxzN4GfTklWgD4lX928DriEH9vQ18F0ZuNkQ1R1lVw+LU
	YTCEAvAH33r3mzp7byzk+nYvy7R7oqDvF2fiXLuwamYeegFxFIWHEGU7V7N2e7u2G5egHUVGMCzi1
	vH570IG1rDzr9/MtWVZSYdFeB+Whpjhy4e0Yg6aEE60bMXskFqQ8zP3+oO0MWa9ELBci86MbXV1Io
	5pfHUH7+xOLfVxkBBVfKxmXuZDqOKpwVo1or5ZZd/aLWhbAM3/fxynvAbAt7QTu5yDghwcbDcJs4s
	gXmOcImQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAyZ2-0000000H0Yu-0hzQ;
	Sun, 27 Sep 2026 23:45:48 +0000
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAyYy-0000000H0YH-06D3
	for linux-um@lists.infradead.org;
	Sun, 27 Sep 2026 23:45:46 +0000
Received: by mail-pz2-x0e.google.com with SMTP id 41be03b00d2f7-cc797656e5eso1041038a12.3
        for <linux-um@lists.infradead.org>; Sun, 27 Sep 2026 16:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790552743; x=1791157543; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o2sN14JO9HCt3Wj9/9g5JpbpB8lC5AOjB18kb3LjB2U=;
        b=Yn1s3wvS6NIyYuYEJo0Y2oFWjm77l43mBgIRgmPyAlTZw32D46y0kJ1PmsSgtE+FGr
         e+Rf9Gm/dc4U/SYSz3mNPQ6mfeREUCoIvBbt9fFZTHEvDSOYYKAFf2Jg9ScNaHv3cC/8
         h41FubdaGvgC/3F+bShS8fIMCBCa20gQOZJejnMesYT+2JiRCjO+0C4/RobYb/v+dKvr
         /vtPXfd/r6M8Yt6Yoc/eclnq/wtH71EKnkKH81uLltFcwSASMciy95MSJWhU5yhsPeBm
         nHdgttnqEQ2tDGyGu97cSp0XmtJeln112VxdM14I4KmoprNrWsxmlYfZxOy7AYbHQf0h
         RsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790552743; x=1791157543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o2sN14JO9HCt3Wj9/9g5JpbpB8lC5AOjB18kb3LjB2U=;
        b=pjpW6DOMD/fldtPqpr3kOVjIaAP0kHu3rHPfTcoIOEQ+mt8BL4Z3IiRpl2V8H4lWsO
         QExeHLIzoA5pubSd+RELPzyXw9sB0IkzKvx5Hpr37vQJfTwNeE+PvGGlp2ra5SJDt6KC
         KKxNNsla0dTlbj8Q3h1YiDh0xWN1XTOLRmqyw+dMP6dul3D2mxpq3p71eK5H85kyZORn
         Krs7imYvGGuFRhmg4EIx5mIOHBbkH+Se3xufRCU4IOdilp2CBlWvuNvWcJyxGfRQ2rgJ
         L8HfRYt+ZwNd8l4GCwqvFOU+avoD99d272S5dgjsn5JNI1RiSMWK2rGnp9j78SkOanoc
         OuFw==
X-Gm-Message-State: AFq9FYImX3lTthYlDdJGyXfhI3Lp+0UzfGfVHRFStnX+ogNIDsxn7LuD
	aK0eMkGB3gWrpFZhP/hpIz0aFMVP0vGjeY7u7P4ATOC81m7sZmf2NnIH
X-Gm-Gg: AYBFou3lMdRIKuy75FgqqUmDXBVpbOENtOJug5fRiTMKxIATh1D+n0i4J01SII0+C4O
	Ew0w/VaSvkbv1xmII4jqQR3MWML4pe5JJHqIYegMoQK13KmoUavcYu+xmL7fcAjxzyexGCBf8KC
	wgNuwy5/WH12uaou+M5YNNlIIT4idrrYShHeJO3Pe49/jkA7H9zUGdRGnfkjdmr1clj6uj/2A/n
	Z3aCnvUhnFS6PyH2nyeBH3V1mI8+yTZRrTR9Jb6BIfN2ldWfhuzz2oUWjEG/iO7fgbpt0fTQfNh
	GHaYsWdx0vRIgjVUBsXUuB63Cfwp9CTZmcKFeuHYIGEINNsheXYgXC4T7kmGYQ8wHdea7s/WP39
	myj4Z8betUgtlUhDuNFplSMhhq0/OS26mfmTw+GH/a7SmbJ+J3uBSLFF9kzdTqw3uukBJkqJ+W+
	Sk0fm5s2F+MUE2dDiY0bY2K55XkDFTqRjAk2GSmYK/jwYKufdAlVCPjY8bniw0SAKINcOufYZXJ
	50m2RPcbdaq1hetgAMEvRPH8V8gvBePu4H4VCXbBC70k6kqGxffL1HDtcQZKUmmUNgSiNT53N7l
	wJKUYB0cPegbruyzTQLwN3GyQmnDCFLuY9uH/Yl9BrEbGAuUPDJQwb2ncKLTKkO/VAGzONEV
X-Received: by 2002:a17:90b:5807:b0:3a0:5413:49b4 with SMTP id 98e67ed59e1d1-3a098dbaf11mr8945027a91.39.1790552742643;
        Sun, 27 Sep 2026 16:45:42 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b4983f43sm6539966a91.0.2026.09.27.16.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 16:45:42 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id D3FFD16D3336; Mon, 28 Sep 2026 08:45:40 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: kunit-dev@googlegroups.com,
	Hajime Tazaki <thehajime@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>,
	Rae Moar <raemoar63@gmail.com>
Subject: [PATCH] um: require MMU for UML PCI support
Date: Mon, 28 Sep 2026 08:45:37 +0900
Message-ID: <20260927234537.1585880-1-thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260927_164544_066012_954F66D1 
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

Because UML_PCI (arch/um/drivers/Kconfig) selects FORCE_PCI, this
contradicts the current dependency of CONFIG_PCI on CONFIG_MMU.  This
commit fixes this issue by adding right dependencies under !MMU
environment.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202609271139.DpjVdepU-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202609271351.tw8EOsgz-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202609270410.Kc2FsJp1-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202609270228.yku16Noi-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202609270416.rEtAiqyF-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202609270538.mV3NDkLu-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202609271435.lANS7mTP-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202609271512.pg5gWbIg-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202609271717.pg5HjzeZ-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202609271810.pxMMu5ZC-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202609271940.FhRl0cBi-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202609272107.sLZJEOtt-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202609272234.F8tROOdL-lkp@intel.com/
Fixes: 626ff2b34dbb ("um: allow deselecting CONFIG_MMU")
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <david@davidgow.net>
Cc: Rae Moar <raemoar63@gmail.com>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/drivers/Kconfig | 3 +++
 lib/kunit/Kconfig       | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index 6a0354ca032f..655e5a270c97 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -159,6 +159,7 @@ config UML_RTC
 
 config UML_PCI
 	bool
+	depends on MMU
 	select FORCE_PCI
 	select IRQ_MSI_LIB
 	select UML_IOMEM_EMULATION
@@ -169,6 +170,7 @@ config UML_PCI
 config UML_PCI_OVER_VIRTIO
 	bool "Enable PCI over VIRTIO device simulation"
 	# in theory, just VIRTIO is enough, but that causes recursion
+	depends on MMU
 	depends on VIRTIO_UML
 	select UML_PCI
 
@@ -183,6 +185,7 @@ config UML_PCI_OVER_VIRTIO_DEVICE_ID
 
 config UML_PCI_OVER_VFIO
 	bool "Enable VFIO-based PCI passthrough"
+	depends on MMU
 	select UML_PCI
 	help
 	  This driver provides support for VFIO-based PCI passthrough.
diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 94ff8e4089bf..cbda6189a308 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -133,7 +133,7 @@ config KUNIT_DEFAULT_TIMEOUT
 
 config KUNIT_UML_PCI
 	bool "KUnit UML PCI Support"
-	depends on UML
+	depends on UML && MMU
 	select UML_PCI
 	help
 	  Enables the PCI subsystem on UML for use by KUnit tests.
-- 
2.43.0


