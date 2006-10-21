Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gb5q4-0004am-GX for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Oct 2006 18:39:52 -0700
Received: from newcod.sandelman.ca ([192.139.46.42] helo=cod.sandelman.ca)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Gb5q1-00052Z-Uo
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Oct 2006 18:39:52 -0700
From: Michael Richardson <mcr@sandelman.ottawa.on.ca>
In-Reply-To: Message from Blaisorblade <blaisorblade@yahoo.it> of "Sat,
	21 Oct 2006 02:38:16 +0200." <200610210238.16557.blaisorblade@yahoo.it>
References: <v0r6x41bnb.fsf@marajade.sandelman.ca>
	<v0vemg6jbo.fsf@marajade.sandelman.ca>
	<200610210238.16557.blaisorblade@yahoo.it> 
Date: Fri, 20 Oct 2006 21:39:24 -0400
Message-ID: <17462.1161394764@sandelman.ottawa.on.ca>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



>>>>> "Blaisorblade" == Blaisorblade  <blaisorblade@yahoo.it> writes:
    >> I built a tree on my laptop as I normally do. It runs etch, and as does my
    >> debian XenU.  With 2.6.15 UML guest on my laptop, everything is fine.
    >> 
    >> Same binary running under a XenU, goes into R state under XenU:

    Blaisorblade> I forget - XenU is an unprivileged guest, and Xen0 is
    Blaisorblade> the main one IIRC  (vaguely) - if that is an
    Blaisorblade> unprivileged guest have you tried on the root one? 
  
  Xen0/Dom0 is the "host" if you like, and XenU/DomU is the "child".

  You are asking if I can run a UML child on the Xen0? I have not tried
it, and I'd have to mess around a bit to do so, but I can try.

    >> 
    >> <BIG PAUSE ******>
    >> 
    >> Linux version 2.6.15 (mcr@marajade.sandelman.ca) (gcc version 4.1.2
    >> 20060901 (pr                      erelease) (Debian 4.1.1-13)) #2 Thu Oct
    >> 19 17:29:21 EDT 2006 Built 1 zonelists

    Blaisorblade> A strace -t (or whichever option shows the timings)
    Blaisorblade> would help finding _where_  
    Blaisorblade> is the big pause...

  I think you mean -T?
  I ran:

strace -f -o /tmp/east.trace -T /0i/sandboxes/UMLPOOL/260ocf/umlbuild/swan26/linux initrd=/0i/sandboxes/UMLPOOL/260ocf/umlbuild/initrd.uml umlroot=/0i/sandboxes/UMLPOOL/260ocf/umlbuild/east/root root=/dev/ram0 rw ssl=pty umid=east $net $UML_DEBUG_OPT $UML_east_OPT  init=/linuxrc $*

  It never actually boots far enough with this option to print anything.

  It was a big message (11MB), so, see
     http://www.sandelman.ca/tmp/xen-uml-50.txt

strace -o /tmp/east.trace -T /0i/sandboxes/UMLPOOL/260ocf/umlbuild/swan26/linux initrd=/0i/sandboxes/UMLPOOL/260ocf/umlbuild/initrd.uml umlroot=/0i/sandboxes/UMLPOOL/260ocf/umlbuild/east/root root=/dev/ram0 rw ssl=pty umid=east $net $UML_DEBUG_OPT $UML_east_OPT  init=/linuxrc $*

without the child tracing, it makes it as it would normally, but we get
nothing about what the child processes are doing, of course.  

I guess maybe that there are problems with the VT ALARMs on the XenU...
Can we build a simpler test case for the Xen folks?

- -- 
]            Bear: "Me, I'm just the shape of a bear."          |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Finger me for keys

iQEVAwUBRTl6SYCLcPvd0N1lAQJGhAgAsoaD1RAlLVYpX1EVRyI9aSj6WcBYfhO9
0L+BgYnuZHDgVdgwqJnGPKypqq8xvlAILGApEojSe7aPdymXTPkY9UxUMFpPa7PV
LS4/1cb/5OnnQ58Op9aa6bsDeuPljK4g8ILwBFUPsmvvRK1/n4D5WO7IfZnqtjzL
GpFwgSJljw9KLLWbv9Pfz33fZqsUb8DkwVVhTWPlrt8qyi0Zxkci3gZ0CoZUy7EA
KplYJgP2AuBmAPsWlLVi9hWA1qsgPKGfSZVtwdqPx81xPU2vN+1hEvvUpZ8/C84W
62A8yBggwtDFXmzG47VgyYCXKxB+Th+ezeQSdW0a2lf1l4Du/1uvPA==
=kEfD
-----END PGP SIGNATURE-----

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
