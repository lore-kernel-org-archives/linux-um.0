Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962B8D2444F
	for <linux-um@archiver.kernel.org>; Thu, 10 Oct 2024 20:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nszzlxw9yTJhBjjpB73SNX4YlkuHo1yoYFr6BzRGbpc=; b=FADeTCySdnw+DnKqr5KllD+XyQ
	SUvWe9wLX8awCndPtAlp5Ewp9pQEk7lqrTDd5WPOXYau7X3IjA5PIpzgzJ7401iBDshtVlqLNwxnJ
	GgnWhZO3K4OSfaQVV2SYHYkik5g+a1U1I+2auTdHawbhRMtnd5vkP+cGaaxB5jWl6/WpM0B6Yll4o
	+RLuaKxvdWjIfPMI4wF9qmyhQw1ahjFgyvbgKvnqN/wcaeE6fIacDfJJ0PQ8S9mAM44Wrc7iMIIyX
	oeYnRmwBdAHPN7mYdV2noFOsKgJiKTYvuo3j2SxbxM9INgYS5DTiCnl5isnBTuQ/Q4MviW0pDHVip
	fTBljpLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sz0By-0000000EL1D-3NWI;
	Thu, 10 Oct 2024 20:55:26 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sz02B-0000000EK7c-2oyF
	for linux-um@lists.infradead.org;
	Thu, 10 Oct 2024 20:45:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=nszzlxw9yTJhBjjpB73SNX4YlkuHo1yoYFr6BzRGbpc=; t=1728593119; x=1729802719; 
	b=l2/vPS69+LYBgqQDf0gxn9Y3Qc2yy3DYAc/kBHuDYIQzz2SGizaY0rKlyEMvXnm+q6b0zqqO3jj
	Z14MpxIYOvxp76gNVygZFofGR0q3o4QOUZYsTRSgdNxRiUpCj/hMnjolU9qL4tci50rozvltXAx0z
	fUlRE22JyKPhZZ8DXQKq//TdKumFHlP5lf9bBIAPnXNmPqS6q1l4+pTdRBbWrQd9zqdNp5txK3qdX
	rMaGld4XWigJA6a6zo75PSCjNmB7SYKeghMXzov23cyuWb3jTrBx1LwdhHNwOF4ldYAcikrZui8nj
	XgDMKSECEYZoZkSqRV1nwl0nLB6nz2T3Oxdw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sz028-00000006JfK-0aRa;
	Thu, 10 Oct 2024 22:45:16 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] um: remove fault_catcher infrastructure
Date: Thu, 10 Oct 2024 22:45:14 +0200
Message-ID: <20241010224513.901c4d390b3e.Ia74742668b44603c1ca23dd36f90e964e6e7ee55@changeid>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_134519_750527_28893F57 
X-CRM114-Status: GOOD (  14.20  )
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

From: Johannes Berg <johannes.berg@intel.com>

This was perhaps intended to do _nofault copies, but the
real reason is lost to history. Remove this, it's not
needed, and using longjmp() out of the middle of the
signal handler with all the state it has modified is
not going to be a good idea anyway.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/asm/processor-generic.h |  3 ---
 arch/um/include/shared/kern_util.h      |  1 -
 arch/um/kernel/trap.c                   | 16 ----------------
 arch/um/os-Linux/signal.c               |  2 +-
 4 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
index bce4595798da..02e759a4a435 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -22,8 +22,6 @@ struct mm_struct;
 struct thread_struct {
 	struct pt_regs regs;
 	struct pt_regs *segv_regs;
-	void *fault_addr;
-	jmp_buf *fault_catcher;
 	struct task_struct *prev_sched;
 	struct arch_thread arch;
 	jmp_buf switch_buf;
@@ -38,7 +36,6 @@ struct thread_struct {
 #define INIT_THREAD \
 { \
 	.regs		   	= EMPTY_REGS,	\
-	.fault_addr		= NULL, \
 	.prev_sched		= NULL, \
 	.arch			= INIT_ARCH_THREAD, \
 	.request		= { } \
diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index d8ffd2db168e..f21dc8517538 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -60,7 +60,6 @@ extern unsigned long from_irq_stack(int nested);
 extern int singlestepping(void);
 
 extern void segv_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs);
-extern void bus_handler(int sig, struct siginfo *si, struct uml_pt_regs *regs);
 extern void winch(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs);
 extern void fatal_sigsegv(void) __attribute__ ((noreturn));
 
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 97c8df9c4401..cdaee3e94273 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -201,7 +201,6 @@ void segv_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 		   struct uml_pt_regs *regs)
 {
-	jmp_buf *catcher;
 	int si_code;
 	int err;
 	int is_write = FAULT_WRITE(fi);
@@ -246,15 +245,8 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 		address = 0;
 	}
 
-	catcher = current->thread.fault_catcher;
 	if (!err)
 		goto out;
-	else if (catcher != NULL) {
-		current->thread.fault_addr = (void *) address;
-		UML_LONGJMP(catcher, 1);
-	}
-	else if (current->thread.fault_addr != NULL)
-		panic("fault_addr set but no fault catcher");
 	else if (!is_user && arch_fixup(ip, regs))
 		goto out;
 
@@ -310,14 +302,6 @@ void relay_signal(int sig, struct siginfo *si, struct uml_pt_regs *regs)
 	}
 }
 
-void bus_handler(int sig, struct siginfo *si, struct uml_pt_regs *regs)
-{
-	if (current->thread.fault_catcher != NULL)
-		UML_LONGJMP(current->thread.fault_catcher, 1);
-	else
-		relay_signal(sig, si, regs);
-}
-
 void winch(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 {
 	do_IRQ(WINCH_IRQ, regs);
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index b11ed66c8bb0..1978eaa557e9 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -26,7 +26,7 @@ void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *) = {
 	[SIGFPE]	= relay_signal,
 	[SIGILL]	= relay_signal,
 	[SIGWINCH]	= winch,
-	[SIGBUS]	= bus_handler,
+	[SIGBUS]	= relay_signal,
 	[SIGSEGV]	= segv_handler,
 	[SIGIO]		= sigio_handler,
 };
-- 
2.47.0


