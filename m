Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7919C44501
	for <linux-um@archiver.kernel.org>; Tue,  7 Jul 2026 19:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=FSz9R//tXkAkFf727Rcog7SX40mWm3WZD+GcFTZrqNo=; b=NNUp+dYYLw231g
	27fGIqYvqukeorZzqs22rs3qDNrT8AD1dQ9Ej70SP1FzdjYHVceNMpKyTlpMEwPERB0rZOebjpAvR
	/kxGFW3MKV6mX9QOlA0KHv8/gXGdmImGBKX5q4IhEb22Hfq4c7Fk0XTvCIpreUfPxlszVH9Jd2szn
	giEodH+I0S9ZD3W98tCDHQqiiCEB6obHHqO4QRfSrsCSitmz2rPl07h6b2x4ueIWboYRh/d4IggTk
	MpbYnbmJ+G2V5bTVI9SmYwHJdiaWXjIduN43Rf5aOXhaAB8UM4NkC2SbL7zECP9XuWE5pFuY7CyXj
	WupFzWy5ExW5FtNe88Cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whB7q-0000000Fh8q-2T6x;
	Tue, 07 Jul 2026 19:06:34 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whB7e-0000000Fgxw-3u1d;
	Tue, 07 Jul 2026 19:06:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5EBE9601ED;
	Tue,  7 Jul 2026 19:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5D11F00A3D;
	Tue,  7 Jul 2026 19:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451182;
	bh=FSz9R//tXkAkFf727Rcog7SX40mWm3WZD+GcFTZrqNo=;
	h=Date:From:To:Cc:Subject:References;
	b=jmy5NgtN1SD2HqwkVPG0TWkFN54TmdXj7T1HSJ0YKKwFEFYGJZgl0bxw21Z5Zw6gF
	 oLz0li+t91OzAxgXcJufOtcILCljJifd/dtqOAvAWgylV3Gsd2EQ0rLxbGfO01LU0j
	 fGSFcIN5CQo8Eb+XAIcZbFr1t/Rccy9Jg9VrEGxft5Y0XFjAFPmIVc5t+s4ruAoLPe
	 NXUZ3wSbTXF7v2pk2mNXgxKVbV69AzbsU6gyihCw7XUl2EEorcZSB4GwvDUCm+Y5ri
	 rE9qNujpevqvyyh40zbml6ST8aYSMsFvamJntu3IcdBj7uE8fU0k0BtndQzpUpA3fJ
	 QZRGwGblw5h8g==
Date: Tue, 07 Jul 2026 21:06:19 +0200
Message-ID: <20260707190253.974626922@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Kees Cook <kees@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
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
Subject: [patch 06/18] riscv/syscall: Use
 syscall_enter_from_user_mode_randomize_stack()
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

syscall_enter_from_user_mode_randomize_stack() replaces
syscall_enter_from_user_mode() and the subsequent invocation of
add_random_kstack_offset().

The advantage is that it applies the stack randomization right after
enter_from_user_mode() and thereby avoids the overhead of get/put_cpu_var()
as that code is invoked with interrupts disabled.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org
---
 arch/riscv/kernel/traps.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -7,7 +7,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/irqflags.h>
-#include <linux/randomize_kstack.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/signal.h>
@@ -333,9 +332,7 @@ void do_trap_ecall_u(struct pt_regs *reg
 
 		riscv_v_vstate_discard(regs);
 
-		syscall = syscall_enter_from_user_mode(regs, syscall);
-
-		add_random_kstack_offset();
+		syscall = syscall_enter_from_user_mode_randomize_stack(regs, syscall);
 
 		if (syscall >= 0 && syscall < NR_syscalls) {
 			syscall = array_index_nospec(syscall, NR_syscalls);


