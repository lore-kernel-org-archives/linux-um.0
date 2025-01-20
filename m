Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6885C0218B
	for <linux-um@archiver.kernel.org>; Mon, 20 Jan 2025 06:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CuYeFaa6XJVhVFEeEDlLSKoQQuloVwYK3vseBrnmsAM=; b=Q91zrSjIzg6KnWJSYndxdFVrOd
	lWmjFt7NPZPjgntuIt/xajlfibCi0Hp0B7x4UJW2enO59S1Z3D6EVJQoG8uajc3pbYamYqnkvB6l3
	giAJ05elrDFG+WuZrApZW26s1M+DCaXt4a7kIVlfJvI9Mrv8YeKEWiMAQ1Ca6dFDTVqxEnOdLFtUH
	F7hddk4TAhn9lM2Fe+7OQhL0uh8mFZDGPpWBCetrqDUFHgU9QrcOySs6cQ2cvp+hy9QT6lLkdeaS/
	Lh1UKi0J9ApdhrZihOLZCl1NIwcwKQQlLs3rBiYLQ5U9D7ZvwZE5CvRd/OXKsHGLm9s0VvUrmBzqk
	440tGcJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZkr5-00000004nWg-1UgM;
	Mon, 20 Jan 2025 06:01:47 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tZkqA-00000004nJr-2emM
	for linux-um@lists.infradead.org;
	Mon, 20 Jan 2025 06:00:51 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-21680814d42so66734175ad.2
        for <linux-um@lists.infradead.org>; Sun, 19 Jan 2025 22:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737352850; x=1737957650; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuYeFaa6XJVhVFEeEDlLSKoQQuloVwYK3vseBrnmsAM=;
        b=Nj6TpTAl8DDqeG3/rRkimHejy8yM1aJ8aecNfBFVM8226ZQ6TXjJKPNhVV1dj/X/9t
         Qsct3aeG88+jYgmIwjkgOzUWojTiBk+wDGLtNEuuJni+kBCqp4tPHlgl9R29+anxGvnM
         Fvk7Ssx1pJ4gkvrhJUDCNYoYd+hFGeH4f5zBbxyrKItE9c1vBZozYpBU6vSeurjT95CJ
         p4gMJFr/Vtohj9zKBDfM2N5L46zn+hDs2caM2HUHaDuSm53/7t/DCb3gL97LaUDbiONp
         RDWxKdykVa5Gfc0mUwq93C2KAE7+wYPZEessx9vjI08+4tlweRWKYXiCU7i0Z7eUDzW7
         /AYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737352850; x=1737957650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuYeFaa6XJVhVFEeEDlLSKoQQuloVwYK3vseBrnmsAM=;
        b=DLPBmkI6Wi0oGAzH9GddHhL3E6LmzYNgHBaDJO1msd/8bM/1vK+Sd0md6DYrDmoRO5
         +NCBvDCVCa6CH2J96StAm02deICp1ZCpE9E4Vex/uW5bWs9iUJPwI9aDyLLDwJMJdh/b
         E8GOezb6SBi/6o6ds0kH6FjSEf9maNRJtZWV61SvGsEUvo8s4t1FRmBdGa3s9S9w+eQv
         tWr6bAInbE6GFTKaDXx6fNgKxqwbBkg/z18YDSoR6HHhm1YvgC5MQ2pOFUSR4pVoKJOh
         v5mRAZ6FJdFK6eK9PuOFsrv8jFL+6veppfDUFgrF7AsK5AnSoNaDQtg+DCvHSIKAv9Ep
         B6Hg==
X-Gm-Message-State: AOJu0YxdEkIFJ8+f90mu/fo1qOVMpyqAyIkCLwQi2S655l21ngwQMufo
	LcftZCQ/glycbqdoiB7bGyBB3ON5piqpfiCqhW9LNLw4jbHWBbAg
X-Gm-Gg: ASbGnctcuDtvwFwOATuVgvO0m20uY/pyQT18qHpObfbOp9jJyHK212IAv8sV9p557m7
	IJOHn6d9zKnmZmcFIv4F/EBAahymhfm/U0DspT+0UEqukl6kxi9BXfS3/H3evWH2NTtWbm7Z3Rt
	F4xiRaSuoa7GchH7PnLcMIwWpSed3ZCdePThnlnOP+9oUQ/oINoYR1sgBid7HTsvV11Hr/X7pZ7
	oFmVJY201rucvSmdZiY5tJvwMFPFU5nu/OvfofYqKTdcNZ8XrGRnfYcMBU3p6twF6mApJPqf2Tn
	HsqwiYw13vdbI72bCOHHKsm3zab5VyTSpKoaDGAp4Q==
X-Google-Smtp-Source: AGHT+IHeGeaA6tt/WnsBig350nrOCCdCABJjvmKWP6jKPsNI+Jr0BZaRo486tuJyyieyd/V/tzMhNA==
X-Received: by 2002:a17:902:d48a:b0:212:67a5:ab2d with SMTP id d9443c01a7336-21c35604a08mr220479625ad.44.1737352849974;
        Sun, 19 Jan 2025 22:00:49 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cea0b91sm52663815ad.49.2025.01.19.22.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 22:00:48 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 94CA5E27540; Mon, 20 Jan 2025 15:00:46 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v7 13/13] um: nommu: plug nommu code into build system
Date: Mon, 20 Jan 2025 15:00:15 +0900
Message-ID: <71b46dce2ee8ae8d9e26aed9bd21aecee1f1a443.1737348400.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737348399.git.thehajime@gmail.com>
References: <cover.1737348399.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250119_220050_687852_31104F21 
X-CRM114-Status: GOOD (  12.47  )
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


