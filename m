Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48071CAC582
	for <linux-um@archiver.kernel.org>; Sat, 13 Sep 2025 00:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MdGbmKxqlcMl0rLfzu7p7wshkZ7f+lqXVhPxNRPgNLM=; b=XambVpxLlf72sl394NCQwpiWiB
	hCQ9CbhAHak8/uzoaDHbbpJJtglWFY3RNnfn3OIkEzaJGqN4YwEed9LqjgkYX7xlMWTYn43rA7YPi
	etKD+ohzGLb+PkflC+cvuHarJ6bPL8yVGcng5+PN4GSQDXRFaASwrCto9NRb+QyRyZA9LOsK23wje
	4v/fPHmXCtqzONqd8vgPS2zfo9ZC2lwxQ/N7TMoAZx7/e9qRPclTNKUpUvKkOU+Qg+CcmOaf4QwB7
	t4GOwNj+wKTsFfcJMIbExOtnYLt9RnwVQqpje9nLQNun7eN2oF3zMKHKh5pgY4WiabVrvPYv9X0gt
	rfxl89cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxEUq-0000000CQUA-01Z2;
	Sat, 13 Sep 2025 00:52:08 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxEUm-0000000CQRK-2Bbi
	for linux-um@lists.infradead.org;
	Sat, 13 Sep 2025 00:52:06 +0000
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-b0418f6fc27so429552666b.3
        for <linux-um@lists.infradead.org>; Fri, 12 Sep 2025 17:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757724723; x=1758329523; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdGbmKxqlcMl0rLfzu7p7wshkZ7f+lqXVhPxNRPgNLM=;
        b=LWJEPJWNg6+MJVu5KgFTMaI/k9WvgodQJLiTZPyO/yTvgEh88nxa6BlIcqI3qE3GBv
         yPfGw0W4S1sZmDmQZ9TgNtUw6tSGn7wXHgwm/tMV6lzTqXhIsDIqqP0FMANtO1mSZ0LC
         ny68YBgtfgc6j7Lt3qbvZCjNLoH/S0yjm8Vm1+JBS5TSi7INkG0ouvSpTTy4UJYNnywE
         o3SlR7VU4Hd8aSqYl2DiL0rV1DUtcyT92VxK30olHGIOO2t1IAWrZRqGAvr3AhgPaxHx
         yR25DRo01DZZqwhw8MDYar7JCkW6LtA3PXazV4ySD76gTVEBF13sYrUCDXcAxMqTPyP3
         HnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757724723; x=1758329523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdGbmKxqlcMl0rLfzu7p7wshkZ7f+lqXVhPxNRPgNLM=;
        b=F5Pj4GOwhCfoSD/BUE94iqdyzaT5pdYAWkEcb78NsKQPbjDzWSx+5EhN01zrWC+lTc
         j5x0zky4awE7PjLS8PpYHIRi0JboJgf4cUstFqSStVYIh585ZzU/15JH2BXk4+A+TaHy
         rUZknOqJG9ROL8feXABKWGhX1fS9I1r7e2gK3M8Zsb+IBbvzlQ31+neufxaDNW8Z2LlU
         +MWSl9uYxGHqkig5XJkG99982U1rb50awhIfC8cs80whu97/SGNpIERe1PmCtT0p/UB8
         9jOQzfakaIHwpBiMj4i2AAn7LCwUOwflA/04QOoICQuMkqoKBTJqZH/Z+E70RDmKqBLy
         H5qw==
X-Forwarded-Encrypted: i=1; AJvYcCXjYH9pJojTGcZA69Qzoo07A22JrcqIrmgKgnbdrtMtYMWCwz6XiLSLSmw1xrugKZbFCtNSiT9zPg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwRrJoY0Zcb3dGaUp1CkUWBOBm0m+Fm/BKAL1uGnQaL9XU1PEs4
	3Dw+Me6TEW/oiYxdwEOUJRBRb1bwON7ymiuPLhtExSmmLes6rsSF5Zxh
X-Gm-Gg: ASbGncvB48f3XeE8PNKxF3TKO0FSMYUZveXy1CNXGZ3An566OsSk4FvCbknnPNE7rqc
	XFs1PVdk8aN91SZ1TCcBqo8veMLODb6GdeRtWK1Odaq/oMlPNQDkireYDPqD0MgtKaT0i4/Iynn
	+mfkV/roH7iI1r3h76+F5/xF0LCrGfWFSTJ/YgkiSBr1S5AKySrspD6SJggPml5Kx1z2ZD65Bdw
	r9lV7OeQGs/tuL30dSO0iDRNzwsEptYUOEZKbXFSukYw4Tx0xoelhweJDtaDc7WITY7F4qrE8Qd
	a8821qC11X9aWsd7nk2ZkBB5vXKZbhM3/baPDpQcgeJ23E1BfOr99PrlLDg/iqXLkRS6RISgopZ
	Z7HlE/265zOA574JnsbufpTEIl4SpsQ==
X-Google-Smtp-Source: AGHT+IEOxv4u1csoR3Asex+KK1PngLg51+/kQQMoUV5EwO+MoxI2Yose6oae6R3weUM2rN4atBIYiQ==
X-Received: by 2002:a17:907:9801:b0:afe:6c9b:c828 with SMTP id a640c23a62f3a-b07c37b8165mr442852966b.61.1757724722473;
        Fri, 12 Sep 2025 17:52:02 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b08cab32303sm25787366b.72.2025.09.12.17.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:52:02 -0700 (PDT)
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
Subject: [PATCH RESEND 11/62] init, efi: remove "noinitrd" command line parameter
Date: Sat, 13 Sep 2025 00:37:50 +0000
Message-ID: <20250913003842.41944-12-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250912_175204_595973_C1A1DB87 
X-CRM114-Status: GOOD (  14.95  )
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

It was inconsistent before initrd removal: it mostly
controlled initrd only, but in EFI stub boot mode
it controlled both initrd and initramfs

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 ---
 arch/arm/configs/collie_defconfig               | 2 +-
 arch/arm/configs/imx_v6_v7_defconfig            | 2 +-
 arch/arm/configs/neponset_defconfig             | 2 +-
 arch/arm/configs/spitz_defconfig                | 2 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c  | 5 +----
 init/do_mounts_initrd.c                         | 9 ---------
 7 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 07e8878f1e13..ad52e3d26014 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4271,9 +4271,6 @@
 			Note that this argument takes precedence over
 			the CONFIG_RCU_NOCB_CPU_DEFAULT_ALL option.
 
-	noinitrd	[RAM] Tells the kernel not to load any configured
-			initial RAM disk.
-
 	nointremap	[X86-64,Intel-IOMMU,EARLY] Do not enable interrupt
 			remapping.
 			[Deprecated - use intremap=off]
diff --git a/arch/arm/configs/collie_defconfig b/arch/arm/configs/collie_defconfig
index 578c6a4af620..00dc8ae22824 100644
--- a/arch/arm/configs/collie_defconfig
+++ b/arch/arm/configs/collie_defconfig
@@ -9,7 +9,7 @@ CONFIG_ARCH_MULTI_V4=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_COLLIE=y
-CONFIG_CMDLINE="noinitrd root=/dev/mtdblock2 rootfstype=jffs2 fbcon=rotate:1"
+CONFIG_CMDLINE="root=/dev/mtdblock2 rootfstype=jffs2 fbcon=rotate:1"
 CONFIG_FPE_NWFPE=y
 CONFIG_PM=y
 # CONFIG_SWAP is not set
diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 9a57763a8d38..b53ae2c052fc 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -32,7 +32,7 @@ CONFIG_SMP=y
 CONFIG_ARM_PSCI=y
 CONFIG_HIGHMEM=y
 CONFIG_ARCH_FORCE_MAX_ORDER=13
-CONFIG_CMDLINE="noinitrd console=ttymxc0,115200"
+CONFIG_CMDLINE="console=ttymxc0,115200"
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
diff --git a/arch/arm/configs/neponset_defconfig b/arch/arm/configs/neponset_defconfig
index 4d720001c12e..a61eb27373a8 100644
--- a/arch/arm/configs/neponset_defconfig
+++ b/arch/arm/configs/neponset_defconfig
@@ -9,7 +9,7 @@ CONFIG_ASSABET_NEPONSET=y
 CONFIG_ZBOOT_ROM_TEXT=0x80000
 CONFIG_ZBOOT_ROM_BSS=0xc1000000
 CONFIG_ZBOOT_ROM=y
-CONFIG_CMDLINE="console=ttySA0,38400n8 cpufreq=221200 rw root=/dev/mtdblock2 mtdparts=sa1100:512K(boot),1M(kernel),2560K(initrd),4M(root) mem=32M noinitrd initrd=0xc0800000,3M"
+CONFIG_CMDLINE="console=ttySA0,38400n8 cpufreq=221200 rw root=/dev/mtdblock2 mtdparts=sa1100:512K(boot),1M(kernel),2560K(initrd),4M(root) mem=32M initrd=0xc0800000,3M"
 CONFIG_FPE_NWFPE=y
 CONFIG_PM=y
 CONFIG_MODULES=y
diff --git a/arch/arm/configs/spitz_defconfig b/arch/arm/configs/spitz_defconfig
index ac2a0f998c73..8582b6f2cf9d 100644
--- a/arch/arm/configs/spitz_defconfig
+++ b/arch/arm/configs/spitz_defconfig
@@ -10,7 +10,7 @@ CONFIG_ARCH_PXA=y
 CONFIG_PXA_SHARPSL=y
 CONFIG_MACH_AKITA=y
 CONFIG_MACH_BORZOI=y
-CONFIG_CMDLINE="console=ttyS0,115200n8 console=tty1 noinitrd root=/dev/mtdblock2 rootfstype=jffs2   debug"
+CONFIG_CMDLINE="console=ttyS0,115200n8 console=tty1 root=/dev/mtdblock2 rootfstype=jffs2   debug"
 CONFIG_FPE_NWFPE=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 7aa2f9ad2935..6d89bf941d57 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -21,7 +21,6 @@ bool efi_nochunk;
 bool efi_nokaslr = !IS_ENABLED(CONFIG_RANDOMIZE_BASE);
 bool efi_novamap;
 
-static bool efi_noinitrd;
 static bool efi_nosoftreserve;
 static bool efi_disable_pci_dma = IS_ENABLED(CONFIG_EFI_DISABLE_PCI_DMA);
 
@@ -75,8 +74,6 @@ efi_status_t efi_parse_options(char const *cmdline)
 			efi_nokaslr = true;
 		} else if (!strcmp(param, "quiet")) {
 			efi_loglevel = CONSOLE_LOGLEVEL_QUIET;
-		} else if (!strcmp(param, "noinitrd")) {
-			efi_noinitrd = true;
 		} else if (IS_ENABLED(CONFIG_X86_64) && !strcmp(param, "no5lvl")) {
 			efi_no5lvl = true;
 		} else if (IS_ENABLED(CONFIG_ARCH_HAS_MEM_ENCRYPT) &&
@@ -614,7 +611,7 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 	efi_status_t status = EFI_SUCCESS;
 	struct linux_efi_initrd initrd, *tbl;
 
-	if (!IS_ENABLED(CONFIG_BLK_DEV_INITRD) || efi_noinitrd)
+	if (!IS_ENABLED(CONFIG_BLK_DEV_INITRD))
 		return EFI_SUCCESS;
 
 	status = efi_load_initrd_dev_path(&initrd, hard_limit);
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 308744254c08..bec1c5d684a3 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -15,7 +15,6 @@
 unsigned long initrd_start, initrd_end;
 int initrd_below_start_ok;
 static unsigned int real_root_dev;	/* do_proc_dointvec cannot handle kdev_t */
-static int __initdata mount_initrd = 1;
 
 phys_addr_t phys_initrd_start __initdata;
 unsigned long phys_initrd_size __initdata;
@@ -39,14 +38,6 @@ static __init int kernel_do_mounts_initrd_sysctls_init(void)
 late_initcall(kernel_do_mounts_initrd_sysctls_init);
 #endif /* CONFIG_SYSCTL */
 
-static int __init no_initrd(char *str)
-{
-	mount_initrd = 0;
-	return 1;
-}
-
-__setup("noinitrd", no_initrd);
-
 static int __init early_initrdmem(char *p)
 {
 	phys_addr_t start;
-- 
2.47.2


