Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C23AE8B38A
	for <linux-um@archiver.kernel.org>; Wed,  4 Feb 2026 02:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hjmnnaJ+dU4QzslBxUrlmdhSXDXCpeTGjd28jp/dBEQ=; b=WBWSgt5sebUjy7d70jSlW2+5ET
	6VUTZ3VSqWV2bwY6Yetb7eWnQCa7ZzIRAViWG/lsesy2ZxVwWec87sCschB9qbnKOy4dO/MqzFy9C
	IT4xwIKT1GBt8koY731dQU0LBXa/XoTA70eUH49QXzCW++JNwXSqxkrbjU0D8yEKKL+HYwUZ8WvwT
	1E9OdQNk7ccYvEIMIMM2L99CrHTV3myvl4knwty6LTYDHL1rFhfTaXuYQkWUD38Br5ivBxC/x3OOS
	hxJ4KtACWx6QnRQ7ENGUrnRy8n19tFUy2B01keTU9Hw5ZAzCcEE9BlD1ja6Fv1L1zrcWf9LIET8k6
	sAbgDj6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnScx-00000007m2x-00Dm;
	Wed, 04 Feb 2026 02:28:23 +0000
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnScu-00000007m1z-1vts
	for linux-um@lists.infradead.org;
	Wed, 04 Feb 2026 02:28:21 +0000
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-c2a9a9b43b1so3756886a12.2
        for <linux-um@lists.infradead.org>; Tue, 03 Feb 2026 18:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770172099; x=1770776899; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjmnnaJ+dU4QzslBxUrlmdhSXDXCpeTGjd28jp/dBEQ=;
        b=AVyA/6ZyhG6wCu+diC12u9HF1MW+xc+q0W6Ig2ZpYRELHakHJ00MIo8HDGnXjzrU8Q
         d0DvHtR9IC+vSRyLQWSjcboWlawbdkTP0F+S/zlMjQ78PxrgIT8rCzLPd9papNJihuW7
         P7YKPOwJ5kL5FWFAlKxnY7Yh4A+r5xmspTerbea1H92fZ0dAvLI1qifCA3eDOAj2SAN1
         Pc8GarQj54+yV2EaM3an8mDsEmmLgGjg9/GYnLgimYlSQUP147ha+PyHbDgaVh6Ty+zl
         gt2mm5i2yuQb13Cz3rDRCz0YKCO9XTHNaidoSojDU3kRe7ZgbAnFODgUXcQdTLItqwmA
         X8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770172099; x=1770776899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hjmnnaJ+dU4QzslBxUrlmdhSXDXCpeTGjd28jp/dBEQ=;
        b=vLEAEQXcMjz3hO2IHlY1s4I8r3fBXlgIS0OK6UuilJk0g1lfa3XqjVyV0FK2mRgb4B
         N8djNx1EMRYv/hyW3CadSgKj6892uZE3n0wHNFQaHIvNzl8vHTXMP6kPZ9wADcxhGRFL
         Y0Ka6+3lIzbpgKg3YeUXP43rp44HD0CKucKggqT/7k+M4+sgZlMRKUNOZbIRuO0gCDAA
         O8LlReB4mOLnelK7ztvBx3dUNGPib1gD8GI8KiVsGhJ36PkIQ4rV7kJV9zT1jOh0utdQ
         CfAMCek7IA31mGn871afO8FHdJ8SJhjRfgisJ5n96xsqdfYA0byAHkfNkVZ3Vk6me40y
         qarA==
X-Gm-Message-State: AOJu0YwZdYCsFm0Qd3RjfssrVGxu3YuSMGjps0ULakxyLduUZ6qlYsmx
	/i6uIsX2m4xxRMsQpxrhyhpN9QNRhtyJijF5mtix+477NEAQmdUKVEVF
X-Gm-Gg: AZuq6aIRZjATBRmE8qq0JRvA0P47YwaXoevxc5+HnwpqZQsbE0Hvskgjujw8A/DJU7a
	FyOAWGGKdi8Z8rsGfiE5fOGOl/rbzHQNQ6jEYozTfHWG5rCGbL4UF584wfOHZe9kybIEt1oIjaL
	mCwOJTcEXNrCgaRSEBJHcBjGJsY+BWqaYj4nQbmTfsx/K51NBkjcmmgcpLPm4C3sbmphFZIj/q+
	errNpGvi1NJUddV8eqZiBAlcVtpu1JEc4MChp1IUMh6rcTI3OzHId7REmwGQsKwvXKaViMYHQCw
	iKuE/hbJAVjRGp4V1QaulNjIVltrYYF1RoQuhAfZKH+D+RJSWnh6ukm0tEmAok+ugUuAP1Hza6Z
	6pxxW+D7KN+zclvz87RZPY9SmWlAUgxCnLAtd3/8cfN/tljg0DwnQUrBv8W1R4cb92ZtDFcv+tJ
	w3jTY24WMKDRAl0sbe1VtNkuoYIfjxqA+cCkvYokxlWFQ2EK+nF4TfnmveOhJKbzNI9NKXtOZm8
	eVGJndZDYYN83Xc
X-Received: by 2002:a05:6a20:a122:b0:370:73c1:6a87 with SMTP id adf61e73a8af0-393724cde89mr1471194637.58.1770172099431;
        Tue, 03 Feb 2026 18:28:19 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a93397c472sm6721415ad.89.2026.02.03.18.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 18:28:18 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 421DD1200C31; Wed,  4 Feb 2026 11:28:17 +0900 (JST)
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
Subject: [PATCH v14 01/13] x86/um: nommu: elf loader for fdpic
Date: Wed,  4 Feb 2026 11:27:59 +0900
Message-ID: <fa22ec46b0d78df65a005d4a33d05edebbbd381d.1770170302.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770170302.git.thehajime@gmail.com>
References: <cover.1770170302.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_182820_500601_438BE6DD 
X-CRM114-Status: GOOD (  16.06  )
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


