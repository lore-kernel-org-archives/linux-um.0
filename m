Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IbII1-0001QG-Bl for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 09:02:05 -0700
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IbIHx-0003wA-T6
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 09:02:03 -0700
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8SG0I34007842
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 28 Sep 2007 12:00:18 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8SG0HpX474324 for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 28 Sep 2007 10:00:17 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8SG0GAr011512 for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 28 Sep 2007 10:00:17 -0600
From: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20070928150353.GC7010@c2.user-mode-linux.org>
References: <20070927220923.96887EDE@kernel>
	<20070928150353.GC7010@c2.user-mode-linux.org>
Date: Fri, 28 Sep 2007 09:00:14 -0700
Message-Id: <1190995215.7344.67.camel@localhost>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH] make UML call dentry_open() with a valid
	vfsmount
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, 2007-09-28 at 11:03 -0400, Jeff Dike wrote:
> On Thu, Sep 27, 2007 at 03:09:23PM -0700, Dave Hansen wrote:
> > 
> > I'm trying to enforce the convention that you may not call
> > dentry_open() with a NULL vfsmount.  This is so that the
> > r/o bind mount patches can consistenty acquire write access
> > to the mounts there.
> > 
> > This patch fixes up UML's HPPFS to track both the vfsmount
> > and the dentry for its files.  Compile, but not runtime
> > tested.
> 
> Can I get a Signed-off-by:?

I'm trying to enforce the convention that you may not call
dentry_open() with a NULL vfsmount.  This is so that the
r/o bind mount patches can consistenty acquire write access
to the mounts there.

This patch fixes up UML's HPPFS to track both the vfsmount
and the dentry for its files.  Compile, but not runtime
tested.

This also fixes a potential oops with the r/o bind mount patches caused
by passing a NULL mnt into dentry_open().  After you've had a chance to
verify that this works, could you send it up to -mm?

One more thing... have you had any problems getting
arch/um/os-Linux/time.c to compile because of a lack of tv_to_nsec()?

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>

---

 lxc-dave/fs/hppfs/hppfs_kern.c |   45 +++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff -puN fs/hppfs/hppfs_kern.c~remove-UML-callers-of-dentry_open-with-null-mnt fs/hppfs/hppfs_kern.c
--- lxc/fs/hppfs/hppfs_kern.c~remove-UML-callers-of-dentry_open-with-null-mnt	2007-09-28 08:57:05.000000000 -0700
+++ lxc-dave/fs/hppfs/hppfs_kern.c	2007-09-28 08:57:05.000000000 -0700
@@ -17,7 +17,8 @@
 #include <asm/fcntl.h>
 #include "os.h"
 
-static int init_inode(struct inode *inode, struct dentry *dentry);
+static int init_inode(struct inode *inode, struct dentry *dentry,
+		struct vfsmount *mnt);
 
 struct hppfs_data {
 	struct list_head list;
@@ -32,7 +33,7 @@ struct hppfs_private {
 };
 
 struct hppfs_inode_info {
-        struct dentry *proc_dentry;
+	struct path proc_path;
 	struct inode vfs_inode;
 };
 
@@ -139,10 +140,10 @@ static void hppfs_read_inode(struct inod
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
@@ -169,7 +170,7 @@ static struct dentry *hppfs_lookup(struc
 		return(ERR_PTR(-ENOENT));
 
 	err = -ENOMEM;
-	parent = HPPFS_I(ino)->proc_dentry;
+	parent = HPPFS_I(ino)->proc_path.dentry;
 	mutex_lock(&parent->d_inode->i_mutex);
 	proc_dentry = d_lookup(parent, &dentry->d_name);
 	if(proc_dentry == NULL){
@@ -194,7 +195,7 @@ static struct dentry *hppfs_lookup(struc
 	if(inode == NULL)
 		goto out_dput;
 
-	err = init_inode(inode, proc_dentry);
+	err = init_inode(inode, proc_dentry, nd->mnt);
 	if(err)
 		goto out_put;
 
@@ -455,7 +456,7 @@ static int file_mode(int fmode)
 static int hppfs_open(struct inode *inode, struct file *file)
 {
 	struct hppfs_private *data;
-	struct dentry *proc_dentry;
+	struct path *proc_path;
 	char *host_file;
 	int err, fd, type, filter;
 
@@ -468,10 +469,11 @@ static int hppfs_open(struct inode *inod
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
@@ -516,7 +518,7 @@ static int hppfs_open(struct inode *inod
 static int hppfs_dir_open(struct inode *inode, struct file *file)
 {
 	struct hppfs_private *data;
-	struct dentry *proc_dentry;
+	struct path *proc_path;
 	int err;
 
 	err = -ENOMEM;
@@ -524,8 +526,9 @@ static int hppfs_dir_open(struct inode *
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
@@ -634,7 +637,8 @@ static struct inode *hppfs_alloc_inode(s
 	if(hi == NULL)
 		return(NULL);
 
-	*hi = ((struct hppfs_inode_info) { .proc_dentry	= NULL });
+	hi->proc_path.dentry = NULL;
+	hi->proc_path.mnt = NULL;
 	inode_init_once(&hi->vfs_inode);
 	return(&hi->vfs_inode);
 }
@@ -663,7 +667,7 @@ static int hppfs_readlink(struct dentry 
 	struct dentry *proc_dentry;
 	int ret;
 
-	proc_dentry = HPPFS_I(dentry->d_inode)->proc_dentry;
+	proc_dentry = HPPFS_I(dentry->d_inode)->proc_path.dentry;
 	proc_file = dentry_open(dget(proc_dentry), NULL, O_RDONLY);
 	if (IS_ERR(proc_file))
 		return PTR_ERR(proc_file);
@@ -681,7 +685,7 @@ static void* hppfs_follow_link(struct de
 	struct dentry *proc_dentry;
 	void *ret;
 
-	proc_dentry = HPPFS_I(dentry->d_inode)->proc_dentry;
+	proc_dentry = HPPFS_I(dentry->d_inode)->proc_path.dentry;
 	proc_file = dentry_open(dget(proc_dentry), NULL, O_RDONLY);
 	if (IS_ERR(proc_file))
 		return proc_file;
@@ -702,7 +706,8 @@ static const struct inode_operations hpp
 	.follow_link	= hppfs_follow_link,
 };
 
-static int init_inode(struct inode *inode, struct dentry *dentry)
+static int init_inode(struct inode *inode, struct dentry *dentry,
+			struct vfsmount *mnt)
 {
 	if(S_ISDIR(dentry->d_inode->i_mode)){
 		inode->i_op = &hppfs_dir_iops;
@@ -717,7 +722,8 @@ static int init_inode(struct inode *inod
 		inode->i_fop = &hppfs_file_fops;
 	}
 
-	HPPFS_I(inode)->proc_dentry = dentry;
+	HPPFS_I(inode)->proc_path.dentry = dentry;
+	HPPFS_I(inode)->proc_path.mnt = mnt;
 
 	return(0);
 }
@@ -727,6 +733,7 @@ static int hppfs_fill_super(struct super
 	struct inode *root_inode;
 	struct file_system_type *procfs;
 	struct super_block *proc_sb;
+	struct vfsmount *mnt = d;
 	int err;
 
 	err = -ENOENT;
@@ -749,7 +756,7 @@ static int hppfs_fill_super(struct super
 	if(root_inode == NULL)
 		goto out;
 
-	err = init_inode(root_inode, proc_sb->s_root);
+	err = init_inode(root_inode, proc_sb->s_root, mnt);
 	if(err)
 		goto out_put;
 
@@ -772,7 +779,7 @@ static int hppfs_read_super(struct file_
 			    int flags, const char *dev_name,
 			    void *data, struct vfsmount *mnt)
 {
-	return get_sb_nodev(type, flags, data, hppfs_fill_super, mnt);
+	return get_sb_nodev(type, flags, mnt, hppfs_fill_super, mnt);
 }
 
 static struct file_system_type hppfs_type = {
_


-- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
