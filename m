Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 19 Jul 2014 17:01:57 +0530
From: Himangi Saraogi <himangi774@gmail.com>
Message-ID: <20140719113157.GA23517@himangi-Dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] UML: Eliminate NULL test after alloc_bootmem_low_pages
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

alloc_bootmem and related functions never return NULL. Thus a NULL
test after calls to these functions is unnecessary.

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
 arch/um/kernel/physmem.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index 30fdd5d..fb041cf 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -43,8 +43,6 @@ int __init init_maps(unsigned long physmem, unsigned long iomem,
 	total_len = phys_len + iomem_len + highmem_len;
 
 	map = alloc_bootmem_low_pages(total_len);
-	if (map == NULL)
-		return -ENOMEM;
 
 	for (i = 0; i < total_pages; i++) {
 		p = &map[i];
-- 
1.9.1

