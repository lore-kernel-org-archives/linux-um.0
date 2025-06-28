Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596C3C77B7F
	for <linux-um@archiver.kernel.org>; Sat, 28 Jun 2025 11:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1Y0qjLu4ESsXOC1mIMGmrpenXtMUUzktqWjzTMVxwvs=; b=2XZOjoRzJ5Tc40kxKrtIvxB6B3
	QGP+w0oaRNEBA6xv8D1V4RKVc2P11e6nHGNJ3wxoFV3girLg5g16FZgh525Y6vC2dgzBgbROheHtc
	L+/U7ZlPRvARQopLYoPYDb9LgqEddzr30BcIDRoaAm+FdEQ1SEEdVM+XKc/Wf57bELiJxp+Gr/kmm
	TSuFDR5dg4TxO7bYnpsRGrv4WQKbjvaD5O8n9Bf1R2HR5Io+cIV6Mio1DJfIVPJ/kkcS3Uv8l6Avn
	5eJwfGiJbsPac389NN5SVp95d2U/nIJo6QpZQIth77ssXGgGVYf38WdhjOqT1c1CEgg+zLnVrz4FX
	jzMq783g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVU4w-0000000GkB9-30UN;
	Sat, 28 Jun 2025 11:50:42 +0000
Received: from pegase1.c-s.fr ([93.17.236.30])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVU4s-0000000Gk9n-1twf;
	Sat, 28 Jun 2025 11:50:40 +0000
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bTqrJ288Cz9vJx;
	Sat, 28 Jun 2025 13:26:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pfMuphSsT2Ir; Sat, 28 Jun 2025 13:26:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bTqrH3wCPz9vJs;
	Sat, 28 Jun 2025 13:26:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 78EDB8B765;
	Sat, 28 Jun 2025 13:26:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id SOtpdDiBEncU; Sat, 28 Jun 2025 13:26:39 +0200 (CEST)
Received: from [192.168.202.221] (unknown [192.168.202.221])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 93EA18B763;
	Sat, 28 Jun 2025 13:26:35 +0200 (CEST)
Message-ID: <ffae82a6-26dd-4c25-80d3-dbb55c889b52@csgroup.eu>
Date: Sat, 28 Jun 2025 13:26:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] kasan: unify kasan_arch_is_ready with
 kasan_enabled
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, ryabinin.a.a@gmail.com,
 glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
 vincenzo.frascino@arm.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
 will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, richard@nod.at,
 anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
 akpm@linux-foundation.org, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com
Cc: arnd@arndb.de, rppt@kernel.org, geert@linux-m68k.org, mcgrof@kernel.org,
 guoweikang.kernel@gmail.com, tiwei.btw@antgroup.com, kevin.brodsky@arm.com,
 benjamin.berg@intel.com, kasan-dev@googlegroups.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-um@lists.infradead.org, linux-mm@kvack.org, llvm@lists.linux.dev
References: <20250626153147.145312-1-snovitoll@gmail.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250626153147.145312-1-snovitoll@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250628_045038_811324_AE877C89 
X-CRM114-Status: GOOD (  31.83  )
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



Le 26/06/2025 à 17:31, Sabyrzhan Tasbolatov a écrit :
> This patch series unifies the kasan_arch_is_ready() and kasan_enabled()
> interfaces by extending the existing kasan_enabled() infrastructure to
> work consistently across all KASAN modes (Generic, SW_TAGS, HW_TAGS).
> 
> Currently, kasan_enabled() only works for HW_TAGS mode using a static key,
> while other modes either return IS_ENABLED(CONFIG_KASAN) (compile-time
> constant) or rely on architecture-specific kasan_arch_is_ready()
> implementations with custom static keys and global variables.
> 
> This leads to:
> - Code duplication across architectures
> - Inconsistent runtime behavior between KASAN modes
> - Architecture-specific readiness tracking

You should also consider refactoring ARCH_DISABLE_KASAN_INLINE, there is 
a high dependency between deferring KASAN readiness and not supporting 
inline KASAN.

> 
> After this series:
> - All KASAN modes use the same kasan_flag_enabled static key
> - Consistent runtime enable/disable behavior across modes
> - Simplified architecture code with unified kasan_init_generic() calls
> - Elimination of arch specific kasan_arch_is_ready() implementations
> - Unified vmalloc integration using kasan_enabled() checks

I dislike that modes which can be enabled from the very begining now 
also depends on the static key being enabled later.

The size is increased for no valid reason:

$ size vmlinux.kasan*
    text	   data	    bss	    dec	    hex	filename
13965336	6716942	 494912	21177190	1432366	vmlinux.kasan0 ==> outline 
KASAN before your patch
13965496	6718422	 494944	21178862	14329ee	vmlinux.kasan1 ==> outline 
KASAN after your patch
13965336	6716942	 494912	21177190	1432366	vmlinux.kasan2 ==> outline 
KASAN after your patch + below change
32517472	6716958	 494912	39729342	25e38be	vmlinux.kasani0 ==> inline 
KASAN before your patch
32518848	6718438	 494944	39732230	25e4406	vmlinux.kasani1 ==> inline 
KASAN after your patch
32517536	6716958	 494912	39729406	25e38fe	vmlinux.kasani2 ==> inline 
KASAN after your patch + below change

Below change (atop you series) only makes use of static key when needed:

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c3e0cc83f120..7a8e5db603cc 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -122,6 +122,7 @@ config PPC
  	# Please keep this list sorted alphabetically.
  	#
  	select ARCH_32BIT_OFF_T if PPC32
+	select ARCH_DEFER_KASAN			if PPC_RADIX_MMU
  	select ARCH_DISABLE_KASAN_INLINE	if PPC_RADIX_MMU
  	select ARCH_DMA_DEFAULT_COHERENT	if !NOT_COHERENT_CACHE
  	select ARCH_ENABLE_MEMORY_HOTPLUG
@@ -219,7 +220,7 @@ config PPC
  	select HAVE_ARCH_JUMP_LABEL
  	select HAVE_ARCH_JUMP_LABEL_RELATIVE
  	select HAVE_ARCH_KASAN			if PPC32 && PAGE_SHIFT <= 14
-	select HAVE_ARCH_KASAN			if PPC_RADIX_MMU
+	select HAVE_ARCH_KASAN_DEFERED		if PPC_RADIX_MMU
  	select HAVE_ARCH_KASAN			if PPC_BOOK3E_64
  	select HAVE_ARCH_KASAN_VMALLOC		if HAVE_ARCH_KASAN
  	select HAVE_ARCH_KCSAN
diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
index 2436eb45cfee..fda86e77fe4f 100644
--- a/include/linux/kasan-enabled.h
+++ b/include/linux/kasan-enabled.h
@@ -4,7 +4,7 @@

  #include <linux/static_key.h>

-#ifdef CONFIG_KASAN
+#ifdef CONFIG_KASAN_DEFER

  /*
   * Global runtime flag. Starts âfalseâ; switched to âtrueâ by
@@ -17,13 +17,21 @@ static __always_inline bool kasan_enabled(void)
  	return static_branch_likely(&kasan_flag_enabled);
  }

-#else /* !CONFIG_KASAN */
+static inline void kasan_enable(void)
+{
+	static_branch_enable(&kasan_flag_enabled);
+}
+
+#else /* !CONFIG_KASAN_DEFER */

  static __always_inline bool kasan_enabled(void)
  {
-	return false;
+	return IS_ENABLED(CONFIG_KASAN);
  }

+static inline void kasan_enable(void)
+{
+}
  #endif /* CONFIG_KASAN */

  #ifdef CONFIG_KASAN_HW_TAGS
diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index f82889a830fa..e0c300f55c07 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -13,6 +13,9 @@ config HAVE_ARCH_KASAN_HW_TAGS
  config HAVE_ARCH_KASAN_VMALLOC
  	bool

+config ARCH_DEFER_KASAN
+	bool
+
  config ARCH_DISABLE_KASAN_INLINE
  	bool
  	help
@@ -58,6 +61,9 @@ config CC_HAS_KASAN_MEMINTRINSIC_PREFIX
  	help
  	  The compiler is able to prefix memintrinsics with __asan or __hwasan.

+config KASAN_DIFER
+	def_bool ARCH_DIFER_KASAN
+
  choice
  	prompt "KASAN mode"
  	default KASAN_GENERIC
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 0f3648335a6b..01f56eed9d20 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -36,8 +36,10 @@
   * Definition of the unified static key declared in kasan-enabled.h.
   * This provides consistent runtime enable/disable across all KASAN modes.
   */
+#ifdef CONFIG_KASAN_DEFER
  DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
  EXPORT_SYMBOL(kasan_flag_enabled);
+#endif

  struct slab *kasan_addr_to_slab(const void *addr)
  {
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index a3b112868be7..516b49accc4f 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -42,7 +42,7 @@
   */
  void __init kasan_init_generic(void)
  {
-	static_branch_enable(&kasan_flag_enabled);
+	kasan_enable();

  	pr_info("KernelAddressSanitizer initialized (generic)\n");
  }
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 8e819fc4a260..c8289a3feabf 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -253,7 +253,7 @@ void __init kasan_init_hw_tags(void)
  	kasan_init_tags();

  	/* KASAN is now initialized, enable it. */
-	static_branch_enable(&kasan_flag_enabled);
+	kasan_enable();

  	pr_info("KernelAddressSanitizer initialized (hw-tags, mode=%s, 
vmalloc=%s, stacktrace=%s)\n",
  		kasan_mode_info(),
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index 525bc91e2fcd..275bcbbf6120 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -45,7 +45,7 @@ void __init kasan_init_sw_tags(void)

  	kasan_init_tags();

-	static_branch_enable(&kasan_flag_enabled);
+	kasan_enable();

  	pr_info("KernelAddressSanitizer initialized (sw-tags, stacktrace=%s)\n",
  		str_on_off(kasan_stack_collection_enabled()));


> 
> This addresses the bugzilla issue [1] about making
> kasan_flag_enabled and kasan_enabled() work for Generic mode,
> and extends it to provide true unification across all modes.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=217049
> 
> === Current mainline KUnit status
> 
> To see if there is any regression, I've tested first on the following
> commit 739a6c93cc75 ("Merge tag 'nfsd-6.16-1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux").
> 
> Tested via compiling a kernel with CONFIG_KASAN_KUNIT_TEST and running
> QEMU VM. There are failing tests in SW_TAGS and GENERIC modes in arm64:
> 
> arm64 CONFIG_KASAN_HW_TAGS:
> 	# kasan: pass:62 fail:0 skip:13 total:75
> 	# Totals: pass:62 fail:0 skip:13 total:75
> 	ok 1 kasan
> 
> arm64 CONFIG_KASAN_SW_TAGS=y:
> 	# kasan: pass:65 fail:1 skip:9 total:75
> 	# Totals: pass:65 fail:1 skip:9 total:75
> 	not ok 1 kasan
> 	# kasan_strings: EXPECTATION FAILED at mm/kasan/kasan_test_c.c:1598
> 	KASAN failure expected in "strscpy(ptr, src + KASAN_GRANULE_SIZE, KASAN_GRANULE_SIZE)", but none occurred
> 
> arm64 CONFIG_KASAN_GENERIC=y, CONFIG_KASAN_OUTLINE=y:
> 	# kasan: pass:61 fail:1 skip:13 total:75
> 	# Totals: pass:61 fail:1 skip:13 total:75
> 	not ok 1 kasan
> 	# same failure as above
> 
> x86_64 CONFIG_KASAN_GENERIC=y:
> 	# kasan: pass:58 fail:0 skip:17 total:75
> 	# Totals: pass:58 fail:0 skip:17 total:75
> 	ok 1 kasan
> 
> === Testing with patches
> 
> Testing in v2:
> 
> - Compiled every affected arch with no errors:
> 
> $ make CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip \
> 	OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf \
> 	HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar HOSTLD=ld.lld \
> 	ARCH=$ARCH
> 
> $ clang --version
> ClangBuiltLinux clang version 19.1.4
> Target: x86_64-unknown-linux-gnu
> Thread model: posix
> 
> - make ARCH=um produces the warning during compiling:
> 	MODPOST Module.symvers
> 	WARNING: modpost: vmlinux: section mismatch in reference: \
> 		kasan_init+0x43 (section: .ltext) -> \
> 		kasan_init_generic (section: .init.text)
> 
> AFAIU, it's due to the code in arch/um/kernel/mem.c, where kasan_init()
> is placed in own section ".kasan_init", which calls kasan_init_generic()
> which is marked with "__init".
> 
> - Booting via qemu-system- and running KUnit tests:
> 
> * arm64  (GENERIC, HW_TAGS, SW_TAGS): no regression, same above results.
> * x86_64 (GENERIC): no regression, no errors
> 
> === NB
> 
> I haven't tested the kernel boot on the following arch. due to the absence
> of qemu-system- support on those arch on my machine, so I defer this to
> relevant arch people to test KASAN initialization:
> - loongarch
> - s390
> - um
> - xtensa
> - powerpc
> - riscv
> 
> Code changes in v2:
> - Replace the order of patches. Move "kasan: replace kasan_arch_is_ready
> 	with kasan_enabled" at the end to keep the compatibility.
> - arch/arm, arch/riscv: add 2 arch. missed in v1
> - arch/powerpc: add kasan_init_generic() in other kasan_init() calls:
> 	arch/powerpc/mm/kasan/init_32.c
> 	arch/powerpc/mm/kasan/init_book3e_64.c
> - arch/um: add the proper header `#include <linux/kasan.h>`. Tested
> 	via compiling with no errors. In the v1 arch/um changes were acked-by
> 	Johannes Berg, though I don't include it due to the changed code in v2.
> - arch/powerpc: add back `#ifdef CONFIG_KASAN` deleted in v1 and tested
> 	the compilation.
> - arch/loongarch: update git commit message about non-standard flow of
> 	calling kasan_init_generic()
> 
> Sabyrzhan Tasbolatov (11):
>    kasan: unify static kasan_flag_enabled across modes
>    kasan/arm64: call kasan_init_generic in kasan_init
>    kasan/arm: call kasan_init_generic in kasan_init
>    kasan/xtensa: call kasan_init_generic in kasan_init
>    kasan/loongarch: call kasan_init_generic in kasan_init
>    kasan/um: call kasan_init_generic in kasan_init
>    kasan/x86: call kasan_init_generic in kasan_init
>    kasan/s390: call kasan_init_generic in kasan_init
>    kasan/powerpc: call kasan_init_generic in kasan_init
>    kasan/riscv: call kasan_init_generic in kasan_init
>    kasan: replace kasan_arch_is_ready with kasan_enabled
> 
>   arch/arm/mm/kasan_init.c               |  2 +-
>   arch/arm64/mm/kasan_init.c             |  4 +---
>   arch/loongarch/include/asm/kasan.h     |  7 -------
>   arch/loongarch/mm/kasan_init.c         |  7 ++-----
>   arch/powerpc/include/asm/kasan.h       | 13 -------------
>   arch/powerpc/mm/kasan/init_32.c        |  2 +-
>   arch/powerpc/mm/kasan/init_book3e_64.c |  2 +-
>   arch/powerpc/mm/kasan/init_book3s_64.c |  6 +-----
>   arch/riscv/mm/kasan_init.c             |  1 +
>   arch/s390/kernel/early.c               |  3 ++-
>   arch/um/include/asm/kasan.h            |  5 -----
>   arch/um/kernel/mem.c                   |  4 ++--
>   arch/x86/mm/kasan_init_64.c            |  2 +-
>   arch/xtensa/mm/kasan_init.c            |  2 +-
>   include/linux/kasan-enabled.h          | 22 ++++++++++++++++------
>   include/linux/kasan.h                  |  6 ++++++
>   mm/kasan/common.c                      | 15 +++++++++++----
>   mm/kasan/generic.c                     | 17 ++++++++++++++---
>   mm/kasan/hw_tags.c                     |  7 -------
>   mm/kasan/kasan.h                       |  6 ------
>   mm/kasan/shadow.c                      | 15 +++------------
>   mm/kasan/sw_tags.c                     |  2 ++
>   22 files changed, 66 insertions(+), 84 deletions(-)
> 


