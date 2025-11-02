Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7DACCFA06
	for <linux-um@archiver.kernel.org>; Sun,  2 Nov 2025 09:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YfBGkCpdCJbbx8ptfVRSSTZ4TOwzXcv5IKpsCTLcAdg=; b=4+no2awxkHUm29TxuE58X+DmfI
	gEbdL2NOlaj28ET8p4n++PTayIPWorjedjA3S1xDfT3BIC1L3lEFCTR/8qazlhJsol5zX8cA5BEo6
	LsvUw219LSp4pWVhMXuXZQiwBIdJ5VLKsACl5NXE04qBBvc1ZDFmuWbdIPLn649bREauFRNY+67IL
	egVg23tKJ63Ut4cR0yPj86Z9sdgFEZ8/NBAVUbJLo4VWJN51UDt9nWSZD+jVr+lUNHmqgr8GffKV8
	L3ZHZcy204jJZd4ZQsiiZwb+3bH2mI3PczbIHCqJv2oUBtkSqf0CTOM5HsqkLuFFcoz0Xy/JJTJB6
	5APV+Bzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFUit-00000008Rzq-0anc;
	Sun, 02 Nov 2025 09:50:07 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFUiq-00000008Rwp-44Co
	for linux-um@lists.infradead.org;
	Sun, 02 Nov 2025 09:50:06 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso457654b3a.3
        for <linux-um@lists.infradead.org>; Sun, 02 Nov 2025 01:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762077004; x=1762681804; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfBGkCpdCJbbx8ptfVRSSTZ4TOwzXcv5IKpsCTLcAdg=;
        b=Q3JVE9SkerjbtUChcmDfaphk3qpjbJfQxd6kc7mrWROg1yogEk7AUauGROip0EpzjC
         A8rjNbQSlR3Cd1Nx+ANJ0x65ProwgT7UArtRW6P6TXxJ5Q8b0Vu/kxmpvRIC63u1N+9A
         EZyH+hzdBMFPIQ90Ex0Eytk4kjZ7+xVS4O9WstlwAxh3/iyx6bjT+/N6jqRDzKUX5lyo
         gBUE62kMdr2xYZRHKiv4vJSEuIfQNX2qtK4QUiTHGXK5MmbTYGJ64O0HjR/pYIgxvybA
         usywdsNdrcP+jSDixopx7MiMIVBQpRSG+iRaEzV7tGKyv4XKVF9M98uieyTQr4eAIftU
         DT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762077004; x=1762681804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfBGkCpdCJbbx8ptfVRSSTZ4TOwzXcv5IKpsCTLcAdg=;
        b=Fkk/FqGz3T7yvtadXX1xqPJdFDW0lBtK9t1Jzt9HEOy7qx2X8ZVGOAj8ZAU7K+YLUv
         IK59D0hR/ueM8mx+VV4wGecFimXf1wvMW/0Hg/rEe8b8MtEeZ8HRpz1GAgjWCFC3K9ZF
         T3wQkJox493TU82BuKyWRhaZOETeBwS7YBOyV5/6vWsoZ+EOrdNqqYd9d7Su8olmq8l1
         HxuUFAwIkcEQeprtaaT5R9/+z8/l+Bsn5Tw3yA+3/QDjpia82CG7H/DrIwwXu/CE6A8B
         zBejuKP/w7zrg541J+FX/Sr85oq3mq6+zFuoEcmfd79iY+o1xDcpNm+LvgFze21IMtRA
         9UXQ==
X-Gm-Message-State: AOJu0YzqPZKYMzzXC5UV51cHRuZsVBLixnGbjEKseY6eDFMiNsHIYY9l
	gomIjOU77aIjjZ51CPJrFEfQM/nddXds0O/4omZkexFe96T1yCcQOPgK
X-Gm-Gg: ASbGncv1NnsMl2KN6Wfviu4OnpDLpQxok1g4WxPy1/P5EGt0XD+ZpDcVpdmRFbsmqHR
	W7Hu68foTFuK1YCtwS7jCbjK6ZVHFFiGD88fwqQ+hQN5tAMQeVZ7qhMqiMO/a3iVK6o4CUEKbrU
	bMjVVR1QJVNUrTCvh7vLSRtidOv7cTSzSKUzafxVCjSP9WwevGdFyC0f/H+drtMpgaVqT8FhGDP
	wA0vNkbF8xf5lfaDFsc7ZdK709YQ6KDRYO9tgAXMvigKFxzc6p2dl1H6gDv0nK+sS30WPC+/2W4
	MGc0Tl/SCesc4SnVnrhQxaj+p59+A18mVEDCHwIyRBzGKbMbFjJY1l73YTIIT3ECeQSuXz0Qd22
	fi/iNsBOKugNs9IROKPl0qZr2DGl8fTrqp2+J/cRDkv1YK7uE3IBm3Vps/Q7mZszXRB8iyV+wCP
	yPjupJH4AgJTIn0dNiL3t4EYt38tY2K/SEt2tdQ/FY/4SE05RUO46HlVef
X-Google-Smtp-Source: AGHT+IEDhV7V1q+X2A4WeUCbo0ZHZo62KKRfx9fdau0q/StwiLJYD/4G+s6ryRCgEgHJrpTQR06FxQ==
X-Received: by 2002:a05:6a00:2d1d:b0:7aa:8397:7754 with SMTP id d2e1a72fcca58-7aa83978122mr1186234b3a.2.1762077004150;
        Sun, 02 Nov 2025 01:50:04 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7aa76782f1esm1243225b3a.67.2025.11.02.01.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 01:50:00 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id E59851123813; Sun,  2 Nov 2025 18:49:57 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 11/13] um: nommu: disable SMP on nommu UML
Date: Sun,  2 Nov 2025 18:49:36 +0900
Message-ID: <54839396f81bc2755728a53912bd8fcb19b889a1.1762075876.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762075876.git.thehajime@gmail.com>
References: <cover.1762075876.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251102_015005_006115_998EB500 
X-CRM114-Status: GOOD (  11.04  )
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

CONFIG_SMP doesn't work with nommu UML since fs register handling of
host does conflict with thread local storage (more specifically,
the variable signals_enabled).

Thus this commit disables the CONFIG option and the TLS variables.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/os-Linux/internal.h | 8 ++++++++
 arch/x86/um/Kconfig         | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/um/os-Linux/internal.h b/arch/um/os-Linux/internal.h
index bac9fcc8c14c..25cb5cc931c1 100644
--- a/arch/um/os-Linux/internal.h
+++ b/arch/um/os-Linux/internal.h
@@ -6,6 +6,14 @@
 #include <stub-data.h>
 #include <signal.h>
 
+/* NOMMU doesn't work with thread-local storage used in CONFIG_SMP,
+ * due to the dependency on host_fs variable switch upon user/kernel
+ * context so, disable TLS until NOMMU supports SMP.
+ */
+#ifndef CONFIG_MMU
+#define __thread
+#endif
+
 /*
  * elf_aux.c
  */
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index c52fb5cb8d21..2bc18ecad783 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -13,7 +13,7 @@ config UML_X86
 	select ARCH_USE_QUEUED_SPINLOCKS
 	select DCACHE_WORD_ACCESS
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
-	select UML_SUBARCH_SUPPORTS_SMP if X86_CX8
+	select UML_SUBARCH_SUPPORTS_SMP if X86_CX8 && MMU
 
 config 64BIT
 	bool "64-bit kernel" if "$(SUBARCH)" = "x86"
-- 
2.43.0


