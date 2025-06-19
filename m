Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD686C7115C
	for <linux-um@archiver.kernel.org>; Thu, 19 Jun 2025 01:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4CZO2OAKV3OtJLgmf9ZQYFE78DDsp7kzC/L9szpctPA=; b=Ez/Ny26qEgwmxUNkzO3Gzny5oC
	RJ1k7tjqWIs6Kw2qnpPn3xMmCe9J27E301tF0p73kHbfhiRLIRkAYKdeIAv+mcveqQcsFxBrToXlE
	mM89lIUIaJ6KYF30wIoKQSb5kCWGJyEL2+BDbyEq7LZGhTLY5BE8eZcCN970UNha2VqUUZm8FdxJ2
	qgHMpLC/hoN1+OUDb0Wzby12uG1YHmZivkINSAPgs/5xNp0bmq+HLFiwAQL5T2CzZtwBg41aK+DBx
	yHzKk66BhU/EzD4TDajTJkL1SrNqMhlc0Dm19ihPmCkTGgwq323En7FkNtDIjtLlwiQaAeqYxlkU0
	tCIfWf8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uS3iD-0000000Bgte-2KW6;
	Thu, 19 Jun 2025 01:05:05 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uS3iB-0000000Bgr8-3uzU
	for linux-um@lists.infradead.org;
	Thu, 19 Jun 2025 01:05:04 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-235e1d4cba0so2569875ad.2
        for <linux-um@lists.infradead.org>; Wed, 18 Jun 2025 18:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750295103; x=1750899903; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CZO2OAKV3OtJLgmf9ZQYFE78DDsp7kzC/L9szpctPA=;
        b=WLEAZhCxccrpwL3pktu9bWv4fJGOOGJTbiZTXo0pNLCdWyKBjMQVR1UHWOon8M0RuQ
         wODpQtE0Vca0o8U31f4oZO9QNbfLIWmZUwshwp7McFM4gasMaXQYAwhWzYG/A7WyE5FQ
         +youFBEUSCBXlqHFPlNKOntjF1wVzASr62vaQoq0vA5UPIu09gKoHH6dG64sCgWvrm4L
         1BXeR9UmoxXN0KFnn+BB9r24XCvsVU9FSN6wdQiCJ0pDYRIMV+j676VrbkHZC3SyZpXg
         AkECUEsNLW0tTYEurF+bZvNIoIl9Q7XDJxt9WZORrD3KgUX5sDZFuKk+5MGqr/MB3KTl
         IQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750295103; x=1750899903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CZO2OAKV3OtJLgmf9ZQYFE78DDsp7kzC/L9szpctPA=;
        b=O+hZKiVp2LZrxKh4pj9xGviCZq+XmK2ncZ6ZCkL7cZayRs69Q0/AO2lPb43Yag+WUu
         NHkL9/FG55kiXL4KQSTvVsdbvVrm5/uBKQJImI6fTmrAQyyAf1+nZlWR1YiGOS1sSWS6
         MCq8tnhH/RmfWDvt3ucEHptIbjbjGOhWpPApGP9Tn7myLhdrUsKN4OFkIPCc4rNaepWO
         5NfjFckOZ2Vzxrcf8W0cZvov14Klm8zmJIfGJJCQSJ9X3KwSxHHF21G05MAnDLzglflX
         PKRjx9BVSVChQhT5RXd6z2ZCyUeUNlwrAqLprv6ofqANcB3djBprVd5OTMfAi6zlIUxn
         /qnw==
X-Gm-Message-State: AOJu0YzsI7IEuZu5up/uSCQLeBXJUBkyV7UmTDDnfKLwFzbAmtg3E0yH
	kXQMfaOvmGZ0H+ePZbEAl31NCYw10jI935ai7XxVorUQO8wZYbKwtSi4
X-Gm-Gg: ASbGnctOcn5THI8JrY3m6OxUDUfvbwQwUqFGABMhqW7zuUZSidpd8s+dtt5tKPJJIGs
	UuYiuhGNp4TrUDNbUyYP35NblXscN6ZoOYzGOfXbWPIk8JRIKZ4zi84hycazwOOxMr1Bxu2RT0B
	LA43j4kaaiot6FaVs4fWYUVcw8gt4LH8Kph6csG/oGUvWcGUO38+Q6ffisHkVFOg2hhmb5+0MnJ
	8OpKJKCXQJyy9Rs3+jlw5uO5zQby9i+fMcaCUZF5vQ5lRX8wJ5lRwbRezZJfa8OzJiw1B0uFwCG
	/zCUXZVc/52SvhkdV39CNWQaw3xoNgAs+JA4mYIXGcHCUcaTw7vodftNOtewUzdBP+6H0adlo1N
	f9+pN6nbIK27GU7xkqF6v2IIkVTSbYEis
X-Google-Smtp-Source: AGHT+IF/lWU7GJLzDXdk1F2IZNf7VWmrNUNbM5q/vElUar5FDwrpd2kD0dJvfnbrgPtrERVIQruzoA==
X-Received: by 2002:a17:903:94d:b0:234:909b:3dba with SMTP id d9443c01a7336-2366b005fb0mr274698465ad.20.1750295103301;
        Wed, 18 Jun 2025 18:05:03 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dea905fsm108088795ad.166.2025.06.18.18.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 18:05:02 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id CEC31ED6543; Thu, 19 Jun 2025 10:05:00 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 13/13] um: nommu: plug nommu code into build system
Date: Thu, 19 Jun 2025 10:04:17 +0900
Message-ID: <03d0cd2581d0e143a5644df5d42fc00a550fc72a.1750294482.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750294482.git.thehajime@gmail.com>
References: <cover.1750294482.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250618_180503_972911_B421B689 
X-CRM114-Status: GOOD (  13.30  )
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
index f08e8a7fac93..81a79c7a5a6f 100644
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


