Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C42uN-0003xY-Qk for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 05 Sep 2004 12:42:39 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C42uJ-0002Ne-NV for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 05 Sep 2004 12:42:38 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200408291307.11051.blaisorblade_spam@yahoo.it>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PkzOBCehTmF3ocx"
Subject: [uml-devel] The new filehandle abstraction: doubts and complaints
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
Date: Sun, 5 Sep 2004 18:04:31 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net


--Boundary-00=_PkzOBCehTmF3ocx
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

About the filehandle abstraction, the idea is nice, but there is something I 
don't like about the implementation:

- locking is not complete: active_handle moves fh->list without holding 
open_files_lock. 

- is_reclaimable should become make_reclaimable: the name is_reclaimable 
should be reserved for a function which says if the fd is reclaimable or not, 
if that function is needed. Probably we don't need this, but this is what 
"is_reclaimable" makes me think:

int is_reclaimable(struct file_handle *fh) {
	//XXX: Add some BUG_ON lines.
	return (!list_empty(&fh->list));
}

- there is an implicit race between using a fd and closing it: there is no 
reason why someone shouldn't be closing the fd while we are reading from it 
(or just after it has been read from the struct and before we do the syscall, 
more exactly). Remember that we are preemptible! A better idea would be this: 
active_handle() moves the fh off the list and then, on return, the caller 
moves it back on the list if it was there (and on top of the list, to be 
marked as recently used). This, anyway, is not safe against multiple users: 
it seems that for now there is not this need, but otherwise it would be 
better to refcount them, and putting them on the free list when the refcount 
goes to 0. It's not implemented in the sample patch attached, but it's easy 
to do.

- some BUG_ON lines should be added, about possible inconsistencies in the 
filehandle state (and describing the possible states of and filehandle 
wouldn't be bad).

The patch I'm attaching contains some of the needed changes to the API, 
without touching its users, because I don't know if my proposal will become 
the actual API or not.

Comments are appreciated.
Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


--Boundary-00=_PkzOBCehTmF3ocx
Content-Type: text/x-diff; charset="us-ascii";
	name="uml-filehandle-locking-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-filehandle-locking-fix.patch"


This is a sample patch, which does not update users of the filehandle API,
which corrects some broken design of the implementation.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/arch/um/include/filehandle.h |   14 +
 uml-linux-2.6.8.1-paolo/arch/um/kernel/filehandle.c  |  186 +++++++++++++------
 uml-linux-2.6.8.1-paolo/arch/um/os-Linux/file.c      |   51 ++++-
 3 files changed, 190 insertions(+), 61 deletions(-)

diff -puN arch/um/kernel/filehandle.c~uml-filehandle-locking-fix arch/um/kernel/filehandle.c
--- uml-linux-2.6.8.1/arch/um/kernel/filehandle.c~uml-filehandle-locking-fix	2004-08-30 21:02:50.552835992 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/kernel/filehandle.c	2004-08-30 21:34:39.819583328 +0200
@@ -9,6 +9,7 @@
 #include "linux/fs.h"
 #include "linux/errno.h"
 #include "linux/module.h"
+#include "asm/bug.h"
 #include "filehandle.h"
 #include "os.h"
 #include "kern_util.h"
@@ -18,22 +19,48 @@ static struct list_head open_files = LIS
 
 #define NUM_RECLAIM 128
 
-static void reclaim_fds(void)
+/*
+ * A filehandle can be:
+ * - open and in use; you must call not_reclaimable() on it, which moves
+ *   it off the list. Note that open_filehandle() returns a filehandle in
+ *   this state. In this case fd != -1, and list_empty(&list) is true.
+ *
+ * - open and reclaimable; it is then (only in this case) on the list. In this
+ *   case get_name must be != NULL. reclaim_fds() can freely move it in the
+ *   "reclaimed away" state.
+ *
+ * - reclaimed away: fd = -1. Only reclaim_fds() can put it here; it is called
+ *   by any API filehandle-aware which request a fd. Also here,
+ *   list_empty(&list) is true. It will go back to "open" state when invoking read_file
+ *   on it.
+ *
+ * inode is a parameter which is passed to get_name. It could be anything;
+ * you must make sure that it does not go away under us.
+ * XXX: make it a void*.
+ * In externfs's, this is guaranted because when the inode goes away, so does the
+ * filehandle. Or at least it should.
+ */
+
+void reclaim_fds(void)
 {
 	struct file_handle *victim;
 	int closed = NUM_RECLAIM;
+	int fd;
 
 	spin_lock(&open_files_lock);
 	while(!list_empty(&open_files) && closed--){
 		victim = list_entry(open_files.prev, struct file_handle, list);
-		os_close_file(victim->fd);
+		fd = victim->fd;
+		/*First make it unreachable, then close it. But
+		 * the other thread could reopen it while closed.*/
 		victim->fd = -1;
+		os_close_file(fd);
 		list_del_init(&victim->list);
 	}
 	spin_unlock(&open_files_lock);
 }
 
-int open_file(char *name, struct openflags flags, int mode)
+/*int open_file(char *name, struct openflags flags, int mode)
 {
 	int fd;
 
@@ -66,83 +93,114 @@ void *open_dir(char *file)
 
 	return(dir);
 }
-EXPORT_SYMBOL(open_dir);
+EXPORT_SYMBOL(open_dir);*/
 
-void not_reclaimable(struct file_handle *fh)
+static inline void __fh_put_fd(struct file_handle *fh)
 {
-	char *name;
-
-	if(fh->get_name == NULL)
-		return;
+	spin_lock(&open_files_lock);
+	list_add(&fh->list, &open_files);
+	spin_unlock(&open_files_lock);
+}
 
-	if(list_empty(&fh->list)){
-		name = (*fh->get_name)(fh->inode);
-		if(name != NULL){
-			fh->fd = open_file(name, fh->flags, 0);
-			kfree(name);
-		}
-		else printk("File descriptor %d has no name\n", fh->fd);
-	}
-	else {
-		spin_lock(&open_files_lock);
-		list_del_init(&fh->list);
-		spin_unlock(&open_files_lock);
-	}
+void fh_put_fd(struct file_handle *fh)
+{
+	__fh_put_fd(fh);
 }
-EXPORT_SYMBOL(not_reclaimable);
+EXPORT_SYMBOL(fh_put_fd);
 
-void is_reclaimable(struct file_handle *fh, char *(name_proc)(struct inode *),
+void make_reclaimable(struct file_handle *fh, char *(name_proc)(struct inode *),
 		    struct inode *inode)
 {
 	fh->get_name = name_proc;
 	fh->inode = inode;
 
-	spin_lock(&open_files_lock);
-	list_add(&fh->list, &open_files);
-	spin_unlock(&open_files_lock);
+	__fh_put_fd(fh);
 }
-EXPORT_SYMBOL(is_reclaimable);
+EXPORT_SYMBOL(make_reclaimable);
 
-static int active_handle(struct file_handle *fh)
+static int active_handle(struct file_handle *fh, int *is_reclaimable)
 {
 	int fd;
 	char *name;
 
-	if(!list_empty(&fh->list))
-		list_move(&fh->list, &open_files);
+	*is_reclaimable = 0;
+	spin_lock(&open_files_lock);
+
+	if(!list_empty(&fh->list)) {
+		BUG_ON(fh->fd == -1);
+		list_del_init(&fh->list, &open_files);
+		*is_reclaimable = 1;
+	}
+
+	spin_unlock(&open_files_lock);
 
 	if(fh->fd != -1)
 		return(0);
 
-	if(fh->inode == NULL)
-		return(-ENOENT);
+	if(fh->get_name == NULL) {
+		fd = -ENOENT;
+		goto out;
+	}
 
 	name = (*fh->get_name)(fh->inode);
-	if(name == NULL)
-		return(-ENOMEM);
+	if(name == NULL) {
+		fd = -ENOMEM;
+		goto out;
+	}
 
 	fd = open_file(name, fh->flags, 0);
 	kfree(name);
 	if(fd < 0)
-		return(fd);
+		goto out;
 
 	fh->fd = fd;
-	is_reclaimable(fh, fh->get_name, fh->inode);
+	fd = 0;
+	/*make_reclaimable(fh, fh->get_name, fh->inode);*/
 
-	return(0);
+out:
+	if (fd < 0 && *is_reclaimable)
+		__fh_put_fd(fh); /*Only on error!*/
+	return(fd);
 }
 
-int filehandle_fd(struct file_handle *fh)
+void not_reclaimable(struct file_handle *fh)
+{
+	char *name;
+
+	spin_lock(&open_files_lock);
+	if(list_empty(&fh->list)){
+		/*Off list, can't be modified.*/
+		spin_unlock(&open_files_lock);
+		if(fh->get_name == NULL)
+			return;
+
+		name = (*fh->get_name)(fh->inode);
+		if(name != NULL){
+			fh->fd = open_file(name, fh->flags, 0);
+			kfree(name);
+		}
+		else printk("File descriptor %d has no name\n", fh->fd);
+	} else {
+		BUG_ON(fh->fd == -1);
+		list_del_init(&fh->list);
+		spin_unlock(&open_files_lock);
+	}
+}
+EXPORT_SYMBOL(not_reclaimable);
+
+/*XXX: We must change all users of this. It was filehandle_fd*/
+int fh_get_fd(struct file_handle *fh, int *is_reclaimable)
 {
 	int err;
+	int is_reclaimable;
 
-	err = active_handle(fh);
+	err = active_handle(fh, &is_reclaimable);
 	if(err)
 		return(err);
 
 	return(fh->fd);
 }
-EXPORT_SYMBOL(filehandle_fd);
+EXPORT_SYMBOL(fh_get_fd);
 
 static void init_fh(struct file_handle *fh, int fd, struct openflags flags)
 {
@@ -185,16 +243,23 @@ int read_file(struct file_handle *fh, un
 	      int len)
 {
 	int err;
+	int is_reclaimable;
 
-	err = active_handle(fh);
+	err = active_handle(fh, &is_reclaimable);
 	if(err)
-		return(err);
+		goto noreclaim;
 
 	err = os_seek_file(fh->fd, offset);
 	if(err)
-		return(err);
+		goto out;
+
+	err = os_read_file(fh->fd, buf, len);
 
-	return(os_read_file(fh->fd, buf, len));
+out:
+	if (is_reclaimable)
+		__fh_put_fd(fh);
+noreclaim:
+	return(err);
 }
 EXPORT_SYMBOL(read_file);
 
@@ -202,33 +267,46 @@ int write_file(struct file_handle *fh, u
 	       const char *buf, int len)
 {
 	int err;
+	int is_reclaimable;
 
-	err = active_handle(fh);
+	err = active_handle(fh, &is_reclaimable);
 	if(err)
-		return(err);
+		goto noreclaim;
 
 	if(offset != -1)
 		err = os_seek_file(fh->fd, offset);
 	if(err)
-		return(err);
+		goto out;
 
-	return(os_write_file(fh->fd, buf, len));
+	err = os_write_file(fh->fd, buf, len);
+
+out:
+	if (is_reclaimable)
+		__fh_put_fd(fh);
+noreclaim:
+	return(err);
 }
 EXPORT_SYMBOL(write_file);
 
 int truncate_file(struct file_handle *fh, unsigned long long size)
 {
 	int err;
+	int is_reclaimable;
 
-	err = active_handle(fh);
+	err = active_handle(fh, &is_reclaimable);
 	if(err)
-		return(err);
+		goto noreclaim;
 
-	return(os_truncate_fd(fh->fd, size));
+	err = os_truncate_fd(fh->fd, size);
+
+	if (is_reclaimable)
+		__fh_put_fd(fh);
+noreclaim:
+	return(err);
 }
 EXPORT_SYMBOL(truncate_file);
 
-int make_pipe(struct file_handle *fhs)
+/*int make_pipe(struct file_handle *fhs)
 {
 	int fds[2], err;
 
@@ -246,7 +324,7 @@ int make_pipe(struct file_handle *fhs)
 	init_fh(&fhs[0], fds[0], OPENFLAGS());
 	init_fh(&fhs[1], fds[1], OPENFLAGS());
 	return(0);
-}
+}*/
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -puN arch/um/include/filehandle.h~uml-filehandle-locking-fix arch/um/include/filehandle.h
--- uml-linux-2.6.8.1/arch/um/include/filehandle.h~uml-filehandle-locking-fix	2004-08-30 21:02:50.553835840 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/include/filehandle.h	2004-08-30 21:19:18.630625336 +0200
@@ -20,8 +20,8 @@ struct file_handle {
 
 extern struct file_handle bad_filehandle;
 
-extern int open_file(char *name, struct openflags flags, int mode);
-extern void *open_dir(char *file);
+/*extern int open_file(char *name, struct openflags flags, int mode);
+extern void *open_dir(char *file);*/
 extern int open_filehandle(char *name, struct openflags flags, int mode, 
 			   struct file_handle *fh);
 extern int read_file(struct file_handle *fh, unsigned long long offset, 
@@ -31,11 +31,17 @@ extern int write_file(struct file_handle
 extern int truncate_file(struct file_handle *fh, unsigned long long size);
 extern int close_file(struct file_handle *fh);
 extern void not_reclaimable(struct file_handle *fh);
-extern void is_reclaimable(struct file_handle *fh, 
+extern void make_reclaimable(struct file_handle *fh,
 			   char *(name_proc)(struct inode *),
 			   struct inode *inode);
+
+extern int fh_get_fd(struct file_handle *fh, int *is_reclaimable);
+extern void fh_put_fd(struct file_handle *fh);
+
+#define is_reclaimable make_reclaimable
+
 extern int filehandle_fd(struct file_handle *fh);
-extern int make_pipe(struct file_handle *fhs);
+/*extern int make_pipe(struct file_handle *fhs);*/
 
 #endif
 
diff -puN arch/um/os-Linux/file.c~uml-filehandle-locking-fix arch/um/os-Linux/file.c
--- uml-linux-2.6.8.1/arch/um/os-Linux/file.c~uml-filehandle-locking-fix	2004-08-30 21:02:50.554835688 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/os-Linux/file.c	2004-08-30 21:02:50.558835080 +0200
@@ -23,6 +23,7 @@
 #include "os.h"
 #include "user.h"
 #include "kern_util.h"
+#include "filehandle.h"
 
 static void copy_stat(struct uml_stat *dst, struct stat64 *src)
 {
@@ -315,8 +316,9 @@ int os_file_mode(char *file, struct open
 
 int os_open_file(char *file, struct openflags flags, int mode)
 {
-	int fd, f = 0;
+	int fd, f = 0, retried = 0;
 
+retry:
 	if(flags.r && flags.w) f = O_RDWR;
 	else if(flags.r) f = O_RDONLY;
 	else if(flags.w) f = O_WRONLY;
@@ -329,9 +331,16 @@ int os_open_file(char *file, struct open
 	if(flags.d) f |= O_DIRECT;
 
 	fd = open64(file, f, mode);
-	if(fd < 0)
+
+	if(fd < 0 && errno != EMFILE)
 		return(-errno);
 
+	if (fd == -1 && (errno == EMFILE || errno == ENFILE) && !retried) {
+		reclaim_fds();
+		retried = 1;
+		goto retry;
+	}
+
 	if(flags.cl && fcntl(fd, F_SETFD, 1)){
 		os_close_file(fd);
 		return(-errno);
@@ -343,8 +352,17 @@ int os_open_file(char *file, struct open
 void *os_open_dir(char *path, int *err_out)
 {
 	void *dir;
+	int retried = 0;
 
+retry:
 	dir = opendir(path);
+
+	if (fd == -1 && (errno == EMFILE || errno == ENFILE) && !retried) {
+		reclaim_fds();
+		retried = 1;
+		goto retry;
+	}
+
 	*err_out = -errno;
 	return(dir);
 }
@@ -434,13 +452,22 @@ int os_connect_socket(char *name)
 {
 	struct sockaddr_un sock;
 	int fd, err;
+	int retried = 0;
 
 	sock.sun_family = AF_UNIX;
 	snprintf(sock.sun_path, sizeof(sock.sun_path), "%s", name);
 
+retry:
 	fd = socket(AF_UNIX, SOCK_STREAM, 0);
+
+	if (fd == -1 && (errno == EMFILE || errno == ENFILE) && !retried) {
+		reclaim_fds();
+		retried = 1;
+		goto retry;
+	}
+
 	if(fd < 0)
-		return(fd);
+		return(-errno);
 
 	err = connect(fd, (struct sockaddr *) &sock, sizeof(sock));
 	if(err)
@@ -610,8 +637,17 @@ int os_set_exec_close(int fd, int close_
 int os_pipe(int *fds, int stream, int close_on_exec)
 {
 	int err, type = stream ? SOCK_STREAM : SOCK_DGRAM;
+	int retried = 0;
 
+retry:
 	err = socketpair(AF_UNIX, type, 0, fds);
+
+	if (err == -1 && (errno == EMFILE || errno == ENFILE) && !retried) {
+		reclaim_fds();
+		retried = 1;
+		goto retry;
+	}
+
 	if(err < 0) 
 		return(-errno);
 
@@ -771,8 +807,17 @@ int os_create_unix_socket(char *file, in
 {
 	struct sockaddr_un addr;
 	int sock, err;
+	int retried = 0;
 
+retry:
 	sock = socket(PF_UNIX, SOCK_DGRAM, 0);
+
+	if (sock == -1 && (errno == EMFILE || errno == ENFILE) && !retried) {
+		reclaim_fds();
+		retried = 1;
+		goto retry;
+	}
+
 	if (sock < 0){
 		printk("create_unix_socket - socket failed, errno = %d\n",
 		       errno);
_

--Boundary-00=_PkzOBCehTmF3ocx--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
