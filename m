Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E59CAC592
	for <linux-um@archiver.kernel.org>; Sun, 14 Sep 2025 03:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eXT46s/O30O5D6iGHqIIZ8OQqeCOoCO9YfqStJzQ+0w=; b=Aaux2W1dsbtvexfFLAH0SpoVJd
	ESY5iBTjU9dWbJlW05a1jNyNlrv2uKL/BlFnvkVAPoySi+sUHWWHGyzrRl0wAjCvly5dVFiZj9ceY
	jvoEwrvi68SUJ3B21Mt1EvlbmwJjwxtX9oT580HS0NaUZICaPdMd9IMvuZw6bT5OZwgSJ6D6SnvFh
	+T4tfLfPVfrLgOaZo6LwHta2+bsqh49E2KwrS50qbN6ARqsfRNx4abOmuKFkaNBOuu1Ss/AJrLQUy
	B1SMxDkfpQw2nosyleN8jNcn1USafn5k2X0NNQ2F2h5VTbq7bJszPsSbNMe5dGoYl6R253u7ZfA4R
	bmXstGQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxdmI-0000000HLiS-1nR2;
	Sun, 14 Sep 2025 03:51:50 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxdmE-0000000HLdn-33Cm
	for linux-um@lists.infradead.org;
	Sun, 14 Sep 2025 03:51:48 +0000
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-b07c38680b3so313779166b.1
        for <linux-um@lists.infradead.org>; Sat, 13 Sep 2025 20:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757821905; x=1758426705; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXT46s/O30O5D6iGHqIIZ8OQqeCOoCO9YfqStJzQ+0w=;
        b=EwSjNRYIgesg9N+2zAcn27UTL3HckN0PR+zj5khroMMZ6Gq+8p7lc27zhEtQv/BwK5
         B3k3F531Wd2YJMH+MkCEFK4gxqEo4xq8yuS/c5YoIm9LK3ZjTUxY3DkWe0fA9f0j0IrK
         mBftU5BkL4aVRAY1L6B7e7ltUMEU9WvP53nf0oKMcNNtEH/NxZEynfWXXX6ecTzTqF0f
         ryMs5DJuUdupxsauASbwkXIvP3oqDIu+5HUvhItgsAlV1I0MYuNosMSaN61rn1hYqnDt
         iEuXhuNjNiM17c5LC/WutvNN1Lh+CMhWt90by03xofMuHrbwURZRieRpo+cRW590DLA/
         gX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757821905; x=1758426705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXT46s/O30O5D6iGHqIIZ8OQqeCOoCO9YfqStJzQ+0w=;
        b=cmq4L6vAb49ASBaKtHlrIgI1rhoeu5xSlcEl/7C8MHauAhbvu2XlVMO9fH1jgMg0zL
         poY3ZClPeZps6xWJTG1qPogYi5PHP3SSCfpZB7+O4eE4E8N80yV8KqNizU3fgXX3h/Hs
         LvQU7NFxYFrm1wIWd+FvE7XU1Iff7vOVgUbopYFZnUiESd2GcQ6Ni2QYMj6daEOU7nSg
         BoAsC012ZJpcyuR0TYegc84Lpf+nrnAO5Fvjscvo1fTbjKhb/ipzo/zkLSzwJElTBOzg
         JtD07ztl8R+FKhlr+RIlC3uzgQ8a6JWAHwFosEEd64R8B14QFUanvvRohyZbvPV8wHxU
         z4qw==
X-Forwarded-Encrypted: i=1; AJvYcCW9B2E6UH8WqprEisgAxqIQHIWYirZVcjPawiq29BFXX3fGDvEUc4wCTzS0RB+4U4PE5I97zJkZmQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxtUW6fC2cb/hypYmIYddbNZTl1wMpYhra3AILmscuCr9NXqgZ5
	nqwHbXEYOLpmyARSVLWwItlcGQWysXIAMXP+YXwTBBtRJMBykDRr6iRT
X-Gm-Gg: ASbGnctrn+fMGMbC/cnquGxTGWj+ZPXDieOiA3g0QG4MOcsUmmrYn1OcujD2ao9kauL
	Soq8wmVz4O/OeapGBDjrAlUd71bTVdCeto8CK/3qybO/90i5tLFFxnxvrP2aD/qXsPKWIk8sU15
	RW7B4zB/MFCc6yJrrAq48ETayXi5L8YoP13ofKWVw9jIXMVra/sGPl2LTpMT8Za7hlQqmnEGp1O
	xPURW7DkwMUWM0cB0GcqVLhl1b0longqgbnh/lIl/gWSCX0wb0RWIilO4V/u0fL/xBjRuySEYQP
	wE5owVtLovOwMiGXNDtzCQyHRQ9VRI43tv1Y5iBEQSKewFRpCy3O7mUX58vPnJKtuxU2CuXuTXS
	pG81EtTA2goiirKP0/cU=
X-Google-Smtp-Source: AGHT+IEAFUpwy9YyLhSCGMZ/kQuTAA3iwfbEpQd1MDgVvquhbXlSq99pqpi7zF/bJ0OEdeyJIf4Tkg==
X-Received: by 2002:a17:907:3f07:b0:b04:7ad5:b567 with SMTP id a640c23a62f3a-b07c35be704mr853139866b.16.1757821904788;
        Sat, 13 Sep 2025 20:51:44 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32f35cdsm661712966b.92.2025.09.13.20.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:51:43 -0700 (PDT)
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
Subject: [PATCH RESEND 40/62] init: rename free_initrd_mem to free_initramfs_mem
Date: Sun, 14 Sep 2025 06:51:38 +0300
Message-ID: <20250914035138.3631173-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250913_205146_800764_D6AAC5F3 
X-CRM114-Status: GOOD (  15.56  )
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
 arch/arm/mm/init.c     |  2 +-
 arch/x86/mm/init.c     |  2 +-
 include/linux/initrd.h |  2 +-
 init/initramfs.c       | 10 +++++-----
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 4faeec51c522..290e9f9874c9 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -437,7 +437,7 @@ void free_initmem(void)
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
+void free_initramfs_mem(unsigned long start, unsigned long end)
 {
 	if (start == virt_external_initramfs_start)
 		start = round_down(start, PAGE_SIZE);
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index bb57e93b4caf..c7ca996fb430 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -981,7 +981,7 @@ void __ref free_initmem(void)
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
-void __init free_initrd_mem(unsigned long start, unsigned long end)
+void __init free_initramfs_mem(unsigned long start, unsigned long end)
 {
 	/*
 	 * end could be not aligned, and We can not align that,
diff --git a/include/linux/initrd.h b/include/linux/initrd.h
index 55239701c4e0..b2a0128c3438 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -7,7 +7,7 @@
 extern int initramfs_below_start_ok;
 
 extern unsigned long virt_external_initramfs_start, virt_external_initramfs_end;
-extern void free_initrd_mem(unsigned long, unsigned long);
+extern void free_initramfs_mem(unsigned long, unsigned long);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 extern void __init reserve_initrd_mem(void);
diff --git a/init/initramfs.c b/init/initramfs.c
index 8ed352721a79..7a050e54ff1a 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -642,7 +642,7 @@ void __init reserve_initrd_mem(void)
 	if (!phys_external_initramfs_size)
 		return;
 	/*
-	 * Round the memory region to page boundaries as per free_initrd_mem()
+	 * Round the memory region to page boundaries as per free_initramfs_mem()
 	 * This allows us to detect whether the pages overlapping the initrd
 	 * are in use, but more importantly, reserves the entire set of pages
 	 * as we don't want these pages allocated for other purposes.
@@ -676,7 +676,7 @@ void __init reserve_initrd_mem(void)
 	virt_external_initramfs_end = 0;
 }
 
-void __weak __init free_initrd_mem(unsigned long start, unsigned long end)
+void __weak __init free_initramfs_mem(unsigned long start, unsigned long end)
 {
 #ifdef CONFIG_ARCH_KEEP_MEMBLOCK
 	unsigned long aligned_start = ALIGN_DOWN(start, PAGE_SIZE);
@@ -707,9 +707,9 @@ static bool __init kexec_free_initrd(void)
 	 */
 	memset((void *)virt_external_initramfs_start, 0, virt_external_initramfs_end - virt_external_initramfs_start);
 	if (virt_external_initramfs_start < crashk_start)
-		free_initrd_mem(virt_external_initramfs_start, crashk_start);
+		free_initramfs_mem(virt_external_initramfs_start, crashk_start);
 	if (virt_external_initramfs_end > crashk_end)
-		free_initrd_mem(crashk_end, virt_external_initramfs_end);
+		free_initramfs_mem(crashk_end, virt_external_initramfs_end);
 	return true;
 }
 #else
@@ -744,7 +744,7 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 	 * free only memory that is not part of crashkernel region.
 	 */
 	if (!do_retain_initrd && virt_external_initramfs_start && !kexec_free_initrd()) {
-		free_initrd_mem(virt_external_initramfs_start, virt_external_initramfs_end);
+		free_initramfs_mem(virt_external_initramfs_start, virt_external_initramfs_end);
 	} else if (do_retain_initrd && virt_external_initramfs_start) {
 		bin_attr_initrd.size = virt_external_initramfs_end - virt_external_initramfs_start;
 		bin_attr_initrd.private = (void *)virt_external_initramfs_start;
-- 
2.47.2


