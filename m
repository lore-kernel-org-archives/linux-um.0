Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMqnK-0003bR-7V for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 10:13:54 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FMqn7-0005br-BM
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 10:13:54 -0800
Message-Id: <200603241814.k2OIExNn005555@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 12/16] UML - Memory hotplug
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
Date: Fri, 24 Mar 2006 13:14:59 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This adds hotplug memory support to UML.  The mconsole syntax is
	config mem=[+-]n[KMG]
In other words, add or subtract some number of kilobytes, megabytes, or
gigabytes.
 
Unplugged pages are allocated and then madvise(MADV_REMOVE), which is
a currently experimental madvise extension.  These pages are tracked so
they can be plugged back in later if the admin decides to give them back.
The first page to be unplugged is used to keep track of about 4M of other
pages.  A list_head is the first thing on this page.  The rest is filled
with addresses of other unplugged pages.  This first page is not madvised,
obviously.
When this page is filled, the next page is used in a similar way and linked
onto a list with the first page.  Etc.
This whole process reverses when pages are plugged back in.  When a tracking
page no longer tracks any unplugged pages, then it is next in line for
plugging, which is done by freeing pages back to the kernel.

This patch also removes checking for /dev/anon on the host, which is obsoleted
by MADVISE_REMOVE.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.16.orig/arch/um/drivers/mconsole_kern.c	2006-03-23 17:15:05.000000000 -0500
+++ linux-2.6.16/arch/um/drivers/mconsole_kern.c	2006-03-23 17:39:21.000000000 -0500
@@ -20,6 +20,8 @@
 #include "linux/namei.h"
 #include "linux/proc_fs.h"
 #include "linux/syscalls.h"
+#include "linux/list.h"
+#include "linux/mm.h"
 #include "linux/console.h"
 #include "asm/irq.h"
 #include "asm/uaccess.h"
@@ -347,6 +349,139 @@ static struct mc_device *mconsole_find_d
 	return(NULL);
 }
 
+#define UNPLUGGED_PER_PAGE \
+	((PAGE_SIZE - sizeof(struct list_head)) / sizeof(unsigned long))
+
+struct unplugged_pages {
+	struct list_head list;
+	void *pages[UNPLUGGED_PER_PAGE];
+};
+
+static unsigned long long unplugged_pages_count = 0;
+static struct list_head unplugged_pages = LIST_HEAD_INIT(unplugged_pages);
+static int unplug_index = UNPLUGGED_PER_PAGE;
+
+static int mem_config(char *str)
+{
+	unsigned long long diff;
+	int err = -EINVAL, i, add;
+	char *ret;
+
+	if(str[0] != '=')
+		goto out;
+
+	str++;
+	if(str[0] == '-')
+		add = 0;
+	else if(str[0] == '+'){
+		add = 1;
+	}
+	else goto out;
+
+	str++;
+	diff = memparse(str, &ret);
+	if(*ret != '\0')
+		goto out;
+
+	diff /= PAGE_SIZE;
+
+	for(i = 0; i < diff; i++){
+		struct unplugged_pages *unplugged;
+		void *addr;
+
+		if(add){
+			if(list_empty(&unplugged_pages))
+				break;
+
+			unplugged = list_entry(unplugged_pages.next,
+					       struct unplugged_pages, list);
+			if(unplug_index > 0)
+				addr = unplugged->pages[--unplug_index];
+			else {
+				list_del(&unplugged->list);
+				addr = unplugged;
+				unplug_index = UNPLUGGED_PER_PAGE;
+			}
+
+			free_page((unsigned long) addr);
+			unplugged_pages_count--;
+		}
+		else {
+			struct page *page;
+
+			page = alloc_page(GFP_ATOMIC);
+			if(page == NULL)
+				break;
+
+			unplugged = page_address(page);
+			if(unplug_index == UNPLUGGED_PER_PAGE){
+				INIT_LIST_HEAD(&unplugged->list);
+				list_add(&unplugged->list, &unplugged_pages);
+				unplug_index = 0;
+			}
+			else {
+				struct list_head *entry = unplugged_pages.next;
+				addr = unplugged;
+
+				unplugged = list_entry(entry,
+						       struct unplugged_pages,
+						       list);
+				unplugged->pages[unplug_index++] = addr;
+				err = os_drop_memory(addr, PAGE_SIZE);
+				if(err)
+					printk("Failed to release memory - "
+					       "errno = %d\n", err);
+			}
+
+			unplugged_pages_count++;
+		}
+	}
+
+	err = 0;
+out:
+	return err;
+}
+
+static int mem_get_config(char *name, char *str, int size, char **error_out)
+{
+	char buf[sizeof("18446744073709551615\0")];
+	int len = 0;
+
+	sprintf(buf, "%ld", uml_physmem);
+	CONFIG_CHUNK(str, size, len, buf, 1);
+
+	return len;
+}
+
+static int mem_id(char **str, int *start_out, int *end_out)
+{
+	*start_out = 0;
+	*end_out = 0;
+
+	return 0;
+}
+
+static int mem_remove(int n)
+{
+	return -EBUSY;
+}
+
+static struct mc_device mem_mc = {
+	.name		= "mem",
+	.config		= mem_config,
+	.get_config	= mem_get_config,
+	.id		= mem_id,
+	.remove		= mem_remove,
+};
+
+static int mem_mc_init(void)
+{
+	mconsole_register_dev(&mem_mc);
+	return 0;
+}
+
+__initcall(mem_mc_init);
+
 #define CONFIG_BUF_SIZE 64
 
 static void mconsole_get_config(int (*get_config)(char *, char *, int,
Index: linux-2.6.16/arch/um/include/os.h
===================================================================
--- linux-2.6.16.orig/arch/um/include/os.h	2006-03-23 17:35:56.000000000 -0500
+++ linux-2.6.16/arch/um/include/os.h	2006-03-23 17:39:21.000000000 -0500
@@ -205,6 +205,7 @@ extern int os_map_memory(void *virt, int
 extern int os_protect_memory(void *addr, unsigned long len, 
 			     int r, int w, int x);
 extern int os_unmap_memory(void *addr, int len);
+extern int os_drop_memory(void *addr, int length);
 extern void os_flush_stdout(void);
 
 /* tt.c
Index: linux-2.6.16/arch/um/os-Linux/process.c
===================================================================
--- linux-2.6.16.orig/arch/um/os-Linux/process.c	2006-03-23 17:15:05.000000000 -0500
+++ linux-2.6.16/arch/um/os-Linux/process.c	2006-03-23 17:39:21.000000000 -0500
@@ -187,6 +187,20 @@ int os_unmap_memory(void *addr, int len)
         return(0);
 }
 
+#ifndef MADV_REMOVE
+#define MADV_REMOVE	0x5		/* remove these pages & resources */
+#endif
+
+int os_drop_memory(void *addr, int length)
+{
+	int err;
+
+	err = madvise(addr, length, MADV_REMOVE);
+	if(err < 0)
+		err = -errno;
+	return 0;
+}
+
 void init_new_thread_stack(void *sig_stack, void (*usr1_handler)(int))
 {
 	int flags = 0, pages;
Index: linux-2.6.16/arch/um/include/mem_user.h
===================================================================
--- linux-2.6.16.orig/arch/um/include/mem_user.h	2006-03-23 17:15:05.000000000 -0500
+++ linux-2.6.16/arch/um/include/mem_user.h	2006-03-23 17:39:21.000000000 -0500
@@ -49,7 +49,6 @@ extern int iomem_size;
 extern unsigned long host_task_size;
 extern unsigned long task_size;
 
-extern void check_devanon(void);
 extern int init_mem_user(void);
 extern void setup_memory(void *entry);
 extern unsigned long find_iomem(char *driver, unsigned long *len_out);
Index: linux-2.6.16/arch/um/os-Linux/mem.c
===================================================================
--- linux-2.6.16.orig/arch/um/os-Linux/mem.c	2006-03-23 17:15:05.000000000 -0500
+++ linux-2.6.16/arch/um/os-Linux/mem.c	2006-03-23 17:39:21.000000000 -0500
@@ -121,36 +121,11 @@ int create_tmp_file(unsigned long long l
 	return(fd);
 }
 
-static int create_anon_file(unsigned long long len)
-{
-	void *addr;
-	int fd;
-
-	fd = open("/dev/anon", O_RDWR);
-	if(fd < 0) {
-		perror("opening /dev/anon");
-		exit(1);
-	}
-
-	addr = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
-	if(addr == MAP_FAILED){
-		perror("mapping physmem file");
-		exit(1);
-	}
-	munmap(addr, len);
-
-	return(fd);
-}
-
-extern int have_devanon;
-
 int create_mem_file(unsigned long long len)
 {
 	int err, fd;
 
-	if(have_devanon)
-		fd = create_anon_file(len);
-	else fd = create_tmp_file(len);
+	fd = create_tmp_file(len);
 
 	err = os_set_exec_close(fd, 1);
 	if(err < 0){
Index: linux-2.6.16/arch/um/os-Linux/start_up.c
===================================================================
--- linux-2.6.16.orig/arch/um/os-Linux/start_up.c	2006-03-23 17:23:54.000000000 -0500
+++ linux-2.6.16/arch/um/os-Linux/start_up.c	2006-03-23 17:39:21.000000000 -0500
@@ -470,25 +470,6 @@ int can_do_skas(void)
 }
 #endif
 
-int have_devanon = 0;
-
-/* Runs on boot kernel stack - already safe to use printk. */
-
-void check_devanon(void)
-{
-	int fd;
-
-	printk("Checking for /dev/anon on the host...");
-	fd = open("/dev/anon", O_RDWR);
-	if(fd < 0){
-		printk("Not available (open failed with errno %d)\n", errno);
-		return;
-	}
-
-	printk("OK\n");
-	have_devanon = 1;
-}
-
 int __init parse_iomem(char *str, int *add)
 {
 	struct iomem_region *new;
@@ -664,6 +645,5 @@ void os_check_bugs(void)
 {
 	check_ptrace();
 	check_sigio();
-	check_devanon();
 }
 



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
