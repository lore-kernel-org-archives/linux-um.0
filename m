Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMQLJ-002egG-OU
 for linux-um@lists.infradead.org; Wed, 17 Mar 2021 07:11:50 +0000
From: Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] um: replace if (cond) BUG() with BUG_ON()
Date: Wed, 17 Mar 2021 15:11:36 +0800
Message-Id: <1615965096-122733-1-git-send-email-yang.lee@linux.alibaba.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: jdike@addtoit.com
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>

Fix the following coccinelle reports:
./arch/um/kernel/mem.c:77:3-6: WARNING: Use BUG_ON instead of if
condition followed by BUG.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/um/kernel/mem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 9242dc9..22e28bf 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -73,8 +73,7 @@ static void __init one_page_table_init(pmd_t *pmd)
 
 		set_pmd(pmd, __pmd(_KERNPG_TABLE +
 					   (unsigned long) __pa(pte)));
-		if (pte != pte_offset_kernel(pmd, 0))
-			BUG();
+		BUG_ON(pte != pte_offset_kernel(pmd, 0));
 	}
 }
 
-- 
1.8.3.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

