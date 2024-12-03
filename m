Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7CEE6C5FB
	for <linux-um@archiver.kernel.org>; Tue,  3 Dec 2024 04:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QGKyoD9iXC2o78Ra9unBAUmtsB+iods/6RLOinj2BAE=; b=nRrUwj2kz3Lfk1QPEBoH07NqhB
	EeeaAjIZXRVwMN2Qd4GnkjGmVQkljNfyQQas9fp4d5gZDR/KD8mrShH2kWeZJlKnzDRhDj+GSNscB
	AKO+ebj8Bu2v36XsqegAIs4dj7Ye2rP1UgGZdUCJcrdMfqX20x0W7ZHV2Giw1IVN0CvvCloto/9aI
	Dmn2ABKmLLbLJPvRK25LCS+sjpEjMlxTZw/Wa0pbnU1BT0dVeCdQsg7IyyEQLgOzM7sDfTUhh9SIh
	kr7UPXyYUf1nIfgQp5YYTffbaiYiTRz8T3MbLvcLGH+U9g7XEV9Xy/aiBucpcFdirseHmJ3WkeV6v
	XcyICRzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKS8-00000008DUr-0E6h;
	Tue, 03 Dec 2024 04:24:00 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKS5-00000008DTn-3fCt
	for linux-um@lists.infradead.org;
	Tue, 03 Dec 2024 04:23:58 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-215c4000c20so553025ad.3
        for <linux-um@lists.infradead.org>; Mon, 02 Dec 2024 20:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733199837; x=1733804637; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGKyoD9iXC2o78Ra9unBAUmtsB+iods/6RLOinj2BAE=;
        b=Pxqbx7CNjoRrk2IuOUty7yyII5KwpJfCkdDQgkCQkzIZY10B86zHrSpWJEANn7YjtK
         sNJ00TPq4V7cczZNkfps77Hc29kkvFR1vw1XyxwaG8rUOyTHNsUS6n9YdvKaOQiHIrG7
         E17l3it8h1+TAjRJ1Wmh2Tjyi+eKI6JkUaH/i1mdEsGzGgpF8g4peDc81KRsH2FXFjmS
         lki5xLM8XiPtZKISLugYjov8mZPIoXSDxfMkAKrWk2E9wA0XX+HqIsGyJFc9okl9aDib
         W0BAnOMyvLSDzIVb0bSbjbo82IVLe7AuYKYnT2iNorz/T5rQ6lV1YYUugVaPpNIU86gR
         utig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733199837; x=1733804637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGKyoD9iXC2o78Ra9unBAUmtsB+iods/6RLOinj2BAE=;
        b=UGD0PhSzS8vbT1SzIJnfZEcK6b3B2h4pC3GhsY/Ou/1OFdITE3cK211rQIvVKJPkj2
         1bNyhSjpwcwVeNNUh8++2LGqxN2hCBdwLt1wENeJTb7tMzzXr9i4zyPeh/6ZJ0pvmV4F
         3i0nkqWcL4xa0g8PDI6bfd7ucdb1pd29ciA9nAgy0waySwI3+4IiKeKgOviUEfvDLmRX
         lRPLO75R3KQsmqGiAcAF0/8tG+IbldsepUP3ngkQUoc7hdK/DiaG+5sGG++AraG5cJsN
         d/OGhNOf8fA4tdnkoDQuapBmEau1cEiiOjBoyWw+aCK2IIUFwFIL6ISdYJk3bWB7WNoo
         qyvw==
X-Gm-Message-State: AOJu0YyqcC3foyWg9fsmYt6ueLKF2LjFsz/Q5ThbmTBNbcm753izhGuz
	fj9dYdyV8AmjHKKtHyDLFV3OoWQV4vzv0NUtsHF4lYuzApaxHmyh
X-Gm-Gg: ASbGncupSl6jdYvLR475ssJkVWV2hxqaot3P8GWiJqzg4/mmZ1Wx3yvouNzm3/Wloj3
	KDCA6SVYwvn6fCjekWiXbuJWt6nY6I5/yAANVb4FrhkZwRMcql0mRurMa9JxOxdYu//wmoHEuqT
	gW9sVSH+WThOfZB2+KbjtQCX9eiVGJNLJca6Iq44SIL6zjbxGP3AoKW4nAgCusi/Eef0WTRTWfT
	4we4pZuM/pTTccOAe6hWJoWf4qIEuUw73WJmArgCNHZi47RLP8QdPGuB/+8a6M3YZFmCorMYsLB
	BVmqOA2NQh2vxdOfE5we
X-Google-Smtp-Source: AGHT+IE4rQr5mAtO5fA29NlUdsAzpoZCc1N5yrR67aPZ5O4VHmbTfg6YGu8kNo7k91njJKRSoFhWnw==
X-Received: by 2002:a17:902:e80f:b0:215:7421:262 with SMTP id d9443c01a7336-215bd1b46c6mr15758155ad.12.1733199837052;
        Mon, 02 Dec 2024 20:23:57 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2153d61aabfsm70255045ad.136.2024.12.02.20.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 20:23:56 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 1A433DD3A0B; Tue,  3 Dec 2024 13:23:54 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v3 10/13] x86/um: nommu: signal handling
Date: Tue,  3 Dec 2024 13:23:09 +0900
Message-ID: <86fdb0dc354ce7724ea8cbdd8d17862e602a25bf.1733199770.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733199769.git.thehajime@gmail.com>
References: <cover.1733199769.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_202357_910035_0318D47A 
X-CRM114-Status: GOOD (  17.44  )
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
 arch/um/os-Linux/signal.c | 16 +++++++++++++++-
 arch/x86/um/signal.c      | 37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index c0d1fb1fc0c4..de3ed8fc0268 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -55,7 +55,15 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
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
@@ -69,6 +77,12 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 	(*sig_info[sig])(sig, si, &r);
 
 	errno = save_errno;
+
+#ifndef CONFIG_MMU
+	/* force handle signals after rt_sigreturn() */
+	if (r.is_user && sig == SIGSEGV)
+		mc_set_regs_ip_relay(mc);
+#endif
 }
 
 /*
diff --git a/arch/x86/um/signal.c b/arch/x86/um/signal.c
index 75087e85b6fd..e1b3a87ddc5d 100644
--- a/arch/x86/um/signal.c
+++ b/arch/x86/um/signal.c
@@ -370,6 +370,13 @@ int setup_signal_stack_si(unsigned long stack_top, struct ksignal *ksig,
 	frame = (struct rt_sigframe __user *)
 		round_down(stack_top - sizeof(struct rt_sigframe), 16);
 
+#ifndef CONFIG_MMU
+	/*
+	 * the sig_frame on !MMU needs be aligned for SSE as
+	 * the frame is used as-is.
+	 */
+	math_size = round_down(math_size, 16);
+#endif
 	/* Add required space for math frame */
 	frame = (struct rt_sigframe __user *)((unsigned long)frame - math_size);
 
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


