Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CprZS-0007br-4w for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 15 Jan 2005 09:18:42 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CprZR-0005NY-8N
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 15 Jan 2005 09:18:42 -0800
Received: from knoppix (grelber.thyrsus.com [192.168.1.31])
	by grelber.thyrsus.com (8.12.11/8.12.11) with ESMTP id j0FIRAia005401
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 15 Jan 2005 13:27:11 -0500
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200501151117.12000.rob@landley.net>
Subject: [uml-devel] Progress with -bb4.
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
Date: Sat, 15 Jan 2005 11:17:11 -0500
To: user-mode-linux-devel@lists.sourceforge.net

Running ptrace under uml found the problem with gcc: UML's default environment 
includes "." at the end of $PATH, and if you have that gcc doesn't search the 
path for ld.

So I took "." out of the path, and it started working.  Yay!  (Cool stuff, 
guys.)

Along the way, I found some interesting quirks:

1) I mentioned the gratuitous use of perl earlier.  This is only for 
--show-config, which could A) be replaced by a sed script, B) should 
presumably be wrapped in CONFIG_IKCONFIG anyway.

I ripped it out of the makefile and it built fine without it.  I'll see about 
patching the makefile with the sed thing and/or the CONFIG option this 
weekend, although I'm not good at makefiles...

2) Building under uclibc dies with a conflicting definition error, due to
arch/um/include/user.h containing "extern int strlcpy(char *, const char *, 
int);", when uclibc's string.h contains:

extern size_t strlcpy(char *__restrict dst, const char *__restrict src,
                      size_t n) __THROW;

I yanked the strlcpy line from arch/um/include/user.h and everything built 
fine without it (didn't even see any new warnings), both under both uclibc 
(more or less 0.9.27, a cvs snapshot a couple weeks before release) and glibc 
(knoppix 3.6, comes with glibc 2.3.2), possibly because it's still in 
include/linux/string.h...

The resulting uclibc binaries seemed to work fine in both environments.  I 
could even run the uclibc one from within the uclibc chroot environment via 
"./vmlinux rootfs=hostfs rootflags=/ rw init=/bin/sh" and it behaved pretty 
well.  (Overmount /proc and /dev/pts and life is good...)

3) Running my big build script, it hangs between ./configure and make of 
binutils.  No idea why yet.  Just sits there spinning, with vmlinux eating 
100% of the CPU, and if you leave it for half an hour it still won't advance, 
and this is something that should only take a second or so...

4) I can get all sorts of things to segfault under uclibc with ptrace -f.  For 
example, just try ptrace -f on a shellscript and watch the segfaults fly.  Is 
it just me?

#4 makes #3 a bit harder to debug.

I'll try upgrading to -bs5 and see if that makes anything better.

Query: is a 2.6.10-bb likely in future, or should I just try -bk or -mm or 
some such?

Rob


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
