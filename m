Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GYaJc-0005a4-3E for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Oct 2006 20:36:00 -0700
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GYa1P-00029n-Vl
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Oct 2006 20:17:14 -0700
Message-ID: <453056B0.1060000@theshore.net>
Date: Fri, 13 Oct 2006 22:17:04 -0500
From: "Christopher S. Aker" <caker@theshore.net>
MIME-Version: 1.0
References: <452C29F2.8050908@theshore.net>
	<200610140243.00086.blaisorblade@yahoo.it>
	<45303B3C.808@theshore.net>
	<200610140435.09094.blaisorblade@yahoo.it>
In-Reply-To: <200610140435.09094.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x92c00000, ip 0x80bcead
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Blaisorblade wrote:
> Which is the cmd line? With how much memory where these instances started?

Kernel command line: mem=300M fake_ide fakehd con=null con0=fd:0,fd:1 
devfs=nomount root=/dev/ubda ubda=<snip> 7 ubdb=<snip> 
eth0=tuntap,encode1_0,fe:fd:46:55:81:95 token_max=400000 token_refill=512

> Ok, Jeff, I recall something but I'm not sure. I even thought kernel threads 
> mapped the whole RAM at boot in their physical range part (which is their 
> entire address space), but it does not seem so.
> 
> The host is just a 64G with 3G/1G split, however the UML is a TT+SKAS with 
> HALF_GIGS=2 (which _is_ unusual, and could be replaced with disabling TT 

Jeff had this discussion with me a few weeks ago when I was trying to 
get UML to use more than ~550M.

At that time, I tried disabling TT mode but had to revert because non-TT 
mode enabled umls wouldn't boot on some very old skas hosts of mine.  I 
suspected that you might point in the same direction he did.  That 
problem is less important since I should really just upgrade those boxes...

> entirely, which gives a free 2,75G of memory space for UML). In fact, the UML 
> binary starts at 0x8000 0000 (i.e. 2G), and there are various holes in the 
> virtual RAM mapped in kernel side - a big part of about 30M (the 
> 0x80607000-0x92c00000 range), then there is a 4M hole (the pre-vmalloc hole 
> should be 8M, but we have a 4M hole for uml_reserved after current brk()), 
> then various holes and allocated ranges (with varying offsets) here and 
> there, like if the area were allocated for vmalloc(). The problem is that we 
> have an allocated anonymous memory range (which the checksum is accessing) 
> before the 4M hole!
> 
> 80000000-80514000 rwxp 00000000 fd:00 540678     /vbin/kernel/2.6.18-linode25
> 80514000-80607000 rwxp 80514000 00:00 0          [heap]
> 80607000-92c00000 rwxs 00607000 00:16
> 	738427     /linodes/encode1/tmp/vm_file-AVT0fb (deleted)
> <hole here>
> 93000000-9300b000 rwxs 006b6000 00:16
> 	738427     /linodes/encode1/tmp/vm_file-AVT0fb (deleted)
> 9300c000-93017000 rwxs 006c2000 00:16
> 	738427     /linodes/encode1/tmp/vm_file-AVT0fb (deleted)
> 
> I can't follow this code at the moment, so I go for now.
> Bye!

-Chris

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
