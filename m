Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KB3q7-0007dc-W9 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 Jun 2008 01:25:24 -0700
Received: from mgw1.diku.dk ([130.225.96.91])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KB3q7-0000mN-9a
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 Jun 2008 01:25:23 -0700
Date: Tue, 24 Jun 2008 10:25:17 +0200 (CEST)
From: Julia Lawall <julia@diku.dk>
Message-ID: <Pine.LNX.4.64.0806241024580.26777@ask.diku.dk>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH 10/14] arch/um: Eliminate NULL test and memset
	after alloc_bootmem
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: akinobu.mita@gmail.com, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

As noted by Akinobu Mita in patch b1fceac2b9e04d278316b2faddf276015fc06e3b,
alloc_bootmem and related functions never return NULL and always return a
zeroed region of memory.  Thus a NULL test or memset after calls to these
functions is unnecessary.

 arch/um/drivers/net_kern.c |    4 ----
 arch/um/kernel/initrd.c    |    2 --
 arch/um/kernel/physmem.c   |    3 ---
 3 files changed, 9 deletions(-)

This was fixed using the following semantic patch.
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@@
expression E;
statement S;
@@

E = \(alloc_bootmem\|alloc_bootmem_low\|alloc_bootmem_pages\|alloc_bootmem_low_pages\)(...)
... when != E
(
- BUG_ON (E == NULL);
|
- if (E == NULL) S
)

@@
expression E,E1;
@@

E = \(alloc_bootmem\|alloc_bootmem_low\|alloc_bootmem_pages\|alloc_bootmem_low_pages\)(...)
... when != E
- memset(E,0,E1);
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>
---

diff -u -p a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -668,10 +668,6 @@ static int __init eth_setup(char *str)
 	}
 
 	new = alloc_bootmem(sizeof(*new));
-	if (new == NULL) {
-		printk(KERN_ERR "eth_init : alloc_bootmem failed\n");
-		return 1;
-	}
 
 	INIT_LIST_HEAD(&new->list);
 	new->index = n;
diff -u -p a/arch/um/kernel/initrd.c b/arch/um/kernel/initrd.c
--- a/arch/um/kernel/initrd.c
+++ b/arch/um/kernel/initrd.c
@@ -37,8 +37,6 @@ static int __init read_initrd(void)
 	}
 
 	area = alloc_bootmem(size);
-	if (area == NULL)
-		return 0;
 
 	if (load_initrd(initrd, area, size) == -1)
 		return 0;
diff -u -p a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -41,12 +41,9 @@ int __init init_maps(unsigned long physm
 	total_len = phys_len + iomem_len + highmem_len;
 
 	map = alloc_bootmem_low_pages(total_len);
-	if (map == NULL)
-		return -ENOMEM;
 
 	for (i = 0; i < total_pages; i++) {
 		p = &map[i];
-		memset(p, 0, sizeof(struct page));
 		SetPageReserved(p);
 		INIT_LIST_HEAD(&p->lru);
 	}

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
