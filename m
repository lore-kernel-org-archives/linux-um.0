Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF01EE6C5F7
	for <linux-um@archiver.kernel.org>; Tue,  3 Dec 2024 04:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jMDksIbcOLWGwD0vO5eo1YOj8LatyWo9RypORfUk9j4=; b=W+DlgZdHJq32kRG8PV1JFJS0mM
	aAydDbcOftC90eKZYJm5uvpkf6zITeTzeXDRuvPRsgbYxE79JmKRBtUyzZsbCsI78+iD23Xny0A8z
	WZbdZZtFtmFQrgSRZ7JAF96Ca5ifp1Gnvlpitd0yiisfH6D7/+g8sNSN6wBp1hsMXwj5cL/BDyxsT
	k8yWCXh/gSbjGOiWuG3nxn5JbMJAgiMkYM4AemTBtIMEVehwc+0HUGdktkHwwWS6OVMbTCrIpgP6x
	5wFbsnPU9MPZyTTeqQQLFpGPnmvT9UEBjNFhskc+JqNJuRokmD19t+c8eRRZbQceGhWHV1h7uqXmp
	nWIPLdmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKRh-00000008DGe-35LU;
	Tue, 03 Dec 2024 04:23:33 +0000
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKRf-00000008DFa-20zM
	for linux-um@lists.infradead.org;
	Tue, 03 Dec 2024 04:23:32 +0000
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-7fcc00285a9so2019956a12.2
        for <linux-um@lists.infradead.org>; Mon, 02 Dec 2024 20:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733199810; x=1733804610; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMDksIbcOLWGwD0vO5eo1YOj8LatyWo9RypORfUk9j4=;
        b=JLy5LGX5+V/QEtAJqingNEapVTiKDXsvklmq0owhYH1EdLXWar22MHDy1OJkzOyGGE
         yzHrg/GYQPclPqQxVE9yqzeKVgOpoGl2QrDtFKNs+HGRF4ODN5YlaHx6u8GxVNZXasLM
         0/kh9WoB6t9+dOgk1dmAkWFpDb5HaJmZqV8oFDs5SfN3XOCmdpNUh+lTNRNuVCMxS7QS
         kYWpSMe3ar/F8mNXzFePgI2n001O6Wfe+GywRe/gr0Ov+oJjsgc+8Mi8ZJc8UL4dlzQe
         PycLfZYbSwbl+HXt9TVNZIiiBe7GIIfoMX+F4bQesUuxSQz/4IbYYz81px2wNER31x4N
         d/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733199810; x=1733804610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMDksIbcOLWGwD0vO5eo1YOj8LatyWo9RypORfUk9j4=;
        b=oza5WDZZsD0w1UPTTxzL4I8z4kHv35EJgq+lxOgwlum5KgzwmmXKFr24j+PTKbxrto
         NnXqk4jzkDOQ4r12mC3D68luUdHXTOlavW4kXK4BU4XE3nmMNcWxATR3WcHy93xahbWv
         kq6dp2uy72LJ2FIyE+mYm/gDgfFMTOihYme/Nuobb8r6Uc30BX3HKTvBPSd9V40aCPd7
         /4glmquOXtryogYypldQP4Z8tLKHZuCgTzDJGF80TCG8xenbzerd76TwgIPIqfVoGHdi
         DtfkyTK2t5qXnRqk173AX7Zu2oOinZSEvG6X5LXUO9MeH2VryV19SwvunHWFKcQwRfi9
         UmdA==
X-Gm-Message-State: AOJu0YyV1duwfxf3nSMLuFGA+hLyVrF/lutmdDgxurn5qDEE+RPKqi9/
	0lzphG5Jxp4ZaFQHqewLYShNSbyYvCBSMk4qJOfQzJJ9aLW5XCup
X-Gm-Gg: ASbGnctxMtDi5t2h21izl1YAtmEwhKXfMQdCI8D0GKGCeKjKua3L5tEeizNZKH7rFwf
	CmswTAW2b9bnzzO0gWtflzD/tViOP57vLkT4zJ37QMlXNyMCacd1WFPt1t4xYXeAjJqyfHxj/zP
	JExEOrQwMQzRjaMfXgFQhKJ98F2QepduqpwbUTmPmRSHXvHgrQJ5SsLroR0T2r2iM5F43Q2t7NY
	Gdbjk/L6nrjQQUPp7n6BY+p8dsiu0NmWA8cB1wGl3g3avYCFyGuUhv9IGkeE+mGXEb91xeCFW53
	jJ80rjhrnUcQLS03iKK1
X-Google-Smtp-Source: AGHT+IE8xdk48VpCN/lmNtJ4mSg7KBUaDEkPOtXNpXZN6KheBo7QC4wgFHpv7a0bXxkvqLx6Sq1RtQ==
X-Received: by 2002:a05:6a20:3941:b0:1e0:d859:e1bd with SMTP id adf61e73a8af0-1e1653a7bb4mr1623878637.1.1733199810346;
        Mon, 02 Dec 2024 20:23:30 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541848924sm9701523b3a.180.2024.12.02.20.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 20:23:29 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 4E210DD39FB; Tue,  3 Dec 2024 13:23:27 +0900 (JST)
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
Subject: [PATCH v3 02/13] x86/um: nommu: elf loader for fdpic
Date: Tue,  3 Dec 2024 13:23:01 +0900
Message-ID: <215895272109f7b0a4a00625e86b57f39fa13af8.1733199769.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733199769.git.thehajime@gmail.com>
References: <cover.1733199769.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_202331_518517_0848984B 
X-CRM114-Status: GOOD (  18.20  )
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
 arch/um/include/asm/Kbuild           |  1 +
 arch/um/include/asm/mmu.h            |  5 +++++
 arch/um/include/asm/ptrace-generic.h |  6 ++++++
 arch/x86/um/asm/elf.h                |  8 ++++++--
 arch/x86/um/asm/module.h             | 24 ------------------------
 fs/Kconfig.binfmt                    |  2 +-
 6 files changed, 19 insertions(+), 27 deletions(-)
 delete mode 100644 arch/x86/um/asm/module.h

diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index 428f2c5158c2..04ab3b653a48 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -13,6 +13,7 @@ generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += mcs_spinlock.h
 generic-y += mmiowb.h
+generic-y += module.h
 generic-y += module.lds.h
 generic-y += param.h
 generic-y += parport.h
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
diff --git a/arch/x86/um/asm/module.h b/arch/x86/um/asm/module.h
deleted file mode 100644
index a3b061d66082..000000000000
--- a/arch/x86/um/asm/module.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __UM_MODULE_H
-#define __UM_MODULE_H
-
-/* UML is simple */
-struct mod_arch_specific
-{
-};
-
-#ifdef CONFIG_X86_32
-
-#define Elf_Shdr Elf32_Shdr
-#define Elf_Sym Elf32_Sym
-#define Elf_Ehdr Elf32_Ehdr
-
-#else
-
-#define Elf_Shdr Elf64_Shdr
-#define Elf_Sym Elf64_Sym
-#define Elf_Ehdr Elf64_Ehdr
-
-#endif
-
-#endif
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


