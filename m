Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C57lh-0006fC-RX for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Sep 2004 12:06:09 -0700
Received: from slartibartfast.pa.net ([66.59.111.182])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C57lh-0003se-0T for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Sep 2004 12:06:09 -0700
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Message-ID: <Pine.LNX.4.58.0409081440150.3136@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] glibc and NPTL, problem, workarounds, etc.
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
Date: Wed, 8 Sep 2004 15:02:03 -0400 (EDT)
To: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: William Stearns <wstearns@pobox.com>

Good day, all,
	Zaphod had a rather nasty filesystem crash last week.  It happened 
around the time that two other events happened; the raid array forgot it 
had drive 3 (requiring me to remove and re-add the drive and start a raid 
rebuild), and one of the users was attempting to upgrade glibc on debian.  
This put in a new version of glibc, along with the NPTL (Native Posix 
Threading Libraries) that don't work with UML.  From that point, that user 
could log in with ssh, but could no longer run any applications because 
bash refused to fork.

	There are a couple of workarounds for this problem.  First, when 
installing any root filesystem, check afterwards to see if there's a 
directory called /lib/tls/ .  If so, rename or delete it.  This removes 
the NPTL extensions to glibc but leaves glibc itself, so applications 
continue to work; they just never try to use the NPTL extensions.
	To make sure it's never used again, do the following as root:

rm -rf /lib/tls/
mkdir /lib/tls/
chmod 000 /lib/tls/
chattr +i /lib/tls/

	Now even root can't write to that directory.  Any attempt to 
install a new version of glibc will probably fail because rpm/apt can't 
write to that directory, but it's better than having a non-functioning 
system.

	In trying to run the above commands while fixing his system, I ran
into the problem where the commands I wanted to run loaded glibc and the
NPTL libaries, and therefore refused to run (the error message I got on
fork mentioned "nptl").  In fact, running single user mode (starting up
uml with "ro single init=/bin/bash") didn't do any better since bash
needed to fork to run the above commands and the fork failed.
	The workaround to the above is this:

export LD_ASSUME_KERNEL=2.4.1
exec /bin/bash

	which replaces your current bash with a new one that won't try to 
load the nptl libraries.  Now you can run commands even though the 
/lib/tls/ directory is there - this would be an excellent time to remove 
them.  :-)

	Jeff, I have a seriously hard time believing that simply running 
nptl binaries could cause journal errors out on the host.  I'm much more 
inclined to believe that the raid rebuild might have briefly set the block 
devices read-only, long enough for the journal to give up because there's 
no place to put the data.  I just thought I'd bring up the closesness in 
time in case it triggered any connections for you.
	I do have some of the host journal errors if they're useful, but I 
suspect they're not.
	Cheers,
	- Bill

---------------------------------------------------------------------------
	"Computers let you make more mistakes faster than any other
invention in human history, with the possible exception of handguns and
tequila." 
	-- Mitch Radcliffe
(Courtesy of Hugo van der Kooij <hvdkooij@caiw.nl>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
