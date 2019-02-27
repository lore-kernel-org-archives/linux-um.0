Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Steven Price <steven.price@arm.com>
Subject: [PATCH v3 21/34] um: mm: Add p?d_large() definitions
Date: Wed, 27 Feb 2019 17:05:55 +0000
Message-Id: <20190227170608.27963-22-steven.price@arm.com>
In-Reply-To: <20190227170608.27963-1-steven.price@arm.com>
References: <20190227170608.27963-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mm@kvack.org
Cc: Steven Price <steven.price@arm.com>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, James Morse <james.morse@arm.com>, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Mark Rutland <Mark.Rutland@arm.com>, "Liang, Kan" <kan.liang@linux.intel.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
List-ID: <linux-um.lists.infradead.org>

walk_page_range() is going to be allowed to walk page tables other than
those of user space. For this it needs to know when it has reached a
'leaf' entry in the page tables. This information is provided by the
p?d_large() functions/macros.

For um, we don't support large pages, so add stubs returning 0.

CC: Jeff Dike <jdike@addtoit.com>
CC: Richard Weinberger <richard@nod.at>
CC: Anton Ivanov <anton.ivanov@cambridgegreys.com>
CC: linux-um@lists.infradead.org
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/um/include/asm/pgtable-3level.h | 1 +
 arch/um/include/asm/pgtable.h        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/um/include/asm/pgtable-3level.h b/arch/um/include/asm/pgtable-3level.h
index c4d876dfb9ac..2abf9aa5808e 100644
--- a/arch/um/include/asm/pgtable-3level.h
+++ b/arch/um/include/asm/pgtable-3level.h
@@ -57,6 +57,7 @@
 #define pud_none(x)	(!(pud_val(x) & ~_PAGE_NEWPAGE))
 #define	pud_bad(x)	((pud_val(x) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
 #define pud_present(x)	(pud_val(x) & _PAGE_PRESENT)
+#define pud_large(x)	(0)
 #define pud_populate(mm, pud, pmd) \
 	set_pud(pud, __pud(_PAGE_TABLE + __pa(pmd)))
 
diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 9c04562310b3..d5fa4e118dcc 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -100,6 +100,7 @@ extern unsigned long end_iomem;
 #define	pmd_bad(x)	((pmd_val(x) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
 
 #define pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)
+#define pmd_large(x)	(0)
 #define pmd_clear(xp)	do { pmd_val(*(xp)) = _PAGE_NEWPAGE; } while (0)
 
 #define pmd_newpage(x)  (pmd_val(x) & _PAGE_NEWPAGE)
-- 
2.20.1


