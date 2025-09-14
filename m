Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054C4CAC582
	for <linux-um@archiver.kernel.org>; Sun, 14 Sep 2025 03:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wOmwD5NF6m1DAFdekL887975d4wKOOnVQzHmGUBheo0=; b=H1t6soaIpKad5DIgMaAE++IUsK
	miO2/favqFttcrPC9q16sD/lSE77fVlH1bijJ3Z9bru02B9ron088KXzaGwaXyQHJmey4sU0hPcds
	q6PiVl/fis+7Y9vrrJnpVnNzKer/fTOY9xa6iK1lg4pVPXy7DWyyWDm0ykf2pBfTx0zVgVQyUNoZd
	KG5EDNJmNLt3o6Mx6bpZpYAp8px3yQYlq5sHmKXn0lUf4l20jOwNwNWR6rEcjpAqNxi71igweNueF
	x0a+tx/1d/ct1vsdGOS86MbDJpfZAQfN0DNDxF/kzbiKBWgqorJiODhC+vSP8EvSVlA/O/5zP5y0S
	d5ZMfQfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxdpj-0000000HNi1-23dc;
	Sun, 14 Sep 2025 03:55:23 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxdph-0000000HNgJ-3QOU
	for linux-um@lists.infradead.org;
	Sun, 14 Sep 2025 03:55:22 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-62f1987d53aso717743a12.0
        for <linux-um@lists.infradead.org>; Sat, 13 Sep 2025 20:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822120; x=1758426920; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOmwD5NF6m1DAFdekL887975d4wKOOnVQzHmGUBheo0=;
        b=kcadL6RFu2Li2Y0NZlRw9ENx0cZYV4e4C3753TIh7ai3YceZpu1Fhk1lVUslkGBrJm
         H1jAEnIiqoGAV0Jz7u13EtrlZq1+IVtAzhpJ80uqo2SviMADlDZsxX6hHFhfDOU1GTT7
         AZKmu8g1nbCaTDQ/iiu9oU9pURWUu2z040L+6xBNEEIHdIpl74/qu0N6StY2rdfSQGdR
         /DrS6eSSF9KZBDY7mG8uc0V+dzUt0pO9Sw43wsDHFmNlswvq7uWLXHToZdiyPKxQsuOm
         uqGXowmegTB66ujUw5XlkDTxcShYuavK6FHsbYchQQTCLjcZh5iu179OFMzODLK6cOGq
         83lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822120; x=1758426920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOmwD5NF6m1DAFdekL887975d4wKOOnVQzHmGUBheo0=;
        b=UsUKn/SYuzHlc1Nhi86xuGkhxy8O9U3MoJJsH2i8/LGARkZSPz7gELpXEBR6hwXcoQ
         z/hbP//3n2UnXNl9E5W3Bzt0E9jMdGvtA2buHYJzuj05zn4RpomtQq4hx2VvEDf7xEeo
         MTj1JZ+KFTRG+sm2wPF4cdY5OfIay0ecR96nWn61xM9yeHn1XFUTuzQvMssF7WVV9P0R
         OX0NFhGR6woO/Aye1ojdQtMoSiORZ8Aj3KsS5voNbdo+jVvl/7PygiRNVoPfRutZznH1
         J5SRRGDoR6RCeV52lQygu1VD2dK29I+VUVpao1rqv11DXQnFhHLs9NRFp7L6fcSYHlY/
         wx0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKIUmPRMTaXWX5V7aEtd7HOfgn76pMU86vz0o//aVWnXxgoXdAcTrpiGuI4IPsgItMMCZcd56shw==@lists.infradead.org
X-Gm-Message-State: AOJu0YydDlQkPBZrqWiUQOPdSXadA+BWEMvOOYZxo54V+/txPHuC4DHM
	0mlW17bj5X7VGPnhVhoA5JZa1UyBwjxmQnndyFNhPazCZdCya+LFwHbj
X-Gm-Gg: ASbGnctIUjs3y1/J6fd6aVP29BPEWVk7L1B8cS43MeKb5uAQ4xzYoVTgOYP6glzzvF9
	nDZORZIb5vj0ipP0pwtx+vHp3JKI+N60vBVaavCag0HTIJfDwrcaK6B8HkOgdrlWXQIDgtI52RE
	cLb4lm55CsFOEkAdWWkUjh3h5/4vR285/fsu7UeM/FtxaZsCEVWQ59F/NTeua8nl1SMmUBJgUtZ
	07WR5Oegw2c6Urwn8HiQgXPNupFapJA1s/7B3QneqzVPA2M7x413oEFKlpBTIyRmimO0qO6lQvm
	0KYnGoHCYU4hcs0W4K7Ayx0kHEKbQUyI5hOWwvsBu13OQQbP2VqpLI0fMj/whObYUMBvD1ZsMhn
	5+o9pFXe4QA69frvRsy8=
X-Google-Smtp-Source: AGHT+IFVXahsOiekrkN9a/Uz4eTnqleIeXBA7XQN4UsGQJ/USlX1vtxhVK0N6asLg1FonCbVUR1qZQ==
X-Received: by 2002:a05:6402:44d2:b0:61b:ff85:398b with SMTP id 4fb4d7f45d1cf-62ed80ee786mr6900890a12.14.1757822119812;
        Sat, 13 Sep 2025 20:55:19 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62ec2e661a5sm6313404a12.0.2025.09.13.20.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:55:18 -0700 (PDT)
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
Subject: [PATCH RESEND 46/62] init: edit docs for initramfs-related configs
Date: Sun, 14 Sep 2025 06:55:13 +0300
Message-ID: <20250914035513.3694090-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250913_205521_901957_6833C91F 
X-CRM114-Status: GOOD (  24.59  )
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

This is cleanup after initrd removal

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 drivers/block/Kconfig |  7 ++-----
 init/Kconfig          | 18 +++++++-----------
 usr/Kconfig           | 42 +++++++++++++++++++++---------------------
 3 files changed, 30 insertions(+), 37 deletions(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 8cf06e40f61c..a268ac3dd304 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -225,9 +225,7 @@ config BLK_DEV_RAM
 	  Saying Y here will allow you to use a portion of your RAM memory as
 	  a block device, so that you can make file systems on it, read and
 	  write to it and do all the other things that you can do with normal
-	  block devices (such as hard drives). It is usually used to load and
-	  store a copy of a minimal root file system off of a floppy into RAM
-	  during the initial install of Linux.
+	  block devices (such as hard drives).
 
 	  For details, read <file:Documentation/admin-guide/blockdev/ramdisk.rst>.
 
@@ -244,8 +242,7 @@ config BLK_DEV_RAM_COUNT
 	depends on BLK_DEV_RAM
 	help
 	  The default value is 16 RAM disks. Change this if you know what you
-	  are doing. If you boot from a filesystem that needs to be extracted
-	  in memory, you will need at least one RAM disk (e.g. root on cramfs).
+	  are doing.
 
 config BLK_DEV_RAM_SIZE
 	int "Default RAM disk size (kbytes)"
diff --git a/init/Kconfig b/init/Kconfig
index 0263c08960bc..1c371dca7fd4 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1435,18 +1435,14 @@ config RELAY
 	  If unsure, say N.
 
 config BLK_DEV_INITRD
-	bool "Initial RAM filesystem and RAM disk (initramfs/initrd) support"
+	bool "Initial RAM filesystem (initramfs) support"
 	help
-	  The initial RAM filesystem is a ramfs which is loaded by the
-	  boot loader (loadlin or lilo) and that is mounted as root
+	  The initial RAM filesystem is a ramfs or tmpfs which is loaded by the
+	  boot loader and that is mounted as root
 	  before the normal boot procedure. It is typically used to
 	  load modules needed to mount the "real" root file system,
 	  etc. See <file:Documentation/filesystems/ramfs-rootfs-initramfs.rst> for details.
 
-	  If RAM disk support (BLK_DEV_RAM) is also included, this
-	  also enables initial RAM disk (initrd) support and adds
-	  15 Kbytes (more on some other architectures) to the kernel size.
-
 	  If unsure say Y.
 
 if BLK_DEV_INITRD
@@ -1485,8 +1481,8 @@ config BOOT_CONFIG_EMBED
 	depends on BOOT_CONFIG
 	help
 	  Embed a bootconfig file given by BOOT_CONFIG_EMBED_FILE in the
-	  kernel. Usually, the bootconfig file is loaded with the initrd
-	  image. But if the system doesn't support initrd, this option will
+	  kernel. Usually, the bootconfig file is loaded with the initramfs.
+	  But if the system doesn't support initramfs, this option will
 	  help you by embedding a bootconfig file while building the kernel.
 
 	  If unsure, say N.
@@ -1496,8 +1492,8 @@ config BOOT_CONFIG_EMBED_FILE
 	depends on BOOT_CONFIG_EMBED
 	help
 	  Specify a bootconfig file which will be embedded to the kernel.
-	  This bootconfig will be used if there is no initrd or no other
-	  bootconfig in the initrd.
+	  This bootconfig will be used if there is no initramfs or no other
+	  bootconfig in the initramfs.
 
 config INITRAMFS_PRESERVE_MTIME
 	bool "Preserve cpio archive mtimes in initramfs"
diff --git a/usr/Kconfig b/usr/Kconfig
index 9279a2893ab0..8899353bd7d5 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -27,7 +27,7 @@ config INITRAMFS_FORCE
 	depends on CMDLINE_EXTEND || CMDLINE_FORCE
 	help
 	  This option causes the kernel to ignore the initramfs image
-	  (or initrd image) passed to it by the bootloader. This is
+	  passed to it by the bootloader. This is
 	  analogous to CMDLINE_FORCE, which is found on some architectures,
 	  and is useful if you cannot or don't want to change the image
 	  your bootloader passes to the kernel.
@@ -53,59 +53,59 @@ config INITRAMFS_ROOT_GID
 	  If you are not sure, leave it set to "0".
 
 config RD_GZIP
-	bool "Support initial ramdisk/ramfs compressed using gzip"
+	bool "Support initial ramfs compressed using gzip"
 	default y
 	select DECOMPRESS_GZIP
 	help
-	  Support loading of a gzip encoded initial ramdisk or cpio buffer.
+	  Support loading of a gzip encoded initial ramfs.
 	  If unsure, say Y.
 
 config RD_BZIP2
-	bool "Support initial ramdisk/ramfs compressed using bzip2"
+	bool "Support initial ramfs compressed using bzip2"
 	default y
 	select DECOMPRESS_BZIP2
 	help
-	  Support loading of a bzip2 encoded initial ramdisk or cpio buffer
+	  Support loading of a bzip2 encoded initial ramfs.
 	  If unsure, say N.
 
 config RD_LZMA
-	bool "Support initial ramdisk/ramfs compressed using LZMA"
+	bool "Support initial ramfs compressed using LZMA"
 	default y
 	select DECOMPRESS_LZMA
 	help
-	  Support loading of a LZMA encoded initial ramdisk or cpio buffer
+	  Support loading of a LZMA encoded initial ramfs.
 	  If unsure, say N.
 
 config RD_XZ
-	bool "Support initial ramdisk/ramfs compressed using XZ"
+	bool "Support initial ramfs compressed using XZ"
 	default y
 	select DECOMPRESS_XZ
 	help
-	  Support loading of a XZ encoded initial ramdisk or cpio buffer.
+	  Support loading of a XZ encoded initial ramfs.
 	  If unsure, say N.
 
 config RD_LZO
-	bool "Support initial ramdisk/ramfs compressed using LZO"
+	bool "Support initial ramfs compressed using LZO"
 	default y
 	select DECOMPRESS_LZO
 	help
-	  Support loading of a LZO encoded initial ramdisk or cpio buffer
+	  Support loading of a LZO encoded initial ramfs.
 	  If unsure, say N.
 
 config RD_LZ4
-	bool "Support initial ramdisk/ramfs compressed using LZ4"
+	bool "Support initial ramfs compressed using LZ4"
 	default y
 	select DECOMPRESS_LZ4
 	help
-	  Support loading of a LZ4 encoded initial ramdisk or cpio buffer
+	  Support loading of a LZ4 encoded initial ramfs.
 	  If unsure, say N.
 
 config RD_ZSTD
-	bool "Support initial ramdisk/ramfs compressed using ZSTD"
+	bool "Support initial ramfs compressed using ZSTD"
 	default y
 	select DECOMPRESS_ZSTD
 	help
-	  Support loading of a ZSTD encoded initial ramdisk or cpio buffer.
+	  Support loading of a ZSTD encoded initial ramfs.
 	  If unsure, say N.
 
 choice
@@ -127,7 +127,7 @@ choice
 	  boot.
 
 	  Keep in mind that your build system needs to provide the appropriate
-	  compression tool to compress the generated initram cpio file for
+	  compression tool to compress the generated initramfs cpio file for
 	  embedding.
 
 	  If in doubt, select 'None'
@@ -153,7 +153,7 @@ config INITRAMFS_COMPRESSION_BZIP2
 	  booting.
 
 	  If you choose this, keep in mind that you need to have the bzip2 tool
-	  available to be able to compress the initram.
+	  available to be able to compress the initramfs.
 
 config INITRAMFS_COMPRESSION_LZMA
 	bool "LZMA"
@@ -166,7 +166,7 @@ config INITRAMFS_COMPRESSION_LZMA
 	  comparison to gzip.
 
 	  If you choose this, keep in mind that you may need to install the xz
-	  or lzma tools to be able to compress the initram.
+	  or lzma tools to be able to compress the initramfs.
 
 config INITRAMFS_COMPRESSION_XZ
 	bool "XZ"
@@ -179,7 +179,7 @@ config INITRAMFS_COMPRESSION_XZ
 	  slow.
 
 	  If you choose this, keep in mind that you may need to install the xz
-	  tool to be able to compress the initram.
+	  tool to be able to compress the initramfs.
 
 config INITRAMFS_COMPRESSION_LZO
 	bool "LZO"
@@ -191,7 +191,7 @@ config INITRAMFS_COMPRESSION_LZO
 	  is quite fast too.
 
 	  If you choose this, keep in mind that you may need to install the lzop
-	  tool to be able to compress the initram.
+	  tool to be able to compress the initramfs.
 
 config INITRAMFS_COMPRESSION_LZ4
 	bool "LZ4"
@@ -213,7 +213,7 @@ config INITRAMFS_COMPRESSION_ZSTD
 	  decompress around the same speed as LZO, but slower than LZ4.
 
 	  If you choose this, keep in mind that you may need to install the zstd
-	  tool to be able to compress the initram.
+	  tool to be able to compress the initramfs.
 
 config INITRAMFS_COMPRESSION_NONE
 	bool "None"
-- 
2.47.2


