Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A422DC02184
	for <linux-um@archiver.kernel.org>; Tue, 14 Jan 2025 11:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ukyNfs65nuvgTdhSkdJYZ2Y9345NLuFCWN/gVQv/aLg=; b=lx2IMwVdZvBSKRkZ9fER3Xw1mV
	lufh8w+WmdqD5GpVCtOJEzgxVske7kFF7ktEFKDAt3Y8RLkG68LM9cfsbhQ9N+Nw17bUFV3D1GVSL
	zK7EMEwn1w+ZmU6h1gb0be8oNRiyx/j0WS0hx5svUi36ZHwQY9b8QjY02rjKFIvNKASwgmbGA5NWF
	11xME6GigWjsXaqifcW3Jg6DuAsGE/63vocdF3/b9XHNuh1LRHndhpB9DxotlN8gbKjXs5rXaTHsD
	yfaN17Gmc5sepbzsoF+sdSIUWPSXFghAILpmy9ok2M7IHjLZ1hUJB3OZjanSd2K+BjyycPaNRCZkC
	6Tr+oRYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXf9a-00000008GJI-1l2V;
	Tue, 14 Jan 2025 11:32:14 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXf8S-00000008G1l-41Io
	for linux-um@lists.infradead.org;
	Tue, 14 Jan 2025 11:31:06 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2ee74291415so7083049a91.3
        for <linux-um@lists.infradead.org>; Tue, 14 Jan 2025 03:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736854264; x=1737459064; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukyNfs65nuvgTdhSkdJYZ2Y9345NLuFCWN/gVQv/aLg=;
        b=BhIuwYlC4o5f4wh/42+7oIKZxeAjpkaLy2VZGnXtYcsWQuaaTns+kCaZX1QfpCg/1c
         U+KYghfpKkE4s48Ogqbyox3YCmQGVI02Pzl8g5i+Z8kIcbbYqMueQulWZ++yGhvHsvHe
         GxeHvfbdpGCXEK+f0DW61ovRUCjSPfVlS0Ds0wS0s0CtBJQkfCeqqhvGCWmtIVzMfLeW
         XCOyffS3oZD+t50CdHZAyTNL4FQqQ6sPiCRGAghK1V5G9F85qL/6/qaVvQY6MqAXbnlW
         P6yUkNPuBr07HkmoSZm5HWlHGDaDhgFN34pnv9Xz/0Tt0OSN7ReUGMmi0zHBkUNkO3gD
         fqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736854264; x=1737459064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukyNfs65nuvgTdhSkdJYZ2Y9345NLuFCWN/gVQv/aLg=;
        b=nsniPCb08vEh//ZAqFXt6F9ZVp2fo4owXmNOIHvctvEbeuj3EKlXan7cTeuov6Sltr
         j9bB5QZsguZLZTrYbSuuJQ1w6Vdj35Yi08cwmhom4kwH1bg/3UgrLByMTW3QpLlSDihG
         zh8NB0g+VkOu//JbDtsE9UPT5y87gvk58vgN6PNbKF5kroyqRRuxxdPZ6ORrgXyWD1Jk
         /4mACvEsF6YtjYMIunZHf59t2HBqx0BkrsgQUXJYXcNJxpNPB1KcsyuhYuhrZDXC2M3p
         5NLk1WHWfhlqO8Bk8JcWi/1PrPfqtQx0rasZOtjST46GWuM981EwtEWY7d1KpEVdjV1G
         ys0A==
X-Gm-Message-State: AOJu0YwVB8jXv+HbO46E9KRLt7FIDsXs5Wn0rnC1dxdBdsufNtYe2T9p
	HIUIMo5n/DlbJP5tLzuWptYQ5btVmF2Lv7lGey2ZVyP+L4BdVpbj
X-Gm-Gg: ASbGncuMbbo8GbT+gOp8+nJ3X4jmJSrqFYHWJ+uVaU4lScQQnsalseFLgRgk6fELudN
	HX1EK8vKe9CIbnICcLfyvaijIi4STswdqlNUmOuaEhI0ccr55DxZK5LWRQs3YzPg3LTTKWDtWfi
	3ZDs+iuwo3Uv4us+4utOs7+D8oaM/KpcQfitTXXBF6mm49XmUgeA2RWMyFOvbKlbSKuOcJBmZdC
	mOdhfKEUfapSDSJ8tpz462tgKrOSV2p/RFI10IFX/htmTO5TBVEsG4ERiOj5hh3afp7U3/81X70
	t6tXx1tvWWgARJqB0z7jDB0LFTeN
X-Google-Smtp-Source: AGHT+IFUwZHNFEc67jBbRXeFTOn0tcZ1umDdW5kX+lEEHYdmJnaChB7NhkDCIdArY2EVW1a5YS/C9A==
X-Received: by 2002:a17:90b:5208:b0:2ef:33a4:ae6e with SMTP id 98e67ed59e1d1-2f548eba9c4mr42260944a91.12.1736854263922;
        Tue, 14 Jan 2025 03:31:03 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22ee09sm65234765ad.200.2025.01.14.03.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 03:31:03 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 5DC8BE1AB50; Tue, 14 Jan 2025 20:31:01 +0900 (JST)
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
Subject: [PATCH v6 02/13] x86/um: nommu: elf loader for fdpic
Date: Tue, 14 Jan 2025 20:30:40 +0900
Message-ID: <d9dd391ee565aa3ad1b8ceba5689caf888f6bd85.1736853926.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736853925.git.thehajime@gmail.com>
References: <cover.1736853925.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_033104_995570_C03DDB0C 
X-CRM114-Status: GOOD (  15.99  )
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


