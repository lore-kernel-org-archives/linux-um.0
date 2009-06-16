Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <menage@google.com>) id 1MGMz1-0004Jx-Ce
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Jun 2009 00:57:03 +0000
Received: from smtp-out.google.com ([216.239.45.13])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MGMyw-0006Rh-7t
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Jun 2009 00:57:03 +0000
From: Paul Menage <menage@google.com>
Date: Mon, 15 Jun 2009 17:17:29 -0700
Message-ID: <20090616001729.30398.72807.stgit@menage.mtv.corp.google.com>
In-Reply-To: <20090616001248.30398.84278.stgit@menage.mtv.corp.google.com>
References: <20090616001248.30398.84278.stgit@menage.mtv.corp.google.com>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH 1/5] UML: Fix some apparent bitrot
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: peterz@infradead.org, mingo@redhat.com, jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net

UML: Fix some apparent bitrot

- migration of net_device methods into net_device_ops
- address space layout changes
- dma_sync_single() changes

Signed-off-by: Paul Menage <menage@google.com>

---

 arch/um/drivers/slip_kern.c        |    1 -
 arch/um/drivers/slirp_kern.c       |    1 -
 arch/um/include/asm/dma-mapping.h  |    4 ++--
 arch/um/include/shared/as-layout.h |    4 +---
 4 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/um/drivers/slip_kern.c b/arch/um/drivers/slip_kern.c
index 5ec1756..dd2aadc 100644
--- a/arch/um/drivers/slip_kern.c
+++ b/arch/um/drivers/slip_kern.c
@@ -30,7 +30,6 @@ static void slip_init(struct net_device *dev, void *data)
 
 	slip_proto_init(&spri->slip);
 
-	dev->init = NULL;
 	dev->hard_header_len = 0;
 	dev->header_ops = NULL;
 	dev->addr_len = 0;
diff --git a/arch/um/drivers/slirp_kern.c b/arch/um/drivers/slirp_kern.c
index f15a6e7..e376284 100644
--- a/arch/um/drivers/slirp_kern.c
+++ b/arch/um/drivers/slirp_kern.c
@@ -32,7 +32,6 @@ void slirp_init(struct net_device *dev, void *data)
 
 	slip_proto_init(&spri->slip);
 
-	dev->init = NULL;
 	dev->hard_header_len = 0;
 	dev->header_ops = NULL;
 	dev->addr_len = 0;
diff --git a/arch/um/include/asm/dma-mapping.h b/arch/um/include/asm/dma-mapping.h
index 90fc708..378de4b 100644
--- a/arch/um/include/asm/dma-mapping.h
+++ b/arch/um/include/asm/dma-mapping.h
@@ -79,14 +79,14 @@ dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
 }
 
 static inline void
-dma_sync_single(struct device *dev, dma_addr_t dma_handle, size_t size,
+dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle, size_t size,
 		enum dma_data_direction direction)
 {
 	BUG();
 }
 
 static inline void
-dma_sync_sg(struct device *dev, struct scatterlist *sg, int nelems,
+dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nelems,
 	    enum dma_data_direction direction)
 {
 	BUG();
diff --git a/arch/um/include/shared/as-layout.h b/arch/um/include/shared/as-layout.h
index a92b678..05e4573 100644
--- a/arch/um/include/shared/as-layout.h
+++ b/arch/um/include/shared/as-layout.h
@@ -52,9 +52,7 @@ extern unsigned long end_vm;
 extern unsigned long start_vm;
 extern unsigned long long highmem;
 
-extern unsigned long _stext, _etext, _sdata, _edata, __bss_start, _end;
-extern unsigned long _unprotected_end;
-extern unsigned long brk_start;
+extern unsigned long _end;
 
 extern unsigned long host_task_size;
 


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

