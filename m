Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA585C02188
	for <linux-um@archiver.kernel.org>; Mon, 20 Jan 2025 06:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ukyNfs65nuvgTdhSkdJYZ2Y9345NLuFCWN/gVQv/aLg=; b=BN7aBZ5SgYjU06Vychy5IH1mhh
	OgQjyH0c2EMb6caJ5SV9t43dzcInOVEHFzh4z79CikOCLLCx6o/BZnSoF3xlqMnjruwoB6yXUNyva
	jUkVh5hKrj+/lfiPGmeTXN3xfKLSbm2iAdoUyAa2EyQFd8yKXs43I58T58vjtlGfzbFtIpsWvbCtx
	NtPWCgbvVP3l6YZwh1NZDS+XS83rqhjY+uggpjxLn/8r3mWDw4k0HMhEKnklkP9vBJF2zbJsXhKZl
	6NM05+yp3rp4dvzIZZFaT5CyaJkLD0FHpnBiFEsjpz4Y7oB6sE+EAM6LFswJs6GvysYvcVpF+msz8
	EuyBDsCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZkqy-00000004nMP-3Eyy;
	Mon, 20 Jan 2025 06:01:40 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tZkpn-00000004nBa-3bl9
	for linux-um@lists.infradead.org;
	Mon, 20 Jan 2025 06:00:29 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2163b0c09afso74995655ad.0
        for <linux-um@lists.infradead.org>; Sun, 19 Jan 2025 22:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737352827; x=1737957627; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukyNfs65nuvgTdhSkdJYZ2Y9345NLuFCWN/gVQv/aLg=;
        b=HmsY60cJuoAVAdMR9aPtDiiK0Gmk4HNpviTymRBRPfmkv6285jHamHsoqlCK4Ew87B
         kr+7+SqnI/VxJRo2+1qpMSyhbzVTKDbyP/RFqTchksm+sO5Jj/tBRdOTNq+O8xu5WBT5
         uU0l5n8vv5aSYMJMUnpiQORfS0IFAhUu2V0T4HJzqt4FJ0E5UAWbL95oNrRbnGVCMkFq
         Sl8JHfaV/qlkIN4JmuWpUDAD++qhQu2eQbHNnhxAItSUui8TUrFmxkCVIeORX8p1mQ8e
         NDWyXn53X7hxVcYYNOdm/ulRWde8nKEo6wm8G7kVxJIQwfuDgn7FwSNJLoDpWgZ9U3le
         PgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737352827; x=1737957627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukyNfs65nuvgTdhSkdJYZ2Y9345NLuFCWN/gVQv/aLg=;
        b=TYFEJMrs00Ds0JCzPyXbNzEDP9Wi1NVhNQl8bGAzKgKt6VkLFxWiJDFdR8nJsjeYxL
         sQsHeAMnuQ0M0I+i/99m1CNpSQZE9NH2vKBTYwYqKQcs3Qoz2NPs5nQtJaQiZmdXdbEf
         wYFbPQ8rFg2nceSWTmhmqL9gcKCtSGVjcqHeg4oFvX4JGEqKsbZZzWYYCeE3xN9FDlXg
         NvDnbJbAq7pzS2QgH2bshgcHUmahp/KZb1LDxGnLJnWK2Eg+9pLPMVqxyYe57jM64xvk
         Y6GO9fGHf/Q9wl6ycRDoTnWK8yurxi59Pgjh8HxAvot1InwLmn2wiYCoXYMV9GSxUE0r
         cc8Q==
X-Gm-Message-State: AOJu0Yw8KpSIOyyEoGpAuZXEJcMlVyGYdG0rnE14kxahO9YwM4HS9VNl
	zJpSzy58yGc2LRzVOIKYH1sm5TdOiML3bIqAqTOmm9q5Tr1IcOmj
X-Gm-Gg: ASbGncsGZDce2wDXl+JeVhIULxBkCcdHg6ZondZSxWVqvhzl1euz67aLcGSQiS7ZSSg
	20ztsY7WgqeJpx06Lh5gI7yafcquPoSzb++EEwA9INPX8sBJwvzbwlV8WEZPc+5lUlBRgQfkHoL
	j89+YDCfbmPtRIFIlYU1/ABI3HbrRMOmgXcraIjQhUd0gP8s5/hSkT1QduP7F6f//9zXQw/I3nX
	YhIiazggU6VOekbxxqCj4fKrqJ+HwIZzDDIRXU5yN/YOBDPPB7L3pFHrT1xuOYCMjQitnXheN/3
	4RDUNA+qDkEs4jf+0dKIp2/m86/MbsjWqU4IfpCdRw==
X-Google-Smtp-Source: AGHT+IEHeuTXy8q3JvsQ/TcxbAalRbkjb77Hq4RpM8tf7n3KtZQMqCH3X3otCgb8yHvy546rNESfFA==
X-Received: by 2002:a05:6a00:4fcb:b0:727:99a8:cd31 with SMTP id d2e1a72fcca58-72daf97b5d3mr18400418b3a.14.1737352826972;
        Sun, 19 Jan 2025 22:00:26 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab9b9966sm6149948b3a.86.2025.01.19.22.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 22:00:24 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 8684EE27526; Mon, 20 Jan 2025 15:00:22 +0900 (JST)
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
Subject: [PATCH v7 02/13] x86/um: nommu: elf loader for fdpic
Date: Mon, 20 Jan 2025 15:00:04 +0900
Message-ID: <d9dd391ee565aa3ad1b8ceba5689caf888f6bd85.1737348399.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737348399.git.thehajime@gmail.com>
References: <cover.1737348399.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250119_220028_306168_77B6751B 
X-CRM114-Status: GOOD (  15.94  )
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


