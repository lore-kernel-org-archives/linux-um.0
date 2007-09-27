Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ib1YB-0003ku-Gt for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Sep 2007 15:09:39 -0700
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ib1Y9-0002Z7-TM
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Sep 2007 15:09:39 -0700
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8RM9Pj0006183
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 27 Sep 2007 18:09:25 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8RM9OlJ556134 for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 27 Sep 2007 18:09:24 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8RM9O0v021143 for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 27 Sep 2007 18:09:24 -0400
From: Dave Hansen <haveblue@us.ibm.com>
Date: Thu, 27 Sep 2007 15:09:23 -0700
Message-Id: <20070927220923.96887EDE@kernel>
Subject: [uml-devel] [PATCH] make UML call dentry_open() with a valid vfsmount
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jdike@karaya.com
Cc: Dave Hansen <haveblue@us.ibm.com>, user-mode-linux-devel@lists.sourceforge.net


I'm trying to enforce the convention that you may not call
dentry_open() with a NULL vfsmount.  This is so that the
r/o bind mount patches can consistenty acquire write access
to the mounts there.

This patch fixes up UML's HPPFS to track both the vfsmount
and the dentry for its files.  Compile, but not runtime
tested.

---

 lxc-dave/fs/hppfs/hppfs_kern.c |   31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff -puN fs/open.c~remove-UML-callers-of-dentry_open-with-null-mnt fs/open.c
diff -puN fs/hppfs/hppfs_kern.c~remove-UML-callers-of-dentry_open-with-null-mnt fs/hppfs/hppfs_kern.c
--- lxc/fs/hppfs/hppfs_kern.c~remove-UML-callers-of-dentry_open-with-null-mnt	2007-09-27 15:03:07.000000000 -0700
+++ lxc-dave/fs/hppfs/hppfs_kern.c	2007-09-27 15:03:07.000000000 -0700
@@ -32,7 +32,7 @@ struct hppfs_private {
 };
 
 struct hppfs_inode_info {
-        struct dentry *proc_dentry;
+	struct path proc_path;
 	struct inode vfs_inode;
 };
 
@@ -139,10 +139,10 @@ static void hppfs_read_inode(struct inod
 {
 	struct inode *proc_ino;
 
-	if(HPPFS_I(ino)->proc_dentry == NULL)
+	if (HPPFS_I(ino)->proc_path.dentry == NULL)
 		return;
 
-	proc_ino = HPPFS_I(ino)->proc_dentry->d_inode;
+	proc_ino = HPPFS_I(ino)->proc_path.dentry->d_inode;
 	ino->i_uid = proc_ino->i_uid;
 	ino->i_gid = proc_ino->i_gid;
 	ino->i_atime = proc_ino->i_atime;
@@ -169,7 +169,7 @@ static struct dentry *hppfs_lookup(struc
 		return(ERR_PTR(-ENOENT));
 
 	err = -ENOMEM;
-	parent = HPPFS_I(ino)->proc_dentry;
+	parent = HPPFS_I(ino)->proc_path.dentry;
 	mutex_lock(&parent->d_inode->i_mutex);
 	proc_dentry = d_lookup(parent, &dentry->d_name);
 	if(proc_dentry == NULL){
@@ -455,7 +455,7 @@ static int file_mode(int fmode)
 static int hppfs_open(struct inode *inode, struct file *file)
 {
 	struct hppfs_private *data;
-	struct dentry *proc_dentry;
+	struct path *proc_path;
 	char *host_file;
 	int err, fd, type, filter;
 
@@ -468,10 +468,11 @@ static int hppfs_open(struct inode *inod
 	if(host_file == NULL)
 		goto out_free2;
 
-	proc_dentry = HPPFS_I(inode)->proc_dentry;
+	proc_path = &HPPFS_I(inode)->proc_path;
 
 	/* XXX This isn't closed anywhere */
-	data->proc_file = dentry_open(dget(proc_dentry), NULL,
+	data->proc_file = dentry_open(dget(proc_path->dentry),
+				      mntget(proc_path->mnt),
 				      file_mode(file->f_mode));
 	err = PTR_ERR(data->proc_file);
 	if(IS_ERR(data->proc_file))
@@ -516,7 +517,7 @@ static int hppfs_open(struct inode *inod
 static int hppfs_dir_open(struct inode *inode, struct file *file)
 {
 	struct hppfs_private *data;
-	struct dentry *proc_dentry;
+	struct path *proc_path;
 	int err;
 
 	err = -ENOMEM;
@@ -524,8 +525,9 @@ static int hppfs_dir_open(struct inode *
 	if(data == NULL)
 		goto out;
 
-	proc_dentry = HPPFS_I(inode)->proc_dentry;
-	data->proc_file = dentry_open(dget(proc_dentry), NULL,
+	proc_path = &HPPFS_I(inode)->proc_path;
+	data->proc_file = dentry_open(dget(proc_path->dentry),
+				      mntget(proc_path->mnt),
 				      file_mode(file->f_mode));
 	err = PTR_ERR(data->proc_file);
 	if(IS_ERR(data->proc_file))
@@ -634,7 +636,8 @@ static struct inode *hppfs_alloc_inode(s
 	if(hi == NULL)
 		return(NULL);
 
-	*hi = ((struct hppfs_inode_info) { .proc_dentry	= NULL });
+	hi->proc_path.dentry = NULL;
+	hi->proc_path.mnt = NULL;
 	inode_init_once(&hi->vfs_inode);
 	return(&hi->vfs_inode);
 }
@@ -663,7 +666,7 @@ static int hppfs_readlink(struct dentry 
 	struct dentry *proc_dentry;
 	int ret;
 
-	proc_dentry = HPPFS_I(dentry->d_inode)->proc_dentry;
+	proc_dentry = HPPFS_I(dentry->d_inode)->proc_path.dentry;
 	proc_file = dentry_open(dget(proc_dentry), NULL, O_RDONLY);
 	if (IS_ERR(proc_file))
 		return PTR_ERR(proc_file);
@@ -681,7 +684,7 @@ static void* hppfs_follow_link(struct de
 	struct dentry *proc_dentry;
 	void *ret;
 
-	proc_dentry = HPPFS_I(dentry->d_inode)->proc_dentry;
+	proc_dentry = HPPFS_I(dentry->d_inode)->proc_path.dentry;
 	proc_file = dentry_open(dget(proc_dentry), NULL, O_RDONLY);
 	if (IS_ERR(proc_file))
 		return proc_file;
@@ -717,7 +720,7 @@ static int init_inode(struct inode *inod
 		inode->i_fop = &hppfs_file_fops;
 	}
 
-	HPPFS_I(inode)->proc_dentry = dentry;
+	HPPFS_I(inode)->proc_path.dentry = dentry;
 
 	return(0);
 }
diff -puN fs/Kconfig~remove-UML-callers-of-dentry_open-with-null-mnt fs/Kconfig
diff -puN fs/Makefile~remove-UML-callers-of-dentry_open-with-null-mnt fs/Makefile
diff -puN arch/um/Kconfig~remove-UML-callers-of-dentry_open-with-null-mnt arch/um/Kconfig
diff -puN include/linux/namei.h~remove-UML-callers-of-dentry_open-with-null-mnt include/linux/namei.h
diff -puN arch/um/os-Linux/time.c~remove-UML-callers-of-dentry_open-with-null-mnt arch/um/os-Linux/time.c
diff -puN fs/hppfs/Makefile~remove-UML-callers-of-dentry_open-with-null-mnt fs/hppfs/Makefile
diff -puN MAINTAINERS~remove-UML-callers-of-dentry_open-with-null-mnt MAINTAINERS
_

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
