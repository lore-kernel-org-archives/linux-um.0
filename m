Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1rpn-0003Lv-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 23 Sep 2003 11:24:23 -0700
Received: from smtp.schwaar.com ([212.31.69.154])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A1rpk-00077n-OV
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 23 Sep 2003 11:24:20 -0700
Mime-Version: 1.0
Message-Id: <p05111b03bb963eec0fa9@[10.96.96.13]>
From: Hannes Schulz <schulz@schwaar.com>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Subject: [uml-devel] [PATCH] hostfs as root (when lauched by root)
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 23 Sep 2003 20:24:16 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: jdike@addtoit.com

If um is launched by root hostfs works as rootfs; it just creates 
files & directories with the wrong (=root's) uid and gid. This patch 
tries to chown+chgid newly created files and directories.


Regards

Hannes

--- uml-2.4.22um5-orig/arch/um/fs/hostfs/hostfs_kern.c	2003-09-23 
15:21:33.000000000 +0200
+++ uml-2.4.22um5-hwh1/arch/um/fs/hostfs/hostfs_kern.c	2003-09-23 
19:34:40.000000000 +0200
@@ -557,7 +557,18 @@
  			 mode & S_IROTH, mode & S_IWOTH, mode & S_IXOTH);
  	if(fd < 0)
  		error = fd;
-	else error = read_name(inode, name);
+	else {
+		int ign;
+		struct hostfs_iattr uidgid;
+
+		uidgid.ia_valid = HOSTFS_ATTR_UID | HOSTFS_ATTR_GID;
+		uidgid.ia_uid = current->fsuid;
+		uidgid.ia_gid = current->fsgid;
+		/* the file was successfully created; the only reasonable
+		 * error is ENOPERM - which is ignored */
+		ign = set_attr(name, &uidgid);
+		error = read_name(inode, name);
+	}

  	kfree(name);
  	if(error){
@@ -660,6 +671,17 @@
  	file = inode_dentry_name(ino, dentry);
  	if(file == NULL) return(-ENOMEM);
  	err = do_mkdir(file, mode);
+	if(!err){
+		int ign;
+		struct hostfs_iattr uidgid;
+
+		uidgid.ia_valid = HOSTFS_ATTR_UID | HOSTFS_ATTR_GID;
+		uidgid.ia_uid = current->fsuid;
+		uidgid.ia_gid = current->fsgid;
+		/* the directory was successfully created. Errors in
+		 * set_attr are ignored */
+		ign = set_attr(file, &uidgid);
+	}
  	kfree(file);
  	return(err);
  }


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
