Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FDECD5BB0
	for <linux-um@archiver.kernel.org>; Fri, 22 May 2026 14:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5LHCEytlni2fA4ULXc5o7hIbHEl7DfX9pkgOfNSW8lw=; b=1e5wQlJbpTMX5/ZtWZFlRCKMTK
	eHsIxqvxv3MF0hN9jJhRkKKQ+s0Ye4r6pyw+Jp2AwiN1Dq2ByFjxHO5v2g5XVGGieHirYFEuyFXvH
	kzCMgFBKb9ET+tt32Bt+0uytMSX10ntqjN6LXoOE7EpJ3aEbKa9TMB4WDp9yqN3W8zdHAoAEwXgPZ
	7RNn0lIdPt5SCwY903Kp2LVcNs7ULHjDBKFUl3WIWijqAMAdoVTPGHrYre13rUus1ZxyG3FAYOzz0
	cFXJKCxn1FknuCG/dgD1lLb0ZHY9cRhJDQ7YD2JuRikWkvxq+WsX5wbA/+1wlKcvRB6oxhQv11YGd
	LDUbnNNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQQk1-0000000B74X-1RGF;
	Fri, 22 May 2026 14:20:45 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQQjz-0000000B73Q-059x
	for linux-um@lists.infradead.org;
	Fri, 22 May 2026 14:20:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B606F43776;
	Fri, 22 May 2026 14:20:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5033D1F00ADE;
	Fri, 22 May 2026 14:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779459642;
	bh=5LHCEytlni2fA4ULXc5o7hIbHEl7DfX9pkgOfNSW8lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z+jXO3fEG9v+jK/yfPyjHtkgUE6ypGpfnHIziKuOj9b61wQQwvMBmhVKyrfurN/ao
	 gDz4qBDNi11sn/cb9mLP+c7BrWOrSS0u5W0lOvjpl62Gei8LDunJNEqKLiwtjMDT4G
	 /LgqrCTV64Jmo8oWeNR4IYBcrf43QKOlgCrQO/z232NKjdhWOehJg2bqTfCwSpSdWP
	 oTdMHWIwYmRGOtFn66Ly1Uor1kYT9IVvpsY6RXqnHTiduxnChN9yiq2hROuTOjIzWj
	 Ev2JC0g/2xduiGU66epER0QCNxBtoPFhSSAT5TlkyrkVTRifeUUrKVcyJRIxFBv9Rd
	 S9iX5mwshsRrQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH 4/8] x86: make CX8 usage unconditional
Date: Fri, 22 May 2026 16:19:55 +0200
Message-Id: <20260522141959.1071595-5-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260522141959.1071595-1-arnd@kernel.org>
References: <20260522141959.1071595-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_072043_109618_B677FBEA 
X-CRM114-Status: GOOD (  18.01  )
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

From: Arnd Bergmann <arnd@arndb.de>

All supported CPUs now provide the cmpxchg8b instruction, so remove
all compile-time and runtime checks for its presence and the fallback
implementation, to assume it just works.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/um/include/asm/asm-prototypes.h  |   4 -
 arch/x86/Kconfig.cpu                  |   4 -
 arch/x86/Kconfig.cpufeatures          |   7 +-
 arch/x86/include/asm/asm-prototypes.h |   4 -
 arch/x86/include/asm/atomic64_32.h    |  15 --
 arch/x86/include/asm/cmpxchg_32.h     |  76 +---------
 arch/x86/include/asm/percpu.h         |  14 +-
 arch/x86/lib/Makefile                 |   4 -
 arch/x86/lib/atomic64_386_32.S        | 195 --------------------------
 arch/x86/lib/cmpxchg8b_emu.S          |  97 -------------
 arch/x86/um/Kconfig                   |   2 +-
 arch/x86/um/Makefile                  |   3 +-
 lib/atomic64_test.c                   |   7 +-
 13 files changed, 13 insertions(+), 419 deletions(-)
 delete mode 100644 arch/x86/lib/atomic64_386_32.S
 delete mode 100644 arch/x86/lib/cmpxchg8b_emu.S

diff --git a/arch/um/include/asm/asm-prototypes.h b/arch/um/include/asm/asm-prototypes.h
index 408b31d59127..b446eec98ed8 100644
--- a/arch/um/include/asm/asm-prototypes.h
+++ b/arch/um/include/asm/asm-prototypes.h
@@ -1,6 +1,2 @@
 #include <asm-generic/asm-prototypes.h>
 #include <asm/checksum.h>
-
-#ifdef CONFIG_UML_X86
-extern void cmpxchg8b_emu(void);
-#endif
diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index fe0246477345..65d887274dd8 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -266,10 +266,6 @@ config X86_HAVE_PAE
 	def_bool y
 	depends on MCRUSOE || MEFFICEON || MCYRIXIII || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC7 || MATOM || X86_64
 
-config X86_CX8
-	def_bool y
-	depends on X86_HAVE_PAE || M586TSC || M586MMX || MK6 || MK7 || MGEODEGX1 || MGEODE_LX
-
 # this should be set for all -march=.. options where the compiler
 # generates cmov.
 config X86_CMOV
diff --git a/arch/x86/Kconfig.cpufeatures b/arch/x86/Kconfig.cpufeatures
index 89cbf8f572ae..e0f2ff65377d 100644
--- a/arch/x86/Kconfig.cpufeatures
+++ b/arch/x86/Kconfig.cpufeatures
@@ -40,10 +40,6 @@ config X86_REQUIRED_FEATURE_NOPL
 	def_bool y
 	depends on X86_64
 
-config X86_REQUIRED_FEATURE_CX8
-	def_bool y
-	depends on X86_CX8
-
 # this should be set for all -march=.. options where the compiler
 # generates cmov.
 config X86_REQUIRED_FEATURE_CMOV
@@ -60,6 +56,9 @@ config X86_REQUIRED_FEATURE_SYSFAST32
 	def_bool y
 	depends on X86_64 && !X86_FRED
 
+config X86_REQUIRED_FEATURE_CX8
+	def_bool y
+
 config X86_REQUIRED_FEATURE_CPUID
 	def_bool y
 	depends on X86_64
diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index 11c6fecc3ad7..6ec680a36dea 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -16,10 +16,6 @@
 #include <asm/gsseg.h>
 #include <asm/nospec-branch.h>
 
-#ifndef CONFIG_X86_CX8
-extern void cmpxchg8b_emu(void);
-#endif
-
 #ifdef CONFIG_STACKPROTECTOR
 extern unsigned long __ref_stack_chk_guard;
 #endif
diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index ab838205c1c6..e3da5d0094c4 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -48,7 +48,6 @@ static __always_inline s64 arch_atomic64_read_nonatomic(const atomic64_t *v)
 	ATOMIC64_EXPORT(atomic64_##sym)
 #endif
 
-#ifdef CONFIG_X86_CX8
 #define __alternative_atomic64(f, g, out, in, clobbers...)		\
 	asm volatile("call %c[func]"					\
 		     : ALT_OUTPUT_SP(out) \
@@ -57,20 +56,6 @@ static __always_inline s64 arch_atomic64_read_nonatomic(const atomic64_t *v)
 		     : clobbers)
 
 #define ATOMIC64_DECL(sym) ATOMIC64_DECL_ONE(sym##_cx8)
-#else
-#define __alternative_atomic64(f, g, out, in, clobbers...)		\
-	alternative_call(atomic64_##f##_386, atomic64_##g##_cx8,	\
-			 X86_FEATURE_CX8, ASM_OUTPUT(out),		\
-			 ASM_INPUT(in), clobbers)
-
-#define ATOMIC64_DECL(sym) ATOMIC64_DECL_ONE(sym##_cx8); \
-	ATOMIC64_DECL_ONE(sym##_386)
-
-ATOMIC64_DECL_ONE(add_386);
-ATOMIC64_DECL_ONE(sub_386);
-ATOMIC64_DECL_ONE(inc_386);
-ATOMIC64_DECL_ONE(dec_386);
-#endif
 
 #define alternative_atomic64(f, out, in, clobbers...) \
 	__alternative_atomic64(f, f, ASM_OUTPUT(out), ASM_INPUT(in), clobbers)
diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index 1f80a62be969..1019c4bce620 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -68,8 +68,6 @@ static __always_inline bool __try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp,
 	return __arch_try_cmpxchg64(ptr, oldp, new,);
 }
 
-#ifdef CONFIG_X86_CX8
-
 #define arch_cmpxchg64 __cmpxchg64
 
 #define arch_cmpxchg64_local __cmpxchg64_local
@@ -78,78 +76,6 @@ static __always_inline bool __try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp,
 
 #define arch_try_cmpxchg64_local __try_cmpxchg64_local
 
-#else
-
-/*
- * Building a kernel capable running on 80386 and 80486. It may be necessary
- * to simulate the cmpxchg8b on the 80386 and 80486 CPU.
- */
-
-#define __arch_cmpxchg64_emu(_ptr, _old, _new, _lock_loc, _lock)	\
-({									\
-	union __u64_halves o = { .full = (_old), },			\
-			   n = { .full = (_new), };			\
-									\
-	asm_inline volatile(						\
-		ALTERNATIVE(_lock_loc					\
-			    "call cmpxchg8b_emu",			\
-			    _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8)	\
-		: ALT_OUTPUT_SP("+a" (o.low), "+d" (o.high))		\
-		: "b" (n.low), "c" (n.high),				\
-		  [ptr] "S" (_ptr)					\
-		: "memory");						\
-									\
-	o.full;								\
-})
-
-static __always_inline u64 arch_cmpxchg64(volatile u64 *ptr, u64 old, u64 new)
-{
-	return __arch_cmpxchg64_emu(ptr, old, new, LOCK_PREFIX_HERE, "lock ");
-}
-#define arch_cmpxchg64 arch_cmpxchg64
-
-static __always_inline u64 arch_cmpxchg64_local(volatile u64 *ptr, u64 old, u64 new)
-{
-	return __arch_cmpxchg64_emu(ptr, old, new, ,);
-}
-#define arch_cmpxchg64_local arch_cmpxchg64_local
-
-#define __arch_try_cmpxchg64_emu(_ptr, _oldp, _new, _lock_loc, _lock)	\
-({									\
-	union __u64_halves o = { .full = *(_oldp), },			\
-			   n = { .full = (_new), };			\
-	bool ret;							\
-									\
-	asm_inline volatile(						\
-		ALTERNATIVE(_lock_loc					\
-			    "call cmpxchg8b_emu",			\
-			    _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8) \
-		: ALT_OUTPUT_SP("=@ccz" (ret),				\
-				"+a" (o.low), "+d" (o.high))		\
-		: "b" (n.low), "c" (n.high),				\
-		  [ptr] "S" (_ptr)					\
-		: "memory");						\
-									\
-	if (unlikely(!ret))						\
-		*(_oldp) = o.full;					\
-									\
-	likely(ret);							\
-})
-
-static __always_inline bool arch_try_cmpxchg64(volatile u64 *ptr, u64 *oldp, u64 new)
-{
-	return __arch_try_cmpxchg64_emu(ptr, oldp, new, LOCK_PREFIX_HERE, "lock ");
-}
-#define arch_try_cmpxchg64 arch_try_cmpxchg64
-
-static __always_inline bool arch_try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp, u64 new)
-{
-	return __arch_try_cmpxchg64_emu(ptr, oldp, new, ,);
-}
-#define arch_try_cmpxchg64_local arch_try_cmpxchg64_local
-
-#endif
-
-#define system_has_cmpxchg64()		boot_cpu_has(X86_FEATURE_CX8)
+#define system_has_cmpxchg64()		true
 
 #endif /* _ASM_X86_CMPXCHG_32_H */
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 409981468cba..6f45358cb091 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -335,11 +335,9 @@ do {									\
 	old__.var = _oval;						\
 	new__.var = _nval;						\
 									\
-	asm_inline qual (						\
-		ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
-			    "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
-		: ALT_OUTPUT_SP([var] "+m" (__my_cpu_var(_var)),	\
-				"+a" (old__.low), "+d" (old__.high))	\
+	asm_inline qual ("cmpxchg8b " __percpu_arg([var])		\
+		: [var] "+m" (__my_cpu_var(_var)),			\
+				"+a" (old__.low), "+d" (old__.high)	\
 		: "b" (new__.low), "c" (new__.high),			\
 		  "S" (&(_var))						\
 		: "memory");						\
@@ -364,10 +362,8 @@ do {									\
 	old__.var = *_oval;						\
 	new__.var = _nval;						\
 									\
-	asm_inline qual (						\
-		ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
-			    "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
-		: ALT_OUTPUT_SP("=@ccz" (success),			\
+	asm_inline qual ("cmpxchg8b " __percpu_arg([var])		\
+		: "=@ccz" (success),					\
 				[var] "+m" (__my_cpu_var(_var)),	\
 				"+a" (old__.low), "+d" (old__.high))	\
 		: "b" (new__.low), "c" (new__.high),			\
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 2dba7f83ef97..210af275f468 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -48,10 +48,6 @@ ifeq ($(CONFIG_X86_32),y)
         lib-y += strstr_32.o
         lib-y += string_32.o
         lib-y += memmove_32.o
-        lib-y += cmpxchg8b_emu.o
-ifneq ($(CONFIG_X86_CX8),y)
-        lib-y += atomic64_386_32.o
-endif
 else
 ifneq ($(CONFIG_GENERIC_CSUM),y)
         lib-y += csum-partial_64.o csum-copy_64.o csum-wrappers_64.o
diff --git a/arch/x86/lib/atomic64_386_32.S b/arch/x86/lib/atomic64_386_32.S
deleted file mode 100644
index e768815e58ae..000000000000
--- a/arch/x86/lib/atomic64_386_32.S
+++ /dev/null
@@ -1,195 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * atomic64_t for 386/486
- *
- * Copyright © 2010  Luca Barbieri
- */
-
-#include <linux/linkage.h>
-#include <asm/alternative.h>
-
-/* if you want SMP support, implement these with real spinlocks */
-.macro IRQ_SAVE reg
-	pushfl
-	cli
-.endm
-
-.macro IRQ_RESTORE reg
-	popfl
-.endm
-
-#define BEGIN_IRQ_SAVE(op) \
-.macro endp; \
-SYM_FUNC_END(atomic64_##op##_386); \
-.purgem endp; \
-.endm; \
-SYM_FUNC_START(atomic64_##op##_386); \
-	IRQ_SAVE v;
-
-#define ENDP endp
-
-#define RET_IRQ_RESTORE \
-	IRQ_RESTORE v; \
-	RET
-
-#define v %ecx
-BEGIN_IRQ_SAVE(read)
-	movl  (v), %eax
-	movl 4(v), %edx
-	RET_IRQ_RESTORE
-ENDP
-#undef v
-
-#define v %esi
-BEGIN_IRQ_SAVE(set)
-	movl %ebx,  (v)
-	movl %ecx, 4(v)
-	RET_IRQ_RESTORE
-ENDP
-#undef v
-
-#define v  %esi
-BEGIN_IRQ_SAVE(xchg)
-	movl  (v), %eax
-	movl 4(v), %edx
-	movl %ebx,  (v)
-	movl %ecx, 4(v)
-	RET_IRQ_RESTORE
-ENDP
-#undef v
-
-#define v %ecx
-BEGIN_IRQ_SAVE(add)
-	addl %eax,  (v)
-	adcl %edx, 4(v)
-	RET_IRQ_RESTORE
-ENDP
-#undef v
-
-#define v %ecx
-BEGIN_IRQ_SAVE(add_return)
-	addl  (v), %eax
-	adcl 4(v), %edx
-	movl %eax,  (v)
-	movl %edx, 4(v)
-	RET_IRQ_RESTORE
-ENDP
-#undef v
-
-#define v %ecx
-BEGIN_IRQ_SAVE(sub)
-	subl %eax,  (v)
-	sbbl %edx, 4(v)
-	RET_IRQ_RESTORE
-ENDP
-#undef v
-
-#define v %ecx
-BEGIN_IRQ_SAVE(sub_return)
-	negl %edx
-	negl %eax
-	sbbl $0, %edx
-	addl  (v), %eax
-	adcl 4(v), %edx
-	movl %eax,  (v)
-	movl %edx, 4(v)
-	RET_IRQ_RESTORE
-ENDP
-#undef v
-
-#define v %esi
-BEGIN_IRQ_SAVE(inc)
-	addl $1,  (v)
-	adcl $0, 4(v)
-	RET_IRQ_RESTORE
-ENDP
-#undef v
-
-#define v %esi
-BEGIN_IRQ_SAVE(inc_return)
-	movl  (v), %eax
-	movl 4(v), %edx
-	addl $1, %eax
-	adcl $0, %edx
-	movl %eax,  (v)
-	movl %edx, 4(v)
-	RET_IRQ_RESTORE
-ENDP
-#undef v
-
-#define v %esi
-BEGIN_IRQ_SAVE(dec)
-	subl $1,  (v)
-	sbbl $0, 4(v)
-	RET_IRQ_RESTORE
-ENDP
-#undef v
-
-#define v %esi
-BEGIN_IRQ_SAVE(dec_return)
-	movl  (v), %eax
-	movl 4(v), %edx
-	subl $1, %eax
-	sbbl $0, %edx
-	movl %eax,  (v)
-	movl %edx, 4(v)
-	RET_IRQ_RESTORE
-ENDP
-#undef v
-
-#define v %esi
-BEGIN_IRQ_SAVE(add_unless)
-	addl %eax, %ecx
-	adcl %edx, %edi
-	addl  (v), %eax
-	adcl 4(v), %edx
-	cmpl %eax, %ecx
-	je 3f
-1:
-	movl %eax,  (v)
-	movl %edx, 4(v)
-	movl $1, %eax
-2:
-	RET_IRQ_RESTORE
-3:
-	cmpl %edx, %edi
-	jne 1b
-	xorl %eax, %eax
-	jmp 2b
-ENDP
-#undef v
-
-#define v %esi
-BEGIN_IRQ_SAVE(inc_not_zero)
-	movl  (v), %eax
-	movl 4(v), %edx
-	testl %eax, %eax
-	je 3f
-1:
-	addl $1, %eax
-	adcl $0, %edx
-	movl %eax,  (v)
-	movl %edx, 4(v)
-	movl $1, %eax
-2:
-	RET_IRQ_RESTORE
-3:
-	testl %edx, %edx
-	jne 1b
-	jmp 2b
-ENDP
-#undef v
-
-#define v %esi
-BEGIN_IRQ_SAVE(dec_if_positive)
-	movl  (v), %eax
-	movl 4(v), %edx
-	subl $1, %eax
-	sbbl $0, %edx
-	js 1f
-	movl %eax,  (v)
-	movl %edx, 4(v)
-1:
-	RET_IRQ_RESTORE
-ENDP
-#undef v
diff --git a/arch/x86/lib/cmpxchg8b_emu.S b/arch/x86/lib/cmpxchg8b_emu.S
deleted file mode 100644
index d4bb24347ff8..000000000000
--- a/arch/x86/lib/cmpxchg8b_emu.S
+++ /dev/null
@@ -1,97 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-
-#include <linux/export.h>
-#include <linux/linkage.h>
-#include <asm/percpu.h>
-#include <asm/processor-flags.h>
-
-.text
-
-#ifndef CONFIG_X86_CX8
-
-/*
- * Emulate 'cmpxchg8b (%esi)' on UP
- *
- * Inputs:
- * %esi : memory location to compare
- * %eax : low 32 bits of old value
- * %edx : high 32 bits of old value
- * %ebx : low 32 bits of new value
- * %ecx : high 32 bits of new value
- */
-SYM_FUNC_START(cmpxchg8b_emu)
-
-	pushfl
-	cli
-
-	cmpl	(%esi), %eax
-	jne	.Lnot_same
-	cmpl	4(%esi), %edx
-	jne	.Lnot_same
-
-	movl	%ebx, (%esi)
-	movl	%ecx, 4(%esi)
-
-	orl	$X86_EFLAGS_ZF, (%esp)
-
-	popfl
-	RET
-
-.Lnot_same:
-	movl	(%esi), %eax
-	movl	4(%esi), %edx
-
-	andl	$(~X86_EFLAGS_ZF), (%esp)
-
-	popfl
-	RET
-
-SYM_FUNC_END(cmpxchg8b_emu)
-EXPORT_SYMBOL(cmpxchg8b_emu)
-
-#endif
-
-#ifndef CONFIG_UML
-
-/*
- * Emulate 'cmpxchg8b %fs:(%rsi)'
- *
- * Inputs:
- * %esi : memory location to compare
- * %eax : low 32 bits of old value
- * %edx : high 32 bits of old value
- * %ebx : low 32 bits of new value
- * %ecx : high 32 bits of new value
- *
- * Notably this is not LOCK prefixed and is not safe against NMIs
- */
-SYM_FUNC_START(this_cpu_cmpxchg8b_emu)
-
-	pushfl
-	cli
-
-	cmpl	__percpu (%esi), %eax
-	jne	.Lnot_same2
-	cmpl	__percpu 4(%esi), %edx
-	jne	.Lnot_same2
-
-	movl	%ebx, __percpu (%esi)
-	movl	%ecx, __percpu 4(%esi)
-
-	orl	$X86_EFLAGS_ZF, (%esp)
-
-	popfl
-	RET
-
-.Lnot_same2:
-	movl	__percpu (%esi), %eax
-	movl	__percpu 4(%esi), %edx
-
-	andl	$(~X86_EFLAGS_ZF), (%esp)
-
-	popfl
-	RET
-
-SYM_FUNC_END(this_cpu_cmpxchg8b_emu)
-
-#endif
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index 44b12e45f9a0..5b78440a78b9 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -13,7 +13,7 @@ config UML_X86
 	select ARCH_USE_QUEUED_SPINLOCKS
 	select DCACHE_WORD_ACCESS
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
-	select UML_SUBARCH_SUPPORTS_SMP if X86_CX8
+	select UML_SUBARCH_SUPPORTS_SMP
 
 config 64BIT
 	bool "64-bit kernel" if "$(SUBARCH)" = "x86"
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index f9ea75bf43ac..b89936fe503a 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -19,8 +19,7 @@ ifeq ($(CONFIG_X86_32),y)
 
 obj-y += syscalls_32.o
 
-subarch-y = ../lib/string_32.o ../lib/atomic64_32.o ../lib/atomic64_cx8_32.o
-subarch-y += ../lib/cmpxchg8b_emu.o ../lib/atomic64_386_32.o
+subarch-y = ../lib/string_32.o ../lib/atomic64_32.o
 subarch-y += ../lib/checksum_32.o
 subarch-y += ../kernel/sys_ia32.o
 
diff --git a/lib/atomic64_test.c b/lib/atomic64_test.c
index d726068358c7..37af41df3e6a 100644
--- a/lib/atomic64_test.c
+++ b/lib/atomic64_test.c
@@ -251,15 +251,12 @@ static __init int test_atomics_init(void)
 	test_atomic64();
 
 #ifdef CONFIG_X86
-	pr_info("passed for %s platform %s CX8 and %s SSE\n",
+	pr_info("passed for %s platform %s SSE\n",
 #ifdef CONFIG_X86_64
 		"x86-64",
-#elif defined(CONFIG_X86_CX8)
-		"i586+",
 #else
-		"i386+",
+		"i586+",
 #endif
-	       boot_cpu_has(X86_FEATURE_CX8) ? "with" : "without",
 	       boot_cpu_has(X86_FEATURE_XMM) ? "with" : "without");
 #else
 	pr_info("passed\n");
-- 
2.39.5


