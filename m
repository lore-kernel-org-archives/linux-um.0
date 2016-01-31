Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v2] um: asm/page.h: remove the pte_high member from struct pte_t
References: <871t91i7gf.fsf@gmail.com> <56AAB5ED.7020200@nod.at>
	<87wpqtgogb.fsf@gmail.com> <56AB2730.5020009@nod.at>
	<87bn845ufn.fsf@gmail.com> <56ADCFCC.4030207@nod.at>
Date: Sun, 31 Jan 2016 16:09:00 +0100
In-Reply-To: <56ADCFCC.4030207@nod.at> (Richard Weinberger's message of "Sun,
	31 Jan 2016 10:11:40 +0100")
Message-ID: <87powhkcqb.fsf_-_@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: Nicolai Stange <nicstange@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@linux-foundation.org>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Commit 16da306849d0 ("um: kill pfn_t")
introduced a compile warning for defconfig (SUBARCH=i386):

  arch/um/kernel/skas/mmu.c:38:206:
      warning: right shift count >= width of type [-Wshift-count-overflow]

Aforementioned patch changes the definition of the phys_to_pfn() macro from

  ((pfn_t) ((p) >> PAGE_SHIFT))

to

  ((p) >> PAGE_SHIFT)

This effectively changes the phys_to_pfn() expansion's type from
unsigned long long to unsigned long.

Through the callchain init_stub_pte() => mk_pte(), the expansion of
phys_to_pfn() is (indirectly) fed into the 'phys' argument of the
pte_set_val(pte, phys, prot) macro, eventually leading to

  (pte).pte_high = (phys) >> 32;

This results in the warning from above.

Since UML only deals with 32 bit addresses, the upper 32 bits from 'phys'
used to be always zero anyway. Also, all page protection flags defined by
UML don't use any bits beyond bit 9. Since the contents of a PTE are
defined within architecture scope only, the ->pte_high member can be safely
removed.

Remove the ->pte_high member from struct pte_t.
Rename ->pte_low to ->pte.
Adapt the pte helper macros in arch/um/include/asm/page.h.

Noteworthy is the pte_copy() macro where a smp_wmb() gets dropped.
This write barrier doesn't seem to be paired with any read barrier
though and thus, was useless anyway.

Fixes: 16da306849d0 ("um: kill pfn_t")
Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 v1 was "um: asm/page.h: zero out a pte's high value in set_pte_val()"

 Changes to v1: do not zero out ->pte_high in pte_set_val(), but remove
                ->pte_high alltogether.

 Although I said that I'm going to introduce a
   typedef unsigned long pteval_t;
 I did not do so in this patch because that would really have been two
 changes in one patch.
 What's more, introduction of pteval_t should probably come along with
 pgdval_t, pmdval_t and pgprotval_t also.

 arch/um/include/asm/page.h | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/um/include/asm/page.h b/arch/um/include/asm/page.h
index e13d41c..f878bec 100644
--- a/arch/um/include/asm/page.h
+++ b/arch/um/include/asm/page.h
@@ -34,21 +34,18 @@ struct page;
 
 #if defined(CONFIG_3_LEVEL_PGTABLES) && !defined(CONFIG_64BIT)
 
-typedef struct { unsigned long pte_low, pte_high; } pte_t;
+typedef struct { unsigned long pte; } pte_t;
 typedef struct { unsigned long pmd; } pmd_t;
 typedef struct { unsigned long pgd; } pgd_t;
-#define pte_val(x) ((x).pte_low | ((unsigned long long) (x).pte_high << 32))
-
-#define pte_get_bits(pte, bits) ((pte).pte_low & (bits))
-#define pte_set_bits(pte, bits) ((pte).pte_low |= (bits))
-#define pte_clear_bits(pte, bits) ((pte).pte_low &= ~(bits))
-#define pte_copy(to, from) ({ (to).pte_high = (from).pte_high; \
-			      smp_wmb(); \
-			      (to).pte_low = (from).pte_low; })
-#define pte_is_zero(pte) (!((pte).pte_low & ~_PAGE_NEWPAGE) && !(pte).pte_high)
-#define pte_set_val(pte, phys, prot) \
-	({ (pte).pte_high = (phys) >> 32; \
-	   (pte).pte_low = (phys) | pgprot_val(prot); })
+#define pte_val(p) ((p).pte)
+
+#define pte_get_bits(p, bits) ((p).pte & (bits))
+#define pte_set_bits(p, bits) ((p).pte |= (bits))
+#define pte_clear_bits(p, bits) ((p).pte &= ~(bits))
+#define pte_copy(to, from) ({ (to).pte = (from).pte; })
+#define pte_is_zero(p) (!((p).pte & ~_PAGE_NEWPAGE))
+#define pte_set_val(p, phys, prot) \
+	({ (p).pte = (phys) | pgprot_val(prot); })
 
 #define pmd_val(x)	((x).pmd)
 #define __pmd(x) ((pmd_t) { (x) } )
-- 
2.7.0


