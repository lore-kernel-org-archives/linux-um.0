Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AjNpz-0003jr-PZ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Jan 2004 11:16:27 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AjNpy-00065F-MN for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Jan 2004 11:16:26 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] First shrinkage of *_user.c files
References: <200401202026.19785.blaisorblade_spam@yahoo.it>
In-Reply-To: <200401202026.19785.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_mCtDAEC/b8RuRf9"
Message-Id: <200401212019.02494.blaisorblade_spam@yahoo.it>
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
Date: Wed, 21 Jan 2004 20:19:02 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>



--Boundary-00=_mCtDAEC/b8RuRf9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Alle 20:26, marted=EC 20 gennaio 2004, BlaisorBlade ha scritto:
> The next thing I'm going to do is to remove entirely
> hostaudio_user.c (I've already started this, but I've not got a successful
> test yet, since I also did a little fix in this).
Now I've got a successful test (the host /dev/dsp was locked by KDE's Arts)=
=2E=20
However, when testing it with /dev/dsp locked, UML freezes completely (I=20
think this happens anyway, since the open() is called without O_NONBLOCK an=
d=20
so it seems obvious why it locks). The export_ioctl adds a missing=20
EXPORT_SYMBOL, while Os_expand_3 is a less intrusive version of=20
Hostaudio_clean_and_fix, that doesn't fold the _user calls inside the other=
=20
ones.

Bye

=2D-=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.23/2.6.0 on an i686; Linux registered user n. 292729
EOSIGN



--Boundary-00=_mCtDAEC/b8RuRf9
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="Export_ioctl.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="Export_ioctl.diff"

--- ./arch/um/kernel/ksyms.c.fix	2004-01-17 18:41:14.000000000 +0100
+++ ./arch/um/kernel/ksyms.c	2004-01-20 17:47:26.000000000 +0100
@@ -69,6 +69,7 @@
 EXPORT_SYMBOL(os_write_file);
 EXPORT_SYMBOL(os_seek_file);
 EXPORT_SYMBOL(os_lock_file);
+EXPORT_SYMBOL(os_ioctl_generic);
 EXPORT_SYMBOL(os_pipe);
 EXPORT_SYMBOL(os_file_type);
 EXPORT_SYMBOL(os_file_mode);

--Boundary-00=_mCtDAEC/b8RuRf9
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="Os_expand_3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="Os_expand_3.diff"

--- ./arch/um/drivers/hostaudio_kern.c.fix	2004-01-17 18:41:10.000000000 +0100
+++ ./arch/um/drivers/hostaudio_kern.c	2004-01-20 16:28:31.000000000 +0100
@@ -13,7 +13,18 @@
 #include "asm/uaccess.h"
 #include "kern_util.h"
 #include "init.h"
-#include "hostaudio.h"
+#include "os.h"
+
+struct hostaudio_state {
+  int fd;
+};
+
+struct hostmixer_state {
+  int fd;
+};
+
+#define HOSTAUDIO_DEV_DSP "/dev/sound/dsp"
+#define HOSTAUDIO_DEV_MIXER "/dev/sound/mixer"
 
 /* Only changed from linux_main at boot time */
 char *dsp = HOSTAUDIO_DEV_DSP;
@@ -56,6 +67,66 @@
 
 /* /dev/dsp file operations */
 
+static inline ssize_t hostaudio_read_user(struct hostaudio_state *state, char *buffer, 
+			    size_t count, loff_t *ppos)
+{
+#ifdef DEBUG
+        printk("hostaudio: read_user called, count = %d\n", count);
+#endif
+
+	return(os_read_file(state->fd, buffer, count));
+}
+
+static inline ssize_t hostaudio_write_user(struct hostaudio_state *state, const char *buffer,
+			     size_t count, loff_t *ppos)
+{
+#ifdef DEBUG
+        printk("hostaudio: write_user called, count = %d\n", count);
+#endif
+
+	return(os_write_file(state->fd, buffer, count));
+}
+
+static inline int hostaudio_ioctl_user(struct hostaudio_state *state, unsigned int cmd, 
+			 unsigned long arg)
+{
+#ifdef DEBUG
+        printk("hostaudio: ioctl_user called, cmd = %u\n", cmd);
+#endif
+
+	return(os_ioctl_generic(state->fd, cmd, arg));
+}
+
+static inline int hostaudio_open_user(struct hostaudio_state *state, int r, int w, char *dsp)
+{
+#ifdef DEBUG
+        printk("hostaudio: open_user called\n");
+#endif
+
+	state->fd = os_open_file(dsp, of_set_rw(OPENFLAGS(), r, w), 0);
+
+	if(state->fd < 0) {
+		printk("hostaudio_open_user failed to open '%s', err = %d\n",
+		       dsp, -state->fd);
+		return(state->fd); 
+	}
+        
+	return(0);
+}
+
+static inline int hostaudio_release_user(struct hostaudio_state *state)
+{
+#ifdef DEBUG
+        printk("hostaudio: release called\n");
+#endif
+	if(state->fd >= 0){
+		os_close_file(state->fd);
+		state->fd = -1;
+	}
+
+        return(0);
+}
+
 static ssize_t hostaudio_read(struct file *file, char *buffer, size_t count, 
 			      loff_t *ppos)
 {
@@ -209,6 +280,48 @@
 
 /* /dev/mixer file operations */
 
+static inline int hostmixer_ioctl_mixdev_user(struct hostmixer_state *state, 
+				unsigned int cmd, unsigned long arg)
+{
+#ifdef DEBUG
+        printk("hostmixer: ioctl_user called cmd = %u\n",cmd);
+#endif
+
+	return(os_ioctl_generic(state->fd, cmd, arg));
+}
+
+static inline int hostmixer_open_mixdev_user(struct hostmixer_state *state, int r, int w,
+			       char *mixer)
+{
+#ifdef DEBUG
+        printk("hostmixer: open_user called\n");
+#endif
+
+        state->fd = os_open_file(mixer, of_set_rw(OPENFLAGS(), r, w), 0);
+
+	if(state->fd < 0) {
+	        printk("hostaudio_open_mixdev_user failed to open '%s', "
+		       "err = %d\n", mixer, state->fd);
+		return(state->fd); 
+	}
+        
+	return(0);
+}
+
+static inline int hostmixer_release_mixdev_user(struct hostmixer_state *state)
+{
+#ifdef DEBUG
+        printk("hostmixer: release_user called\n");
+#endif
+
+        if(state->fd >= 0){
+		os_close_file(state->fd);
+		state->fd = -1;
+        }
+
+        return 0;
+}
+
 static int hostmixer_ioctl_mixdev(struct inode *inode, struct file *file, 
 				  unsigned int cmd, unsigned long arg)
 {
--- ./arch/um/drivers/hostaudio_user.c.fix	2004-01-17 18:41:10.000000000 +0100
+++ ./arch/um/drivers/hostaudio_user.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,130 +0,0 @@
-/* 
- * Copyright (C) 2002 Steve Schmidtke 
- * Licensed under the GPL
- */
-
-#include <sys/types.h>
-#include <unistd.h>
-#include <errno.h>
-#include "hostaudio.h"
-#include "user_util.h"
-#include "kern_util.h"
-#include "user.h"
-#include "os.h"
-
-/* /dev/dsp file operations */
-
-ssize_t hostaudio_read_user(struct hostaudio_state *state, char *buffer, 
-			    size_t count, loff_t *ppos)
-{
-#ifdef DEBUG
-        printk("hostaudio: read_user called, count = %d\n", count);
-#endif
-
-	return(os_read_file(state->fd, buffer, count));
-}
-
-ssize_t hostaudio_write_user(struct hostaudio_state *state, const char *buffer,
-			     size_t count, loff_t *ppos)
-{
-#ifdef DEBUG
-        printk("hostaudio: write_user called, count = %d\n", count);
-#endif
-
-	return(os_write_file(state->fd, buffer, count));
-}
-
-int hostaudio_ioctl_user(struct hostaudio_state *state, unsigned int cmd, 
-			 unsigned long arg)
-{
-#ifdef DEBUG
-        printk("hostaudio: ioctl_user called, cmd = %u\n", cmd);
-#endif
-
-	return(os_ioctl_generic(state->fd, cmd, arg));
-}
-
-int hostaudio_open_user(struct hostaudio_state *state, int r, int w, char *dsp)
-{
-#ifdef DEBUG
-        printk("hostaudio: open_user called\n");
-#endif
-
-	state->fd = os_open_file(dsp, of_set_rw(OPENFLAGS(), r, w), 0);
-
-	if(state->fd < 0) {
-		printk("hostaudio_open_user failed to open '%s', err = %d\n",
-		       dsp, -state->fd);
-		return(state->fd); 
-	}
-        
-	return(0);
-}
-
-int hostaudio_release_user(struct hostaudio_state *state)
-{
-#ifdef DEBUG
-        printk("hostaudio: release called\n");
-#endif
-	if(state->fd >= 0){
-		os_close_file(state->fd);
-		state->fd = -1;
-	}
-
-        return(0);
-}
-
-/* /dev/mixer file operations */
-
-int hostmixer_ioctl_mixdev_user(struct hostmixer_state *state, 
-				unsigned int cmd, unsigned long arg)
-{
-#ifdef DEBUG
-        printk("hostmixer: ioctl_user called cmd = %u\n",cmd);
-#endif
-
-	return(os_ioctl_generic(state->fd, cmd, arg));
-}
-
-int hostmixer_open_mixdev_user(struct hostmixer_state *state, int r, int w,
-			       char *mixer)
-{
-#ifdef DEBUG
-        printk("hostmixer: open_user called\n");
-#endif
-
-        state->fd = os_open_file(mixer, of_set_rw(OPENFLAGS(), r, w), 0);
-
-	if(state->fd < 0) {
-	        printk("hostaudio_open_mixdev_user failed to open '%s', "
-		       "err = %d\n", mixer, state->fd);
-		return(state->fd); 
-	}
-        
-	return(0);
-}
-
-int hostmixer_release_mixdev_user(struct hostmixer_state *state)
-{
-#ifdef DEBUG
-        printk("hostmixer: release_user called\n");
-#endif
-
-        if(state->fd >= 0){
-		os_close_file(state->fd);
-		state->fd = -1;
-        }
-
-        return 0;
-}
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
--- ./arch/um/drivers/Makefile.fix	2004-01-18 10:07:33.000000000 +0100
+++ ./arch/um/drivers/Makefile	2004-01-20 16:25:14.000000000 +0100
@@ -15,7 +15,7 @@
 #pcap-objs := pcap_kern.o pcap_user.o $(PCAP)
 net-objs := net_kern.o net_user.o
 mconsole-objs := mconsole_kern.o mconsole_user.o
-hostaudio-objs := hostaudio_kern.o hostaudio_user.o
+hostaudio-objs := hostaudio_kern.o
 ubd-objs := ubd_kern.o ubd_user.o
 port-objs := port_kern.o port_user.o
 harddog-objs := harddog_kern.o harddog_user.o
--- ./arch/um/include/hostaudio.h.fix	2003-12-20 16:58:43.000000000 +0100
+++ ./arch/um/include/hostaudio.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,48 +0,0 @@
-/* 
- * Copyright (C) 2002 Steve Schmidtke 
- * Licensed under the GPL
- */
-
-#ifndef HOSTAUDIO_H
-#define HOSTAUDIO_H
-
-#define HOSTAUDIO_DEV_DSP "/dev/sound/dsp"
-#define HOSTAUDIO_DEV_MIXER "/dev/sound/mixer"
-
-struct hostaudio_state {
-  int fd;
-};
-
-struct hostmixer_state {
-  int fd;
-};
-
-/* UML user-side protoypes */
-extern ssize_t hostaudio_read_user(struct hostaudio_state *state, char *buffer,
-				   size_t count, loff_t *ppos);
-extern ssize_t hostaudio_write_user(struct hostaudio_state *state, 
-				    const char *buffer, size_t count, 
-				    loff_t *ppos);
-extern int hostaudio_ioctl_user(struct hostaudio_state *state, 
-				unsigned int cmd, unsigned long arg);
-extern int hostaudio_open_user(struct hostaudio_state *state, int r, int w, 
-			       char *dsp);
-extern int hostaudio_release_user(struct hostaudio_state *state);
-extern int hostmixer_ioctl_mixdev_user(struct hostmixer_state *state, 
-				unsigned int cmd, unsigned long arg);
-extern int hostmixer_open_mixdev_user(struct hostmixer_state *state, int r, 
-				      int w, char *mixer);
-extern int hostmixer_release_mixdev_user(struct hostmixer_state *state);
-
-#endif /* HOSTAUDIO_H */
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */

--Boundary-00=_mCtDAEC/b8RuRf9
Content-Type: text/x-diff; charset="iso-8859-1";
	name="Hostaudio_clean_and_fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="Hostaudio_clean_and_fix.diff"

--- ./arch/um/drivers/hostaudio_kern.c.fix	2004-01-20 17:42:12.000000000 +0100
+++ ./arch/um/drivers/hostaudio_kern.c	2004-01-21 20:13:17.000000000 +0100
@@ -13,7 +13,18 @@
 #include "asm/uaccess.h"
 #include "kern_util.h"
 #include "init.h"
-#include "hostaudio.h"
+#include "os.h"
+
+struct hostaudio_state {
+  int fd;
+};
+
+struct hostmixer_state {
+  int fd;
+};
+
+#define HOSTAUDIO_DEV_DSP "/dev/sound/dsp"
+#define HOSTAUDIO_DEV_MIXER "/dev/sound/mixer"
 
 /* Only changed from linux_main at boot time */
 char *dsp = HOSTAUDIO_DEV_DSP;
@@ -61,7 +72,7 @@
 {
         struct hostaudio_state *state = file->private_data;
 	void *kbuf;
-	int err;
+	int ret;
 
 #ifdef DEBUG
         printk("hostaudio: read called, count = %d\n", count);
@@ -71,16 +82,18 @@
 	if(kbuf == NULL)
 		return(-ENOMEM);
 
-        err = hostaudio_read_user(state, kbuf, count, ppos);
-	if(err < 0)
+	ret = os_read_file(state->fd, kbuf, count);
+	if(ret < 0)
 		goto out;
 
-	if(copy_to_user(buffer, kbuf, err))
-		err = -EFAULT;
+	if(copy_to_user(buffer, kbuf, ret))
+		ret = -EFAULT;
+	else
+		*ppos += ret;
 
  out:
 	kfree(kbuf);
-	return(err);
+	return(ret);
 }
 
 static ssize_t hostaudio_write(struct file *file, const char *buffer, 
@@ -88,7 +101,7 @@
 {
         struct hostaudio_state *state = file->private_data;
 	void *kbuf;
-	int err;
+	int ret;
 
 #ifdef DEBUG
         printk("hostaudio: write called, count = %d\n", count);
@@ -98,17 +111,18 @@
 	if(kbuf == NULL)
 		return(-ENOMEM);
 
-	err = -EFAULT;
+	ret = -EFAULT;
 	if(copy_from_user(kbuf, buffer, count))
 		goto out;
 
-        err = hostaudio_write_user(state, kbuf, count, ppos);
-	if(err < 0)
+	ret = os_write_file(state->fd, kbuf, count);
+	if(ret < 0)
 		goto out;
+	*ppos += ret;
 
  out:
 	kfree(kbuf);
-	return(err);
+	return(ret);
 }
 
 static unsigned int hostaudio_poll(struct file *file, 
@@ -128,7 +142,7 @@
 {
         struct hostaudio_state *state = file->private_data;
 	unsigned long data = 0;
-	int err;
+	int ret;
 
 #ifdef DEBUG
         printk("hostaudio: ioctl called, cmd = %u\n", cmd);
@@ -147,7 +161,7 @@
 		break;
 	}
 
-        err = hostaudio_ioctl_user(state, cmd, (unsigned long) &data);
+	ret = os_ioctl_generic(state->fd, cmd, (unsigned long) &data);
 
 	switch(cmd){
 	case SNDCTL_DSP_SPEED:
@@ -163,7 +177,7 @@
 		break;
 	}
 
-	return(err);
+	return(ret);
 }
 
 static int hostaudio_open(struct inode *inode, struct file *file)
@@ -182,12 +196,17 @@
         if(file->f_mode & FMODE_READ) r = 1;
         if(file->f_mode & FMODE_WRITE) w = 1;
 
-        ret = hostaudio_open_user(state, r, w, dsp);
+	ret = os_open_file(dsp, of_set_rw(OPENFLAGS(), r, w), 0);
+
         if(ret < 0){
+		printk("hostaudio_open failed to open '%s', err = %d\n",
+		       dsp, -ret);
 		kfree(state);
 		return(ret);
         }
 
+	state->fd = ret;
+
         file->private_data = state;
         return(0);
 }
@@ -195,16 +214,19 @@
 static int hostaudio_release(struct inode *inode, struct file *file)
 {
         struct hostaudio_state *state = file->private_data;
-        int ret;
 
 #ifdef DEBUG
         printk("hostaudio: release called\n");
 #endif
 
-        ret = hostaudio_release_user(state);
+	if(state->fd >= 0){
+		os_close_file(state->fd);
+		state->fd = -1;
+	}
+
         kfree(state);
 
-        return(ret);
+	return(0);
 }
 
 /* /dev/mixer file operations */
@@ -218,7 +240,7 @@
         printk("hostmixer: ioctl called\n");
 #endif
 
-        return(hostmixer_ioctl_mixdev_user(state, cmd, arg));
+	return(os_ioctl_generic(state->fd, cmd, arg));
 }
 
 static int hostmixer_open_mixdev(struct inode *inode, struct file *file)
@@ -237,13 +259,17 @@
         if(file->f_mode & FMODE_READ) r = 1;
         if(file->f_mode & FMODE_WRITE) w = 1;
 
-        ret = hostmixer_open_mixdev_user(state, r, w, mixer);
+	ret = os_open_file(mixer, of_set_rw(OPENFLAGS(), r, w), 0);
         
         if(ret < 0){
+		printk("hostaudio_open_mixdev failed to open '%s', err = %d\n",
+		       dsp, -ret);
 		kfree(state);
 		return(ret);
         }
 
+	state->fd = ret;
+	
         file->private_data = state;
         return(0);
 }
@@ -251,16 +277,18 @@
 static int hostmixer_release(struct inode *inode, struct file *file)
 {
         struct hostmixer_state *state = file->private_data;
-	int ret;
 
 #ifdef DEBUG
         printk("hostmixer: release called\n");
 #endif
 
-        ret = hostmixer_release_mixdev_user(state);
+	if(state->fd >= 0){
+		os_close_file(state->fd);
+		state->fd = -1;
+	}
         kfree(state);
 
-        return(ret);
+	return(0);
 }
 
 
--- ./arch/um/drivers/hostaudio_user.c.fix	2004-01-17 18:41:10.000000000 +0100
+++ ./arch/um/drivers/hostaudio_user.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,130 +0,0 @@
-/* 
- * Copyright (C) 2002 Steve Schmidtke 
- * Licensed under the GPL
- */
-
-#include <sys/types.h>
-#include <unistd.h>
-#include <errno.h>
-#include "hostaudio.h"
-#include "user_util.h"
-#include "kern_util.h"
-#include "user.h"
-#include "os.h"
-
-/* /dev/dsp file operations */
-
-ssize_t hostaudio_read_user(struct hostaudio_state *state, char *buffer, 
-			    size_t count, loff_t *ppos)
-{
-#ifdef DEBUG
-        printk("hostaudio: read_user called, count = %d\n", count);
-#endif
-
-	return(os_read_file(state->fd, buffer, count));
-}
-
-ssize_t hostaudio_write_user(struct hostaudio_state *state, const char *buffer,
-			     size_t count, loff_t *ppos)
-{
-#ifdef DEBUG
-        printk("hostaudio: write_user called, count = %d\n", count);
-#endif
-
-	return(os_write_file(state->fd, buffer, count));
-}
-
-int hostaudio_ioctl_user(struct hostaudio_state *state, unsigned int cmd, 
-			 unsigned long arg)
-{
-#ifdef DEBUG
-        printk("hostaudio: ioctl_user called, cmd = %u\n", cmd);
-#endif
-
-	return(os_ioctl_generic(state->fd, cmd, arg));
-}
-
-int hostaudio_open_user(struct hostaudio_state *state, int r, int w, char *dsp)
-{
-#ifdef DEBUG
-        printk("hostaudio: open_user called\n");
-#endif
-
-	state->fd = os_open_file(dsp, of_set_rw(OPENFLAGS(), r, w), 0);
-
-	if(state->fd < 0) {
-		printk("hostaudio_open_user failed to open '%s', err = %d\n",
-		       dsp, -state->fd);
-		return(state->fd); 
-	}
-        
-	return(0);
-}
-
-int hostaudio_release_user(struct hostaudio_state *state)
-{
-#ifdef DEBUG
-        printk("hostaudio: release called\n");
-#endif
-	if(state->fd >= 0){
-		os_close_file(state->fd);
-		state->fd = -1;
-	}
-
-        return(0);
-}
-
-/* /dev/mixer file operations */
-
-int hostmixer_ioctl_mixdev_user(struct hostmixer_state *state, 
-				unsigned int cmd, unsigned long arg)
-{
-#ifdef DEBUG
-        printk("hostmixer: ioctl_user called cmd = %u\n",cmd);
-#endif
-
-	return(os_ioctl_generic(state->fd, cmd, arg));
-}
-
-int hostmixer_open_mixdev_user(struct hostmixer_state *state, int r, int w,
-			       char *mixer)
-{
-#ifdef DEBUG
-        printk("hostmixer: open_user called\n");
-#endif
-
-        state->fd = os_open_file(mixer, of_set_rw(OPENFLAGS(), r, w), 0);
-
-	if(state->fd < 0) {
-	        printk("hostaudio_open_mixdev_user failed to open '%s', "
-		       "err = %d\n", mixer, state->fd);
-		return(state->fd); 
-	}
-        
-	return(0);
-}
-
-int hostmixer_release_mixdev_user(struct hostmixer_state *state)
-{
-#ifdef DEBUG
-        printk("hostmixer: release_user called\n");
-#endif
-
-        if(state->fd >= 0){
-		os_close_file(state->fd);
-		state->fd = -1;
-        }
-
-        return 0;
-}
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
--- ./arch/um/drivers/Makefile.fix	2004-01-18 10:07:33.000000000 +0100
+++ ./arch/um/drivers/Makefile	2004-01-20 17:48:05.000000000 +0100
@@ -15,7 +15,7 @@
 #pcap-objs := pcap_kern.o pcap_user.o $(PCAP)
 net-objs := net_kern.o net_user.o
 mconsole-objs := mconsole_kern.o mconsole_user.o
-hostaudio-objs := hostaudio_kern.o hostaudio_user.o
+hostaudio-objs := hostaudio_kern.o
 ubd-objs := ubd_kern.o ubd_user.o
 port-objs := port_kern.o port_user.o
 harddog-objs := harddog_kern.o harddog_user.o
--- ./arch/um/include/hostaudio.h.fix	2003-12-20 16:58:43.000000000 +0100
+++ ./arch/um/include/hostaudio.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,48 +0,0 @@
-/* 
- * Copyright (C) 2002 Steve Schmidtke 
- * Licensed under the GPL
- */
-
-#ifndef HOSTAUDIO_H
-#define HOSTAUDIO_H
-
-#define HOSTAUDIO_DEV_DSP "/dev/sound/dsp"
-#define HOSTAUDIO_DEV_MIXER "/dev/sound/mixer"
-
-struct hostaudio_state {
-  int fd;
-};
-
-struct hostmixer_state {
-  int fd;
-};
-
-/* UML user-side protoypes */
-extern ssize_t hostaudio_read_user(struct hostaudio_state *state, char *buffer,
-				   size_t count, loff_t *ppos);
-extern ssize_t hostaudio_write_user(struct hostaudio_state *state, 
-				    const char *buffer, size_t count, 
-				    loff_t *ppos);
-extern int hostaudio_ioctl_user(struct hostaudio_state *state, 
-				unsigned int cmd, unsigned long arg);
-extern int hostaudio_open_user(struct hostaudio_state *state, int r, int w, 
-			       char *dsp);
-extern int hostaudio_release_user(struct hostaudio_state *state);
-extern int hostmixer_ioctl_mixdev_user(struct hostmixer_state *state, 
-				unsigned int cmd, unsigned long arg);
-extern int hostmixer_open_mixdev_user(struct hostmixer_state *state, int r, 
-				      int w, char *mixer);
-extern int hostmixer_release_mixdev_user(struct hostmixer_state *state);
-
-#endif /* HOSTAUDIO_H */
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */

--Boundary-00=_mCtDAEC/b8RuRf9--



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
