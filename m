Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CrNsd-0001C9-CW for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Jan 2005 14:00:47 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CrNsb-00040A-Fm for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Jan 2005 14:00:47 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Progress with -bb4.
References: <200501151117.12000.rob@landley.net>
In-Reply-To: <200501151117.12000.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501192312.52036.blaisorblade@yahoo.it>
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
Date: Wed, 19 Jan 2005 23:12:51 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>

On Saturday 15 January 2005 17:17, Rob Landley wrote:
> Running ptrace under uml found the problem with gcc: UML's default
> environment includes "." at the end of $PATH, and if you have that gcc
> doesn't search the path for ld.
>
> So I took "." out of the path, and it started working.  Yay!  (Cool stuff,
> guys.)
>
> Along the way, I found some interesting quirks:
>
> 1) I mentioned the gratuitous use of perl earlier.  This is only for
> --show-config, which could A) be replaced by a sed script,
I've just answered with a patch.
> B) should 
> presumably be wrapped in CONFIG_IKCONFIG anyway.
No, no more possible - I planned doing that but then the plain-text version 
went away... in the kernel normally only the gzip'ed version is saved.
> I ripped it out of the makefile and it built fine without it.  I'll see
> about patching the makefile with the sed thing and/or the CONFIG option
> this weekend, although I'm not good at makefiles...

> 2) Building under uclibc dies with a conflicting definition error, due to
> arch/um/include/user.h containing "extern int strlcpy(char *, const char *,
> int);", when uclibc's string.h contains:

> extern size_t strlcpy(char *__restrict dst, const char *__restrict src,
>                       size_t n) __THROW;

> I yanked the strlcpy line from arch/um/include/user.h and everything built
> fine without it (didn't even see any new warnings), both under both uclibc
> (more or less 0.9.27, a cvs snapshot a couple weeks before release) and
> glibc (knoppix 3.6, comes with glibc 2.3.2), possibly because it's still in
> include/linux/string.h...
More likely because it's not used in UML "userspace" code - it cannot include 
include/linux/string.h (it could include the host's version, but I don't 
think it will do this for <linux/string.h> - it's unlikely).
> The resulting uclibc binaries seemed to work fine in both environments.  I
> could even run the uclibc one from within the uclibc chroot environment via
> "./vmlinux rootfs=hostfs rootflags=/ rw init=/bin/sh" and it behaved pretty
> well.  (Overmount /proc and /dev/pts and life is good...)

> 3) Running my big build script, it hangs between ./configure and make of
> binutils.  No idea why yet.  Just sits there spinning, with vmlinux eating
> 100% of the CPU, and if you leave it for half an hour it still won't
> advance, and this is something that should only take a second or so...
Well, try doing things at hand, and using sh -x (or the new bash-debugging of 
3.0, I've not yet learned it but it could be useful maybe).
> 4) I can get all sorts of things to segfault under uclibc with ptrace -f. 
You mean strace, right?
> For example, just try ptrace -f on a shellscript and watch the segfaults
> fly.  Is it just me?
No, it's me too, but I never got to understanding what's going on there.
> #4 makes #3 a bit harder to debug.
>
> I'll try upgrading to -bs5 and see if that makes anything better.
Well, I don't think -bs5 it's worth the effort - the problems fixed from -bb4 
likely don't affect you in this case (they cause early breakage in the boot).
> Query: is a 2.6.10-bb likely in future, or should I just try -bk or -mm or
> some such?
Watch the site, there will be upgrades on this... raw 2.6.10 isn't good for 
UML... however the first 2.6.10-bb probably won't be better / stabler than 
2.6.9-bb, at least until the issue you are experiencing won't be debugged...
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
