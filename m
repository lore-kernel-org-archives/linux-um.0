Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1awxs8-00059V-Ir
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 May 2016 20:21:44 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1awxs7-0003AI-6M
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 May 2016 20:21:44 +0000
References: <1462093338-8759-1-git-send-email-toshiq2@gmail.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <5726654D.1070500@nod.at>
Date: Sun, 1 May 2016 22:21:33 +0200
MIME-Version: 1.0
In-Reply-To: <1462093338-8759-1-git-send-email-toshiq2@gmail.com>
Subject: Re: [uml-devel] [PATCH] hostfs: fix opening file with overlayfs
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
To: Toshikuni Fukaya <toshiq2@gmail.com>, user-mode-linux-devel@lists.sourceforge.net
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, David Howells <dhowells@redhat.com>, jdike@addtoit.com, Al Viro <viro@zeniv.linux.org.uk>, mszeredi@redhat.com

CC'ing VFS folks

Am 01.05.2016 um 11:02 schrieb Toshikuni Fukaya:
> If a file on overlayfs using hostfs as a lowerdir is opened, it would
> be failed by ENOENT because hostfs resolves a host path by a host root
> path stored on the hostfs superblock referred by file->f_path.dentry,
> but it is replaced with overlayfs's one starting from the
> commit 4bacc9c9234c ("overlayfs: Make f_path always point to the
> overlay and f_inode to the underlay").
> 
> We replace using file->f_path.dentry directly with calling
> "file_dentry" from a commit d101a125954e ("fs: add file_dentry()") to
> fix the issue.

Is there a reason why not all instances of file->f_path.dentry have
been replaced by file_dentry()?
I smell more fallout...

Thanks,
//richard

> Signed-off-by: Toshikuni Fukaya <toshiq2@gmail.com>
> ---
>  fs/hostfs/hostfs_kern.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
> index 7016653..26a9f43 100644
> --- a/fs/hostfs/hostfs_kern.c
> +++ b/fs/hostfs/hostfs_kern.c
> @@ -284,7 +284,7 @@ static int hostfs_readdir(struct file *file, struct dir_context *ctx)
>  	int error, len;
>  	unsigned int type;
>  
> -	name = dentry_name(file->f_path.dentry);
> +	name = dentry_name(file_dentry(file));
>  	if (name == NULL)
>  		return -ENOMEM;
>  	dir = open_dir(name, &error);
> @@ -323,7 +323,7 @@ retry:
>  	if (mode & FMODE_WRITE)
>  		r = w = 1;
>  
> -	name = dentry_name(file->f_path.dentry);
> +	name = dentry_name(file_dentry(file));
>  	if (name == NULL)
>  		return -ENOMEM;
>  
> 

------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

