Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AJ6Yg-0003JP-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 09 Nov 2003 23:33:58 -0800
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=0)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AJ6Yf-0003Ix-9F
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 09 Nov 2003 23:33:57 -0800
Subject: Re: [uml-devel] skas & /proc/mm in the host kernel, yet /proc/mm
 'not found'
References: <200309182037.h8IKbMEk028815@hongkong.cs.nmsu.edu>
	<20030919095020.294F93BCE4@home.petschge.de>
	<20030920173518.521B03BCE7@home.petschge.de>
	<Pine.LNX.4.58.0309220535000.28187@crystal.nuked.org>
	<200309232016.h8NKGNaK003251@ccure.karaya.com>
	<Pine.LNX.4.58.0309232330340.28187@crystal.nuked.org>
	<200309241619.h8OGJwaK006019@ccure.karaya.com>
	<87fzig533b.fsf@amaterasu.srvr.nix>
	<200311100239.hAA2daxD013066@ccure.user-mode-linux.org>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <200311100239.hAA2daxD013066@ccure.user-mode-linux.org> (Jeff
 Dike's message of "Sun, 09 Nov 2003 21:39:36 -0500")
Message-ID: <878ymoiso6.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Mon, 10 Nov 2003 07:33:45 +0000
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, 09 Nov 2003, Jeff Dike spake:
> nix@esperi.demon.co.uk said:
>> Kernel panic: init_new_context_skas - new_mm failed, errno = -24 
> 
> This is EMFILE - Too many open files
> 
> Do you have a disgustingly low file limit, or was UML opening an immense number
> of files?  Looking at /proc/<pid>/fd for a UML pid would be informative.

Hm, well, the system as a whole is hardly straining:

953     266     8192

and while each UML thread has a lot of stuff open, it doesn't have
*that* many (and I can't see why it would have many more as this
UML is rarely much busier than it is now):

/proc/297/fd:
total 36
lr-x------    1 firewall firewall       64 Nov 10 07:28 0 -> /dev/null
l-wx------    1 firewall firewall       64 Nov 10 07:28 1 -> /dev/null
l-wx------    1 firewall firewall       64 Nov 10 07:28 10 -> /proc/mm
l-wx------    1 firewall firewall       64 Nov 10 07:28 11 -> /proc/mm
lrwx------    1 firewall firewall       64 Nov 10 07:28 12 -> socket:[4351]
l-wx------    1 firewall firewall       64 Nov 10 07:28 13 -> /proc/mm
lrwx------    1 firewall firewall       64 Nov 10 07:28 14 -> /dev/net/tun
lrwx------    1 firewall firewall       64 Nov 10 07:28 15 -> /dev/net/tun
l-wx------    1 firewall firewall       64 Nov 10 07:28 16 -> /proc/mm
l-wx------    1 firewall firewall       64 Nov 10 07:28 17 -> /proc/mm
l-wx------    1 firewall firewall       64 Nov 10 07:28 18 -> /proc/mm
l-wx------    1 firewall firewall       64 Nov 10 07:28 19 -> /proc/mm
l-wx------    1 firewall firewall       64 Nov 10 07:28 2 -> /dev/null
l-wx------    1 firewall firewall       64 Nov 10 07:28 20 -> /proc/mm
l-wx------    1 firewall firewall       64 Nov 10 07:28 21 -> /proc/mm
l-wx------    1 firewall firewall       64 Nov 10 07:28 22 -> /proc/mm
l-wx------    1 firewall firewall       64 Nov 10 07:28 23 -> /proc/mm
l-wx------    1 firewall firewall       64 Nov 10 07:28 24 -> /proc/mm
l-wx------    1 firewall firewall       64 Nov 10 07:28 25 -> /proc/mm
l-wx------    1 firewall firewall       64 Nov 10 07:28 26 -> /proc/mm
l-wx------    1 firewall firewall       64 Nov 10 07:28 27 -> /proc/mm
lrwx------    1 firewall firewall       64 Nov 10 07:28 28 -> /home/.loki.wkstn.nix/firewall/log/esperi/1068250386-456237
l-wx------    1 firewall firewall       64 Nov 10 07:28 29 -> /proc/mm
lrwx------    1 firewall firewall       64 Nov 10 07:28 3 -> /tmp/vm_file-AUj74X (deleted)
l-wx------    1 firewall firewall       64 Nov 10 07:28 30 -> /proc/mm
l-wx------    1 firewall firewall       64 Nov 10 07:28 33 -> /proc/mm
l-wx------    1 firewall firewall       64 Nov 10 07:28 35 -> /proc/mm
l-wx------    1 firewall firewall       64 Nov 10 07:28 36 -> /proc/mm
lrwx------    1 firewall firewall       64 Nov 10 07:28 37 -> /home/.loki.wkstn.nix/firewall/log/esperi/1068250771-738857
l-wx------    1 firewall firewall       64 Nov 10 07:28 38 -> /proc/mm
lrwx------    1 firewall firewall       64 Nov 10 07:28 4 -> socket:[1375]
lrwx------    1 firewall firewall       64 Nov 10 07:28 5 -> socket:[1378]
lrwx------    1 firewall firewall       64 Nov 10 07:28 6 -> socket:[1379]
lrwx------    1 firewall firewall       64 Nov 10 07:28 7 -> /mirror/uml/esperi-root-cow.image
lr-x------    1 firewall firewall       64 Nov 10 07:28 8 -> /mirror/uml/esperi-root.image
lrwx------    1 firewall firewall       64 Nov 10 07:28 9 -> /home/.loki.wkstn.nix/firewall/log/esperi/1068250066-884422

It seems to me that it would take quite a change for this to rise to
thousands upon thousands of open fds.

(There are 31 processes running in this UML right now.) Of course this
UML's only been running for two days.

The crash seems to happen when I'm sshed in from the outside world doing
things that involve lots of tty activity: I wonder if the tty logging
may be at fault?

I'll do a watched ls -l on /proc/297/fd when I'm sshed in next (in a
couple of hours) and see what happens.

>> hppfs_open : failed to open a socket in 'proc/uptime/r', err = 1 
> 
> This is likely the same thing, just the errno return was botched.

The odd thing is that I have no hppfs filesystems mounted. It's *there*,
but I've not used it (or honeypot.pl or any similar thing) as UML
started panicking on me in short order (minutes) whenever I used it.

-- 
`Me, I want exploding spaceships and pulverized worlds and clashes of
 billion-year-old empires *and* competently written sentences.'
                                                    --- Matt Austern


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
