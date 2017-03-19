Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: WARNING: CPU: 0 PID: 1 at mm/mmap.c:1110 vma_merge+0x9a/0x2c8
References: <b579ab24-7032-9322-fc8d-671c25d802d6@nod.at>
 <20170317183635.GC28995@redhat.com>
 <b7b3f276-0b0b-cb94-e501-4b087a241311@nod.at>
 <20170318104629.GA5129@redhat.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <48f5cadd-d568-a192-e4d3-18a1c31ce7a6@nod.at>
Date: Sun, 19 Mar 2017 23:02:19 +0100
MIME-Version: 1.0
In-Reply-To: <20170318104629.GA5129@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Arcangeli <aarcange@redhat.com>
Cc: adityam@microsoft.com, Rik van Riel <riel@redhat.com>, hughd@google.com, mgorman@techsingularity.net, janvorli@microsoft.com, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, Al Viro <viro@zeniv.linux.org.uk>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Andrea,

Am 18.03.2017 um 11:46 schrieb Andrea Arcangeli:
> Your proposed fix sounds fine and it won't slowdown setup_arg_pages
> just for UML, but you should then double check there cannot be an
> overlap with the pre-existing vma (i.e. bprm->vma), because
> __install_special_mapping wouldn't verify that.

After some thinking together with Al I realized that my approach is not
that nice.
UML cannot use arch_setup_additional_pages() since it is only being called
for ELF binaries. And, most important, it needs also to install them also in
arch_dup_mmap() because we cannot copy the pages upon fork().
Since this is only a minor issue I'd like to find a solution with the least
churn.

An alternative solution would be providing another mm hook to find such an
"early vma". Please see the attached diff. What do you think?

Thanks,
//richard

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index b9e3f0aca261..d16d6daf8928 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -169,5 +169,10 @@ static inline bool arch_pte_access_permitted(pte_t pte, bool write)
 	/* by default, allow everything */
 	return true;
 }
+
+static inline struct vm_area_struct *arch_early_vma(struct mm_struct *mm)
+{
+	return NULL;
+}
 #endif /* __KERNEL__ */
 #endif /* __ASM_POWERPC_MMU_CONTEXT_H */
diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index 6e31d87fb669..f27d34927cdf 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -162,4 +162,9 @@ static inline bool arch_pte_access_permitted(pte_t pte, bool write)
 	/* by default, allow everything */
 	return true;
 }
+
+static inline struct vm_area_struct *arch_early_vma(struct mm_struct *mm)
+{
+	return NULL;
+}
 #endif /* __S390_MMU_CONTEXT_H */
diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
index 94ac2739918c..893a7a61dce6 100644
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -10,6 +10,7 @@
 #include <linux/mm_types.h>

 #include <asm/mmu.h>
+#include <as-layout.h>

 extern void uml_setup_stubs(struct mm_struct *mm);
 /*
@@ -43,6 +44,11 @@ static inline bool arch_pte_access_permitted(pte_t pte, bool write)
 	return true;
 }

+static inline struct vm_area_struct *arch_early_vma(struct mm_struct *mm)
+{
+	return find_vma(mm, STUB_START);
+}
+
 /*
  * end asm-generic/mm_hooks.h functions
  */
diff --git a/arch/unicore32/include/asm/mmu_context.h b/arch/unicore32/include/asm/mmu_context.h
index 62dfc644c908..23c547787b62 100644
--- a/arch/unicore32/include/asm/mmu_context.h
+++ b/arch/unicore32/include/asm/mmu_context.h
@@ -109,4 +109,10 @@ static inline bool arch_pte_access_permitted(pte_t pte, bool write)
 	/* by default, allow everything */
 	return true;
 }
+
+static inline struct vm_area_struct *arch_early_vma(struct mm_struct *mm)
+
+{
+	return NULL;
+}
 #endif
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 306c7e12af55..03d3657b4494 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -272,4 +272,9 @@ static inline bool arch_pte_access_permitted(pte_t pte, bool write)
 {
 	return __pkru_allows_pkey(pte_flags_pkey(pte_flags(pte)), write);
 }
+
+static inline struct vm_area_struct *arch_early_vma(struct mm_struct *mm)
+{
+	return NULL;
+}
 #endif /* _ASM_X86_MMU_CONTEXT_H */
diff --git a/fs/exec.c b/fs/exec.c
index 65145a3df065..5e7d8eb7bd08 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -667,7 +667,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	unsigned long stack_shift;
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = bprm->vma;
-	struct vm_area_struct *prev = NULL;
+	struct vm_area_struct *prev = arch_early_vma(mm);
 	unsigned long vm_flags;
 	unsigned long stack_base;
 	unsigned long stack_size;
diff --git a/include/asm-generic/mm_hooks.h b/include/asm-generic/mm_hooks.h
index cc5d9a1405df..ada50a350030 100644
--- a/include/asm-generic/mm_hooks.h
+++ b/include/asm-generic/mm_hooks.h
@@ -38,4 +38,9 @@ static inline bool arch_pte_access_permitted(pte_t pte, bool write)
 	/* by default, allow everything */
 	return true;
 }
+
+static inline struct vm_area_struct *arch_early_vma(struct mm_struct *mm)
+{
+	return NULL;
+}
 #endif	/* _ASM_GENERIC_MM_HOOKS_H */

