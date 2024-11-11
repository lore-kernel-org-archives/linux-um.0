Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9975FD12D77
	for <linux-um@archiver.kernel.org>; Mon, 11 Nov 2024 06:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=88f6/3StlK+B2n/V04PkoiIStLbFWa6jUrm9PgjB1nk=; b=0i0FO9so1F/KQEPoEFhOdjwugd
	IgxaNnBvFxJW5vvwu7EwIPKDgrDKWcGwOlURtUAV0C2lvp/9dJMPgD+qo4UFyYynocXCMQiYcreY+
	N1jqDSbczLIu3gA/clpGncfZGU9jFbC8bRlNUnkzG+pZSYsQiD15pwgEW2/z8QZKICibsSZ6Y7knk
	eKFQ+g8pJfpjjgLQpLuufO0TSEf0cYIBe9v43EMgBi6ht1rZYRH6TBObfD5u8WILgwRdPG+Tuj43q
	ICIfZeFPGVmof2y9PsZLZX4jFz+HPuFZTv2idFL513+9pEzS+rgH3jog50dWd69tDSCMR6ARZYcwa
	gdUMvadQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tANv3-0000000GUNk-1S1i;
	Mon, 11 Nov 2024 06:29:01 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tANv0-0000000GUN4-27bU
	for linux-um@lists.infradead.org;
	Mon, 11 Nov 2024 06:28:59 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-720e94d36c8so4425407b3a.1
        for <linux-um@lists.infradead.org>; Sun, 10 Nov 2024 22:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731306537; x=1731911337; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88f6/3StlK+B2n/V04PkoiIStLbFWa6jUrm9PgjB1nk=;
        b=djZOGxgfFIlcfcHOmR0ygtFcTBWx6hIhGfs0OHxVd7iYDbgU8qeJFZ65/s+ldI8cip
         FskXKLAhmnXIfBiiU4aG0aoorXesjJacELKfJ2iY5UKxh+BkS7ZtxJns4P151lT+9luP
         e8auI8G/R0chtQeTnUfx4ry38vIsyY6m37opvubYFDarFHG29HHaqt8ePMpmPeL9+TpS
         Fk1xvrA5VMVWrrUz9AuoNDvnfVjrNrZXTC5AOPerQeGypuRZeyGlVv/3gwfICrd/Bohk
         dE61kv7BaYTajMzUrJSIqxmP5Jih7KsQFl++HUlX0zrz7Q8bgS9c3Se3imuOjRNMGEcv
         y2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731306537; x=1731911337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88f6/3StlK+B2n/V04PkoiIStLbFWa6jUrm9PgjB1nk=;
        b=On5FMOAV32tdfYAj8b/e8zrk687CIQuCIKs31zjE8bLDCgztbY6G8bGv5e2nvsiyF8
         H2EXOSBEqohxDBfuJnUXrEDjOvfrTpc12HlmKC+GWelGQv4NTvMS2STfhRVMvGIO5O29
         vsmwOweReuvQybI7Sj62grwnlBLKXDjN3kOBmrXfF1n+dLHzB3pM1mnFjabJJXYL7Koj
         qCBNsrK70lk27+PcZ92HbqeNglQQzAzN4BoAD+oVWxEp/afefu/eKPlYQpr5c6r2oimd
         qanVOt1AN3HuDUhkbY9WSvj4Qlays8c+ziyThlalH3g6BlDRQG4W5WLa8bAfGOKC5ErI
         j86w==
X-Gm-Message-State: AOJu0YyG0c1W0mU6NdF6Vw2KK6w4AcL1ok+SsucvOfd+ug98ao4jHju+
	wvIM6R8Lma5cUf5FK7IH2a13xewsTWkv3d9KzOqM08OKQaLFlH9V
X-Google-Smtp-Source: AGHT+IEOfVoxFaJ4zhHD+TEqr4EbtC2/3lVnsJg2jPWEIWsqpj/mbQt/NxnYEXXBtk7Q2qf26GLT+A==
X-Received: by 2002:a05:6a00:1701:b0:71e:6a57:7288 with SMTP id d2e1a72fcca58-72413f80258mr18286267b3a.5.1731306537319;
        Sun, 10 Nov 2024 22:28:57 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a4f566sm8251211b3a.171.2024.11.10.22.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 22:28:56 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id CFD8CDBA92C; Mon, 11 Nov 2024 15:28:54 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [RFC PATCH v2 13/13] um: nommu: plug nommu code into build system
Date: Mon, 11 Nov 2024 15:27:13 +0900
Message-ID: <460c900f1bafb3fc239c6f874f9e971d727ba736.1731290567.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731290567.git.thehajime@gmail.com>
References: <cover.1731290567.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_222858_570246_5C39C29B 
X-CRM114-Status: GOOD (  13.68  )
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
index a9876bdb5bf9..81897c496711 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -30,13 +30,16 @@ config UML
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select TRACE_IRQFLAGS_SUPPORT
 	select TTY # Needed for line.c
-	select HAVE_ARCH_VMAP_STACK
+	select HAVE_ARCH_VMAP_STACK if MMU
 	select HAVE_RUST
 	select ARCH_HAS_UBSAN
 	select HAVE_ARCH_TRACEHOOK
+	select UACCESS_MEMCPY if !MMU
+	select GENERIC_STRNLEN_USER if !MMU
+	select GENERIC_STRNCPY_FROM_USER if !MMU
 
 config MMU
-	bool
+	bool "MMU-based Paged Memory Management Support" if 64BIT
 	default y
 
 config UML_DMA_EMULATION
@@ -189,8 +192,15 @@ config MAGIC_SYSRQ
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


