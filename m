Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JpfpU-0003Ey-0z for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Apr 2008 01:32:20 -0700
Received: from wa-out-1112.google.com ([209.85.146.183])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JpfpS-00064n-Kw
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Apr 2008 01:32:19 -0700
Received: by wa-out-1112.google.com with SMTP id k22so7639519waf.18
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 26 Apr 2008 01:32:18 -0700 (PDT)
Date: Sat, 26 Apr 2008 16:31:32 +0800 (CST)
Message-Id: <20080426.163132.194697674.xiyou.wangcong@gmail.com>
From: WANG Cong <xiyou.wangcong@gmail.com>
In-Reply-To: <20080425175608.GA11182@c2.user-mode-linux.org>
References: <20080425175608.GA11182@c2.user-mode-linux.org>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH 6/19] UML - hppfs fixes
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
To: jdike@addtoit.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Jeff Dike <jdike@addtoit.com>
Date: Fri, 25 Apr 2008 13:56:09 -0400
> hppfs tidying and fixes noticed during hch's get_inode work -
>       style fixes
>       a copy_to_user got its return value checked
>       hppfs_write no longer fiddles file->f_pos because it gets and
> returns pos in its arguments
>       hppfs_delete_inode dputs the underlyng procfs dentry stored in
> its private data and mntputs the vfsmnt stashed in s_fs_info
>       hppfs_put_super no longer needs to mntput the s_fs_info, so it
> no longer needs to exist
>       hppfs_readlink and hppfs_follow_link were doing a bunch of stuff
> with a struct file which they didn't use
>       there is now a ->permission which calls generic_permission
>       get_inode was always returning 0 for some reason - it now
> returns an inode if nothing bad happened
> 
> Signed-off-by: Jeff Dike <jdike@linux.intel.com>
> ---
>  fs/hppfs/hppfs_kern.c |   82 ++++++++++++++++++--------------------------------
>  1 file changed, 30 insertions(+), 52 deletions(-)
> 
> Index: linux-2.6.22/fs/hppfs/hppfs_kern.c
> ===================================================================
> --- linux-2.6.22.orig/fs/hppfs/hppfs_kern.c	2008-04-24 13:35:54.000000000 -0400
> +++ linux-2.6.22/fs/hppfs/hppfs_kern.c	2008-04-24 15:31:59.000000000 -0400
> @@ -33,7 +33,7 @@ struct hppfs_private {
>  };
>  
>  struct hppfs_inode_info {
> -        struct dentry *proc_dentry;
> +	struct dentry *proc_dentry;
>  	struct inode vfs_inode;
>  };
>  
> @@ -52,7 +52,7 @@ static int is_pid(struct dentry *dentry)
>  	int i;
>  
>  	sb = dentry->d_sb;
> -	if ((sb->s_op != &hppfs_sbops) || (dentry->d_parent != sb->s_root))
> +	if (dentry->d_parent != sb->s_root)
>  		return 0;
>  
>  	for (i = 0; i < dentry->d_name.len; i++) {
> @@ -136,7 +136,7 @@ static int file_removed(struct dentry *d
>  }
>  
>  static struct dentry *hppfs_lookup(struct inode *ino, struct dentry *dentry,
> -                                  struct nameidata *nd)
> +				   struct nameidata *nd)
>  {
>  	struct dentry *proc_dentry, *new, *parent;
>  	struct inode *inode;
> @@ -254,6 +254,8 @@ static ssize_t hppfs_read(struct file *f
>  	int err;
>  
>  	if (hppfs->contents != NULL) {
> +		int rem;
> +
>  		if (*ppos >= hppfs->len)
>  			return 0;
>  
> @@ -267,8 +269,10 @@ static ssize_t hppfs_read(struct file *f
>  
>  		if (off + count > hppfs->len)
>  			count = hppfs->len - off;
> -		copy_to_user(buf, &data->contents[off], count);
> -		*ppos += count;
> +		rem = copy_to_user(buf, &data->contents[off], count);
> +		*ppos += count - rem;
> +		if (rem > 0)
> +			return -EFAULT;


Could you please explain why check 'rem' after using it here?


>  	} else if (hppfs->host_fd != -1) {
>  		err = os_seek_file(hppfs->host_fd, *ppos);
>  		if (err) {
> @@ -285,21 +289,15 @@ static ssize_t hppfs_read(struct file *f
>  	return count;
>  }
>  
> -static ssize_t hppfs_write(struct file *file, const char __user *buf, size_t len,
> -			   loff_t *ppos)
> +static ssize_t hppfs_write(struct file *file, const char __user *buf,
> +			   size_t len, loff_t *ppos)
>  {
>  	struct hppfs_private *data = file->private_data;
>  	struct file *proc_file = data->proc_file;
>  	ssize_t (*write)(struct file *, const char __user *, size_t, loff_t *);
> -	int err;
>  
>  	write = proc_file->f_path.dentry->d_inode->i_fop->write;
> -
> -	proc_file->f_pos = file->f_pos;
> -	err = (*write)(proc_file, buf, len, &proc_file->f_pos);
> -	file->f_pos = proc_file->f_pos;
> -
> -	return err;
> +	return (*write)(proc_file, buf, len, ppos);
>  }
>  
>  static int open_host_sock(char *host_file, int *filter_out)
> @@ -357,7 +355,7 @@ static struct hppfs_data *hppfs_get_data
>  
>  	if (filter) {
>  		while ((n = read_proc(proc_file, data->contents,
> -				     sizeof(data->contents), NULL, 0)) > 0)
> +				      sizeof(data->contents), NULL, 0)) > 0)
>  			os_write_file(fd, data->contents, n);
>  		err = os_shutdown_socket(fd, 0, 1);
>  		if (err) {
> @@ -429,8 +427,8 @@ static int file_mode(int fmode)
>  static int hppfs_open(struct inode *inode, struct file *file)
>  {
>  	struct hppfs_private *data;
> -	struct dentry *proc_dentry;
>  	struct vfsmount *proc_mnt;
> +	struct dentry *proc_dentry;

And what does this kind of change mean?

>  	char *host_file;
>  	int err, fd, type, filter;
>  
> @@ -492,8 +490,8 @@ static int hppfs_open(struct inode *inod
>  static int hppfs_dir_open(struct inode *inode, struct file *file)
>  {
>  	struct hppfs_private *data;
> -	struct dentry *proc_dentry;
>  	struct vfsmount *proc_mnt;
> +	struct dentry *proc_dentry;

ditto

<snip>

Thanks!


Cong

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
