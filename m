Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DQwDX-0000i7-SS for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Apr 2005 16:45:19 -0700
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252] ident=93)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DQwDU-0004Ox-AX
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Apr 2005 16:45:19 -0700
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Message-ID: <20050427234515.GY13052@parcelfarce.linux.theplanet.co.uk>
References: <1114570958.5983.50.camel@mythical>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114570958.5983.50.camel@mythical>
Subject: [uml-devel] Re: [UML] Compile error when building with seperate
	source and object directories
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
Date: Thu, 28 Apr 2005 00:45:15 +0100
To: jdike@karaya.com
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, sam@ravnborg.org, Ryan Anderson <ryan@michonline.com>

On Tue, Apr 26, 2005 at 11:02:38PM -0400, Ryan Anderson wrote:
> I've been seeing a build error when trying to build User Mode Linux on
> an x86-32 host (Athlon, fwiw).  The kernel I'm building is a 1-day old
> pull from git.  This error is not new, though.  I thought it was merely
> an artifact of a patch stuck in a queue at first so I didn't mention it
> right away.

That's because that stuff is not merged yet.  Speaking of which, where does
the current UML tree live and who should that series be Cc'ed to?

I've got a decent split-up and IMO that should be mergable.  Patches are
on ftp.linux.org.uk/pub/people/viro/UM*; summary in the end of mail.
That's a sanitized and split version of old UML-kbuild patch.

There is a bunch of minor fixes not covered by that patchset (ipc.h assuming
that there is include/asm-<target>/ipc.h when it should just include the
asm-generic/ipc.h and be done with that; ptrace.c broken on amd64 in the
part dealing with debug registers; missing include of skas_ptrace.h in
amd64 variant of syscalls.h), but that's a separate story.  Kbuild-related
stuff is all here...

Please, review.

(0)
	Make vmlinux.lds.S include appopriate script instead of playing
games with symlinks.

(1)
	Use explicit os-... in make dependencies instead of playing with
symlinks (symlink in question is still created - it's needed for other
things; however, there's no reason to complicate ordering here).

(2)
	Beginning of cross-build fixes.  Instead of expecting that
mk_user_constants (compiled and executed on the build box) will see
the sizeof, etc. for target box, we do what every architecture already
does for asm-offsets.  Namely, have user-offsets.c compiled *for* *target*
into user-offsets.s and sed it into the header with relevant constants.
We don't need to reinvent any wheels - all tools are already there.

	This patch deals with mk_user_constants.  It doesn't assume any
relationship between target and build environment anymore - we pick all
defines we need from user-offsets.h.  Later patches will deal with the
rest of mk_... helpers in the same way.

(3)
	mk_ptregs converted.  Nothing new here, it's the same situation
as with mk_user_constants.

(4)
	Ditto for mk_sc

(5)
	The next group of helpers is a bit trickier - they want the constants
similar to those in user-offsets.h, but we need target sc.h for it.  So we
can't put that into user-offsets (sc.h depends on it) and need the second
generated header for that stuff (kernel-offsets.h.  BFD...

(6)
	mk_thread converted

(7)
	helpers in arch/um/util (mk_task and mk_constants) converted.
That's it - none of the helpers depends on build and target being the
same architecture anymore.

(8)
	make distclean et.al. are missing arch/um/sys-x86_64/utils; fixed
the same way we have it done for sys-i386 counterpart.

(9)
	The last obstacle for cross-builds - bogus -L/usr/lib passed to
the final link phase.  It's not needed on native build (gcc will do that
just fine) and it's wrong on cross-build (the stuff we want is *not*
one in /usr/lib and (cross-)gcc knows where to find what we need anyway).
We are not calling ld(1) here...
	Bogus argument removed.  At that point we can build working
uml-i386 on e.g. alpha.

(10)
	O=... builds support.  Very easy, actually.


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
