Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476CDC44501
	for <linux-um@archiver.kernel.org>; Tue,  7 Jul 2026 19:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=4+5KtSAhpclzOPxgH9736FL7Uf1pNCSlMPQrqwffdRU=; b=IxNi7KjDK9XfYR
	TFRa8ly4EaZVl6tvUYaEu4TJCMtWJY1IgJyoyxksNJBns1hl5Rkv1PyAk9VjLy7gSRckAVZOkaUB5
	1JbgMKdAwGlvGhdi+doBgIzH718yYAcDZTOkfuvN+qhfSJBgOUARLC2SWg18d5laya/iYhzXUYcC6
	j6dpPBTi+pUQmPiIcdbtlGxTbuAwIG9T5Kt2SLfjjmjU0q1Ko88LaGAmit7MXSkbSfIRpdBB+NZD9
	sbvfUFAJCBthXmiXVdi68ot9d2+pr2WH5a/KGRDX43+YbWgD2Zta/T2FX4u1ZRJwX4hQ+zzzm/SI/
	T91QcJrg1xO8/+Zu0xrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whB7Z-0000000FgtJ-3TLX;
	Tue, 07 Jul 2026 19:06:17 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whB7W-0000000FgoT-2JlZ;
	Tue, 07 Jul 2026 19:06:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 007A061389;
	Tue,  7 Jul 2026 19:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3571F000E9;
	Tue,  7 Jul 2026 19:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451173;
	bh=4+5KtSAhpclzOPxgH9736FL7Uf1pNCSlMPQrqwffdRU=;
	h=Date:From:To:Cc:Subject:References;
	b=L0NwhOtn/pOWM0ulqppTdz+f5F1vPIiktRF8++iqaXbfQrbA09EWRmKXUTgs+tJGZ
	 9BOc+sE0QdxWAWxboebj5k3TGGiEZy86TkscBomKuqCnVcID0FRgb+hXm7kRhQb508
	 18f9wNTMGjmah3berrpcvUtgyoh65Oruioe9rXjT2vjCE0ifLG+hzmK2ha75qKIz8p
	 1GtYXAThFYccYlfm3dA4KtHGVG1cGenYQHaPXFR1tPeFk2o5v6tnBtmGInkBCyatdE
	 GHsMMbjrc9U1K+LMYACpZgx7BpGh3yI1J/j1USPF0e6lRALp6AqGe77XqRzuOFecve
	 UXBMPM/ZYnxHQ==
Date: Tue, 07 Jul 2026 21:06:11 +0200
Message-ID: <20260707190253.865955911@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Michael Ellerman <mpe@ellerman.id.au>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Kees Cook <kees@kernel.org>,
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
Subject: [patch 04/18] loongarch/syscall: Use
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
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev
---
 arch/loongarch/kernel/syscall.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/arch/loongarch/kernel/syscall.c
+++ b/arch/loongarch/kernel/syscall.c
@@ -11,7 +11,6 @@
 #include <linux/linkage.h>
 #include <linux/nospec.h>
 #include <linux/objtool.h>
-#include <linux/randomize_kstack.h>
 #include <linux/syscalls.h>
 #include <linux/unistd.h>
 
@@ -70,9 +69,7 @@ void noinstr __no_stack_protector do_sys
 	regs->orig_a0 = regs->regs[4];
 	regs->regs[4] = -ENOSYS;
 
-	nr = syscall_enter_from_user_mode(regs, nr);
-
-	add_random_kstack_offset();
+	nr = syscall_enter_from_user_mode_randomize_stack(regs, nr);
 
 	if (nr < NR_syscalls) {
 		syscall_fn = sys_call_table[array_index_nospec(nr, NR_syscalls)];


