Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1L2hsU-0000GU-16
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Nov 2008 07:53:34 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1L2hsP-0001TB-Ml
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Nov 2008 07:53:33 +0000
Date: Tue, 18 Nov 2008 23:53:23 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20081118235323.85dd277d.akpm@linux-foundation.org>
In-Reply-To: <20081118180003.GF3185@hack.voiplan.pt>
References: <20081118180003.GF3185@hack.voiplan.pt>
Mime-Version: 1.0
Subject: Re: [uml-devel] [Patch] hostfs: fix a duplicated global function name
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
To: =?ISO-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Tue, 18 Nov 2008 18:00:03 +0000 Am__rico Wang <xiyou.wangcong@gmail.com> wrote:

> 
> fs/hostfs/hostfs_user.c defines do_readlink() as non-static,
> and so does fs/xfs/linux-2.6/xfs_ioctl.c when CONFIG_XFS_DEBUG=y.
> So rename do_readlink() in hostfs to hostfs_do_readlink().

heh, yes, it's not a great choice of identifier.

> I think it's better if XFS guys will also rename their do_readlink(),
> it's not necessary to use such a general name.
> 
> Compile test only.
>
> ...
>
> diff --git a/fs/hostfs/hostfs.h b/fs/hostfs/hostfs.h
> index 6ae9011..2f34f8f 100644
> --- a/fs/hostfs/hostfs.h
> +++ b/fs/hostfs/hostfs.h
> @@ -81,7 +81,7 @@ extern int do_rmdir(const char *file);
>  extern int do_mknod(const char *file, int mode, unsigned int major,
>  		    unsigned int minor);
>  extern int link_file(const char *from, const char *to);
> -extern int do_readlink(char *file, char *buf, int size);
> +extern int hostfs_do_readlink(char *file, char *buf, int size);
>  extern int rename_file(char *from, char *to);
>  extern int do_statfs(char *root, long *bsize_out, long long *blocks_out,
>  		     long long *bfree_out, long long *bavail_out,
> diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
> index 7f34f43..3a31451 100644
> --- a/fs/hostfs/hostfs_kern.c
> +++ b/fs/hostfs/hostfs_kern.c
> @@ -168,7 +168,7 @@ static char *follow_link(char *link)
>  		if (name == NULL)
>  			goto out;
>  
> -		n = do_readlink(link, name, len);
> +		n = hostfs_do_readlink(link, name, len);
>  		if (n < len)
>  			break;
>  		len *= 2;
> @@ -943,7 +943,7 @@ int hostfs_link_readpage(struct file *file, struct page *page)
>  	name = inode_name(page->mapping->host, 0);
>  	if (name == NULL)
>  		return -ENOMEM;
> -	err = do_readlink(name, buffer, PAGE_CACHE_SIZE);
> +	err = hostfs_do_readlink(name, buffer, PAGE_CACHE_SIZE);
>  	kfree(name);
>  	if (err == PAGE_CACHE_SIZE)
>  		err = -E2BIG;
> diff --git a/fs/hostfs/hostfs_user.c b/fs/hostfs/hostfs_user.c
> index 53fd0a6..b79424f 100644
> --- a/fs/hostfs/hostfs_user.c
> +++ b/fs/hostfs/hostfs_user.c
> @@ -377,7 +377,7 @@ int link_file(const char *to, const char *from)
>  	return 0;
>  }
>  
> -int do_readlink(char *file, char *buf, int size)
> +int hostfs_do_readlink(char *file, char *buf, int size)
>  {
>  	int n;

Thanks, I'll send this in for 2.6.28 unless someone stops me soon.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
