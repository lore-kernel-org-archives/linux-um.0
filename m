Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5Bic-0004nM-DV for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Sep 2004 16:19:14 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1C5Bia-00043j-LI
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Sep 2004 16:19:14 -0700
Message-Id: <200409090022.i890MNBP016031@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Sun, 05 Sep 2004 18:04:31 +0200."
	<200408291307.11051.blaisorblade_spam@yahoo.it> 
References: <200408291307.11051.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: The new filehandle abstraction: doubts and complaints
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
Date: Wed, 08 Sep 2004 20:22:23 -0400
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

blaisorblade_spam@yahoo.it said:
> - locking is not complete: active_handle moves fh->list without
> holding  open_files_lock.  

Yup, good spotting.

> - is_reclaimable should become make_reclaimable: the name
> is_reclaimable  should be reserved for a function which says if the fd
> is reclaimable or not,  if that function is needed. 

Yeah, I've been looking suspiciously at that name.

> Probably we don't
> need this, but this is what  "is_reclaimable" makes me think: 

Don't add it until it's needed.

> - there is an implicit race between using a fd and closing it: there
> is no  reason why someone shouldn't be closing the fd while we are
> reading from it  (or just after it has been read from the struct and
> before we do the syscall,  more exactly). 

This is a different issue.  VFS should protect against that, as long as a
host inode always gets the same UML inode, even if you're looking at it 
through a different mount.  Part of that is using the same inode number
as the host, so that will always match up, which we do.  The other is the
superblock, which is also part of the inode hash.  This is done wrong - we
allocate a different superblock for every mount.

I'm wondering whether hostfs superblocks should correspond to host filesystems.
This would fix the coherency issue, but I don't know whether it would
break anything else.

> The patch I'm attaching contains some of the needed changes to the
> API,  without touching its users, because I don't know if my proposal
> will become  the actual API or not. 

That patch is trying to do a lot of things, and they're all mixed up with
each other.  Can you split it out a bit more?

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
