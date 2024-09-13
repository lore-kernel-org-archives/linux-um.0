Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175D8FA375A
	for <linux-um@archiver.kernel.org>; Fri, 13 Sep 2024 14:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2iMqCL16nvIVqbFIVvASdDsc9aD2h+9cgin+rWYCLmc=; b=4e38joDzMl4oQ9IXjUBhwJI3xX
	TMmlFIWFcGqogLgYmohUvGD/tVJ4cyuPuaCs0WQIxiov0iNcfftv9nWM7/SNjDTOu3UnLHnV2bmqy
	RPqqeFNTW1/oncNxEeoZFWzhvGhNWFzHqLxSWvee43crIHSqvSQ1PEkPiTnECOAxTOaB+sXJxpRgR
	sauuyYmdwpBZzIcOXM+mQI9LMggNwQYRXvWBVy3RVytI8D4NgoLgFIKlMfwyAy0yyVvGGZKxaNO4z
	rmDS7kTxA0X8c78UpKAnVKnGjj/IH35nw9XTNH5SMQtcXns0o+heiNQdyHdCySc8YZhewyf+P1Mrb
	zdcfZQOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp7BL-0000000GAr0-2viH;
	Fri, 13 Sep 2024 14:21:55 +0000
Received: from out0-215.mail.aliyun.com ([140.205.0.215])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp7BG-0000000GAo4-2KiR
	for linux-um@lists.infradead.org;
	Fri, 13 Sep 2024 14:21:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1726237307; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=2iMqCL16nvIVqbFIVvASdDsc9aD2h+9cgin+rWYCLmc=;
	b=igYGEzdV5R8IT2DoWdSLvB+kxwALtxsnUjR6cEaM4nnVWyHYUo/4QiH/nwn61IJCHOpmC1P1z+vs6kEtujIZgj2JJ3CQ/UksTAeBmGuWf9Slg53iz16hDC1NBBXkNi1F5Z9quJ2xsifhB7vpaZwQ/20x3inn4aVRGacfeyMKi1Y=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZIP7E8L_1726237305)
          by smtp.aliyun-inc.com;
          Fri, 13 Sep 2024 22:21:46 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 2/3] um: Remove highmem leftovers
Date: Fri, 13 Sep 2024 22:21:36 +0800
Message-Id: <20240913142137.248245-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913142137.248245-1-tiwei.btw@antgroup.com>
References: <20240913142137.248245-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_072150_797417_43F5F826 
X-CRM114-Status: GOOD (  20.08  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Highmem was only supported on UML/i386. And the support has been
removed by commit a98a6d864d3b ("um: Remove broken highmem support").
Remove the leftovers and stop UML from trying to setup highmem when
the sum of physmem_size and iomem_size exceeds max_physmem.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/virtio_uml.c       |  9 +--------
 arch/um/include/shared/as-layout.h |  1 -
 arch/um/include/shared/mem_user.h  |  5 ++---
 arch/um/kernel/mem.c               |  3 ---
 arch/um/kernel/physmem.c           | 30 +++++++++++-------------------
 arch/um/kernel/um_arch.c           | 17 +++++++----------
 6 files changed, 21 insertions(+), 44 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 2b6e701776b6..e7f5556e3c96 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -72,7 +72,7 @@ struct virtio_uml_vq_info {
 	bool suspended;
 };
 
-extern unsigned long long physmem_size, highmem;
+extern unsigned long long physmem_size;
 
 #define vu_err(vu_dev, ...)	dev_err(&(vu_dev)->pdev->dev, ##__VA_ARGS__)
 
@@ -673,13 +673,6 @@ static int vhost_user_set_mem_table(struct virtio_uml_device *vu_dev)
 
 	if (rc < 0)
 		return rc;
-	if (highmem) {
-		msg.payload.mem_regions.num++;
-		rc = vhost_user_init_mem_region(__pa(end_iomem), highmem,
-				&fds[1], &msg.payload.mem_regions.regions[1]);
-		if (rc < 0)
-			return rc;
-	}
 
 	return vhost_user_send(vu_dev, false, &msg, fds,
 			       msg.payload.mem_regions.num);
diff --git a/arch/um/include/shared/as-layout.h b/arch/um/include/shared/as-layout.h
index 06292fca5a4d..61965a06c18a 100644
--- a/arch/um/include/shared/as-layout.h
+++ b/arch/um/include/shared/as-layout.h
@@ -41,7 +41,6 @@ extern unsigned long uml_physmem;
 extern unsigned long uml_reserved;
 extern unsigned long end_vm;
 extern unsigned long start_vm;
-extern unsigned long long highmem;
 
 extern unsigned long brk_start;
 
diff --git a/arch/um/include/shared/mem_user.h b/arch/um/include/shared/mem_user.h
index 11a723a58545..adfa08062f88 100644
--- a/arch/um/include/shared/mem_user.h
+++ b/arch/um/include/shared/mem_user.h
@@ -47,10 +47,9 @@ extern int iomem_size;
 #define ROUND_4M(n) ((((unsigned long) (n)) + (1 << 22)) & ~((1 << 22) - 1))
 
 extern unsigned long find_iomem(char *driver, unsigned long *len_out);
-extern void mem_total_pages(unsigned long physmem, unsigned long iomem,
-		     unsigned long highmem);
+extern void mem_total_pages(unsigned long physmem, unsigned long iomem);
 extern void setup_physmem(unsigned long start, unsigned long usable,
-			  unsigned long len, unsigned long long highmem);
+			  unsigned long len);
 extern void map_memory(unsigned long virt, unsigned long phys,
 		       unsigned long len, int r, int w, int x);
 
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index a5b4fe2ad931..5026668dc054 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -6,7 +6,6 @@
 #include <linux/stddef.h>
 #include <linux/module.h>
 #include <linux/memblock.h>
-#include <linux/highmem.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
@@ -51,8 +50,6 @@ EXPORT_SYMBOL(empty_zero_page);
 pgd_t swapper_pg_dir[PTRS_PER_PGD];
 
 /* Initialized at boot time, and readonly after that */
-unsigned long long highmem;
-EXPORT_SYMBOL(highmem);
 int kmalloc_ok = 0;
 
 /* Used during early boot */
diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index fb2adfb49945..cc5238c1bf1e 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -24,17 +24,14 @@ EXPORT_SYMBOL(high_physmem);
 
 extern unsigned long long physmem_size;
 
-void __init mem_total_pages(unsigned long physmem, unsigned long iomem,
-		     unsigned long highmem)
+void __init mem_total_pages(unsigned long physmem, unsigned long iomem)
 {
-	unsigned long phys_pages, highmem_pages;
-	unsigned long iomem_pages, total_pages;
+	unsigned long phys_pages, iomem_pages, total_pages;
 
-	phys_pages    = physmem >> PAGE_SHIFT;
-	iomem_pages   = iomem   >> PAGE_SHIFT;
-	highmem_pages = highmem >> PAGE_SHIFT;
+	phys_pages  = physmem >> PAGE_SHIFT;
+	iomem_pages = iomem   >> PAGE_SHIFT;
 
-	total_pages   = phys_pages + iomem_pages + highmem_pages;
+	total_pages = phys_pages + iomem_pages;
 
 	max_mapnr = total_pages;
 }
@@ -64,13 +61,12 @@ void map_memory(unsigned long virt, unsigned long phys, unsigned long len,
  * @reserve_end:	end address of the physical kernel memory.
  * @len:	Length of total physical memory that should be mapped/made
  *		available, in bytes.
- * @highmem:	Number of highmem bytes that should be mapped/made available.
  *
- * Creates an unlinked temporary file of size (len + highmem) and memory maps
+ * Creates an unlinked temporary file of size (len) and memory maps
  * it on the last executable image address (uml_reserved).
  *
  * The offset is needed as the length of the total physical memory
- * (len + highmem) includes the size of the memory used be the executable image,
+ * (len) includes the size of the memory used be the executable image,
  * but the mapped-to address is the last address of the executable image
  * (uml_reserved == end address of executable image).
  *
@@ -78,19 +74,19 @@ void map_memory(unsigned long virt, unsigned long phys, unsigned long len,
  * of all user space processes/kernel tasks.
  */
 void __init setup_physmem(unsigned long start, unsigned long reserve_end,
-			  unsigned long len, unsigned long long highmem)
+			  unsigned long len)
 {
 	unsigned long reserve = reserve_end - start;
 	long map_size = len - reserve;
 	int err;
 
-	if(map_size <= 0) {
+	if (map_size <= 0) {
 		os_warn("Too few physical memory! Needed=%lu, given=%lu\n",
 			reserve, len);
 		exit(1);
 	}
 
-	physmem_fd = create_mem_file(len + highmem);
+	physmem_fd = create_mem_file(len);
 
 	err = os_map_memory((void *) reserve_end, physmem_fd, reserve,
 			    map_size, 1, 1, 1);
@@ -109,7 +105,7 @@ void __init setup_physmem(unsigned long start, unsigned long reserve_end,
 	os_write_file(physmem_fd, __syscall_stub_start, PAGE_SIZE);
 	os_fsync_file(physmem_fd);
 
-	memblock_add(__pa(start), len + highmem);
+	memblock_add(__pa(start), len);
 	memblock_reserve(__pa(start), reserve);
 
 	min_low_pfn = PFN_UP(__pa(reserve_end));
@@ -137,10 +133,6 @@ int phys_mapping(unsigned long phys, unsigned long long *offset_out)
 			region = region->next;
 		}
 	}
-	else if (phys < __pa(end_iomem) + highmem) {
-		fd = physmem_fd;
-		*offset_out = phys - iomem_size;
-	}
 
 	return fd;
 }
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 8e594cda6d77..8f86aa468b50 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -366,18 +366,15 @@ int __init linux_main(int argc, char **argv)
 
 	setup_machinename(init_utsname()->machine);
 
-	highmem = 0;
+	physmem_size = (physmem_size + PAGE_SIZE - 1) & PAGE_MASK;
 	iomem_size = (iomem_size + PAGE_SIZE - 1) & PAGE_MASK;
+
 	max_physmem = TASK_SIZE - uml_physmem - iomem_size - MIN_VMALLOC;
 
-	/*
-	 * Zones have to begin on a 1 << MAX_PAGE_ORDER page boundary,
-	 * so this makes sure that's true for highmem
-	 */
-	max_physmem &= ~((1 << (PAGE_SHIFT + MAX_PAGE_ORDER)) - 1);
 	if (physmem_size + iomem_size > max_physmem) {
-		highmem = physmem_size + iomem_size - max_physmem;
-		physmem_size -= highmem;
+		physmem_size = max_physmem - iomem_size;
+		os_info("Physical memory size shrunk to %llu bytes\n",
+			physmem_size);
 	}
 
 	high_physmem = uml_physmem + physmem_size;
@@ -413,8 +410,8 @@ void __init setup_arch(char **cmdline_p)
 	u8 rng_seed[32];
 
 	stack_protections((unsigned long) &init_thread_info);
-	setup_physmem(uml_physmem, uml_reserved, physmem_size, highmem);
-	mem_total_pages(physmem_size, iomem_size, highmem);
+	setup_physmem(uml_physmem, uml_reserved, physmem_size);
+	mem_total_pages(physmem_size, iomem_size);
 	uml_dtb_init();
 	read_initrd();
 
-- 
2.34.1


