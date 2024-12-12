Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8DBE7717F
	for <linux-um@archiver.kernel.org>; Thu, 12 Dec 2024 10:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=imtbBrBEkPVKtbCA/xxwe0ZEaWgNsfGZobwNJy/U71E=; b=dYosg1Ip9/67DsJvQ21BCmlBpO
	t3qPxIh7xcj6cTiLW5TpEijjgTq18kF7DFyaUIrMV36RziMYE/yMqyeCbeiLGlDSmXPwddDdCBnmW
	5JyhNhwWLgEqQVNRyMZWS6aDACNYbmsQFSvgWobTd4KPj+ti9S4NSpO8Srwj3ex03jczGS5fJwPIn
	MC1X6b+KjqHMKd5y2vv2GfOYKmtb7nZ2jJA1GJwnTBjZSCP9PAtHwuSIpJXEMeKqIaZVE5Zvd8PBu
	QkD3kkhtOQIvDEU2yaiyOYGokQ7tuqVHh49mJ4UhMCRyrXUhK8ugsphSXrzYcSG4RyDgSXbBuKC8X
	+QAzKG8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLgDd-000000001PN-2kiw;
	Thu, 12 Dec 2024 10:14:53 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLgD1-000000001Dn-3h3J
	for linux-um@lists.infradead.org;
	Thu, 12 Dec 2024 10:14:16 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-725f3594965so313056b3a.3
        for <linux-um@lists.infradead.org>; Thu, 12 Dec 2024 02:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733998455; x=1734603255; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imtbBrBEkPVKtbCA/xxwe0ZEaWgNsfGZobwNJy/U71E=;
        b=PfG6Q8hoGyv8FJ6Y7Af3oP3WrhP8+T6T34gP4exDz51MojTOyh5J13Vx2q1C4Yt77T
         82L9Ogy/FX/QJmVwlVXLpy7W/Wv0SAp3SzBj4YYbRMjWXooxK/W2gOQKiMoin+RxxD7D
         I9RAHb+jD3MmGyfWArRIcJBo+e70nfhIWo1nKEnhSfxEjfQ/Yh6e8xONesC/sggxgszK
         21R2Pl/tMrO8v+U//9rvEX9fuw+jtF4aSow6Z9BPvbUfPMuKLGtmGHFw89bwrs8GJ01E
         2MJ63cuhwUoG7esH4vWFaWRYBt15pP8f1L3gd7D3dmBsxGbmzJarALuLQUirIW5JXizO
         /ryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733998455; x=1734603255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imtbBrBEkPVKtbCA/xxwe0ZEaWgNsfGZobwNJy/U71E=;
        b=WaTBx+fwXOSym6QAYjtAhPcXx3g1a3+VXS+HH9T/Q696JkIPKHo1ypEuDqfKWwwgrR
         pfHi4k4jZplOz4Sri0ryRyb0cvast56CfpkDA8rjFbeE8ALHxOZYJlGkTnZgBn1O5zvK
         lxuZtlzlQMmTsZhaSQUmyqhcD9EDsxUPRvdm6/Qc8iYomF3dY74A2SKnnfjM7H2S61Tt
         HT0DYRGlgrcgvoHI4pbHE2sqSWjXZl82ARm0JeprddixlYKS6j1F7t4l4+1tlXEqdZ30
         PNgbmitl5cdjf35iYxeeikosDXLN/QDa4z52wWK7lv+Qghc++uPn0mPKOaQm734Lebvo
         NAUA==
X-Gm-Message-State: AOJu0YyLYpzTEo1dO/l10v298cRkPGiete64OVcOIYBzkclPhatnrNYS
	g0kEJ4Zk0/je49RZSGcJmGT9UqaP0k2UxokD9StL9isLrBXwoqXP
X-Gm-Gg: ASbGncsVfLkIfR1Og+QlR6e7SG0BhA7JCTtv8aNnFFdRTFUhh+zRP0Memj3APLspQU6
	dCapFV6nG3xiaxPBcVaHmLp54atIzXX43p4O1Wua3HjfQw9m3I5KsXCP5ak63SbUsTojJ7aINCW
	VSa8eqty+Illmjl9a4UL1kW/DRQ1A/RMp6oIGpQhl0fHEMszMW+2vFs868sFxRg+uc5U/rdy3YF
	k1O/rQGl7ZFwoZL4KXsV+JN1hD3B7ebBbh6YXthaOVg9U1vY8Fj2E5efPnB9ZLGLnhDgTcYA8Ye
	562H8UTWNgbAil/d/NDwTEKcm98=
X-Google-Smtp-Source: AGHT+IFVhbe01ozM68JjhYH4Ulu2767FV6uMDBATKo9A5IIcvIgwdzomTiXfbfiCL1mxVboFbfpF4Q==
X-Received: by 2002:a05:6a21:398f:b0:1e1:b12e:edb8 with SMTP id adf61e73a8af0-1e1cebb7f15mr4365029637.30.1733998454879;
        Thu, 12 Dec 2024 02:14:14 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd3e2d63fbsm8473250a12.6.2024.12.12.02.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 02:14:14 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 2DA5FDDEEC0; Thu, 12 Dec 2024 19:14:12 +0900 (JST)
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
Subject: [PATCH v5 02/13] x86/um: nommu: elf loader for fdpic
Date: Thu, 12 Dec 2024 19:12:09 +0900
Message-ID: <d387e58f08b929357a2651e82d2ee18bcf681e40.1733998168.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733998168.git.thehajime@gmail.com>
References: <cover.1733998168.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_021415_919621_3F3B6A56 
X-CRM114-Status: GOOD (  15.82  )
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


