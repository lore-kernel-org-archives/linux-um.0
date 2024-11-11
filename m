Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F966D12D76
	for <linux-um@archiver.kernel.org>; Mon, 11 Nov 2024 06:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xOVZBEb1qaBKyIOwwQleK43822fSZbq/jfSKIeFdX6E=; b=cCI6GjdTdyj7Vr/6Bn6AIwkeR1
	pNWhkjyJpr4Ot/AtjkZQC5ZhQ0hGABQteiPpr2YfDy7o9VwL6iUvKNLZWH63gmt36ZOGIXjy/t3JE
	JB5M436FaEKiNwOvjnhbTxABbhPR65/j1ZfRYOIWbB11Twzp+39Nq/RGi6xhPi8F3fI3T2CeeG3JA
	RjYIOvQ4mQKVD93EQcx4j471s8BDhNXByXMJPZn3HOJX0O72vjAc7E/grXpvs8XfQWvj7jrHmp5OR
	leZ2bpcDKpsfYVr5lZ1B7Kyi6I+/SkgO94GASUV2gYdVBWSavouPMsxToG/IRgTtttG+Ozu2gQL4m
	KBaJWEbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tANtw-0000000GU8Q-3aKy;
	Mon, 11 Nov 2024 06:27:52 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tANtu-0000000GU7Y-07wi
	for linux-um@lists.infradead.org;
	Mon, 11 Nov 2024 06:27:51 +0000
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-7ea68af2f62so3187445a12.3
        for <linux-um@lists.infradead.org>; Sun, 10 Nov 2024 22:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731306469; x=1731911269; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOVZBEb1qaBKyIOwwQleK43822fSZbq/jfSKIeFdX6E=;
        b=OMBvK0V7w1sOJkNKnpQeTwftz8+q4NMLU3ulNL8EptT+iNq8/6KE10L4ed01KR+AUa
         B6hjEb13eYj3LZGVHMrEN6J0QHxrP06su0gQL9lLEJUGoFRPAHR67yabsuO5Z741F6KF
         Jyxlo9nLQVjvxR4usiqYudn48P+SGyCO9MC4ZPqfjm1Jnl0Fdy2cnIZtMixsUJ5XH74e
         gfAMCnzcnkW98biH7Pzj2R0U4/nFPIyeRTwFInemLGjcdOdW0d8SvfYztWpeiadAQ0aV
         chYNzoV+bQ/B1GTLa87Ry44kqxnIKeqZxgjGsS0mtlgbpXlTPPqcdrCr5p/JdICqx4RR
         ab2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731306469; x=1731911269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOVZBEb1qaBKyIOwwQleK43822fSZbq/jfSKIeFdX6E=;
        b=F5UeJ7x7ZTOhw7GzgsqG7fwjvm2fslAB61X+SEa8Dn6HLbcglIXhHeqBsMER3dCKDE
         q1PtqnvusNWc3x74s/aAZYD17wnn5EZe9H2xuTEsyr221eG34YpIyx0wF9FuQFNdylc5
         IM8NYomiDGiFvJOWcfLJyrI5DGqKEo7AbyEtGGEG1MUMW/jll/o/HD4rkm8Opre6I0+K
         x5XL4LXrmwGixVqeWH2kU8BtvHVcYgWJKeFjqpgaZdw5D5pbr3z3xoeKZA7oBCwsIUIM
         mYaYuH6eE1l2Se1c7YkVXUIhDo0u5urbeb2KhfIF6avPJeYmmB9lJ1eddPOwFhzPi0rE
         x5Kg==
X-Gm-Message-State: AOJu0YzvY3GuznXX10tqFPfVaGuO1qyWznKL0kmBGLJ17mX5MevShhzh
	wuExP0GjXdZ4bUumKhnNBH35D/ln/QGtCrqf6cruGN3nhPb+FwY9
X-Google-Smtp-Source: AGHT+IHr4mrXQCJG6ehz4R575ji8XJjfRwnS/MkIAJ3E4bPBw/vNBMDgKXMb0Ui2eNQcCUFveGlOmw==
X-Received: by 2002:a05:6a20:4324:b0:1db:f06e:f666 with SMTP id adf61e73a8af0-1dc22b91c5emr16383347637.41.1731306469013;
        Sun, 10 Nov 2024 22:27:49 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5f8f5d3sm7819534a91.27.2024.11.10.22.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 22:27:48 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 43199DBA916; Mon, 11 Nov 2024 15:27:46 +0900 (JST)
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
Subject: [RFC PATCH v2 02/13] x86/um: nommu: elf loader for fdpic
Date: Mon, 11 Nov 2024 15:27:02 +0900
Message-ID: <ea2a3fb86915664d54ba174e043046f684e7cf8c.1731290567.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731290567.git.thehajime@gmail.com>
References: <cover.1731290567.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_222750_092316_96E8136C 
X-CRM114-Status: GOOD (  17.84  )
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
 arch/um/include/asm/Kbuild           |  1 +
 arch/um/include/asm/mmu.h            |  5 +++++
 arch/um/include/asm/ptrace-generic.h |  6 ++++++
 arch/x86/um/asm/elf.h                |  8 ++++++--
 arch/x86/um/asm/module.h             | 24 ------------------------
 fs/Kconfig.binfmt                    |  2 +-
 6 files changed, 19 insertions(+), 27 deletions(-)
 delete mode 100644 arch/x86/um/asm/module.h

diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index 18f902da8e99..cf8260fdcfe5 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -14,6 +14,7 @@ generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += mcs_spinlock.h
 generic-y += mmiowb.h
+generic-y += module.h
 generic-y += module.lds.h
 generic-y += param.h
 generic-y += parport.h
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
diff --git a/arch/x86/um/asm/module.h b/arch/x86/um/asm/module.h
deleted file mode 100644
index a3b061d66082..000000000000
--- a/arch/x86/um/asm/module.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __UM_MODULE_H
-#define __UM_MODULE_H
-
-/* UML is simple */
-struct mod_arch_specific
-{
-};
-
-#ifdef CONFIG_X86_32
-
-#define Elf_Shdr Elf32_Shdr
-#define Elf_Sym Elf32_Sym
-#define Elf_Ehdr Elf32_Ehdr
-
-#else
-
-#define Elf_Shdr Elf64_Shdr
-#define Elf_Sym Elf64_Sym
-#define Elf_Ehdr Elf64_Ehdr
-
-#endif
-
-#endif
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


