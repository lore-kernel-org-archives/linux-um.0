Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B3E60726F3
	for <linux-um@archiver.kernel.org>; Thu,  5 Nov 2026 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=We+X03a8;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D6XAX9GF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=fxA0QOOVlVk/C5WqVFf6Fc/JZ/oAJEGHusCPXQ6ePVY=; b=We+X03a8AH5r8B
	UV6ivh5IlePw2CNaQMqQTzAuR3CM1aiELtYooD6qPn93OgvgtxJtgcdtuwAPvnFGKAVnUsmprtOCe
	SwU2MgYxuIP+20V6H6yWji6zhssc88Ygs0+i4+z4caGOQ11rOD81ANafgFTduV/WGUCHpQieQZyk7
	VzlTeTPmcaLayxGWSeOAhjM2iNCBzr29LLw7gNpvHs3t1wCOI8Sg4y0cWPslLqA3hPLAGrAiImm3N
	FQf2a2DGC5O5HM5BwJpEYbmWwr8OtoEyqNW0lLwKa2K7e51jmvC/wh5A78dv3fFIWzCxItbiOfN4D
	wnlBoE2FIkl3Bz+AMjOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP0Ql-00000009eaL-1KDe;
	Thu, 05 Nov 2026 16:35:15 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP0Qb-00000009eXN-3aFn
	for linux-um@lists.infradead.org;
	Thu, 05 Nov 2026 16:35:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 969FF43DFA;
	Thu,  5 Nov 2026 16:35:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334A21F000C1;
	Thu,  5 Nov 2026 16:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793896505;
	bh=fxA0QOOVlVk/C5WqVFf6Fc/JZ/oAJEGHusCPXQ6ePVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D6XAX9GFvefOrBa0R+l2TyrStIIuVduIXsRPYLV3/C2dAnUQ/pEepaCDAV6794zuU
	 hN28rmpBJiA3orhhXuOCXjoX/4fAHakJHszFVDCMp1+E/LtPcA8O1/xYHXsJqKPNPC
	 0yRoMKJvsSzbtsgqstSTzjpSl55hoRE2PeqIwsOi+3HHjWM5EhaJfsOY+27/sRI0PO
	 TyVJ8ETn1C14jo9EnKU97uP33sDiDuS6yK7D/khp6oObLb8gJd/5+RrHZZZ8NPHGGL
	 P8Ex83SM+jyqkqXYouef7g3ByfXxHGSxbhFWkOoOGsljgZtwr++UW7uhBRr3IxqCqT
	 iPj8V19W5VoWw==
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
Subject: [PATCH 3/7] x86: make CX8 usage unconditional
Date: Thu,  5 Nov 2026 17:34:34 +0100
Message-ID: <20261105163440.2381661-4-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105163440.2381661-1-arnd@kernel.org>
References: <20261105163440.2381661-1-arnd@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arnd Bergmann <arnd@arndb.de>

All supported CPUs now provide the cmpxchg8b instruction, so remove
all compile-time and runtime checks for its presence and the fallback
implementation, to assume it just works.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/um/include/asm/asm-prototypes.h  |   4 -
 arch/x86/Kconfig.cpu                  |   3 -
 arch/x86/Kconfig.cpufeatures          |   6 +-
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
 13 files changed, 13 insertions(+), 417 deletions(-)
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
index f2c1f544f5f9..832e4bd9f6e0 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -274,9 +274,6 @@ config X86_HAVE_PAE
 	def_bool y
 	depends on MCRUSOE || MEFFICEON || MCYRIXIII || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC7 || MATOM || X86_64
 
-config X86_CX8
-	def_bool y
-
 # this should be set for all -march=.. options where the compiler
 # generates cmov.
 config X86_CMOV
diff --git a/arch/x86/Kconfig.cpufeatures b/arch/x86/Kconfig.cpufeatures
index 09833c88f9ff..e0f2ff65377d 100644
--- a/arch/x86/Kconfig.cpufeatures
+++ b/arch/x86/Kconfig.cpufeatures
@@ -40,9 +40,6 @@ config X86_REQUIRED_FEATURE_NOPL
 	def_bool y
 	depends on X86_64
 
-config X86_REQUIRED_FEATURE_CX8
-	def_bool y
-
 # this should be set for all -march=.. options where the compiler
 # generates cmov.
 config X86_REQUIRED_FEATURE_CMOV
@@ -59,6 +56,9 @@ config X86_REQUIRED_FEATURE_SYSFAST32
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
index e85c221ed1c9..1019c4bce620 100644
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
-	return __arch_cmpxchg64_emu(ptr, old, new, , "lock ");
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
-	return __arch_try_cmpxchg64_emu(ptr, oldp, new, , "lock ");
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
index cef9a4ca9841..539abf94828d 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -330,11 +330,9 @@ do {									\
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
@@ -359,10 +357,8 @@ do {									\
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
index 100b68f601f9..716da7b1e3e9 100644
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
2.53.0


