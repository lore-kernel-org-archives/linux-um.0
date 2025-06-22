Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDF5C8300F
	for <linux-um@archiver.kernel.org>; Sun, 22 Jun 2025 21:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4CZO2OAKV3OtJLgmf9ZQYFE78DDsp7kzC/L9szpctPA=; b=v4+nKH2wBlkI0ivtiUwzSPFtJS
	ch9fmG6d9fiNhFVVwIMX5E6ZCsOHJ8ncMnnpa+PoULD5eIVBo+ErIzKv5Om1ocjMTlnC9YNon/X5W
	1mrgtq4Obl+xfsnqgr9G4VoBYt9KGrtcEd6LkmkhstLtJuTXsJPA7VNW5yRaHKkPMucc2F5XcU6s6
	TBvEhCkEpsW/QgN/utFsFZsUYq3wPZEcQhaL7jJwK0/cEYi3sSAk9cL8CKh0S2jKeC307ceI2nP4q
	NJN6vxT8Y8kO8UGfssV+zPqSFtujpLH4Xw6HYeOTu6gdm1TTetuQnmv0kO0tA0JMYEVF1peikPnoA
	vDsDRlfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTSKL-00000001FAy-1XpL;
	Sun, 22 Jun 2025 21:34:13 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTSJv-00000001EzB-2VtR
	for linux-um@lists.infradead.org;
	Sun, 22 Jun 2025 21:33:48 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2350fc2591dso29262635ad.1
        for <linux-um@lists.infradead.org>; Sun, 22 Jun 2025 14:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750628027; x=1751232827; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CZO2OAKV3OtJLgmf9ZQYFE78DDsp7kzC/L9szpctPA=;
        b=CG+GSQ/MwTfrY5+4cXYP/hKVZnbNpqZkuKcXw/bg9v7MbOibeE/t1eTZb0aju117Cs
         76PeQqVJcj9iVMJXCaBKFIdZUMReyY6hs8YkUBUJkks3SMTE1VFxbLb/7Jnw9rL5z41f
         uM5dYKa43z8Ep0cT5KnSc3GfvVVSCHE5ZmZqsg1T7FV2y5AnlGqaWac5WfKvE/bDbacL
         Dy0nHsZemwIPXmMddVg2ctGYK+pE5ijZiGxa6mpSOYs+s74CXNaR/z0vecuRpuVJjW+p
         4ww1106NOD7+Gk0GDp2svGT3NDrIappxmj4yxltba4QHuWq/geH6OJCFqdv9Tcc9oXib
         j1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750628027; x=1751232827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CZO2OAKV3OtJLgmf9ZQYFE78DDsp7kzC/L9szpctPA=;
        b=aCkUubM2TXm71MGEdkg1e28z00ZNsORjcDOt5eo8Uca7HWJE5ARoOLSQeRlk49RJen
         CePpKNTKanZbBFTDiWd4dkPk+3YJ/KIQO0EbbL92mF+UzChzAkur/WNJbJtO6onXN2Bd
         k4lDi7FHilk+TajvsGEW0RvfXVyoJnsdTOK/BRGhudALRDbN+ydi892qPnHAXsq1wo0V
         wqNznru/cplkFbVQabQQgG+8MGGjhNCebHnBaPBuob0XUX0oxEq5Kvc2St4L3WnnDhVT
         qVDOTHi/wvrW0739K/zu2DKJyeYuMQ4diaHVnmC3sTYXlyI2qfitVYa/KIDrRDz094U7
         rrrg==
X-Gm-Message-State: AOJu0YwI3iMSYjK/VUfhtZzDO0aA4pTBoe8N3SUyMZlWlWq0lzXuQFWB
	ahscZQQA1z8Z15yPrdrmlvoYCFIJwD7mo9qRVp5B+tkFL5O7K1iUCQNm
X-Gm-Gg: ASbGncsu1wqobKjZ1pV0XmVP+tLDTCuRKfODu/dVJ3atRRvHhT0d7J6c59x1FclUYDE
	fgK7p6G4aZdwqeE1viSOiz45EMr7ld2u03Ze3oX1MYdaIq6w/vGup+kobRYdFoIyhQkYtKBIw3k
	As8W9HtMRF20CxbcC0Oeuj7sgktY6sp1uYo1KoMfJPCKJN0n+GEEVag80IQfhqGBMEY5FkoF/EP
	K0fL5fl8e0yW1QL8XZja9oe9/P7whTGf0un7UXQ1dE/DofquojoxthovO++UNCTutFys5Ydm437
	sdm8jZ5TII1ffHmH4Ue4M/GQ5il7I+UKKdn8FUsWY5Wd48LQenF8p1ORNfrA5QHpva5F6VaYMDW
	GnGJSggNEA8YblTn6wwwjiahsTskxz7iN
X-Google-Smtp-Source: AGHT+IHxp56Xls+moSgffTIGwer9X/frbYltlT1Wotdht1GfPvk8Ri0YMlmgTa9DA+cKj0epHgkh4Q==
X-Received: by 2002:a17:902:f64a:b0:236:8b70:191b with SMTP id d9443c01a7336-237dad62920mr129643705ad.0.1750628026800;
        Sun, 22 Jun 2025 14:33:46 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83d1390sm66931345ad.68.2025.06.22.14.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 14:33:46 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id E3DE1EF1EBE; Mon, 23 Jun 2025 06:33:44 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 13/13] um: nommu: plug nommu code into build system
Date: Mon, 23 Jun 2025 06:33:11 +0900
Message-ID: <2b8eb79a28dd4cca358236347847679c7a968f04.1750594487.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750594487.git.thehajime@gmail.com>
References: <cover.1750594487.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250622_143347_637018_D38C55C1 
X-CRM114-Status: GOOD (  12.46  )
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

Add nommu kernel for um build.  defconfig is also provided.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/um/Kconfig                        | 14 ++++++-
 arch/um/configs/x86_64_nommu_defconfig | 54 ++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 2 deletions(-)
 create mode 100644 arch/um/configs/x86_64_nommu_defconfig

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index f08e8a7fac93..81a79c7a5a6f 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -31,14 +31,17 @@ config UML
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select TRACE_IRQFLAGS_SUPPORT
 	select TTY # Needed for line.c
-	select HAVE_ARCH_VMAP_STACK
+	select HAVE_ARCH_VMAP_STACK if MMU
 	select HAVE_RUST
 	select ARCH_HAS_UBSAN
 	select HAVE_ARCH_TRACEHOOK
 	select THREAD_INFO_IN_TASK
+	select UACCESS_MEMCPY if !MMU
+	select GENERIC_STRNLEN_USER if !MMU
+	select GENERIC_STRNCPY_FROM_USER if !MMU
 
 config MMU
-	bool
+	bool "MMU-based Paged Memory Management Support" if 64BIT
 	default y
 
 config UML_DMA_EMULATION
@@ -185,8 +188,15 @@ config MAGIC_SYSRQ
 	  The keys are documented in <file:Documentation/admin-guide/sysrq.rst>. Don't say Y
 	  unless you really know what this hack does.
 
+config ARCH_FORCE_MAX_ORDER
+	int "Order of maximal physically contiguous allocations" if EXPERT
+	default "10" if MMU
+	default "16" if !MMU
+
 config KERNEL_STACK_ORDER
 	int "Kernel stack size order"
+	default 3 if !MMU
+	range 3 10 if !MMU
 	default 2 if 64BIT
 	range 2 10 if 64BIT
 	default 1 if !64BIT
diff --git a/arch/um/configs/x86_64_nommu_defconfig b/arch/um/configs/x86_64_nommu_defconfig
new file mode 100644
index 000000000000..02cb87091c9f
--- /dev/null
+++ b/arch/um/configs/x86_64_nommu_defconfig
@@ -0,0 +1,54 @@
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_CGROUPS=y
+CONFIG_BLK_CGROUP=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CGROUP_CPUACCT=y
+# CONFIG_PID_NS is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+# CONFIG_MMU is not set
+CONFIG_HOSTFS=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_SSL=y
+CONFIG_NULL_CHAN=y
+CONFIG_PORT_CHAN=y
+CONFIG_PTY_CHAN=y
+CONFIG_TTY_CHAN=y
+CONFIG_CON_CHAN="pts"
+CONFIG_SSL_CHAN="pts"
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_IOSCHED_BFQ=m
+CONFIG_BINFMT_MISC=m
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_BLK_DEV_UBD=y
+CONFIG_BLK_DEV_LOOP=m
+CONFIG_BLK_DEV_NBD=m
+CONFIG_DUMMY=m
+CONFIG_TUN=m
+CONFIG_PPP=m
+CONFIG_SLIP=m
+CONFIG_LEGACY_PTY_COUNT=32
+CONFIG_UML_RANDOM=y
+CONFIG_EXT4_FS=y
+CONFIG_QUOTA=y
+CONFIG_AUTOFS_FS=m
+CONFIG_ISO9660_FS=m
+CONFIG_JOLIET=y
+CONFIG_NLS=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_FRAME_WARN=1024
+CONFIG_IPV6=y
-- 
2.43.0


