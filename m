Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CoTf0-0007AL-56 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Jan 2005 13:34:42 -0800
Received: from pike.sandelman.ca ([205.150.200.164])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CoTey-0006cc-08
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Jan 2005 13:34:41 -0800
Subject: Re: [uml-devel] How stable is hostfs (and UML in general)? 
In-Reply-To: Message from Rob Landley <rob@landley.net> of "Tue,
	11 Jan 2005 01:35:55 EST." <200501110135.55716.rob@landley.net> 
References: <200501082106.38306.rob@landley.net>
	<200501100120.04746.rob@landley.net>
	<3986.1105370511@marajade.sandelman.ottawa.on.ca>
	<200501110135.55716.rob@landley.net> 
Message-ID: <11049.1105479264@marajade.sandelman.ottawa.on.ca>
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
Date: Tue, 11 Jan 2005 16:34:24 -0500
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----


>>>>> "Rob" == Rob Landley <rob@landley.net> writes:
    Rob> Chapter 5 of current variants of LFS uses the host system to
    Rob> create a toolchain you can chroot into and build the final
    Rob> system with.  Then in chapter 6, you build the final system in

  I think the use of chroot is a cop-out.

    Rob> This requires root access (as does creating device nodes,
    Rob> mounting /proc or loopback devices...  A rather large number of

  I use "fakeroot" to do all of that for embedded work that I do...

all:
	mkdir -p ${ROOTDIR}
	fakeroot ${MAKE} EDTUDIR=${EDTUDIR} realall

realall:	
	echo Updating Symlinks
	@mkdir -p ${ROOTDIR}
	@mkdir -p ${ROOTDIR}/bin ${ROOTDIR}/sbin ${ROOTDIR}/etc ${ROOTDIR}/targa ${ROOTDIR}/dev
	...
	echo Updating Binaries
	(cd ${EDTUDIR} && ${MAKE} PREFIX=${PREFIX} ROOTDIR=${ROOTDIR} EDTUDIR=. install )
	${MKFSJFFS2} --squash --eraseblock=128 --root=${ROOTDIR} --output=jffs2/jffs2.image --cvs-exclude -x rtime --big-endian 


  Since the "mkfsjffs2" runs under the fakeroot as well, it gets all of
the permissions and dev nodes, etc.
  Works like a charm, once one remembers to install fakeroot.
  (This customer has all of their stuff on SuSE 9.1. I use Debian)

    Rob> The second reason to use UML is that I compile a new C library
    Rob> (uclibc), link applications against it, and then run those
    Rob> applications.  Even before the chroot, I'm running the new

  yes, it is good for testing.

  What I'm trying to get at, is that I strongly disagree with any
"embedded" system that requires that you build "on" it. 
  If you are trying to build GNOME 2.3 apps for RH 7.2... by ALL MEANS,
UML is the tool for you....

    Rob> difficult.  If you're not careful, you suck in libm or libgcc
    Rob> and bang, they link in glibc.  Even statically linking won't

  Yup. That's why I wouldn't want to run the build environment on the
"target"

    >> well, I run into this problem regularly whenever I do anything
    >> complicated. I don't build with swap by default, and I run out
    >> very quickly.

    Rob> *shrug*.  How much memory I need to build correctly is an
    Rob> interesting thing to find out later, but right now it won't
    Rob> compile hello world and 32 megs should be plenty for that.  (I
    Rob> can try mem=64M if you think that'll help.)

  dd if=/dev/zero bs=1024k count=64 of=MYSWAP
  ./linux ubd1=./MYSWAP

    Rob> The tee output of four consecutive runs is attached.  All I did
    Rob> each time was ctrl-c out of the hang, cursor up, change the
    >> You could hit ^C from a hang?

    Rob> /dev/console attaches to fd0 and fd1.  These are not ttys/ptys
    Rob> but file descriptors, hence they controlling tty sends the kill

  Well, usually, once the system is properly initialized, ^C does
nothing. If you get a kernel panic/hang, I usually have to use kill from
another window.

- -- 
]       ON HUMILITY: to err is human. To moo, bovine.           |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Finger me for keys

iQCVAwUBQeRGXoqHRg3pndX9AQGUDQQA0dPnJzBz/5ifSpGjmaTcfNNNtYlugzUE
7m2hb0DXUb2kKgrrLrawXxckSh2NFLclgA2h29k8SQHFD1JWTl/AmPT52tmcIVhD
hW3YBqh+hm0wuuckBZ4B2vsoobLtfvMxTRROLs5OXaZvMjxg7fwLfdmDEM1g4S4E
fbcuI/S8FoM=
=5OC4
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
