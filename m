Return-Path: <openrisc-bounces@lists.librecores.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH V5 07/26] mm/mmap: Build protect protection_map[] with
 ARCH_HAS_VM_GET_PAGE_PROT
Date: Mon, 27 Jun 2022 10:28:14 +0530
Message-Id: <20220627045833.1590055-8-anshuman.khandual@arm.com>
In-Reply-To: <20220627045833.1590055-1-anshuman.khandual@arm.com>
References: <20220627045833.1590055-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Unsubscribe: <https://lists.librecores.org/options/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=unsubscribe>
List-Archive: <http://lists.librecores.org/pipermail/openrisc/>
List-Post: <mailto:openrisc@lists.librecores.org>
List-Help: <mailto:openrisc-request@lists.librecores.org?subject=help>
List-Subscribe: <https://lists.librecores.org/listinfo/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=subscribe>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>
To: linux-mm@kvack.org
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org, christophe.leroy@csgroup.eu, hch@infradead.org, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Anshuman Khandual <anshuman.khandual@arm.com>, linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org, linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-um.lists.infradead.org>

Now that protection_map[] has been moved inside those platforms that enable
ARCH_HAS_VM_GET_PAGE_PROT. Hence generic protection_map[] array now can be
protected with CONFIG_ARCH_HAS_VM_GET_PAGE_PROT intead of __P000.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/mm.h | 2 +-
 mm/mmap.c          | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 47bfe038d46e..65b7f3d9ff87 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -424,7 +424,7 @@ extern unsigned int kobjsize(const void *objp);
  * mapping from the currently active vm_flags protection bits (the
  * low four bits) to a page protection mask..
  */
-#ifdef __P000
+#ifndef CONFIG_ARCH_HAS_VM_GET_PAGE_PROT
 extern pgprot_t protection_map[16];
 #endif
 
diff --git a/mm/mmap.c b/mm/mmap.c
index b46d5e931bb3..2cc722e162fa 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -81,7 +81,7 @@ static void unmap_region(struct mm_struct *mm,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
 		unsigned long start, unsigned long end);
 
-#ifdef __P000
+#ifndef CONFIG_ARCH_HAS_VM_GET_PAGE_PROT
 pgprot_t protection_map[16] __ro_after_init = {
 	[VM_NONE]					= __P000,
 	[VM_READ]					= __P001,
@@ -100,9 +100,6 @@ pgprot_t protection_map[16] __ro_after_init = {
 	[VM_SHARED | VM_EXEC | VM_WRITE]		= __S110,
 	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= __S111
 };
-#endif
-
-#ifndef CONFIG_ARCH_HAS_VM_GET_PAGE_PROT
 DECLARE_VM_GET_PAGE_PROT
 #endif	/* CONFIG_ARCH_HAS_VM_GET_PAGE_PROT */
 
-- 
2.25.1


