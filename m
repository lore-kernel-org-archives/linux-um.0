Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ALoYI-0000Cp-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 17 Nov 2003 10:56:46 -0800
Received: from sleator.dsl.telerama.com ([205.201.9.185] helo=slash.mukesh.agrawals.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1ALoXM-0004qi-An
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 17 Nov 2003 10:55:48 -0800
From: user-mode-linux@mukesh.agrawals.org
Subject: Re: [uml-devel] Re: Bug#220679: user-mode-linux: Fails to Mount Root
 Filesystem on Reboot
In-Reply-To: <20031117161447.GL9377@dijkstra.csh.rit.edu>
Message-ID: <Pine.LNX.4.44.0311171352460.26239-100000@slash.mukesh.agrawals.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Mon, 17 Nov 2003 13:55:35 -0500 (EST)
To: Daniel Burton <dan@spaz.org>
Cc: Matt Zimmerman <mdz@debian.org>, 220679@bugs.debian.org, user-mode-linux-devel@lists.sourceforge.net

On Mon, 17 Nov 2003, Matt Zimmerman wrote:

> On Mon, Nov 17, 2003 at 12:43:49AM -0800, Daniel Burton wrote:
>
> > Package: user-mode-linux
> > Version: 2.4.22-5um-1
> > Severity: normal
> > Followup-For: Bug #220679
> >
> > The root filesystem doesn't get mounted when I reboot running the
> > following script:
> >
> > #!/bin/sh
> > linux ubd0=root_fs ubd1=swap eth0=daemon ssl0=tty:/dev/ttyS4 mem=4000M \
> >     umid=vdialup root=/dev/ubd0 devfs=mount

> > F_SETLK failed, file already locked by pid 26263
> > Failed to lock 'root_fs', err = 11
> > unable to open root_fs for validation
>
> And this is the problem.  Presumably pid 26263 is the UML itself, and for
> some reason the file isn't getting unlocked.

You may have another UML using that file. Perhaps you killed some of the
UML processes, but not all of them?

"ps aux | grep linux" will probably show a UML still running.

(This has always been the case for me, when I get the "F_SETLK failed"
message.)



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
