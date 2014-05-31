Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Real Name <enjoymindful@gmail.com>
Date: Sun,  1 Jun 2014 07:34:42 +0800
Message-Id: <1401579282-17987-1-git-send-email-enjoymindful@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] delete unnecessary bootmem struct page array
To: user-mode-linux-devel@lists.sourceforge.net
Cc: richard@nod.at, linux-kernel@vger.kernel.org, Real Name <enjoymindful@gmail.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

1) uml kernel bootmem managed through bootmem_data->node_bootmem_map,
not struct page array, so it is unnecessary.

2) the struct page array allocate has been pointer by a *loacl* pointer
struct page *map in init_maps function. The array can't be access after
the init_maps exit. As a result, there is about 1% of total memory leak.
---
 arch/um/kernel/um_arch.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 016adf0..9f3c6d1 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -309,11 +309,6 @@ int __init linux_main(int argc, char **argv)
 	 */
 
 	diff = UML_ROUND_UP(brk_start) - UML_ROUND_UP(&_end);
-	if (diff > 1024 * 1024) {
-		printf("Adding %ld bytes to physical memory to account for "
-		       "exec-shield gap\n", diff);
-		physmem_size += UML_ROUND_UP(brk_start) - UML_ROUND_UP(&_end);
-	}
 
 	uml_physmem = (unsigned long) &__binary_start & PAGE_MASK;
 
-- 
1.8.3.1

