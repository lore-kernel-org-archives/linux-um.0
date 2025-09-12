Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349BBCA101F
	for <linux-um@archiver.kernel.org>; Fri, 12 Sep 2025 22:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q9iQK8EdIF6RRP4HkX18/uU6rY0egPm6PmmgTdmDikE=; b=gs1gQ93neAoRSLPC8acuNB5EOu
	VZTxM9Gj9SmikquvZnnucRxRDWZx0g5GvocTeW0Qq7SyXpYAsjuSoANk+jYJsI+y00Zmv+NWVfTh9
	3EM9tpI00G9ZAjeAVpDxp9eQ0tptz4Ab39G3LK4oLIePAdod4wTUYw98L4QjkHeX/NsczNJGutsZB
	pBPMtlYoU3yJwywN9LJULkb7c18wB5RfynxZVI7lG7vHxo1R/ret4GL5blw7BsJLS/M+y/sBD2xf0
	5WKDKfgojnizYTfww6/83oB6+7DoFij/ZH0bWNn0CEVlZ4rmOIPhWUgPk7L/9h+4wiVeDBAiZo/Ie
	cAMzWXtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxCWq-0000000BvpE-2l1r;
	Fri, 12 Sep 2025 22:46:04 +0000
Received: from sender4-pp-o95.zoho.com ([136.143.188.95])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxCWo-0000000Bvnc-139F;
	Fri, 12 Sep 2025 22:46:03 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1757716883; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cYmkTWVTcQlLmLr5V8p1CrwhziHK5jWEHqN1/x0dbbnP4N6eqwJhNpFD+YvvcG1JcA1pILR0lg+/Ny7uiewAqWrYp0xgwBVqCid/qUwxU2pBACMW8E+qi9+gH5uFDpaMNSKBUmBcqwPg32DVp6NEprKLCwOzLldRlExaYRgKRTw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757716883; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=q9iQK8EdIF6RRP4HkX18/uU6rY0egPm6PmmgTdmDikE=; 
	b=Ju1dqMVIkIYpU5LdsWBIf/CGwDsN0K99qbvJhITUG43b4iO5ReBci570gSrCvJZpIaavRZGeh519zGwQ3xzl9eLPP7B/6fd5qSQvFqfvp30skE+0PjF0wF1ZPM088gDBmx9lu1/Hmu9iiGaXsgt143EyXlTcYz1mO0b4E8ZkWow=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757716883;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=q9iQK8EdIF6RRP4HkX18/uU6rY0egPm6PmmgTdmDikE=;
	b=acIupnwFZvyRH5FokPCft4nvGFUMr39pqEpKs0NtNZVw5kg9Xyn8fLnVwVnsMrYi
	icAGCn5xQY/D8nPVu8I73mfObC5kAiAiUgDDUOK0dT7tuN6mPBE7LpoJ79v5Pcf1s+2
	+A3prhgVdkGFxaNK2Z8tJ6RB7TjqHAI2HFOwbXVs=
Received: by mx.zohomail.com with SMTPS id 1757716881894668.1339002049043;
	Fri, 12 Sep 2025 15:41:21 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
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
	patches@lists.linux.dev,
	stable+noautosel@kernel.org
Subject: [PATCH 03/62] init: sh, sparc, x86: remove unused constants RAMDISK_PROMPT_FLAG and RAMDISK_LOAD_FLAG
Date: Fri, 12 Sep 2025 22:38:38 +0000
Message-ID: <20250912223937.3735076-4-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250912223937.3735076-1-safinaskar@zohomail.com>
References: <20250912223937.3735076-1-safinaskar@zohomail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112274be46f51a3e6d7b65453b8c4000084fba7464352cc4dc9cd50377fd7f09b0684ed62a16f1e6eeb:zu08011227aebba3291345918c920d3b3a00008f86ff3411911b832b8b206255ff0b95bb9fe1592be8b5327b:rf0801122cd997ff081c6a0f543772417b00002b369a2b05bf7efffc2b9c1c1140566e0d80ce0978fa409c151951bada9a:ZohoMail
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250912_154602_339122_E8BFC328 
X-CRM114-Status: UNSURE (   9.33  )
X-CRM114-Notice: Please train this message.
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

They were used for initrd before c8376994c86.

c8376994c86c made them unused and forgot to remove them

Fixes: c8376994c86c ("initrd: remove support for multiple floppies")
Cc: <stable+noautosel@kernel.org> # because changes uapi headers
Signed-off-by: Askar Safin <safinaskar@zohomail.com>
---
 arch/sh/kernel/setup.c                | 2 --
 arch/sparc/kernel/setup_32.c          | 2 --
 arch/sparc/kernel/setup_64.c          | 2 --
 arch/x86/include/uapi/asm/bootparam.h | 2 --
 arch/x86/kernel/setup.c               | 2 --
 5 files changed, 10 deletions(-)

diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 039a51291002..d66f098e9e9f 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -71,8 +71,6 @@ EXPORT_SYMBOL(sh_mv);
 extern int root_mountflags;
 
 #define RAMDISK_IMAGE_START_MASK	0x07FF
-#define RAMDISK_PROMPT_FLAG		0x8000
-#define RAMDISK_LOAD_FLAG		0x4000
 
 static char __initdata command_line[COMMAND_LINE_SIZE] = { 0, };
 
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 704375c061e7..eb60be31127f 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -172,8 +172,6 @@ extern unsigned short root_flags;
 extern unsigned short root_dev;
 extern unsigned short ram_flags;
 #define RAMDISK_IMAGE_START_MASK	0x07FF
-#define RAMDISK_PROMPT_FLAG		0x8000
-#define RAMDISK_LOAD_FLAG		0x4000
 
 extern int root_mountflags;
 
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 63615f5c99b4..f728f1b00aca 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -145,8 +145,6 @@ extern unsigned short root_flags;
 extern unsigned short root_dev;
 extern unsigned short ram_flags;
 #define RAMDISK_IMAGE_START_MASK	0x07FF
-#define RAMDISK_PROMPT_FLAG		0x8000
-#define RAMDISK_LOAD_FLAG		0x4000
 
 extern int root_mountflags;
 
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index dafbf581c515..f53dd3f319ba 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -6,8 +6,6 @@
 
 /* ram_size flags */
 #define RAMDISK_IMAGE_START_MASK	0x07FF
-#define RAMDISK_PROMPT_FLAG		0x8000
-#define RAMDISK_LOAD_FLAG		0x4000
 
 /* loadflags */
 #define LOADED_HIGH	(1<<0)
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 1b2edd07a3e1..6409e766fb17 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -223,8 +223,6 @@ extern int root_mountflags;
 unsigned long saved_video_mode;
 
 #define RAMDISK_IMAGE_START_MASK	0x07FF
-#define RAMDISK_PROMPT_FLAG		0x8000
-#define RAMDISK_LOAD_FLAG		0x4000
 
 static char __initdata command_line[COMMAND_LINE_SIZE];
 #ifdef CONFIG_CMDLINE_BOOL
-- 
2.47.2


