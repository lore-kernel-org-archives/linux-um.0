Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Co1NN-0006od-9e for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jan 2005 07:22:37 -0800
Received: from pike.sandelman.ca ([205.150.200.164])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1Co1NI-0007zr-6C
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jan 2005 07:22:36 -0800
Subject: Re: [uml-devel] How stable is hostfs (and UML in general)? 
In-Reply-To: Message from Rob Landley <rob@landley.net> of "Mon,
	10 Jan 2005 01:20:04 EST." <200501100120.04746.rob@landley.net> 
References: <200501082106.38306.rob@landley.net>
	<31487.1105315534@marajade.sandelman.ottawa.on.ca>
	<200501100120.04746.rob@landley.net> 
Message-ID: <3986.1105370511@marajade.sandelman.ottawa.on.ca>
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
Date: Mon, 10 Jan 2005 10:21:51 -0500
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----


>>>>> "Rob" == Rob Landley <rob@landley.net> writes:
    Rob> My uclibc system works just fine as long as I chroot into it or
    Rob> boot into it with a normal (2.6) linux kernel.  It can even
    Rob> recompile itself, entirely from source, under itself.

    Rob> Using user mode linux with it is what causes problems.  If I
    Rob> run user mode linux with that exact same directory a hostfs
    Rob> root partition, it either hangs or malfunctions in numerous
    Rob> different ways, some of which seem to be race conditions and
    Rob> others are reproducible bad behavior which I have never once
    Rob> seen those exact same binaries exhibit when I chroot from the
    Rob> host kernel.

  Does it work with 
       ./linux root=... init=/bin/sh

  ??

    Rob> couldn't figure out any way to make it start with a readable
    Rob> hostfs by default, but "mount -o remount,rw / /" once it was up
    Rob> seemed to do the trick, and I can put that in an init script no

  You want to add the 'rw' flag to your boot line.
  This is what "make uml" on the openswan tree creates:

/mara4/openswan-2/asyncklips/UMLPOOL/east/linux root=/dev/root rootfstype=hostfs rootflags=/mara4/openswan-2/asyncklips/UMLPOOL/east/root rw umid=east $net $UML_DEBUG_OPT $UML_east_OPT $*
  
    Rob> But when trying to compile "hello world", gcc died saying it
    Rob> couldn't find ld.  This exact filesystem worked fine chrooting
    Rob> into it on the host kernel, a knoppix system running 2.6.7.

    >> Well, was ld actually there?

    Rob> Did you read second sentence in the bit you just quoted?  How,
    Rob> exactly, could I chroot into there and compile stuff if ld
    Rob> isn't there?

  Yes, but you are missing my point.
  It *COULD* be that due to a bug in hostfs that ld wasn't where it was
supposed to be. 
 
    Rob> I did, of course, check and make sure that ls and cat and such
    Rob> found ld in the UML environment, which they did.  (The error
    Rob> message is actually collect2 can't find ld, although apparently
    Rob> gcc can find collect2.)  I tried running gcc -v to see if I

  Yes, okay.

    Rob> could get it to tell me what it was doing that didn't work
    Rob> (thinking possibly some environment variable was set wrong),
    Rob> and uclibc hung so badly I had to kill it from another window.

  I suggest you might want to build a static copy of "strace" to run
under the build environment. 

    >> It sounds like your builds are really what is broken, not the
    >> root file system.

    Rob> Yes.  I agree with this.  I'm not building user mode linux
    Rob> properly.  The root filesystem works when I chroot into it
    Rob> instead of running uclibc against it.

  As I understand it, you are building a rootfs so that you can
"natively" build for your target environment.
  (I do not understand why this is necessary. )
  
    >> Yes, it does need swap if you intend to run gcc.

    Rob> A) Not to compile hello world it doesn't.  I'm fairly certain
    Rob> that can still be done in 16 megs, even with a modern gcc.  B)

  well, I run into this problem regularly whenever I do anything
complicated. I don't build with swap by default, and I run out very
quickly. 

    Rob> Interesting.  Somebody said earlier that it's using /tmp
    Rob> instead of /dev/shm in hopes of getting shared memory.  On
    Rob> knoppix, /tmp is a ramdisk.  I wonder if that's confusing
    Rob> it...?  (dmesg doesn't say the out of memory killer's getting
    Rob> triggered...)

  I have /tmp be a ramdisk all the time.

    Rob> Interesting.  Running it with "TMPDIR=." at the start of the
    Rob> command line, I got the same old panics the first three times
    Rob> (and it didn't try to allocate any more memory than before,
    Rob> presumably I need to tell it mem= for that), but on the fourth
    Rob> attempt it got farther than it ever has before, and instead of
    Rob> panicing it just hung.  (Still didn't get my shell prompt, but
    Rob> oh well.)

  Hmm. random huh.

    Rob> The tee output of four consecutive runs is attached.  All I did
    Rob> each time was ctrl-c out of the hang, cursor up, change the

  You could hit ^C from a hang?

    >> I suggest that you might want to try the UML image system in the
    >> Openswan builds. It generates everything you need. It has been
    >> used with 2.6.9+ guests, on 2.4 and 2.6 hosts.

    Rob> Is this a binary, or a build script?  (Do you have a URL?)

  Build script.
  www.openswan.org/code/

  Get yourself 500Mb of disk space, 
      cp testing/utils/umlsetup-sample.sh umlsetup.sh
      vi umlsetup.sh
      make uml

  You need to set "KERN=26" if using a 2.6 kernel.

- -- 
]       ON HUMILITY: to err is human. To moo, bovine.           |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Finger me for keys

iQCVAwUBQeKdjoqHRg3pndX9AQHKZwP/WgLnAry9eH6zWDvvnJ12obewUjNGe5X/
PZE+rrnHMhc67C2npNVF2DkiTv9KwCHAyx1aQPgaNmr/PjyCEES2YrbCxPPP42ed
UG9lFmxAjyexlhuDEHbsA0UoOY4d1ILrOAEJOAKokWTwUhGLCq2yhlTUreEwHqvz
GI51yz4ErXk=
=ZzcU
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
