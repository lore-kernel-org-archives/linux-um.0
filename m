Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A887E6C5FB
	for <linux-um@archiver.kernel.org>; Tue,  3 Dec 2024 04:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A308RrEr7E36b4DSV1XsgRK9lOwiuRrBRlfF8Ce2kbE=; b=kqG5HhdM7yFDE+6dAp1VmFx2il
	y5Cl5txtc9ACd4hfQ2yIojFOcz9e6bLGFKyW//lZhtc08kco7uJ/xchFfps6xJSDdYcBcnYGd9tXr
	Xj957Ir+NwVjiIBVURWDDwcgG1D33VKQLsHWQnmQT2kI5huY6CZTjZtPpc84EyMN5boxhy9AQZq2c
	kRuClAJqlxIGZ5LHLOc7ohH2ZNAabnolIvF8RYaDK5XAqU4C2tSOqEPLxBkeRkPVxdRndTqMQ91Ms
	xKw0iAg9lb04ChzNDXfXji9pdnbiv5oM8Pssl1CNGC2OClVoIlN5bzYl53R3HHtHJJUn6T1Ht46VT
	d+NYBn2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKRs-00000008DNu-45EI;
	Tue, 03 Dec 2024 04:23:45 +0000
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKRr-00000008DN8-0cMl
	for linux-um@lists.infradead.org;
	Tue, 03 Dec 2024 04:23:44 +0000
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-7fbc1ca1046so4605054a12.0
        for <linux-um@lists.infradead.org>; Mon, 02 Dec 2024 20:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733199822; x=1733804622; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A308RrEr7E36b4DSV1XsgRK9lOwiuRrBRlfF8Ce2kbE=;
        b=E829OaF9KToZ/xfRoPWlAbEYyea/t2bv9iiYefWciCY1g25yizEtpJqEi82PESGIgv
         RatjC5nedIT56lappgrwwKw1ul3AeqGmi4Zno1WArJ6F6s3bFMPXsVpwZTFWoSFEUzqX
         NDGUSrF2kNK8aGMt4a0Tq6ugkfZDimIj+KWPWIw16TM0qC5I4qxsElvRHor5excksUn1
         l7zVPRw/yW/ov3wyw2vnCJtc2yHnI47d0+1F7xS0gNzOPCp+7Gpn8CpDnLqHXhnoHgur
         wyyahvR0zvtj3zio6cqqjyx3QBQn+fXFXiHbZsZcdUbPAOaBjSA/gWx5hWqrKFEaOLLP
         aayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733199822; x=1733804622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A308RrEr7E36b4DSV1XsgRK9lOwiuRrBRlfF8Ce2kbE=;
        b=N7cuP+jEBwVMAsFwURaNS6KFZ9AR4d32G4PEHwZTPPq7DrhYcGKc77T3qClUUg+AYk
         Xdta3Sb13fBzzXu2MAtKltf05m513pkgWhYugIcvxH/VzybcENazebr8Vlyy4ei3u0Dg
         ym8ccOJ+mZXxDJsOdhMgPuuJ10G32nfVNAD8OpJL/HL9fKq8PQHbGGA9UelF1GEqlvMf
         djSz6JWBXMqnmgNtLnB7nv/BWgBQ1XeUysIIlE3C6dO9g7WkIrdbTPeCj++/H89Gyhkl
         e16l3CMhlyoZC0xUdSXyQ9tSPsVPhLsA7X+y+rp1hg5sdup2qLBoB9+wTpwOucsb5JGw
         +BSg==
X-Gm-Message-State: AOJu0Yzw/Nt3PdMI33oCh+LDcnXqjyyNroFW7psNRFhEs21ONp8IhGyy
	eWnivNDbqOM7uSYNXnFP63GeORUtbUdp1qDQa1yOcCxz4B7RcAqI
X-Gm-Gg: ASbGnctUvXwd0yCmeSRwVFyaD88neoxUv5dyoxVAVjDhYifvFNcsoPbmY2TZ5/cZL72
	bNFQCTCQlA/VxErgzOUQ/jp6281lejWKoRbZ74OvS3nUC8/DRvqtrzuOefPXiy6K+mAjuK285SL
	HX7gg5TTBeqWKW+E9QpimqyJ7bqVRtpLtOE1p2nZaVFWefKVEVIc+nX8UWcvrJHTzDPVFfbKgSC
	oQQcqLdWWLsI5jhw2sFk5HWYJNcfbHoZGif+8GJ9C/Bxu88g1Z2PrNTKejEcS4eDNj1oA8eBrzB
	FffsyGyeaABOpTHkFxLE
X-Google-Smtp-Source: AGHT+IFkTnyrGefLfaXpJDYUFG4t+O7IVAXqwsheUygWhpPhZ4TZWC7dn18rK6UFhhGloy7EoxNGfw==
X-Received: by 2002:a05:6a20:4393:b0:1d9:87e3:11f5 with SMTP id adf61e73a8af0-1e1654132d2mr1825287637.37.1733199821965;
        Mon, 02 Dec 2024 20:23:41 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fbfc3sm9673255b3a.123.2024.12.02.20.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 20:23:41 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 5FDA2DD3A01; Tue,  3 Dec 2024 13:23:38 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v3 05/13] x86/um: nommu: syscall translation by zpoline
Date: Tue,  3 Dec 2024 13:23:04 +0900
Message-ID: <02330ee6c6676cc2f6501ec78f3a1f448ba1d3d6.1733199769.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733199769.git.thehajime@gmail.com>
References: <cover.1733199769.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_202343_187477_58A9ECDB 
X-CRM114-Status: GOOD (  27.63  )
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

All syscalls issued by userspace thus redirected to a specific function,
__kernel_vsyscall, introduced as a syscall entry point for !MMU UML.  This
totally changes the code path to hook syscall with ptrace(2) used by
MMU-full UML.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/x86/um/asm/elf.h |   3 +
 arch/x86/um/zpoline.c | 223 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 226 insertions(+)
 create mode 100644 arch/x86/um/zpoline.c

diff --git a/arch/x86/um/asm/elf.h b/arch/x86/um/asm/elf.h
index 33f69f1eac10..6f5977ff0d21 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -188,6 +188,9 @@ do {								\
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
index 000000000000..97f5345ab314
--- /dev/null
+++ b/arch/x86/um/zpoline.c
@@ -0,0 +1,223 @@
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
+				break;
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
+ * elf_arch_finalize_exec() - architecture hook to translate syscall/sysenter
+ *
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
+ *
+ * @exec_params: ELF meta data for executable file
+ * @interp_params: ELF meta data for the interpreter file
+ */
+int elf_arch_finalize_exec(struct elf_fdpic_params *exec_params,
+			   struct elf_fdpic_params *interp_params)
+{
+	int err = 0, count = 0;
+	struct mm_struct *mm = current->mm;
+
+	if (down_write_killable(&mm->mmap_lock))
+		return -EINTR;
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
+ * setup_zpoline_trampoline() - install trampoline code for zpoline
+ *
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
+	ret = os_map_memory((void *) 0, -1, 0, PAGE_SIZE, 1, 1, 1);
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
+	 * FIXME: shift red zone area to properly handle the case
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
+	__zpoline_start[ptr++] = ((uint64_t) __kernel_vsyscall >> (8 * 0));
+	__zpoline_start[ptr++] = ((uint64_t) __kernel_vsyscall >> (8 * 1));
+	__zpoline_start[ptr++] = ((uint64_t) __kernel_vsyscall >> (8 * 2));
+	__zpoline_start[ptr++] = ((uint64_t) __kernel_vsyscall >> (8 * 3));
+	__zpoline_start[ptr++] = ((uint64_t) __kernel_vsyscall >> (8 * 4));
+	__zpoline_start[ptr++] = ((uint64_t) __kernel_vsyscall >> (8 * 5));
+	__zpoline_start[ptr++] = ((uint64_t) __kernel_vsyscall >> (8 * 6));
+	__zpoline_start[ptr++] = ((uint64_t) __kernel_vsyscall >> (8 * 7));
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
+	ret = os_protect_memory(0, PAGE_SIZE, 0, 0, 1);
+	if (ret)
+		panic("failed: can't configure permission on trampoline code");
+
+	pr_info("zpoline: setting up trampoline code done\n");
+	return 0;
+}
+arch_initcall(setup_zpoline_trampoline);
-- 
2.43.0


