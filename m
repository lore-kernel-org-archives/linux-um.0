Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B36CCF9EA
	for <linux-um@archiver.kernel.org>; Sun, 26 Oct 2025 23:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ltvUojeDw2skWltkLkA8I4LPaua+3RtbVj9v75fVcTk=; b=X/BRtDy5RRwNpuOT5dp4jer8i/
	mc18OiKpROzrwhM3m1gJH/qaAQ0Je7rWoBCMp8LIXd0+szHZEK9/cJmU9t5qZdQWz41CbU1H+tPdW
	TpP7fvSyBv8K2EZ0Cjl2RIvivNRLGSuU7kKxfPuSPHINSWghhFc10GVKkjRX0XhmAd0r7q3RJ0yZh
	bKLQ2r4vs5FBekitA6fFiMbzOmrWCY8Z+QLPPRI7pLLHuu1b3pz0vXoazCuQ1IY/ylfSFylbIbiZL
	l/+mJfVQNgYzj7LVSeWcMPfFuxxhaCL0zu5qO78ySrMUC01d7LQt24xTlcLzVfk+p+hxoI6RlWt1E
	Sg/85Pnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDAeM-0000000CsIA-1YUj;
	Sun, 26 Oct 2025 23:59:50 +0000
Received: from out-184.mta0.migadu.com ([91.218.175.184])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDAeJ-0000000CsHE-1IEK
	for linux-um@lists.infradead.org;
	Sun, 26 Oct 2025 23:59:48 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761523185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ltvUojeDw2skWltkLkA8I4LPaua+3RtbVj9v75fVcTk=;
	b=ukl/Y5OVH6PiezY+yVtFImFv7FWkfzRNitWjygPZ4n4kboEoBWdxs7eVFBu8+J8u6eG1jl
	QmFaWELxXVk/3OI3aEehGEBJtPMzoHRJnPawlcZd79PRAY8k4jd2Gu7NCd5Pa/SMgDtFoY
	CqQK8HdMJA8I4djY5lC7mZxI/waA438=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH 3/3] um: Remove file-based iomem emulation support
Date: Mon, 27 Oct 2025 07:59:12 +0800
Message-Id: <20251026235912.1654016-4-tiwei.bie@linux.dev>
In-Reply-To: <20251026235912.1654016-1-tiwei.bie@linux.dev>
References: <20251026235912.1654016-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251026_165947_515574_CA96B4BB 
X-CRM114-Status: GOOD (  26.26  )
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

From: Tiwei Bie <tiwei.btw@antgroup.com>

The file-based iomem emulation was introduced to support writing
paravirtualized drivers based on emulated iomem regions. However,
the only driver that makes use of it is an example driver called
mmapper, which was written about two decades ago.

We now have several modern device emulation mechanisms, such as
vhost-user-based virtio-uml. Remove the file-based iomem emulation
support to reduce the maintenance burden.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/Kconfig                    |   6 --
 arch/um/drivers/Makefile           |   1 -
 arch/um/drivers/mmapper_kern.c     | 135 -----------------------------
 arch/um/include/asm/pgtable.h      |   4 +-
 arch/um/include/shared/kern_util.h |   1 -
 arch/um/include/shared/mem_user.h  |  13 ---
 arch/um/kernel/mem.c               |   2 +-
 arch/um/kernel/physmem.c           |  71 ---------------
 arch/um/kernel/um_arch.c           |   7 +-
 arch/um/os-Linux/skas/process.c    |   7 --
 arch/um/os-Linux/start_up.c        |  50 -----------
 11 files changed, 4 insertions(+), 293 deletions(-)
 delete mode 100644 arch/um/drivers/mmapper_kern.c

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 49781bee7905..0b4d00596a8c 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -200,12 +200,6 @@ config KERNEL_STACK_ORDER
 	  increase in the size of the state which needs to be saved when handling
 	  signals.
 
-config MMAPPER
-	tristate "iomem emulation driver"
-	help
-	  This driver allows a host file to be used as emulated IO memory inside
-	  UML.
-
 config PGTABLE_LEVELS
 	int
 	default 4 if 64BIT
diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index 6bf8cbf71d3c..36dc57840084 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -29,7 +29,6 @@ obj-$(CONFIG_STDERR_CONSOLE) += stderr_console.o
 
 obj-$(CONFIG_UML_NET_VECTOR) += vector.o
 obj-$(CONFIG_MCONSOLE) += mconsole.o
-obj-$(CONFIG_MMAPPER) += mmapper_kern.o 
 obj-$(CONFIG_BLK_DEV_UBD) += ubd.o 
 obj-$(CONFIG_UML_SOUND) += hostaudio.o
 obj-$(CONFIG_NULL_CHAN) += null.o 
diff --git a/arch/um/drivers/mmapper_kern.c b/arch/um/drivers/mmapper_kern.c
deleted file mode 100644
index 807cd3358740..000000000000
--- a/arch/um/drivers/mmapper_kern.c
+++ /dev/null
@@ -1,135 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * arch/um/drivers/mmapper_kern.c
- *
- * BRIEF MODULE DESCRIPTION
- *
- * Copyright (C) 2000 RidgeRun, Inc.
- * Author: RidgeRun, Inc.
- *         Greg Lonnon glonnon@ridgerun.com or info@ridgerun.com
- *
- */
-
-#include <linux/stddef.h>
-#include <linux/types.h>
-#include <linux/fs.h>
-#include <linux/init.h>
-#include <linux/miscdevice.h>
-#include <linux/module.h>
-#include <linux/mm.h>
-
-#include <linux/uaccess.h>
-#include <mem_user.h>
-
-/* These are set in mmapper_init, which is called at boot time */
-static unsigned long mmapper_size;
-static unsigned long p_buf;
-static char *v_buf;
-
-static ssize_t mmapper_read(struct file *file, char __user *buf, size_t count,
-			    loff_t *ppos)
-{
-	return simple_read_from_buffer(buf, count, ppos, v_buf, mmapper_size);
-}
-
-static ssize_t mmapper_write(struct file *file, const char __user *buf,
-			     size_t count, loff_t *ppos)
-{
-	if (*ppos > mmapper_size)
-		return -EINVAL;
-
-	return simple_write_to_buffer(v_buf, mmapper_size, ppos, buf, count);
-}
-
-static long mmapper_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	return -ENOIOCTLCMD;
-}
-
-static int mmapper_mmap(struct file *file, struct vm_area_struct *vma)
-{
-	int ret = -EINVAL;
-	int size;
-
-	if (vma->vm_pgoff != 0)
-		goto out;
-
-	size = vma->vm_end - vma->vm_start;
-	if (size > mmapper_size)
-		return -EFAULT;
-
-	/*
-	 * XXX A comment above remap_pfn_range says it should only be
-	 * called when the mm semaphore is held
-	 */
-	if (remap_pfn_range(vma, vma->vm_start, p_buf >> PAGE_SHIFT, size,
-			    vma->vm_page_prot))
-		goto out;
-	ret = 0;
-out:
-	return ret;
-}
-
-static int mmapper_open(struct inode *inode, struct file *file)
-{
-	return 0;
-}
-
-static int mmapper_release(struct inode *inode, struct file *file)
-{
-	return 0;
-}
-
-static const struct file_operations mmapper_fops = {
-	.owner		= THIS_MODULE,
-	.read		= mmapper_read,
-	.write		= mmapper_write,
-	.unlocked_ioctl	= mmapper_ioctl,
-	.mmap		= mmapper_mmap,
-	.open		= mmapper_open,
-	.release	= mmapper_release,
-	.llseek		= default_llseek,
-};
-
-/*
- * No locking needed - only used (and modified) by below initcall and exitcall.
- */
-static struct miscdevice mmapper_dev = {
-	.minor		= MISC_DYNAMIC_MINOR,
-	.name		= "mmapper",
-	.fops		= &mmapper_fops
-};
-
-static int __init mmapper_init(void)
-{
-	int err;
-
-	printk(KERN_INFO "Mapper v0.1\n");
-
-	v_buf = (char *) find_iomem("mmapper", &mmapper_size);
-	if (mmapper_size == 0) {
-		printk(KERN_ERR "mmapper_init - find_iomem failed\n");
-		return -ENODEV;
-	}
-	p_buf = __pa(v_buf);
-
-	err = misc_register(&mmapper_dev);
-	if (err) {
-		printk(KERN_ERR "mmapper - misc_register failed, err = %d\n",
-		       err);
-		return err;
-	}
-	return 0;
-}
-
-static void __exit mmapper_exit(void)
-{
-	misc_deregister(&mmapper_dev);
-}
-
-module_init(mmapper_init);
-module_exit(mmapper_exit);
-
-MODULE_AUTHOR("Greg Lonnon <glonnon@ridgerun.com>");
-MODULE_DESCRIPTION("DSPLinux simulator mmapper driver");
-MODULE_LICENSE("GPL");
diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 24fdea6f88c3..6ca7583003cd 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -45,10 +45,10 @@ extern unsigned long *empty_zero_page;
  * area for the same reason. ;)
  */
 
-extern unsigned long end_iomem;
+#include <as-layout.h> /* for high_physmem */
 
 #define VMALLOC_OFFSET	(__va_space)
-#define VMALLOC_START ((end_iomem + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1))
+#define VMALLOC_START	((high_physmem + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1))
 #define VMALLOC_END	(TASK_SIZE-2*PAGE_SIZE)
 #define MODULES_VADDR	VMALLOC_START
 #define MODULES_END	VMALLOC_END
diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index 949a03c7861e..3ca589f3cd97 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -39,7 +39,6 @@ extern void uml_pm_wake(void);
 
 extern int start_uml(void);
 extern void paging_init(void);
-extern int parse_iomem(char *str, int *add);
 
 extern void uml_cleanup(void);
 extern void do_uml_exitcalls(void);
diff --git a/arch/um/include/shared/mem_user.h b/arch/um/include/shared/mem_user.h
index d4727efcf23d..8a5b72872ff8 100644
--- a/arch/um/include/shared/mem_user.h
+++ b/arch/um/include/shared/mem_user.h
@@ -32,21 +32,8 @@
 #ifndef _MEM_USER_H
 #define _MEM_USER_H
 
-struct iomem_region {
-	struct iomem_region *next;
-	char *driver;
-	int fd;
-	int size;
-	unsigned long phys;
-	unsigned long virt;
-};
-
-extern struct iomem_region *iomem_regions;
-extern int iomem_size;
-
 #define ROUND_4M(n) ((((unsigned long) (n)) + (1 << 22)) & ~((1 << 22) - 1))
 
-extern unsigned long find_iomem(char *driver, unsigned long *len_out);
 extern void setup_physmem(unsigned long start, unsigned long usable,
 			  unsigned long len);
 extern void map_memory(unsigned long virt, unsigned long phys,
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 19d40b58eac4..dc938715ec9d 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -197,7 +197,7 @@ void __init paging_init(void)
 		panic("%s: Failed to allocate %lu bytes align=%lx\n",
 		      __func__, PAGE_SIZE, PAGE_SIZE);
 
-	max_zone_pfn[ZONE_NORMAL] = end_iomem >> PAGE_SHIFT;
+	max_zone_pfn[ZONE_NORMAL] = high_physmem >> PAGE_SHIFT;
 	free_area_init(max_zone_pfn);
 
 #if IS_ENABLED(CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA)
diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index af02b5f9911d..ae6ca373c261 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -105,19 +105,6 @@ int phys_mapping(unsigned long phys, unsigned long long *offset_out)
 		fd = physmem_fd;
 		*offset_out = phys;
 	}
-	else if (phys < __pa(end_iomem)) {
-		struct iomem_region *region = iomem_regions;
-
-		while (region != NULL) {
-			if ((phys >= region->phys) &&
-			    (phys < region->phys + region->size)) {
-				fd = region->fd;
-				*offset_out = phys - region->phys;
-				break;
-			}
-			region = region->next;
-		}
-	}
 
 	return fd;
 }
@@ -140,61 +127,3 @@ __uml_setup("mem=", uml_mem_setup,
 "    be more, and the excess, if it's ever used, will just be swapped out.\n"
 "	Example: mem=64M\n\n"
 );
-
-__uml_setup("iomem=", parse_iomem,
-"iomem=<name>,<file>\n"
-"    Configure <file> as an IO memory region named <name>.\n\n"
-);
-
-/*
- * This list is constructed in parse_iomem and addresses filled in
- * setup_iomem, both of which run during early boot.  Afterwards, it's
- * unchanged.
- */
-struct iomem_region *iomem_regions;
-
-/* Initialized in parse_iomem and unchanged thereafter */
-int iomem_size;
-
-unsigned long find_iomem(char *driver, unsigned long *len_out)
-{
-	struct iomem_region *region = iomem_regions;
-
-	while (region != NULL) {
-		if (!strcmp(region->driver, driver)) {
-			*len_out = region->size;
-			return region->virt;
-		}
-
-		region = region->next;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(find_iomem);
-
-static int setup_iomem(void)
-{
-	struct iomem_region *region = iomem_regions;
-	unsigned long iomem_start = high_physmem + PAGE_SIZE;
-	int err;
-
-	while (region != NULL) {
-		err = os_map_memory((void *) iomem_start, region->fd, 0,
-				    region->size, 1, 1, 0);
-		if (err)
-			printk(KERN_ERR "Mapping iomem region for driver '%s' "
-			       "failed, errno = %d\n", region->driver, -err);
-		else {
-			region->virt = iomem_start;
-			region->phys = __pa(region->virt);
-		}
-
-		iomem_start += region->size + PAGE_SIZE;
-		region = region->next;
-	}
-
-	return 0;
-}
-
-__initcall(setup_iomem);
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index fa11528ba617..e86a5cbdc139 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -257,8 +257,6 @@ EXPORT_SYMBOL(task_size);
 unsigned long host_task_size;
 
 unsigned long brk_start;
-unsigned long end_iomem;
-EXPORT_SYMBOL(end_iomem);
 
 #define MIN_VMALLOC (32 * 1024 * 1024)
 
@@ -366,9 +364,7 @@ int __init linux_main(int argc, char **argv, char **envp)
 	setup_machinename(init_utsname()->machine);
 
 	physmem_size = PAGE_ALIGN(physmem_size);
-	iomem_size = PAGE_ALIGN(iomem_size);
-
-	max_physmem = TASK_SIZE - uml_physmem - iomem_size - MIN_VMALLOC;
+	max_physmem = TASK_SIZE - uml_physmem - MIN_VMALLOC;
 	if (physmem_size > max_physmem) {
 		physmem_size = max_physmem;
 		os_info("Physical memory size shrunk to %llu bytes\n",
@@ -376,7 +372,6 @@ int __init linux_main(int argc, char **argv, char **envp)
 	}
 
 	high_physmem = uml_physmem + physmem_size;
-	end_iomem = high_physmem + iomem_size;
 
 	start_vm = VMALLOC_START;
 
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 0bc10cd4cbed..820846ff7179 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -298,7 +298,6 @@ static int userspace_tramp(void *data)
 		.seccomp = using_seccomp,
 		.stub_start = STUB_START,
 	};
-	struct iomem_region *iomem;
 	int ret;
 
 	if (using_seccomp) {
@@ -332,12 +331,6 @@ static int userspace_tramp(void *data)
 
 	fcntl(init_data.stub_data_fd, F_SETFD, 0);
 
-	/* In SECCOMP mode, these FDs are passed when needed */
-	if (!using_seccomp) {
-		for (iomem = iomem_regions; iomem; iomem = iomem->next)
-			fcntl(iomem->fd, F_SETFD, 0);
-	}
-
 	/* dup2 signaling FD/socket to STDIN */
 	if (dup2(tramp_data->sockpair[0], 0) < 0)
 		exit(3);
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index a827c2e01aa5..8b19dca83f71 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -489,53 +489,3 @@ void __init os_early_checks(void)
 		fatal("Failed to initialize default registers");
 	stop_ptraced_child(pid, 1);
 }
-
-int __init parse_iomem(char *str, int *add)
-{
-	struct iomem_region *new;
-	struct stat64 buf;
-	char *file, *driver;
-	int fd, size;
-
-	driver = str;
-	file = strchr(str,',');
-	if (file == NULL) {
-		os_warn("parse_iomem : failed to parse iomem\n");
-		goto out;
-	}
-	*file = '\0';
-	file++;
-	fd = open(file, O_RDWR, 0);
-	if (fd < 0) {
-		perror("parse_iomem - Couldn't open io file");
-		goto out;
-	}
-
-	if (fstat64(fd, &buf) < 0) {
-		perror("parse_iomem - cannot stat_fd file");
-		goto out_close;
-	}
-
-	new = malloc(sizeof(*new));
-	if (new == NULL) {
-		perror("Couldn't allocate iomem_region struct");
-		goto out_close;
-	}
-
-	size = (buf.st_size + UM_KERN_PAGE_SIZE) & ~(UM_KERN_PAGE_SIZE - 1);
-
-	*new = ((struct iomem_region) { .next		= iomem_regions,
-					.driver		= driver,
-					.fd		= fd,
-					.size		= size,
-					.phys		= 0,
-					.virt		= 0 });
-	iomem_regions = new;
-	iomem_size += new->size + UM_KERN_PAGE_SIZE;
-
-	return 0;
- out_close:
-	close(fd);
- out:
-	return 1;
-}
-- 
2.34.1


