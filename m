Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AH7EQ-00035F-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 04 Nov 2003 11:52:50 -0800
Received: from blacksheep.csh.rit.edu ([129.21.60.6])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AH7EP-00005Y-NW
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 04 Nov 2003 11:52:49 -0800
Received: from dijkstra (dijkstra.csh.rit.edu [129.21.60.152])
	by blacksheep.csh.rit.edu (Postfix) with ESMTP id 28A4E3F2
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue,  4 Nov 2003 14:52:48 -0500 (EST)
Received: from mdz by dijkstra with local (Exim 3.35 #1 (Debian))
	id 1AH7EO-0000eu-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 04 Nov 2003 14:52:48 -0500
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] Partitioning scheme for ubd's
Message-ID: <20031104195247.GW9377@dijkstra.csh.rit.edu>
References: <200311041921.09084.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311041921.09084.blaisorblade_spam@yahoo.it>
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
Date: Tue, 4 Nov 2003 14:52:47 -0500
To: user-mode-linux-devel@lists.sourceforge.net

On Tue, Nov 04, 2003 at 07:21:09PM +0100, BlaisorBlade wrote:

> Alle 23:46, sabato 1 novembre 2003, Matt Zimmerman ha scritto:
> > On Sat, Nov 01, 2003 at 11:59:11AM +0100, BlaisorBlade wrote:
> > > But there is a problem here:
> > > 1) device names are not consistent: if you want to use ubd[a-z], decide
> > > so and start the change(for 2.6 there's a lot more changes anyway, so it
> > > is a good occasion...)
> >
> > Are you talking about /proc/partitions or something else?
> 
> No, about the command line and the device file names.

The command line, I think, accepts both for backward compatibility.  The
device file names, of course, are a userland concern.  Current versions of
makedev, at least in Debian, use the new scheme.

> > > The other possible solution(which would be
> > > cleaner) would be to teach, if possible, to the host kernel Device
> > > Manager to read a file as a bunch of partition with its table(I've heard
> > > of DM about COW files these days), and then to mount the partitions, but
> > > I don't know if it's possible.
> 
> Would instead this one(or another way to do this) be interesting? So that the
> kernel could guess by itself the offsets of partitions, rather than requiring
> the user do more passages(i.e. use fdisk to read partition table) to handle
> this.

I suppose the solution to this would be partition support on loop devices.
Is this any easier in 2.6?

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
