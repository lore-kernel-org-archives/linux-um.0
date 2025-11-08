Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCE4CCFA18
	for <linux-um@archiver.kernel.org>; Sat,  8 Nov 2025 08:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hjmnnaJ+dU4QzslBxUrlmdhSXDXCpeTGjd28jp/dBEQ=; b=3Ym9J3GFmXoz7m4IFws5qc5olr
	TBeDCuce7AEVh9zsj3hj5VlOP8gKFL8xz6KWfCLfaCv6oXmJ+Hse55SUidqIRktfF/2RBZqF0tgUr
	Xd+ZjkOtY0qV56sfbOOpVIk5QphNRy2v1VZauiWjF1Zkr/QZRwjy3poA/J0SOxVs7hXIeIFKWY3aO
	m2rVQjOvX5Iq+Y1X+VsVkhY6nBHtRUr9BAumprfNOhM7KK3yJMpfnVfQcWF72yJTCM8dlI+9sdnUO
	xLEWqYwNZdr2kgssheT3tQcDNRaQozPGWHO+F3QwpAUYDw7xuAsp20wSNMBSXOFkkTM8c5ZELHs+1
	boJCyEew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHdxQ-00000002iqN-1uYk;
	Sat, 08 Nov 2025 08:06:00 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHdxN-00000002ioy-16jz
	for linux-um@lists.infradead.org;
	Sat, 08 Nov 2025 08:05:58 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-297e264528aso4770205ad.2
        for <linux-um@lists.infradead.org>; Sat, 08 Nov 2025 00:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762589156; x=1763193956; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjmnnaJ+dU4QzslBxUrlmdhSXDXCpeTGjd28jp/dBEQ=;
        b=eF8K8ghEOQCzqed+CE5/0YSb4ZChXpPNYAIRfUYuIb/fOdfyeES8mwK4Gb6oj1XloQ
         twDXtzwkhHHEcE10NBX0k/eAs0Aqa9VYZztWkzWxftxO+9j+d7eyeCEYbqEMZZRrUpab
         DoHcAu47rq9sp2FvB5YT7A/nmxsa78SBepnY/NB3AoITzrRwSp8jMB099qwG1J5fEl9q
         eRlaImrtfpCiCIURFXYKtt2b533oZxi+HRWYuzI8glm/uFQl1UwP1tRDKuke0+bMxa49
         5UIfjN6LmHc/THy1oqxBPh7kRZl7/m7qZg7cxP8h+AdAiZ2tlejSQAMnbh2uUpsgimnB
         sNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762589156; x=1763193956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hjmnnaJ+dU4QzslBxUrlmdhSXDXCpeTGjd28jp/dBEQ=;
        b=stXGo4UKsUUtQUyBGcrECeFPGZnvX6TJKCwDmAnAkwoEQAUb9Vx6mYWXHgTgMsX6d6
         sJUPSPRoW4MjIuADIFO9aiKgQF97j1ru9DIkVX5gkhEnCuvUWaRswr1pM72nVFS+Z4Xu
         gPN4tliNwfy10Uu0FuEaHW+CHTNWvOOhOh7pjBXvVqTt1QtIZ4gvxci50CxHI14TVZlc
         SoZefN+JUz9sgbMDQxEE46fJ0HKpDc5NkzZzVM0e+D9mDO0aiinhCQlvwtpot7iLAty4
         oP7jxRun08jYe4ArXPgIWlP4WBS7EepOhelfV2rW9uvqRtt42hLAzTxwcoo2DbuoYolK
         UThw==
X-Gm-Message-State: AOJu0YxQXllxeTLEBMvcP4v8eS8j8U097ZuqdR0NF0do0K3l1EcYmk9I
	W1hFxhMCDQ8P5RPmrZ1gKBjJAiaWZEvvL3rfcSrAbDRTns2ognIBxMTA
X-Gm-Gg: ASbGncudCdbIo7Rf0gW6z5/ES8Ox+Rjrli+ic+jZIa/O3cWYY9/cqW15HNe7yYWvFvA
	tWpChR9pM5G4XeMGCq7IKygJBDiEOuMVPFBziS2YUSMrMmlJN9fwJjuLF/mXIThaPHMMxLAQF65
	MrqQivnVhSnYEzApSwPeM0dhyemsktHed+ZbUSZSUYxjkak0VsUgdojOgAi3Twmv9YYIEpO1muD
	F5D4Fm09WbOwA00cblWuUB3LXViIQkYJLAADlGloZY+uuJJLGGCJftSFwYvGguR33m0dnsUX8pp
	AcibtP5hguZZv+JaVu5zEiL5o+HivBch5NN2I9je3t8bJ4KWDbJcKR3Dw+UIm2WHRpExMrx0hfq
	EmK62wMukBSsKpEV/5OQcP7d24O9Hzztuvhm2g5XoH486z3vo2Eu75McPYYHHtSgbij1LX77+08
	qiYnoYgQsFDRGYOmgsGeWvolL05WseipDNSSUbZX6dCisDXlFszoAGlgItTilHlr1LIdI=
X-Google-Smtp-Source: AGHT+IFNIgTTAZ2Vl2vkAxBvJV+q8EYjnppJ5K0pIHpzL9Ue02aCEVYgWqO6SIqSBUirhrY7QzbLaw==
X-Received: by 2002:a17:903:ac6:b0:295:269d:87cf with SMTP id d9443c01a7336-297e5619d74mr21459175ad.5.1762589156346;
        Sat, 08 Nov 2025 00:05:56 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096b801sm83340945ad.7.2025.11.08.00.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 00:05:55 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 0019311388C7; Sat,  8 Nov 2025 17:05:53 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 01/13] x86/um: nommu: elf loader for fdpic
Date: Sat,  8 Nov 2025 17:05:36 +0900
Message-ID: <59210140957e95ab0df73125bfdb035913a468b1.1762588860.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762588860.git.thehajime@gmail.com>
References: <cover.1762588860.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251108_000557_416864_A9C45CFB 
X-CRM114-Status: GOOD (  16.03  )
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
Acked-by: Kees Cook <kees@kernel.org>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/um/include/asm/mmu.h            | 5 +++++
 arch/um/include/asm/ptrace-generic.h | 6 ++++++
 arch/x86/um/asm/elf.h                | 8 ++++++--
 fs/Kconfig.binfmt                    | 2 +-
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
index 07d48738b402..82a919132aff 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -21,6 +21,11 @@ typedef struct mm_context {
 	spinlock_t sync_tlb_lock;
 	unsigned long sync_tlb_range_from;
 	unsigned long sync_tlb_range_to;
+
+#ifdef CONFIG_BINFMT_ELF_FDPIC
+	unsigned long   exec_fdpic_loadmap;
+	unsigned long   interp_fdpic_loadmap;
+#endif
 } mm_context_t;
 
 #define INIT_MM_CONTEXT(mm)						\
diff --git a/arch/um/include/asm/ptrace-generic.h b/arch/um/include/asm/ptrace-generic.h
index 86d74f9d33cf..62e9916078ec 100644
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
index 22d0111b543b..388fe669886c 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -9,6 +9,7 @@
 #include <skas.h>
 
 #define CORE_DUMP_USE_REGSET
+#define ELF_FDPIC_CORE_EFLAGS  0
 
 #ifdef CONFIG_X86_32
 
@@ -158,8 +159,11 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 
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
index 1949e25c7741..0a92bebd5f75 100644
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


