Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dgvm0-0007A9-5c	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Jun 2005 19:31:00 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1Dgvlw-00074r-6y	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Jun 2005 19:31:00 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] hostfs permissions
References: <quack.20050609T2234.87is0msrl6@meow.quarl.org>
	<200506110026.24655.blaisorblade@yahoo.it>
	<quack.20050610T1748.87psutn2gh@quack.cs.berkeley.edu>
In-Reply-To: <quack.20050610T1748.87psutn2gh@quack.cs.berkeley.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506110434.03051.blaisorblade@yahoo.it>
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
Date: Sat, 11 Jun 2005 04:33:56 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Karl Chen <quarl@cs.berkeley.edu>

On Saturday 11 June 2005 02:48, Karl Chen wrote:
> >>>>> On 2005-06-10 15:26 PDT, Blaisorblade  writes:
>
>     Blaisorblade> Ok, in this case there's probably a simpler
>     Blaisorblade> road: simply use a 2.4.27-1bs kernel. The
>     Blaisorblade> implemented behaviour is that all created files
>     Blaisorblade> will have the ID they have on the host, i.e. the
>     Blaisorblade> ID of the user running UML.
>
> Thanks for the tip!  I will be running UML under different user
> IDs but I'd rather it always be the same uid inside the UML.  I
> used this micropatch to get exactly the behavior I want. It's
> obviously for this particular experiment only; I still think
> uid,gid mount options would be better in general.  I guess that's
> only 5 or 10 more lines of code...
Yes, I just need a bit of time to implement all cases and especially option 
parsing. And I can confirm your micropatch does exactly the work you need.

> diff -u
> /home/quarl/proj/uml/linux/linux-2.4.27/arch/um/fs/hostfs/.backup/hostfs_ke
>rn.c.\~1\~
> /home/quarl/proj/uml/linux/linux-2.4.27/arch/um/fs/hostfs/hostfs_kern.c ---
> /home/quarl/proj/uml/linux/linux-2.4.27/arch/um/fs/hostfs/.backup/hostfs_ke
>rn.c.~1~	2005-06-10 16:58:51.000000000 -0700 +++
> /home/quarl/proj/uml/linux/linux-2.4.27/arch/um/fs/hostfs/hostfs_kern.c	200
>5-06-10 17:35:01.829485585 -0700 @@ -1,3 +1,6 @@
> +#define KLUDGE_FS_UID 7777
> +#define KLUDGE_FS_GID 7777
> +
>  /*
>   * Copyright (C) 2000 - 2003 Jeff Dike (jdike@addtoit.com)
>   * Licensed under the GPL
> @@ -142,6 +145,10 @@
>  	ino->i_blocks = i_blocks;
>  	if(kdev_same(ino->i_sb->s_dev, ROOT_DEV) && (ino->i_uid == getuid()))
>  		ino->i_uid = 0;
> +        else if (ino->i_uid == getuid()) {          /* KC KLUDGE */
> +                ino->i_uid = KLUDGE_FS_UID;         /* KC KLUDGE */
> +                ino->i_gid = KLUDGE_FS_GID;         /* KC KLUDGE */
> +        }                                           /* KC KLUDGE */
>  	return(0);
>  }
>
> @@ -760,13 +767,17 @@
>  		if(kdev_same(dentry->d_inode->i_sb->s_dev, ROOT_DEV) &&
>  		   (attr->ia_uid == 0))
>  			attr->ia_uid = getuid();
> +                else if (attr->ia_uid == KLUDGE_FS_UID) { /* KC KLUDGE */
> +                        attr->ia_uid = getuid();          /* KC KLUDGE */
> +                        attr->ia_gid = getgid();          /* KC KLUDGE */
> +                }                                         /* KC KLUDGE */
>  		attrs.ia_valid |= HOSTFS_ATTR_UID;
>  		attrs.ia_uid = attr->ia_uid;
>  	}
>  	if(attr->ia_valid & ATTR_GID){
>  		if(kdev_same(dentry->d_inode->i_sb->s_dev, ROOT_DEV) &&
>  		   (attr->ia_gid == 0))
> -			attr->ia_gid = getuid();
> +			attr->ia_gid = getgid();
>  		attrs.ia_valid |= HOSTFS_ATTR_GID;
>  		attrs.ia_gid = attr->ia_gid;
>  	}

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
