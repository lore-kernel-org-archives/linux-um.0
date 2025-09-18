Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E08CAC59A
	for <linux-um@archiver.kernel.org>; Thu, 18 Sep 2025 07:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=weQA9Kmk5Cj0pX9CPL2mzbHMoGKA1UTMBAigZCiGmmg=; b=WL3rsQkowpvfYoIjcX9iRDELFM
	EStJwKAZi5xenLhfsEdxMoqZQbZ6cODZIQA26lfSXuLagYgctwk25C1rkn4VT5DCxcF5vLtwjJvDs
	pUc/I8ly3W6Na3hoIvGZMzJeVkTcirrvmmWzdo7O6aRPLbGn73tGSQyRMHEKXhv607fbQaw6soYuU
	M7V92JqY7yHkaQbJJgvkmQ5cccy4uVieXazk2rTbFxz1iJmz7R2vm+fW2UuD6iTBs46n0EXbr56Sl
	+B5dCpQ+Bw0ljZlIKZlk/1wHKh9JAhm6nWcM6R9IL3BR96w3QBX7xJfITb6Xd28RQ6m+DAyVaYVmy
	HwVn69LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9Ew-0000000GZLf-2P1Q;
	Thu, 18 Sep 2025 07:39:38 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9Eu-0000000GZJI-1lwN
	for linux-um@lists.infradead.org;
	Thu, 18 Sep 2025 07:39:37 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2445806e03cso8722925ad.1
        for <linux-um@lists.infradead.org>; Thu, 18 Sep 2025 00:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758181175; x=1758785975; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weQA9Kmk5Cj0pX9CPL2mzbHMoGKA1UTMBAigZCiGmmg=;
        b=m/rD2UXiieynTwLbMzxCe623KDwyQITMA1JZpD5Flo8Xh4E9Qca2t307nzjrinYeB5
         yEU4ebO9uMdZcohEARzph6lhquXc5JKM8l52DcUlHdx0GYPF5MCnsUFSYpSZU9DQlf7N
         OW/riwUzJDiR0OONfOcsFg5g3TNamJeoNW8TERZ89rTjkUi7x/tkw8fmzVrcBaxwyjAJ
         nE4LmuLKNQ0H2tXGc5EGDWPpOPL26bhlIVPyapE1LFbeV3ddFcHQEjQjBkekSfPOR8OU
         GQYUU3z+Fjk94N6RkKIx4RRy/uQsIgSdz8Xmkx81zrE3yzw/zXG9waKFVsE2ZPNzysxb
         t5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758181175; x=1758785975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=weQA9Kmk5Cj0pX9CPL2mzbHMoGKA1UTMBAigZCiGmmg=;
        b=mV151HR0hxopbI7Punil6QUHszdkAEPCbqxiPYzNSg/WcvT5GdG1/Ku7OhUGGx3tco
         Mbc6BOPABhRJPPW4onPl/8VCiWLZDB+YZWflprW/ioPYrpctAz8vXcNehtGPoWGOO92B
         U3EvKtWnWPA3bMO4fdt/UDGB5w5XUOTKN+3xkdDBheKNrefzSXD5+HAAwvfKfLIb2ygt
         ZcJytEF3r1uyWivZCe+pEjHUJwhFnsdaUBGtOGwX91u/vo4eWXsRw1rDsOA+ASWoBzrg
         Y6Dna6Llk8qY6MdlhBVPxKnT/8zlKUzfhdinkVXwt/NjXLbeCB93oQo/xHoTM4tYVdeD
         OU2g==
X-Gm-Message-State: AOJu0YyPCiMRLG5quumC/7DO6qj7Lt4Fh94wYcGNz+fSXbDBumO1gYid
	htGDj6zbYy31knR+Ar3Kj158pR5YmfOtZThlMQHaXvRhH2thHicDkXoZ
X-Gm-Gg: ASbGncvrSoy3lVm5PYL2KIxcFEdZoYV6JyI1CpNfbpe4WQiaIeijpG+u6Cg/K4HOPlj
	vJ/LKWBtTLi6vpaIqYCW0JDO7ww98ZBVUnGI6YT5o/ZvVPoIaMnaB+x51kV0OsCXCEJNMfQxnZ4
	Tk+hcubar91qZdPiCo4TLp0o6F/g2LCDGL65mnosQwlSlpJxUP6KDkO7j8/KInZstiei8kga0AN
	/kVm26X4Z20aggDtBTK1bVcAwsNT+S4EIZZfycXYO8OvWWRoSiOpumoJoWE/dEG1OpyECt7pIjT
	ycvMxqwmJmYRom98eeVb5GIcCVqZjhr9/b1xrfMyq4HB972mXltSxV06VhjUcv3zBrJwmPH/tIs
	9C4GtKOYEJrhbFwugkLLdVDtqrd0sWjP6pi5hnCPwosdIxpDeM762Zdx5PXIUErjslhzCYAkSaE
	dOODTDGYwaB+M=
X-Google-Smtp-Source: AGHT+IE+HOwpQOTe1IjwWUlVdtuE/bhc6md4K+/CWF49tmVYYKG4ELGdQ5lhm0IUR79AdsHRiU6vaA==
X-Received: by 2002:a17:903:18e:b0:24e:e5c9:ecfd with SMTP id d9443c01a7336-2681390328cmr73932485ad.42.1758181175568;
        Thu, 18 Sep 2025 00:39:35 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e00b3sm16679445ad.90.2025.09.18.00.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 00:39:34 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 3475E1062114; Thu, 18 Sep 2025 16:39:33 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v11 13/13] um: nommu: plug nommu code into build system
Date: Thu, 18 Sep 2025 16:39:08 +0900
Message-ID: <fc8ca16be8d409c82acd2bdb3e62b18ae3afe3ef.1758181109.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758181109.git.thehajime@gmail.com>
References: <cover.1758181109.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_003936_457357_A13B952C 
X-CRM114-Status: GOOD (  13.28  )
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


