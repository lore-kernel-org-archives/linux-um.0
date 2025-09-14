Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6CBCAC582
	for <linux-um@archiver.kernel.org>; Sun, 14 Sep 2025 04:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zQmt9Zed9iIletHUt2qeYNjKhIuvjCTi/Cw19xUj63o=; b=dEW63+nXwgRC4kuoGVKdSmINqz
	M9m9eUEwPvddsxN/sJn8ZyHkTYloSEl3iPfXRlC+HwegpYL9lmvPPBJ6RPHBxRJcSfRNL3MLBk+24
	L9QluJBCeF76g9iXv9YDwPi7zvmwWkUymyZ179miQ2XpFeoNeW0gIvlISP3G3gKTTVwsryXZazCJ7
	Qz4c2zHDR/ZeYX2zVfMSRUeERnu6uLgrz83I45JLPoaBCHEPENKZ6QEcsLlyq1P3JVV5yVZNP8ASt
	EAdAA7zs62N1OumYX+lliTKLWYukLPiR1cZNtBZV476pg3kSKD/1w2pyT87kdGIrGGhhjNlQqRK4E
	9ZOnWLDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxdyc-0000000HSEH-1U0Q;
	Sun, 14 Sep 2025 04:04:34 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxdya-0000000HSCo-0rRB
	for linux-um@bombadil.infradead.org;
	Sun, 14 Sep 2025 04:04:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=zQmt9Zed9iIletHUt2qeYNjKhIuvjCTi/Cw19xUj63o=; b=k6w8KO9wwjH52DRnU/qVAfTqdp
	KTHNxQygp0Q8RG+nDu9vAOBQxconrGizctJSkg0nDFT/95SF93wYlYbP+aDedY9FBX4mE2EQamVdt
	8xo6ZZ1UJjTCr4hqGGXf6I8BEL4cHzZyt8mheZqV9fYxi2OIHUc/LISBfwbj2OQ9GpHQaw+OYXTD7
	LXQUE3RpfBDa0RuoBql7GcxjxNsKJ+eyI0vhXsg7sHfoejQibMsEU3nZxrF5N9BhPaNJAeuu99E+n
	WqDrWfYwc67gBXYELqUrR2gFWd4B9pyRjDFyc1V45AsNMDd+gD1Rv8Va8YbmxohNZcUCk8djGTtz5
	VIJJlW6w==;
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxdyQ-00000006ixj-2wrc
	for linux-um@lists.infradead.org;
	Sun, 14 Sep 2025 04:04:24 +0000
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-b07c28f390eso368882666b.2
        for <linux-um@lists.infradead.org>; Sat, 13 Sep 2025 21:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822661; x=1758427461; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQmt9Zed9iIletHUt2qeYNjKhIuvjCTi/Cw19xUj63o=;
        b=EvmMZ7jwOHZHnk2RQIud6Z9AlQDAIWUHn/cmGwebuXl2w2bur82A0OOOtAdOcB2BfG
         tt0gtKrlzdxoxD/BmRqbZYXPn2wWwufoP8d4zafpVVbaNvYAUhu7iKOlysca5xUKYJXy
         gpvFbD0M2zMIizpsZtuO46VpcH/NRuid7eOQwcCUotBuNzdNHNLJvU5F/P5koqkPfnic
         jnhxdM5DI5gAbRKm3XAZEqUCuLdGD6X4s1K1Aq6qZEzJMESFktwIv2EHT7u/R8EGEazP
         gbC6giP7j3scvwMx4+nFPm45MCAQGDvg8kEQ0wxdhUdp0uNmuksbUQAsJFExZNcHhHf4
         jTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822661; x=1758427461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQmt9Zed9iIletHUt2qeYNjKhIuvjCTi/Cw19xUj63o=;
        b=mALUTBtOwBKfzMA8w4hFqCzRMf7JtJihzWDVctsyA6rUYFDbYtVbQQFWdvB/UUwXwS
         Oi48I/foxl/vK0kFwM9uhiKt479XnJ5ujQn6ATXIbGQZqoSO3N7KPRgp1ISy0KHc6Iho
         FwfZObOgYUONJi7l3kTYDiDYujb1slx9fOlAVCCFS9jOPrRiXm2QYNQYJL19/zcWegXE
         JXUnCQx45aoEStvQqXo/gdBKvg2ixAPKwIQzrbtmICmtSgWhNNVPWUdvvA9hMTZfdTEe
         h9+jaq0uvd8cCtzWgE6ik1BMfC60ntQ6qWTrqfb7OITscfMVvzfRFnIq8LjDkZphSILy
         8USg==
X-Forwarded-Encrypted: i=1; AJvYcCXN2Qb7SYFXt0V8DFHsAMNbYn+ss+RAtdkWBkB37FHSgo3IrSTTMcvuFAvHE4VqqhjUHIXy3kLAJg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz6PWVZLXS4caVMEMsPTUoSpyulKn1so09FMo4f4t6mK/yW53xK
	ALbsvyssxsJsky+ZkNsp8RKl2dL9aAh1qL7pGyVLf2hAskJj8qRL+5gl
X-Gm-Gg: ASbGncujTIXl3rjpbL5J6b0RhXFXRbkqOkWHRffqsdqGcsmoWlcCsecNcnNyatwF62I
	yr8ZDEJOk2WGDBTMpkl9MUFiBRuQgDLed2I/hW2e3ieqoYV8lLLiC2+D3bg/ObSRuwHj/Yi4ut9
	2IkScSsX4+dAH3ZH5LquOjbpMhvETz79NVtfCfM8zK1Y43tdf7jl15K2NrOp+LBSmIXeWKfSGov
	IV/lK7l0tigmOcFX47E+o/ngijpoUCw2913dI5KY2dDOkFrEkx0/xHB5PFyqtZTu0921IA05GSN
	V9aJ3TBpYdl5nXZOivHIKdGE/bfAouogTTn1nlB1k8J7Y1PYdVtaukGqw9hthFBwlEfMS+wDB6/
	yT7U1yorwfK/pOk0XHmkOaPeO56Q5mw==
X-Google-Smtp-Source: AGHT+IHaFT6KFwuX+yIp0UoOdQj6J/d/IOTebo0H4gG0vMFBsMmT50PoMXVLJ+eEN7aUH8ZQwvBwiA==
X-Received: by 2002:a17:907:3ea6:b0:b09:48c6:b7b0 with SMTP id a640c23a62f3a-b0948c6c713mr431888166b.56.1757822661177;
        Sat, 13 Sep 2025 21:04:21 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32dd57csm669318166b.52.2025.09.13.21.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 21:04:20 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Curtin <ecurtin@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	patches@lists.linux.dev
Subject: [PATCH RESEND 61/62] init: rename CONFIG_RD_LZ4 to CONFIG_INITRAMFS_DECOMPRESS_LZ4
Date: Sun, 14 Sep 2025 07:04:15 +0300
Message-ID: <20250914040416.3840072-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250914_050423_049799_20D93412 
X-CRM114-Status: GOOD (  12.08  )
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

Initrd support was removed,
and CONFIG_RD_LZ4 has nothing to do with ramdisks.

Update your configs

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 arch/arm/configs/aspeed_g4_defconfig       | 2 +-
 arch/arm/configs/aspeed_g5_defconfig       | 2 +-
 arch/arm/configs/lpc18xx_defconfig         | 2 +-
 arch/arm/configs/sp7021_defconfig          | 2 +-
 arch/arm/configs/vf610m4_defconfig         | 2 +-
 arch/mips/configs/ath25_defconfig          | 2 +-
 arch/mips/configs/bmips_stb_defconfig      | 2 +-
 arch/openrisc/configs/simple_smp_defconfig | 2 +-
 arch/powerpc/configs/44x/fsp2_defconfig    | 2 +-
 arch/powerpc/configs/skiroot_defconfig     | 2 +-
 arch/riscv/configs/nommu_k210_defconfig    | 2 +-
 arch/riscv/configs/nommu_virt_defconfig    | 2 +-
 arch/xtensa/configs/cadence_csp_defconfig  | 2 +-
 arch/xtensa/configs/nommu_kc705_defconfig  | 2 +-
 usr/Kconfig                                | 4 ++--
 15 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_g4_defconfig
index 2b22ce99e42d..a65bdc6e6c2f 100644
--- a/arch/arm/configs/aspeed_g4_defconfig
+++ b/arch/arm/configs/aspeed_g4_defconfig
@@ -11,7 +11,7 @@ CONFIG_NAMESPACES=y
 CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
-# CONFIG_RD_LZ4 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
 CONFIG_EXPERT=y
 # CONFIG_UID16 is not set
 # CONFIG_SYSFS_SYSCALL is not set
diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index 764fde3d416b..24954645c34f 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -11,7 +11,7 @@ CONFIG_NAMESPACES=y
 CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
-# CONFIG_RD_LZ4 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
 CONFIG_EXPERT=y
 # CONFIG_UID16 is not set
 # CONFIG_SYSFS_SYSCALL is not set
diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
index b14ebbe5b023..4dee6346a6a8 100644
--- a/arch/arm/configs/lpc18xx_defconfig
+++ b/arch/arm/configs/lpc18xx_defconfig
@@ -5,7 +5,7 @@ CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
-# CONFIG_RD_LZ4 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_UID16 is not set
 CONFIG_BASE_SMALL=y
diff --git a/arch/arm/configs/sp7021_defconfig b/arch/arm/configs/sp7021_defconfig
index e65c94f24341..6b1166cbf478 100644
--- a/arch/arm/configs/sp7021_defconfig
+++ b/arch/arm/configs/sp7021_defconfig
@@ -10,7 +10,7 @@ CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
-# CONFIG_RD_LZ4 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_PERF_EVENTS=y
 CONFIG_ARCH_SUNPLUS=y
diff --git a/arch/arm/configs/vf610m4_defconfig b/arch/arm/configs/vf610m4_defconfig
index 7d457a196dfc..acec039e2f16 100644
--- a/arch/arm/configs/vf610m4_defconfig
+++ b/arch/arm/configs/vf610m4_defconfig
@@ -3,7 +3,7 @@ CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
-# CONFIG_RD_LZ4 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 # CONFIG_MMU is not set
diff --git a/arch/mips/configs/ath25_defconfig b/arch/mips/configs/ath25_defconfig
index baf32dfe8295..5e84ee24e372 100644
--- a/arch/mips/configs/ath25_defconfig
+++ b/arch/mips/configs/ath25_defconfig
@@ -7,7 +7,7 @@ CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
-# CONFIG_RD_LZ4 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_FHANDLE is not set
 # CONFIG_AIO is not set
diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bmips_stb_defconfig
index 44830de10527..b5fb138bf237 100644
--- a/arch/mips/configs/bmips_stb_defconfig
+++ b/arch/mips/configs/bmips_stb_defconfig
@@ -19,7 +19,7 @@ CONFIG_MIPS_O32_FP64_SUPPORT=y
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 CONFIG_INITRAMFS_DECOMPRESS_XZ=y
 # CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
-# CONFIG_RD_LZ4 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_PCIEASPM_POWERSAVE=y
diff --git a/arch/openrisc/configs/simple_smp_defconfig b/arch/openrisc/configs/simple_smp_defconfig
index 9f4bb9d940f0..5265f6f940a5 100644
--- a/arch/openrisc/configs/simple_smp_defconfig
+++ b/arch/openrisc/configs/simple_smp_defconfig
@@ -7,7 +7,7 @@ CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
-# CONFIG_RD_LZ4 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
 CONFIG_EXPERT=y
 # CONFIG_KALLSYMS is not set
 # CONFIG_EPOLL is not set
diff --git a/arch/powerpc/configs/44x/fsp2_defconfig b/arch/powerpc/configs/44x/fsp2_defconfig
index e5e4f6721728..34486aa5155f 100644
--- a/arch/powerpc/configs/44x/fsp2_defconfig
+++ b/arch/powerpc/configs/44x/fsp2_defconfig
@@ -12,7 +12,7 @@ CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
-# CONFIG_RD_LZ4 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
 CONFIG_KALLSYMS_ALL=y
 CONFIG_BPF_SYSCALL=y
 CONFIG_EXPERT=y
diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
index fc1a718af17a..d159882484f6 100644
--- a/arch/powerpc/configs/skiroot_defconfig
+++ b/arch/powerpc/configs/skiroot_defconfig
@@ -14,7 +14,7 @@ CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
-# CONFIG_RD_LZ4 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EXPERT=y
 # CONFIG_SGETMASK_SYSCALL is not set
diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
index 7507045e9c4a..6e961256a941 100644
--- a/arch/riscv/configs/nommu_k210_defconfig
+++ b/arch/riscv/configs/nommu_k210_defconfig
@@ -6,7 +6,7 @@ CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
-# CONFIG_RD_LZ4 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
 # CONFIG_RD_ZSTD is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_SYSFS_SYSCALL is not set
diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/configs/nommu_virt_defconfig
index afa79217f06e..eb289c44dfc3 100644
--- a/arch/riscv/configs/nommu_virt_defconfig
+++ b/arch/riscv/configs/nommu_virt_defconfig
@@ -5,7 +5,7 @@ CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
-# CONFIG_RD_LZ4 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EXPERT=y
 # CONFIG_SYSFS_SYSCALL is not set
diff --git a/arch/xtensa/configs/cadence_csp_defconfig b/arch/xtensa/configs/cadence_csp_defconfig
index dad9383c6deb..26a4a9f3886a 100644
--- a/arch/xtensa/configs/cadence_csp_defconfig
+++ b/arch/xtensa/configs/cadence_csp_defconfig
@@ -18,7 +18,7 @@ CONFIG_INITRAMFS_SOURCE="$$KERNEL_INITRAMFS_SOURCE"
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
-# CONFIG_RD_LZ4 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EXPERT=y
 CONFIG_PROFILING=y
diff --git a/arch/xtensa/configs/nommu_kc705_defconfig b/arch/xtensa/configs/nommu_kc705_defconfig
index 0a0e94ae7b1c..988998806661 100644
--- a/arch/xtensa/configs/nommu_kc705_defconfig
+++ b/arch/xtensa/configs/nommu_kc705_defconfig
@@ -19,7 +19,7 @@ CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
-# CONFIG_RD_LZ4 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_PERF_EVENTS=y
diff --git a/usr/Kconfig b/usr/Kconfig
index 62c978018565..3a891a0c9ef4 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -92,7 +92,7 @@ config INITRAMFS_DECOMPRESS_LZO
 	  Support loading of a LZO encoded initial ramfs.
 	  If unsure, say N.
 
-config RD_LZ4
+config INITRAMFS_DECOMPRESS_LZ4
 	bool "Support initial ramfs compressed using LZ4"
 	default y
 	select DECOMPRESS_LZ4
@@ -195,7 +195,7 @@ config INITRAMFS_COMPRESSION_LZO
 
 config INITRAMFS_COMPRESSION_LZ4
 	bool "LZ4"
-	depends on RD_LZ4
+	depends on INITRAMFS_DECOMPRESS_LZ4
 	help
 	  It's compression ratio is the poorest amongst the choices. The kernel
 	  size is about 15% bigger than gzip; however its decompression speed
-- 
2.47.2


