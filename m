Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E88CA101F
	for <linux-um@archiver.kernel.org>; Sat, 13 Sep 2025 01:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=076xoEVbaVUh2WXJ09mT2DE1QkI5WvxeMmJOzlrP1Zs=; b=36SYOPaL99j4OowrUEpi8lqrSg
	th2WsCyUKrnyXLsTmz7V+y5mZvwmPbFbrD3uTTyLhJ5MISgUlZSqiSDAnA3cghCSmVoAVp0tRNnvm
	oDUp0LSuzrxD6t6UmHCQj+2XbWBkFQ+sptWE89N5K2aUED6y0y7ircEVrwFSa39i9HQFLcnIboeE2
	w3FGAxOpzMAVwQ+zY9zdBFsp3umaTDzYhwnS77Onx2+2NlrSlDCv+LS7/MgsRowo26ix+F4uxnFCf
	37wX0CGw/N7S7PT7OqRnPu8eK/vOX9wqLtikwxdfaPHd/ZZRETKG//Kyd/Fs7/Pqo0+UlemqO2JNN
	/H4g/qCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxEkg-0000000CWf3-39J6;
	Sat, 13 Sep 2025 01:08:30 +0000
Received: from mail-ed1-f51.google.com ([209.85.208.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxEke-0000000CWdQ-1jfr
	for linux-um@lists.infradead.org;
	Sat, 13 Sep 2025 01:08:29 +0000
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-625e1ef08eeso4237403a12.1
        for <linux-um@lists.infradead.org>; Fri, 12 Sep 2025 18:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757725706; x=1758330506; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=076xoEVbaVUh2WXJ09mT2DE1QkI5WvxeMmJOzlrP1Zs=;
        b=Xiwvms/DBu9wXjYHD/Yu5vTQuQ9kmrGB+h+0i45Rnachqb7TVwIqAvdQNlu8wRsGye
         5zImRJxNokp3GwDwO+WSazntR0STL/3QbThGZgNpqxdwagHjvhEsYrXGqaf1Br4JAb4g
         vtuHPDeC8nOzO3dYLAtLzJtSUDFz3c76uGcEjc6W5QkmW1CmxvDxgOiFNEfAXQg/eUhK
         b0B4Z1jYk5J/9uokFU0cPPuao2WpEz6d9b83Y1EetleFEisY4bwwaV0c33Xn7EN4uITp
         SQcFov3ypRAN1LPY+ekUY9JNyZ0/1WOsTGXvXPczA4MiM1YX97jc/X+HH6FUlWw22abr
         RYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757725706; x=1758330506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=076xoEVbaVUh2WXJ09mT2DE1QkI5WvxeMmJOzlrP1Zs=;
        b=KIrG6a70M/DUmYAaUo2lgb6A8FJ6umCxoOmsfTykhcl05k7O+jXmYWKBqrg8aoSGjz
         jAy5ejjxh5Vjr9m4y/80YDheOo0+62SAURFO9Zz39fO5a4Mpt9dh9WNIMgXiC1MeUD8y
         mjwmZCLQ2d7zrmS8NsMdm8sIQFa3jAcgXkbS3HcsG9+uHznBKF4nPgqRobb7eLkB71Ks
         jdOy7PHXDgmaknfYEfU+LAAWN89WkPMvNF2CATFT35CAftXL7JN3a8vG5nOxy1BWqkfi
         c+ZsuCcf3HmafedTQq7Rr+ghguxrSdxAV2szRbDkWu2vyU9HmBaXIy4gC5QfB3qyVJKv
         +daw==
X-Forwarded-Encrypted: i=1; AJvYcCVgmQgdXsZ4+T+2boZ+ugFZLFMR6q/zF+i9cbidJThPo56LKKBONfMFzN3AV11JGF6j1qy7eLzayg==@lists.infradead.org
X-Gm-Message-State: AOJu0YziqPCgP6oafw2jbYbaJCLu1M9KQ6n/2BYIJIm606rYQzMgdJuZ
	VMC3A0GX+3eyBpo0I4kP/NUCHpNa00Ijq3XwSL/JROna2/6uG3KZ5iVh
X-Gm-Gg: ASbGnct0i6ShzoMNkZMu5M5I1gKlIUiN5AG8O46DM1pHE0jjUkyLEhRHPmv8NQEcn85
	72lWvNagQFbMvB2027DdldpGDEUyHmGXtVrUUxZ3MZX1RLxhBTjCQ+kOAj0J2OVcI0iM8eaP/Pi
	zKsy7yip5y4SP9of/c8ABKxdyW18XDQw4XJconYh1S6CqWO7+WkFoafN8V6TDAwuCpfMvnf1PHE
	EKPVZ8wscE6Yl2KZhBD6VvnB3OXHZvSp6/dsF0wndH45EkbUw7xFabhCu6PhO6yk7tZ9jzekOEm
	qq3ot2CYLK2rPNIjdCb2IOstxHgAV1OEDq017PXi1xrJ9fQYnQxXYMa1ZO0ybnN+e687nQtTUsr
	7SpUaZtMwqqVtz1TsjgMblTJgw7CS2w==
X-Google-Smtp-Source: AGHT+IGdk3XVuMADNouJH/aBQO3dgisawWr0ra1gK5dmtwng/BJ+8DUWD+mdbhpnTmhbFrSAIQbncg==
X-Received: by 2002:a05:6402:26d0:b0:62e:e5b3:6388 with SMTP id 4fb4d7f45d1cf-62ee5b367b9mr3462166a12.19.1757725706048;
        Fri, 12 Sep 2025 18:08:26 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62eff1a5c6esm720024a12.50.2025.09.12.18.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:08:24 -0700 (PDT)
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
Subject: [PATCH RESEND 26/62] init: move phys_external_initramfs_{start,size} to init/initramfs.c
Date: Sat, 13 Sep 2025 00:38:05 +0000
Message-ID: <20250913003842.41944-27-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250912_180828_471986_A3064D9C 
X-CRM114-Status: GOOD (  11.04  )
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

Move definitions of phys_external_initramfs_start and
phys_external_initramfs_size to init/initramfs.c

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 init/do_mounts_initrd.c | 3 ---
 init/initramfs.c        | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 444182a76999..06be76aa602c 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -15,9 +15,6 @@
 unsigned long initrd_start, initrd_end;
 int initrd_below_start_ok;
 
-phys_addr_t phys_external_initramfs_start __initdata;
-unsigned long phys_external_initramfs_size __initdata;
-
 static int __init early_initrdmem(char *p)
 {
 	phys_addr_t start;
diff --git a/init/initramfs.c b/init/initramfs.c
index 6abe0a3ca4ce..5242d851e839 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -600,6 +600,9 @@ __setup("initramfs_async=", initramfs_async_setup);
 #include <linux/initrd.h>
 #include <linux/kexec.h>
 
+phys_addr_t phys_external_initramfs_start __initdata;
+unsigned long phys_external_initramfs_size __initdata;
+
 static BIN_ATTR(initrd, 0440, sysfs_bin_attr_simple_read, NULL, 0);
 
 void __init reserve_initrd_mem(void)
-- 
2.47.2


