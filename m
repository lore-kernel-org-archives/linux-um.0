Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C626E6C5F7
	for <linux-um@archiver.kernel.org>; Tue,  3 Dec 2024 04:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r0xun+Ov366EVWhre5XHhHgWvyEJOnJJhXH6nr+3WcY=; b=QPI008UQ2iWKjOhjIHZGe5L7Wr
	ibz8J092Y/Y9rKet7QKiz0WKTDBS682NvBTrBrtOzzZpZn8uHjRgPuQYUVY8JUQTqwk8lH4unVHjI
	6SUuj88tmslWQejFyKccX1zKq57sFgWs0z/W+bfI7z3kFL45h56xrxGmYtciql/mP2nqspo3d+M53
	XIF0RkyHTAraK4E0G1nROm7vMfbn147eruLbPJAiRmC/6olxu7ms+Hxs5rIYr7pDIVAzzYWn1x/pt
	SS/EwP6i9XLGlSIfFqufN9nEqDhzya3++bZmc2h0gwKGokuQ7Kl/uOf1JshKwG11ac/Ds9pF6Hcar
	2zvEINDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKSH-00000008DZN-16u7;
	Tue, 03 Dec 2024 04:24:09 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKSF-00000008DY3-0SzG
	for linux-um@lists.infradead.org;
	Tue, 03 Dec 2024 04:24:08 +0000
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2ee6dd1dd5eso2701914a91.3
        for <linux-um@lists.infradead.org>; Mon, 02 Dec 2024 20:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733199846; x=1733804646; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0xun+Ov366EVWhre5XHhHgWvyEJOnJJhXH6nr+3WcY=;
        b=VVNKxRqReyayEgBPrNpsRdwzk+haRRTBD5c3R1ydUMb+/4sn8CLQEmqrImOdMy2gR/
         RKaaiUtDH+X2R6lbwVF0VfHs0KQVGBLS+otgmOPSEe2XwxA1Ewk59h0jCFSn3mxrnejJ
         DVwAgwwqjHjd8obUPbTkcQgYVceSyjYxHeyv8kKuaC7zgjUlhqFDmPYI/QBX0vPLUoxA
         1/ceq7cLC7XNM4U1JIW1k7KWa2txyobhrDHzSIxM74WbfkXZi4XZoV/5QvWTCQorJVM2
         94VphlLIO1XCTnedvQr9U+O39d9SXgAqjCo/Oak7vkym4+ABSfGUJuNx6Efe2DbB2FlX
         qrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733199846; x=1733804646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0xun+Ov366EVWhre5XHhHgWvyEJOnJJhXH6nr+3WcY=;
        b=D1Kv7VBH+5ttHeMnN6cOgbMaMQA+k5PJXFTbplI5x4I257HO0HoHZAAzxisKg5d54B
         Y+25FpqC1ZGVp61Y7PZpkqjzp/PmeCF1WW3om0UGusDk/wgBvWWI/fX9xst8Nnz2b0TK
         66jPmDP+Yd29ngvkKA3vU5Ht9yjykWBgSfrZGpWt0VOmNu31cSIV3rPQawC9Y2+h3Vso
         v6nGM0oGaVc8LJSIx+X72DjEjs0xfFo5fCFGPWtTvVKrOBE4WMl/rsEPrdTf/wdqea/c
         g+Ho0bJ+M4KaQDr87OMfQ4/JF/MmAPj6IoeNq28NR1YtiDC+mqOb9On5RO+ULzwD/JUM
         r1RA==
X-Gm-Message-State: AOJu0Yx6fCDnUPQ5550cCsAw2thGGy58EtWC/xZAg+gfsqhqz0B2TTlS
	+CuEs6lssgHfhTk+Ya4vT4h2VtXwhOcpYj4ALikJhy+xtupqZlEt
X-Gm-Gg: ASbGncuM/XEDe3zthFZBa+sXcN3qU4sltcp3t7KKQthJyPmNnmelRV+e7QJu4XhrJC1
	z5rOkARnCOBlzGw6UAFH/mFjMy8OlWeZksr1zrTSoBuZMh3wlv5uQuowR0a57fQfzd794JKcYGG
	IBZUoH9DdN5ntTMx3V1mQpQBr0B3IBg+aeYQltKGxfW2R7kCckITu8VAt8AxsBu1yy8KD2sSWEB
	bhhUeWMO88Mnb5uhu3Sbgw8LnT43li2ylafk7Kvy2pemT8pQ+5lpJ8JzHQC0VFNLnq4weei2obJ
	NCWthcsXIVy6Zkkgz1nY
X-Google-Smtp-Source: AGHT+IF4WrhiM4jXXQzCg6KEIBYjeljIueYcmtVYoQR+6S4KUBzp8ehC94jUaQwlvoCPcfyozdAf8Q==
X-Received: by 2002:a17:90b:2e51:b0:2ee:d7d3:3008 with SMTP id 98e67ed59e1d1-2ef011fba50mr2144238a91.12.1733199845682;
        Mon, 02 Dec 2024 20:24:05 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee7413422esm5831886a91.4.2024.12.02.20.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 20:24:04 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 07D1ADD3A11; Tue,  3 Dec 2024 13:24:02 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v3 13/13] um: nommu: plug nommu code into build system
Date: Tue,  3 Dec 2024 13:23:12 +0900
Message-ID: <4f8fefb228fcbb0adf2025313e674b8fc20ff551.1733199770.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733199769.git.thehajime@gmail.com>
References: <cover.1733199769.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_202407_148847_49B456F8 
X-CRM114-Status: GOOD (  13.96  )
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
 arch/x86/um/Makefile                   | 18 ++++++++
 3 files changed, 94 insertions(+), 2 deletions(-)
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
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index b42c31cd2390..0513c4ad0130 100644
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


