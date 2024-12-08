Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47969E7717F
	for <linux-um@archiver.kernel.org>; Sun,  8 Dec 2024 10:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=imtbBrBEkPVKtbCA/xxwe0ZEaWgNsfGZobwNJy/U71E=; b=Pqp3JMge5ZoPuah8ac8QqT6mwq
	4Toa4HETyCSVeM8UU2w/6GEHQuBvotkCCNU99/ww3hbn9FAiGTp3h/jvN2qVCnHXqla0kG/f5hEt2
	u4YDsfrpU4G2lfO9TWRFbZZjHlVaxJZBHk/LuI4Q0XowUGDW5xy/q4P+8Lb9/DLu1eJpvaST/5TjU
	DoIWpHJ6Gv+fMTGpjQKxQ80/QBEtsK66vI/dlOpfNwkRfVzFx36Fa6qgH+ytjGlMbNvIPhwtODp50
	TbloBIuDOEDlvJdtGzoyF0frnv4Mo4sI7Yp1qTU6eyUF+HSrir9CfglYbf3oVWdDhA4O+bQC6LWN3
	9ksBXtyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKEKU-000000057Sz-3qKu;
	Sun, 08 Dec 2024 10:15:58 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKEKS-000000057RH-0fE0
	for linux-um@lists.infradead.org;
	Sun, 08 Dec 2024 10:15:57 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-21649a7bcdcso651095ad.1
        for <linux-um@lists.infradead.org>; Sun, 08 Dec 2024 02:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733652955; x=1734257755; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imtbBrBEkPVKtbCA/xxwe0ZEaWgNsfGZobwNJy/U71E=;
        b=fFH7mCWDBl+qYrVJWcje7kvJYmSvmkcPvLcJm6bgPFOlcuSOUAZGqsADQ2L/iK98yu
         wkOBR7DDkP5dOSwyxQ6pXwDylp2VCAxqKxHvaYhozyDni8J0B2BFunCQdsECLb67kkIR
         +F0+neA/o4ftHOVirB4SfJX8MGx46LJ0ZcHcXmRU7IcBIylqPdyPYO+IUGMsH97xXKcv
         8+bZrJhrR29ClMJ+G3JKQHKca12aBiOnmXD6ZVNYJ0UG4bKUVpwBM1OFuC7u2WNoFoXJ
         xCgRH+wIkLfhOTdjXPisipe+im86qXHn+jF5HwAsOkDfhrWBWm/JCk5WlzT8lRkA6V41
         CQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733652955; x=1734257755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imtbBrBEkPVKtbCA/xxwe0ZEaWgNsfGZobwNJy/U71E=;
        b=l3JGSFbwccHkrgJ+EeeAXgGpU4jSKkRjZPQl9dc+o2ZLwEwlQq7uzjQ9IFCSwkl5Qe
         dU2fzileUhHGPj5lDJ81YUx2I3ecnitRJOFxyTjlqxS/mwiWKRMIKOCC3x0+9Zu0ayLo
         OQYVKN9NIwsLr+vtI2jqJuanbc0KI9Rpd8ujwfOayol4rp6GMJYyJ5i0gc9UnGV/ndFf
         mVjMj6sNpP1pTmH+3JWHyOxo1ssWF+0e+D1KhZIC/6KhybBrnOizdZ+qt8u5c5+o5wZb
         i1jrz8/4wa433Uz+DZim0HVNR4ZJ8uG/9Ub4mtK1G/x/UMPptyL6O57/GaXiigWqTwtk
         udNQ==
X-Gm-Message-State: AOJu0YxpGBEn5Ur2iD7+099e/5P3jvDyWLgT/fqSXvEL0vGztZpImBRP
	guU+359N1/ofD7B1MDyzL3yJ6boJV55w44AKPJgaSXv04nXXtWHA
X-Gm-Gg: ASbGncs/UGPrgnGCw+i694q8wJ43zlpJHxOUCjMD90oxZxWsCzg8cFtBTyRggRQaZPH
	pNLcBtnDjJF0xc1r1QOmEg9uO7kNBWBBVNxug5f09wn2pyKSQBLHpzwyT0UJ49zZdOeWv9ZKUDI
	PiGcNaA/YhIDAx/R0uMvh5g+wWS5yXi6BDlVoqZ2Y7w4Vnwhn/1WYdFWGpJO8r1da7fvtBp2vua
	dKnkd9u3APX8T3GnpeIuFpYl/+ZhGO2e/eo72krj90Ky6F65dI6hHCvma785rx7P5lM2zFwCjeQ
	3FOlo2H+K4Dusdz32Eki
X-Google-Smtp-Source: AGHT+IFQct9SApUaLux90fR0aNxlzm2wMoioHTPd27lhStCGrHuRbObEG0AcO2vIjjIL4fIUoZbNUg==
X-Received: by 2002:a17:902:f54d:b0:215:5bd8:9f7b with SMTP id d9443c01a7336-21614d456b1mr116100605ad.15.1733652955174;
        Sun, 08 Dec 2024 02:15:55 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8ef9ee4sm54638735ad.161.2024.12.08.02.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 02:15:54 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 17ADBDDB022; Sun,  8 Dec 2024 19:15:53 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 02/13] x86/um: nommu: elf loader for fdpic
Date: Sun,  8 Dec 2024 19:15:29 +0900
Message-ID: <d387e58f08b929357a2651e82d2ee18bcf681e40.1733652929.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733652929.git.thehajime@gmail.com>
References: <cover.1733652929.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241208_021556_200557_8B6F247A 
X-CRM114-Status: GOOD (  15.66  )
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

As UML supports CONFIG_MMU=n case, it has to use an alternate ELF
loader, FDPIC ELF loader.  In this commit, we added necessary
definitions in the arch, as UML has not been used so far.  It also
updates Kconfig file to use BINFMT_ELF_FDPIC under !MMU environment.

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/um/include/asm/mmu.h            | 5 +++++
 arch/um/include/asm/ptrace-generic.h | 6 ++++++
 arch/x86/um/asm/elf.h                | 8 ++++++--
 fs/Kconfig.binfmt                    | 2 +-
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
index a3eaca41ff61..01422b761aa0 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -14,6 +14,11 @@ typedef struct mm_context {
 	/* Address range in need of a TLB sync */
 	unsigned long sync_tlb_range_from;
 	unsigned long sync_tlb_range_to;
+
+#ifdef CONFIG_BINFMT_ELF_FDPIC
+	unsigned long   exec_fdpic_loadmap;
+	unsigned long   interp_fdpic_loadmap;
+#endif
 } mm_context_t;
 
 #endif
diff --git a/arch/um/include/asm/ptrace-generic.h b/arch/um/include/asm/ptrace-generic.h
index 4696f24d1492..4ff844bcb1cd 100644
--- a/arch/um/include/asm/ptrace-generic.h
+++ b/arch/um/include/asm/ptrace-generic.h
@@ -29,6 +29,12 @@ struct pt_regs {
 
 #define PTRACE_OLDSETOPTIONS 21
 
+#ifdef CONFIG_BINFMT_ELF_FDPIC
+#define PTRACE_GETFDPIC		31
+#define PTRACE_GETFDPIC_EXEC	0
+#define PTRACE_GETFDPIC_INTERP	1
+#endif
+
 struct task_struct;
 
 extern long subarch_ptrace(struct task_struct *child, long request,
diff --git a/arch/x86/um/asm/elf.h b/arch/x86/um/asm/elf.h
index 62ed5d68a978..33f69f1eac10 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -9,6 +9,7 @@
 #include <skas.h>
 
 #define CORE_DUMP_USE_REGSET
+#define ELF_FDPIC_CORE_EFLAGS  0
 
 #ifdef CONFIG_X86_32
 
@@ -190,8 +191,11 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 
 extern unsigned long um_vdso_addr;
 #define AT_SYSINFO_EHDR 33
-#define ARCH_DLINFO	NEW_AUX_ENT(AT_SYSINFO_EHDR, um_vdso_addr)
-
+#define ARCH_DLINFO						\
+do {								\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR, um_vdso_addr);		\
+	NEW_AUX_ENT(AT_MINSIGSTKSZ, 0);			\
+} while (0)
 #endif
 
 typedef unsigned long elf_greg_t;
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index bd2f530e5740..419ba0282806 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -58,7 +58,7 @@ config ARCH_USE_GNU_PROPERTY
 config BINFMT_ELF_FDPIC
 	bool "Kernel support for FDPIC ELF binaries"
 	default y if !BINFMT_ELF
-	depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !MMU)
+	depends on ARM || ((M68K || RISCV || SUPERH || UML || XTENSA) && !MMU)
 	select ELFCORE
 	help
 	  ELF FDPIC binaries are based on ELF, but allow the individual load
-- 
2.43.0


