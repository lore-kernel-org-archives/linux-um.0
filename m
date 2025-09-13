Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5B8CAC582
	for <linux-um@archiver.kernel.org>; Sat, 13 Sep 2025 01:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h6O+lfSZLBCLtFpNKL/1anVub0eApVizJE0pmHD2kMo=; b=RBLAH/tRA9yQTXtMwJWc4kuq3r
	YGUZCBHOOKGgL3lXN8TfQLGI7aBb23cHlFxPfLqKICKFhQXN+CbEepQjWhDk1Zz2IZw1MZpE5LyS7
	JToMz5MYW8mfa9iDpSdUr8GYJCEx2niUVmUEyzhzaACsnClfWWS9Ua0iIawJX4Lv9S/FxXmldFlJi
	v5KVr42R9qmg1coMbHqRXMj+3CrzRRjsM+1pn+4dYftTtbZC4cdjFCPYan8rf3P4r2OeXDsQy6USW
	K22pRIPiCSgq669CJNcBCU/zXUBMdxlHRs+KDrF+lvE0JGcbJ0uPAB5qXh1uJvYNK0WzEHn3RvZAO
	S4/ATjmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxEnx-0000000CXlx-0m27;
	Sat, 13 Sep 2025 01:11:53 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxEnv-0000000CXlH-45a9
	for linux-um@bombadil.infradead.org;
	Sat, 13 Sep 2025 01:11:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=h6O+lfSZLBCLtFpNKL/1anVub0eApVizJE0pmHD2kMo=; b=mMO+5O12b0XxX+R9SIUIrPVgtL
	kQWm4XCw3NU3X3QM5B4lDGYhcHpUP3ORRZTowxTR5X3bGu5D70VeVKxlXQvE8g8cZu1INihhVcvgF
	lcrlsTGWs2OjWrEWHEyUWcht5BSmd0KQRwFxOQJ3vDtwZYfi5QawKRkpEQrRnfuBdHvhjEl/gar9p
	Qfsiq0Fu+7Af030GHPC0OaB56CeF1H+Wnj9fJeGD0hVK+obNNjf9Z35eb3GPF59icxXD7cbxy5i6x
	YQbIJGIDybRtRj2VC/4S2oEJCAz48uStOzsww9/ljNgX0Wv53ea4ptHgZYFVPrF6IBsODby8aD8oR
	pfc+UbYg==;
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxEnr-00000006WQ5-0hlc
	for linux-um@lists.infradead.org;
	Sat, 13 Sep 2025 01:11:50 +0000
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad4f0so3994992a12.0
        for <linux-um@lists.infradead.org>; Fri, 12 Sep 2025 18:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757725904; x=1758330704; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6O+lfSZLBCLtFpNKL/1anVub0eApVizJE0pmHD2kMo=;
        b=RQzeg6oJmT4iSMfCNQ/0VroFLO0UHQkNAL/A5L1M/hiMkrzU8rbTFumdbxTTPhIudB
         ufWEneb6kTXy7dNz3VXmD9EpyM0kR6BBewhqomP4WfUeXATO0iqjujkpHdv4wYzzvQvG
         OatdeOIxZFH6rJDWUX4zxDj9+k7v/OIRA7+N0j5OYv9AQkcSiQA/KjMK/EXEMMtkdNPN
         FQi+kSQWq3Rb8OnYGY7pvpabJIIAAQNmIHcJzrbk/2bhzgo23AgC3VOHmGk8G1aijSco
         M3DrtiDC7ZMS+ZZaiZzpqQvQq3/6HU3Q0SvV1c/sy8/uzm3g4+C/vW5uWwIxI+BDLR+X
         YABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757725904; x=1758330704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6O+lfSZLBCLtFpNKL/1anVub0eApVizJE0pmHD2kMo=;
        b=BGNfVof/vUc/bfZdLmYfus34NfTeCOrbrhDHP3zgAxHd+q5QyUL6/dZJvNB0bO6G6d
         y+XTZOy4AkuDHwGYdgmNtLs8zcCLEqYY/uUgYIoQOhuEz0hskz1Ft4ipjoMy1zcXTdJB
         fcfXikXIEnyKwYwFjCmIwz71MxszhqlpPrTQm3AVEaGiagl7mucxsdBvonSZwLiGhxaO
         mi+V0WObwJlmRS1YuVOfXep5xwVaZylIgao4hRGxWm0x7u5EcEL1dP3RlAwKYswTGgXM
         YCBUY+lJqQJ2XohzCYYEx2IKgK8XTwSNFR+OGFVd9zb5kkQpRgEYUbkvwWEycy0i6y5C
         M7sw==
X-Forwarded-Encrypted: i=1; AJvYcCXc2pAOiSZYlszcBXbxuWaM6ywAISLgkENJzKolVOnOpGq6+5A5aryVhpx2yJDkTSohIsJIV4aW4A==@lists.infradead.org
X-Gm-Message-State: AOJu0YyQ0CuutE/ZZmasBiQEARvkPooaSaLoMfZrNzmUwONMaIhERkEt
	KkDHRFvO9YVc43GcJcSRrWve/flZPTd6CshuQ+vMoPdv+AENd5Z+VYwA
X-Gm-Gg: ASbGncuAw2Ixnp0PkjGGSc4a2BaRO/K/LB+bL1Nw0ojPccVZDTYOuqtlMeIXv6HR58f
	1DxEbINa3H9uO/5Coh+nUZY+dEklpEDYt1KZRPDQXGybLTaly7T2FHWDRxU9bEbnVmxXxpGNHvQ
	RkR6DTPh041VD5yJK9++t5wqzBidwlU51Hpez6kXs6qHWHFaI+waAjnRrwnlXGrMvRxLYtcbNnh
	3SvFHjfjuGw+1ipeDXV0rdeDCNvEKCb7Z34qyo+ULXDTshJeqy0UZfIgCgrp6HuL3XhdVX9JDty
	guZ3OZdJeOk0J1Ha+TwpqeTY2Y9sb7NLnWJwNMSzDpXw6qLs0iucs6dBDygjnH1v1DvsHi92s9C
	ByWPxF4tOovB58McLDv4=
X-Google-Smtp-Source: AGHT+IEEs4w0VYWOrTZ2mf5mPdRdgIBBMsi5zMJEle+Jt2EK6Q+4TbCNWtdbvmdxcJfUUMXxxDwLfQ==
X-Received: by 2002:a05:6402:5242:b0:628:a4fb:3b44 with SMTP id 4fb4d7f45d1cf-62ed825998fmr4990182a12.1.1757725904210;
        Fri, 12 Sep 2025 18:11:44 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62efb5b8b0asm913566a12.20.2025.09.12.18.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:11:43 -0700 (PDT)
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
Subject: [PATCH RESEND 29/62] init: move virt_external_initramfs_{start,end} to init/initramfs.c
Date: Sat, 13 Sep 2025 00:38:08 +0000
Message-ID: <20250913003842.41944-30-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250913_021148_367327_91681E14 
X-CRM114-Status: GOOD (  11.37  )
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

Move definitions of virt_external_initramfs_start and
virt_external_initramfs_end to init/initramfs.c

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 init/do_mounts_initrd.c | 1 -
 init/initramfs.c        | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 8bdeb205a0cd..535ce459ab94 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -12,7 +12,6 @@
 
 #include "do_mounts.h"
 
-unsigned long virt_external_initramfs_start, virt_external_initramfs_end;
 int initrd_below_start_ok;
 
 static int __init early_initrdmem(char *p)
diff --git a/init/initramfs.c b/init/initramfs.c
index 9a221c713c60..d2301cc6c470 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -600,6 +600,8 @@ __setup("initramfs_async=", initramfs_async_setup);
 #include <linux/initrd.h>
 #include <linux/kexec.h>
 
+unsigned long virt_external_initramfs_start, virt_external_initramfs_end;
+
 phys_addr_t phys_external_initramfs_start __initdata;
 unsigned long phys_external_initramfs_size __initdata;
 
-- 
2.47.2


