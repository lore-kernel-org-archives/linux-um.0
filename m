Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA03C44503
	for <linux-um@archiver.kernel.org>; Tue,  7 Jul 2026 19:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=LBj+ZkGRdAQN74z4D94PD8p6NaRtGe8kKF18FGUoSBc=; b=vdXnVOn99LMPgf
	PPvre1BHrBeR22oCLJsmxsA2qq0y1c0WkPqBzmq4SEYYxxeEWkAGjvyODISeyyYWaUjuuGIp7MVd9
	1qKcsj8Bc0oLX6v7vzqN5uIha5gEPPnhyBDABmJtD509jmT/M7STkmDC0ntujhK+xluOWvNoCRPl0
	eNNF/KOenuVsnHfgNRFxE0ZGxHmnW4Ye+iLBBNr+/ybMgGQkTVy12lV1pxcPB9r7Ltx/yTzJfifPT
	TniUReIhfoMLMAKfQnJ+AtNF1jmUwsayJTEj+2+sIfdzWfSC7//IuqXOT3pH5nc0CmUbrcX7569ZA
	tqtvw5WHGpVQh0scL6Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whB7X-0000000Fgpm-0aoE;
	Tue, 07 Jul 2026 19:06:15 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whB7S-0000000FgkQ-1a9d;
	Tue, 07 Jul 2026 19:06:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CAD1561384;
	Tue,  7 Jul 2026 19:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B438D1F00A3D;
	Tue,  7 Jul 2026 19:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451169;
	bh=LBj+ZkGRdAQN74z4D94PD8p6NaRtGe8kKF18FGUoSBc=;
	h=Date:From:To:Cc:Subject:References;
	b=VY1zowsespAaLkdQfjN21WoDu0I2bpmruM24iQyJPomLBoNcfhRcxHp71u2Qaoz8w
	 2Y6R/xVT7Yp0jxQTc8E5PWuftOuCpOuAgoGxlRSnJZdeLFmp/X5t3iL3htCKZRfn3+
	 ZILTZaA9qyxubwDpKLYazC72ZykMomE0EWqkxhprvJrhHU6PoirMY9t5PUOI4e22OR
	 1Mzlboe/bN4bCNA4g1TTcbgSS+G0cMdMv/Ny3g+iZse0ddGOTpczuxmdM6Qdp/eE7e
	 Cdr45b4mkb4xZpki9QM7BPX+TNtyRnQRDjpUHUDvask5gaQC50oiZ/ZZKDlC+8+3Ru
	 MjqY28jZMNheA==
Date: Tue, 07 Jul 2026 21:06:07 +0200
Message-ID: <20260707190253.816918647@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Kees Cook <kees@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 x86@kernel.org,
 Mark Rutland <mark.rutland@arm.com>,
 Jinjie Ruan <ruanjinjie@huawei.com>,
 Andy Lutomirski <luto@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Guo Ren <guoren@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>,
 Chris Zankel <chris@zankel.net>,
 linux-arm-kernel@lists.infradead.org,
 linux-alpha@vger.kernel.org,
 linux-csky@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org,
 Arnd Bergmann <arnd@arndb.de>,
 Vineet Gupta <vgupta@kernel.org>,
 Will Deacon <will@kernel.org>,
 Brian Cain <bcain@kernel.org>,
 Michal Simek <monstr@monstr.eu>,
 Dinh Nguyen <dinguyen@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org,
 linux-hexagon@vger.kernel.org,
 linux-openrisc@vger.kernel.org,
 sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org,
 =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
Subject: [patch 03/18] entry: Provide
 [syscall_]enter_from_user_mode_randomize_stack()
References: <20260707181957.433213175@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Randomizing the syscall stack can only happen after state is established
via enter_from_user_mode() or syscall_enter_from_user_mode(). The earlier
it happens the better.

Provide two new macros to consolidate that:

  - enter_from_user_mode_randomize_stack()
	enter_from_user_mode();
	add_random_kstack_offset_irqsoff();

  - syscall_enter_from_user_mode_randomize_stack()
	enter_from_user_mode_randomize_stack();
	syscall_enter_from_user_mode_work();
    
to reduce boiler plate code.

Those are macros and not inline functions as the latter would limit the
stack randomization scope to the inline function itself.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
 include/linux/entry-common.h |   56 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -6,6 +6,7 @@
 #include <linux/irq-entry-common.h>
 #include <linux/livepatch.h>
 #include <linux/ptrace.h>
+#include <linux/randomize_kstack.h>
 #include <linux/resume_user_mode.h>
 #include <linux/seccomp.h>
 #include <linux/sched.h>
@@ -150,6 +151,61 @@ static __always_inline long syscall_ente
 }
 
 /**
+ * enter_from_user_mode_randomize_stack - Establish state and add stack randomization
+ *					  before invoking syscall_enter_from_user_mode_work()
+ * @regs:	Pointer to currents pt_regs
+ *
+ * Invoked from architecture specific syscall entry code with interrupts
+ * disabled. The calling code has to be non-instrumentable. When the function
+ * returns all state is correct, interrupts are still disabled and the
+ * subsequent functions can be instrumented.
+ *
+ * Implemented as a macro so that the stack randomization is effective
+ * throughout the function in which it is invoked. An inline would only make it
+ * effective in the scope of the inline function.
+ */
+#define enter_from_user_mode_randomize_stack(regs)			\
+do {									\
+	enter_from_user_mode(regs);					\
+	instrumentation_begin();					\
+	add_random_kstack_offset_irqsoff();				\
+	instrumentation_end();						\
+} while (0)
+
+/**
+ * syscall_enter_from_user_mode_randomize_stack - Establish state and check and handle work
+ *						  before invoking a syscall
+ * @regs:	Pointer to currents pt_regs
+ * @syscall:	The syscall number
+ *
+ * Invoked from architecture specific syscall entry code with interrupts
+ * disabled. The calling code has to be non-instrumentable. When the
+ * function returns all state is correct, interrupts are enabled and the
+ * subsequent functions can be instrumented.
+ *
+ * This is the combination of enter_from_user_mode_randomize_stack() and
+ * syscall_enter_from_user_mode_work() to be used when there is no
+ * architecture specific work to be done between the two.
+ *
+ * Returns: The original or a modified syscall number. See
+ * syscall_enter_from_user_mode_work() for further explanation.
+ *
+ * Implemented as a macro to make stack randomization effective in the calling
+ * scope.
+ */
+#define syscall_enter_from_user_mode_randomize_stack(regs, syscall)	\
+({									\
+	enter_from_user_mode_randomize_stack(regs);			\
+									\
+	instrumentation_begin();					\
+	local_irq_enable();						\
+	long _ret = syscall_enter_from_user_mode_work(regs, syscall);	\
+	instrumentation_end();						\
+									\
+	_ret;								\
+})
+
+/**
  * syscall_enter_from_user_mode - Establish state and check and handle work
  *				  before invoking a syscall
  * @regs:	Pointer to currents pt_regs


