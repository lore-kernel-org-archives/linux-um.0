Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4Nv8-0001Ui-52 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Sep 2004 11:08:50 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C4Nv6-0006nR-Nd for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Sep 2004 11:08:50 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] uml modules broken in 2.6.8 (has something to do with
	memmove)
References: <200409060005.54577.ralph@debianbase.de>
In-Reply-To: <200409060005.54577.ralph@debianbase.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_UbKPBYHHbfu6zJH"
Message-Id: <200409062005.08014.blaisorblade_spam@yahoo.it>
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
Date: Mon, 6 Sep 2004 20:05:08 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Ralph =?iso-8859-15?q?Pa=DFgang?= <ralph@debianbase.de>


--Boundary-00=_UbKPBYHHbfu6zJH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 06 September 2004 00:05, Ralph Pa=DFgang wrote:
> Hi all,
>
> I am not a kernel hacker, but I found with google that something changed
> with memmove in 2.6.8, but I don't know enough of the kernel stuff to know
> what it means:
>
> http://kerneltrap.org/node/view/3443 -> search for memmove and you find:
> "i386: uninline memmove"
Well, smart catch. If you know C, I can explain this. Before memmove was an
inline function defined in kernel headers, while in 2.6.8. I hope you are
using 2.6.8.1, actually, because 2.6.8 is known-buggy for nfs. Well, no, you
say 2.6.8. However, I guess that Debian-source includes the fix.

> Has nobody besides me this problem? I can't use my uml without nat, so I
> downgraded again to 2.6.6...
Solutions in such cases are (waiting for the fix):
=2D compiling what you need in the kernel rather than as a module
=2D if you get complaints about a certain symbol, i.e. memmove, just add a
EXPORT_SYMBOL(memmove) and the prototype (or the appropriate include) in
arch/um/kernel/ksyms.c and recompile the kernel (you don't need to recompile
the modules).

In this case, apply this patch with patch -p1 -l:

diff -puN arch/um/os-Linux/user_syms.c~uml-export-Symbols arch/um/os-Linux/=
user_syms.c
=2D-- uml-linux-2.6.8.1/arch/um/os-Linux/user_syms.c~uml-export-Symbols   2=
004-08-29 14:40:56.000000000 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/os-Linux/user_syms.c        2004-08-29 =
14:40:56.000000000 +0200
@@ -14,12 +14,14 @@

 extern size_t strlen(const char *);
 extern void *memcpy(void *, const void *, size_t);
+extern void *memmove(void *, const void *, size_t);
 extern void *memset(void *, int, size_t);
 extern int printf(const char *, ...);

 EXPORT_SYMBOL(strlen);
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memset);
+EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(printf);

 EXPORT_SYMBOL(strstr);

If you experience other module-related problems, you may want to use the=20
attached patch, however I'm not sure it will apply on your tree.
=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_UbKPBYHHbfu6zJH
Content-Type: text/x-diff; charset="iso-8859-1";
	name="uml-export-Symbols.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-export-Symbols.patch"


Adds a lot more EXPORT_SYMBOLS calls, and also replace some __initcall with
some module_init().

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/arch/um/Kconfig              |    3 +-
 uml-linux-2.6.8.1-paolo/arch/um/kernel/filehandle.c  |   10 +++++++
 uml-linux-2.6.8.1-paolo/arch/um/kernel/irq.c         |    2 +
 uml-linux-2.6.8.1-paolo/arch/um/kernel/ksyms.c       |   26 ++++++++++++++++++-
 uml-linux-2.6.8.1-paolo/arch/um/kernel/physmem.c     |    5 +++
 uml-linux-2.6.8.1-paolo/arch/um/os-Linux/user_syms.c |    2 +
 uml-linux-2.6.8.1-paolo/fs/hostfs/Makefile           |    6 ++--
 uml-linux-2.6.8.1-paolo/fs/hostfs/externfs.c         |    7 +++++
 uml-linux-2.6.8.1-paolo/fs/hostfs/host_file.c        |   20 ++++++++++++++
 uml-linux-2.6.8.1-paolo/fs/hostfs/host_fs.c          |    7 +----
 uml-linux-2.6.8.1-paolo/fs/hostfs/humfs.c            |   21 +++++++++++----
 uml-linux-2.6.8.1-paolo/fs/hostfs/meta_fs.c          |    5 ++-
 12 files changed, 98 insertions(+), 16 deletions(-)

diff -puN arch/um/kernel/ksyms.c~uml-export-Symbols arch/um/kernel/ksyms.c
--- uml-linux-2.6.8.1/arch/um/kernel/ksyms.c~uml-export-Symbols	2004-08-29 14:40:56.000000000 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/kernel/ksyms.c	2004-08-29 14:40:56.000000000 +0200
@@ -21,6 +21,7 @@
 #include "user_util.h"
 #include "mem_user.h"
 #include "os.h"
+#include "aio.h"
 #include "helper.h"
 
 EXPORT_SYMBOL(stop);
@@ -48,6 +49,7 @@ EXPORT_SYMBOL(to_virt);
 EXPORT_SYMBOL(mode_tt);
 EXPORT_SYMBOL(handle_page_fault);
 EXPORT_SYMBOL(find_iomem);
+EXPORT_SYMBOL(uml_strdup);
 
 #ifdef CONFIG_MODE_TT
 EXPORT_SYMBOL(strncpy_from_user_tt);
@@ -81,16 +83,38 @@ EXPORT_SYMBOL(os_flush_stdout);
 EXPORT_SYMBOL(os_close_file);
 EXPORT_SYMBOL(os_set_fd_async);
 EXPORT_SYMBOL(os_set_fd_block);
-EXPORT_SYMBOL(helper_wait);
+EXPORT_SYMBOL(os_remove_dir);
+EXPORT_SYMBOL(os_remove_file);
 EXPORT_SYMBOL(os_shutdown_socket);
 EXPORT_SYMBOL(os_create_unix_socket);
 EXPORT_SYMBOL(os_connect_socket);
 EXPORT_SYMBOL(os_accept_connection);
 EXPORT_SYMBOL(os_ioctl_generic);
 EXPORT_SYMBOL(os_rcv_fd);
+EXPORT_SYMBOL(os_truncate_fd);
+EXPORT_SYMBOL(os_fd_size);
+EXPORT_SYMBOL(os_close_dir);
+EXPORT_SYMBOL(os_make_dev);
+EXPORT_SYMBOL(os_stat_filesystem);
+EXPORT_SYMBOL(os_move_file);
+EXPORT_SYMBOL(os_read_symlink);
+EXPORT_SYMBOL(os_link_file);
+EXPORT_SYMBOL(os_make_dir);
+EXPORT_SYMBOL(os_make_symlink);
+EXPORT_SYMBOL(os_set_file_time);
+EXPORT_SYMBOL(os_truncate_file);
+EXPORT_SYMBOL(os_set_file_owner);
+EXPORT_SYMBOL(os_set_file_perms);
+EXPORT_SYMBOL(os_lstat_file);
+EXPORT_SYMBOL(os_tell_dir);
+EXPORT_SYMBOL(os_read_dir);
+EXPORT_SYMBOL(os_seek_dir);
+EXPORT_SYMBOL(submit_aio);
+
 EXPORT_SYMBOL(run_helper);
 EXPORT_SYMBOL(start_thread);
 EXPORT_SYMBOL(dump_thread);
+EXPORT_SYMBOL(helper_wait);
 
 EXPORT_SYMBOL(do_gettimeofday);
 EXPORT_SYMBOL(do_settimeofday);
diff -puN arch/um/os-Linux/user_syms.c~uml-export-Symbols arch/um/os-Linux/user_syms.c
--- uml-linux-2.6.8.1/arch/um/os-Linux/user_syms.c~uml-export-Symbols	2004-08-29 14:40:56.000000000 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/os-Linux/user_syms.c	2004-08-29 14:40:56.000000000 +0200
@@ -14,12 +14,14 @@
 
 extern size_t strlen(const char *);
 extern void *memcpy(void *, const void *, size_t);
+extern void *memmove(void *, const void *, size_t);
 extern void *memset(void *, int, size_t);
 extern int printf(const char *, ...);
 
 EXPORT_SYMBOL(strlen);
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memset);
+EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(printf);
 
 EXPORT_SYMBOL(strstr);
diff -puN arch/um/os-Linux/aio.c~uml-export-Symbols arch/um/os-Linux/aio.c
diff -puN arch/um/kernel/irq.c~uml-export-Symbols arch/um/kernel/irq.c
--- uml-linux-2.6.8.1/arch/um/kernel/irq.c~uml-export-Symbols	2004-08-29 14:40:56.000000000 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/kernel/irq.c	2004-08-29 14:40:56.000000000 +0200
@@ -437,6 +437,8 @@ int um_request_irq(unsigned int irq, int
 		err = activate_fd(irq, fd, type, dev_id);
 	return(err);
 }
+EXPORT_SYMBOL(um_request_irq);
+EXPORT_SYMBOL(reactivate_fd);
 
 /* this was setup_x86_irq but it seems pretty generic */
 int setup_irq(unsigned int irq, struct irqaction * new)
diff -puN arch/um/kernel/physmem.c~uml-export-Symbols arch/um/kernel/physmem.c
--- uml-linux-2.6.8.1/arch/um/kernel/physmem.c~uml-export-Symbols	2004-08-29 14:40:56.000000000 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/kernel/physmem.c	2004-08-30 16:36:26.469125200 +0200
@@ -8,6 +8,7 @@
 #include "linux/slab.h"
 #include "linux/vmalloc.h"
 #include "linux/bootmem.h"
+#include "linux/module.h"
 #include "asm/types.h"
 #include "asm/pgtable.h"
 #include "kern_util.h"
@@ -229,6 +230,10 @@ void physmem_forget_descriptor(int fd)
 	kfree(desc);
 }
 
+EXPORT_SYMBOL(physmem_forget_descriptor);
+EXPORT_SYMBOL(physmem_remove_mapping);
+EXPORT_SYMBOL(physmem_subst_mapping);
+
 void arch_free_page(struct page *page, int order)
 {
 	void *virt;
diff -puN fs/hostfs/externfs.c~uml-export-Symbols fs/hostfs/externfs.c
--- uml-linux-2.6.8.1/fs/hostfs/externfs.c~uml-export-Symbols	2004-08-29 14:40:56.000000000 +0200
+++ uml-linux-2.6.8.1-paolo/fs/hostfs/externfs.c	2004-08-29 14:40:56.000000000 +0200
@@ -1190,6 +1190,7 @@ char *host_root_filename(char *mount_arg
 
 	return(uml_strdup(root));
 }
+EXPORT_SYMBOL(host_root_filename);
 
 static int externfs_fill_sb(struct super_block *sb, void *data, int silent)
 {
@@ -1286,6 +1287,7 @@ int register_externfs(char *name, struct
  out:
 	return(err);
 }
+EXPORT_SYMBOL(register_externfs);
 
 void unregister_externfs(char *name)
 {
@@ -1304,6 +1306,11 @@ void unregister_externfs(char *name)
 	up(&externfs_sem);
 	printk("Unregister_externfs - filesystem '%s' not found\n", name);
 }
+EXPORT_SYMBOL(unregister_externfs);
+
+EXPORT_SYMBOL(init_externfs);
+EXPORT_SYMBOL(inode_externfs_info);
+EXPORT_SYMBOL(inode_name_prefix);
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -puN fs/hostfs/humfs.c~uml-export-Symbols fs/hostfs/humfs.c
--- uml-linux-2.6.8.1/fs/hostfs/humfs.c~uml-export-Symbols	2004-08-29 14:40:56.000000000 +0200
+++ uml-linux-2.6.8.1-paolo/fs/hostfs/humfs.c	2004-08-29 14:40:56.000000000 +0200
@@ -12,9 +12,11 @@
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/kdev_t.h>
+#include <linux/module.h>
 #include "linux/init.h"
 #include "linux/workqueue.h"
 #include <asm/irq.h>
+#include <asm/div64.h>
 #include "hostfs.h"
 #include "mem.h"
 #include "os.h"
@@ -320,8 +322,6 @@ static int init_humfs_aio(void)
 	return(0);
 }
 
-__initcall(init_humfs_aio);
-
 static int humfs_aio(enum aio_type type, int fd, unsigned long long offset,
 		     char *buf, int len, int real_len,
 		     void (*completion)(char *, int, void *), void *arg)
@@ -669,6 +669,7 @@ struct humfs *inode_humfs_info(struct in
 {
 	return(container_of(inode_externfs_info(inode), struct humfs, ext));
 }
+EXPORT_SYMBOL(inode_humfs_info);
 
 static int humfs_rename_file(char *from, char *to, struct externfs_data *ed)
 {
@@ -705,9 +706,16 @@ static int humfs_stat_fs(long *bsize_out
 	if(err)
 		return(err);
 
+#if 0
 	*blocks_out = mount->total / *bsize_out;
 	*bfree_out = (mount->total - mount->used) / *bsize_out;
-	*bavail_out = (mount->total - mount->used) / *bsize_out;
+#endif
+	*blocks_out = mount->total;
+	*bfree_out = (mount->total - mount->used);
+	do_div(blocks_out, *bsize_out);
+	do_div(bfree_out, *bsize_out);
+
+	*bavail_out = *bfree_out;
 	return(0);
 }
 
@@ -766,6 +774,7 @@ void register_meta(struct humfs_meta_ops
 	list_add(&ops->list, &metas);
 	up(&meta_sem);
 }
+EXPORT_SYMBOL(register_meta);
  
 void unregister_meta(struct humfs_meta_ops *ops)
 {
@@ -773,6 +782,7 @@ void unregister_meta(struct humfs_meta_o
 	list_del(&ops->list);
 	up(&meta_sem);
 }
+EXPORT_SYMBOL(unregister_meta);
  
 static struct humfs *read_superblock(char *root)
 {
@@ -1003,6 +1013,7 @@ struct externfs_mount_ops humfs_mount_op
 
 static int __init init_humfs(void)
 {
+	init_humfs_aio();
 	return(register_externfs("humfs", &humfs_mount_ops));
 }
 
@@ -1011,8 +1022,8 @@ static void __exit exit_humfs(void)
 	unregister_externfs("humfs");
 }
 
-__initcall(init_humfs);
-__exitcall(exit_humfs);
+module_init(init_humfs);
+module_exit(exit_humfs);
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -puN fs/hostfs/host_file.c~uml-export-Symbols fs/hostfs/host_file.c
--- uml-linux-2.6.8.1/fs/hostfs/host_file.c~uml-export-Symbols	2004-08-29 14:40:56.000000000 +0200
+++ uml-linux-2.6.8.1-paolo/fs/hostfs/host_file.c	2004-08-29 14:40:56.000000000 +0200
@@ -9,6 +9,7 @@
 #include "linux/types.h"
 #include "linux/slab.h"
 #include "linux/fs.h"
+#include "linux/module.h"
 #include "asm/fcntl.h"
 #include "hostfs.h"
 #include "filehandle.h"
@@ -430,6 +431,25 @@ int generic_host_truncate_file(struct fi
 	return(truncate_file(fh, size));
 }
 
+EXPORT_SYMBOL(free_path);
+EXPORT_SYMBOL(generic_host_read_dir);
+EXPORT_SYMBOL(get_path);
+EXPORT_SYMBOL(host_create_file);
+EXPORT_SYMBOL(host_file_type);
+EXPORT_SYMBOL(host_link_file);
+EXPORT_SYMBOL(host_make_dir);
+EXPORT_SYMBOL(host_make_symlink);
+EXPORT_SYMBOL(host_open_dir);
+EXPORT_SYMBOL(host_open_file);
+EXPORT_SYMBOL(host_read_link);
+EXPORT_SYMBOL(host_remove_dir);
+EXPORT_SYMBOL(host_rename_file);
+EXPORT_SYMBOL(host_root_filename);
+EXPORT_SYMBOL(host_set_attr);
+EXPORT_SYMBOL(host_stat_file);
+EXPORT_SYMBOL(host_stat_fs);
+EXPORT_SYMBOL(host_unlink_file);
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
diff -puN arch/um/kernel/filehandle.c~uml-export-Symbols arch/um/kernel/filehandle.c
--- uml-linux-2.6.8.1/arch/um/kernel/filehandle.c~uml-export-Symbols	2004-08-29 14:40:56.000000000 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/kernel/filehandle.c	2004-08-29 14:41:57.000000000 +0200
@@ -8,6 +8,7 @@
 #include "linux/spinlock.h"
 #include "linux/fs.h"
 #include "linux/errno.h"
+#include "linux/module.h"
 #include "filehandle.h"
 #include "os.h"
 #include "kern_util.h"
@@ -65,6 +66,7 @@ void *open_dir(char *file)
 
 	return(dir);
 }
+EXPORT_SYMBOL(open_dir);
 
 void not_reclaimable(struct file_handle *fh)
 {
@@ -87,6 +89,7 @@ void not_reclaimable(struct file_handle 
 		spin_unlock(&open_files_lock);
 	}
 }
+EXPORT_SYMBOL(not_reclaimable);
 
 void is_reclaimable(struct file_handle *fh, char *(name_proc)(struct inode *),
 		    struct inode *inode)
@@ -98,6 +101,7 @@ void is_reclaimable(struct file_handle *
 	list_add(&fh->list, &open_files);
 	spin_unlock(&open_files_lock);
 }
+EXPORT_SYMBOL(is_reclaimable);
 
 static int active_handle(struct file_handle *fh)
 {
@@ -138,6 +142,7 @@ int filehandle_fd(struct file_handle *fh
 
 	return(fh->fd);
 }
+EXPORT_SYMBOL(filehandle_fd);
 
 static void init_fh(struct file_handle *fh, int fd, struct openflags flags)
 {
@@ -161,6 +166,7 @@ int open_filehandle(char *name, struct o
 	init_fh(fh, fd, flags);
 	return(0);
 }
+EXPORT_SYMBOL(open_filehandle);
 
 int close_file(struct file_handle *fh)
 {
@@ -173,6 +179,7 @@ int close_file(struct file_handle *fh)
 	fh->fd = -1;
 	return(0);
 }
+EXPORT_SYMBOL(close_file);
 
 int read_file(struct file_handle *fh, unsigned long long offset, char *buf,
 	      int len)
@@ -189,6 +196,7 @@ int read_file(struct file_handle *fh, un
 
 	return(os_read_file(fh->fd, buf, len));
 }
+EXPORT_SYMBOL(read_file);
 
 int write_file(struct file_handle *fh, unsigned long long offset, 
 	       const char *buf, int len)
@@ -206,6 +214,7 @@ int write_file(struct file_handle *fh, u
 
 	return(os_write_file(fh->fd, buf, len));
 }
+EXPORT_SYMBOL(write_file);
 
 int truncate_file(struct file_handle *fh, unsigned long long size)
 {
@@ -217,6 +226,7 @@ int truncate_file(struct file_handle *fh
 
 	return(os_truncate_fd(fh->fd, size));
 }
+EXPORT_SYMBOL(truncate_file);
 
 int make_pipe(struct file_handle *fhs)
 {
diff -puN arch/um/Kconfig~uml-export-Symbols arch/um/Kconfig
--- uml-linux-2.6.8.1/arch/um/Kconfig~uml-export-Symbols	2004-08-29 14:40:56.000000000 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/Kconfig	2004-08-30 16:37:12.222169680 +0200
@@ -83,6 +83,7 @@ config EXTERNFS
 
 config HOSTFS
 	tristate "Host filesystem"
+	depends on EXTERNFS
 	help
         While the User-Mode Linux port uses its own root file system for
         booting and normal file access, this module lets the UML user
@@ -104,7 +105,7 @@ config HOSTFS
 
 config HUMFS
 	tristate 'Usable host filesystem'
-	depends on EXTERNFS
+	depends on EXTERNFS && HOSTFS
 
 config HPPFS
 	tristate "HoneyPot ProcFS"
diff -puN fs/hostfs/host_fs.c~uml-export-Symbols fs/hostfs/host_fs.c
--- uml-linux-2.6.8.1/fs/hostfs/host_fs.c~uml-export-Symbols	2004-08-29 14:40:56.000000000 +0200
+++ uml-linux-2.6.8.1-paolo/fs/hostfs/host_fs.c	2004-08-30 16:36:41.152892928 +0200
@@ -11,6 +11,7 @@
 #include "linux/init.h"
 #include "linux/fs.h"
 #include "linux/stat.h"
+#include "linux/module.h"
 #include "hostfs.h"
 #include "kern.h"
 #include "init.h"
@@ -21,6 +22,7 @@
 /* Changed in hostfs_args before the kernel starts running */
 static char *jail_dir = "/";
 int append = 0;
+EXPORT_SYMBOL(append);
 
 static int __init hostfs_args(char *options, int *add)
 {
@@ -446,14 +448,9 @@ static void __exit exit_hostfs(void)
 	unregister_externfs("hostfs");
 }
 
-__initcall(init_hostfs);
-__exitcall(exit_hostfs);
-
-#if 0
 module_init(init_hostfs)
 module_exit(exit_hostfs)
 MODULE_LICENSE("GPL");
-#endif
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -puN fs/hostfs/meta_fs.c~uml-export-Symbols fs/hostfs/meta_fs.c
--- uml-linux-2.6.8.1/fs/hostfs/meta_fs.c~uml-export-Symbols	2004-08-29 14:40:56.000000000 +0200
+++ uml-linux-2.6.8.1-paolo/fs/hostfs/meta_fs.c	2004-08-29 14:40:56.000000000 +0200
@@ -5,6 +5,7 @@
 
 #include <linux/slab.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include "hostfs.h"
 #include "metadata.h"
 #include "kern_util.h"
@@ -505,8 +506,8 @@ static void __exit exit_meta_fs(void)
 	unregister_meta(&hum_fs_meta_fs_ops);
 }
 
-__initcall(init_meta_fs);
-__exitcall(exit_meta_fs);
+module_init(init_meta_fs);
+module_exit(exit_meta_fs);
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -puN fs/hostfs/Makefile~uml-export-Symbols fs/hostfs/Makefile
--- uml-linux-2.6.8.1/fs/hostfs/Makefile~uml-export-Symbols	2004-08-30 16:37:25.671125128 +0200
+++ uml-linux-2.6.8.1-paolo/fs/hostfs/Makefile	2004-08-30 16:37:35.061697544 +0200
@@ -3,11 +3,13 @@
 # Licensed under the GPL
 #
 
-obj-y = 
+obj-y :=
 obj-$(CONFIG_EXTERNFS) += externfs.o
-obj-$(CONFIG_HOSTFS) += host_fs.o host_file.o
+obj-$(CONFIG_HOSTFS) += hostfs.o
 obj-$(CONFIG_HUMFS) += humfs.o meta_fs.o
 
+hostfs-objs := host_fs.o host_file.o
+
 SINGLE_OBJS = $(foreach f,$(patsubst %.o,%,$(obj-y) $(obj-m)),$($(f)-objs))
 
 USER_OBJS := $(filter %_user.o,$(obj-y) $(obj-m) $(SINGLE_OBJS))
_

--Boundary-00=_UbKPBYHHbfu6zJH--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
