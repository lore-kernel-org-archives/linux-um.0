Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBA8CCFA18
	for <linux-um@archiver.kernel.org>; Sat,  8 Nov 2025 08:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ph9zR1fvONGEfCwcooy4q6QCBsuZBG7EiBPZ3ZJSBIk=; b=BTcAMppajzprbWas5zAl5NYhgC
	cVl8ayjZFMaiFg75Vn2L0kGr/FXHOqxbXBIV6oWA4FoAtJhWQluYClkI2HLqNu95gwqG8VCj6YiIg
	jU5vEJMNxwrIDmeZkMUl6vEP/CAmCvvZhn/J+uQ1ncDqhBebbAXNbSG5xFX6OHYBdqyAMuBPe9dkV
	+5tkltlY+tuZ9jtWpvU0Ya7GmFU1um9xdkfkIBWJVbzYEGn2ht1dx/Me4RAn25AKEjoFiyGxGT7bQ
	4IXhOBV+qOBpJmdeGWgNbtzFrBKcnx5iQ27RoU1YiENNasnjZpxL4EqCm7sYZJsAXLjH1BTee2wUZ
	HIKYdceA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHdxu-00000002j9p-0UqX;
	Sat, 08 Nov 2025 08:06:30 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHdxq-00000002j6n-0CVw
	for linux-um@lists.infradead.org;
	Sat, 08 Nov 2025 08:06:27 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-295247a814bso18913665ad.0
        for <linux-um@lists.infradead.org>; Sat, 08 Nov 2025 00:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762589185; x=1763193985; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ph9zR1fvONGEfCwcooy4q6QCBsuZBG7EiBPZ3ZJSBIk=;
        b=ipgD6aMMO9iJtPiSaqsiuOQXD/mLRliPUYhkjuHiU48w01PQ9dXsZJQaDIQvYlrzz6
         Hf+mcUOXe2FkdN/ska/NVDSNTNUlqGKuMtOFAyOwJFX/43R8iZPTJ7rGJ1nYbSqkclGL
         B866rcc9Uq3p0S/k2VYhTVj3czQCfdBT1dHyT4dgnohUsgOlWt31pO9sG0ycLSO1MwD0
         pb3w2Qde74fb4mbYhuBrBBC9Xwi2t0qjqsnV1Szptj9x7RyAwrHHPDUvij21w/o4PWBp
         dfK77HJtumLc9vQXQGkL4TMWATbd7sfPJ4QgS/P+t20VkhDmsz/RNM5nylG/CKue9H5Q
         3j3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762589185; x=1763193985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ph9zR1fvONGEfCwcooy4q6QCBsuZBG7EiBPZ3ZJSBIk=;
        b=SWP4OZsfBmP9tevGuxU9HP+GbB4MuBTk0+V7fqb67/X2H0WYPPDC73CysSLhNV4Y+B
         BJlYnkLDyFYB07V4o0073yHBq1n2LwGQuUH9n34mqFiGMJSOM11HgOATY/UooxUFmk0A
         xPM8+zc/1zFiiBQCSQs/40zLclZ+XgiLWB8WAQGssJ7URQgeklxe+1AruobpC5pixJ1m
         KDhGNpz0yf50N1tqXydaB2sYuCTo8/V6Qt7UxTEsOGTWJKTJ81+x6l6g9AjAbHPscdJh
         dWD2mmWolhITI35l/eAVCYqTMRg4/0edhosm56c+qJonNe2E5/ENgMSQ4ij4odzcmLsQ
         F+yg==
X-Gm-Message-State: AOJu0Yz/rguHgPLiSfqvSFI+uF8K3bmZXap9qcPkX0Ob1fXVwcH6E8Fb
	DuVCHU+rkx92bLt5EDkSyJEQ45oI0Um/ALWH76wWK4NjxjJcg+eSFyu1
X-Gm-Gg: ASbGncufkrKtjuspuvswLWYjywMCEsCS1CPEuVlZheTGK/ugnx0drxg8qKVmIG2/nUK
	pDCyomtGbSRYugLBkksNadob5dpiEAgfz0HqAZ3333QgmRIMG9xR7XH+Ecl9M/hTA+f6YjdGbRp
	6R7vNHpzC/6axIC1A5sa9dpP3i9I/fv4+8p4mNyT5em2Qtagq6CxWQ7VdW5/OTzqyCGKBWNRjUb
	ZZvUfHuW8XOYwjhZ9oYsPJ3OfxK/Bmg/F/viz1NdA46HMQnjA83yL2uoeJEm5L5wlYxb8oqt/Tc
	RJdLnXhNVxUML1dUnpnrJebmt3B/A8SNeZ8w4Dw8k3YSwaQ+0TulVwpBhJSF7BgAl/LyCIxAca5
	4DhwuMqJz7OEfsDZIB1ekr5mdwjOsjaLyBpMLF9UiAf6UixUGoi8N66OUrmy+LZfCz2LllNUUkv
	ZLmT8pQ1gIZTlCi35I47iHGekWKnH8Hj9A9b9tBUxoOTKFz5c0Y5tV34O5jjEhqSWD7A4=
X-Google-Smtp-Source: AGHT+IGJfdh18b/VLG+FNXOhiB/u0ohyfs/EsEy0a88QiPDZTbxqJDMvN0IIjQCopB9ZzCCa4OleMg==
X-Received: by 2002:a17:902:ecc5:b0:295:565b:c691 with SMTP id d9443c01a7336-297e5629152mr26786625ad.17.1762589185138;
        Sat, 08 Nov 2025 00:06:25 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096b8ffsm81262075ad.21.2025.11.08.00.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 00:06:24 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 52B3311388DF; Sat,  8 Nov 2025 17:06:23 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 13/13] um: nommu: plug nommu code into build system
Date: Sat,  8 Nov 2025 17:05:48 +0900
Message-ID: <ae577803cd463b830d120f15b316ad8c373d4735.1762588860.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762588860.git.thehajime@gmail.com>
References: <cover.1762588860.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251108_000626_226412_A1BD0AFD 
X-CRM114-Status: GOOD (  12.51  )
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
index 097c6a6265ef..4907fd2db512 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -34,16 +34,19 @@ config UML
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
@@ -225,8 +228,15 @@ config MAGIC_SYSRQ
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


