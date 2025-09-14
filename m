Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D716CAC582
	for <linux-um@archiver.kernel.org>; Sun, 14 Sep 2025 04:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VsOamTozKEbtevaUIkeHFHddobOLWaVp/WNglpXBTPs=; b=bq1aHOdrMLn+Qkolmb9jmIt2jb
	SAGgRwP/YABIEmBY2yvYlyrp1P8Xmlny3NS4KAW3CXPWUSsGZG2IzAWkVaK/sRKm0akrTfF4DLEm2
	/Kpgxtc1qS1zgymGUJr/kNfWW+Jd/UAnvHsCTJuW8QSmzf4xOSDaKafG1Xujyjgcc04H2nI9263Gz
	5EKljSNGoojvFve3BOnLSgP3S7PGbTrlpqsTG/xI4MOF3JHmiOs7jFpKO6W4BlwJwvhRFTNIsevAf
	/Bf5eyBlXN9C80SqV+vw3F+vldzUXqOOoZ9YG3Z7tK4HDxmlovUMtkOlxD11Lw2Ib0MEpQO2vC0DL
	x0FCOyMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxdxx-0000000HRtG-0GOU;
	Sun, 14 Sep 2025 04:03:53 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxdxv-0000000HRs6-2T2I
	for linux-um@bombadil.infradead.org;
	Sun, 14 Sep 2025 04:03:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=VsOamTozKEbtevaUIkeHFHddobOLWaVp/WNglpXBTPs=; b=FIkrgYhRB9Cm6w4i2mZ1obb11v
	KOVCQi9nxkEXpMlggSI1OG2DSaUdnKVgiWDeuhgQYEXMLuxtuGX/lNYwk3z438uy1AHQWXREPjCt8
	p/yD3GpsYE3/yy6ObvvIphkbOQ0C6Wkg/Yugy+lGBcLPfbZbumV8/E8znwushBnx8WrezJ1y4iokR
	4C0yMMFt1g5UofAhA6ql1XGvfw1UOTjU2wbyY+IKlYd1OgHUaYRcvqB1xW11d1xk0Twrq2g7DYDZx
	TCOKWire7Rvb+plI+JXtUKcwNjzDRF/rocbEXv06F3g/CPtOjDJ5u/z0LxNcn5OOyVh9j5w/8jGps
	XAXxzcbg==;
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxdxr-00000006irn-1lLW
	for linux-um@lists.infradead.org;
	Sun, 14 Sep 2025 04:03:50 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-62f28da25b9so369578a12.1
        for <linux-um@lists.infradead.org>; Sat, 13 Sep 2025 21:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822626; x=1758427426; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsOamTozKEbtevaUIkeHFHddobOLWaVp/WNglpXBTPs=;
        b=FcPMTapXHBCKTHIMF7rJsOsmlJeL4KyDc94FBPvwDrQgHBLQYguCyA6RPr1nF36v36
         0XmAFFpYPLJehB0tQXEJkEH+gQwKLT/jSA2y6EekTlgKHqAqsLDQUj4UtYx5EbEpAevq
         IFWSNtdh6g7wGu47T3tYWT7k8v9YlQx0uTMKsTNWmtZfO03L4K8JbCpPt7ksFPlZ/i+c
         lifgRmYdR6xwDOAEx1avslq5gh9BqCSCx8R2krT1ldXJNqW9jJ3Pt6DCzu/idKa0woT9
         KWiN+a5Dk9wOpbzMWrnskKadSnZCbShTXUTLm4MrbTrEOYKBE5ALVP6q8TNUSydczJFR
         QQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822626; x=1758427426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsOamTozKEbtevaUIkeHFHddobOLWaVp/WNglpXBTPs=;
        b=Txxc45R1ckDBOcr68dDbJFjteTf2waGD6wC9yZbauS4U4hOM1gFbJDEDV2Efq2fLB9
         RxVPHVe6nr1sf9kCWL8obZr6HUhQL6kxvL10CyMujOytd4Bjyn3IR5deG6L0U12MzxtE
         tr1RjYIsuDNlRuv9WO22s9J7ZI4sKie8woNbcPRxc7ownw+kcmR6tZ8UoOAPSYj8Yd5L
         e7XknXKH38tT2tvUBuK0AhRL0BVxdG9Tlkk00Rawvo1oWXDZm3FCPW6ImSkCTPuAYF5I
         CLeZCMw45qAaIK2cIbRAWJXaRWjHTQfWWTEqPz7B44WCt67Ac0srKvs0sFnQEF9d72Ro
         o6lQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI2rqRLa5p7mYrxMHq+QDgDop3tO3z6Od4OuBUJeDjC6w/BfNVvjjW0lGL4OL2/EHC3yfbq1FmYA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwnhZs/OduzB0KF7OT0Qz2Rbr8NJzgWE+oMX0tKfmyY+AbUoI1h
	SrsDhRQh+99odVZptsPuvcX+YIjG7LlLTl5ZNFKL8do4tLPocKGd/gpU
X-Gm-Gg: ASbGnctAW5kByRkCclz6Tez2nu1mqWcEeBBVVlql655j/ngYEUUQ81etVKz4iWcz147
	+0SmRLr2e65ksoDYZw+Ui/QUbj38aLZkNhnVnREuFqdIMh8IFUm2maBNkF4iOQqGGsO9aqitjGP
	MsdSkuF7Ra42pxOnQVpdd8BDLjf4u2JUM39wt8tKkRFkGfVORJgGopGkyMIrYrf7gh1dCYO499K
	TTPLtEkcUKVhtqGzVNzMMGBBiirE9FbhUMFgb4IIV7iy9kkGC5zbkcnOMr6XyKX3O9orTBK300H
	6lZcChjhX3hxN95K7w5EX6qUGBovaFO7bQVCgzPsTpresiooPnIkWkRN2U3OBkW/yG8uA1iAa8i
	kSwuyXL30rL0UgiMm9do=
X-Google-Smtp-Source: AGHT+IGIk0SwDpnTjpBVT7sJgIMOGKNGXW+rOPL9oM2bCvwkhtwd2LPazr69GK44eCdlALX7ivqu/A==
X-Received: by 2002:a05:6402:2341:b0:628:66cd:d839 with SMTP id 4fb4d7f45d1cf-62ed82599aemr7456895a12.7.1757822625662;
        Sat, 13 Sep 2025 21:03:45 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62f2e1d5b5bsm463001a12.3.2025.09.13.21.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 21:03:44 -0700 (PDT)
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
Subject: [PATCH RESEND 60/62] init: rename CONFIG_RD_LZO to CONFIG_INITRAMFS_DECOMPRESS_LZO
Date: Sun, 14 Sep 2025 07:03:39 +0300
Message-ID: <20250914040339.3831241-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250914_050347_672017_D13E989D 
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

Initrd support was removed,
and CONFIG_RD_LZO has nothing to do with ramdisks.

Update your configs

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 arch/arm/configs/aspeed_g4_defconfig       | 2 +-
 arch/arm/configs/aspeed_g5_defconfig       | 2 +-
 arch/arm/configs/lpc18xx_defconfig         | 2 +-
 arch/arm/configs/sp7021_defconfig          | 2 +-
 arch/mips/configs/ath25_defconfig          | 2 +-
 arch/mips/configs/bmips_stb_defconfig      | 2 +-
 arch/openrisc/configs/simple_smp_defconfig | 2 +-
 arch/powerpc/configs/44x/fsp2_defconfig    | 2 +-
 arch/powerpc/configs/skiroot_defconfig     | 2 +-
 arch/riscv/configs/nommu_k210_defconfig    | 2 +-
 arch/riscv/configs/nommu_virt_defconfig    | 2 +-
 arch/sh/configs/sdk7786_defconfig          | 2 +-
 arch/xtensa/configs/cadence_csp_defconfig  | 2 +-
 arch/xtensa/configs/nommu_kc705_defconfig  | 2 +-
 usr/Kconfig                                | 4 ++--
 15 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_g4_defconfig
index af891a2b2d6c..2b22ce99e42d 100644
--- a/arch/arm/configs/aspeed_g4_defconfig
+++ b/arch/arm/configs/aspeed_g4_defconfig
@@ -10,7 +10,7 @@ CONFIG_CGROUPS=y
 CONFIG_NAMESPACES=y
 CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
-# CONFIG_RD_LZO is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
 # CONFIG_RD_LZ4 is not set
 CONFIG_EXPERT=y
 # CONFIG_UID16 is not set
diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index a16aed0abcaa..764fde3d416b 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -10,7 +10,7 @@ CONFIG_CGROUPS=y
 CONFIG_NAMESPACES=y
 CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
-# CONFIG_RD_LZO is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
 # CONFIG_RD_LZ4 is not set
 CONFIG_EXPERT=y
 # CONFIG_UID16 is not set
diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
index 816586530ff5..b14ebbe5b023 100644
--- a/arch/arm/configs/lpc18xx_defconfig
+++ b/arch/arm/configs/lpc18xx_defconfig
@@ -4,7 +4,7 @@ CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
-# CONFIG_RD_LZO is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
 # CONFIG_RD_LZ4 is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_UID16 is not set
diff --git a/arch/arm/configs/sp7021_defconfig b/arch/arm/configs/sp7021_defconfig
index 2d9bbda67e85..e65c94f24341 100644
--- a/arch/arm/configs/sp7021_defconfig
+++ b/arch/arm/configs/sp7021_defconfig
@@ -9,7 +9,7 @@ CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
-# CONFIG_RD_LZO is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
 # CONFIG_RD_LZ4 is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_PERF_EVENTS=y
diff --git a/arch/mips/configs/ath25_defconfig b/arch/mips/configs/ath25_defconfig
index e401b29ce706..baf32dfe8295 100644
--- a/arch/mips/configs/ath25_defconfig
+++ b/arch/mips/configs/ath25_defconfig
@@ -6,7 +6,7 @@ CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_GZIP is not set
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
-# CONFIG_RD_LZO is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
 # CONFIG_RD_LZ4 is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_FHANDLE is not set
diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bmips_stb_defconfig
index 072bfdc87771..44830de10527 100644
--- a/arch/mips/configs/bmips_stb_defconfig
+++ b/arch/mips/configs/bmips_stb_defconfig
@@ -18,7 +18,7 @@ CONFIG_MIPS_O32_FP64_SUPPORT=y
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 CONFIG_INITRAMFS_DECOMPRESS_XZ=y
-# CONFIG_RD_LZO is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
 # CONFIG_RD_LZ4 is not set
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
diff --git a/arch/openrisc/configs/simple_smp_defconfig b/arch/openrisc/configs/simple_smp_defconfig
index 7080bdedea01..9f4bb9d940f0 100644
--- a/arch/openrisc/configs/simple_smp_defconfig
+++ b/arch/openrisc/configs/simple_smp_defconfig
@@ -6,7 +6,7 @@ CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
-# CONFIG_RD_LZO is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
 # CONFIG_RD_LZ4 is not set
 CONFIG_EXPERT=y
 # CONFIG_KALLSYMS is not set
diff --git a/arch/powerpc/configs/44x/fsp2_defconfig b/arch/powerpc/configs/44x/fsp2_defconfig
index ffb345222649..e5e4f6721728 100644
--- a/arch/powerpc/configs/44x/fsp2_defconfig
+++ b/arch/powerpc/configs/44x/fsp2_defconfig
@@ -11,7 +11,7 @@ CONFIG_LOG_BUF_SHIFT=16
 CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
-# CONFIG_RD_LZO is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
 # CONFIG_RD_LZ4 is not set
 CONFIG_KALLSYMS_ALL=y
 CONFIG_BPF_SYSCALL=y
diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
index 008a63a90330..fc1a718af17a 100644
--- a/arch/powerpc/configs/skiroot_defconfig
+++ b/arch/powerpc/configs/skiroot_defconfig
@@ -13,7 +13,7 @@ CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_GZIP is not set
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
-# CONFIG_RD_LZO is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
 # CONFIG_RD_LZ4 is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EXPERT=y
diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
index 10ffb9ea40bd..7507045e9c4a 100644
--- a/arch/riscv/configs/nommu_k210_defconfig
+++ b/arch/riscv/configs/nommu_k210_defconfig
@@ -5,7 +5,7 @@ CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
-# CONFIG_RD_LZO is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
 # CONFIG_RD_LZ4 is not set
 # CONFIG_RD_ZSTD is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/configs/nommu_virt_defconfig
index 9383e3445ead..afa79217f06e 100644
--- a/arch/riscv/configs/nommu_virt_defconfig
+++ b/arch/riscv/configs/nommu_virt_defconfig
@@ -4,7 +4,7 @@ CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
-# CONFIG_RD_LZO is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
 # CONFIG_RD_LZ4 is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EXPERT=y
diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_defconfig
index f19e9915e6de..7465ebf36df2 100644
--- a/arch/sh/configs/sdk7786_defconfig
+++ b/arch/sh/configs/sdk7786_defconfig
@@ -29,7 +29,7 @@ CONFIG_NET_NS=y
 CONFIG_INITRAMFS=y
 CONFIG_INITRAMFS_DECOMPRESS_BZIP2=y
 CONFIG_INITRAMFS_DECOMPRESS_LZMA=y
-CONFIG_RD_LZO=y
+CONFIG_INITRAMFS_DECOMPRESS_LZO=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
 CONFIG_KPROBES=y
diff --git a/arch/xtensa/configs/cadence_csp_defconfig b/arch/xtensa/configs/cadence_csp_defconfig
index f102ed913e9b..dad9383c6deb 100644
--- a/arch/xtensa/configs/cadence_csp_defconfig
+++ b/arch/xtensa/configs/cadence_csp_defconfig
@@ -17,7 +17,7 @@ CONFIG_INITRAMFS_SOURCE="$$KERNEL_INITRAMFS_SOURCE"
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
-# CONFIG_RD_LZO is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
 # CONFIG_RD_LZ4 is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EXPERT=y
diff --git a/arch/xtensa/configs/nommu_kc705_defconfig b/arch/xtensa/configs/nommu_kc705_defconfig
index d3916408eaf6..0a0e94ae7b1c 100644
--- a/arch/xtensa/configs/nommu_kc705_defconfig
+++ b/arch/xtensa/configs/nommu_kc705_defconfig
@@ -18,7 +18,7 @@ CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
-# CONFIG_RD_LZO is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
 # CONFIG_RD_LZ4 is not set
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
diff --git a/usr/Kconfig b/usr/Kconfig
index 69f95a5a1847..62c978018565 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -84,7 +84,7 @@ config INITRAMFS_DECOMPRESS_XZ
 	  Support loading of a XZ encoded initial ramfs.
 	  If unsure, say N.
 
-config RD_LZO
+config INITRAMFS_DECOMPRESS_LZO
 	bool "Support initial ramfs compressed using LZO"
 	default y
 	select DECOMPRESS_LZO
@@ -183,7 +183,7 @@ config INITRAMFS_COMPRESSION_XZ
 
 config INITRAMFS_COMPRESSION_LZO
 	bool "LZO"
-	depends on RD_LZO
+	depends on INITRAMFS_DECOMPRESS_LZO
 	help
 	  Its compression ratio is the second poorest amongst the choices. The
 	  kernel size is about 10% bigger than gzip. Despite that, its
-- 
2.47.2


