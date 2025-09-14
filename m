Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF636CAC58F
	for <linux-um@archiver.kernel.org>; Sun, 14 Sep 2025 03:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O9abWz0+AALTE1DyE86pUo1tihrL6Hn8wt7mMTmG960=; b=El3ksU/qkww17Q/Vs1dKYW9dGD
	c//zIEQi8sD9sJUYeQqN4MRXGA/L+nlUgbuqoZ21RpnNIkDOvzPleUTDil7FjuMz7Kpi+0dO5qO+G
	2ApQsDdal9TY+wYF3R9ri1JSz5TUTU35cQGdTlLT+c51U9d/CZB8nupVISC48yOJdw0unex6aDEpB
	i0Gr3Rm0pQOx8cNIYx2ink2Ef8aJod4WcPgmdpbYGt0TnwZPP4jkqWvj0gOoOah2cuPIy2r9EpiXA
	wRevR/kxGFvmozRHX8xLV/wNK72nRAlaStAb3W32D0HYSZH8Luk67UgCMM9wijZfawd13vQXqt8fA
	3skKbBnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxdto-0000000HPq8-2Hu3;
	Sun, 14 Sep 2025 03:59:36 +0000
Received: from mail-ej1-f45.google.com ([209.85.218.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxdtl-0000000HPnB-3GsR
	for linux-um@lists.infradead.org;
	Sun, 14 Sep 2025 03:59:35 +0000
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so479129566b.3
        for <linux-um@lists.infradead.org>; Sat, 13 Sep 2025 20:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822372; x=1758427172; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9abWz0+AALTE1DyE86pUo1tihrL6Hn8wt7mMTmG960=;
        b=Dp9/uUkFHX/uFX/XB1RXTpXEMWavlyFhAVDucZKr0i8nOEDUUqxzHTqGfXi4HAOHZ5
         SNeuZ7z/1zdaitEzyiBxQEu/0PSkiYdt65Lfz9gb1kSGW4oCsn4lw3dRTl8hc1l7xQOa
         fnFC3fD9qwefHBci0EVNwCSG6exHWyw+2mcSx4itguNXHBOaNkXpba/i6l+yfPcWJyIN
         bKJE2UEfwRahqGTn10A0dRybl1QhI9l0WkEI2qpJNvWdKHzXqqDmJZNszvDnNFJg3nDe
         hY0kFF9Q2U7ES5TGDck3Gozp+PL+8+Y2AWgXq2m9VhP7n0gVrkMtWHIQKFywJ0n0V+Qs
         eo9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822372; x=1758427172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9abWz0+AALTE1DyE86pUo1tihrL6Hn8wt7mMTmG960=;
        b=JO9DxWEEUNIsjsYSbiLAt6H53jGceoERCVGHxDnVqGpSKB0lUDQHf4nMiXaa9qrOfN
         blOKsuFWb8MFI0kupq/KHmgaljG1QMENA0RzDWQ9Q1XhsQFCWh2wo65pl9a2LeYQlrg1
         dzolUUdURqZ7RQkXd/kkKN1cPqC1A6Y5YBo9cXxDEjrrnHCStL3vXGgWw85t1FE3UxeU
         CWFToT9yTWTsSdOaWeitUcTfeewLb9Xz8Iq6En0uni1Gc7ozytsVQPf4EixwL8muplwa
         5pdv9lYNUqAdANwsTeDBFG7m9SNqZyEL1NA/D3jRUG5j8rj722etJjkPRbY/Ip52xZVb
         +nfA==
X-Forwarded-Encrypted: i=1; AJvYcCXF130gXx6GsQEl0Xad8R/DO1amUWdJYxmYLVAnMZcHIKACIlJg9/B9mJnqxK7dQup4pIhKj2FZew==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw8hoLoi4smZaPZ1bUJaQM/op4M01sdB7iTt5dqcnlK4ZxStfxK
	aUyLpArM69EQuoWb4PSgzJAcGxZDRpPBJL3FS/I/YQBXyaiB5+gYd93W
X-Gm-Gg: ASbGncsRKLOCAUzTf4Hel5v44lwWtgpvuC7iHDopVpCapVzk7nYiDpP6oKoMGSRxUSy
	y5qQJBvXNWfn4PeEJeflzh+gfjPJZzF/w8suYAZldcO3QQBRDo9wHDuJHeHJb0PbKigZ5ashcOm
	7ms0g57BT4VnRoRjY/bVmm+SqSEYDXmhVunBW5UZnVYoGRwICTMHkH7hXZh6BrHhsAnzaH9TO73
	zIGW5WQ7Fku6doE5oijQy9WIadpkGiqkA8K9mCD2tn7AcRnEbztn7VJ5VqDsjtWp68d6YaQPUoU
	c/L302D3DSuVGGe/5yA5TdDax1tYNZAR6BNOYnRH9ZgXF7A7hIuIYB5USO/OsfD8B8HeSAYmRcQ
	mAvjPyYjpFPlJD/izW3E=
X-Google-Smtp-Source: AGHT+IHIaNmlQUOqaI2XvHaD2x2sJJCA+iwXMxeIqgPaozK4MzRrxS2gXxwIxVkINaRf0GrOSh3U1Q==
X-Received: by 2002:a17:907:3ea6:b0:b09:48c6:b7ad with SMTP id a640c23a62f3a-b0948c6c6a4mr387666066b.57.1757822371514;
        Sat, 13 Sep 2025 20:59:31 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07de03d93csm287001766b.12.2025.09.13.20.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:59:31 -0700 (PDT)
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
Subject: [PATCH RESEND 53/62] init: rename kexec_free_initrd to kexec_free_initramfs
Date: Sun, 14 Sep 2025 06:59:26 +0300
Message-ID: <20250914035926.3770703-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250913_205933_827709_573D5A89 
X-CRM114-Status: GOOD (  11.58  )
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
 init/initramfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 40c8e4b05886..d52314b17c25 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -690,7 +690,7 @@ void __weak __init free_initramfs_mem(unsigned long start, unsigned long end)
 }
 
 #ifdef CONFIG_CRASH_RESERVE
-static bool __init kexec_free_initrd(void)
+static bool __init kexec_free_initramfs(void)
 {
 	unsigned long crashk_start = (unsigned long)__va(crashk_res.start);
 	unsigned long crashk_end   = (unsigned long)__va(crashk_res.end);
@@ -713,7 +713,7 @@ static bool __init kexec_free_initrd(void)
 	return true;
 }
 #else
-static inline bool kexec_free_initrd(void)
+static inline bool kexec_free_initramfs(void)
 {
 	return false;
 }
@@ -743,7 +743,7 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 	 * If the initrd region is overlapped with crashkernel reserved region,
 	 * free only memory that is not part of crashkernel region.
 	 */
-	if (!retain_initramfs && virt_external_initramfs_start && !kexec_free_initrd()) {
+	if (!retain_initramfs && virt_external_initramfs_start && !kexec_free_initramfs()) {
 		free_initramfs_mem(virt_external_initramfs_start, virt_external_initramfs_end);
 	} else if (retain_initramfs && virt_external_initramfs_start) {
 		bin_attr_initrd.size = virt_external_initramfs_end - virt_external_initramfs_start;
-- 
2.47.2


