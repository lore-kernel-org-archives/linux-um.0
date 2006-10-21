Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gb5If-0001eK-9a for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Oct 2006 18:05:21 -0700
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Gb5Id-0005Wi-Lw
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Oct 2006 18:05:21 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 21 Oct 2006 02:38:16 +0200
References: <v0r6x41bnb.fsf@marajade.sandelman.ca>
	<v0vemg6jbo.fsf@marajade.sandelman.ca>
In-Reply-To: <v0vemg6jbo.fsf@marajade.sandelman.ca>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610210238.16557.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Xen 3.0.2 and UML guest
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
Cc: Michael Richardson <mcr@sandelman.ottawa.on.ca>

On Friday 20 October 2006 00:18, Michael Richardson wrote:
> >>>>> "Michael" == Michael Richardson <mcr@sandelman.ottawa.on.ca> writes:
>
>     Michael> The fault may well be Xen's.  I'm looking for other
> experiences, Michael> yeah or nay.
>
> I built a tree on my laptop as I normally do. It runs etch, and as does my
> debian XenU.  With 2.6.15 UML guest on my laptop, everything is fine.
>
> Same binary running under a XenU, goes into R state under XenU:

I forget - XenU is an unprivileged guest, and Xen0 is the main one IIRC 
(vaguely) - if that is an unprivileged guest have you tried on the root one?

>  5749 pts/1    Ss+    0:00 /bin/sh
> /0i/sandboxes/UMLPOOL/260ocf/umlbuild/east/st 5750 pts/1    R+     2:33
> /0i/sandboxes/UMLPOOL/260ocf/umlbuild/swan26/linux in 5756 pts/1    S+    
> 0:00 /0i/sandboxes/UMLPOOL/260ocf/umlbuild/swan26/linux in 5757 pts/1    S+
>     0:00 /0i/sandboxes/UMLPOOL/260ocf/umlbuild/swan26/linux in 5758 pts/1  
>  S+     0:00 /0i/sandboxes/UMLPOOL/260ocf/umlbuild/swan26/linux in 5759
> pts/1    T+     1:19 [linux]
>
> It looks like this happens as soon as the scheduler is enabled.
> mode=tt WORKS.
>
> Running uml_mconsole east sysrq t:
>
> Checking that ptrace can change system call numbers...OK
> Checking syscall emulation patch for ptrace...OK
> Checking advanced syscall emulation patch for ptrace...OK
> Checking PROT_EXEC mmap in /tmp...OK
> Checking for the skas3 patch in the host:
>   - /proc/mm...not found
>   - PTRACE_FAULTINFO...not found
>   - PTRACE_LDT...not found
> UML running in SKAS0 mode
>
>     <BIG PAUSE ******>
>
> Linux version 2.6.15 (mcr@marajade.sandelman.ca) (gcc version 4.1.2
> 20060901 (pr                      erelease) (Debian 4.1.1-13)) #2 Thu Oct
> 19 17:29:21 EDT 2006 Built 1 zonelists

A strace -t (or whichever option shows the timings) would help finding _where_ 
is the big pause...
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
