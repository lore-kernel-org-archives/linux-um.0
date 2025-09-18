Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8D1CAC5A7
	for <linux-um@archiver.kernel.org>; Thu, 18 Sep 2025 05:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=weQA9Kmk5Cj0pX9CPL2mzbHMoGKA1UTMBAigZCiGmmg=; b=FCRHl1q/txCbYjrY++5nCGR+fE
	IS0OlOHKC3tQL7MIJANHqruHV82Unq3xerPiYGhgBonzQw7zfbDsfqMq7YmeRfrLEFs/u6v3D74sm
	qSdSL8Fsi3vU3DoXAkQyJ/EApDw5e6QyW34ft1FqS/B/TgD7yJtb2Ca+ObHpPz4iWHH7xUX+V0Hxj
	bmuwDr41HxO4n7s0iahWRaoBJWOuhkI90G8u45elVunBpLhormryKKyBVKXm7PZvpfCI1zM43S9xA
	5kn3lGv/V9G572VDvKNk8cuPEoeOC9zlHu7tui3JsQyazluYRbB9nUlLtdOWRZtRTgF9pNqoKz7Nc
	k+y2cITA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz70u-0000000GITQ-4Bus;
	Thu, 18 Sep 2025 05:17:01 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz70s-0000000GIRL-29m9
	for linux-um@lists.infradead.org;
	Thu, 18 Sep 2025 05:17:00 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso572171b3a.1
        for <linux-um@lists.infradead.org>; Wed, 17 Sep 2025 22:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758172618; x=1758777418; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weQA9Kmk5Cj0pX9CPL2mzbHMoGKA1UTMBAigZCiGmmg=;
        b=ImUU2TPmBtGfI+UGvHkXfSQVeE4sPUicR5E69vwNzfcsPNbz+WLc/Hm9v9zILs16dQ
         koBEqFTdeH+S02E56kj0Dsnb/cnCdW01+rjfQ3b0Xwc/YK8Q9VmTuZay7on6EmtnuLWm
         HF68ulj5OUzUI/xc2UhzPHMZ+D/k0AoSi/CAya8hZUMawa6fttkCnlFAgeGB0J7q6gAF
         ZSlS+wj2U6J9fNMwwnrbA5P3HCEq/X9hl1KzhEj0FhLa6xGn9eifAAj5ntrw1oLjTZtB
         /YN3TNq1eyoKb/rh2JEiAPqqLq241PS2wQdVC2hlgdEb8v8xZVeCDIQPsGxxmQJcCTFI
         sS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172618; x=1758777418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=weQA9Kmk5Cj0pX9CPL2mzbHMoGKA1UTMBAigZCiGmmg=;
        b=fMSRh28POUw+7vbqKf9EkbiJg5iD/yszS77q5MHy/YW3f3vzaA1dWsIqWUEw8SX+hr
         tJWrZFtomL1+kx0p6jdk6zJdq9EZSc4BIZOrPAcaYLestrqPgcbx9/7gFTfzLC8zgeHQ
         cJlTSD118DE/VR04ol8lue4Ca7JI4EoZVUpL6KmpSymw3iXcc8OoEI4BYPRzmgD6EwkD
         t4bHT0BObPuia3JWwMM+4ew33h3vQMEtq9QYhJJKYkgmCvacqkaJ6XusVTUc5slG4Q2K
         0xT2g20tVuUydYmwAA8sYEArmKeyJ3bmsb2wpuyOvQMW0VXbMDKbpu1d1RDTWM5TgHa/
         Quyw==
X-Gm-Message-State: AOJu0YzPQi+9KccOpWLY50qmV8DSW2d8OkhmKQ6mmRhihM/B1xKgSA4j
	TPO+xe7kCDco3kUD0bEJDB/bIUzUMOLdEs0UepHoJWUo1xkurLjim/6cTdJINg==
X-Gm-Gg: ASbGncvwKcqx6ydVE+XivQT18QEH3jsAv1tsVu7LPIJdlYFL/H5IEExvGD69upyR83E
	UFLQ7+UzShoI4zUHAP1hreVMrlG7KgsAojkUZlR3OAvwFCd1a+N0lwLyxn9LkWzGxje+DrrtTR6
	N29U1V+VDeGp9mDm+dusTQmurrNcxjvvvM733UI8xxNcobQVYRmi7SaOLqVOPypmvx1ll9u+m5h
	QvnxXSaCLqauQzCT8XNiloK1H77KNmOh+5co+fqwIB8VWMpdur6KSouv+tALwmE8OU5U8qyB5lY
	34hIrA+0bUJDdBgaFpXeYpOoKiW5IrxZ7nes+cTfUvIS+xKkqXBoXyIC0NKXc3hrTz9+EgVZA7z
	0aMj1WaVc1rlnAEYUoy+R0fK0PNI7STQ6mHpGU19J769tEP8wpBE+F2ZZzYbqaI7yRq/BJE4eMY
	hHTEIvMzpur/E=
X-Google-Smtp-Source: AGHT+IGZQwtJMyRnh3Z8k0XoyJf1CY4mOdwaCuE/LPYRa5FoHXNH/TLQrn91zATBe14rAtpangIWQA==
X-Received: by 2002:a05:6a20:9150:b0:252:76ab:8beb with SMTP id adf61e73a8af0-27aa99bd366mr6383648637.41.1758172617633;
        Wed, 17 Sep 2025 22:16:57 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff35afa1sm1149269a12.7.2025.09.17.22.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:16:56 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 2AC351061EFD; Thu, 18 Sep 2025 14:16:55 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 14/14] um: nommu: plug nommu code into build system
Date: Thu, 18 Sep 2025 14:16:07 +0900
Message-ID: <8a9d6dde30441e5605b864d99977e6cf5842205c.1758171893.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758171893.git.thehajime@gmail.com>
References: <cover.1758171893.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250917_221658_609451_EAE87391 
X-CRM114-Status: GOOD (  13.23  )
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
index 8161cc5ae6f7..b3d2716836ac 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -32,16 +32,19 @@ config UML
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select TRACE_IRQFLAGS_SUPPORT
 	select TTY # Needed for line.c
-	select HAVE_ARCH_VMAP_STACK
+	select HAVE_ARCH_VMAP_STACK if MMU
 	select HAVE_RUST
 	select ARCH_HAS_UBSAN
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_SYSCALL_TRACEPOINTS
 	select THREAD_INFO_IN_TASK
 	select SPARSE_IRQ
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


