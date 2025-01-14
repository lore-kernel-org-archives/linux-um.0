Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CBDC02184
	for <linux-um@archiver.kernel.org>; Tue, 14 Jan 2025 11:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CuYeFaa6XJVhVFEeEDlLSKoQQuloVwYK3vseBrnmsAM=; b=mTaypYlM8mDPfH9Rs2rygJtGzO
	qEyvuNcS1j96hvawMiuLaxY7BI95TdytIARP8eELhhS1cwKFnFOV3MwVKms9FfSjtcCvJ/he5fJme
	ojUCqNR4p+J/bd8f+vWaBVadQVJcx3auKgrqh+qxtn5EgNSaUFcT+wfRM/i/UkYVCmEHoeur9nbgt
	ySp9vwdAbdym80OGI/jnrD3ZX7ldC+FsCLNV9VoV2GKyf977n5eLRGKbXOMPgeeUUFXNQv5Xc7o44
	XRaJfMue9iQFdERgLYmjJLUZH+YEcPfZKfLCPRtKavxgESQyT+Z9K/ozr6hoa3gs/KoDrNL6yEcpk
	7dBlU7+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXf9f-00000008GRD-37U7;
	Tue, 14 Jan 2025 11:32:19 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXf8n-00000008G9s-3Iyd
	for linux-um@lists.infradead.org;
	Tue, 14 Jan 2025 11:31:26 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-215770613dbso64129665ad.2
        for <linux-um@lists.infradead.org>; Tue, 14 Jan 2025 03:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736854285; x=1737459085; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuYeFaa6XJVhVFEeEDlLSKoQQuloVwYK3vseBrnmsAM=;
        b=abh2NAGIuKA1U/jOnkEumErumCgzCwloUtAiL491QMRs57mbdHwRMBM3PH5xm0tRCn
         OHGylabkHvxWhCpsCb0l1uhk0s+YVNOLxhuOmaYu4NezzMLA8pYjRDFTiQi92bGupFYt
         Tv0Xo5wJXWU/63HunohKQStOICB0eHQ6+VgS5hH78EOu4QLzO/ttBOdW4ZplueEjWsrc
         lAd9Rlp9bBMgZIUDZZrYf5jIZmP/IE3s0Uu3h2A+XiueO/rP2Qxj53fH2J3BBkb2gQSM
         k4SlDjdm2v+VCEg9bPBmp+YiOBkbX7VZ2fPiIboTHsk3RQyhA6uKdrkuVhe+h7z6MLVC
         p/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736854285; x=1737459085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuYeFaa6XJVhVFEeEDlLSKoQQuloVwYK3vseBrnmsAM=;
        b=i61hnch/NzMG0/8nopY0vNvAVRNbt4d/4BmTu+JkLJNeuhm0v3l8XfVkBzyeolJ/B7
         rqayIiqvFOUGpElpFW5aHBpBUWGCsrLjcCzjcqMbhCKzPoqlxilsEVx3b6gfrXGo0MHL
         npbPn12bh2/kPNCy2Y697swFhuFA4hdh/yPKex9/E+xkFXDZbWnxE32gbUYP6hmP0jAN
         asvs/3h+5q+O4rztvq20nwDQcDLToxMD/hnjYJkyaxD6UDkAlVazhLjRfxU402xY4csT
         DewUD6StCGow/+5RkJG7ftaHnM9s80cO6KJo45KVPgScc/Gwe6UHbxOTm+u7NoOxpbiS
         5HPA==
X-Gm-Message-State: AOJu0YwO4dS1PJs5XEY5N82/8SbRA3fEBKPPOw4nCrstfLNcLguXsmwI
	63ZBJ805l/iUBzTPEvmCo03cnBqpDbWl2a1nX9VuWX7Vj/2hB+Fh
X-Gm-Gg: ASbGncuWwiPCVriSvyI5946wtr1oudjd3uGgLAU1GhIQ0rEsoZGboKWbP0RZ9zGYqbO
	v91F4Xv8fUM10qr5dLtXFdyoOJ+1GzOZ86lhvlO4PjsR4rrWuCTbzC6Atkd2dBj8ehmEsVHImIO
	zmfLag56mmeDnB9PrawJj6v3wwu0u26ysoZ3z1U3DrBSwMe0tzJ/4BIsW1KErK8yJ8TN6uJo2Q/
	V5WxG6iMf3wFXowpGwNLGOnewE5D7duVYJBh4P+x/3VPQ2EFEQIPOuGnXvGJq9LYeOOlCUArvS7
	phMbaiAR0YkNfqWyVBOXpzCo4t/h
X-Google-Smtp-Source: AGHT+IFUqT2sC7LYoKwjmO3fG1nRgwamloNBakOpeHpfkU8/b390rfDoQE26N7j7rMk8WHHDMk1WxA==
X-Received: by 2002:a17:902:cec3:b0:216:7ee9:220b with SMTP id d9443c01a7336-21a83f4f43amr442673625ad.22.1736854285225;
        Tue, 14 Jan 2025 03:31:25 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f232680sm65378145ad.182.2025.01.14.03.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 03:31:24 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id DD926E1AB66; Tue, 14 Jan 2025 20:31:22 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v6 13/13] um: nommu: plug nommu code into build system
Date: Tue, 14 Jan 2025 20:30:51 +0900
Message-ID: <965a45cb1dfec8f9ddebec098947e4561fa94e69.1736853926.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736853925.git.thehajime@gmail.com>
References: <cover.1736853925.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_033125_829381_B1557B47 
X-CRM114-Status: GOOD (  12.69  )
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
 arch/um/Kconfig                        | 14 +++++-
 arch/um/configs/x86_64_nommu_defconfig | 64 ++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 2 deletions(-)
 create mode 100644 arch/um/configs/x86_64_nommu_defconfig

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 18051b1cfce0..2fc5a91c90a7 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -30,14 +30,17 @@ config UML
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
@@ -190,8 +193,15 @@ config MAGIC_SYSRQ
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
index 000000000000..c2e0fb546987
--- /dev/null
+++ b/arch/um/configs/x86_64_nommu_defconfig
@@ -0,0 +1,64 @@
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
+CONFIG_UML_SOUND=m
+CONFIG_UML_NET=y
+CONFIG_UML_NET_ETHERTAP=y
+CONFIG_UML_NET_TUNTAP=y
+CONFIG_UML_NET_SLIP=y
+CONFIG_UML_NET_DAEMON=y
+CONFIG_UML_NET_MCAST=y
+CONFIG_UML_NET_SLIRP=y
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
+CONFIG_SOUND=m
+CONFIG_EXT4_FS=y
+CONFIG_REISERFS_FS=y
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


