Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ABDnt-0004as-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 19 Oct 2003 06:41:05 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1AAqlM-0008E8-LF
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 18 Oct 2003 06:04:56 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Exactly what is wanted with hostfs UID/GID operation
References: <3F8B2B6E.30709@easyco.com>
In-Reply-To: <3F8B2B6E.30709@easyco.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200310171358.20666.blaisorblade_spam@yahoo.it>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 17 Oct 2003 16:28:57 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: jdike@addtoit.com

Answering to a previous message of Jeff Dike
At 03:49, 11 Oct 2003, Jeff Dike wrote:
> doug@easyco.com said:
> > The code itself involves a lot of extra parameters from kernel to user
> >  space as things like the current user aren't propogated down.  I
> > personally think that our current patch set is "100% ugly" and would
> > not  consider posting it as-is.  If people are interested in
> > transparent  numeric UID/GID to hostfs, then I would be happy to clean
> > up what we  have and submit it.
>
> OK, that ain't the way to do it.  Anything that involves passing a parallel
> set of creds through VFS will cause Al Viro to lop my head off.  Since I'm
> somewhat attached to it, I will not propose such a thing, no matter how
> cleaned up it is.
I don't agree. Al Viro doesn't matter here. The only more params to pass are 
from hostfs_kern.c to hostfs_user.c. Stop. Also, since we are in process 
context inside hostfs_kern.c, we can also read current very easily (even if we 
should rely on VFS permission handling as much as possible). By the way, if 
you want to manage the UMSDOS-like db, then you need to pass exactly the same 
params down.
**Security risks!**
Besides, even with the UMSDOS-like db, you still need to avoid as much as 
possible to create root-owned files on the host. It's always a security risk, 
even if it's not that easy to exploit: for instance, let's look at the man 
page of modutils:

By default, modutils will reject attempts to use a  module  that
              is  not  owned by root.
Luckily, you need write access to the /lib/modules path to exploit this, but 
it's not a good thing anyway. So if we remove this possibility, it's a better 
world for all us.
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN




-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
