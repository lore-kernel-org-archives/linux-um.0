Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AC2CAC582
	for <linux-um@archiver.kernel.org>; Sat, 13 Sep 2025 00:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2BXXMTZbWkKZqT8QgJ9Z777RqiFOaP2Wc1It8eJXku8=; b=CJmE9dyTwpXGB4QcCEWHKNQxI4
	7vUng8qmspdmMup8s1PmT6bDSgx1XZG+K1Ynk0L9//uHHV4cb2B+Y5+lNJ3v4B4yhaG+OzyMcDSlp
	zCCN7ZG2pbTqNi15rFkMYC+46DmF7NOJKx8kbKLDN+FN1mm1cCpCliBHh2whC1veyId69nFZRPGi4
	5++fYDxIL7crPiC9XYr2vsb9w1YvMkGT54hDSDfz5PLSV6Z5DCR5yx0DAom2Gvj1LMGncBvD8WuST
	Yel2dmXs9QSFPEAA33n4xCg8rdb2+wo7hnowvJbKjd4OHI9F/L/LBaw136CYfUBay/UnG86wgm7Jo
	79i2dQ5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxEbC-0000000CSuP-0Sjl;
	Sat, 13 Sep 2025 00:58:42 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxEb9-0000000CStA-45rP
	for linux-um@bombadil.infradead.org;
	Sat, 13 Sep 2025 00:58:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=2BXXMTZbWkKZqT8QgJ9Z777RqiFOaP2Wc1It8eJXku8=; b=VfNrGraC1M4t/sd7yv6/wxST2m
	fI5mEVzKueJwzHc7LFGLbtN+zC3K597tBzPNyzW0wVJWfPlce9dw7DuBRFAvxE4lG7rfDeUvr6Shu
	UEyoI3pajQTDkXoyXWrHqW07SJ2fdkzD2mRaMjHye4XOz8AriKFHP3n3Yn9XZEG684je3qnbU7NTw
	of9tx+DiQARfiFqZcqwHJCOxCRJaWMRinfojKDof2Tb8XXHueM+d4VVTIMRdc6YUG1ydfgWD+9Ab9
	ToCxmWobWCEpLT2MAymz7xf2IWJl3LkGWhW58yBnDwvc2uKAS/QCLwW+ljNdEWSx2pUKucE++WVgO
	IGz5RHgQ==;
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxEb6-00000006VQg-3J6w
	for linux-um@lists.infradead.org;
	Sat, 13 Sep 2025 00:58:38 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-6228de280ccso4861922a12.3
        for <linux-um@lists.infradead.org>; Fri, 12 Sep 2025 17:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757725115; x=1758329915; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BXXMTZbWkKZqT8QgJ9Z777RqiFOaP2Wc1It8eJXku8=;
        b=Y+WjlSaK5qz5pAcAtn9kUUBll8M8zSQC+t36e78mdIxQiA8AqqSoBA5ruiIOKvG+eq
         ND3GG9iu85JgtxD1WPEPuM8IEcRm+5nOM3c7a5vHcnPFgUEfkkZD5g4YiIH4KJ0NILFq
         5E/CfHTcEX/eOZx1ZLws7ijZ+PLXxncVycqcLjnG16OHrixlyuhORAgM25+M+orWbZ03
         KokcgmOkvgP4v7PW9bUXQPj/mwNpsfpdCH1D+ND9vCEjViKgK/G7b/RqyRdSaf7QUVFl
         rNHpWmDRr7PKi2VYr463T4JtRn9Ci2cHAJ16yRFSP92CsmDoa98610cj48sq8xPxRJfg
         Iiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757725115; x=1758329915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BXXMTZbWkKZqT8QgJ9Z777RqiFOaP2Wc1It8eJXku8=;
        b=hZbCVPEJjshxYRrgMsZqx9/i8jn0OyGwCTfhBJto18wz0R2xyWPE4UXecHSxv2Wlpz
         WM02s6eOW+WQQzt5FgCNLqqk/dzYeMEJk6KvyhqEgZqIXkD507mFhF7czHdz5gC6p3Lr
         ySWpI1w4lU/OQXgCJJyb1v1vU1Ge7aHhEfG9zEpPLeA+wmxWD9omjQNJ4Rw2iQ+JMTXo
         btNAHOG+kRfiBwgCeMPXdvWlDerGnaQgKWhp+HpZnK3vsnsAPhR8Aj6q4KXKZz2zG4sn
         6j9BwYxcN8HzGsCqEPEnwloOFoqO3HG6Q6KHA8muUtqxiurj7BboiFsLvit0jOCjITYy
         7jdg==
X-Forwarded-Encrypted: i=1; AJvYcCWE8SXQr7EBaLXPqnWeqfijl2XZh/nv76HsdYqe8cuj40jC9NfB1PqUKdSWnA2KiU0wD1PrTA0M1Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YwjM2SibpXSbR+ySVfVHj/UGAwmYtLkI+l79N3w+Hf6iXg8/Pid
	8c0DuN/rKcZKt1L7GCdIDfO8cVgBD4lzazETDLgOMe9RxkxZ+9sJWTCE
X-Gm-Gg: ASbGncvQfhwkBlWYraXS4rEadc6RjqU/f9+zjHUkC/9FBb7JaZfVFaylIj1qgqyI7VC
	hqfYjsl7GChA0RFedVfv1F4J/3Ez8rKPfEKVKQd07Jz+W5KGFy9EsiSFl9q+t824ToH4rI0sYmg
	zFxz0moL4MkZqFScFutudtgwRYMvw0+SEqQINBT4Moyj8R2WuyM6sBe0ZnXErnKQG25jbdojarL
	9r6J0X2w5Xb5AQrvU5262kdTaVGOQBdqOvE2erGubojr91u4Gx/qKrDkRfyBjBUWcGGMj2udbRg
	uaiIQLLXL0N/mYTJ9Zoza+IAYDwBStS1bz9Jy4hprTTsqkWWZyAZ++lCoHlC44SjzAHP/Q4CLlv
	bS7iOKq3FYiyxy0dClgun2xxntn0KSw==
X-Google-Smtp-Source: AGHT+IF4XezAq8wXNO6voYrJeDnCFhU1tJ+TfyE7OJRqFWOCMlq1YMWoUA8uaJ4xPb3fA3w8qZjP4Q==
X-Received: by 2002:a05:6402:5242:b0:628:a4fb:3b44 with SMTP id 4fb4d7f45d1cf-62ed825998fmr4961876a12.1.1757725114882;
        Fri, 12 Sep 2025 17:58:34 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62ec33f3b16sm4143925a12.24.2025.09.12.17.58.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:58:34 -0700 (PDT)
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
Subject: [PATCH RESEND 17/62] doc: modernize Documentation/filesystems/ramfs-rootfs-initramfs.rst
Date: Sat, 13 Sep 2025 00:37:56 +0000
Message-ID: <20250913003842.41944-18-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250913_015837_056057_B0DDF870 
X-CRM114-Status: GOOD (  18.17  )
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

Update it to reflect initrd removal.

Also I specified that error reports should
go to linux-doc@vger.kernel.org , because
Rob Landley said that he keeps getting
reports about this document and is unable
to fix them

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 .../filesystems/ramfs-rootfs-initramfs.rst    | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/filesystems/ramfs-rootfs-initramfs.rst b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
index fa4f81099cb4..38a9cf11f547 100644
--- a/Documentation/filesystems/ramfs-rootfs-initramfs.rst
+++ b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
@@ -8,6 +8,8 @@ October 17, 2005
 
 :Author: Rob Landley <rob@landley.net>
 
+Report errors in this document to <linux-doc@vger.kernel.org>
+
 What is ramfs?
 --------------
 
@@ -101,9 +103,9 @@ archive is extracted into it, the kernel will fall through to the older code
 to locate and mount a root partition, then exec some variant of /sbin/init
 out of that.
 
-All this differs from the old initrd in several ways:
+All this differs from the old initrd (removed in 2025) in several ways:
 
-  - The old initrd was always a separate file, while the initramfs archive is
+  - The old initrd was always a separate file, while the initramfs archive can be
     linked into the linux kernel image.  (The directory ``linux-*/usr`` is
     devoted to generating this archive during the build.)
 
@@ -137,7 +139,7 @@ Populating initramfs:
 
 The 2.6 kernel build process always creates a gzipped cpio format initramfs
 archive and links it into the resulting kernel binary.  By default, this
-archive is empty (consuming 134 bytes on x86).
+archive is nearly empty (consuming 134 bytes on x86).
 
 The config option CONFIG_INITRAMFS_SOURCE (in General Setup in menuconfig,
 and living in usr/Kconfig) can be used to specify a source for the
@@ -222,15 +224,13 @@ use in place of the above config file::
 External initramfs images:
 --------------------------
 
-If the kernel has initrd support enabled, an external cpio.gz archive can also
-be passed into a 2.6 kernel in place of an initrd.  In this case, the kernel
-will autodetect the type (initramfs, not initrd) and extract the external cpio
+If the kernel has CONFIG_BLK_DEV_INITRD enabled, an external cpio.gz archive can also
+be passed into a 2.6 kernel.  In this case, the kernel will extract the external cpio
 archive into rootfs before trying to run /init.
 
-This has the memory efficiency advantages of initramfs (no ramdisk block
-device) but the separate packaging of initrd (which is nice if you have
+This is nice if you have
 non-GPL code you'd like to run from initramfs, without conflating it with
-the GPL licensed Linux kernel binary).
+the GPL licensed Linux kernel binary.
 
 It can also be used to supplement the kernel's built-in initramfs image.  The
 files in the external archive will overwrite any conflicting files in
@@ -278,7 +278,7 @@ User Mode Linux, like so::
   EOF
   gcc -static hello.c -o init
   echo init | cpio -o -H newc | gzip > test.cpio.gz
-  # Testing external initramfs using the initrd loading mechanism.
+  # Testing external initramfs.
   qemu -kernel /boot/vmlinuz -initrd test.cpio.gz /dev/zero
 
 When debugging a normal root filesystem, it's nice to be able to boot with
-- 
2.47.2


