Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C72CCFA04
	for <linux-um@archiver.kernel.org>; Sun,  2 Nov 2025 09:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ph9zR1fvONGEfCwcooy4q6QCBsuZBG7EiBPZ3ZJSBIk=; b=PvX6ueBtT7U8j9ZzJkYFZulaDX
	qxb2kkE0S6Ug8DgI+Jlo4UCoio/4eiL4/6j6DVYjI49cp4Q6chqhPfl5LuyHfTZe4svr5qcTMe7/f
	lgXIOJGWntl4XNFMcuk2F2PDt/HYWqNCZ1Atfs6j6VuTV2BZKnKR2xyUAVBzUeJQ/cij3S+x64x9O
	lXt3vNtwY0y7ua+y/+/mbFsd3Ekpj9BDccASg47CsTYnz+lRasWj3dbnJZJp829T/v8PpZY59dhcr
	HmNyZMKZrS0c5R1ksmK+1QLKZtR3M96VM5/PhOwM/tkuvk65i5WGze+FfQsltfUazSBrDS9+AQ73G
	oNBBP7pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFUiv-00000008S2Y-3OC6;
	Sun, 02 Nov 2025 09:50:09 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFUis-00000008Rym-38gr
	for linux-um@lists.infradead.org;
	Sun, 02 Nov 2025 09:50:08 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2952048eb88so31327695ad.0
        for <linux-um@lists.infradead.org>; Sun, 02 Nov 2025 01:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762077006; x=1762681806; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ph9zR1fvONGEfCwcooy4q6QCBsuZBG7EiBPZ3ZJSBIk=;
        b=JSM7Q1g7jgkvRecZceKdwKsrD9h5OEzunXGs34XOmYmjHsREMfx6+z0HHoSCuCd0T7
         1VQOMTap88OPsD7uoiK8W5T+XaEZHL9abLacsy4q2W3vQvWqq6U6vmZGRf9jnoAZhe0o
         An96cQ48XqiuakC6rVcuoMs44U7jdrawJyL7xHwbsIXc+rgRVubUHiT6NAWbrnMQpqj7
         Uunp0J5tmRcq2j+sUdkPELo9TxrQ6DxnIy5ozc4t7iSXAdVVkz3oib7kWWyymW1NwsoB
         lSGvwHIu/4/D15VTrHA6BiwYRAi3Y0AqZ8+R9ALxmlxFN85TM1qnHtJCiP7QpFrgH+KD
         h++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762077006; x=1762681806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ph9zR1fvONGEfCwcooy4q6QCBsuZBG7EiBPZ3ZJSBIk=;
        b=dSpWL9hib2Q39icmlM1RlIXl43e3eWKym0rDXb8HMtlSnjY50vz90EdYQ48HSLvhKc
         0AH4qiUcS5ouov59CXJAugPsyPnEuE9Oo2jbjArxDW6X3Hhj30gBW9WRc2v0iMi/KBYW
         Vt4LdSy9KOHc5PaI6VEJEaP+WYLEoSBVIFQSujgKpZfOjT8igaMO0J+egV/haKZ3zmZ7
         t/5BEYYl9Jq6pSHb5L3XoPMlMzVasWv0YXRVGllcp6ZM1pU7v6rzsCCjTc/6hmrIYpN/
         HM6MD4UQ5SMy8HO5aqIto/6Z6lAahFVmG3jR/6gHm2XpJNGTkM0tqjvm/VmMkdMhACjF
         ml9w==
X-Gm-Message-State: AOJu0Yzv7l1A4nuyHFSpMCef6FQOSJexWXy+tnyK3v3lLDn5CUS+xxho
	2kaSZA6XikWFEGG5OjWaPPGoMVEjuwgHBp1YlKDRkbTHZKiQxQupjXj3DwsgCg==
X-Gm-Gg: ASbGncuSvs/sqXNqH3WG64ekXP5ioze9UKyVW2OLgw8s9z1v0kxIzT8OqBZkjFRNbDc
	DIn6EQsYq8OI91sMJakj+kYBi/mlHH2p0n1ldUha+XatVy7bwCfPTiq1XrPCSL/6/sCRNlyinXP
	g1QAknC0lPBV/bzEKv2RuPU5utRQsqEjpWQYIXAnJfFmrzVt/c3qIVTug6t4I8kp4ZaZZOtJWTp
	kHrzfWyT/rnEJKpSGkzwGa2b2Kp3stRiVXfbfWWl8IHtoHdwP+vFQWk+dnplrbtFBwALD5AF7Dx
	v5edHNnV4g+jyDOJebGkJ6B4RB9OnL5fjswTAfECciNsIuFRwrcIyh+nfbPLTuv1mH6ylhbuZqV
	cSKSpL3tv/SyMUtDDPnR+3nBRDG9XLDuKh+4M7nkexZt8MniR7TP3UJklJwwHGxuFe0k3RsO7YS
	LwYzjuxumVuLVtJpBc5qh7EJ0aFYrwDIX+BXMS2We/qfr3HCUCbv1HQtprl91CmY/oEek=
X-Google-Smtp-Source: AGHT+IHUuWG7Ov5kBT/yNTPJH3xuxkjK4iSTaaCg1YaGK1t1FQzTnk7AwddqLgQ2HelyS4KrdoJ2gA==
X-Received: by 2002:a17:903:2285:b0:290:2a14:2ed5 with SMTP id d9443c01a7336-2951a390655mr107666405ad.4.1762077006004;
        Sun, 02 Nov 2025 01:50:06 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2958dd23059sm18342285ad.47.2025.11.02.01.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 01:50:04 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id B73931123817; Sun,  2 Nov 2025 18:50:00 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 13/13] um: nommu: plug nommu code into build system
Date: Sun,  2 Nov 2025 18:49:38 +0900
Message-ID: <efea26f968ad9049116cee46fb55f450df50033d.1762075876.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762075876.git.thehajime@gmail.com>
References: <cover.1762075876.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251102_015006_794527_FCB6A8D8 
X-CRM114-Status: GOOD (  12.95  )
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


