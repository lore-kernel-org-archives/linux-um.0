Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B5ECAC58F
	for <linux-um@archiver.kernel.org>; Sun, 14 Sep 2025 03:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8LDuJwsx1JnhEieEawhozXv7eEPm7AwX4v3UgIhLgCc=; b=g+aLyGHjsDRCvgvkuVhWRmhCog
	cW0QTEy/70tPDCljxcM0jVNEpOsT77hyl5ntJzVP1a2SYtNBiv2fPDORNIzE/vCyNr0oa3JHCWdo0
	jpzXoW8UiBv3svVgoQsl7xwKw2JP5tBcOy6/7f1xl+rj0Ivuqu80MwYTZsdZ22QGWVlfSD0epecf0
	Lh9DO4KYCcO89hlP6B5E4RJ0l0GzuYd9t9X+cCwemgCqgly+FEzUpVOA1OXk+H7ixENYFIYG+6RkK
	R2opYvP2nXcxSVR7fJ8eig4yvNgPasrRUdamYhFVFLkUqw8oICw6YS3QqGoclf6wvp3VyzFoyAdzC
	+02IhLUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxdtF-0000000HPUx-26rV;
	Sun, 14 Sep 2025 03:59:01 +0000
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxdtB-0000000HPRT-3cEH
	for linux-um@lists.infradead.org;
	Sun, 14 Sep 2025 03:59:00 +0000
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-afcb7a16441so465873566b.2
        for <linux-um@lists.infradead.org>; Sat, 13 Sep 2025 20:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822336; x=1758427136; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LDuJwsx1JnhEieEawhozXv7eEPm7AwX4v3UgIhLgCc=;
        b=YylZMOitWf6KYGpLGV7bR6qGT10dUCITNTEk+xmOWs16p7lKkJcQeB/FxH+qiPdh71
         qaGObB+1Awi+oCF4oNiy5ShXJG5XR2t5LPk6cKXxna405PULludHkBfhsriKuJWcrJhv
         tNANTkwOHzCGE2XodXee2hbvbPAvMpRAg1I+hc/9R/0G37IJrsj6odr7hQmhR9x0jQ11
         fADEuHi1t2hQ5WaQzyz6BnhTQpc3dsJqNqVltQPb3tMe8y8SH87SLUhYT8DSARnfR27S
         NGqJZaTP8XsjiZcCG0zhmYNV+AOUuVr1e8gZTT2oqsERT/HDEVCFLaqULN0JkaewEmDN
         Rdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822336; x=1758427136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LDuJwsx1JnhEieEawhozXv7eEPm7AwX4v3UgIhLgCc=;
        b=nNvX4oyI7MhjRwg28wqUZBuyBdRZ122Oh08bv5wDspOiA/1Y5uDhwuqmMd6fetiqPo
         us+YDxbWpNPTOktjTqk0tjYB3hXAP08Pf64PjIvDLujp8Xj39eFflOb9nhAlTLS1nuxi
         FHDWQVb1FJHxotiYERcsdMuOz3t4QVvWqSlEu2VidNegfqVpwWtIQBW0CzvxLU+xDY1a
         enoHTNilml6qJrnzfL0DgMGwyOhBs+Z+9FiZPM2dK1ESCRE9yFe6J7KYX68eTXw9ij7i
         Wzy90bW3MKD5cENnp/agXbT1OorTUW2vBTTSWntjHSULdDHZtDGjhi9bD1LWS4j28UEP
         qZZg==
X-Forwarded-Encrypted: i=1; AJvYcCWcwytLJ0L89UuleA5++FidS/nUyD1UsBZy4T0O6wFEK3sTnI7RQDDxqUQzGrCIjExgv3usfvt3TQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YziGvktPeDrRhDcCnwjFgukMykXRXQFEOmb2JX17D4pTgAZ/eki
	qa8KWroo1MbTVxa4RZEPY9YuPyYP4KqVqvyer+5PNQ/XTsoyrUGVe9aH
X-Gm-Gg: ASbGnct/J6ysDNs+M9bv0CnAT4rVWATxIv8DXMc8OpbjbaTvMl+9uJRedq3gD9XXowk
	h0HMU0d/3/Ebu9a90q8Bp5brecweO1GM7p7ithgEehj3vBLT/ujtNXEfhzz9lWBjJ3hyYF6zyEs
	8tvh/dMxET02BzIhBe2mCh2c0PRjnFhAQdBiB1ar6iBzuqlrsreRQe/GcC9y60vSTJ3vrmOa9gc
	KEPgsTRTNwMLWv4FUayzogyF7b/1nMIAQ6OvmL1PFjxjwGCzqvrfn0HZJoJTXj8ANimmB7Ouc2P
	bLi+8eDMFwH0FQWLlRrM7DqM4XOpc+mzOvCTh19t1LE7p1j94soVh8QUoBRcPYMrglJ2aZnY8Mm
	8AnnJ9YaG4OswnonTzAP4T8PvmGCo1w==
X-Google-Smtp-Source: AGHT+IHNLaKXJiC+zXQ2uAPY4azg+7W3/1g8JczFufMn8mQqgVOZ73ifHuYY/OKrygFTvfUSeCcOcw==
X-Received: by 2002:a17:907:3e90:b0:afe:cbee:7660 with SMTP id a640c23a62f3a-b07c34d63c8mr797483566b.21.1757822335865;
        Sat, 13 Sep 2025 20:58:55 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b0cf2112639sm91581266b.104.2025.09.13.20.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:58:55 -0700 (PDT)
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
Subject: [PATCH RESEND 52/62] init: rename do_retain_initrd to retain_initramfs
Date: Sun, 14 Sep 2025 06:58:50 +0300
Message-ID: <20250914035850.3762697-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250913_205857_922998_B4F75D62 
X-CRM114-Status: GOOD (  13.97  )
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
 init/initramfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 30e94ebf4902..40c8e4b05886 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -570,13 +570,13 @@ char * __init unpack_to_rootfs(char *buf, unsigned long len)
 	return message;
 }
 
-static int __initdata do_retain_initrd;
+static int __initdata retain_initramfs;
 
 static int __init retain_initrd_param(char *str)
 {
 	if (*str)
 		return 0;
-	do_retain_initrd = 1;
+	retain_initramfs = 1;
 	return 1;
 }
 __setup("retain_initrd", retain_initrd_param);
@@ -584,7 +584,7 @@ __setup("retain_initrd", retain_initrd_param);
 #ifdef CONFIG_ARCH_HAS_KEEPINITRD
 static int __init keepinitrd_setup(char *__unused)
 {
-	do_retain_initrd = 1;
+	retain_initramfs = 1;
 	return 1;
 }
 __setup("keepinitrd", keepinitrd_setup);
@@ -743,9 +743,9 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 	 * If the initrd region is overlapped with crashkernel reserved region,
 	 * free only memory that is not part of crashkernel region.
 	 */
-	if (!do_retain_initrd && virt_external_initramfs_start && !kexec_free_initrd()) {
+	if (!retain_initramfs && virt_external_initramfs_start && !kexec_free_initrd()) {
 		free_initramfs_mem(virt_external_initramfs_start, virt_external_initramfs_end);
-	} else if (do_retain_initrd && virt_external_initramfs_start) {
+	} else if (retain_initramfs && virt_external_initramfs_start) {
 		bin_attr_initrd.size = virt_external_initramfs_end - virt_external_initramfs_start;
 		bin_attr_initrd.private = (void *)virt_external_initramfs_start;
 		if (sysfs_create_bin_file(firmware_kobj, &bin_attr_initrd))
-- 
2.47.2


