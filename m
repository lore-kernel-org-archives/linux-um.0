Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AgQQX-0001Sw-Hn for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Jan 2004 07:25:57 -0800
Received: from lns-p19-18-82-65-125-142.adsl.proxad.net
	([82.65.125.142] helo=yellowpig.yi.org ident=mail)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AgQQW-0004QH-Kg for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Jan 2004 07:25:56 -0800
Message-ID: <20040113152542.GD7072@seventeen>
References: <20031221005257.GF9354@alcor.net> <20031221010656.GH9354@alcor.net>
	<20031228093317.GK17472@alcor.net>
	<20031228095115.GL17472@alcor.net>
	<20031228101240.GN17472@alcor.net>
	<20031228113042.GO17472@alcor.net>
	<20031230184330.GD1365@alcor.net>
	<200401060258.i062wWFI023087@ccure.user-mode-linux.org>
	<20040108070718.GI28393@alcor.net>
	<20040112183623.GB1436@alcor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040112183623.GB1436@alcor.net>
From: Bill Allombert <allomber@math.u-bordeaux.fr>
Subject: [uml-devel] Re: Panic with slirp transport and gcc 3.3
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
Date: Tue, 13 Jan 2004 16:25:42 +0100
To: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, 176485@bugs.debian.org
Cc: mdz@debian.org

On Mon, Jan 12, 2004 at 10:36:23AM -0800, Matt Zimmerman wrote:
> By the way, the original reason why I started building UML with gcc-2.95 was
> because building with 3.x broke the slirp transport like so:
> 
> Kernel panic: read of switch_pipe failed, errno = 9
> 
> errno 9 is EBADF.  I never did find the real cause of that bug, but it has
> resurfaced now that I am building with gcc 3.3 again to fix the other, worse
> bug.  I would be interested to know if anyone else has run into it.  More
> information is here:

For what it worth with the current Debian UML package I get

$ linux ubd0=uml root=/dev/ubd0 eth0=slirp|& less
...
 Netdevice 0 : SLIRP backend - command line: 'slirp'
 mconsole (version 2) initialized on /home/bill/.uml/wksNEk/mconsole
 Partition check:
  ubda: unknown partition table
 Initializing stdio console driver
 NET4: Linux TCP/IP 1.0 for NET4.0
 IP: routing cache hash table of 512 buckets, 4Kbytes
 TCP: Hash tables configured (established 2048 bind 4096)
 Linux IP multicast router 0.06 plus PIM-SM
 NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
 Kernel panic: Segfault with no mm

Without the eth0=slirp parameter, there are no kernel panic.
So at least the error message has changed.

The host kernel has the skas patch from the Debian package applied.

Cheers,
-- 
Bill. <ballombe@debian.org>

Imagine a large red swirl here. 


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
