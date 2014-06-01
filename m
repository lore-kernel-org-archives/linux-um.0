Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <enjoymindful@gmail.com>) id 1WqtZr-0002Ax-40
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Jun 2014 00:24:43 +0000
Received: from mail-pd0-f181.google.com ([209.85.192.181])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WqtZq-0004oA-6U
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Jun 2014 00:24:42 +0000
Received: by mail-pd0-f181.google.com with SMTP id z10so2197835pdj.12
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 31 May 2014 17:24:36 -0700 (PDT)
From: Real Name <enjoymindful@gmail.com>
Date: Sun,  1 Jun 2014 08:24:06 +0800
Message-Id: <1401582246-30025-1-git-send-email-enjoymindful@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH] delete unnecessary bootmem struct page array
To: user-mode-linux-devel@lists.sourceforge.net
Cc: richard@nod.at, linux-kernel@vger.kernel.org

1) uml kernel bootmem managed through bootmem_data->node_bootmem_map,
not struct page array, so it is unnecessary.

2) the struct page array allocate has been pointer by a *loacl* pointer
struct page *map in init_maps function. The array can't be access after
the init_maps exit. As a result, there is about 1% of total memory leak.
---
 arch/um/kernel/um_arch.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 016adf0..d4c98d1 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -348,12 +348,6 @@ int __init linux_main(int argc, char **argv)
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


------------------------------------------------------------------------------
Time is money. Stop wasting it! Get your web API in 5 minutes.
www.restlet.com/download
http://p.sf.net/sfu/restlet
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

