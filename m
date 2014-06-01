Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Real Name <enjoymindful@gmail.com>
Date: Sun,  1 Jun 2014 21:08:51 +0800
Message-Id: <1401628131-1948-2-git-send-email-enjoymindful@gmail.com>
In-Reply-To: <1401628131-1948-1-git-send-email-enjoymindful@gmail.com>
References: <1401628131-1948-1-git-send-email-enjoymindful@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] delete unnecessary bootmem struct page array
To: user-mode-linux-devel@lists.sourceforge.net
Cc: richard@nod.at, linux-kernel@vger.kernel.org, Honggang Li <enjoymindful@gmail.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: Honggang Li <enjoymindful@gmail.com>

1) uml kernel bootmem managed through bootmem_data->node_bootmem_map,
not the struct page array, so the array is unnecessary.

2) the bootmem struct page array has been pointed by a *local* pointer,
struct page *map, in init_maps function. The array can be accessed only
in init_maps's scope. As a result, uml kernel wastes about 1% of total
memory.

Signed-off-by: Honggang Li <enjoymindful@gmail.com>
---
 arch/um/kernel/um_arch.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 6043c76..5aa2d82 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -338,12 +338,6 @@ int __init linux_main(int argc, char **argv)
 	start_vm = VMALLOC_START;
 
 	setup_physmem(uml_physmem, uml_reserved, physmem_size, highmem);
-	if (init_maps(physmem_size, iomem_size, highmem)) {
-		printf("Failed to allocate mem_map for %Lu bytes of physical "
-		       "memory and %Lu bytes of highmem\n", physmem_size,
-		       highmem);
-		exit(1);
-	}
 
 	virtmem_size = physmem_size;
 	stack = (unsigned long) argv;
-- 
1.8.3.1

