Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Sat, 14 Apr 2012 17:52:11 +0200
Message-Id: <1334418731-16498-2-git-send-email-richard@nod.at>
In-Reply-To: <1334418731-16498-1-git-send-email-richard@nod.at>
References: <1334418731-16498-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 2/2] um: Fix __swp_type()
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, hughd@google.com, Richard Weinberger <richard@nod.at>, stable@kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

The current __swp_type() function uses a too small bitshift.
Using more than one swap files causes bad pages because
the type bits clash with other page flags.

CC: stable@kernel.org
Analyzed-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/include/asm/pgtable.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 294254e..5888f1b 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -354,11 +354,11 @@ extern pte_t *virt_to_pte(struct mm_struct *mm, unsigned long addr);
 #define update_mmu_cache(vma,address,ptep) do ; while (0)
 
 /* Encode and de-code a swap entry */
-#define __swp_type(x)			(((x).val >> 4) & 0x3f)
+#define __swp_type(x)			(((x).val >> 5) & 0x1f)
 #define __swp_offset(x)			((x).val >> 11)
 
 #define __swp_entry(type, offset) \
-	((swp_entry_t) { ((type) << 4) | ((offset) << 11) })
+	((swp_entry_t) { ((type) << 5) | ((offset) << 11) })
 #define __pte_to_swp_entry(pte) \
 	((swp_entry_t) { pte_val(pte_mkuptodate(pte)) })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
-- 
1.7.7.3

