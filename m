Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF29FC7115A
	for <linux-um@archiver.kernel.org>; Thu, 19 Jun 2025 01:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AAQlIsbb3rspPlz+RCx7t45Zo7U4vMMrJR2HDEEY2UE=; b=eV1GPXyHpFpWEkEP3mZiwc+3Ph
	zehxU1383DKgtuPLg0kO3WT542eiw4Z4npm6lyBVdfrVpMX8HLK1cbbpQcJW7LRuCqukvJtgI313E
	iVZI5oP5vjgMUCzdvwllrDmUIVwSpxMS0uSHLhBfBJOUGT2B76V/Zp36x38BP+LqFdPF+V/QmL6HW
	tH6KC00AXvWVIYjvkAyhRJu5JL4zBR0YmEtPGZ3CaDaTAVw0/F7q1beTiPGlvRmvENGGmq7GKtzmi
	n5C2fDET8UY6GehOkzg1jXs+QhSr2yNDE32YIDD1HGx2wOVPJlifFetU+QszXzUyrb0qBNjROOC+q
	Kq7g07Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uS3hp-0000000BgXG-29Ik;
	Thu, 19 Jun 2025 01:04:41 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uS3hn-0000000BgWe-0zbJ
	for linux-um@lists.infradead.org;
	Thu, 19 Jun 2025 01:04:40 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-748c3afd0dbso143474b3a.0
        for <linux-um@lists.infradead.org>; Wed, 18 Jun 2025 18:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750295078; x=1750899878; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAQlIsbb3rspPlz+RCx7t45Zo7U4vMMrJR2HDEEY2UE=;
        b=aZjyiJK5nkXTsrIIrBMhB+bPPqbHBXLjioOIPaU0DBxwdjPDDXurdsjdDba8s1og77
         451/Kkiqe67Lmkh/30BE85hfA9OQ7wqrsk8Qa8tHHig5jwNGwMMHluYBAjCXejHjDVrD
         kfFTvinod5pWWEvulrNUJ87NbhdAyBPjeBGvUeX+iD2oGsiuwXlfrhsUsHz49fdZzLaG
         oxgaCCzoNXJD7IeLNv6625Z7CftGQceiqeSGyE3n7HYm51hwuKnhIyiTI5/mgcVreF1x
         sdSwCR1Wl+NoeaXco9cRPosyqOLHp2RJxXjvcSLsRwL5bWEa2Y66De1ma+HcNz0aWB7k
         HhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750295078; x=1750899878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AAQlIsbb3rspPlz+RCx7t45Zo7U4vMMrJR2HDEEY2UE=;
        b=RjiV6ABDicSrzWE98KVlen5qzy04IG6A3xqNnn9z1C8mB/ueR0rvMkns+9LJTTJ/Wy
         XPd8T8xkvWjoYy6PhC+IASYWPCsAd+sBW9rcvvp4zEeWsnOq7QqaPDyEdusV5IiglLkQ
         yB/zqoM96lJMKfyrzQV9KsDTJMxEjWqAxLNFCBnzgNjc/sC9hLhI8/SUQmUB1daZc+rx
         B5jP5ER1EsaEUVmWDpk3B3TKPG6f8FpEHnBU5CYzMnMXbU3cdOIPBmK+Dwds+bY9CQ7S
         AxZOwSroCzoeg+MuMP76dSZDJ8vtQZNFD5BIGvO/fpBGLCUBJRdtrkGHgAaZW2nqSs41
         ld8w==
X-Gm-Message-State: AOJu0Yyq4qBgdP/VMCb+FF6K0t8JXGVZmOWljusKn5gs0U5Zt3hYdwPZ
	qdcpXnvDkIf0oWix1kgDuqHnQknawmLCtZAo+T2NsCoZpdiLtGgiFzpC+ZPBWYzP
X-Gm-Gg: ASbGncvLN989SINrHoRRTKqWYZ6b/4xPTBU4gFNLBSaWYlNIUlkTtHldGJTOot83VTK
	dMX57DW3R9YHm/Maw6pqznMmUD7K593neDI/3RVLH4K6ZdWv2zsrO4ZwL1K3/WoT1jZr1fBl4ig
	wWLmmIF/PGroBTLNsrMMcSsIIK1MffmGOyiJQnQILUPzdZuei52x54gRr9IDg9D0whGHmIvI8ch
	lqz3oK+swc0tepDcj1vEzhmrLZU2Qk2hHff/IaV7crR8TKYaEY1pWF19QX+/bGDz8aePPf8EkVm
	5O4rYNJtCIqFGirWTfeNoqS/+qVxbVYxOsfzCOXvvIdSNQEfg1hSdYxqTIHhbSYP0KcsXr39IN4
	lWLE0Ykl92XfT874DM63oE0COioZ6KkY/
X-Google-Smtp-Source: AGHT+IHB2DycC27BBHn6mGZ870nAohm4fuY2R4YYnJOfQvt0vJB8Xb8OYArORQprvedXyVNuZmFy3g==
X-Received: by 2002:a05:6a00:21c3:b0:742:a334:466a with SMTP id d2e1a72fcca58-7489cf97ddbmr27854811b3a.12.1750295078389;
        Wed, 18 Jun 2025 18:04:38 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900829f7sm11794405b3a.87.2025.06.18.18.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 18:04:37 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 1F350ED652A; Thu, 19 Jun 2025 10:04:30 +0900 (JST)
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
Subject: [PATCH v9 01/13] x86/um: nommu: elf loader for fdpic
Date: Thu, 19 Jun 2025 10:04:05 +0900
Message-ID: <e09d413c2c32673469730d90a5852f94ddd18cf2.1750294482.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750294482.git.thehajime@gmail.com>
References: <cover.1750294482.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250618_180439_281818_32D0937B 
X-CRM114-Status: GOOD (  16.64  )
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
index 4d0e4239f3cc..e9661846b4a3 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -17,6 +17,11 @@ typedef struct mm_context {
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


