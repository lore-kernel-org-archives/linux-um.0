Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093D5CCFA04
	for <linux-um@archiver.kernel.org>; Sun,  2 Nov 2025 09:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7GAo7QPFRSMtQ+F+v51lXmGXWMCiRMzi5C8xvTtplUQ=; b=cveYzANcQW+vobtuqMq1dq87rk
	ECDJ8GyacjBboEYP8Kt1/Ad1tP9E0+87dsO36p1VFvLKT6uTT9/sL2v9ijrP18HZfJDUClxizfntK
	wqcYAwBUtUTVHEzTUYDyqnkG6Yle0n6+OCrUER5Jaq8vzkZN+NOdtpLkh0UBVoBqqvfBymQMWNBfc
	85+U0V2sIPB8C3dqo37YLCivORhFXBMz8Mzp9hcjSXsXaabdERKXnThCYckQASTSx4ECpgM2JpmWz
	10I+ZL5ENGME9krnibdAviQUCKpmm3BHKloIG71UWXl5iITWTSSBPhGNC7MzE7uWTR0h/3O/vUGCa
	5rChaGAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFUig-00000008RmF-32kP;
	Sun, 02 Nov 2025 09:49:54 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFUie-00000008RlO-2Ccx
	for linux-um@lists.infradead.org;
	Sun, 02 Nov 2025 09:49:53 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-781010ff051so2795177b3a.0
        for <linux-um@lists.infradead.org>; Sun, 02 Nov 2025 01:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762076992; x=1762681792; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GAo7QPFRSMtQ+F+v51lXmGXWMCiRMzi5C8xvTtplUQ=;
        b=TNj6Kc7KXQ3gMJmyv8Ej528rcnvL3w5HwFFs7rheL+OuiTC9prBlfX+fy4gJzvNWhi
         yEFW41Lmg1bkXqnI4m1l8abcBnAX7MvBDhEo5OMfU6NysDz0QADGhA4Ik3zWgAkgE+xD
         V97WG5aicvfldMdmZj5r1aMrvTGR2w1lW+aq0xQNvL/DKWRKiUp5c4ktZFUMaatIyE0Y
         n8v579/aZaZP0cmrViU+AqBIn+N85CdJ+YZjaRWRQ6XwisXg2X2qLuSvtYPUd4ad7tav
         4ENGkKcUIu90SPBJjmjZUsuCq3tFVJa/75rSDSEANQsKJFFTAk/kUM1FrFPyBCWaoGr1
         JvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762076992; x=1762681792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GAo7QPFRSMtQ+F+v51lXmGXWMCiRMzi5C8xvTtplUQ=;
        b=abWykIkk2AAy7GS8vhd2+KeSKzpAkjI+xdlY2QIwRQuH7vJWJSyLujz5cXVC0Ikq8R
         ewZE+rBBr0K88zR7XhkzxbQhp8thvDE2REIs4fROIq6BZ7TRqDq/QBY26fJ9akApvbXb
         SOOJUTlGEQ/B1m85oHnESiZCk9effR/RYnakxgIHK8J9uOtkNmgJrCWScRU8c+yUCR80
         NxntDujeA2eq/XIahUji8bxRtWF8gKp/fgV+uQNyVhxrrfT9E0fWCTZnM1b3KHgBI6Oc
         EED4wczyh5lZoAvzww6FmCHmsomuQAWpBGaSOHAjTD/EuXKQM4rsf5iL0jQEo8muKYxB
         SP9g==
X-Gm-Message-State: AOJu0Yy9Rlt62ztwRpIv1kYpHMWJ7nBUVx66Itm1pUadXkBgCsBYpN5B
	/xoIc5tuVfo5ifVQoDmbIl0dH8KF72U7agsjAJIS+zMPe1BQzhcHGyif
X-Gm-Gg: ASbGncujaSkVS50zB8k/g4sdEKpsmT0ACLcch8RPzy/s/JbU9Wuz6OaqPVTBuVILUR4
	4pCHFbaRZAmqT4dbCAmclc7roncp818WZwdaie5RKA/HeCpnEfu61Y/SAMIExzP6WCQ2RpaTtZd
	1iT4ullN6fzMi0Dw+vGNAaOqEk05FtfO044LaDE6z42XokldoKl8t8LtEIk0fTPqkp0FzOOgduV
	8cUXTUvmHCisgfoI5y4wcGPKT782Dyaa1RHy08+k00TAG0k2X7AteiHDjN3EaZkf3LZ2bXwJkqs
	OdnZpWQIk20RKFT1oGKjMY+RlY0qxLsY8s8aHQG+T+hseYea6NdfyX49FOtoQXS20dmyo1/EVD5
	NeLZyJu1EGTTSkiFA5Y6VB+TRcqh0hnQqnjOkO31jZCUHcU2avG4o9r//4ci457U5i8zspumNHH
	jNTaBN90JtjTS8W9Qj9u5zso794tBJmO/cPLC5zJ9/PK8D1w==
X-Google-Smtp-Source: AGHT+IFjPZCZPoz2w60NDnASz0MjN7TYV8NIqgCnj6gVUAWRi7VL8ewmGqOYXuj4ykHVff4Lv7oBqw==
X-Received: by 2002:a05:6a00:1793:b0:7aa:d434:69d6 with SMTP id d2e1a72fcca58-7aad443af35mr506394b3a.10.1762076991691;
        Sun, 02 Nov 2025 01:49:51 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a9bad978c4sm2738154b3a.13.2025.11.02.01.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 01:49:50 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 0072711237FF; Sun,  2 Nov 2025 18:49:42 +0900 (JST)
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
Subject: [PATCH v12 01/13] x86/um: nommu: elf loader for fdpic
Date: Sun,  2 Nov 2025 18:49:26 +0900
Message-ID: <d0537389ac18acb03ae3bdaf25473d56f7e74f4f.1762075876.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762075876.git.thehajime@gmail.com>
References: <cover.1762075876.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251102_014952_568597_7EC24F23 
X-CRM114-Status: GOOD (  16.30  )
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


