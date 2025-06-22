Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE2FC7EE2E
	for <linux-um@archiver.kernel.org>; Sun, 22 Jun 2025 21:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AAQlIsbb3rspPlz+RCx7t45Zo7U4vMMrJR2HDEEY2UE=; b=HWWlHQ18EteqbhePSmyzBCpY1Q
	oBGE2gm5meJBhu0Xf4oas6L2ghICActpYiJjvVaM9h+FSd1boEF4hKWbYzopQypeLkmld6wn8oN0K
	mMpKXJqGgW1DenHvnXZ85ZrwH85/QoTnr35VNxRzuf11m+kPATVbFDrB1heatV4pjf3Iar4WYu+pi
	CU++PeiPz37etiqReKCg7YhAJNlBKBBSwycB8LwU/6ZKnxogOBN8OUTQ7Y585efgohE6YCHWm5Kgm
	oL3IHpLYzooCCMtPv+tLZGo1qs/8arWwuzSgcF16Iza78Cl/GuKCb2iu1YgHI4ofvtK23N3gOAybS
	atbx8L9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTSKF-00000001F3s-1olr;
	Sun, 22 Jun 2025 21:34:07 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTSJa-00000001Er2-2Dmg
	for linux-um@lists.infradead.org;
	Sun, 22 Jun 2025 21:33:27 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2360ff7ac1bso23572415ad.3
        for <linux-um@lists.infradead.org>; Sun, 22 Jun 2025 14:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750628006; x=1751232806; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAQlIsbb3rspPlz+RCx7t45Zo7U4vMMrJR2HDEEY2UE=;
        b=EPWEplPdggFZkUfkXqj+/eEocFbQKR6tdhfIExfpoKRkgGqo8Y1Xe8yY6mytPBbgJ0
         zFvy1v/vYPy0qU9Wdh+UQl88TfeeTaEFCoq3cl0ezGbKR7IVFTqWFu/pmw5/DfnBHZOk
         nmnD6VeDG4DnqgnAhIKHKLfCXHpduRX2uXtIdoNk35kof0afQk4nbAN43jY3cuts4wBb
         hG5Hr1Kl865oFOAYiMQTGKLAJ06IJowtpdJkO8QdG00THzeh8CDxaspIs3A7rVMgfbp9
         TRX+XcaicRpBw8Kqahja7MBQi/XjN3b9bYqVzbxkLjfPUT37DZYzPRIdlrsNbRWtiMT3
         iLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750628006; x=1751232806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AAQlIsbb3rspPlz+RCx7t45Zo7U4vMMrJR2HDEEY2UE=;
        b=ql1usSBNNFSEZykiRZRUJ2kFN9NQid1D8nFtnJjWv4wPCrJlWM5t///oul6XLqHmJF
         Qarn50RklPzjojRTv2k85IjH+J2RqfP7xaUb7wUwVZMJ1/nhlNquMGrl//FkTXemSXDN
         AA10UZIEzWhy2YiCkFqpAP+rwipooQNoN3toTlmhYshS5IzQOxPZoQkQpsZnQ7Gx7ItA
         J5vOfE3iyT5yB1DwqNsUL1pvrzp/HmN8W/JJoDLC51igyu3Do4LbLQe+TTvD3mtoYDCX
         xKdQTmm4EkxzF+Q917StlXq3IpWnboKFC2y296pbl2S0k6whAIzDHN4UyDtCUR+hY3t2
         W+tQ==
X-Gm-Message-State: AOJu0Yzca6fENuqCkeP1fOKTDiQlF7yy/G6yJr3EfGcE7d+aLSa79+wq
	kBx3cGiQ4E6z42EdPmFwZHUBG4Ll+1bfWvLzvb/ZXuFdp7T3+0QRyVzm
X-Gm-Gg: ASbGncuVeXE8O+65W62M09RNO8vYUnys349ny6P9Vb6ANgiseOyj9RS75KI8LFGhF2x
	XUwLTdUTuxjB349b0G4C6oelYg3no0CqbwnUoRtSjOh+f8vjfzyjRLuHf2nczCwDOuI3TJ0qAI7
	+7cKOoF2DA3EKXJFmiB/fTRf6F0izwTSomJwdOTQfidUR9VAuK/YD1xdKsg4iOVA2Gg4YMaN8Nj
	tIR4FDigQp47hsHsZr99W2+Z43vSVx8Vbhc7vUKsaIpdMfSXGwcgTdmtLqjNWvwPYUiCCGz41xg
	ipoiDVMbyq14PyZsopNhQlOU+BvwZHclnj0LZKsXRbu8bG/XwqmvVPfQ1P5SuNGLw5xwA4Ua6uM
	1JeSufGIcfrcflhpdBs9VxIyxI9KsYH2t
X-Google-Smtp-Source: AGHT+IE/OyFdRvoMZNChjYSNeiwAt0sGgB2Kp3DYDGisjy/68Lf7lJEd62sOTC8wwxO80U6hLupeeg==
X-Received: by 2002:a17:902:ec85:b0:234:f825:b2c3 with SMTP id d9443c01a7336-237d983d1e7mr177001775ad.17.1750628005666;
        Sun, 22 Jun 2025 14:33:25 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83d5c97sm67821005ad.70.2025.06.22.14.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 14:33:24 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 2359AEF1EA6; Mon, 23 Jun 2025 06:33:16 +0900 (JST)
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
Subject: [PATCH v10 01/13] x86/um: nommu: elf loader for fdpic
Date: Mon, 23 Jun 2025 06:32:59 +0900
Message-ID: <e09d413c2c32673469730d90a5852f94ddd18cf2.1750594487.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750594487.git.thehajime@gmail.com>
References: <cover.1750594487.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250622_143326_563676_30F91B18 
X-CRM114-Status: GOOD (  16.11  )
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


