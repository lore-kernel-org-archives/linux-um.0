Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CyE5j-0000gb-0z for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Feb 2005 10:58:35 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CyE5i-0002sr-AC for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Feb 2005 10:58:34 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] correct gid in hostfs_kern.c
References: <p05111b01bb962e502881@[10.96.96.13]>
In-Reply-To: <p05111b01bb962e502881@[10.96.96.13]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502071919.30545.blaisorblade@yahoo.it>
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
Date: Mon, 7 Feb 2005 19:19:30 +0100
To: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net
Cc: Hannes Schulz <schulz@schwaar.com>

On Tuesday 23 September 2003 19:20, Hannes Schulz wrote:
> I was reading hostfs_* because I wanted hostfs as rootfs (when
> launched by root).

> --- uml-2.4.22um5-orig/arch/um/fs/hostfs/hostfs_kern.c 2003-09-23
> 15:21:33.000000000 +0200
> +++ uml-2.4.22um5-hwh1/arch/um/fs/hostfs/hostfs_kern.c 2003-09-23
> 15:24:42.000000000 +0200
> @@ -766,7 +766,7 @@
>    if(attr->ia_valid & ATTR_GID){
>     if(kdev_same(dentry->d_inode->i_sb->s_dev, ROOT_DEV) &&
>        (attr->ia_gid == 0))
> -   attr->ia_gid = getuid();
> +   attr->ia_gid = getgid();
>     attrs.ia_valid |= HOSTFS_ATTR_GID;
>     attrs.ia_gid = attr->ia_gid;
>    }

I've verified that this patch has not yet been applied, neither in 2.4 nor in 
2.6. I'm going to merge it into 2.6.11.

The original code does not make sense (since a given UID could not exist as a 
GID) so it *must* be a typo, and not done on purpose.

I don't understand the purpose of the patched branch, however... it means that 
chgrp 0 "fileName" will be executed as chgrp <group as UML is running> 
fileName.

And only when running hostfs as rootfs.... well, it makes sense since when 
stat()'ing a file this code is used:

        if((ino->i_sb->s_dev == ROOT_DEV) && (ino->i_uid == getuid()))
                ino->i_uid = 0;

i.e. if UML runs as uid 500, the host uid 500 is mapped to the guest uid 0. 
This does not happen for the gids, which is to fix.

Also, these two threads deserve a look, too:

[uml-devel] [PATCH] hostfs as root (when lauched by root)
[uml-devel] [BUG 2.4.22-um5 + hostfs] file not updated upon munmap

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
