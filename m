Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mJmsQ-00DZ6s-AG
 for linux-um@lists.infradead.org; Sat, 28 Aug 2021 01:11:19 +0000
Received: by mail-qt1-x82e.google.com with SMTP id r21so6786835qtw.11
 for <linux-um@lists.infradead.org>; Fri, 27 Aug 2021 18:11:17 -0700 (PDT)
From: CGEL <cgel.zte@gmail.com>
Subject: [PATCH linux-next] um: Replace if (cond) BUG() with BUG_ON()
Date: Fri, 27 Aug 2021 18:11:08 -0700
Message-Id: <20210828011108.11232-1-deng.changcheng@zte.com.cn>
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
To: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Yang Li <yang.lee@linux.alibaba.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Dave Hansen <dave.hansen@linux.intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Changcheng Deng <deng.changcheng@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Fix the following coccinelle reports:

./arch/um/kernel/mem.c:89:2-5: WARNING: Use BUG_ON instead of if
condition followed by BUG.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 arch/um/kernel/mem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 8e636ce..1810e69 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -85,8 +85,7 @@ static void __init one_md_table_init(pud_t *pud)
 		      __func__, PAGE_SIZE, PAGE_SIZE);
 
 	set_pud(pud, __pud(_KERNPG_TABLE + (unsigned long) __pa(pmd_table)));
-	if (pmd_table != pmd_offset(pud, 0))
-		BUG();
+	BUG_ON(pmd_table != pmd_offset(pud, 0));
 #endif
 }
 
-- 
1.8.3.1



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

