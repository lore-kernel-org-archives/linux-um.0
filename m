Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 19 Jul 2014 17:04:05 +0530
From: Himangi Saraogi <himangi774@gmail.com>
Message-ID: <20140719113405.GA23568@himangi-Dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] uml/net_kern: Eliminate NULL test after alloc_bootmem
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

alloc_bootmem and related functions never return NULL. Thus a NULL
test or memset after calls to these functions is unnecessary.

The following Coccinelle semantic patch was used for making the change:

@@
expression E;
statement S;
@@

E = \(alloc_bootmem\|alloc_bootmem_low\|alloc_bootmem_pages\|alloc_bootmem_low_pages\)(...)
... when != E
- if (E == NULL) S

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
 arch/um/drivers/net_kern.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 7d26d9c..f70dd54 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -659,10 +659,6 @@ static int __init eth_setup(char *str)
 	}
 
 	new = alloc_bootmem(sizeof(*new));
-	if (new == NULL) {
-		printk(KERN_ERR "eth_init : alloc_bootmem failed\n");
-		return 1;
-	}
 
 	INIT_LIST_HEAD(&new->list);
 	new->index = n;
-- 
1.9.1

