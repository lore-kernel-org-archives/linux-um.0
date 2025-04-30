Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224D8C369D9
	for <linux-um@archiver.kernel.org>; Wed, 30 Apr 2025 04:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ukyNfs65nuvgTdhSkdJYZ2Y9345NLuFCWN/gVQv/aLg=; b=4bG+pdd0/GNv53Z22VvWGDUlQS
	3YCFj02peh9gOgApdPkyNF3Lc2391vg5US4FHt0IJBdc/bM6GSlwQyV/83liaQTjpU4QTmqJ1EvA1
	O62+6c108RlKAAdPs6c3gx6sGe7vqRQyN0fZ4NBktznIeLTOkQPcyKhKOZDRNV15FNPjZUWO1zMVP
	i9lCMtWX8rk+/L2dy6HYBcP3F5LUHhQBW3cOUgZcztUah9EBBRCvA2a2bj7+z2eKB77C8LdSkshlX
	qBxTBM22pYGgRWdh06ETr+jL9B3eNa+ph5J83VOzpjv2v2Stx4R+7zXV9d9FM3mdxRddLqYXwa1G4
	a2ZbOH/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9z4A-0000000Bffe-35S8;
	Wed, 30 Apr 2025 04:29:02 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9z2n-0000000BfPJ-2fXx
	for linux-um@lists.infradead.org;
	Wed, 30 Apr 2025 04:27:40 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-736b0c68092so5936327b3a.0
        for <linux-um@lists.infradead.org>; Tue, 29 Apr 2025 21:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745987256; x=1746592056; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukyNfs65nuvgTdhSkdJYZ2Y9345NLuFCWN/gVQv/aLg=;
        b=D7+PHkkb84R3MR52zjefn3hEbZ2e1eAWN9Va9VP8dahnupE9ut8HyMKK+3jLn16GYe
         gssuZqdZpkGvnBsB+ktlZQcZYPZRKggtJLYX7fDlW5YXThc69MHJnzGpgw08SfU+/pNt
         mCwubGkwSUIsnBleKovqFH35KW72Fz2RLTB9voo6Bk7Wd/IEtqEZLPpfaMiYUPaULwJZ
         O9ct+aeSEut7cNNK1CqVDrwApmzZVf3jhNHTG7r6IVEu5bnzymBEE7kku17uutqXwdMv
         fODSy22MClCWlJ5ZV8jg4o0maonZ6cUo6YD71s2jhVltD4FGFlaIvHGDRMaETQgmXmSX
         FkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745987256; x=1746592056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukyNfs65nuvgTdhSkdJYZ2Y9345NLuFCWN/gVQv/aLg=;
        b=WR3aJDqeob1Jfds8e8bEERlLNMcMImiJbYwnIh7j51h9HOU+lDwLbgAKtopiNB2o4w
         9AI7RF3XSFkALDMQHMoceIn40iAj8hQEbgCz8GlGexNr9Ogwwd6zcqWDaLZ/2hrHx6kJ
         HbGZMrgaxN2AdfrHESR8eIVwdP97IZ7B0/19IPL9NXZQsBRLCOlRuBeTPDxfVahGdy9K
         8/I3+yp+LUTjWBSmnE5j99EUZineqPItvlSvWRFCqpgBgUGdgEqIXpQsQwrF/pDG58NF
         eH8h3dEEwthzNr0wpO7B6CaUNRbtkX7hBRGzm2ffCVzIP0dxvq7YV1ILFnw3DAHOaOQV
         fGHA==
X-Gm-Message-State: AOJu0YyG7kVI/4B6UeK9daeTSPwWFeE7hIKnpJx539bkosyvHc2t6WCt
	YyeMuAFZuUlSLA7VCJ40LyrtW2MRY1oJPPulKLg6csYHalB5g+9P
X-Gm-Gg: ASbGncsWpzOiDIu1A7e0wf5TuMVpYOwP14iqbV0cFOtibP+HDgZp356MQS/TpX0iK/f
	22jCssRA4wNHnH0Bir6cQcDHOl7mppp5E8Qgv8WNcDpmtAHn0SJId7zHS3b4Wla7h9LImoVU4MV
	GAkfwVD9LIN4yHtpsb4D83lztAhSNJcoCjVGp2q6ERu2/9q2z47KyKQAY3azcHLTksIM0xpCYtz
	Mvnr+tm+6vqu9kQZXWl9KRqs6WJQKS6gaJ/B9t3iEFa86aa5nZVY8BmyGYZyEAcNdQw310ji4PB
	9+MeRBzDZB5zH5RCGtbkb8uTFH+vJN38kkMc1Uagw5otPMYK/Gfbcw2zqEf8nyGSfvFgnwGriuO
	GQdNWyTzTaW0=
X-Google-Smtp-Source: AGHT+IHaI2hva/XO5UNyBlcemnxgGJqm96jqA3suKBcAYtlVKSOpmAkCAY78xziMTfLiN3rWee/VXA==
X-Received: by 2002:a05:6a00:2e24:b0:736:39d4:ccf6 with SMTP id d2e1a72fcca58-74038989daemr2827463b3a.8.1745987256524;
        Tue, 29 Apr 2025 21:27:36 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-740398f9ac3sm621129b3a.23.2025.04.29.21.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 21:27:35 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id DC01FE94814; Wed, 30 Apr 2025 13:27:33 +0900 (JST)
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
Subject: [PATCH v8 01/12] x86/um: nommu: elf loader for fdpic
Date: Wed, 30 Apr 2025 13:27:07 +0900
Message-ID: <1f0ec32dbc49f8784995a29a2e87063507eb9838.1745980082.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745980082.git.thehajime@gmail.com>
References: <cover.1745980082.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_212737_673177_6CE53BFE 
X-CRM114-Status: GOOD (  16.84  )
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


