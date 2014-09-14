Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1XT7GB-0007IL-Mv
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 Sep 2014 10:42:23 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XT7G9-0001bm-J0
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 Sep 2014 10:42:23 +0000
Received: from [217.255.233.8] (helo=[192.168.2.106])
	by www17.your-server.de with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80.1) (envelope-from <thomas@m3y3r.de>) id 1XT7G1-0002OC-Rg
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 Sep 2014 12:42:15 +0200
Message-ID: <1410691327.998.8.camel@localhost.localdomain>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Sun, 14 Sep 2014 12:42:07 +0200
Mime-Version: 1.0
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
Subject: [uml-devel] [PATCH] um: Register UML with systemd-machined
To: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>


Call machined's "CreateMachine" to create a scope unit for the
current uml instance.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---
 arch/um/Makefile            |  4 +-
 arch/um/include/shared/os.h |  1 +
 arch/um/os-Linux/Makefile   |  6 ++-
 arch/um/os-Linux/machined.c | 89 +++++++++++++++++++++++++++++++++++++++++++++
 arch/um/os-Linux/umid.c     | 69 +++++++++++++++++++----------------
 5 files changed, 135 insertions(+), 34 deletions(-)
 create mode 100644 arch/um/os-Linux/machined.c

diff --git a/arch/um/Makefile b/arch/um/Makefile
index e4b1a96..e9e3dee 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -132,8 +132,10 @@ LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
 
 LD_FLAGS_CMDLINE = $(foreach opt,$(LDFLAGS),-Wl,$(opt))
 
+LINK_DBUS = $(shell pkg-config --libs dbus-1)
+
 # Used by link-vmlinux.sh which has special support for um link
-export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE)
+export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE) $(LINK_DBUS)
 
 # When cleaning we don't include .config, so we don't include
 # TT or skas makefiles and don't clean skas_ptregs.h.
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 08eec0b..13f8f10 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -217,6 +217,7 @@ extern int helper_wait(int pid);
 extern int umid_file_name(char *name, char *buf, int len);
 extern int set_umid(char *name);
 extern char *get_umid(void);
+extern char* get_uml_dir_realpath(void);
 
 /* signal.c */
 extern void timer_init(void);
diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
index 08ff509..23559a3 100644
--- a/arch/um/os-Linux/Makefile
+++ b/arch/um/os-Linux/Makefile
@@ -5,16 +5,18 @@
 
 obj-y = aio.o execvp.o file.o helper.o irq.o main.o mem.o process.o \
 	registers.o sigio.o signal.o start_up.o time.o tty.o \
-	umid.o user_syms.o util.o drivers/ skas/
+	umid.o user_syms.o util.o drivers/ skas/ machined.o
 
 obj-$(CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA) += elf_aux.o
 
 USER_OBJS := $(user-objs-y) aio.o elf_aux.o execvp.o file.o helper.o irq.o \
 	main.o mem.o process.o registers.o sigio.o signal.o start_up.o time.o \
-	tty.o umid.o util.o
+	tty.o umid.o util.o machined.o
 
 HAVE_AIO_ABI := $(shell [ -r /usr/include/linux/aio_abi.h ] && \
 	echo -DHAVE_AIO_ABI )
 CFLAGS_aio.o += $(HAVE_AIO_ABI)
 
+CFLAGS_machined.o += $(shell pkg-config --cflags dbus-1 )
+
 include arch/um/scripts/Makefile.rules
diff --git a/arch/um/os-Linux/machined.c b/arch/um/os-Linux/machined.c
new file mode 100644
index 0000000..d39e7b1
--- /dev/null
+++ b/arch/um/os-Linux/machined.c
@@ -0,0 +1,89 @@
+#include <dbus/dbus.h>
+#include <init.h>
+#include <unistd.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <os.h>
+#include <string.h>
+
+static int machined_init(void) {
+
+    DBusMessageIter message_iter;
+    DBusMessageIter message_iter_array;
+
+    DBusError dbus_error = {};
+    dbus_bool_t dbus_rc = false;
+
+    DBusConnection *con = NULL;
+    DBusMessage* message = NULL, *reply_message = NULL;
+
+    char *root_dir = get_uml_dir_realpath();
+
+    char *arg_machine_name = NULL;
+    unsigned char arg_uuid[] = { };
+    dbus_uint32_t arg_pid = os_getpid();
+    char *arg_root_dir = root_dir ? "" : root_dir;
+    const char *arg_service = "uml";
+    const char *arg_class = "vm";
+
+#define SLEN 255
+    arg_machine_name = malloc(SLEN);
+    if(arg_machine_name == NULL) {
+        goto out;
+    }
+
+    snprintf(arg_machine_name, SLEN, "uml-uid=%i-umid=%s", getuid(), get_umid());
+
+    con = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+    if(con == NULL) {
+        printf("dbus_bus_get: no connection to system bus!\n");
+        goto out;
+    }
+
+    message = dbus_message_new_method_call(
+        "org.freedesktop.machine1",
+        "/org/freedesktop/machine1",
+        "org.freedesktop.machine1.Manager",
+        "CreateMachine");
+    if(message == NULL) {
+        printf("dbus_message_new_method_call: no machined manager found!\n");
+        goto out;
+    }
+
+    dbus_message_iter_init_append (message, &message_iter);
+    /* normal arguments */
+    dbus_rc = dbus_message_iter_append_basic(&message_iter, DBUS_TYPE_STRING, &arg_machine_name);
+    dbus_rc &= dbus_message_iter_open_container(&message_iter, DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE_AS_STRING, &message_iter_array);
+    dbus_rc &= dbus_message_iter_append_fixed_array(&message_iter_array, DBUS_TYPE_BYTE, &arg_uuid, 0);
+    dbus_rc &= dbus_message_iter_close_container(&message_iter, &message_iter_array);
+    dbus_rc &= dbus_message_iter_append_basic(&message_iter, DBUS_TYPE_STRING, &arg_service);
+    dbus_rc &= dbus_message_iter_append_basic(&message_iter, DBUS_TYPE_STRING, &arg_class);
+    dbus_rc &= dbus_message_iter_append_basic(&message_iter, DBUS_TYPE_UINT32, &arg_pid);
+    dbus_rc &= dbus_message_iter_append_basic(&message_iter, DBUS_TYPE_STRING, &arg_root_dir);
+
+    /* append scope properties array */
+    dbus_rc &= dbus_message_iter_open_container(&message_iter, DBUS_TYPE_ARRAY, "(sv)", &message_iter_array);
+    /* ENHANCEME: fill in array of (sv) to control the scope unit */
+    dbus_rc &= dbus_message_iter_close_container(&message_iter, &message_iter_array);
+    if(dbus_rc != true) {
+        printf("DBusMessage: construction of message failed!\n");
+        goto out;
+    }
+
+    reply_message = dbus_connection_send_with_reply_and_block(con, message, -1, &dbus_error);
+    if(reply_message == NULL) {
+        printf("Failed to register with systemd-machined: %s\n", dbus_error.message);
+        goto out;
+    }
+
+out:
+    free(arg_machine_name);
+    free(root_dir);
+    dbus_connection_flush(con);
+    dbus_message_unref(message);
+    dbus_connection_unref(con);
+    return 0;
+}
+
+__uml_postsetup(machined_init);
diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
index c1dc892..b492243 100644
--- a/arch/um/os-Linux/umid.c
+++ b/arch/um/os-Linux/umid.c
@@ -14,6 +14,7 @@
 #include <sys/stat.h>
 #include <init.h>
 #include <os.h>
+#include <stdbool.h>
 
 #define UML_DIR "~/.uml/"
 
@@ -24,48 +25,52 @@ static char umid[UMID_LEN] = { 0 };
 
 /* Changed by set_uml_dir and make_uml_dir, which are run early in boot */
 static char *uml_dir = UML_DIR;
+static bool uml_dir_set = false;
+
+char* get_uml_dir_realpath(void) {
 
-static int __init make_uml_dir(void)
-{
 	char dir[512] = { '\0' };
-	int len, err;
+	int len = 0;
+	char* uml_dir_real = NULL;
+	char *uml_dir_local = uml_dir;
 
-	if (*uml_dir == '~') {
+	if (*uml_dir_local == '~') {
 		char *home = getenv("HOME");
 
-		err = -ENOENT;
 		if (home == NULL) {
 			printk(UM_KERN_ERR "make_uml_dir : no value in "
 			       "environment for $HOME\n");
 			goto err;
 		}
 		strlcpy(dir, home, sizeof(dir));
-		uml_dir++;
+		uml_dir_local++;
 	}
-	strlcat(dir, uml_dir, sizeof(dir));
+	strlcat(dir, uml_dir_local, sizeof(dir));
 	len = strlen(dir);
-	if (len > 0 && dir[len - 1] != '/')
+	if (len > 0 && dir[len - 1] != '/') {
 		strlcat(dir, "/", sizeof(dir));
+	}
 
-	err = -ENOMEM;
-	uml_dir = malloc(strlen(dir) + 1);
-	if (uml_dir == NULL) {
-		printf("make_uml_dir : malloc failed, errno = %d\n", errno);
+	uml_dir_real = malloc(strlen(dir) + 1);
+	if (uml_dir_real == NULL) {
+		printf("get_uml_dir_realpath : malloc failed, errno = %d\n", errno);
 		goto err;
 	}
-	strcpy(uml_dir, dir);
+	strcpy(uml_dir_real, dir);
+err:
+	return uml_dir_real;
+}
 
-	if ((mkdir(uml_dir, 0777) < 0) && (errno != EEXIST)) {
-	        printf("Failed to mkdir '%s': %s\n", uml_dir, strerror(errno));
+static int __init make_uml_dir(void)
+{
+    int err = 0;
+    char* uml_dir_real = get_uml_dir_realpath();
+
+	if ((mkdir(uml_dir_real, 0777) < 0) && (errno != EEXIST)) {
+	    printf("Failed to mkdir '%s': %s\n", uml_dir_real, strerror(errno));
 		err = -errno;
-		goto err_free;
 	}
-	return 0;
-
-err_free:
-	free(uml_dir);
-err:
-	uml_dir = NULL;
+	free(uml_dir_real);
 	return err;
 }
 
@@ -128,18 +133,17 @@ out:
  *	this boot racing with a shutdown of the other UML
  * In any of these cases, the directory isn't useful for anything else.
  *
- * Boolean return: 1 if in use, 0 otherwise.
+ * Boolean return: true if in use, false otherwise.
  */
-static inline int is_umdir_used(char *dir)
+static inline bool is_umdir_used(char *dir)
 {
 	char file[strlen(uml_dir) + UMID_LEN + sizeof("/pid\0")];
 	char pid[sizeof("nnnnn\0")], *end;
-	int dead, fd, p, n, err;
+	int dead, fd, p, n;
 
 	n = snprintf(file, sizeof(file), "%s/pid", dir);
 	if (n >= sizeof(file)) {
 		printk(UM_KERN_ERR "is_umdir_used - pid filename too long\n");
-		err = -E2BIG;
 		goto out;
 	}
 
@@ -154,7 +158,6 @@ static inline int is_umdir_used(char *dir)
 		goto out;
 	}
 
-	err = 0;
 	n = read(fd, pid, sizeof(pid));
 	if (n < 0) {
 		printk(UM_KERN_ERR "is_umdir_used : couldn't read pid file "
@@ -176,13 +179,13 @@ static inline int is_umdir_used(char *dir)
 	if ((kill(p, 0) == 0) || (errno != ESRCH)) {
 		printk(UM_KERN_ERR "umid \"%s\" is already in use by pid %d\n",
 		       umid, p);
-		return 1;
+		return true;
 	}
 
 out_close:
 	close(fd);
 out:
-	return 0;
+	return false;
 }
 
 /*
@@ -194,7 +197,7 @@ out:
 static int umdir_take_if_dead(char *dir)
 {
 	int ret;
-	if (is_umdir_used(dir))
+	if (is_umdir_used(dir) == true)
 		return -EEXIST;
 
 	ret = remove_files_and_dir(dir);
@@ -350,6 +353,10 @@ char *get_umid(void)
 
 static int __init set_uml_dir(char *name, int *add)
 {
+    if(uml_dir_set == true) {
+        free(uml_dir);
+    }
+
 	if (*name == '\0') {
 		printf("uml_dir can't be an empty string\n");
 		return 0;
@@ -371,7 +378,7 @@ static int __init set_uml_dir(char *name, int *add)
 		return 0;
 	}
 	sprintf(uml_dir, "%s/", name);
-
+	uml_dir_set = true;
 	return 0;
 }
 
-- 
1.9.3



------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

