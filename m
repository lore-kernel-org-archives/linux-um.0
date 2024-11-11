Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89F7D12D77
	for <linux-um@archiver.kernel.org>; Mon, 11 Nov 2024 06:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P9W8sLSZVRt/hdna/XYup1SpEEQT3PS8wgsso2fTjHQ=; b=PaMNMvR1ptJpdsDrEiYTEpgZId
	OBQpFwhDPQ97YWk17+d6xLijCtYK2rtRVAeoRbBs/UyBX8boA56BLlBdSjA0jJHxKbAdpv0Zf632a
	qwORTuCP4hqEdxApGmzewtL59XRZcNrDgvMpgX0mZJ8VUJE2xd4ZB1T+G51q+IH6bVmj6DlMLkMW5
	HwCDvrOcOkTRWFrMVeX0XP243jYeuIU/ajfFy2MZfnO7qqbyQyO1sQhEuIkisWLST7z4Heb4f0Voz
	ve7vBUUXBA0AYm232cEvr0tcSRgCiO+qh+yN82i546KII5a90kCL67hu11EGfmgSrM1Qa7R9sxd3h
	nVr+ESqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tANuo-0000000GUKH-2kdy;
	Mon, 11 Nov 2024 06:28:46 +0000
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tANum-0000000GUJk-2Svb
	for linux-um@lists.infradead.org;
	Mon, 11 Nov 2024 06:28:45 +0000
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-7181b86a749so1696758a34.3
        for <linux-um@lists.infradead.org>; Sun, 10 Nov 2024 22:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731306524; x=1731911324; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9W8sLSZVRt/hdna/XYup1SpEEQT3PS8wgsso2fTjHQ=;
        b=Gc2Rq9ri8H0KQKIpa1JYl3RKfYtm2QgxbqkgpMuzHLnDl6Zpel3E66nPsAUrAarr5G
         tWFxnoUtZ12+Gr+OyAp8uBFlZHyZWyawPTHQKVf/ag8Gbfixyzo8VYIEw60ng0FYCmDq
         zV+mkabFjfvevPh6J5cfRxvzJ/U7Ujm6Ops0se9eR7ZDb1xY/mxnCG9xAot+cd+U7uBJ
         QnXPHyETCAxo2i8c8HSGCs8z2yCTunYdJSSIFbwv658b1f6gOhckUUUbDLduTv7ek0g9
         2Nu/A0blrgYs022FGEJPqkiR5FmhUQZLZCEmdMkBdpjQYtjtxdO9K2Bl1vBK7TCtWZVo
         4U2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731306524; x=1731911324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9W8sLSZVRt/hdna/XYup1SpEEQT3PS8wgsso2fTjHQ=;
        b=eAN59hsJlPSWWl3gXPq1Kq09HfMpfM76FvoV+z/fq32G4CFnTLeBOZLhw1zZhMjxzc
         YNpCjbkwyFUGory6SerzQTj1ZIiyND3GUvtj4h/0MH7zKJa3dkS9o58EHFfUDn8QxVJY
         9x0CGOnSsooNr8XOYWJxTB4w6lK3i/6n+27CO9haApynEz+RQvVOWRwAoNaG2OnRcA9j
         IPmCumAbuo7G+U/srKWJ3r9zRgaJBEwv/O12LSUmcuWpOUU69O9H1t6iNJZEl1y6fZ//
         0SRXt16SINSFdxz/dyaEshUwShh39p1m9JcMAoa52VRVtzmpDfnOYz/gF6YUVo5+zOAU
         YGgg==
X-Gm-Message-State: AOJu0YySDIL0gF1tQuro3e6m3lNet+XNX4xoaHSkxwZl9w/MtSYAiGF2
	AWjVeRuq9fiEsysr9veUsb6aNdv/+4qVRxHh6O3OdspQ7e0Zj8qg
X-Google-Smtp-Source: AGHT+IGKB1lL6Ad17VRVApUJFc/Lgy9c2q0hsMuXNYHTpZUPb6caqXDCrgXYN/3oOxehePQpxivzcg==
X-Received: by 2002:a05:6830:620f:b0:710:ea11:3d35 with SMTP id 46e09a7af769-71a1c221985mr9828249a34.15.1731306523622;
        Sun, 10 Nov 2024 22:28:43 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f65fd7asm7722516a12.83.2024.11.10.22.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 22:28:42 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id ECFB3DBA926; Mon, 11 Nov 2024 15:28:40 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [RFC PATCH v2 10/13] x86/um: nommu: signal handling
Date: Mon, 11 Nov 2024 15:27:10 +0900
Message-ID: <5a769da2dcc8e7f9b89fbdbc4bccd0b8a1660309.1731290567.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731290567.git.thehajime@gmail.com>
References: <cover.1731290567.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_222844_652056_9BB57CA0 
X-CRM114-Status: GOOD (  20.10  )
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

This commit updates the behavior of signal handling under !MMU
environment. 1) the stack preparation for the signal handlers and
2) restoration of stack after rt_sigreturn(2) syscall.  Those are needed
as the stack usage on vfork(2) syscall is different.

It also adds the follow up routine for SIGSEGV as a signal delivery runs
in the same stack frame while we have to avoid endless SIGSEGV.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/include/shared/kern_util.h |  3 +++
 arch/um/kernel/trap.c              | 10 ++++++++
 arch/um/os-Linux/signal.c          | 18 ++++++++++++++-
 arch/x86/um/signal.c               | 37 +++++++++++++++++++++++++++++-
 4 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index f21dc8517538..bcc8d28279ae 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -62,6 +62,9 @@ extern int singlestepping(void);
 extern void segv_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs);
 extern void winch(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs);
 extern void fatal_sigsegv(void) __attribute__ ((noreturn));
+#ifndef CONFIG_MMU
+extern void sigsegv_post_routine(void);
+#endif
 
 void um_idle_sleep(void);
 
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index a7519b3de4bf..b9b54e777894 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -174,6 +174,16 @@ void fatal_sigsegv(void)
 	os_dump_core();
 }
 
+#ifndef CONFIG_MMU
+void sigsegv_post_routine(void)
+{
+	change_sig(SIGIO, 1);
+	change_sig(SIGALRM, 1);
+	change_sig(SIGWINCH, 1);
+	userspace(&current->thread.regs.regs);
+}
+#endif
+
 /**
  * segv_handler() - the SIGSEGV handler
  * @sig:	the signal number
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 52852018a3ad..a06622415d8f 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -36,7 +36,15 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 	struct uml_pt_regs r;
 	int save_errno = errno;
 
-	r.is_user = 0;
+#ifndef CONFIG_MMU
+	memset(&r, 0, sizeof(r));
+	/* mark is_user=1 when the IP is from userspace code. */
+	if (mc && (REGS_IP(mc->gregs) > uml_reserved
+		   && REGS_IP(mc->gregs) < high_physmem))
+		r.is_user = 1;
+	else
+#endif
+		r.is_user = 0;
 	if (sig == SIGSEGV) {
 		/* For segfaults, we want the data from the sigcontext. */
 		get_regs_from_mc(&r, mc);
@@ -191,6 +199,7 @@ static void hard_handler(int sig, siginfo_t *si, void *p)
 	ucontext_t *uc = p;
 	mcontext_t *mc = &uc->uc_mcontext;
 	unsigned long pending = 1UL << sig;
+	int is_segv = 0;
 
 	do {
 		int nested, bail;
@@ -214,6 +223,7 @@ static void hard_handler(int sig, siginfo_t *si, void *p)
 
 		while ((sig = ffs(pending)) != 0){
 			sig--;
+			is_segv = (sig == SIGSEGV) ? 1 : 0;
 			pending &= ~(1 << sig);
 			(*handlers[sig])(sig, (struct siginfo *)si, mc);
 		}
@@ -227,6 +237,12 @@ static void hard_handler(int sig, siginfo_t *si, void *p)
 		if (!nested)
 			pending = from_irq_stack(nested);
 	} while (pending);
+
+#ifndef CONFIG_MMU
+	/* if there is SIGSEGV notified, let the userspace run w/ __noreturn */
+	if (is_segv)
+		sigsegv_post_routine();
+#endif
 }
 
 void set_handler(int sig)
diff --git a/arch/x86/um/signal.c b/arch/x86/um/signal.c
index 75087e85b6fd..b7365c75a967 100644
--- a/arch/x86/um/signal.c
+++ b/arch/x86/um/signal.c
@@ -371,6 +371,13 @@ int setup_signal_stack_si(unsigned long stack_top, struct ksignal *ksig,
 		round_down(stack_top - sizeof(struct rt_sigframe), 16);
 
 	/* Add required space for math frame */
+#ifndef CONFIG_MMU
+	/*
+	 * the sig_frame on !MMU needs be aligned for SSE as
+	 * the frame is used as-is.
+	 */
+	math_size = round_down(math_size, 16);
+#endif
 	frame = (struct rt_sigframe __user *)((unsigned long)frame - math_size);
 
 	/* Subtract 128 for a red zone and 8 for proper alignment */
@@ -417,6 +424,18 @@ int setup_signal_stack_si(unsigned long stack_top, struct ksignal *ksig,
 		/* could use a vstub here */
 		return err;
 
+#ifndef CONFIG_MMU
+	/*
+	 * we need to push handler address at top of stack, as
+	 * __kernel_vsyscall, called after this returns with ret with
+	 * stack contents, thus push the handler here.
+	 */
+	frame = (struct rt_sigframe __user *) ((unsigned long) frame -
+					       sizeof(unsigned long));
+	err |= __put_user((unsigned long)ksig->ka.sa.sa_handler,
+			  (unsigned long *)frame);
+#endif
+
 	if (err)
 		return err;
 
@@ -442,9 +461,25 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	unsigned long sp = PT_REGS_SP(&current->thread.regs);
 	struct rt_sigframe __user *frame =
 		(struct rt_sigframe __user *)(sp - sizeof(long));
-	struct ucontext __user *uc = &frame->uc;
+	struct ucontext __user *uc;
 	sigset_t set;
 
+#ifndef CONFIG_MMU
+	/**
+	 * we enter here with:
+	 *
+	 * __restore_rt:
+	 *     mov $15, %rax
+	 *     call *%rax (translated from syscall)
+	 *
+	 * (code is from musl libc)
+	 * so, stack needs to be popped of "call"ed address before
+	 * looking at rt_sigframe.
+	 */
+	frame = (struct rt_sigframe __user *)((unsigned long)frame + sizeof(long));
+#endif
+	uc = &frame->uc;
+
 	if (copy_from_user(&set, &uc->uc_sigmask, sizeof(set)))
 		goto segfault;
 
-- 
2.43.0


