Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2AAC44507
	for <linux-um@archiver.kernel.org>; Tue,  7 Jul 2026 19:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=k5p+gDeGow5od0W2jgXaapJrAZfwc3i2DfCDO4w4k2U=; b=fNlBRPShe++o5x
	46uXwz9U6WrMwTnXqcrH9Ltc0WoA+n9N57leVhCnkMrtvZKG+gm3oO7rU254+XYh59hzjMZ9b44pc
	3/uFud84qnBiHlvvmM2HiOg8DocdL8bTpMGY2iD3ic1nWBlLqVqVgQC05JOrmqqknzLF1w/oz8iVv
	JltyL/IJjzhzk6OEuziZuN05INYK27h6L9L9n/edIKWdFegAgigwmCeq8wfGlnqLe6sOPCkuf26jy
	ilb92HUbEOV3DEDBhyvf1zGdD4icxvaOur1eHHyW0SzcfRxjFqBYjwT7aWftgUJjL4ndOmuZjQEw7
	ah4CkTm2pDwVgzl75Lyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whB9B-0000000Fikq-1aua;
	Tue, 07 Jul 2026 19:07:57 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whB8O-0000000Fhk6-2RoO;
	Tue, 07 Jul 2026 19:07:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5455340837;
	Tue,  7 Jul 2026 19:07:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691E61F000E9;
	Tue,  7 Jul 2026 19:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451228;
	bh=k5p+gDeGow5od0W2jgXaapJrAZfwc3i2DfCDO4w4k2U=;
	h=Date:From:To:Cc:Subject:References;
	b=jm9Q3Laf3FKmdLmABRbJipEgYAm2Nvq7OuMFuhObrcMDIik3KnCXo3gPTumzB8Ks6
	 R2Gh5AXPLtOPkX4xGcvEbi6QTXdXx5/QVPzzzZ8xwFmaGErRXW49XMgkYcMa3mHP16
	 NZyJRjBGh1rQKkdpKB/7+FFOPY0JXZbeyKYhfMwGWmdrM9iFLD57NkK4L8nzez26ia
	 lSGhDZsXLIy33FDWV2JaQZRiT6U6B6OVrJAobxJY0jyGqtEYE+4QXvbpOMvRDycErW
	 1QLeEAPw7GwrC8w/3TQxgag4cP6oLp2eSVsbIbk2440lpovAypZ3nvHiufLponi5S1
	 lFKuBs3QiJDKw==
Date: Tue, 07 Jul 2026 21:07:05 +0200
Message-ID: <20260707190254.545214398@kernel.org>
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
Subject: [patch 17/18] x86/entry: Simplify the syscall number logic
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

Converting from int to long, back to int and then to unsigned int is
confusing at best.

None of this voodoo is required. Negative syscall numbers including -1
don't need any of this treatment and the low level ASM code already does
the sign extension to 64-bit on a 64-bit kernel.

The only point where signedness matters is the comparison against the
maximum syscall number, but that can be simplified by just using a unsigned
argument for the various syscall invocation functions.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
 arch/x86/entry/syscall_32.c    |   26 +++++++++++---------------
 arch/x86/entry/syscall_64.c    |   36 ++++++++++++++----------------------
 arch/x86/include/asm/syscall.h |    2 +-
 3 files changed, 26 insertions(+), 38 deletions(-)

--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -41,6 +41,8 @@ const sys_call_ptr_t sys_call_table[] =
 #endif
 
 #define __SYSCALL(nr, sym) case nr: return __ia32_##sym(regs);
+
+/* The unsigned int @nr argument is intentional as it creates denser code in a 64-bit build */
 static noinline long ia32_sys_call(const struct pt_regs *regs, unsigned int nr)
 {
 	switch (nr) {
@@ -49,7 +51,7 @@ static noinline long ia32_sys_call(const
 	}
 }
 
-static __always_inline int syscall_32_enter(struct pt_regs *regs)
+static __always_inline long syscall_32_enter(struct pt_regs *regs)
 {
 	if (IS_ENABLED(CONFIG_IA32_EMULATION))
 		current_thread_info()->status |= TS_COMPAT;
@@ -70,17 +72,11 @@ early_param("ia32_emulation", ia32_emula
 /*
  * Invoke a 32-bit syscall.  Called with IRQs on in CT_STATE_KERNEL.
  */
-static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs, int nr)
+static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs, unsigned long nr)
 {
-	/*
-	 * Convert negative numbers to very high and thus out of range
-	 * numbers for comparisons.
-	 */
-	unsigned int unr = nr;
-
-	if (likely(unr < IA32_NR_syscalls)) {
-		unr = array_index_nospec(unr, IA32_NR_syscalls);
-		regs->ax = ia32_sys_call(regs, unr);
+	if (likely(nr < IA32_NR_syscalls)) {
+		nr = array_index_nospec(nr, IA32_NR_syscalls);
+		regs->ax = ia32_sys_call(regs, (unsigned int)nr);
 	}
 }
 
@@ -126,7 +122,7 @@ static __always_inline bool int80_is_ext
  */
 __visible noinstr void do_int80_emulation(struct pt_regs *regs)
 {
-	int nr;
+	long nr;
 
 	/* Kernel does not use INT $0x80! */
 	if (unlikely(!user_mode(regs))) {
@@ -205,7 +201,7 @@ static __always_inline bool int80_is_ext
  */
 DEFINE_FREDENTRY_RAW(int80_emulation)
 {
-	int nr;
+	long nr;
 
 	enter_from_user_mode_randomize_stack(regs);
 
@@ -240,7 +236,7 @@ DEFINE_FREDENTRY_RAW(int80_emulation)
 /* Handles int $0x80 on a 32bit kernel */
 __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 {
-	int nr = syscall_32_enter(regs);
+	long nr = syscall_32_enter(regs);
 
 	/*
 	 * Subtlety here: if ptrace pokes something larger than 2^31-1 into
@@ -260,7 +256,7 @@ DEFINE_FREDENTRY_RAW(int80_emulation)
 
 static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 {
-	int nr = syscall_32_enter(regs);
+	long nr = syscall_32_enter(regs);
 	int res;
 
 	enter_from_user_mode_randomize_stack(regs);
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -32,6 +32,8 @@ const sys_call_ptr_t sys_call_table[] =
 #undef  __SYSCALL
 
 #define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
+
+/* The unsigned int @nr argument is intentional as it creates denser code */
 static noinline long x64_sys_call(const struct pt_regs *regs, unsigned int nr)
 {
 	switch (nr) {
@@ -52,39 +54,29 @@ static noinline long x32_sys_call(const
 #endif
 }
 
-static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
+static __always_inline bool do_syscall_x64(struct pt_regs *regs, unsigned long nr)
 {
-	/*
-	 * Convert negative numbers to very high and thus out of range
-	 * numbers for comparisons.
-	 */
-	unsigned int unr = nr;
-
-	if (likely(unr < NR_syscalls)) {
-		unr = array_index_nospec(unr, NR_syscalls);
-		regs->ax = x64_sys_call(regs, unr);
+	if (likely(nr < NR_syscalls)) {
+		nr = array_index_nospec(nr, NR_syscalls);
+		regs->ax = x64_sys_call(regs, (unsigned int)nr);
 		return true;
 	}
 	return false;
 }
 
-static __always_inline void do_syscall_x32(struct pt_regs *regs, int nr)
+static __always_inline void do_syscall_x32(struct pt_regs *regs, unsigned long nr)
 {
-	/*
-	 * Adjust the starting offset of the table, and convert numbers
-	 * < __X32_SYSCALL_BIT to very high and thus out of range
-	 * numbers for comparisons.
-	 */
-	unsigned int xnr = nr - __X32_SYSCALL_BIT;
-
-	if (IS_ENABLED(CONFIG_X86_X32_ABI) && likely(xnr < X32_NR_syscalls)) {
-		xnr = array_index_nospec(xnr, X32_NR_syscalls);
-		regs->ax = x32_sys_call(regs, xnr);
+	/* Adjust the starting offset of the table */
+	nr -= __X32_SYSCALL_BIT;
+
+	if (IS_ENABLED(CONFIG_X86_X32_ABI) && likely(nr < X32_NR_syscalls)) {
+		nr = array_index_nospec(nr, X32_NR_syscalls);
+		regs->ax = x32_sys_call(regs, (unsigned int)nr);
 	}
 }
 
 /* Returns true to return using SYSRET, or false to use IRET */
-__visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
+__visible noinstr bool do_syscall_64(struct pt_regs *regs, long nr)
 {
 	nr = syscall_enter_from_user_mode_randomize_stack(regs, nr);
 
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -164,7 +164,7 @@ static inline int syscall_get_arch(struc
 		? AUDIT_ARCH_I386 : AUDIT_ARCH_X86_64;
 }
 
-bool do_syscall_64(struct pt_regs *regs, int nr);
+bool do_syscall_64(struct pt_regs *regs, long nr);
 void do_int80_emulation(struct pt_regs *regs);
 
 #endif	/* CONFIG_X86_32 */


