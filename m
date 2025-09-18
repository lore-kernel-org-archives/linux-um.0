Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE723CAC59A
	for <linux-um@archiver.kernel.org>; Thu, 18 Sep 2025 07:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oiT0MrcHOyv1UJl38CIIzCgovK63Js+Y+q9YvsvWIlo=; b=NezmPQn9ZtRwzsPiqfG07WrjsL
	2U0TurZXvbIs3xWIAVCTVbGRyZZsSw6EoOfXu7A31OigGUoVXzf28yC2thYIVyTCDz5t0dKOKBWBn
	srO+3uHkN5Rw8pgFNrqrYjaUKNuoQ4a8t37pzq1RdreOFrq7s8s3NbPD2oVTr8NcKveMzdv7LyN3V
	MMZL6tcOC7cAtpesr4sF6PjlyQzrEFIqOXy3Vit6orJWcWH0CqoLtoEqOaYPiYjPjrF8qfvz1gBSy
	3apv7eqxBQBxCmmoOpyepYd1Su8icvKkJbTJNUnh1cWmSmxPQ34w0gEwuNF/UgBoXwrJCxLGyjEe+
	SqscVpoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9Ef-0000000GZ2z-2p73;
	Thu, 18 Sep 2025 07:39:21 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9Ee-0000000GZ1b-0vlQ
	for linux-um@lists.infradead.org;
	Thu, 18 Sep 2025 07:39:21 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2570bf6058aso8623715ad.0
        for <linux-um@lists.infradead.org>; Thu, 18 Sep 2025 00:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758181159; x=1758785959; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiT0MrcHOyv1UJl38CIIzCgovK63Js+Y+q9YvsvWIlo=;
        b=aaLu+I9FRw6/2SKuIGARexnrQWXjiNVF59LMVQJwxk3r9+l3t2PsNCixFWVqyP2yhR
         62rWkzoG4zX9+LTIahi5NAfeCYe8b81Yb0oVrEgPvffSzZ+cTIRRrimHM7TuwjDmg1FQ
         o5ps6TdIBuvBnuGnm6hlGWaMCFrdNmHqB+0ClIclz4hjcmd7RHAbpcdHItn4Nx4cNwtX
         ujfQTrOspjeD5/G+owYvI0u8gaEK8OlmP2VndaSIENf0POvTTM9mSkYeQQ+OX4ETWahn
         SEnKYCaRXPY7yvmZpdNKRZEQavcEQ71X6n02HfnRuCM3MzLD6ira6Mk1++mOGcRfrU87
         93ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758181159; x=1758785959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oiT0MrcHOyv1UJl38CIIzCgovK63Js+Y+q9YvsvWIlo=;
        b=H+qRAT4glH9cR38Gzr1KCzd7SaQeaaIJix06TXpaSq+gwnlkAZ6FZe3F3Xb8pBdii5
         rCPj6lMRSnnyK6rE+HzYypugCL6z7ONq9d37XG1dO5fbKWn9Y6AdIU/oHRttraW6ehP/
         hmgCvqRUiLGq+TjCW6LJEnQOD9QV+Pf4uZ8KM/a3f53uiATIFR2y32d3/2SXH/dXdnfV
         ECdjR3bMTfRMK+3RN6uQCwABAQqrkHbQhgqv34nNnOb6bQr95e1A71MA7JHEqUnxyOx/
         e6BEF77GmPSLlEt07MMwVvBVILhDr3KGCPJNeDrHMGTbu9R20LZf6kHcGwI/Jws/Bw2H
         eLGA==
X-Gm-Message-State: AOJu0YyXwFzrDOiDanN6nT8gSKa+UbxJciRE+fBaTfjDXwER6E2/sBQX
	7tzmI/sIFV1/Hn1a6mId4vk+dPEFs9dUkk8tvIxcAw/qKKY/tMLGZdoh
X-Gm-Gg: ASbGncvivVqlkZPXnROdJTLyLLdJruB+Ck1wAk88+FjQVH4uW5iYmSYQltAmUMdWIMe
	anSOeoEGI9zK62MNoSlptzp1+gDlo16AKqRmVYEm98TBAkw6mUHAe8SvTiCqbCEITHAfYnqW9NB
	L6k8VVMHRekVeUMzEZcWpDURy7fYLCtvCAaUiKtO7340nSD5R3nHHfdj7Xc/a2wpoLyZA8yoVgA
	K6+uaZcAJfztjESG0kFpxxOyiT/QsX2j7PJxyBjhqjCqZnpoXyGsmXsSt7IWN1as+qXmHbXXkOZ
	DW0eP+Bm/FaIUWTIdF5n3evmYKQZgSiIf17IU7A8S2D2KdfvvQztvgvEOPBjrY/bYsYN5XJ1F3F
	y7yMC6Y2TN/DW7RlM+LOg7/L2ZTzQG7uHI+L4o+I633ILDQRljSFF/vogVcBbLsYxwpRHp62dsC
	wpAYptSEgq6KM=
X-Google-Smtp-Source: AGHT+IEhAan4I4Yy608aj+94bqPtnH0sZCzGPXalqh2iDtPG1/N54CnlninxatIc4ohWkAdwd6ge3w==
X-Received: by 2002:a17:902:d504:b0:24c:af64:ae11 with SMTP id d9443c01a7336-26813903478mr67341765ad.44.1758181158787;
        Thu, 18 Sep 2025 00:39:18 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed275fb3csm4555900a91.20.2025.09.18.00.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 00:39:18 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 4BB8A10620FC; Thu, 18 Sep 2025 16:39:16 +0900 (JST)
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
Subject: [PATCH RESEND v11 01/13] x86/um: nommu: elf loader for fdpic
Date: Thu, 18 Sep 2025 16:38:56 +0900
Message-ID: <5a4932bbcdbf79facd544fec7e3d6a6969a40aa1.1758181109.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758181109.git.thehajime@gmail.com>
References: <cover.1758181109.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_003920_263244_32FC9AAE 
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


