Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FCDCE8E6E
	for <linux-um@archiver.kernel.org>; Thu, 24 Oct 2024 12:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2vPMt9Q3YEo293oGj5ufdt86H0CL5VULi2Suh/nhVX8=; b=BgAC7dKFxx+B+dIrm3eYboLNOR
	izOw1R04EoASfDerMeTrJ0cTEVmZc4m3qJgkbOatKm9K3l/7CZWngWQeiz9Y9rbwCp9UL/SzYKzxn
	3dfvo12z1FUULvSYYkJwlH+J4HnoxjXygg3kVQEVKmZNPW58lJtpZhKqb/xoCQ3JWgY0gKGU4h5SF
	iEBttFcQNH2JsS9egUvZYcNN5FTkIgRGuTZPkDelkqYKkql59lgFRPAPWj6YzM4at+3N/4tdOvr2R
	e/gBewv1M+DU3XPAVauNq/S5d25lrOD7kdLlBJgtf7CAr6iFnCwbOqwm7JRNKBB0NEFQ+nUPYG6rr
	8P+B6S0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3wgU-00000000Iq5-0h5d;
	Thu, 24 Oct 2024 12:11:22 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3wfJ-00000000IbV-1XY2
	for linux-um@lists.infradead.org;
	Thu, 24 Oct 2024 12:10:10 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-20c693b68f5so7965505ad.1
        for <linux-um@lists.infradead.org>; Thu, 24 Oct 2024 05:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729771808; x=1730376608; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vPMt9Q3YEo293oGj5ufdt86H0CL5VULi2Suh/nhVX8=;
        b=VH8fkk6PcIxSaBGiZS1BW9ku4iEOtBL4OhwkMjs3yGi+7y8fD1qG25zET7UXseDVSm
         hA1rKQNo1/JYwitamnUsSpbXfgnSSfKBpnUjQHiQeDLP5u++ZRDMU56qsw7QYe3+VbZW
         biSQWItBYr/M+Xi9enF7Uarw9W/5GscM0vK879GWAJt/rDSERfobqw3TxvrriSKPuY+Q
         3segniwugTfeXM6pZ5HMBfSAxoYuQGmwKHqi0oF0YEuxPf2w0anyjuPhkWDPzoZVSTdm
         tjB1zfaekC6qFaxeZO1WZcGpNZEadp87QTLx7bR93NUaIPeKx+CqZCiSUMd6hj4arKZw
         vW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729771808; x=1730376608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2vPMt9Q3YEo293oGj5ufdt86H0CL5VULi2Suh/nhVX8=;
        b=isYWah9hS2YRu24ocdx29BYolxGNSassnqozfkEtWyYCPA+fL2g6WCQUanmf49+Ci8
         byb+nYSI94V4gwzgbSqe4O8JMkxIxl+QJmKBY1OXSDNvUt7KV7bS8gRmKDase8imKj0h
         9zW9RQEFAZMZIvQ65+4q5zmNl+hnyq/8GYwNj/O1XTzs1WJN/GKOpIQ+IgFhBSat+9wz
         7xdkii4nZ7BetOiTE825ZxjKVIYQSnQAc0VKz4Bb1rO/7NQf91WS7EjHJuF1NkfoztxY
         io8EY3G6Aefmp+LpwvFOtYTSX12Pbfgm1j5K++gQHIbqk/ezv0HTrTL22WkDb3ZlwoPP
         FOpQ==
X-Gm-Message-State: AOJu0YwVC5Sey7xvj1WRcjuSVOL17DPqibqTEVj5kLB/Q9fFLalPmP4p
	zoZhbB1ElH1dWMwDxbCqfAFJVNJJXtB4GgCmFSOLsVHqA5MLQTLW
X-Google-Smtp-Source: AGHT+IHlgNxJD8D0fW992B/MR1k9nZUrPdU1SuSMKf7qfM1gXQ8A8GZeOKGo2b2JST7a7zz7L1KrMA==
X-Received: by 2002:a17:902:ea02:b0:20c:7d4c:64db with SMTP id d9443c01a7336-20fab2dba5cmr78257515ad.49.1729771807922;
        Thu, 24 Oct 2024 05:10:07 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f363esm71335675ad.269.2024.10.24.05.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 05:10:07 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id F3089D51251; Thu, 24 Oct 2024 21:10:05 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org,
	jdike@addtoit.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: thehajime@gmail.com,
	ricarkol@google.com
Subject: [RFC PATCH 05/13] x86/um: nommu: syscall translation by zpoline
Date: Thu, 24 Oct 2024 21:09:13 +0900
Message-ID: <2f3537884533232ab2ef2937e392d32736527bdc.1729770373.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729770373.git.thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_051009_446821_4A194A86 
X-CRM114-Status: GOOD (  27.50  )
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

This commit adds a mechanism to hook syscalls for unmodified userspace
programs used under UML in !MMU mode. The mechanism, called zpoline,
translates syscall/sysenter instructions with `call *%rax`, which can be
processed by a trampoline code also installed upon an initcall during
boot. The translation is triggered by elf_arch_finalize_exec(), an arch
hook introduced by another commit.

All syscalls issued by userspace thus redirected to a speicific function,
__kernel_vsyscall, introduced as a syscall entry point for !MMU UML.  This
totally changes the code path to hook syscall with ptrace(2) used by
MMU-full UML.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/x86/um/asm/elf.h |   3 +
 arch/x86/um/zpoline.c | 228 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 231 insertions(+)
 create mode 100644 arch/x86/um/zpoline.c

diff --git a/arch/x86/um/asm/elf.h b/arch/x86/um/asm/elf.h
index 4f87980bc9e9..05f90fc078b3 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -187,6 +187,9 @@ do {								\
 struct linux_binprm;
 extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 	int uses_interp);
+struct elf_fdpic_params;
+extern int elf_arch_finalize_exec(struct elf_fdpic_params *exec_params,
+				  struct elf_fdpic_params *interp_params);
 
 extern unsigned long um_vdso_addr;
 #define AT_SYSINFO_EHDR 33
diff --git a/arch/x86/um/zpoline.c b/arch/x86/um/zpoline.c
new file mode 100644
index 000000000000..a25bb50680e8
--- /dev/null
+++ b/arch/x86/um/zpoline.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  zpoline.c
+ *
+ *  Replace syscall/sysenter instructions to `call *%rax` to hook syscalls.
+ *
+ */
+//#define DEBUG
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/elf-fdpic.h>
+#include <asm/unistd.h>
+#include <asm/insn.h>
+#include <sysdep/syscalls.h>
+#include <os.h>
+
+#ifndef CONFIG_MMU
+
+/* start of trampoline code area */
+static char *__zpoline_start;
+
+static int __zpoline_translate_syscalls(struct elf_fdpic_params *params)
+{
+	int count = 0, loop;
+	struct insn insn;
+	unsigned long addr;
+	struct elf_fdpic_loadseg *seg;
+	struct elf_phdr *phdr;
+	struct elfhdr *ehdr = (struct elfhdr *)params->elfhdr_addr;
+
+	if (!ehdr)
+		return 0;
+
+	seg = params->loadmap->segs;
+	phdr = params->phdrs;
+	for (loop = 0; loop < params->hdr.e_phnum; loop++, phdr++) {
+		if (phdr->p_type != PT_LOAD)
+			continue;
+		addr = seg->addr;
+		/* skip translation of trampoline code */
+		if (addr <= (unsigned long)(&__zpoline_start[0] + 0x1000 + 0x0100)) {
+			pr_warn("%lx: address is in the range of trampoline", addr);
+			return -EINVAL;
+		}
+
+		/* translate only segment with Executable flag */
+		if (!(phdr->p_flags & PF_X)) {
+			seg++;
+			continue;
+		}
+
+		pr_debug("translation 0x%lx-0x%llx", addr,
+			 seg->addr + seg->p_memsz);
+		/* now ready to translate */
+		while (addr < (seg->addr + seg->p_memsz)) {
+			insn_init(&insn, (void *)addr, MAX_INSN_SIZE, 1);
+			insn_get_length(&insn);
+
+			insn_get_opcode(&insn);
+
+			switch (insn.opcode.bytes[0]) {
+			case 0xf:
+				switch (insn.opcode.bytes[1]) {
+				case 0x05: /* syscall */
+				case 0x34: /* sysenter */
+					pr_debug("%lx: found syscall/sysenter", addr);
+					*(char *)addr = 0xff; // callq
+					*((char *)addr + 1) = 0xd0; // *%rax
+					count++;
+					break;
+				}
+			default:
+			}
+
+			addr += insn.length;
+			if (insn.length == 0) {
+				pr_debug("%lx: length zero with byte %x. skip ?",
+					 addr, insn.opcode.bytes[0]);
+				addr += 1;
+			}
+		}
+		seg++;
+	}
+	return count;
+}
+
+/**
+ * translate syscall/sysenter instruction upon loading ELF binary file
+ * on execve(2)&co syscall.
+ *
+ * suppose we have those instructions:
+ *
+ *    mov $sysnr, %rax
+ *    syscall                 0f 05
+ *
+ * this will translate it with:
+ *
+ *    mov $sysnr, %rax        (<= untouched)
+ *    call *(%rax)            ff d0
+ *
+ * this will finally called hook function guided by trampoline code installed
+ * at setup_zpoline_trampoline().
+ */
+int elf_arch_finalize_exec(struct elf_fdpic_params *exec_params,
+			   struct elf_fdpic_params *interp_params)
+{
+	int err = 0, count = 0;
+	struct mm_struct *mm = current->mm;
+
+	if (down_write_killable(&mm->mmap_lock)) {
+		err = -EINTR;
+		return err;
+	}
+
+	/* translate for the executable */
+	err = __zpoline_translate_syscalls(exec_params);
+	if (err < 0) {
+		pr_info("zpoline: xlate error %d", err);
+		goto out;
+	}
+	count += err;
+	pr_debug("zpoline: rewritten (exec) %d syscalls\n", count);
+
+	/* translate for the interpreter */
+	err = __zpoline_translate_syscalls(interp_params);
+	if (err < 0) {
+		pr_info("zpoline: xlate error %d", err);
+		goto out;
+	}
+	count += err;
+
+	err = 0;
+	pr_debug("zpoline: rewritten (exec+interp) %d syscalls\n", count);
+
+out:
+	up_write(&mm->mmap_lock);
+	return err;
+}
+
+/**
+ * setup trampoline code for syscall hooks
+ *
+ * the trampoline code guides to call hooked function, __kernel_vsyscall
+ * in this case, via nop slides at the memory address zero (thus, zpoline).
+ *
+ * loaded binary by exec(2) is translated to call the function.
+ */
+static int __init setup_zpoline_trampoline(void)
+{
+	int i, ret;
+	int ptr;
+
+	/* zpoline: map area of trampoline code started from addr 0x0 */
+	__zpoline_start = 0x0;
+
+	ret = os_map_memory((void *) 0, -1, 0, 0x1000, 1, 1, 1);
+	if (ret)
+		panic("map failed\n NOTE: /proc/sys/vm/mmap_min_addr should be set 0\n");
+
+	/* fill nop instructions until the trampoline code */
+	for (i = 0; i < NR_syscalls; i++)
+		__zpoline_start[i] = 0x90;
+
+	/* optimization to skip old syscalls */
+	/* short jmp */
+	__zpoline_start[214 /* __NR_epoll_ctl_old */] = 0xeb;
+	/* range of a short jmp : -128 ~ +127 */
+	__zpoline_start[215 /* __NR_epoll_wait_old */] = 127;
+
+	/**
+	 * FIXME: shit red zone area to properly handle the case
+	 */
+
+	/**
+	 * put code for jumping to __kernel_vsyscall.
+	 *
+	 * here we embed the following code.
+	 *
+	 * movabs [$addr],%r11
+	 * jmpq   *%r11
+	 *
+	 */
+	ptr = NR_syscalls;
+	/* 49 bb [64-bit addr (8-byte)]    movabs [64-bit addr (8-byte)],%r11 */
+	__zpoline_start[ptr++] = 0x49;
+	__zpoline_start[ptr++] = 0xbb;
+	__zpoline_start[ptr++] = ((uint64_t)
+				  __kernel_vsyscall >> (8 * 0)) & 0xff;
+	__zpoline_start[ptr++] = ((uint64_t)
+				  __kernel_vsyscall >> (8 * 1)) & 0xff;
+	__zpoline_start[ptr++] = ((uint64_t)
+				  __kernel_vsyscall >> (8 * 2)) & 0xff;
+	__zpoline_start[ptr++] = ((uint64_t)
+				  __kernel_vsyscall >> (8 * 3)) & 0xff;
+	__zpoline_start[ptr++] = ((uint64_t)
+				  __kernel_vsyscall >> (8 * 4)) & 0xff;
+	__zpoline_start[ptr++] = ((uint64_t)
+				  __kernel_vsyscall >> (8 * 5)) & 0xff;
+	__zpoline_start[ptr++] = ((uint64_t)
+				  __kernel_vsyscall >> (8 * 6)) & 0xff;
+	__zpoline_start[ptr++] = ((uint64_t)
+				  __kernel_vsyscall >> (8 * 7)) & 0xff;
+
+	/*
+	 * pretending to be syscall instruction by putting return
+	 * address in %rcx.
+	 */
+	/* 48 8b 0c 24               mov    (%rsp),%rcx */
+	__zpoline_start[ptr++] = 0x48;
+	__zpoline_start[ptr++] = 0x8b;
+	__zpoline_start[ptr++] = 0x0c;
+	__zpoline_start[ptr++] = 0x24;
+
+	/* 41 ff e3                jmp    *%r11 */
+	__zpoline_start[ptr++] = 0x41;
+	__zpoline_start[ptr++] = 0xff;
+	__zpoline_start[ptr++] = 0xe3;
+
+	/* permission: XOM (PROT_EXEC only) */
+	ret = os_protect_memory(0, 0x1000, 0, 0, 1);
+	if (ret)
+		panic("failed: can't configure permission on trampoline code");
+
+	pr_info("zpoline: setting up trampoline code done\n");
+	return 0;
+}
+arch_initcall(setup_zpoline_trampoline);
+#endif /* !CONFIG_MMU */
-- 
2.43.0


