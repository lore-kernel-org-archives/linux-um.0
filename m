Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DD6CAC597
	for <linux-um@archiver.kernel.org>; Thu, 18 Sep 2025 05:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oiT0MrcHOyv1UJl38CIIzCgovK63Js+Y+q9YvsvWIlo=; b=hIFrMSHRhEJtoCq8lyQldUK8Ar
	LvgWDvTu4s1YyEwliqI+xesRTpEWsCSb8PVyjaK2klNWbr1yoPnDtXMYZUqarwyaYIrLKrQK6OYGF
	0BwJBeO3tna9+XlhLABiPwuqyoi4Ff7+4xbISYYK8beaAVlF79lm4yyJP/1qFoGJvqRUEiBFC4mU0
	qtthoKA5bZyoLoHJbXdK+GXMNA0iH2xJyu9jRz8CKBhdou1TfY1TqLhhifLeNeWSjfOzYInk0IKj+
	WXnvEkiad/ZT5DxIPsna6MiWrCNg8QnP2/XlCkc12G++LiAJfiJ9tLKFm3RGhxUweVaoK9mhVzKfv
	i4916I0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz70Q-0000000GI5I-0eOr;
	Thu, 18 Sep 2025 05:16:30 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz70L-0000000GI37-1CF7
	for linux-um@lists.infradead.org;
	Thu, 18 Sep 2025 05:16:28 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-77796ad4c13so397909b3a.0
        for <linux-um@lists.infradead.org>; Wed, 17 Sep 2025 22:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758172584; x=1758777384; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiT0MrcHOyv1UJl38CIIzCgovK63Js+Y+q9YvsvWIlo=;
        b=mwDAuHoQqQtMdMU7HYdvbBx9XQghxWPhlQIj98OaeRn3aFNqpSWXvrM2dVY60JcVmY
         YO6eacBVzq6kmbyxnaUnVccuioa7qiF9KZ3kTf/1gQgotNZ4okLcW4WiqGIA9eJRhY8d
         nkfQCu38UUfsWPo17fDmkpMMKlSJexltUel0KgFMBO8gmT6RtS/DsVC34yjCExqHM/tp
         NIymfW7MU9KFBWLQxpzLib6b6+f+8DZK1bkbm0MUc/Ea3x2Si8rvR/SwvrtLkhjz5X75
         tC7O8exkvJ6o6yDtRy0st7Rd+N0y9vWtvRb4E8Dh/usEFFbINFJXP7HNM2bYMQ30u+fa
         r5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172584; x=1758777384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oiT0MrcHOyv1UJl38CIIzCgovK63Js+Y+q9YvsvWIlo=;
        b=eHHojWcw7cyfosjMlvMObgmB66c7X8Rl1MNcU62NvRKLoS9aZr/t3vzx31sfUi2FQv
         TTsrVBd4vAJ66gGhW+Dfd5Zjqt2pgafA7LJZ0gQvNBLBO7IUfJ8cdRci7hBti6PA2QFZ
         Q3iIMW2hh6GdwL1HN8ouczTsGbdUqQtIbUsWwfF4i497vWHsLzLuHziONJBH256+QFzQ
         icrnrAu44UWZBc0QMhzOfZXhOiXdOmzcPeXZk96tt/q2HMzI0oKCxfNPEc3CDtNhjIfh
         lvq4QkdxerkLnhRErJ1Bc2vWTEWEbK4d8k9pJdcFYSig/rGKicvSFgTOryEo6X5JScJL
         V50A==
X-Gm-Message-State: AOJu0YwN14MMdTEKENbxXaR8XjoHiQ62CkeFPjLArhxiZ2IaQBZbly9O
	xjbK3nLLIo7bxo8T39EwnUujYzMBIeBF6xlMPdeXMfdN8pPFj+zj51pw/IO3pcM6
X-Gm-Gg: ASbGncsG0Nje0eMj0cHYPgm6qJv8SDKxnlIvAZlkRRSYm/lKk2Z2U0fplxQEV46iaFz
	U+r8l65pnpR3y9ebOoqzz9qtWpoQk7YepNgNq32OJaXXO57zVHh8VwhyQm6Av8R670QG4kjufYc
	gY5+4RF5EwUQZoPy4D2470LEuzDNeYeKkD850ZQncE7nukI2PqjH8Zvj1OE+zp4nSjLkDOB/yEw
	tJU2DPmn8YuZoNUucfC1C8/SsGhY30fLmZtsq2OgBVtJrdK/sIRI6azg13WEzFJBJc3+oOL2K2V
	4ftxjlo+WpZxmcK5WPqvwBDEpG01hjfeGpqhvU6hMJsXkIdU1/rQYrasVvwU82P9lKEsnz51GlJ
	22Pg0qsrLyzhEqjXmX3GZswE01q8PJFvg8RPmH6xTX/bSaBJPtdW1e4Td+4TTj1a0+By/uS6VJw
	lwaZkUXh7vnQHZ1j4kELIeBA==
X-Google-Smtp-Source: AGHT+IEa23dRQySwPPnr5ub15MBlqUEyaqoSvqVGNsNzpQT7Ye8yNYnLRaw4EeZooTnvYHDwu7FgGw==
X-Received: by 2002:a05:6a00:887:b0:772:8694:1d71 with SMTP id d2e1a72fcca58-77bf45c2008mr5267793b3a.0.1758172583863;
        Wed, 17 Sep 2025 22:16:23 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfe7607c8sm1093015b3a.58.2025.09.17.22.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:16:23 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id B2BEE1061EE2; Thu, 18 Sep 2025 14:16:20 +0900 (JST)
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
Subject: [PATCH v11 01/14] x86/um: nommu: elf loader for fdpic
Date: Thu, 18 Sep 2025 14:15:54 +0900
Message-ID: <5a4932bbcdbf79facd544fec7e3d6a6969a40aa1.1758171893.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758171893.git.thehajime@gmail.com>
References: <cover.1758171893.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250917_221625_328933_45468D9B 
X-CRM114-Status: GOOD (  16.59  )
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


