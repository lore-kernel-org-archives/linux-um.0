Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ALm2C-00051r-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 17 Nov 2003 08:15:28 -0800
Received: from blacksheep.csh.rit.edu ([129.21.60.6])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1ALm1Z-0001di-MG
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 17 Nov 2003 08:14:49 -0800
From: Matt Zimmerman <mdz@debian.org>
Message-ID: <20031117161447.GL9377@dijkstra.csh.rit.edu>
References: <E1ALez7-0007q5-Of@frankenstein>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ALez7-0007q5-Of@frankenstein>
Subject: [uml-devel] Re: Bug#220679: user-mode-linux: Fails to Mount Root Filesystem on Reboot
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
Date: Mon, 17 Nov 2003 11:14:47 -0500
To: Daniel Burton <dan@spaz.org>, 220679@bugs.debian.org
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Nov 17, 2003 at 12:43:49AM -0800, Daniel Burton wrote:

> Package: user-mode-linux
> Version: 2.4.22-5um-1
> Severity: normal
> Followup-For: Bug #220679
> 
> The root filesystem doesn't get mounted when I reboot running the 
> following script:
> 
> #!/bin/sh
> linux ubd0=root_fs ubd1=swap eth0=daemon ssl0=tty:/dev/ttyS4 mem=4000M \
>     umid=vdialup root=/dev/ubd0 devfs=mount

So you are saying that specifying ubd0= explicitly does _not_, in fact, fix
your problem?  Your previous message seems to have said that it did.

> F_SETLK failed, file already locked by pid 26263
> Failed to lock 'root_fs', err = 11
> unable to open root_fs for validation

And this is the problem.  Presumably pid 26263 is the UML itself, and for
some reason the file isn't getting unlocked.

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
