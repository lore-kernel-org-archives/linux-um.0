Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iN8km-00027z-9W
 for linux-um@lists.infradead.org; Wed, 23 Oct 2019 05:00:18 +0000
Received: by mail-pf1-x441.google.com with SMTP id b128so12136770pfa.1
 for <linux-um@lists.infradead.org>; Tue, 22 Oct 2019 22:00:12 -0700 (PDT)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC PATCH 47/47] um: add lkl virtio-blk device
Date: Wed, 23 Oct 2019 13:38:21 +0900
Message-Id: <d380ec02dd0cd97afe08706093b59329e6b09fe2.1571798507.git.thehajime@gmail.com>
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

Now uml can use a virtio-blk device via 'vubd0=<filename>' over
virtio-mmio driver.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 .circleci/config.yml             |  4 ++-
 arch/um/configs/x86_64_defconfig |  1 +
 arch/um/os-Linux/lkl_dev.c       | 56 +++++++++++++++++++++++++++++++-
 tools/lkl/lib/Makefile           |  6 ++--
 4 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/.circleci/config.yml b/.circleci/config.yml
index cec55ad93dc6..266ed58b6fd7 100644
--- a/.circleci/config.yml
+++ b/.circleci/config.yml
@@ -135,7 +135,9 @@ do_uml_steps: &do_uml_steps
   - run:
       name: test
       command: |
-        ./linux rootfstype=hostfs ro mem=1g loglevel=10 veth0=tap,tap0,0xc803 init="/bin/bash -c exit" || export RETVAL=$?
+        dd if=/dev/zero of=disk.img bs=1024 count=20480
+        mkfs.ext4 disk.img
+        ./linux rootfstype=hostfs ro mem=1g loglevel=10 veth0=tap,tap0,0xc803 vubd0=disk.img init='/bin/bash -x -c "mount -t ext4 /dev/vda /mnt ; ls -l /mnt/; ip addr ; exit"' || export RETVAL=$?
         # SIGABRT=6 => 128+6
         if [ $RETVAL != "134" ]; then
           exit 1
diff --git a/arch/um/configs/x86_64_defconfig b/arch/um/configs/x86_64_defconfig
index 917982b6cd60..e5b7c048a701 100644
--- a/arch/um/configs/x86_64_defconfig
+++ b/arch/um/configs/x86_64_defconfig
@@ -75,3 +75,4 @@ CONFIG_VIRTIO_MENU=y
 CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
 CONFIG_VIRTIO_NET=y
+CONFIG_VIRTIO_BLK=y
\ No newline at end of file
diff --git a/arch/um/os-Linux/lkl_dev.c b/arch/um/os-Linux/lkl_dev.c
index 698062917ed5..e08f113dfc0b 100644
--- a/arch/um/os-Linux/lkl_dev.c
+++ b/arch/um/os-Linux/lkl_dev.c
@@ -6,6 +6,7 @@
 #include <os.h>
 #include <kern_util.h>
 #include <errno.h>
+#include <fcntl.h>
 
 #include <lkl.h>
 #include <lkl_host.h>
@@ -14,6 +15,7 @@ extern struct lkl_host_operations lkl_host_ops;
 struct lkl_host_operations *lkl_ops = &lkl_host_ops;
 
 static struct lkl_netdev *nd;
+static struct lkl_disk disk;
 
 int __init uml_netdev_prepare(char *iftype, char *ifparams, char *ifoffload)
 {
@@ -108,13 +110,65 @@ __uml_setup("veth", lkl_eth_setup,
 "    Configure a network device.\n\n"
 );
 
+int __init uml_blkdev_add(void)
+{
+	int disk_id = 0;
+
+	if (disk.fd)
+		disk_id = lkl_disk_add(&disk);
+
+	if (disk_id < 0)
+		return -1;
+
+	return 0;
+}
+__initcall(uml_blkdev_add);
+
+static int __init lkl_ubd_setup(char *str, int *niu)
+{
+	char *end, *fname;
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
+	/* <filename> */
+	fname = str;
+
+	os_info("fname=%s\n", fname);
+	/* create */
+	disk.fd = open(fname, O_RDWR);
+	if (disk.fd < 0)
+		return -1;
+
+	disk.ops = NULL;
+
+	return 1;
+}
+__uml_setup("vubd", lkl_ubd_setup,
+"vubd<n>=<filename>\n"
+"    Configure a block device.\n\n"
+);
+
+
 /* stub functions */
 int lkl_is_running(void)
 {
 	return 1;
 }
 
-
 void lkl_put_irq(int i, const char *user)
 {
 }
diff --git a/tools/lkl/lib/Makefile b/tools/lkl/lib/Makefile
index 8dc0009c680e..3cee5b0133b1 100644
--- a/tools/lkl/lib/Makefile
+++ b/tools/lkl/lib/Makefile
@@ -3,9 +3,9 @@ USER_CFLAGS += -I$(srctree)/tools/lkl/include \
 		-Wno-strict-prototypes -Wno-undef \
 		-Wframe-larger-than=20480 -O0 -g
 
-USER_OBJS += fs.o iomem.o net.o jmp_buf.o virtio.o virtio_net.o \
+USER_OBJS += iomem.o jmp_buf.o virtio.o virtio_net.o \
 	 virtio_net_fd.o virtio_net_tap.o utils.o posix-host.o \
-	../../perf/pmu-events/jsmn.o
+	 virtio_blk.o ../../perf/pmu-events/jsmn.o
 
 #obj-y += fs.o
 obj-y += iomem.o
@@ -14,7 +14,7 @@ obj-y += jmp_buf.o
 obj-y += posix-host.o
 #obj-$(LKL_HOST_CONFIG_NT) += nt-host.o
 obj-y += utils.o
-#obj-y += virtio_blk.o
+obj-y += virtio_blk.o
 obj-y += virtio.o
 #obj-y += dbg.o
 #obj-y += dbg_handler.o
-- 
2.20.1 (Apple Git-117)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

