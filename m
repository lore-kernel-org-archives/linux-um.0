Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6ZIV-0001N4-G1 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Sep 2004 11:41:59 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C6ZIT-0002Eo-3r for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Sep 2004 11:41:58 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] glibc and NPTL, problem, workarounds, etc.
References: <Pine.LNX.4.58.0409081440150.3136@sparrow>
In-Reply-To: <Pine.LNX.4.58.0409081440150.3136@sparrow>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409122020.51479.blaisorblade_spam@yahoo.it>
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
Date: Sun, 12 Sep 2004 20:20:51 +0200
To: user-mode-linux-devel@lists.sourceforge.net, William Stearns <wstearns@pobox.com>

On Wednesday 08 September 2004 21:02, William Stearns wrote:
> Good day, all,
> 	Zaphod had a rather nasty filesystem crash last week.  It happened
> around the time that two other events happened; the raid array forgot it
> had drive 3 (requiring me to remove and re-add the drive and start a raid
> rebuild), and one of the users was attempting to upgrade glibc on debian.
> This put in a new version of glibc, along with the NPTL (Native Posix
> Threading Libraries) that don't work with UML.  From that point, that user
> could log in with ssh, but could no longer run any applications because
> bash refused to fork.

> 	There are a couple of workarounds for this problem.  First, when
> installing any root filesystem, check afterwards to see if there's a
> directory called /lib/tls/ .  If so, rename or delete it.  This removes
> the NPTL extensions to glibc but leaves glibc itself, so applications
> continue to work; they just never try to use the NPTL extensions.
> 	To make sure it's never used again, do the following as root:

There is another patch which should make the work - (I never tested it, but it 
should work). Basically, uname will state it is a "i586" rather than "i686", 
so NPTL is not enabled:

http://www.suse.de/~kraxel/uml/patches/uml-pretend-to-be-i586

> rm -rf /lib/tls/
> mkdir /lib/tls/
> chmod 000 /lib/tls/
> chattr +i /lib/tls/

> 	Now even root can't write to that directory.  Any attempt to
> install a new version of glibc will probably fail because rpm/apt can't
> write to that directory, but it's better than having a non-functioning
> system.

> 	In trying to run the above commands while fixing his system, I ran
> into the problem where the commands I wanted to run loaded glibc and the
> NPTL libaries, and therefore refused to run (the error message I got on
> fork mentioned "nptl").  In fact, running single user mode (starting up
> uml with "ro single init=/bin/bash") didn't do any better since bash
> needed to fork to run the above commands and the fork failed.
> 	The workaround to the above is this:
>
> export LD_ASSUME_KERNEL=2.4.1
> exec /bin/bash

> 	which replaces your current bash with a new one that won't try to
> load the nptl libraries.  Now you can run commands even though the
> /lib/tls/ directory is there - this would be an excellent time to remove
> them.  :-)

> 	Jeff, I have a seriously hard time believing that simply running
> nptl binaries could cause journal errors out on the host.

You got them on the *physical* host? Yup!

> I'm much more 
> inclined to believe that the raid rebuild might have briefly set the block
> devices read-only
No, it shouldn't have - I didn't write the RAID code, but I'm sure that 
anything such is not allowed to happen.

Did the machine poweroff/crash/oops during the rebuild?

I've lately discovered (and fixed) a big number of problems with the SKAS 
patch, and somebody reported a host crash while running Java in UML which 
could be connected to one of the SKAS bugs.
> , long enough for the journal to give up because there's 
> no place to put the data. 
Ok, there is something more similar that could, actually, have happened. The 
device does not become "read only" at all - the stripe which is being 
processed will probably be locked for a while, which means that the datas 
will wait to be written for a while. Then, if memory is exhausted, the 
journal will get errors.
> I just thought I'd bring up the closesness in 
> time in case it triggered any connections for you.

> 	I do have some of the host journal errors if they're useful, but I
> suspect they're not.
Please post the messages (without flooding us with debug datas - post only 
what is easily human-readable, and redirect the rest to the LKML, the 
filesystem ML and to the RAID ml, if any).

Also, which is the filesystem you use?

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
