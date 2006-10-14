Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GYZN4-0000Hg-80 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Oct 2006 19:35:30 -0700
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GYZMz-0005oG-Ic
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Oct 2006 19:35:30 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 14 Oct 2006 04:35:08 +0200
References: <452C29F2.8050908@theshore.net>
	<200610140243.00086.blaisorblade@yahoo.it>
	<45303B3C.808@theshore.net>
In-Reply-To: <45303B3C.808@theshore.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610140435.09094.blaisorblade@yahoo.it>
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, "Christopher S. Aker" <caker@theshore.net>

On Saturday 14 October 2006 03:19, Christopher S. Aker wrote:
> Blaisorblade wrote:
> > On Friday 13 October 2006 22:07, Jeff Dike wrote:
> >> On Tue, Oct 10, 2006 at 06:17:06PM -0500, Christopher S. Aker wrote:
> >>> This is 2.6.18-um, on top of a 2.6.16.29-skas3-v8.2 host.
> >>>
> >>> Kernel file is here:
> >>> http://www.theshore.net/~caker/uml/kernels/2.6.18-linode25
> >>>
> >>>
> >>> Kernel panic - not syncing: Kernel mode fault at addr 0x92c00000, ip
> >>> 0x80bcead

> > Jeff, are these addresses normal? They tell that the binary is a
> > statically linked one - but what is the memory layout? Chris, can you
> > post
> > cat /proc/<pid>/maps on a running instance of that kernel, together with
> > host and guest config (the guest's one is contained there, I know, but I
> > don't have the time to extract).

> > I'm suspiscious about memory layout problems (say host with unusual
> > splits, like 1G/3G, or some problem with memory mappings anyhow).

> All the stuff you requested is in here:
> http://www.theshore.net/~caker/uml/kmf/

> http://www.theshore.net/~caker/uml/kmf/maps.txt (has the maps from all
> the UML's pids, in case you notice duplicates)

> http://www.theshore.net/~caker/uml/kmf/config-2.6.18-um.txt
> http://www.theshore.net/~caker/uml/kmf/config-2.6.16.29-1-bigmem-skas-v8.2.
>txt
Which is the cmd line? With how much memory where these instances started?

Ok, Jeff, I recall something but I'm not sure. I even thought kernel threads 
mapped the whole RAM at boot in their physical range part (which is their 
entire address space), but it does not seem so.

The host is just a 64G with 3G/1G split, however the UML is a TT+SKAS with 
HALF_GIGS=2 (which _is_ unusual, and could be replaced with disabling TT 
entirely, which gives a free 2,75G of memory space for UML). In fact, the UML 
binary starts at 0x8000 0000 (i.e. 2G), and there are various holes in the 
virtual RAM mapped in kernel side - a big part of about 30M (the 
0x80607000-0x92c00000 range), then there is a 4M hole (the pre-vmalloc hole 
should be 8M, but we have a 4M hole for uml_reserved after current brk()), 
then various holes and allocated ranges (with varying offsets) here and 
there, like if the area were allocated for vmalloc(). The problem is that we 
have an allocated anonymous memory range (which the checksum is accessing) 
before the 4M hole!

80000000-80514000 rwxp 00000000 fd:00 540678     /vbin/kernel/2.6.18-linode25
80514000-80607000 rwxp 80514000 00:00 0          [heap]
80607000-92c00000 rwxs 00607000 00:16
	738427     /linodes/encode1/tmp/vm_file-AVT0fb (deleted)
<hole here>
93000000-9300b000 rwxs 006b6000 00:16
	738427     /linodes/encode1/tmp/vm_file-AVT0fb (deleted)
9300c000-93017000 rwxs 006c2000 00:16
	738427     /linodes/encode1/tmp/vm_file-AVT0fb (deleted)

I can't follow this code at the moment, so I go for now.
Bye!
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
