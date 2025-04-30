Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BC9C3ABB5
	for <linux-um@archiver.kernel.org>; Wed, 30 Apr 2025 04:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rT31LZBxKQU6eu4tlFml+AuOML692n2PMZhnY9YLrtA=; b=HgUetcBiViQa7czCWRZUWxBZ9h
	0dnUmKXNCKwptMsm3sxUwz40vXllAQ8K7JtAQ6wWWq69d3JE/2foskgjpVyPNEhaVdqwIDdWQPcwy
	Flv/RJKSMJIrS+Wf2k3AEJF3dqJ913c/+tiHrE49X/ou6o+gWTY90sbPElcxoiGx7VwyoHK6rg1VT
	BiBE7iW2qeEgpgM9k1dyHQs6lrcj2riYNf37otYkgDAl4eZv9Q94Iic0CVHkIRFWE1ru0ceiVxKbg
	qWsW5VSd3o6OYiQryJfUXFxlzJBimUbm27Whq2jJYNpyXs/yy+X/QfHcO/br6sz5ACQCuR3vyXZ9C
	a8D2eenw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9z4D-0000000Bfjc-2Jid;
	Wed, 30 Apr 2025 04:29:05 +0000
Received: from mail-pj1-f41.google.com ([209.85.216.41])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9z3I-0000000BfV7-39pW
	for linux-um@lists.infradead.org;
	Wed, 30 Apr 2025 04:28:09 +0000
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-301302a328bso9391019a91.2
        for <linux-um@lists.infradead.org>; Tue, 29 Apr 2025 21:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745987287; x=1746592087; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rT31LZBxKQU6eu4tlFml+AuOML692n2PMZhnY9YLrtA=;
        b=MW8Vq6BtNt+wn66s6tw9tAfrFA3J82/aslyl9p6v90U9qQOYQqNilxIeuv62YACAnD
         727T0GJaVIjktAothLwpbkDJ6AuWKv1JAV6vFQEGnK9s4S8qQJXi4kGAqGY30yD5iCTr
         n8yO4pqZv/7a1bJIDjJtUcpx7IEqx9LSe0+MLrvEj3P4aCilXsma9ZfM6sMx5RQcdDSY
         bGhKPqglv2esBZbvDLYwlE/A99fdxEpM/RJw2K8v7P4JaEHx9N8x3Kt+wk8N3x3bqu7O
         Zzy8GJodZ4OBsBhaGcvogMVQzu/mTBTFef0JdBBcroYBLuJVmWpNvpX5XReq+URcr67K
         /7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745987287; x=1746592087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rT31LZBxKQU6eu4tlFml+AuOML692n2PMZhnY9YLrtA=;
        b=AlhW88Zq7PT2uCfi4n8E8BXqp0j1J/fwvVBOucBdS8+fUqKJbAE3SHSIR/OcuQxzaU
         VfRljXwLx4HNokx05LsBpsjVYaXI6pNqy+P4h/i47jiZwS1Y5DVqlQixxOmNpxqjBYga
         OiBJd3e+Ew1jLIs0Q2MDAknXWcD6qE3kfJgnOXFx0CoTQvBZAYhN3JZqHLAbv6C7Mwdm
         0ogOXnYQ0lL0+jAPtU6SirsGl3punTuWoPSKq6qZgshBAvCHTX1iDaYEv+d4WZ1ylsIL
         CAJY/lCcxum3VlciLelUMQDaV1Mo7sn0s6tG0gvGU00/Vd0lfWVktil4/sPcsWND5CKR
         72eQ==
X-Gm-Message-State: AOJu0YyBoU2WLVhgImyoryEIKh+bPpyBG4moNHRAIbC1cIgvhZm4T6in
	77qCnKRg/D+Gaj+Zo/2iLgjIsKbR/IDAjQt+4otO0F6Q6UANg0RH
X-Gm-Gg: ASbGncvzpMV6OJd3Oye0aOaHWAyeLp+vr7/+KbrtuK1hs9zy5Tr09Se61Pogbmv+aTM
	BhbJVm1vEVTuy9iRRT/qYMsBzBxySFq4E+JKMt1eTimICaer9IU8A1LO/WQnJZaVOlX1iyg8iVJ
	nibSvBGAkWGjkFefX5pSgBfk1xQoVm4fVyc4nBg+geo6t4l9HgEZLHSmNnEPL3ZuXDBh3GaAm88
	FgdL73DBQhSHZByltiqosczp2xQ1VZVrTilD4CVZh8oOCHWHcsxMKTp2QTQQuMYAaoYtiRcANYh
	LxHsT1n2HX/432ipl1OOjT4gNAXoxLt2DO8tn7XaIT/PvjVG4tPa2JUzPdG0+un2rMYKPVjpya/
	YQjazOJ/Gc0E=
X-Google-Smtp-Source: AGHT+IHs8ctUZrSNL4gP9gYydAnVaHBNQJH8vTsp9SOtrT3bTdbngoqV9WtXcIXTZkQTZdyv3JUqTQ==
X-Received: by 2002:a17:90b:1f8e:b0:2f4:432d:250d with SMTP id 98e67ed59e1d1-30a33302091mr2229467a91.21.1745987287552;
        Tue, 29 Apr 2025 21:28:07 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a34a1113csm493273a91.22.2025.04.29.21.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 21:28:06 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id EFAB9E9482A; Wed, 30 Apr 2025 13:28:04 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 12/12] um: nommu: plug nommu code into build system
Date: Wed, 30 Apr 2025 13:27:18 +0900
Message-ID: <5a59722b1cab960187461701df76d6f4d3f1249f.1745980082.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745980082.git.thehajime@gmail.com>
References: <cover.1745980082.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_212808_789196_261FE3C1 
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
 arch/um/Kconfig                        | 14 +++++-
 arch/um/configs/x86_64_nommu_defconfig | 64 ++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 2 deletions(-)
 create mode 100644 arch/um/configs/x86_64_nommu_defconfig

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 79509c7f39de..84b2ee7129ae 100644
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
@@ -191,8 +194,15 @@ config MAGIC_SYSRQ
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


