Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EX2oi-0005Up-FZ for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 Nov 2005 12:33:12 -0800
Received: from host175-37.pool8253.interbusiness.it ([82.53.37.175]
	helo=zion.home.lan) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EX2ob-0002O9-7Z for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 Nov 2005 12:33:12 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20051101203721.26156.11021.stgit@zion.home.lan>
In-Reply-To: <20051101170633.GB6448@ccure.user-mode-linux.org>
References: <20051101170633.GB6448@ccure.user-mode-linux.org>
Subject: [uml-devel] [PATCH] uml: fix hardcoded ZONE_* constants in zone setup
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 01 Nov 2005 21:37:21 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Remove usage of hardcoded constants in paging_init().

By chance I spotted a bug in zones_setup involving a change to ZONE_* constants,
due to the ZONE_DMA32 patch from Andi Kleen (which is in -mm). So, possibly,
instead of zones_size[2] you will find zones_size[3] in the code, but that
change is wrong and this patch is still correct.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/mem.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -234,8 +234,8 @@ void paging_init(void)
 	empty_bad_page = (unsigned long *) alloc_bootmem_low_pages(PAGE_SIZE);
 	for(i=0;i<sizeof(zones_size)/sizeof(zones_size[0]);i++) 
 		zones_size[i] = 0;
-	zones_size[0] = (end_iomem >> PAGE_SHIFT) - (uml_physmem >> PAGE_SHIFT);
-	zones_size[2] = highmem >> PAGE_SHIFT;
+	zones_size[ZONE_DMA] = (end_iomem >> PAGE_SHIFT) - (uml_physmem >> PAGE_SHIFT);
+	zones_size[ZONE_HIGHMEM] = highmem >> PAGE_SHIFT;
 	free_area_init(zones_size);
 
 	/*



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
