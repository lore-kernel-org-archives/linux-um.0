Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iN8kl-00025F-OB
 for linux-um@lists.infradead.org; Wed, 23 Oct 2019 05:00:19 +0000
Received: by mail-pf1-x442.google.com with SMTP id q21so12098697pfn.11
 for <linux-um@lists.infradead.org>; Tue, 22 Oct 2019 22:00:11 -0700 (PDT)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC PATCH 46/47] um: use lkl virtio_net_tap device as UML device
Date: Wed, 23 Oct 2019 13:38:20 +0900
Message-Id: <0496cb2872ada0c05cc7a39bc8f2677d49b0623f.1571798507.git.thehajime@gmail.com>
In-Reply-To: <cover.1571798507.git.thehajime@gmail.com>
References: <cover.1571798507.git.thehajime@gmail.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: Octavian Purdila <tavi.purdila@gmail.com>, Hajime Tazaki <thehajime@gmail.com>, Akira Moroo <retrage01@gmail.com>

This also expands supporting virtio-mmio driver, which involves multiple
addition to Kconfig as well.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 .circleci/config.yml             |   2 +-
 arch/um/Kconfig                  |   6 --
 arch/um/Makefile.um              |   4 +
 arch/um/configs/x86_64_defconfig |   5 ++
 arch/um/include/asm/Kbuild       |   1 +
 arch/um/include/asm/io.h         |   4 +
 arch/um/os-Linux/Makefile        |   5 ++
 arch/um/os-Linux/lkl_dev.c       | 134 +++++++++++++++++++++++++++++++
 arch/x86/um/syscalls_64.c        |  53 ++++++++++++
 tools/lkl/lib/Makefile           |  32 ++++++++
 tools/lkl/lib/virtio.c           |  17 +++-
 tools/lkl/lib/virtio.h           |  22 +++++
 tools/lkl/lib/virtio_net.c       |  23 +++++-
 tools/lkl/lib/virtio_net_fd.c    |  22 -----
 tools/lkl/lib/virtio_net_fd.h    |  22 +++++
 15 files changed, 320 insertions(+), 32 deletions(-)
 create mode 100644 arch/um/os-Linux/lkl_dev.c
 create mode 100644 tools/lkl/lib/Makefile

diff --git a/.circleci/config.yml b/.circleci/config.yml
index 7d140d9a2acb..cec55ad93dc6 100644
--- a/.circleci/config.yml
+++ b/.circleci/config.yml
@@ -135,7 +135,7 @@ do_uml_steps: &do_uml_steps
   - run:
       name: test
       command: |
-        ./linux rootfstype=hostfs ro mem=1g loglevel=10 init="/bin/bash -c exit" || export RETVAL=$?
+        ./linux rootfstype=hostfs ro mem=1g loglevel=10 veth0=tap,tap0,0xc803 init="/bin/bash -c exit" || export RETVAL=$?
         # SIGABRT=6 => 128+6
         if [ $RETVAL != "134" ]; then
           exit 1
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index d7e9af63cf8f..a32dd84f0bf2 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -23,9 +23,6 @@ config MMU
 	bool
 	default y if !UML_LKL
 
-config NO_IOMEM
-	def_bool y
-
 config ISA
 	bool
 
@@ -160,9 +157,6 @@ config MMAPPER
 	  This driver allows a host file to be used as emulated IO memory inside
 	  UML.
 
-config NO_DMA
-	def_bool y
-
 config PGTABLE_LEVELS
 	int
 	default 3 if 3_LEVEL_PGTABLES
diff --git a/arch/um/Makefile.um b/arch/um/Makefile.um
index 24a088e5df04..65cfc4393e3d 100644
--- a/arch/um/Makefile.um
+++ b/arch/um/Makefile.um
@@ -11,6 +11,8 @@ core-y			+= $(ARCH_DIR)/kernel/		\
 			 $(ARCH_DIR)/drivers/		\
 			 $(ARCH_DIR)/os-$(OS)/
 
+core-y			+= $(srctree)/tools/lkl/lib/
+
 ifdef CONFIG_64BIT
 	KBUILD_CFLAGS += -mcmodel=large
 endif
@@ -52,6 +54,8 @@ KBUILD_CPPFLAGS += -I$(srctree)/$(HOST_DIR)/include \
 		   -I$(objtree)/$(HOST_DIR)/include/generated \
 		   -I$(objtree)/$(HOST_DIR)/include/generated/uapi
 
+KBUILD_CPPFLAGS += -I$(srctree)/$(ARCH_DIR)/lkl/include -I$(srctree)/$(ARCH_DIR)/
+
 # -Derrno=kernel_errno - This turns all kernel references to errno into
 # kernel_errno to separate them from the libc errno.  This allows -fno-common
 # in KBUILD_CFLAGS.  Otherwise, it would cause ld to complain about the two different
diff --git a/arch/um/configs/x86_64_defconfig b/arch/um/configs/x86_64_defconfig
index 3281d7600225..917982b6cd60 100644
--- a/arch/um/configs/x86_64_defconfig
+++ b/arch/um/configs/x86_64_defconfig
@@ -70,3 +70,8 @@ CONFIG_NLS=y
 CONFIG_DEBUG_INFO=y
 CONFIG_FRAME_WARN=1024
 CONFIG_DEBUG_KERNEL=y
+CONFIG_VIRTIO=y
+CONFIG_VIRTIO_MENU=y
+CONFIG_VIRTIO_MMIO=y
+CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
+CONFIG_VIRTIO_NET=y
diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index 6c2aa280f1d9..54037cdb320e 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -5,6 +5,7 @@ generic-y += compat.h
 generic-y += current.h
 generic-y += delay.h
 generic-y += device.h
+generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += extable.h
diff --git a/arch/um/include/asm/io.h b/arch/um/include/asm/io.h
index 96f77b5232aa..f23700d3c071 100644
--- a/arch/um/include/asm/io.h
+++ b/arch/um/include/asm/io.h
@@ -2,11 +2,15 @@
 #ifndef _ASM_UM_IO_H
 #define _ASM_UM_IO_H
 
+#ifndef CONFIG_HAS_IOMEM
 #define ioremap ioremap
 static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
 {
 	return (void __iomem *)(unsigned long)offset;
 }
+#else
+#include <lkl/include/asm/io.h>
+#endif
 
 #define iounmap iounmap
 static inline void iounmap(void __iomem *addr)
diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
index 839915b8c31c..d90d88a2f34e 100644
--- a/arch/um/os-Linux/Makefile
+++ b/arch/um/os-Linux/Makefile
@@ -11,9 +11,14 @@ obj-y = execvp.o file.o helper.o irq.o main.o mem.o process.o \
 	umid.o user_syms.o util.o drivers/ skas/
 
 obj-$(CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA) += elf_aux.o
+obj-y += lkl_dev.o
+
+CFLAGS_lkl_dev.o:=-I$(srctree)/tools/lkl/include -Wno-undef
 
 USER_OBJS := $(user-objs-y) elf_aux.o execvp.o file.o helper.o irq.o \
 	main.o mem.o process.o registers.o sigio.o signal.o start_up.o time.o \
 	tty.o umid.o util.o
 
+USER_OBJS += lkl_dev.o
+
 include arch/um/scripts/Makefile.rules
diff --git a/arch/um/os-Linux/lkl_dev.c b/arch/um/os-Linux/lkl_dev.c
new file mode 100644
index 000000000000..698062917ed5
--- /dev/null
+++ b/arch/um/os-Linux/lkl_dev.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdlib.h>
+#include <string.h>
+#include <init.h>
+#include <os.h>
+#include <kern_util.h>
+#include <errno.h>
+
+#include <lkl.h>
+#include <lkl_host.h>
+
+extern struct lkl_host_operations lkl_host_ops;
+struct lkl_host_operations *lkl_ops = &lkl_host_ops;
+
+static struct lkl_netdev *nd;
+
+int __init uml_netdev_prepare(char *iftype, char *ifparams, char *ifoffload)
+{
+	int offload = 0;
+
+	if (ifoffload)
+		offload = strtol(ifoffload, NULL, 0);
+
+	if ((strcmp(iftype, "tap") == 0)) {
+		nd = lkl_netdev_tap_create(ifparams, offload);
+#ifdef notyet
+	} else if ((strcmp(iftype, "macvtap") == 0)) {
+		nd = lkl_netdev_macvtap_create(ifparams, offload);
+#endif
+	} else {
+		if (offload) {
+			lkl_printf("WARN: %s isn't supported on %s\n",
+				   "LKL_HIJACK_OFFLOAD",
+				   iftype);
+			lkl_printf(
+				"WARN: Disabling offload features.\n");
+		}
+		offload = 0;
+	}
+#ifdef notyet
+	if (strcmp(iftype, "raw") == 0)
+		nd = lkl_netdev_raw_create(ifparams);
+#endif
+
+	return 0;
+}
+
+
+int __init uml_netdev_add(void)
+{
+	if (nd)
+		lkl_netdev_add(nd, NULL);
+
+	return 0;
+}
+__initcall(uml_netdev_add);
+
+static int __init lkl_eth_setup(char *str, int *niu)
+{
+	char *end, *iftype, *ifparams, *ifoffload;
+	int devid, err = -EINVAL;
+
+	/* veth */
+	devid = strtoul(str, &end, 0);
+	if (end == str) {
+		os_warn("Bad device number\n");
+		return err;
+	}
+
+	/* = */
+	str = end;
+	if (*str != '=') {
+		os_warn("Expected '=' after device number\n");
+		return err;
+	}
+	str++;
+
+	/* <iftype> */
+	iftype = str;
+
+	/* <ifparams> */
+	ifparams = strchr(str, ',');
+	if (ifparams == NULL) {
+		os_warn("failed to parse ifparams\n");
+		return -1;
+	}
+	*ifparams = '\0';
+	ifparams++;
+
+	str = ifparams;
+	/* <offload> */
+	ifoffload = strchr(str, ',');
+	*ifoffload = '\0';
+	ifoffload++;
+
+	os_info("str=%s, iftype=%s, ifparams=%s, offload=%s\n",
+		str, iftype, ifparams, ifoffload);
+
+	/* preparation */
+	uml_netdev_prepare(iftype, ifparams, ifoffload);
+
+	return 1;
+}
+
+__uml_setup("veth", lkl_eth_setup,
+"veth[0-9]+=<iftype>,<ifparams>,<offload>\n"
+"    Configure a network device.\n\n"
+);
+
+/* stub functions */
+int lkl_is_running(void)
+{
+	return 1;
+}
+
+
+void lkl_put_irq(int i, const char *user)
+{
+}
+
+/* XXX */
+static int free_irqs[2] = {5, 13};
+int lkl_get_free_irq(const char *user)
+{
+	static int irq_idx;
+	return free_irqs[irq_idx++];
+}
+
+int lkl_trigger_irq(int irq)
+{
+	do_IRQ(irq, NULL);
+	return 0;
+}
diff --git a/arch/x86/um/syscalls_64.c b/arch/x86/um/syscalls_64.c
index 58f51667e2e4..e70dc7f76b19 100644
--- a/arch/x86/um/syscalls_64.c
+++ b/arch/x86/um/syscalls_64.c
@@ -9,6 +9,7 @@
 #include <linux/sched/mm.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
+#include <linux/platform_device.h>
 #include <asm/prctl.h> /* XXX This should get the constants from libc */
 #include <os.h>
 
@@ -87,3 +88,55 @@ void arch_switch_to(struct task_struct *to)
 
 	arch_prctl(to, ARCH_SET_FS, (void __user *) to->thread.arch.fs);
 }
+
+SYSCALL_DEFINE3(virtio_mmio_device_add, long, base, long, size, unsigned int,
+		irq)
+{
+	struct platform_device *pdev;
+	int ret;
+
+	struct resource res[] = {
+		[0] = {
+		       .start = base,
+		       .end = base + size - 1,
+		       .flags = IORESOURCE_MEM,
+		       },
+		[1] = {
+		       .start = irq,
+		       .end = irq,
+		       .flags = IORESOURCE_IRQ,
+		       },
+	};
+
+	pdev = platform_device_alloc("virtio-mmio", PLATFORM_DEVID_AUTO);
+	if (!pdev) {
+		dev_err(&pdev->dev,
+			"%s: Unable to device alloc for virtio-mmio\n",
+			__func__);
+		return -ENOMEM;
+	}
+
+	ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
+	if (ret) {
+		dev_err(&pdev->dev,
+			"%s: Unable to add resources for %s%d\n", __func__,
+			pdev->name, pdev->id);
+		goto exit_device_put;
+	}
+
+	ret = platform_device_add(pdev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "%s: Unable to add %s%d\n", __func__,
+			pdev->name, pdev->id);
+		goto exit_release_pdev;
+	}
+
+	return pdev->id;
+
+exit_release_pdev:
+	platform_device_del(pdev);
+exit_device_put:
+	platform_device_put(pdev);
+
+	return ret;
+}
diff --git a/tools/lkl/lib/Makefile b/tools/lkl/lib/Makefile
new file mode 100644
index 000000000000..8dc0009c680e
--- /dev/null
+++ b/tools/lkl/lib/Makefile
@@ -0,0 +1,32 @@
+
+USER_CFLAGS += -I$(srctree)/tools/lkl/include \
+		-Wno-strict-prototypes -Wno-undef \
+		-Wframe-larger-than=20480 -O0 -g
+
+USER_OBJS += fs.o iomem.o net.o jmp_buf.o virtio.o virtio_net.o \
+	 virtio_net_fd.o virtio_net_tap.o utils.o posix-host.o \
+	../../perf/pmu-events/jsmn.o
+
+#obj-y += fs.o
+obj-y += iomem.o
+#obj-y += net.o
+obj-y += jmp_buf.o
+obj-y += posix-host.o
+#obj-$(LKL_HOST_CONFIG_NT) += nt-host.o
+obj-y += utils.o
+#obj-y += virtio_blk.o
+obj-y += virtio.o
+#obj-y += dbg.o
+#obj-y += dbg_handler.o
+obj-y += virtio_net.o
+obj-y += virtio_net_fd.o
+obj-y += virtio_net_tap.o
+#obj-$(LKL_HOST_CONFIG_VIRTIO_NET) += virtio_net_raw.o
+#obj-$(LKL_HOST_CONFIG_VIRTIO_NET_MACVTAP) += virtio_net_macvtap.o
+#obj-$(LKL_HOST_CONFIG_VIRTIO_NET_DPDK) += virtio_net_dpdk.o
+#obj-$(LKL_HOST_CONFIG_VIRTIO_NET_VDE) += virtio_net_vde.o
+#obj-$(LKL_HOST_CONFIG_VIRTIO_NET) += virtio_net_pipe.o
+obj-y += ../../perf/pmu-events/jsmn.o
+#obj-y += config.o
+
+include arch/um/scripts/Makefile.rules
diff --git a/tools/lkl/lib/virtio.c b/tools/lkl/lib/virtio.c
index 4b3dbba607c3..98539e270320 100644
--- a/tools/lkl/lib/virtio.c
+++ b/tools/lkl/lib/virtio.c
@@ -46,6 +46,12 @@
 		lkl_host_ops.panic();					\
 	} while (0)
 
+#ifdef __arch_um__
+extern unsigned long uml_physmem;
+#else
+static unsigned long uml_physmem;
+#endif
+
 struct virtio_queue {
 	uint32_t num_max;
 	uint32_t num;
@@ -216,7 +222,8 @@ static void add_dev_buf_from_vring_desc(struct virtio_req *req,
 {
 	struct iovec *buf = &req->buf[req->buf_count++];
 
-	buf->iov_base = (void *)(uintptr_t)le64toh(vring_desc->addr);
+	buf->iov_base = (void *)(uintptr_t)le64toh(vring_desc->addr)
+		+ uml_physmem;
 	buf->iov_len = le32toh(vring_desc->len);
 
 	if (!(buf->iov_base && buf->iov_len))
@@ -304,8 +311,10 @@ void virtio_process_queue(struct virtio_dev *dev, uint32_t qidx)
 	if (!q->ready)
 		return;
 
+#ifndef __arch_um__
 	if (dev->ops->acquire_queue)
 		dev->ops->acquire_queue(dev, qidx);
+#endif
 
 	while (q->last_avail_idx != le16toh(q->avail->idx)) {
 		/*
@@ -319,8 +328,10 @@ void virtio_process_queue(struct virtio_dev *dev, uint32_t qidx)
 			virtio_set_avail_event(q, q->avail->idx);
 	}
 
+#ifndef __arch_um__
 	if (dev->ops->release_queue)
 		dev->ops->release_queue(dev, qidx);
+#endif
 }
 
 static inline uint32_t virtio_read_device_features(struct virtio_dev *dev)
@@ -406,7 +417,7 @@ static inline void set_ptr_low(void **ptr, uint32_t val)
 	uint64_t tmp = (uintptr_t)*ptr;
 
 	tmp = (tmp & 0xFFFFFFFF00000000) | val;
-	*ptr = (void *)(long)tmp;
+	*ptr = (void *)(long)tmp + uml_physmem;
 }
 
 static inline void set_ptr_high(void **ptr, uint32_t val)
@@ -579,6 +590,7 @@ int virtio_dev_setup(struct virtio_dev *dev, int queues, int num_max)
 
 int virtio_dev_cleanup(struct virtio_dev *dev)
 {
+#ifndef __arch_um__
 	char devname[100];
 	long fd, ret;
 	long mount_ret;
@@ -622,6 +634,7 @@ int virtio_dev_cleanup(struct virtio_dev *dev)
 	lkl_put_irq(dev->irq, "virtio");
 	unregister_iomem(dev->base);
 	lkl_host_ops.mem_free(dev->queue);
+#endif
 	return 0;
 }
 
diff --git a/tools/lkl/lib/virtio.h b/tools/lkl/lib/virtio.h
index 7427aa8fad79..be06ef09f8b0 100644
--- a/tools/lkl/lib/virtio.h
+++ b/tools/lkl/lib/virtio.h
@@ -87,6 +87,28 @@ void virtio_req_complete(struct virtio_req *req, uint32_t len);
 void virtio_process_queue(struct virtio_dev *dev, uint32_t qidx);
 void virtio_set_queue_max_merge_len(struct virtio_dev *dev, int q, int len);
 
+#ifdef __arch_um__
+//#include <irq_kern.h>
+#include <irq_user.h>
+enum irqreturn {
+	IRQ_HANDLED		= (1 << 0),
+	IRQ_WAKE_THREAD		= (1 << 1),
+};
+
+typedef enum irqreturn irqreturn_t;
+typedef irqreturn_t (*irq_handler_t)(int, void *);
+
+#define IRQF_SHARED		0x00000080
+
+extern int um_request_irq(unsigned int irq, int fd, int type,
+			  irq_handler_t handler,
+			  unsigned long irqflags,  const char *devname,
+			  void *dev_id);
+
+long sys_virtio_mmio_device_add(long base, long size, unsigned int irq);
+#define lkl_sys_virtio_mmio_device_add sys_virtio_mmio_device_add
+#endif /* __arch_um__ */
+
 #define container_of(ptr, type, member) \
 	(type *)((char *)(ptr) - __builtin_offsetof(type, member))
 
diff --git a/tools/lkl/lib/virtio_net.c b/tools/lkl/lib/virtio_net.c
index 60743109215b..224d7bf50702 100644
--- a/tools/lkl/lib/virtio_net.c
+++ b/tools/lkl/lib/virtio_net.c
@@ -2,6 +2,7 @@
 #include <string.h>
 #include <lkl_host.h>
 #include "virtio.h"
+#include "virtio_net_fd.h"
 #include "endian.h"
 
 #include <lkl/linux/virtio_net.h>
@@ -211,9 +212,21 @@ static struct lkl_mutex **init_queue_locks(int num_queues)
 	return ret;
 }
 
+#ifdef __arch_um__
+static irqreturn_t um_virtio_intr(int irq, void *dev_id)
+{
+	struct virtio_dev *dev = dev_id;
+
+	virtio_process_queue(dev, 0);
+	return 0;
+}
+#endif
+
 int lkl_netdev_add(struct lkl_netdev *nd, struct lkl_netdev_args *args)
 {
 	struct virtio_net_dev *dev;
+	struct lkl_netdev_fd *nd_fd =
+		container_of(nd, struct lkl_netdev_fd, dev);
 	int ret = -LKL_ENOMEM;
 
 	dev = lkl_host_ops.mem_alloc(sizeof(*dev));
@@ -251,16 +264,22 @@ int lkl_netdev_add(struct lkl_netdev *nd, struct lkl_netdev_args *args)
 	if (ret)
 		goto out_free;
 
+#ifdef __arch_um__
+	um_request_irq(dev->dev.irq, nd_fd->fd_rx, IRQ_READ, um_virtio_intr,
+		       IRQF_SHARED, "virtio", dev);
+#endif
+
 	/*
 	 * We may receive upto 64KB TSO packet so collect as many descriptors as
 	 * there are available up to 64KB in total len.
 	 */
 	if (dev->dev.device_features & BIT(LKL_VIRTIO_NET_F_MRG_RXBUF))
 		virtio_set_queue_max_merge_len(&dev->dev, RX_QUEUE_IDX, 65536);
-
+#ifndef __arch_um__
 	dev->poll_tid = lkl_host_ops.thread_create(poll_thread, dev);
 	if (dev->poll_tid == 0)
 		goto out_cleanup_dev;
+#endif
 
 	ret = dev_register(dev);
 	if (ret < 0)
@@ -279,6 +298,7 @@ int lkl_netdev_add(struct lkl_netdev *nd, struct lkl_netdev_args *args)
 	return ret;
 }
 
+#ifndef __arch_um__
 /* Return 0 for success, -1 for failure. */
 void lkl_netdev_remove(int id)
 {
@@ -314,6 +334,7 @@ void lkl_netdev_remove(int id)
 	free_queue_locks(dev->queue_locks, NUM_QUEUES);
 	lkl_host_ops.mem_free(dev);
 }
+#endif
 
 void lkl_netdev_free(struct lkl_netdev *nd)
 {
diff --git a/tools/lkl/lib/virtio_net_fd.c b/tools/lkl/lib/virtio_net_fd.c
index f8664455e696..a19193cfeca9 100644
--- a/tools/lkl/lib/virtio_net_fd.c
+++ b/tools/lkl/lib/virtio_net_fd.c
@@ -25,28 +25,6 @@
 #include "virtio.h"
 #include "virtio_net_fd.h"
 
-struct lkl_netdev_fd {
-	struct lkl_netdev dev;
-	/* file-descriptor based device */
-	int fd_rx;
-	int fd_tx;
-	/*
-	 * Controlls the poll mask for fd. Can be acccessed concurrently from
-	 * poll, tx, or rx routines but there is no need for syncronization
-	 * because:
-	 *
-	 * (a) TX and RX routines set different variables so even if they update
-	 * at the same time there is no race condition
-	 *
-	 * (b) Even if poll and TX / RX update at the same time poll cannot
-	 * stall: when poll resets the poll variable we know that TX / RX will
-	 * run which means that eventually the poll variable will be set.
-	 */
-	int poll_tx, poll_rx;
-	/* controle pipe */
-	int pipe[2];
-};
-
 static int fd_net_tx(struct lkl_netdev *nd, struct iovec *iov, int cnt)
 {
 	int ret;
diff --git a/tools/lkl/lib/virtio_net_fd.h b/tools/lkl/lib/virtio_net_fd.h
index 713ba13cca7c..fe6d6d8e3ab4 100644
--- a/tools/lkl/lib/virtio_net_fd.h
+++ b/tools/lkl/lib/virtio_net_fd.h
@@ -4,6 +4,28 @@
 
 struct ifreq;
 
+struct lkl_netdev_fd {
+	struct lkl_netdev dev;
+	/* file-descriptor based device */
+	int fd_rx;
+	int fd_tx;
+	/*
+	 * Controlls the poll mask for fd. Can be acccessed concurrently from
+	 * poll, tx, or rx routines but there is no need for syncronization
+	 * because:
+	 *
+	 * (a) TX and RX routines set different variables so even if they update
+	 * at the same time there is no race condition
+	 *
+	 * (b) Even if poll and TX / RX update at the same time poll cannot
+	 * stall: when poll resets the poll variable we know that TX / RX will
+	 * run which means that eventually the poll variable will be set.
+	 */
+	int poll_tx, poll_rx;
+	/* controle pipe */
+	int pipe[2];
+};
+
 /**
  * lkl_register_netdev_linux_fdnet - register a file descriptor-based network
  * device as a NIC
-- 
2.20.1 (Apple Git-117)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

