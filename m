Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fjlxg-0004XI-44 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 May 2006 16:43:20 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fjlxg-00082L-7I for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 May 2006 16:43:20 -0700
Received: from rc5.robl.org.uk ([80.68.88.33] helo=robl.org.uk)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Fjlxc-0007bJ-Hq
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 May 2006 16:43:20 -0700
Received: from localhost ([127.0.0.1] helo=webmail.robl.org.uk)
	by robl.org.uk with esmtp (Exim 4.52) id 1FjlxT-0000xE-7T
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 27 May 2006 00:43:07 +0100
From: "robl" <robl@robl.org.uk>
Reply-To: spam@robl.org.uk
Subject: Re: [uml-devel] UML Hang / strace fix
Message-Id: <20060526233925.M96557@robl.org.uk>
In-Reply-To: <20060526221751.M57003@robl.org.uk>
References: <20060526221751.M57003@robl.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
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
Date: Sat, 27 May 2006 00:43:07 +0100
To: user-mode-linux-devel@lists.sourceforge.net


I've installed a UML kernel from http://uml.nagafix.co.uk/ and this seems to
have fixed the problem so it looks like a problem with the stock debian
user-mode-linux package kernel.  If anybody is interested in the problem then
let me know what diagnostics you'd like to see and I'll see what I can provide
(it would be nice if the stock debian worked on my system) but otherwise I'm
happy with this solution.

Cheers,

Rob

On Fri, 26 May 2006 23:30:12 +0100, robl wrote
> Hi,
> 
> I posted this on #UML and was asked to repeat it here ...
> 
> I've recently installed UML on a Compaq DL360 G1 Dual P3 1Ghz / 
> Debian Sarge
> 
> I see intermittent hangs with the UML kernel at :
> 
> Initialized stdio console driver
> Console initialized on /dev/tty0
> Initializing software serial port version 1
>  ubda: unknown partition table
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.  <----- Hangs here
> 
> The processlist at this point is :
> 
> root     14553  1.1  1.9 206200 10056 pts/0  S+   00:33   0:00       
>    linux mem=200M eth0=tuntap,tap1 root     14558  0.0  1.9 206200 
> 10056 pts/0  S+   00:33   0:00             linux mem=200M 
> eth0=tuntap,tap1 root     14559  0.0  1.9 206200 10056 pts/0  S+   
> 00:33   0:00             linux mem=200M eth0=tuntap,tap1 root    
>  14560  0.0  1.9 206200 10056 pts/0  S+   00:33   0:00             
> linux mem=200M eth0=tuntap,tap1
> 
> If I strace -p 14560 then I see :
> 
> debian:~# strace -p 14560
> Process 14560 attached - interrupt to quit
> poll([{fd=15, events=POLLIN, revents=POLLIN}], 1, -1) = 1
> read(15, "\0", 1)                       = 1
> write(15, "\0", 1)                      = 1
> poll(
> 
> This then causes the UML kernel to continue booting normally.
> 
> It seems a 50/50 success/hang rate.
> 
> The UML kernel is Linux (none) 2.6.16 #2 Sat Apr 29 23:36:42 CEST 
> 2006 i686 GNU/Linux
> 
> I've tried this with a stock Debian sarge 2.4 and a patched 2.6 skas 
> as the host kernels both with the same results.
> 
> Anybody have any ideas why this hangs and why strace kicks it back 
> into action ?
> 
> Thanks,
> 
> Rob
> 
> -------------------------------------------------------
> All the advantages of Linux Managed Hosting--Without the Cost and Risk!
> Fully trained technicians. The highest number of Red Hat 
> certifications in the hosting industry. Fanatical Support. Click to 
> learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
