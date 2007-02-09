Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HFdoV-0006ZZ-Bw for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Feb 2007 14:01:53 -0800
Received: from crown.reflexsecurity.com ([72.54.139.163])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HFdoU-0008Aq-Tl
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Feb 2007 14:01:51 -0800
Date: Fri, 9 Feb 2007 17:01:44 -0500
From: Jason Lunz <lunz@falooley.org>
Message-ID: <20070209220144.GB30936@metaxa.reflex>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [UML] fix crash in block layer
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
To: Jeff Dike <jdike@addtoit.com>, Blaisorblade <blaisorblade@yahoo.it>, Jens Axboe <jens.axboe@oracle.com>
Cc: user-mode-linux-devel@lists.sourceforge.net


[resent, axboe@suse.de bounced]

When the device-mapper DM_DEV_CREATE_CMD ioctl is called to create a new
device, dev_create()->dm_create()->alloc_dev()->
blk_queue_bounce_limit(md->queue, BLK_BOUNCE_ANY) happens.

blk_queue_bounce_limit(BLK_BOUNCE_ANY) calls init_emergency_isa_pool()
if blk_max_pfn < blk_max_low_pfn. This is the case on UML, but
init_emergency_isa_pool() hits BUG_ON(!isa_page_pool) because there
doesn't seem to be a dma zone on UML for mempool_create() to allocate from.

Most architectures seem to have max_low_pfn == max_pfn, but UML doesn't
because of the uml_reserved chunk it keeps for itself. From what I can
see, max_pfn and max_low_pfn don't get much use after the
bootmem-allocator stops being used anyway, except that they initialize
the block layer's blk_max_low_pfn/blk_max_pfn.

With this applied I can use lvm to create logical volumes without
crashing UML.

Signed-off-by: Jason Lunz <lunz@falooley.org>

---
 arch/um/kernel/mem.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-2.6.20-rc5-uml/arch/um/kernel/mem.c
===================================================================
--- linux-2.6.20-rc5-uml.orig/arch/um/kernel/mem.c
+++ linux-2.6.20-rc5-uml/arch/um/kernel/mem.c
@@ -63,7 +63,7 @@
 
 void mem_init(void)
 {
-	max_low_pfn = (high_physmem - uml_physmem) >> PAGE_SHIFT;
+	max_pfn = max_low_pfn = (high_physmem - uml_physmem) >> PAGE_SHIFT;
 
         /* clear the zero-page */
         memset((void *) empty_zero_page, 0, PAGE_SIZE);
@@ -84,7 +84,6 @@
 	totalram_pages += totalhigh_pages;
 #endif
 	num_physpages = totalram_pages;
-	max_pfn = totalram_pages;
 	printk(KERN_INFO "Memory: %luk available\n", 
 	       (unsigned long) nr_free_pages() << (PAGE_SHIFT-10));
 	kmalloc_ok = 1;

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
