Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B96Eo-0006XQ-7L for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Apr 2004 09:44:22 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1B96En-00042I-EW for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Apr 2004 09:44:21 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
References: <40686E7D.2080600@unclewebster.com>
	<200403300217.i2U2HKxc026892@ccure.user-mode-linux.org>
In-Reply-To: <200403300217.i2U2HKxc026892@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ncFbAzVIqo4SSxf"
Message-Id: <200404011953.43255.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Hostfs and Humfs
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
Date: Thu, 1 Apr 2004 18:53:43 +0100
To: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>



--Boundary-00=_ncFbAzVIqo4SSxf
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Alle 04:17, marted=EC 30 marzo 2004, Jeff Dike ha scritto:
> tim@unclewebster.com said:
> > Is there any clever way to reset the root password for users, aside
> > from  deleting the cow? "linux single" is fine, but aside from that?
>
> I'm finishing up a new hostfs-like filesystem which I want to become the
> preferred mechanism to boot UMLs because of its ability to mmap data from
> the host, eliminating duplicate copies of file data in memory.

Al Viro said you that ubd=3Dmmap won't work, right? Would you give me the m=
agic=20
words to search on the LKML or forward the messages to the -devel list?

Also, I've started writing a little patch for 2.6 to hostfs to generalize i=
t=20
like you said (which I attached). It is just 2-3 hours of work, since I had=
=20
some doubt: do you like adding a hostfs_user_operations stored into=20
super_block->s_fs_info and calling all the functions of hostfs_user.c=20
indirectly (the trivial and long part I did not do yet)?

Would it be useful for your "humfs", as it seems to me?

=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_ncFbAzVIqo4SSxf
Content-Type: text/x-diff; charset="iso-8859-1"; name="Abstract_hostfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="Abstract_hostfs.patch"

--- ./fs/hostfs/hostfs_kern.c.fix	2004-03-01 18:59:47.000000000 +0100
+++ ./fs/hostfs/hostfs_kern.c	2004-03-01 19:26:03.000000000 +0100
@@ -33,6 +33,30 @@
 	struct inode vfs_inode;
 };
 
+struct hostfs_private_fs_info { /* To fill s_fs_info; it will need a list_head field.*/
+	struct hostfs_user_operations *ops;
+	struct list_head link;
+};
+
+/* For now no locking, it is called in initialization.*/
+static struct hostfs_private_fs_info hostfs_info;
+
+int register_hostfs_ops(struct hostfs_user_operations* ops)
+{
+	hostfs_info.ops = ops;
+	return 0;
+}
+
+static inline struct hostfs_user_operations* HOSTFS_OPS_INO(struct inode* ino)
+{
+	return ((struct hostfs_private_fs_info*) ino->i_sb->s_fs_info)->ops;
+}
+
+static inline struct hostfs_user_operations* HOSTFS_OPS_FILE(struct file* file)
+{
+	return ((struct hostfs_private_fs_info*) file->f_dentry->d_sb->s_fs_info)->ops;
+}
+
 static inline struct hostfs_inode_info *HOSTFS_I(struct inode *inode)
 {
 	return(list_entry(inode, struct hostfs_inode_info, vfs_inode));
@@ -927,6 +951,8 @@
 	sb->s_blocksize_bits = 10;
 	sb->s_magic = HOSTFS_SUPER_MAGIC;
 	sb->s_op = &hostfs_sbops;
+	/* Just temporary;*/
+	sb->s_fs_info = &hostfs_info;
 
 	if((data == NULL) || (*data == '\0')) 
 		data = root_ino;
--- ./fs/hostfs/hostfs.h.fix	2004-02-20 18:43:27.000000000 +0100
+++ ./fs/hostfs/hostfs.h	2004-03-01 19:21:05.000000000 +0100
@@ -31,6 +31,7 @@
 	unsigned int	ia_attr_flags;
 };
 
+#if 0
 extern int stat_file(const char *path, unsigned long long *inode_out, 
 		     int *mode_out, int *nlink_out, int *uid_out, int *gid_out,
 		     unsigned long long *size_out, struct timespec *atime_out, 
@@ -64,6 +65,46 @@
 		     long long *files_out, long long *ffree_out, 
 		     void *fsid_out, int fsid_size, long *namelen_out, 
 		     long *spare_out);
+#endif
+
+struct hostfs_user_operations {
+	int (*stat_file)(const char *path, unsigned long long *inode_out, 
+			     int *mode_out, int *nlink_out, int *uid_out, int *gid_out,
+			     unsigned long long *size_out, struct timespec *atime_out, 
+			     struct timespec *mtime_out, struct timespec *ctime_out, 
+			     int *blksize_out, unsigned long long *blocks_out);
+	int (*access_file)(char *path, int r, int w, int x);
+	int (*open_file)(char *path, int r, int w, int append);
+	int (*file_type)(const char *path, int *rdev);
+	void *(*open_dir)(char *path, int *err_out);
+	char *(*read_dir)(void *stream, unsigned long long *pos, 
+			      unsigned long long *ino_out, int *len_out);
+	void (*close_file)(void *stream);
+	void (*close_dir)(void *stream);
+	int (*read_file)(int fd, unsigned long long *offset, char *buf, int len);
+	int (*write_file)(int fd, unsigned long long *offset, const char *buf,
+			      int len);
+	int (*lseek_file)(int fd, long long offset, int whence);
+	int (*file_create)(char *name, int ur, int uw, int ux, int gr, 
+			       int gw, int gx, int or, int ow, int ox);
+	int (*set_attr)(const char *file, struct hostfs_iattr *attrs);
+	int (*make_symlink)(const char *from, const char *to);
+	int (*unlink_file)(const char *file);
+	int (*do_mkdir)(const char *file, int mode);
+	int (*do_rmdir)(const char *file);
+	int (*do_mknod)(const char *file, int mode, int dev);
+	int (*link_file)(const char *from, const char *to);
+	int (*do_readlink)(char *file, char *buf, int size);
+	int (*rename_file)(char *from, char *to);
+	int (*do_statfs)(char *root, long *bsize_out, long long *blocks_out, 
+			     long long *bfree_out, long long *bavail_out, 
+			     long long *files_out, long long *ffree_out, 
+			     void *fsid_out, int fsid_size, long *namelen_out, 
+			     long *spare_out);
+};
+
+/* For now only one hostfs_user_operations can be registered */
+extern int register_hostfs_ops(struct hostfs_user_operations * ops);
 
 #endif
 
--- ./fs/hostfs/hostfs_user.c.fix	2004-03-01 19:02:15.000000000 +0100
+++ ./fs/hostfs/hostfs_user.c	2004-03-01 19:25:04.000000000 +0100
@@ -341,6 +341,31 @@
 	return(0);
 }
 
+static struct hostfs_user_operations host_ops = {
+	.stat_file      = stat_file,
+	.file_type      = file_type,
+	.access_file    = access_file,
+	.open_file      = open_file,
+	.open_dir       = open_dir,
+	.read_dir       = read_dir,
+	.read_file      = read_file,
+	.write_file     = write_file,
+	.lseek_file     = lseek_file,
+	.close_file     = close_file,
+	.close_dir      = close_dir,
+	.file_create    = file_create,
+	.set_attr       = set_attr,
+	.make_symlink   = make_symlink,
+	.unlink_file    = unlink_file,
+	.do_mkdir       = do_mkdir,
+	.do_rmdir       = do_rmdir,
+	.do_mknod       = do_mknod,
+	.link_file      = link_file,
+	.do_readlink    = do_readlink,
+	.rename_file    = rename_file,
+	.do_statfs      = do_statfs,
+};
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically

--Boundary-00=_ncFbAzVIqo4SSxf--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
