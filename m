Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CnnPU-0006u8-Gi for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Jan 2005 16:27:52 -0800
Received: from pike.sandelman.ca ([205.150.200.164])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CnnPS-00075i-Dk
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Jan 2005 16:27:52 -0800
Subject: Re: [uml-devel] How stable is hostfs (and UML in general)? 
In-Reply-To: Message from Rob Landley <rob@landley.net> of "Sat,
	08 Jan 2005 21:06:38 EST." <200501082106.38306.rob@landley.net> 
References: <200501082106.38306.rob@landley.net> 
Message-ID: <31487.1105315534@marajade.sandelman.ottawa.on.ca>
From: Michael Richardson <mcr@sandelman.ottawa.on.ca>
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
Date: Sun, 09 Jan 2005 19:05:34 -0500
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----


>>>>> "Rob" == Rob Landley <rob@landley.net> writes:
    Rob> I want to use UML because I'm building a little uclibc-based
    Rob> distro that has a problem when the system it's building on has
    Rob> a kernel older than the one it's building.  I'm testing the

  I think you have a serious problem to begin with.

  Probably, you aren't building with the cross-compile headers, but
rather with the host's headers, and maybe you are using the kernel
headers rather than the uClibc headers.
  When building for a different libc, you'd be best to pretend that you
are in fact building for a different CPU. I.e. build a whole
cross-compile environment.

    Rob> Under the UML built from stock 2.6.9 sources, after some
    Rob> tweaking I got it to sort of boot and give me a shell prompt
    Rob> about 1/3 of the time (the other 2/3 of the time it paniced
    Rob> during boot due to various race conditions, but trying it
    Rob> several times in a row usually got me to the shell prompt).  I
    Rob> couldn't figure out any way to make it start with a readable
    Rob> hostfs by default, but "mount -o remount,rw / /" once it was up
    Rob> seemed to do the trick, and I can put that in an init script no
    Rob> problem.  (And yes it worked: I could create files and have
    Rob> them show up in the host system.)
  
  I use hostfs root all the time.
  I have no such problems.

    Rob> But when trying to compile "hello world", gcc died saying it
    Rob> couldn't find ld.  This exact filesystem worked fine chrooting
    Rob> into it on the host kernel, a knoppix system running 2.6.7.
  
  Well, was ld actually there? 

    Rob> mconsole (version 2) initialized on
    Rob> /home/knoppix/.uml/WGIHE3/mconsole audit: initializing netlink
    Rob> socket (disabled) audit(300.210:0): initialized Initializing
    Rob> Cryptographic API Kernel panic - not syncing: fix_range fixing
    Rob> wrong address space, current = 0xa0cb90a0

  It sounds like your builds are really what is broken, not the root
file system.

    Rob> cables and virtual hubs and it doesn't apply to me.  I'm trying
    Rob> for a VERY simple setup: my UML doesn't need more networking
    Rob> than loopback, doesn't need swap, doesn't need module

  Yes, it does need swap if you intend to run gcc.

  I suggest that you might want to try the UML image system in the
Openswan builds. It generates everything you need. It has been used with
2.6.9+ guests, on 2.4 and 2.6 hosts.

- -- 
]       ON HUMILITY: to err is human. To moo, bovine.           |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Finger me for keys

iQCVAwUBQeHGxYqHRg3pndX9AQHxbwQAkZEnFOz0z4xxSB4XLVl6XXKJAk/vw4/w
48HCyCv/guKdwmZcwCYd3MFVyMood8aNSjlzfpETSjYvGTKqGR/cqJEn+4Urtara
NX2N7kcN3DYPs3yW1g5QZ/kWoTQc/+sTV3BOC4mw2vGRga2W0VTRblCShnuvV/N2
v/szXnInqK4=
=O7w2
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
