Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BLKTW-0005Tw-6L for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 May 2004 04:22:06 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BLKTV-000178-HO for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 May 2004 04:22:05 -0700
From: Henrik Nordstrom <uml@henrik.marasystems.com>
Subject: Re: [uml-devel] [patch] 2.4 hostfs no longer mounts specified
	directory 
In-Reply-To: <200405042136.i44La3kI004256@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.44.0405051319040.13298-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Wed, 5 May 2004 13:21:55 +0200 (CEST)
To: Jeff Dike <jdike@addtoit.com>
Cc: Henrik Nordstrom <uml@henrik.marasystems.com>, user-mode-linux-devel@lists.sourceforge.net

On Tue, 4 May 2004, Jeff Dike wrote:

> @@ -243,7 +245,7 @@ 
> static int stat_fs(long *bsize_out, long
>  		   void *fsid_out, int fsid_size, long *namelen_out, 
>  		   long *spare_out, void *mount)
>  {
> -	const char *path[] = { jail_dir, mount, NULL };
> +	const char *path[] = { jail_dir, mount, mount, NULL };
>  
>  	return(host_statfs(path, bsize_out, blocks_out, bfree_out, bavail_out, 
>  			   files_out, ffree_out, fsid_out, fsid_size, 
> 
> What's up with that, anyway?

Copy-paste error...

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
