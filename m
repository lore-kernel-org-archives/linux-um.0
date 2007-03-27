Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HWGVx-0001qF-Ge for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Mar 2007 11:35:25 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HWGRg-000336-BI
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Mar 2007 11:31:01 -0700
Date: Tue, 27 Mar 2007 14:27:50 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070327182750.GA8421@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 6/6] UML - Fix LVM crash
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Jason Lunz <lunz@falooley.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>

From: Jason Lunz <lunz@falooley.org>

Permit lvm to create logical volumes without crashing UML.

When device-mapper's DM_DEV_CREATE_CMD ioctl is called to create a new
device, dev_create()->dm_create()->alloc_dev()->
blk_queue_bounce_limit(md->queue, BLK_BOUNCE_ANY) is called.

blk_queue_bounce_limit(BLK_BOUNCE_ANY) calls init_emergency_isa_pool()
if blk_max_pfn < blk_max_low_pfn. This is the case on UML, but
init_emergency_isa_pool() hits BUG_ON(!isa_page_pool) because there
doesn't seem to be a dma zone on UML for mempool_create() to allocate
from.

Most architectures seem to have max_low_pfn == max_pfn, but UML doesn't
because of the uml_reserved chunk it keeps for itself. From what I can
see, max_pfn and max_low_pfn don't get much use after the
bootmem-allocator stops being used anyway, except that they initialize
the block layer's blk_max_low_pfn/blk_max_pfn.

This ensures init_emergency_isa_pool() doesn't crash uml in this
situation by setting max_low_pfn == max_pfn in mem_init().

Signed-off-by: Jason Lunz <lunz@falooley.org>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/kernel/mem.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-2.6.21-mm/arch/um/kernel/mem.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/mem.c	2007-03-27 12:25:10.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/mem.c	2007-03-27 12:58:36.000000000 -0400
@@ -64,8 +64,6 @@ static void setup_highmem(unsigned long 
 
 void mem_init(void)
 {
-	max_low_pfn = (high_physmem - uml_physmem) >> PAGE_SHIFT;
-
 	/* clear the zero-page */
 	memset((void *) empty_zero_page, 0, PAGE_SIZE);
 
@@ -80,6 +78,7 @@ void mem_init(void)
 
 	/* this will put all low memory onto the freelists */
 	totalram_pages = free_all_bootmem();
+	max_low_pfn = totalram_pages;
 #ifdef CONFIG_HIGHMEM
 	totalhigh_pages = highmem >> PAGE_SHIFT;
 	totalram_pages += totalhigh_pages;

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
