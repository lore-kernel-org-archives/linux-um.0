Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ALocB-0000ry-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 17 Nov 2003 11:00:47 -0800
Received: from blacksheep.csh.rit.edu ([129.21.60.6])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1ALobC-0005Sy-LO
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 17 Nov 2003 10:59:46 -0800
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] Re: Bug#220679: user-mode-linux: Fails to Mount Root Filesystem on Reboot
Message-ID: <20031117185942.GZ9377@dijkstra.csh.rit.edu>
References: <20031117161447.GL9377@dijkstra.csh.rit.edu> <Pine.LNX.4.44.0311171352460.26239-100000@slash.mukesh.agrawals.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311171352460.26239-100000@slash.mukesh.agrawals.org>
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
Date: Mon, 17 Nov 2003 13:59:42 -0500
To: user-mode-linux@mukesh.agrawals.org
Cc: Daniel Burton <dan@spaz.org>, 220679@bugs.debian.org, user-mode-linux-devel@lists.sourceforge.net

On Mon, Nov 17, 2003 at 01:55:35PM -0500, user-mode-linux@mukesh.agrawals.org wrote:

> On Mon, 17 Nov 2003, Matt Zimmerman wrote:
> 
> > On Mon, Nov 17, 2003 at 12:43:49AM -0800, Daniel Burton wrote:
> > > F_SETLK failed, file already locked by pid 26263
> > > Failed to lock 'root_fs', err = 11
> > > unable to open root_fs for validation
> >
> > And this is the problem.  Presumably pid 26263 is the UML itself, and for
> > some reason the file isn't getting unlocked.
> 
> You may have another UML using that file. Perhaps you killed some of the
> UML processes, but not all of them?
> 
> "ps aux | grep linux" will probably show a UML still running.
> 
> (This has always been the case for me, when I get the "F_SETLK failed"
> message.)

This was after a reboot, not killing UML, so this same UML was able to lock
the file earlier, and no other UML could have locked it during that time.

-- 
 - mdz


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
