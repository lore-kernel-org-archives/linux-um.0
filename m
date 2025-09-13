Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18968CA101F
	for <linux-um@archiver.kernel.org>; Sat, 13 Sep 2025 01:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IjswgxWrFNOKRwzjkiuQ0bl5mmgWmo9Cqzfehf6N75I=; b=PSX5n0VGKOepJKKsaPbErO9qpy
	benjcxmYPrPS3T6OgtkNkTC9uLwf7OtDccr6TBhm7AB99Ng0YauNLSsoH4jNh1SRTIKU+5p9rPBP/
	uXh/ONCR6H4VJFW/6nDGIuArsfYe8G0YxOwGIjKf34/UKSXMfVI54uMY5b/OBHYRQElwmqRREtUQK
	c/W7x/rVIJ8YR+Qujs3Ue3JYBXLI/JYD5PvaxmCfh8tbR986WXBF0KbDDsLg1SY5UuTqPxP9dZmEe
	llfnbG4rDE7AKnW6/B4Uv7ct6cBZY552KWWIrsyBJC7Yj3pIfXoitor3Suw1TPU77lTXvfSrO4odj
	FcYM6j4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxEsE-0000000CZVy-3EM9;
	Sat, 13 Sep 2025 01:16:18 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxEsE-0000000CZVE-0GyV
	for linux-um@bombadil.infradead.org;
	Sat, 13 Sep 2025 01:16:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=IjswgxWrFNOKRwzjkiuQ0bl5mmgWmo9Cqzfehf6N75I=; b=JzbJ55sJiSH4AcrGE+2JS9YWjl
	5u9D7ygQbkwOphQySGqrkPglDPRDCJnRs4uVWwSMNyaWzKw377YJMRCtWnndLeRUZrDiFr33LZMlw
	2r2STRFb/FtkpoMGDylDGXh9SaFtYX66jkVON0qx4fWaUvxOP5zTDOIEnG3d6PqT3z49eyURC+SCM
	QXUzrRbglYY4tdSL8Z34P65d5hgLvjJm/r5GURf08opaTqgfiUzarLFkzORZ+oTmY60LpP3JWl3rt
	rTV3Ph2np2LUAm4o4oa9x0dZpsTIR2/iH3CASKTl+w5d6q6HylzPAe/EK6XJ9M6waum1DqNforBQD
	VI1b2I7w==;
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxEsA-00000006Wne-1fan
	for linux-um@lists.infradead.org;
	Sat, 13 Sep 2025 01:16:16 +0000
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-6228de280a4so4102070a12.2
        for <linux-um@lists.infradead.org>; Fri, 12 Sep 2025 18:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757726172; x=1758330972; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjswgxWrFNOKRwzjkiuQ0bl5mmgWmo9Cqzfehf6N75I=;
        b=LGujDUzRiHXVs4bwv7TAJAJ+Q6DQlIbrkOJ0bBHN7LRwAntWTSLt22F9ChFPTCNt4Y
         K9RpYdTD5aqsiYOciX6QIOqa05yIXLcVAiYGc0Tk3AYLodZNCG1xSVYZmRiquqAwTboO
         K2I0llMne/DPSvTiqZ7+JvRAuKopsl3eyNc9W+N55rxGM6iX3cup6X2DzPay57ixoTgx
         GslS5aW1csH5GblGRqNodJjDccJ19nR/RtXX0upLZZScs+WfvraWKylPA/c5Q7GTJY2X
         sYbK0WL5DL9UWUEopvk4ACRkYpXQ6lt8bHuDwx2Nl5oYfnhoMivVszLCYDOcDV+sK2ZZ
         LD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757726172; x=1758330972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjswgxWrFNOKRwzjkiuQ0bl5mmgWmo9Cqzfehf6N75I=;
        b=kODduTY+zKN+lWWZB6N9A0YfHR1/sHID3TFXeiwU96tssx8oiGwiA8vLUtHyLxgf5k
         dkLA+icHODBxt7M0Ml6JFRjJNIWT6XLgvpLP4JJSY6njYDO48P0ZX4fT+VCu9HhELRdq
         jEYHhzKag4nnwfmxVfihBjuRRknTFUhQPIWSWP8PaVnvvkE5kHGNKMg+OquV0JFrwhEM
         R6cmnzTtIG34Q45d9QhEifikwqtfuFJioiMxRFwvzvWilhrW5epD/KcZWmcjilYlBXzg
         jw2uNSIYFYrF70SR78wHOVJT3N2d5/BlOrAgfr2ONNvqzu6flbJZyVz/8rNU996g+laB
         Q/8g==
X-Forwarded-Encrypted: i=1; AJvYcCXCtI2+ymE7lw37wIopNdAJxCRYfDsGazW8sCaeIom9p51qBYDq49kDHZcgRRHSOKSsDNf60+87ag==@lists.infradead.org
X-Gm-Message-State: AOJu0YweRjyBL9qftGQbdNJ+XX31sNxsrJ38OSIAfbn2PT6CpNvfiOwM
	GVoUR6BKd7+NCrWBegJDsWenO1t0jDLWbc6Ld5ZEszqIgoSKGei0PFtE
X-Gm-Gg: ASbGncs8ZZmVskFaCXWBmoElaYBtGzxvg5/XHVYsKUir6nPg2bAdEkUvDVQVmp+xoPD
	6j18Rm4lE9WLnCKZ0LB6IlXR1l9Rahi7wB8YtbS8I0gYkMp1iRXvsgEpjjYXRmIgX+pC8Rcr5sb
	kOLxDKTuZnFZCwwKOKsmUoZkmwD7z2rCJKx8Y+dkQK3j1JjeGSvWQJSdJDUHGNm4tqEtcozzfOq
	mbaOkj8lyau8TWuivavazmb1d7QSy8v2MemVrBxB33lFaJZVAWKgZWiLQc60CNc3iaIWy58R//U
	yVItL+4Gs1Z5mXf780OSNgRsqypTKSqjth1IKDyl4AMC5Rl1GqrQVrerDG8U5DsjOtvJ6vpRKyq
	t15iUWuQoJ47j4QS1RwsLNGoRWDUh5Q==
X-Google-Smtp-Source: AGHT+IE1vl5AoL08hnxvihV4MKDaztrK6JygVC9P3kqlNeKyWBvnhpYqmVFYWjhHgbqbRt0/sx/2Sg==
X-Received: by 2002:a05:6402:40d3:b0:61e:ae59:5f07 with SMTP id 4fb4d7f45d1cf-62ed82718ddmr4360854a12.20.1757726172015;
        Fri, 12 Sep 2025 18:16:12 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62ec33ac2efsm4135647a12.12.2025.09.12.18.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:16:10 -0700 (PDT)
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
Subject: [PATCH RESEND 33/62] init: remove init/do_mounts_initrd.c
Date: Sat, 13 Sep 2025 00:38:12 +0000
Message-ID: <20250913003842.41944-34-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250913_021614_748893_23936AF5 
X-CRM114-Status: GOOD (  12.66  )
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
 init/Makefile           |  1 -
 init/do_mounts_initrd.c | 36 ------------------------------------
 init/initramfs.c        | 23 +++++++++++++++++++++++
 3 files changed, 23 insertions(+), 37 deletions(-)
 delete mode 100644 init/do_mounts_initrd.c

diff --git a/init/Makefile b/init/Makefile
index b020154b3d2a..09657c0274eb 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -17,7 +17,6 @@ obj-$(CONFIG_INITRAMFS_TEST)   += initramfs_test.o
 obj-y                          += init_task.o
 
 mounts-y			:= do_mounts.o
-mounts-$(CONFIG_BLK_DEV_INITRD)	+= do_mounts_initrd.o
 
 #
 # UTS_VERSION
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
deleted file mode 100644
index 509f912c0fce..000000000000
--- a/init/do_mounts_initrd.c
+++ /dev/null
@@ -1,36 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/unistd.h>
-#include <linux/kernel.h>
-#include <linux/fs.h>
-#include <linux/minix_fs.h>
-#include <linux/romfs_fs.h>
-#include <linux/initrd.h>
-#include <linux/sched.h>
-#include <linux/freezer.h>
-#include <linux/kmod.h>
-#include <uapi/linux/mount.h>
-
-#include "do_mounts.h"
-
-static int __init early_initrdmem(char *p)
-{
-	phys_addr_t start;
-	unsigned long size;
-	char *endp;
-
-	start = memparse(p, &endp);
-	if (*endp == ',') {
-		size = memparse(endp + 1, NULL);
-
-		phys_external_initramfs_start = start;
-		phys_external_initramfs_size = size;
-	}
-	return 0;
-}
-early_param("initrdmem", early_initrdmem);
-
-static int __init early_initrd(char *p)
-{
-	return early_initrdmem(p);
-}
-early_param("initrd", early_initrd);
diff --git a/init/initramfs.c b/init/initramfs.c
index 90096177a867..8ed352721a79 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -606,6 +606,29 @@ int initramfs_below_start_ok;
 phys_addr_t phys_external_initramfs_start __initdata;
 unsigned long phys_external_initramfs_size __initdata;
 
+static int __init early_initrdmem(char *p)
+{
+	phys_addr_t start;
+	unsigned long size;
+	char *endp;
+
+	start = memparse(p, &endp);
+	if (*endp == ',') {
+		size = memparse(endp + 1, NULL);
+
+		phys_external_initramfs_start = start;
+		phys_external_initramfs_size = size;
+	}
+	return 0;
+}
+early_param("initrdmem", early_initrdmem);
+
+static int __init early_initrd(char *p)
+{
+	return early_initrdmem(p);
+}
+early_param("initrd", early_initrd);
+
 static BIN_ATTR(initrd, 0440, sysfs_bin_attr_simple_read, NULL, 0);
 
 void __init reserve_initrd_mem(void)
-- 
2.47.2


