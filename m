Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CoGbZ-00078H-7u for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jan 2005 23:38:17 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CoGbQ-0001gn-73
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jan 2005 23:38:16 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] How stable is hostfs (and UML in general)?
References: <200501082106.38306.rob@landley.net>
	<200501100120.04746.rob@landley.net>
	<3986.1105370511@marajade.sandelman.ottawa.on.ca>
In-Reply-To: <3986.1105370511@marajade.sandelman.ottawa.on.ca>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501110135.55716.rob@landley.net>
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
Date: Tue, 11 Jan 2005 01:35:55 -0500
To: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Monday 10 January 2005 10:21 am, Michael Richardson wrote:

>   Does it work with
>        ./linux root=... init=/bin/sh
>
>   ??

Don't have a real partition to mount it on, unless I want to cannibalize the 
host system's swap.  I could try ubd if you think it would help.

>     Rob> couldn't figure out any way to make it start with a readable
>     Rob> hostfs by default, but "mount -o remount,rw / /" once it was up
>     Rob> seemed to do the trick, and I can put that in an init script no
>
>   You want to add the 'rw' flag to your boot line.
>   This is what "make uml" on the openswan tree creates:
>
> /mara4/openswan-2/asyncklips/UMLPOOL/east/linux root=/dev/root
> rootfstype=hostfs rootflags=/mara4/openswan-2/asyncklips/UMLPOOL/east/root
> rw umid=east $net $UML_DEBUG_OPT $UML_east_OPT $*

Neat trick.  As I mentioned earlier, I tried it and it worked.  (I was using 
rootflags=blah/blah/blah,rw thinking it was like remount.  Gave an 
interesting panic that took a lot of printfs to figure out, but the ability 
to stick printfs into the kernel is half the fun of UML...)

>     Rob> could get it to tell me what it was doing that didn't work
>     Rob> (thinking possibly some environment variable was set wrong),
>     Rob> and uclibc hung so badly I had to kill it from another window.
>
>   I suggest you might want to build a static copy of "strace" to run
> under the build environment.

Yeah, that's a to-do item of mine.  I was a bit concerned about running strace 
under a ptraced emulation environment, but guess it all has to nest and stack 
nicely or it would never work in the first place.  (Just as long as I'm not 
the one who has to keep it all straight... :)

>     >> It sounds like your builds are really what is broken, not the
>     >> root file system.
>
>     Rob> Yes.  I agree with this.  I'm not building user mode linux
>     Rob> properly.  The root filesystem works when I chroot into it
>     Rob> instead of running uclibc against it.
>
>   As I understand it, you are building a rootfs so that you can
> "natively" build for your target environment.
>   (I do not understand why this is necessary. )

A previous incarnation of my build script started life years ago as a big 
shell script automating a Linux From Scratch installation (back around LFS 
3.0 or so).  The current version is sort of based on LFS 5.0, heavily 
mutated.  (Another to-do item of mine is to rebase it on 6.0, or at least 
update all the packages and figure out how to shoehorn udev into this thing).

Chapter 5 of current variants of LFS uses the host system to create a 
toolchain you can chroot into and build the final system with.  Then in 
chapter 6, you build the final system in a chroot environment that contains 
just the toolchain you build in chapter 5.

My build script currently drops a "here" document into a directory and runs it 
when it needs the chroot environment.  This requires root access (as does 
creating device nodes, mounting /proc or loopback devices...  A rather large 
number of system administration things you kind of have to do to make a linux 
system).

The first reason to use UML is to get away from the need to run build.sh (a 
large complicated script that does many dangerous things) as root.  But in 
theory, I could use the fakeroot package for that.

The second reason to use UML is that I compile a new C library (uclibc), link 
applications against it, and then run those applications.  Even before the 
chroot, I'm running the new applications I compile because I put them at the 
start of the path.  (This is intentional, the new compiler naturally links 
against the new c library, and getting the old compiler to link against the 
correct libraries (not just the C library itself but other libraries that 
link to the C library) is chronically difficult.  If you're not careful, you 
suck in libm or libgcc and bang, they link in glibc.  Even statically linking 
won't always help here because glibc dlopens libnss at runtime, at which 
point things just get ugly...)

The problem is that I want to compile the new C library against new kernel 
headers.  If I'm building a 2.6.10 kernel for the final system, I want the 
libc to use maszur's cleaned up 2.6.10 kernel headers.  But the available 
features of the kernel (not just the syscalls the C library can make but all 
sorts of details like 16 bit or 32 bit uids) are defined in the kernel 
headers.  Linux is backwards compatible in that old application binaries can 
run on new systems, but it does NOT go the other way.  And thus applications 
that link against the new libc, with new kernel headers, segfault if you run 
them on a system that uses an older kernel than the headers the libc was 
built against.  (Because they try to use new kernel features that don't exist 
in that kernel.)

>     >> Yes, it does need swap if you intend to run gcc.
>
>     Rob> A) Not to compile hello world it doesn't.  I'm fairly certain
>     Rob> that can still be done in 16 megs, even with a modern gcc.  B)
>
>   well, I run into this problem regularly whenever I do anything
> complicated. I don't build with swap by default, and I run out very
> quickly.

*shrug*.  How much memory I need to build correctly is an interesting thing to 
find out later, but right now it won't compile hello world and 32 megs should 
be plenty for that.  (I can try mem=64M if you think that'll help.)

>     Rob> Interesting.  Somebody said earlier that it's using /tmp
>     Rob> instead of /dev/shm in hopes of getting shared memory.  On
>     Rob> knoppix, /tmp is a ramdisk.  I wonder if that's confusing
>     Rob> it...?  (dmesg doesn't say the out of memory killer's getting
>     Rob> triggered...)
>
>   I have /tmp be a ramdisk all the time.

This laptop only has 128 megs and I've got a desktop up with a web browser.  
It'll get a little unhappy.  But if I left the swap file do its job and don't 
try to do anything while it runs, it shouldn't be too bad...

>     Rob> Interesting.  Running it with "TMPDIR=." at the start of the
>     Rob> command line, I got the same old panics the first three times
>     Rob> (and it didn't try to allocate any more memory than before,
>     Rob> presumably I need to tell it mem= for that), but on the fourth
>     Rob> attempt it got farther than it ever has before, and instead of
>     Rob> panicing it just hung.  (Still didn't get my shell prompt, but
>     Rob> oh well.)
>
>   Hmm. random huh.

Reverting to 2.6.9-bb4 at least made the randomness go away.  This is a good 
thing.  (I could probably debug it from here myself given a few weeks...)

>     Rob> The tee output of four consecutive runs is attached.  All I did
>     Rob> each time was ctrl-c out of the hang, cursor up, change the
>
>   You could hit ^C from a hang?

/dev/console attaches to fd0 and fd1.  These are not ttys/ptys but file 
descriptors, hence they controlling tty sends the kill signal to the running 
process still attached to that terminal, which is the vmlinux instance I 
started.

Once UML starts init, it seems to register a signal handler or something...

As I said, good for scripting, not so good for debugging.  Some of the hangs 
I'm seeing are almost certainly a stuck process I can't ctrl-C out of and 
have to kill from another window...

>     >> I suggest that you might want to try the UML image system in the
>     >> Openswan builds. It generates everything you need. It has been
>     >> used with 2.6.9+ guests, on 2.4 and 2.6 hosts.
>
>     Rob> Is this a binary, or a build script?  (Do you have a URL?)
>
>   Build script.
>   www.openswan.org/code/
>
>   Get yourself 500Mb of disk space,
>       cp testing/utils/umlsetup-sample.sh umlsetup.sh
>       vi umlsetup.sh
>       make uml
>
>   You need to set "KERN=26" if using a 2.6 kernel.

Sounds cool.  On the to-do list.  Thanks.

Rob


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
