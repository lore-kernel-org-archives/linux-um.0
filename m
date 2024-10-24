Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924C1CE8E72
	for <linux-um@archiver.kernel.org>; Thu, 24 Oct 2024 12:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CHB5/7vegkHYFSBIO7sIJgXgUiVuIjPC9VUJ0vRc9nk=; b=01Zpib2CiwWsdCLiDbszf0Jadt
	BQBfz8/stY8+IEoJp0s5DhbQt375RUrabfCtRXlO9fCTOAv8R9kpKoq63Rm7bCWj1ZOqsW8NHFdaa
	QvFbm2f0w0sU+kYTs9ONnhgNQAPwHzxRH4uErXBxzvVZtOTxuDPT2ahW0ILkDLdfZulIn9sVt7QD+
	ys4a0OB+CUxhBSnxbaAQ+K1DiSh5JiDKQkxrGmogu6hvN5Slsko0JKGInUZIUJ3re/Xu5sFC6+7Qw
	C5/uJ26WVub97bwXtwSkgM6VZA1eVWO8C1/N+We+yBxOEZtFzz+QT/0nxnKGtuxlrdWlndwIrRcVV
	q/YPlwtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3wgX-00000000ItV-0QZj;
	Thu, 24 Oct 2024 12:11:25 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3wfc-00000000IeP-2CZE
	for linux-um@lists.infradead.org;
	Thu, 24 Oct 2024 12:10:29 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-71f5208217dso518181b3a.2
        for <linux-um@lists.infradead.org>; Thu, 24 Oct 2024 05:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729771828; x=1730376628; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHB5/7vegkHYFSBIO7sIJgXgUiVuIjPC9VUJ0vRc9nk=;
        b=UVHTqrBDAkUd6YZKvbeZq0MdsI4hfZcc0WQwgF9IVzh7hInhJXkUlr0Rqfo4JrygBc
         3H3F+9Uwp5NR3AQdgASU6SM+ZAzQJfWvPTDuoW3iX4R/2byILDkM/K6pe88tYuk8JLci
         I4nKeBDliqUxCDTTNvcKNrczxL+3LryzELm8MJ4DIFYoJqSGxQnBowug+LrKz5Q4N8DC
         5g6F5jFU+3kHarCn1KyCWSEUhIXK5UvZjBdMtMCdtCMbV2NVQ3n6ylav8hV0DbcMXGcV
         wWBejoiU6a63uheh1dm4dprLDf3HQexSOFsz3qpLrLU3oWyoEz2SM3sJXEcgqkaXxDVD
         r9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729771828; x=1730376628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHB5/7vegkHYFSBIO7sIJgXgUiVuIjPC9VUJ0vRc9nk=;
        b=AAiYb6rYNhRv76R4L4SCLSF3ON6Kzf2ZxRtwIQIk1fpb0YGglYf0qCuU4xWTNjkaG4
         SE3kyZ5OImwC0wx853JfjWB3Ah7nBnt9/4GSDuUeqhBhRxyZRos0pl5Gb487dN+x149t
         IZYzFleOiVADq7XuM+KDVeJxaEUzlHB5AnhQwwe+qDZYO5XiDO5aP7XN8VqL+x8WgYyr
         6jTkNEWn+rvO/2UDNUj2l6jFwulcCLwO25BXDupQhug62ZwKBO+G/vK/ECMzDAKrIxtH
         Qr1FdOarLAJSahhQ5Yw3zVWOG4u355pT6mbeKGxbAz586zrCScpJSNMDJVnfkcvsT/d4
         C7mw==
X-Gm-Message-State: AOJu0YwoDNZhQLeoAOOYIZ1MbPD4X3j2+AhMoChWNqyklwJtp5KO2Pgw
	B8deBu3CodDIsisgOJPJA/IcI43qtnjVVS38Aq2snlX15WUHkqgJ
X-Google-Smtp-Source: AGHT+IF3zAKUcoVHQk4MKxtLT0unS01jYilAvLF8DqQeLrUpBEbmEu0fD0kLSDrKz+1mtflLNN+d9w==
X-Received: by 2002:a05:6a00:1817:b0:71e:5950:97d2 with SMTP id d2e1a72fcca58-72045f8d0bdmr2095716b3a.17.1729771827512;
        Thu, 24 Oct 2024 05:10:27 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeabde7d5sm8361083a12.93.2024.10.24.05.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 05:10:26 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 23C56D5125B; Thu, 24 Oct 2024 21:10:25 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org,
	jdike@addtoit.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: thehajime@gmail.com,
	ricarkol@google.com
Subject: [RFC PATCH 10/13] x86/um: nommu: stack save/restore on vfork
Date: Thu, 24 Oct 2024 21:09:18 +0900
Message-ID: <ebd3fce1eeee65934fe9da3c50be94f215974075.1729770373.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729770373.git.thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_051028_592965_9AABDD8F 
X-CRM114-Status: GOOD (  17.14  )
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

This fork can only come from libc's vfork, which does this:

	popq %%rdx;
	call *%rax; // zpoline => __kernel_vsyscall
	pushq %%rdx;

%rcx stores the return address which is stored at
pt_regs[HOST_IP] at the moment.  As child returns via
userspace() with a jmp instruction (while parent does via ret
instruction in __kernel_vsyscall), we need to pop (advance)
the pushed address by "call".

As a result of vfork return in child, stack contents is overwritten
by child (by pushq in vfork), which makes the parent puzzled after
child returns.  thus the contents should be restored before
vfork/parent returns.  this is done in do_syscall_64().

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/um/kernel/process.c    | 22 +++++++++++++++++-----
 arch/x86/um/do_syscall_64.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 270b5bd476be..134687530e5f 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -140,15 +140,27 @@ static void fork_handler(void)
 
 #ifndef CONFIG_MMU
 	/*
+	 * child of vfork(2) comes here.
+	 * clone(2) also enters here but doesn't need to advance the %rsp.
+	 *
 	 * This fork can only come from libc's vfork, which
 	 * does this:
 	 *	popq %%rdx;
-	 *	call *%0; // vsyscall
+	 *	call *%rax; // zpoline => __kernel_vsyscall
 	 *	pushq %%rdx;
-	 * %rdx stores the return address which is stored
-	 * at pt_regs[HOST_IP] at the moment. We still
-	 * need to pop the pushed address by "call" though,
-	 * so this is what this next line does.
+	 * %rcx stores the return address which is stored
+	 * at pt_regs[HOST_IP] at the moment.  As child returns
+	 * via userspace() with a jmp instruction (while parent
+	 * does via ret instruction in __kernel_vsyscall), we
+	 * need to pop (advance) the pushed address by "call"
+	 * though, so this is what this next line does.
+	 *
+	 * As a result of vfork return in child, stack contents
+	 * is overwritten by child (by pushq in vfork), which
+	 * makes the parent puzzled after child returns.
+	 *
+	 * thus the contents should be restored before vfork/parent
+	 * returns.  this is done in do_syscall_64().
 	 */
 	if (current->thread.regs.regs.gp[HOST_ORIG_AX] == __NR_vfork)
 		current->thread.regs.regs.gp[REGS_SP_INDEX] += 8;
diff --git a/arch/x86/um/do_syscall_64.c b/arch/x86/um/do_syscall_64.c
index 594248f7319c..4235259bbee1 100644
--- a/arch/x86/um/do_syscall_64.c
+++ b/arch/x86/um/do_syscall_64.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+//#define DEBUG 1
 #include <linux/kernel.h>
 #include <linux/ptrace.h>
 #include <asm/fsgsbase.h>
@@ -34,9 +35,38 @@ static int os_x86_arch_prctl(int pid, int option, unsigned long *arg2)
 	return 0;
 }
 
+/*
+ * save/restore the return address stored in the stack, as the child overwrites
+ * the contents after returning to userspace (i.e., by push %rdx).
+ *
+ * see the detail in fork_handler().
+ */
+static void *vfork_save_stack(void)
+{
+	unsigned char *stack_copy;
+
+	stack_copy = kzalloc(PAGE_SIZE << THREAD_SIZE_ORDER,
+			     GFP_KERNEL);
+	if (!stack_copy)
+		return NULL;
+
+	memcpy(stack_copy,
+	       (void *)current->thread.regs.regs.gp[HOST_SP], 8);
+
+	return stack_copy;
+}
+
+static void vfork_restore_stack(void *stack_copy)
+{
+	WARN_ON_ONCE(!stack_copy);
+	memcpy((void *)current->thread.regs.regs.gp[HOST_SP],
+	       stack_copy, 8);
+}
+
 __visible void do_syscall_64(struct pt_regs *regs)
 {
 	int syscall;
+	unsigned char *stack_copy = NULL;
 
 	syscall = PT_SYSCALL_NR(regs->regs.gp);
 	UPT_SYSCALL_NR(&regs->regs) = syscall;
@@ -45,6 +75,9 @@ __visible void do_syscall_64(struct pt_regs *regs)
 		 syscall, (unsigned long)current,
 		 (unsigned long)sys_call_table[syscall]);
 
+	if (syscall == __NR_vfork)
+		stack_copy = vfork_save_stack();
+
 	/* set fs register to the original host one */
 	os_x86_arch_prctl(0, ARCH_SET_FS, (void *)host_fs);
 
@@ -72,6 +105,9 @@ __visible void do_syscall_64(struct pt_regs *regs)
 		userspace(&current->thread.regs.regs,
 			current_thread_info()->aux_fp_regs);
 	}
+	/* only parents of vfork restores the contents of stack */
+	if (syscall == __NR_vfork && regs->regs.gp[HOST_AX] > 0)
+		vfork_restore_stack(stack_copy);
 }
 
 #endif
-- 
2.43.0


