Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AG4Vj-0006K0-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 01 Nov 2003 14:46:23 -0800
Received: from blacksheep.csh.rit.edu ([129.21.60.6])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AG4Vi-0005kQ-O7
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 01 Nov 2003 14:46:22 -0800
Received: from dijkstra (dijkstra.csh.rit.edu [129.21.60.152])
	by blacksheep.csh.rit.edu (Postfix) with ESMTP id 24859333
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat,  1 Nov 2003 17:46:22 -0500 (EST)
Received: from mdz by dijkstra with local (Exim 3.35 #1 (Debian))
	id 1AG4Vh-0006EP-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 01 Nov 2003 17:46:21 -0500
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] Partitioning scheme for ubd's
Message-ID: <20031101224621.GP6350@dijkstra.csh.rit.edu>
References: <200311011159.11435.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311011159.11435.blaisorblade_spam@yahoo.it>
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
Date: Sat, 1 Nov 2003 17:46:21 -0500
To: user-mode-linux-devel@lists.sourceforge.net

On Sat, Nov 01, 2003 at 11:59:11AM +0100, BlaisorBlade wrote:

> But there is a problem here:
> 1) device names are not consistent: if you want to use ubd[a-z], decide so
> and start the change(for 2.6 there's a lot more changes anyway, so it is a
> good occasion...)

Are you talking about /proc/partitions or something else?

> 2) if I do an install, I can partition the ubd's; but then, I won't be
> able to loop mount the file on the host(and if I'm in trouble, this
> ability is worth a lot). In fact, I've never partitioned the ubd's, but
> this meant a lot of trouble even to run Slackware install.

Of course you can; use losetup -o (or mount -o loop,offset=).  But I don't
see what this has to do with partition support for ubd.  You can use
partitions or not, depending on what you prefer, just as with a real block
device.

> 3) so, I thought this: since partitioning schemes are pluggable, it would be 
> possible to fool it and turn the ubd's into partitions of a single disk. I.e. 
> if I setup udb0, ubd1 and so on, they would be seen as three partitions of a 
> single disk. But they are still different files, loop-mountable on host.
> 
> Would you ever accept this? The other possible solution(which would be 
> cleaner) would be to teach, if possible, to the host kernel Device Manager to 
> read a file as a bunch of partition with its table(I've heard of DM about COW 
> files these days), and then to mount the partitions, but I don't know if it's 
> possible.

I can't think of any instance where I'd want this mixed solution, instead of
the existing options with partitions and multiple ubd devices.

-- 
 - mdz


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
