Return-Path: <brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [RESEND PATCH 3/4] um: define set_pte_at() as a static inline function, not a macro
Date: Wed,  3 Apr 2019 10:39:01 +0200
Message-Id: <20190403083902.3975-4-brgl@bgdev.pl>
In-Reply-To: <20190403083902.3975-1-brgl@bgdev.pl>
References: <20190403083902.3975-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-ID: <linux-um.lists.infradead.org>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

When defined as macro, the mm argument is unused and subsequently the
variable passed as mm is considered unused by the compiler. This fixes
a build warning.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/um/include/asm/pgtable.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 9c04562310b3..b377df76cc28 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -263,7 +263,12 @@ static inline void set_pte(pte_t *pteptr, pte_t pteval)
 	*pteptr = pte_mknewpage(*pteptr);
 	if(pte_present(*pteptr)) *pteptr = pte_mknewprot(*pteptr);
 }
-#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
+
+static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
+			      pte_t *pteptr, pte_t pteval)
+{
+	set_pte(pteptr, pteval);
+}
 
 #define __HAVE_ARCH_PTE_SAME
 static inline int pte_same(pte_t pte_a, pte_t pte_b)
-- 
2.21.0


