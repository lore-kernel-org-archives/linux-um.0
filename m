Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD71E7718B
	for <linux-um@archiver.kernel.org>; Thu, 12 Dec 2024 10:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CuYeFaa6XJVhVFEeEDlLSKoQQuloVwYK3vseBrnmsAM=; b=XbzvzT8RXEtGrN7Iuv8z2D32KD
	hvAWXwHpXkn2q5RqeIbUTQRKmc7LwLD4m+sWHxhzK3HNAWjTcdUoXdOZVRfdalihaXJ9qaOVsbgS6
	eAifz7XwV+vPt9AcuxkSd5lsGfD22ekaebfhGoGc/PAJU6/IafGcxwRmfMTTWNGsz9tMB80RBpttH
	XfuXpBnK00ciD7iv3mBdydZ9FPZ3VcGHQqmhfAF+eK0pRNiLYQzD9mfwUAgfdemWrIQMU/7EJEjQP
	BGgG0CigZoAXS2KsU0WVWPicYJOevHqokt7CWGalRBoif656KGit9L/p1hwSqEsnkq1dRNO1rM7LA
	w2wG7Y2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLgDh-000000001Wj-39b2;
	Thu, 12 Dec 2024 10:14:57 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLgDX-000000001O4-0utJ
	for linux-um@lists.infradead.org;
	Thu, 12 Dec 2024 10:14:48 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2161eb95317so3616075ad.1
        for <linux-um@lists.infradead.org>; Thu, 12 Dec 2024 02:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733998486; x=1734603286; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuYeFaa6XJVhVFEeEDlLSKoQQuloVwYK3vseBrnmsAM=;
        b=gEDrrrT/JN0+72dtJMKjK6q5y3PYQ0ma7H6vLpQNjq5z1JDz2KIpSGEwSTvZ1qQkwz
         IjGwAfqkfihMExzdHeK4dGGdjD9dL0xFcaOcJSzZQic0HRtJ24pML4T5GRSoGqWakpGT
         kd2KI9yMIuwmCompOkHST0Tapr0UbPK2c1/A2HoE++cvlL09GEoaraXI0n+3VIfQVPe/
         wSYLbvMuKMOVn48oUzQJjM9vel9WBgf+ig/UppZoF09nutzQYcargNm2UmigqxrDZb4P
         h1mRDb3dsq+B1iyeRaqZBObtfTuj4lQXKORLnWfIUI9MfI/LLrFvOdIlIrq/7rCYkN0o
         WVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733998486; x=1734603286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuYeFaa6XJVhVFEeEDlLSKoQQuloVwYK3vseBrnmsAM=;
        b=OnfrO12DikvAx7wiE65iAyn36F+EKosPiMw9g7GUcZl8tIFI8GhidpXaIIWMShy7/M
         EHLgcKNCWJUuYU8RAEvuF2uqgFOPsV4mSMoq5Iecxz6NEYw58TGcyKAgA02fuL/Mb4jP
         DFCob/+rIOhPDzo0rm8EMQKw3MEdtJAnyznsem3jL+LW7B8KpeLY7AzHQEf/z3Dl+a5M
         +gzVw1xMgLOrOB3dy2njNfnaB5Ph0CwQAVYY3lpauquRqmUo2kv5uRstzCCv+Pbh3ffA
         mj0WhFNMF1YXIpMrgd16KsRdhoSHMrv/S22DGkvjHaWwkb2Dd+9FrmEg3NM71FZ6YWQN
         /xlw==
X-Gm-Message-State: AOJu0Yz22z16Nw7ZEOcQk1USNLIszdCZRv7QxxtQlR5FPQaKEOd7v7U6
	Vxl4/3QYJVHJ1cPl6Hlhne60sY8NPiacXi5oZnUI3EsStZlF3xZg
X-Gm-Gg: ASbGncs/cPLzvAtTew+RA4fSQ6HxehBfJoY1bmjQu8expipIdgCF4LjByCc1YTtS3qK
	QpNzttsw/SWeFFH5LFJ3/dbB6FLSyNNKP/xnK/pUj1eTEii2ciu2MpqIWg7WC2q4DXASmKigaEQ
	sRz5yQolQMWuH6hoPoMi4blTaZWXgCFohJDBC/HGkP7wWUR2wCDKn4lgkBKDxvkFSb0bZdDtq93
	OxgC3bFfpBFNEe6lSMhrk/gt1oJmVwxkZElump4Lbj5DlAIHdOH49W5ST/08l0JmQ+8Wc3ezCYo
	JN4Bsor0YG5Zv+598lr7L9RyYb4=
X-Google-Smtp-Source: AGHT+IF/ML9ckPXgbOs7RCoTMAlOO46mn9/xhxqi4tspsk6UiFdJFzW3QerEuDchv3CTHNUfnFwa7A==
X-Received: by 2002:a17:902:ec90:b0:215:b087:5d62 with SMTP id d9443c01a7336-21778549d38mr112880955ad.36.1733998486222;
        Thu, 12 Dec 2024 02:14:46 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2163725faf4sm78782065ad.196.2024.12.12.02.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 02:14:45 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 0F279DDEED6; Thu, 12 Dec 2024 19:14:44 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v5 13/13] um: nommu: plug nommu code into build system
Date: Thu, 12 Dec 2024 19:12:20 +0900
Message-ID: <799b2025b7b4fcdb45b156fc87190c6478607cd8.1733998168.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733998168.git.thehajime@gmail.com>
References: <cover.1733998168.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_021447_254868_F9995804 
X-CRM114-Status: GOOD (  12.35  )
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


