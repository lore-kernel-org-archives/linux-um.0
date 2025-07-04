Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB16C8303D
	for <linux-um@archiver.kernel.org>; Fri,  4 Jul 2025 13:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MQ8S2P6tr58+gxioMqiPvqUsLz1lP2Wb0NQnRQjJAB8=; b=Y2Bb1fMZ2bmmxOfHImUJZoQHUX
	r5fdWZ1oWqiXS1Stm64lbnuxqd6P1sabO8FsqLMsB0CLvHo8LQAD7RmIVXrEPY007nZNOJxCTQEcz
	zxp1EtGCVYyzedHVHS4J3iy5yoeerZgRWP36r4iormQfaLmfTDGpDpWI8cJ+0xfYUaP9Cc6pt+jEw
	4BItor75r1qB+HIERXPilVmV2W/DBmPE1nT7+OAxRA4sZu/87yNcIhdxdACLzs/roR2T8oNjZfLde
	rzFTK7sWaPmK1pNBcux09ndTe8UmaNph5Ob1JNzx0G6nvXRUxuDBEKQc+ad6NKp3LDDpSRPKOQVfK
	xZb2bOBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXgaf-0000000EXJQ-0nju;
	Fri, 04 Jul 2025 13:36:33 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXfdM-0000000EOtE-3JBb
	for linux-um@bombadil.infradead.org;
	Fri, 04 Jul 2025 12:35:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=MQ8S2P6tr58+gxioMqiPvqUsLz1lP2Wb0NQnRQjJAB8=; b=QNwHrmqwWbEjRW1PIMILIqmIve
	idZdtZbq5mqiyWhfWRhozTOZ51wbRxF/uZj0TJRpoA0O9DloyYWKEZYt7PRB97gZFnCVf15R0M1R6
	Gk1Onpl/pcfZczlCyVUCb5FXAd3IZ9rdRfP4QzjXWjM7A65rPKt80C0dHymEWt1ORwzqteiFDDtQk
	TTGaoHyGK106+WfMitlRFBXLAOepibcIWdO2ih2ZqdiMdUjYShUBmj8Eh5mpydmypD4+MmEnZhUr5
	duPOcG2iqGAUt2YNAvZ7w5DsoL7qZdDU1ZbotfSizVCUNs0iLPjr13J4rNaKRPIkQsBIuBUdHjwFb
	Zk9rjwYQ==;
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXfdJ-00000007yVO-3rHV
	for linux-um@lists.infradead.org;
	Fri, 04 Jul 2025 12:35:15 +0000
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751632511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MQ8S2P6tr58+gxioMqiPvqUsLz1lP2Wb0NQnRQjJAB8=;
	b=Sb3dBoLNnSkyajIhodo7cj/Di50cmVQJQ6QziMvNOtfU4fjiN2J3auhKj3Taq8Ab1bYFDL
	lVZJL6QeCpwvKZDMOnRHODSVICPS5MXo8WpX0IoK+H9pmonNPvj1JB9BzevTq3ORgSHmba
	r1KAI7GDu1G9yh9D/lzTqmTfKPvAFiVd8cvBLP/XGTDWIqY+KqD4yPQgsoyCl4l9hP5ukf
	wz99pIa0ZLC4dTHJYDSarIs4nEIqTViJMpGfsDQLTyGauvelgntWjjFygOLricvKifAJAG
	NO8+RL1VU5JaqBrYo/XP3zj/flThqccCypUuGKBA96/jOHwsyO59Pe/m3+4mcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751632511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MQ8S2P6tr58+gxioMqiPvqUsLz1lP2Wb0NQnRQjJAB8=;
	b=S4duA70QNhQb/AOlTDxvtZ36FBu7BcQF9mVE8vZZtFhBz6yi98lXkm4DArhqMekcQRpxHI
	cVP3cfIZpURydDDQ==
Date: Fri, 04 Jul 2025 14:34:47 +0200
Subject: [PATCH] um: Re-evaluate thread flags repeatedly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250704-uml-thread_flags-v1-1-0e293fd8d627@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAGbKZ2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcwNj3dLcHN2SjKLUxJT4tJzE9GLdlDRDCxNTY9Mks2RzJaC2gqLUtMw
 KsJHRsbW1ANeAsBBiAAAA
X-Change-ID: 20250703-uml-thread_flags-df184535b6c7
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Nam Cao <namcao@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751632510; l=2500;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=1EEsk3CakOIK6uLy9xJ0+8ZrzcRqWqydDglc717WYjg=;
 b=Ncey8gWeakla09DCNmGT3PSI/G9tKWkGd/DZxzcF5ZZH1bZxFJDEx048UdBMeaa0DqoGYlR1t
 ct4Kep8B/9eASY5WMF/EJkgJgvAHZBnfvjcn7P6Hmx4XQCrxM5QjLzg
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250704_133514_121324_7C1BED9F 
X-CRM114-Status: UNSURE (   9.07  )
X-CRM114-Notice: Please train this message.
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

The thread flags may change during their processing.
For example a task_work can queue a new signal to be sent.
This signal should be delivered before returning to usespace again.

Evaluate the flags repeatedly similar to other architectures.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Nam Cao <namcao@linutronix.de>
---
 arch/um/include/asm/thread_info.h |  4 ++++
 arch/um/kernel/process.c          | 20 ++++++++++++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/um/include/asm/thread_info.h b/arch/um/include/asm/thread_info.h
index f9ad06fcc991a2b10e2aa6059880b993e3d60a2d..eb9b3a6d99e84751a0b48ba516aaf25752e90873 100644
--- a/arch/um/include/asm/thread_info.h
+++ b/arch/um/include/asm/thread_info.h
@@ -50,7 +50,11 @@ struct thread_info {
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_MEMDIE		(1 << TIF_MEMDIE)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
+#define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 
+#define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL | \
+				 _TIF_NOTIFY_RESUME)
+
 #endif
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 0cd6fad3d908d43e84ebc821676e05377ec641e9..1be644de9e41ecdb94d379760ee8790c1d0657c6 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -82,14 +82,18 @@ struct task_struct *__switch_to(struct task_struct *from, struct task_struct *to
 void interrupt_end(void)
 {
 	struct pt_regs *regs = &current->thread.regs;
-
-	if (need_resched())
-		schedule();
-	if (test_thread_flag(TIF_SIGPENDING) ||
-	    test_thread_flag(TIF_NOTIFY_SIGNAL))
-		do_signal(regs);
-	if (test_thread_flag(TIF_NOTIFY_RESUME))
-		resume_user_mode_work(regs);
+	unsigned long thread_flags;
+
+	thread_flags = read_thread_flags();
+	while (thread_flags & _TIF_WORK_MASK) {
+		if (thread_flags & _TIF_NEED_RESCHED)
+			schedule();
+		if (thread_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
+			do_signal(regs);
+		if (thread_flags & _TIF_NOTIFY_RESUME)
+			resume_user_mode_work(regs);
+		thread_flags = read_thread_flags();
+	}
 }
 
 int get_current_pid(void)

---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250703-uml-thread_flags-df184535b6c7

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


