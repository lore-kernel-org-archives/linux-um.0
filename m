Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF905CE8E68
	for <linux-um@archiver.kernel.org>; Thu, 24 Oct 2024 12:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qwi3Jmcr0lXpgi9n06tVS0RJnHuvok+eK1ILtlfkibs=; b=buVKopNJPsAUzraLaSOG7qwGUB
	c3vMzSD+3W+Ofoy2x39wGjCdZsjQk37/VW6sDIIqd6cEKkItkTRwZpw8J9hbSsmI4Orb0VQpzgDHa
	JboHj28ukVDnxrgvMWtuMtz5pYsxc1P/+CDqi0Qversk/8IL+Dp3qxbu1qu8dAsE0n8AeHwRftPCT
	J+AORj8RkYemDkQsqm+YLWC8L8iKpzMPUQPUNIvqXb/39kGs3pHxvviGTyo6Xt26w4daFPBt/3Mkl
	gZiNN4MgMo7MdSLiY/7fbyHBiZUg+PduSxVP85TvyN7EDD/l1NeQ9+vTIRjM7m+6ghB/oRL6PxZdf
	lU/ItE6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3wi2-00000000J96-1K8S;
	Thu, 24 Oct 2024 12:12:58 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3wfo-00000000Igd-2pyQ
	for linux-um@lists.infradead.org;
	Thu, 24 Oct 2024 12:10:41 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-20cf6eea3c0so6034845ad.0
        for <linux-um@lists.infradead.org>; Thu, 24 Oct 2024 05:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729771840; x=1730376640; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qwi3Jmcr0lXpgi9n06tVS0RJnHuvok+eK1ILtlfkibs=;
        b=TSVfpdbYFtV+N9ZopblqmPVYyga/9sy8QVSa8CYjaXPm4WAHxL0PILImU/NYnShYhP
         ORCfF4nOaagW2DUxJLozO3arzO2C1FE9EjqJyKH/lPOM0nhobuan/QbxTkGdBz6NKUDG
         MIUgNSWdX4rOW4RmADVYz22fho6Ln7QhXqPTj9vaDtpOWWGUUJgcWj21ITExnHufyO0J
         jZ0PUeMA4xrZ2lRzSuLzYT9fW2kJG07WkGxKYoFEubunMZ38+RyyDY6W2vff0giVZTZJ
         +5yWJsFD5FOTmno1s1WXdH5Hme/ItpCSTAarUsf9enXqRGefWQn4BOSxCcryteNS4J0c
         dS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729771840; x=1730376640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qwi3Jmcr0lXpgi9n06tVS0RJnHuvok+eK1ILtlfkibs=;
        b=j5D9zW+0wsgAABqcvmIbZHNwuNnpQI06L+zbl5yga0/0vUZ4SexCnlkYUQDDPbLP7M
         uI6r9ife9w200+7ueQa3j1D/Tbkj7XLe5E+qme9LmPiSRZhJxxotQzZLymbhNVJJwfwy
         bffLumckLaSd+oZzhiJuzP7dfNpS5gefF+PV2bb6WusAHszfztwHBtdP0j0dYflGUmZV
         Z1+YXNaFW50JlDE1JMJYJGiaVxPDl/RoE2P5twhpWAyWxS2Ea1lvoceu4ndIeHWk3qew
         opFljPjuzVSPfGrrjwWIvG97vRrGb3oL2lNBAJCBH8Kxer6yjvctafzdycMbHfyWpJo2
         szrw==
X-Gm-Message-State: AOJu0YzQCS0rJehFM89LZQAD/zvO7Ef7qpkTVVhSlsvQee0Eaa+/ebgT
	N+ZjZug0amAE3zCThQjI6DGV/DysBDlC2pOhbQX8ZmJFeWGR6koxqHbMrEuD
X-Google-Smtp-Source: AGHT+IFY9za947KkPP7mUseSpZL5d51CItnnoeoKmiAmL/+IFZUvKLEDE0ybCyEcPrEoP8vT0l1Yrw==
X-Received: by 2002:a17:902:f683:b0:20d:2848:2bee with SMTP id d9443c01a7336-20fb9975807mr21804815ad.16.1729771839674;
        Thu, 24 Oct 2024 05:10:39 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bd309sm71213275ad.151.2024.10.24.05.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 05:10:38 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 2DCDBD51261; Thu, 24 Oct 2024 21:10:37 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org,
	jdike@addtoit.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: thehajime@gmail.com,
	ricarkol@google.com
Subject: [RFC PATCH 13/13] um: nommu: plug nommu code into build system
Date: Thu, 24 Oct 2024 21:09:21 +0900
Message-ID: <82a7ee8b31c51edb47e144922581824a3b5e371d.1729770373.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729770373.git.thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_051040_737923_392FEE1D 
X-CRM114-Status: GOOD (  14.01  )
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
 arch/um/Kconfig                         | 13 ++++-
 arch/um/configs/x86_64_nommu_defconfig  | 64 +++++++++++++++++++++++++
 arch/um/include/shared/common-offsets.h |  3 ++
 arch/x86/um/Makefile                    | 18 +++++++
 4 files changed, 96 insertions(+), 2 deletions(-)
 create mode 100644 arch/um/configs/x86_64_nommu_defconfig

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index c89575d05021..7e0d4285bd87 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -29,12 +29,15 @@ config UML
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select TRACE_IRQFLAGS_SUPPORT
 	select TTY # Needed for line.c
-	select HAVE_ARCH_VMAP_STACK
+	select HAVE_ARCH_VMAP_STACK if MMU
 	select HAVE_RUST
 	select ARCH_HAS_UBSAN
+	select UACCESS_MEMCPY if !MMU
+	select GENERIC_STRNLEN_USER if !MMU
+	select GENERIC_STRNCPY_FROM_USER if !MMU
 
 config MMU
-	bool
+	bool "MMU-based Paged Memory Management Support"
 	default y
 
 config UML_DMA_EMULATION
@@ -187,8 +190,14 @@ config MAGIC_SYSRQ
 	  The keys are documented in <file:Documentation/admin-guide/sysrq.rst>. Don't say Y
 	  unless you really know what this hack does.
 
+config ARCH_FORCE_MAX_ORDER
+	int "Order of maximal physically contiguous allocations"
+	default "10" if MMU
+	default "16" if !MMU
+
 config KERNEL_STACK_ORDER
 	int "Kernel stack size order"
+	default 3 if !MMU
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
diff --git a/arch/um/include/shared/common-offsets.h b/arch/um/include/shared/common-offsets.h
index 579ed946a3a9..85a0e90a34b7 100644
--- a/arch/um/include/shared/common-offsets.h
+++ b/arch/um/include/shared/common-offsets.h
@@ -28,4 +28,7 @@ DEFINE(UML_CONFIG_64BIT, CONFIG_64BIT);
 #ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
 DEFINE(UML_CONFIG_UML_TIME_TRAVEL_SUPPORT, CONFIG_UML_TIME_TRAVEL_SUPPORT);
 #endif
+#ifdef CONFIG_MMU
+DEFINE(UML_CONFIG_MMU, CONFIG_MMU);
+#endif
 
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index 36e67fc97c22..d0a37634979b 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -32,6 +32,24 @@ obj-y += syscalls_64.o vdso/
 subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o \
 	../lib/memmove_64.o ../lib/memset_64.o
 
+
+# used by zpoline.c to translate syscall/sysenter instructions
+# note: only in x86_64 w/ !CONFIG_MMU
+ifneq ($(CONFIG_MMU),y)
+inat_tables_script = $(srctree)/arch/x86/tools/gen-insn-attr-x86.awk
+inat_tables_maps = $(srctree)/arch/x86/lib/x86-opcode-map.txt
+quiet_cmd_inat_tables = GEN     $@
+      cmd_inat_tables = $(AWK) -f $(inat_tables_script) $(inat_tables_maps) > $@
+$(obj)/inat-tables.c: $(inat_tables_script) $(inat_tables_maps)
+	$(call cmd,inat_tables)
+targets += inat-tables.c
+$(obj)/../lib/inat.o: $(obj)/inat-tables.c
+subarch-y += ../lib/insn.o ../lib/inat.o
+
+
+obj-y += do_syscall_$(BITS).o entry_$(BITS).o zpoline.o
+endif
+
 endif
 
 subarch-$(CONFIG_MODULES) += ../kernel/module.o
-- 
2.43.0


