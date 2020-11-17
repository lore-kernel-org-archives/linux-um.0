Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kf0Xs-00011b-5f
 for linux-um@lists.infradead.org; Tue, 17 Nov 2020 12:57:26 +0000
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.9 14/21] um: Call pgtable_pmd_page_dtor() in
 __pmd_free_tlb()
Date: Tue, 17 Nov 2020 07:56:45 -0500
Message-Id: <20201117125652.599614-14-sashal@kernel.org>
In-Reply-To: <20201117125652.599614-1-sashal@kernel.org>
References: <20201117125652.599614-1-sashal@kernel.org>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, Matthew Wilcox <willy@infradead.org>, Christopher Obbard <chris.obbard@collabora.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Richard Weinberger <richard@nod.at>

[ Upstream commit 9a5085b3fad5d5d6019a3d160cdd70357d35c8b1 ]

Commit b2b29d6d0119 ("mm: account PMD tables like PTE tables") uncovered
a bug in uml, we forgot to call the destructor.
While we are here, give x a sane name.

Reported-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Co-developed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Richard Weinberger <richard@nod.at>
Tested-by: Christopher Obbard <chris.obbard@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/include/asm/pgalloc.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
index 5393e13e07e0a..2bbf28cf3aa92 100644
--- a/arch/um/include/asm/pgalloc.h
+++ b/arch/um/include/asm/pgalloc.h
@@ -33,7 +33,13 @@ do {							\
 } while (0)
 
 #ifdef CONFIG_3_LEVEL_PGTABLES
-#define __pmd_free_tlb(tlb,x, address)   tlb_remove_page((tlb),virt_to_page(x))
+
+#define __pmd_free_tlb(tlb, pmd, address)		\
+do {							\
+	pgtable_pmd_page_dtor(virt_to_page(pmd));	\
+	tlb_remove_page((tlb),virt_to_page(pmd));	\
+} while (0)						\
+
 #endif
 
 #endif
-- 
2.27.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

