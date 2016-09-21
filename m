Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Daniel Walter <dwalter@sigma-star.at>
Subject: [PATCH v2 29/46] um: Add nandsim backend driver
Date: Wed, 21 Sep 2016 11:54:07 +0200
Message-Id: <55a100c5b7151b3d73eae1b811b260e9164fa4e3.1474450296.git.dwalter@sigma-star.at>
In-Reply-To: <cover.1474450295.git.dwalter@sigma-star.at>
References: <cover.1474450295.git.dwalter@sigma-star.at>
Sender: linux-kernel-owner@vger.kernel.org
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, richard@nod.at
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: Richard Weinberger <richard@nod.at>

Add a small UML driver to act as nandsim backend.
This allows us to use the nandsim MTD as root device
and boot from it.
e.g. ./linux mem=512M unand.backing_file=/home/rw/work/ubifs/mtd4.raw \
 unand.id_bytes=0x1c,0xd3,0x90,0xa6 unand.no_oob=y nandsim.defaults=n \
 ubi.mtd=0 rootfstype=ubifs root=ubi0:rootfs

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/Kconfig.um          |   6 ++
 arch/um/drivers/Makefile    |   2 +
 arch/um/drivers/nand_kern.c | 159 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 167 insertions(+)
 create mode 100644 arch/um/drivers/nand_kern.c

diff --git a/arch/um/Kconfig.um b/arch/um/Kconfig.um
index 4b2ed58..f7a1a17 100644
--- a/arch/um/Kconfig.um
+++ b/arch/um/Kconfig.um
@@ -44,6 +44,12 @@ config HOSTFS
           If you'd like to be able to work with files stored on the host,
           say Y or M here; otherwise say N.
 
+config UML_NANDSIM
+	tristate "UML nandsim backend"
+	help
+	  Use a file on the host directly as backend for nandsim.
+	  For more help, see modinfo unand.
+
 config MCONSOLE
 	bool "Management console"
 	depends on PROC_FS
diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index e7582e1..08a806e 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -16,6 +16,7 @@ hostaudio-objs := hostaudio_kern.o
 ubd-objs := ubd_kern.o ubd_user.o
 port-objs := port_kern.o port_user.o
 harddog-objs := harddog_kern.o harddog_user.o
+unand-objs := nand_kern.o
 
 LDFLAGS_pcap.o := -r $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=libpcap.a)
 
@@ -59,6 +60,7 @@ obj-$(CONFIG_XTERM_CHAN) += xterm.o xterm_kern.o
 obj-$(CONFIG_UML_WATCHDOG) += harddog.o
 obj-$(CONFIG_BLK_DEV_COW_COMMON) += cow_user.o
 obj-$(CONFIG_UML_RANDOM) += random.o
+obj-$(CONFIG_UML_NANDSIM) += unand.o
 
 # pcap_user.o must be added explicitly.
 USER_OBJS := fd.o null.o pty.o tty.o xterm.o slip_common.o pcap_user.o vde_user.o
diff --git a/arch/um/drivers/nand_kern.c b/arch/um/drivers/nand_kern.c
new file mode 100644
index 0000000..399d9e6
--- /dev/null
+++ b/arch/um/drivers/nand_kern.c
@@ -0,0 +1,159 @@
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nandsim.h>
+#include <init.h>
+#include <os.h>
+
+static u_char id_bytes[8] = {
+	[0 ... 7] = 0xFF,
+};
+static bool no_oob;
+static char *backing_file;
+static unsigned int bus_width;
+
+module_param_array(id_bytes, byte, NULL, 0400);
+module_param(no_oob, bool, 0400);
+module_param(backing_file, charp, 0400);
+module_param(bus_width, uint, 0400);
+
+MODULE_PARM_DESC(backing_file, "File to use as backing store");
+MODULE_PARM_DESC(id_bytes, "The ID bytes returned by NAND Flash 'read ID' command");
+MODULE_PARM_DESC(no_oob, "Set to use an image without OOB data, i.e created by nanddump");
+MODULE_PARM_DESC(bus_width, "Chip's bus width (8- or 16-bit)");
+
+struct ns_uml_data {
+	int fd;
+	void *file_buf;
+};
+
+/*
+ * We support only one instance so far, just to boot from MTD.
+ * If you need more MTDs, use nandsimctl(8).
+ */
+static struct mtd_info *nsmtd;
+
+static int file_read(struct nandsim *ns, char *addr, unsigned long count,
+		     loff_t offset)
+{
+	struct ns_uml_data *data = nandsim_get_backend_data(ns);
+
+	return os_pread_file(data->fd, addr, count, offset);
+}
+
+static ssize_t file_write(struct nandsim *ns, const char *addr, size_t count,
+			  loff_t offset)
+{
+	struct ns_uml_data *data = nandsim_get_backend_data(ns);
+
+	return os_pwrite_file(data->fd, addr, count, offset);
+}
+
+static void ns_uml_read_page(struct nandsim *ns, int num)
+{
+	__ns_file_read_page(ns, num, file_read);
+}
+
+static int ns_uml_prog_page(struct nandsim *ns, int num)
+{
+	struct ns_uml_data *data = nandsim_get_backend_data(ns);
+
+	return __ns_file_prog_page(ns, num, data->file_buf, file_read,
+				   file_write);
+}
+
+static void ns_uml_erase_sector(struct nandsim *ns)
+{
+	struct ns_uml_data *data = nandsim_get_backend_data(ns);
+
+	__ns_file_erase_sector(ns, data->file_buf, file_write);
+}
+
+static int ns_uml_init(struct nandsim *ns, struct nandsim_params *nsparam)
+{
+	struct ns_uml_data *data = kzalloc(sizeof(*data), GFP_KERNEL);
+
+	if (!data)
+		return -ENOMEM;
+
+	data->file_buf = kmalloc(nandsim_get_geom(ns)->pgszoob, GFP_KERNEL);
+	if (!data->file_buf) {
+		kfree(data);
+		return -ENOMEM;
+	}
+
+	data->fd = os_open_file(nsparam->cache_file, of_set_rw(OPENFLAGS(), 1, 1), 0);
+	if (data->fd < 0) {
+		printk(KERN_ERR "Unable to open %s: %i\n", nsparam->cache_file, data->fd);
+		kfree(data->file);
+		kfree(data);
+		return data->fd;
+	}
+
+	nandsim_set_backend_data(ns, data);
+
+	return 0;
+}
+
+static void ns_uml_destroy(struct nandsim *ns)
+{
+	struct ns_uml_data *data = nandsim_get_backend_data(ns);
+
+	if (!data)
+		return;
+
+	os_close_file(data->fd);
+	kfree(data->file_buf);
+	kfree(data);
+}
+
+static struct ns_backend_ops ns_uml_bops = {
+	.erase_sector = ns_uml_erase_sector,
+	.prog_page = ns_uml_prog_page,
+	.read_page = ns_uml_read_page,
+	.init = ns_uml_init,
+	.destroy = ns_uml_destroy,
+	.name = "uml",
+};
+
+static struct nandsim_params params = {
+	.bops = &ns_uml_bops,
+};
+
+static int __init uml_ns_init(void)
+{
+	struct mtd_info *ret;
+
+	if (!backing_file)
+		return 0;
+
+	params.cache_file = backing_file;
+	params.bus_width = bus_width;
+	params.no_oob = no_oob;
+	memcpy(params.id_bytes, id_bytes, sizeof(params.id_bytes));
+
+	ret = ns_new_instance(&params);
+	if (IS_ERR(ret))
+		return PTR_ERR(ret);
+
+	nsmtd = ret;
+
+	return 0;
+}
+late_initcall(uml_ns_init);
+
+static void __exit uml_ns_exit(void)
+{
+	/*
+	 * Since this driver is a singleton we can rely on module refcounting,
+	 * and assume that ns_destroy_instance() will succeed in any case.
+	 * If not, print a frindly warning. B-)
+	 */
+	WARN_ON(ns_destroy_instance(nsmtd) != 0);
+}
+module_exit(uml_ns_exit);
+
+MODULE_AUTHOR("Richard Weinberger");
+MODULE_DESCRIPTION("UML nandsim backend");
+MODULE_LICENSE("GPL");
+
-- 
2.8.3


