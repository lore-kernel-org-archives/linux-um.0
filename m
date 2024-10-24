Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCA7CE8E67
	for <linux-um@archiver.kernel.org>; Thu, 24 Oct 2024 12:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PIytQe80ylla7Sl/fe5LxDRRHtWVNhv8vhvelm/o17c=; b=fFF9TTeC0UIuf59K7fRXtnfzbt
	O5idPHkqdvNjyENwyHjtISmbYcp6YfOmkEcRsop92dKdkBwZnyaoVaAhgITgioXBwdkEDQPdHLrhp
	eskqdY5X3RRgb8QK+bi4HfdUjgA0VnvmUYWKGIuVDO19v8WX3ukqVtJeoL63mpPo0LC5XXKKNsPSR
	DuhWoeH6/A2VWrAk9bBWLdcEciKiE+U1FeG/yh3/NkBf5wS0+OO929n4OfYzqODv/UV5Trse1kZaQ
	+Dp0fmwJTesgSB0XiQRTSPwdhSFiDWe3xG2DwtIthwyptuJJp/Q33tKG92j93idIzXrQhM5EQfT8T
	ypRu6Yzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3wgT-00000000Ip5-0BUY;
	Thu, 24 Oct 2024 12:11:21 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3wf9-00000000IXG-1hgn
	for linux-um@lists.infradead.org;
	Thu, 24 Oct 2024 12:10:00 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-71ec12160f6so563585b3a.3
        for <linux-um@lists.infradead.org>; Thu, 24 Oct 2024 05:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729771798; x=1730376598; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIytQe80ylla7Sl/fe5LxDRRHtWVNhv8vhvelm/o17c=;
        b=UWDTUQd169OUBNg78YN72ROhSf/gYolZcAXclp4AKRb3bYZ1J4z/kGVhX0VWnWIec9
         XmzbDIkvEtTFuzxr50gKiZy9FPOOdDdI8nK3iKthUvHbQvumOSfJM+xGVS2+NZaLP4T+
         uNKcGefVdCeVRBL3ILNxDEGftrm4ZFTuLqfx5lIUGd6FBTadKyKKrkF8N6nYysM0IYES
         nzsCRL8DzUJyN0iAqEtpfx2ZdJqoUshW6WJ/iCmPwfCJrk6s+b8NfG65qufZqQaEc9VR
         m2oZbGay7BvndXIESYkWtI61z75qzc8WrLgzELw1EiCQSENxJsAhPnju8zAXFHi4D+cb
         dyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729771798; x=1730376598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIytQe80ylla7Sl/fe5LxDRRHtWVNhv8vhvelm/o17c=;
        b=YXu/jpWd2F8cMmz5PSTmO3c8B/D6h4yO6BZGU2W05k1R8gSKNQK6Dukm8PTf0PXXiX
         UcOrPvxvt9V7thco+b5m/blHzCCvuoInEKe3GWqeHWI5lEXRUN439LaYRtMTyD3j/IIq
         V2LeqqFftzZXMPtb0V82I8mfFnmBgU1/+F0wUWX1e7S4CYSmESdEA6enJ331ltCfAF7a
         8qZ3y/lnTbf8Egzo3xlSBV0IC4sDTLeArGwPxtxssI7W4jA/14cR91U8PYVC1smRhI/q
         YngNudBxyq7zvDsOoqt2WD33OdFYBUMtnxjf9VXmPRXKsJztm0lDSeU7g5AB6KDWiXJD
         VyDw==
X-Gm-Message-State: AOJu0Yx+TVnA8Ih3iHl+0tmlXfEsGor1eWLTzpdZa4PuXJ/SaBbhE9wX
	OhWKuJixOnOdXuK32viEHCAUz+TAja7MfEPgIP/OTXwO8x0ztown
X-Google-Smtp-Source: AGHT+IEWx31qom/T9NynWTwcS94S2CIs7HjdghwcESDW4t/deHJ+ZjzUUv7QSQwXyIjcl4756ZTDog==
X-Received: by 2002:a05:6a20:43a7:b0:1d8:d3b4:7a73 with SMTP id adf61e73a8af0-1d9898fda0cmr2115741637.4.1729771797871;
        Thu, 24 Oct 2024 05:09:57 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeabda22fsm8492096a12.88.2024.10.24.05.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 05:09:57 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 4C46BD5124B; Thu, 24 Oct 2024 21:09:55 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org,
	jdike@addtoit.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 02/13] x86/um: nommu: elf loader for fdpic
Date: Thu, 24 Oct 2024 21:09:10 +0900
Message-ID: <db0cc5bc7e55431f1ac6580aa1d983f8cfc661fb.1729770373.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729770373.git.thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_050959_469695_571320B4 
X-CRM114-Status: GOOD (  17.93  )
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
 arch/um/include/asm/mmu.h            |  5 +++++
 arch/um/include/asm/ptrace-generic.h | 17 +++++++++++++++++
 arch/x86/um/asm/elf.h                |  9 +++++++--
 arch/x86/um/asm/module.h             | 19 +------------------
 fs/Kconfig.binfmt                    |  2 +-
 5 files changed, 31 insertions(+), 21 deletions(-)

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
index 4696f24d1492..fefa7631394e 100644
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
@@ -44,6 +50,17 @@ extern void clear_flushed_tls(struct task_struct *task);
 extern int syscall_trace_enter(struct pt_regs *regs);
 extern void syscall_trace_leave(struct pt_regs *regs);
 
+#ifndef CONFIG_MMU
+#include <asm-generic/bug.h>
+
+static inline const struct user_regset_view *task_user_regset_view(
+	struct task_struct *task)
+{
+	WARN_ON_ONCE(true);
+	return 0;
+}
+#endif
+
 #endif
 
 #endif
diff --git a/arch/x86/um/asm/elf.h b/arch/x86/um/asm/elf.h
index 6052200fe925..4f87980bc9e9 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -8,6 +8,8 @@
 #include <asm/user.h>
 #include <skas.h>
 
+#define ELF_FDPIC_CORE_EFLAGS  0
+
 #ifdef CONFIG_X86_32
 
 #define R_386_NONE	0
@@ -188,8 +190,11 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 
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
index a3b061d66082..4f7be1481979 100644
--- a/arch/x86/um/asm/module.h
+++ b/arch/x86/um/asm/module.h
@@ -2,23 +2,6 @@
 #ifndef __UM_MODULE_H
 #define __UM_MODULE_H
 
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
+#include <asm-generic/module.h>
 
 #endif
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


