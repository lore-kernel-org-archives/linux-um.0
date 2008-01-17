Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFcTq-000123-2t for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:41:01 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JFcTp-0001aK-5O
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:40:58 -0800
Date: Thu, 17 Jan 2008 16:40:39 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080117214039.GA6697@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 3/20] UML - SMP locking commentary
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
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Add some more commentary about various pieces of global data not
needing locking.

Also got rid of unmap_physmem since that is no longer used.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/drivers/net_kern.c |    7 ++++++-
 arch/um/include/mem_user.h |    1 -
 arch/um/kernel/mem.c       |   13 ++++++++-----
 arch/um/kernel/physmem.c   |    6 +++---
 4 files changed, 17 insertions(+), 10 deletions(-)

Index: linux-2.6.22/arch/um/include/mem_user.h
===================================================================
--- linux-2.6.22.orig/arch/um/include/mem_user.h	2007-12-14 10:45:27.000000000 -0500
+++ linux-2.6.22/arch/um/include/mem_user.h	2007-12-14 11:19:06.000000000 -0500
@@ -56,7 +56,6 @@ extern void setup_physmem(unsigned long 
 			  unsigned long len, unsigned long long highmem);
 extern void add_iomem(char *name, int fd, unsigned long size);
 extern unsigned long phys_offset(unsigned long phys);
-extern void unmap_physmem(void);
 extern void map_memory(unsigned long virt, unsigned long phys,
 		       unsigned long len, int r, int w, int x);
 
Index: linux-2.6.22/arch/um/kernel/mem.c
===================================================================
--- linux-2.6.22.orig/arch/um/kernel/mem.c	2007-12-14 10:45:27.000000000 -0500
+++ linux-2.6.22/arch/um/kernel/mem.c	2007-12-14 11:20:01.000000000 -0500
@@ -22,17 +22,20 @@
 unsigned long *empty_zero_page = NULL;
 /* allocated in paging_init and unchanged thereafter */
 unsigned long *empty_bad_page = NULL;
+
+/*
+ * Initialized during boot, and readonly for initializing page tables
+ * afterwards
+ */
 pgd_t swapper_pg_dir[PTRS_PER_PGD];
+
+/* Initialized at boot time, and readonly after that */
 unsigned long long highmem;
 int kmalloc_ok = 0;
 
+/* Used during early boot */
 static unsigned long brk_end;
 
-void unmap_physmem(void)
-{
-	os_unmap_memory((void *) brk_end, uml_reserved - brk_end);
-}
-
 static void map_cb(void *unused)
 {
 	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
Index: linux-2.6.22/arch/um/kernel/physmem.c
===================================================================
--- linux-2.6.22.orig/arch/um/kernel/physmem.c	2007-12-14 10:45:27.000000000 -0500
+++ linux-2.6.22/arch/um/kernel/physmem.c	2007-12-14 11:19:06.000000000 -0500
@@ -164,10 +164,10 @@ __uml_setup("iomem=", parse_iomem,
  * setup_iomem, both of which run during early boot.  Afterwards, it's
  * unchanged.
  */
-struct iomem_region *iomem_regions = NULL;
+struct iomem_region *iomem_regions;
 
-/* Initialized in parse_iomem */
-int iomem_size = 0;
+/* Initialized in parse_iomem and unchanged thereafter */
+int iomem_size;
 
 unsigned long find_iomem(char *driver, unsigned long *len_out)
 {
Index: linux-2.6.22/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.22.orig/arch/um/drivers/net_kern.c	2007-12-14 10:45:27.000000000 -0500
+++ linux-2.6.22/arch/um/drivers/net_kern.c	2007-12-14 11:19:06.000000000 -0500
@@ -368,7 +368,6 @@ static struct platform_driver uml_net_dr
 		.name  = DRIVER_NAME,
 	},
 };
-static int driver_registered;
 
 static void net_device_release(struct device *dev)
 {
@@ -383,6 +382,12 @@ static void net_device_release(struct de
 	free_netdev(netdev);
 }
 
+/*
+ * Ensures that platform_driver_register is called only once by
+ * eth_configure.  Will be set in an initcall.
+ */
+static int driver_registered;
+
 static void eth_configure(int n, void *init, char *mac,
 			  struct transport *transport)
 {

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
