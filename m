Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BmfFP-00074e-IP for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Jul 2004 14:00:31 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1BmfFO-0002g2-Qt
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Jul 2004 14:00:31 -0700
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20040719204008.GA15091@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [patch] mconsole_proc rewrite (and crash fix).
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
Date: Mon, 19 Jul 2004 22:40:08 +0200
To: Jeff Dike <jdike@addtoit.com>, uml devel <user-mode-linux-devel@lists.sourceforge.net>

  Hi,

Below is a rewrite of the mconsole_proc function.

The old code had the problem that the kernel crashed after calling
"uml_mconsole proc <somefile>" a few times.  I havn't tracked what
exactly causes the problem, I guess trying to access the procfs without
actually mounting it somewhere causes some corruption of kernel data
structures.

The new code simply openes /proc/<file> via sys_open().  That simplifies
the function alot.  It also doesn't crash any more ;)
Drawback is that it only works when procfs is actually mounted below
/proc.  One suggestion I've received to fix the later issue was to mount
the procfs within a kernel thread with a private namespace, but I havn't
tried that so far.

  Gerd

--- a/arch/um/drivers/mconsole_kern.c.proc	2004-07-14 10:54:03.089015009 +0200
+++ b/arch/um/drivers/mconsole_kern.c	2004-07-14 20:03:52.812664794 +0200
@@ -19,6 +19,7 @@
 #include "linux/fs.h"
 #include "linux/namei.h"
 #include "linux/proc_fs.h"
+#include "linux/syscalls.h"
 #include "asm/irq.h"
 #include "asm/uaccess.h"
 #include "user_util.h"
@@ -120,77 +121,50 @@
 
 void mconsole_proc(struct mc_request *req)
 {
-	struct nameidata nd;
-	struct file_system_type *proc;
-	struct super_block *super;
-	struct file *file;
-	int n, err;
-	char *ptr = req->request.data, *buf;
-	
+	char path[64];
+	char *buf;
+	int len;
+	int fd;
+	char *ptr = req->request.data;
+
 	ptr += strlen("proc");
 	while(isspace(*ptr)) ptr++;
+	snprintf(path, sizeof(path), "/proc/%s", ptr);
 
-	proc = get_fs_type("proc");
-	if(proc == NULL){
-		mconsole_reply(req, "procfs not registered", 1, 0);
-		goto out;
-	}
-
-	super = (*proc->get_sb)(proc, 0, NULL, NULL);
-	put_filesystem(proc);
-	if(super == NULL){
-		mconsole_reply(req, "Failed to get procfs superblock", 1, 0);
-		goto out;
-	}
-	up_write(&super->s_umount);
-
-	nd.dentry = super->s_root;
-	nd.mnt = NULL;
-	nd.flags = O_RDONLY + 1;
-	nd.last_type = LAST_ROOT;
-
-	err = link_path_walk(ptr, &nd);
-	if(err){
-		mconsole_reply(req, "Failed to look up file", 1, 0);
-		goto out_kill;
-	}
-
-	file = dentry_open(nd.dentry, nd.mnt, O_RDONLY);
-	if(IS_ERR(file)){
+	fd = sys_open(path, 0, 0);
+	if (fd < 0) {
 		mconsole_reply(req, "Failed to open file", 1, 0);
-		goto out_kill;
+		printk("open %s: %d\n",path,fd);
+		goto out;
 	}
 
 	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if(buf == NULL){
 		mconsole_reply(req, "Failed to allocate buffer", 1, 0);
-		goto out_fput;
+		goto out_close;
 	}
 
-	if((file->f_op != NULL) && (file->f_op->read != NULL)){
-		do {
-			n = (*file->f_op->read)(file, buf, PAGE_SIZE - 1, 
-						&file->f_pos);
-			if(n >= 0){
-				buf[n] = '\0';
-				mconsole_reply(req, buf, 0, (n > 0));
-			}
-			else {
-				mconsole_reply(req, "Read of file failed", 
-					       1, 0);
-				goto out_free;
-			}
-		} while(n > 0);
+	for (;;) {
+		len = sys_read(fd, buf, PAGE_SIZE-1);
+		if (len < 0) {
+			mconsole_reply(req, "Read of file failed", 1, 0);
+			goto out_free;
+		} else if (len == PAGE_SIZE-1) {
+			buf[len] = '\0';
+			mconsole_reply(req, buf, 0, 1);
+		} else {
+			buf[len] = '\0';
+			mconsole_reply(req, buf, 0, 0);
+			break;
+		}
 	}
-	else mconsole_reply(req, "", 0, 0);
 
  out_free:
 	kfree(buf);
- out_fput:
-	fput(file);
- out_kill:
-	deactivate_super(super);
- out: ;
+ out_close:
+	sys_close(fd);
+ out:
+	/* nothing */;
 }
 
 #define UML_MCONSOLE_HELPTEXT \


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
