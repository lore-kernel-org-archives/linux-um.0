Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cntrj-00019p-Ql for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Jan 2005 23:21:27 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1Cntri-0003HA-Co
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Jan 2005 23:21:27 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] How stable is hostfs (and UML in general)?
References: <200501082106.38306.rob@landley.net>
	<31487.1105315534@marajade.sandelman.ottawa.on.ca>
In-Reply-To: <31487.1105315534@marajade.sandelman.ottawa.on.ca>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_U6h4BIJ4WAB5BxQ"
Message-Id: <200501100120.04746.rob@landley.net>
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
Date: Mon, 10 Jan 2005 01:20:04 -0500
To: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Cc: user-mode-linux-devel@lists.sourceforge.net


--Boundary-00=_U6h4BIJ4WAB5BxQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 09 January 2005 07:05 pm, Michael Richardson wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
>
> >>>>> "Rob" == Rob Landley <rob@landley.net> writes:
>
>     Rob> I want to use UML because I'm building a little uclibc-based
>     Rob> distro that has a problem when the system it's building on has
>     Rob> a kernel older than the one it's building.  I'm testing the
>
>   I think you have a serious problem to begin with.
>
>   Probably, you aren't building with the cross-compile headers, but
> rather with the host's headers, and maybe you are using the kernel
> headers rather than the uClibc headers.

No, I'm using maritz maszur's kernel headers.  Before I build uclibc I move 
the linux, sound, and asm (actually asm-$ARCH) directories from that into the 
uclibc source's include directory and then truncating 
extra/scripts/fix_includes.sh to zero bytes.  As I said earlier, I have to 
use maszur's old 2.6.6 headers for this, even when the kernel I'm building is 
2.6.9 or 2.6.10, because if I use newer ones the binaries linked with the 
resulting uclibc segfault when run under the 2.6.7 kernel in my knoppix host 
system.

In case the web page I linked earlier was too much to wade through, here are 
the direct links to my build scripts from the end of the page.  The first 
script does the equivalent of a heavily modified Linux From Scratch chapter 
5, and the second one no longer has that much to do with chapter 6 but you 
can still sort of see it if you squint.

http://www.landley.net/code/firmware/mktools.sh
http://www.landley.net/code/firmware/build.sh

>   When building for a different libc, you'd be best to pretend that you
> are in fact building for a different CPU. I.e. build a whole
> cross-compile environment.

Maybe I wasn't clear.

My uclibc system works just fine as long as I chroot into it or boot into it 
with a normal (2.6) linux kernel.  It can even recompile itself, entirely 
from source, under itself.

Using user mode linux with it is what causes problems.  If I run user mode 
linux with that exact same directory a hostfs root partition, it either hangs 
or malfunctions in numerous different ways, some of which seem to be race 
conditions and others are reproducible bad behavior which I have never once 
seen those exact same binaries exhibit when I chroot from the host kernel.

Clear?  This directory works just fine with chroot.  It does not work with 
UML.

>     Rob> Under the UML built from stock 2.6.9 sources, after some
>     Rob> tweaking I got it to sort of boot and give me a shell prompt
>     Rob> about 1/3 of the time (the other 2/3 of the time it paniced
>     Rob> during boot due to various race conditions, but trying it
>     Rob> several times in a row usually got me to the shell prompt).  I
>     Rob> couldn't figure out any way to make it start with a readable
>     Rob> hostfs by default, but "mount -o remount,rw / /" once it was up
>     Rob> seemed to do the trick, and I can put that in an init script no
>     Rob> problem.  (And yes it worked: I could create files and have
>     Rob> them show up in the host system.)
>
>   I use hostfs root all the time.
>   I have no such problems.

Cool.  I'd love to figure out what you're doing that I'm not, or vice versa.

>     Rob> But when trying to compile "hello world", gcc died saying it
>     Rob> couldn't find ld.  This exact filesystem worked fine chrooting
>     Rob> into it on the host kernel, a knoppix system running 2.6.7.
>
>   Well, was ld actually there?

Did you read second sentence in the bit you just quoted?  How, exactly, could 
I chroot into there and compile stuff if ld isn't there?

I did, of course, check and make sure that ls and cat and such found ld in the 
UML environment, which they did.  (The error message is actually collect2 
can't find ld, although apparently gcc can find collect2.)  I tried running 
gcc -v to see if I could get it to tell me what it was doing that didn't work 
(thinking possibly some environment variable was set wrong), and uclibc hung 
so badly I had to kill it from another window.

"ld" is in both /bin/ld and /usr/bin/ld, since /bin is a symlink to /usr/bin.  
(And /sbin is a symlink to /usr/sbin, and /lib is a symlink to /usr/lib, and 
yes I needed to rip the gratuitous extra hardwired path out of collect2.c to 
make a unified lib directory work.  That was months ago.  And it works fine 
under the host kernel.)

>     Rob> mconsole (version 2) initialized on
>     Rob> /home/knoppix/.uml/WGIHE3/mconsole audit: initializing netlink
>     Rob> socket (disabled) audit(300.210:0): initialized Initializing
>     Rob> Cryptographic API Kernel panic - not syncing: fix_range fixing
>     Rob> wrong address space, current = 0xa0cb90a0
>
>   It sounds like your builds are really what is broken, not the root
> file system.

Yes.  I agree with this.  I'm not building user mode linux properly.  The root 
filesystem works when I chroot into it instead of running uclibc against it.

I would very much like to be able to build uclibc such that it works properly.  
I like the concept of this project, and want to use it.  I just don't seem to 
know how to get it to work for me.  There seems to be more to it than untar, 
make ARCH=um menuconfig, make ARCH=um, use resulting binary.  Doing so sort 
of worked for me under 2.6.9: I got a shell prompt, at least the 1/3 of the 
time that the UML boot process survived the various race conditions, but when 
it did the applications (reliably and reproducibly) malfunctioned.

Doing the same build under 2.6.10, I have yet to see a shell prompt on my 
laptop.  I was hoping someone would see something obviously wrong from 
my .config...
 
>     Rob> cables and virtual hubs and it doesn't apply to me.  I'm trying
>     Rob> for a VERY simple setup: my UML doesn't need more networking
>     Rob> than loopback, doesn't need swap, doesn't need module
>
>   Yes, it does need swap if you intend to run gcc.

A) Not to compile hello world it doesn't.  I'm fairly certain that can still 
be done in 16 megs, even with a modern gcc.
B) On my work machine, without swap, I compiled a whole c++ project.
C) I've compiled this project on a machine with 32 megs of ram and no swap, 
and my laptop actually has 128 megs so if UML isn't giving itself at least 32 
it's making a bad decision...

And it isn't: Memory: 27808k available according to the bootup message.  
Hmmm...

Interesting.  Somebody said earlier that it's using /tmp instead of /dev/shm 
in hopes of getting shared memory.  On knoppix, /tmp is a ramdisk.  I wonder 
if that's confusing it...?  (dmesg doesn't say the out of memory killer's 
getting triggered...)

Interesting.  Running it with "TMPDIR=." at the start of the command line, I 
got the same old panics the first three times (and it didn't try to allocate 
any more memory than before, presumably I need to tell it mem= for that), but 
on the fourth attempt it got farther than it ever has before, and instead of 
panicing it just hung.  (Still didn't get my shell prompt, but oh well.)

The tee output of four consecutive runs is attached.  All I did each time was 
ctrl-c out of the hang, cursor up, change the number on out.txt, and hit 
return again.  This is not the full range of failures to boot I've seen from 
this thing, by the way...

The command line was:
TMPDIR=. ../uml.sh 2>&1 | tee out.txt

And uml.sh is (wordwrapped here, but not in the original):
./vmlinux rootfstype=hostfs rootflags=/home/knoppix/newbuild/build 
init=/bin/bash

>   I suggest that you might want to try the UML image system in the
> Openswan builds. It generates everything you need. It has been used with
> 2.6.9+ guests, on 2.4 and 2.6 hosts.

Is this a binary, or a build script?  (Do you have a URL?)

I'd really like to compile this thing from source since I already have the 
linux source tarball in my build processs anyway, to make the kernel for the 
final system.  I'll happily applying patches for this different use if they 
fix the problems I'm having.  Right now, it dosn't seem like anybody else has 
been seeing these problems, though, so I'd like to figure out what I'm doing 
wrong...

Rob

--Boundary-00=_U6h4BIJ4WAB5BxQ
Content-Type: text/plain;
  charset="iso-8859-1";
  name="out.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="out.txt"

Checking for the skas3 patch in the host...not found
Checking for /proc/mm...not found
Checking PROT_EXEC mmap in /tmp...OK
Linux version 2.6.10 (knoppix@Knoppix) (gcc version 3.3.4 (Debian 1:3.3.4-9)) #1 Sat Jan 8 19:07:07 EST 2005
Built 1 zonelists
Kernel command line: rootfstype=hostfs rootflags=/home/knoppix/newbuild/build init=/bin/bash root=98:0
PID hash table entries: 256 (order: 8, 4096 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 27808k available
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...missing
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with errno 2)
NET: Registered protocol family 16
Sangoma WANPIPE Router v1.1 (c) 1995-2000 Sangoma Technologies Inc.
mconsole (version 2) initialized on /home/knoppix/.uml/QwNyrK/mconsole
audit: initializing netlink socket (disabled)
audit(300.210:0): initialized
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
elevator: using anticipatory as default io scheduler
nbd: registered device at major 43
ipddp.c:v0.01 8/28/97 Bradford W. Johnson <johns393@maroon.tc.umn.edu>
ipddp0: Appletalk-IP Encap. mode by Bradford W. Johnson <johns393@maroon.tc.umn.edu>
pktgen.c: v1.4: Packet Generator for packet performance testing.
pktgen: Error: your machine does not have working cycle counter.
NET: Registered protocol family 26
u32 classifier
    OLD policer on 
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
ip_conntrack version 2.1 (217 buckets, 1736 max) - 300 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
IPVS: Registered protocols (TCP, UDP, AH, ESP)
IPVS: Connection hash table configured (size=4096, memory=32Kbytes)
IPVS: ipvs loaded.
IPVS: [rr] scheduler registered.
IPVS: [wrr] scheduler registered.
IPVS: [lc] scheduler registered.
IPVS: [wlc] scheduler registered.
IPVS: [lblc] scheduler registered.
IPVS: [lblcr] scheduler registered.
IPVS: [dh] scheduler registered.
IPVS: [sh] scheduler registered.
IPVS: [sed] scheduler registered.
IPVS: [nq] scheduler registered.
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2002 Netfilter core team
NET: Registered protocol family 17
NET: Registered protocol family 15
Bridge firewalling registered
Ebtables v2.0 registered
NET: Registered protocol family 4
NET: Registered protocol family 5
NET: Registered protocol family 9
X.25 for Linux. Version 0.2 for Linux 2.1.15
NET: Registered protocol family 8
NET: Registered protocol family 20
lec.c: Jan  8 2005 18:41:28 initialized
mpoa: /proc/mpoa initialized
mpc.c: Jan  8 2005 18:41:11 initialized
NET4: DECnet for Linux: V.2.5.68s (C) 1995-2003 Linux DECnet Project Team
DECnet: Routing cache hash table of 512 buckets, 4Kbytes
NET: Registered protocol family 12
NET: Registered protocol family 19
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
SCTP: Hash tables configured (established 512 bind 1024)
Initializing stdio console driver

--Boundary-00=_U6h4BIJ4WAB5BxQ
Content-Type: text/plain;
  charset="iso-8859-1";
  name="out2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="out2.txt"

Checking for the skas3 patch in the host...not found
Checking for /proc/mm...not found
Checking PROT_EXEC mmap in /tmp...OK
Linux version 2.6.10 (knoppix@Knoppix) (gcc version 3.3.4 (Debian 1:3.3.4-9)) #1 Sat Jan 8 19:07:07 EST 2005
Built 1 zonelists
Kernel command line: rootfstype=hostfs rootflags=/home/knoppix/newbuild/build init=/bin/bash root=98:0
PID hash table entries: 256 (order: 8, 4096 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 27808k available
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...missing
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with errno 2)
Kernel panic - not syncing: write of switch_pipe failed, err = 0

--Boundary-00=_U6h4BIJ4WAB5BxQ
Content-Type: text/plain;
  charset="iso-8859-1";
  name="out3.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="out3.txt"

Checking for the skas3 patch in the host...not found
Checking for /proc/mm...not found
Checking PROT_EXEC mmap in /tmp...OK
Linux version 2.6.10 (knoppix@Knoppix) (gcc version 3.3.4 (Debian 1:3.3.4-9)) #1 Sat Jan 8 19:07:07 EST 2005
Built 1 zonelists
Kernel command line: rootfstype=hostfs rootflags=/home/knoppix/newbuild/build init=/bin/bash root=98:0
PID hash table entries: 256 (order: 8, 4096 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 27808k available
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...missing
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with errno 2)
NET: Registered protocol family 16
Kernel panic - not syncing: read of switch_pipe failed, errno = 9

--Boundary-00=_U6h4BIJ4WAB5BxQ
Content-Type: text/plain;
  charset="iso-8859-1";
  name="out4.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="out4.txt"

Checking for the skas3 patch in the host...not found
Checking for /proc/mm...not found
Checking PROT_EXEC mmap in /tmp...OK
Linux version 2.6.10 (knoppix@Knoppix) (gcc version 3.3.4 (Debian 1:3.3.4-9)) #1 Sat Jan 8 19:07:07 EST 2005
Built 1 zonelists
Kernel command line: rootfstype=hostfs rootflags=/home/knoppix/newbuild/build init=/bin/bash root=98:0
PID hash table entries: 256 (order: 8, 4096 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 27808k available
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...missing
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with errno 2)
Kernel panic - not syncing: read of switch_pipe failed, errno = 9
 
EIP: 0073:[<a02652f2>] CPU: 0 Not tainted ESP: 007b:a0c826b4 EFLAGS: 00200286
    Not tainted
EAX: 00000000 EBX: 00000001 ECX: a0c82754 EDX: a0c826d4
ESI: 00000008 EDI: 0000000a EBP: a0c826bc DS: 007b ES: 007b
Call Trace: 
 [<a0046d2d>] notifier_call_chain+0x2d/0x50
 [<a00e9b46>] bust_spinlocks+0x46/0x50
 [<a00362e1>] panic+0x71/0x120
 [<a001c800>] copy_from_user_proc+0x0/0x50
 [<a0022e33>] switch_to_tt+0x1e3/0x220
 [<a02a95f0>] schedule+0x2c0/0x4b0
 [<a0038f10>] do_exit+0x170/0x340
 [<a0017733>] um_execve+0x23/0x60
 [<a0049a26>] ____call_usermodehelper+0x76/0xb0
 [<a00499b0>] ____call_usermodehelper+0x0/0xb0
 [<a001bed8>] run_kernel_thread+0x78/0x80
 [<a02653c4>] sigemptyset+0x24/0x40
 [<a00499b0>] ____call_usermodehelper+0x0/0xb0
 [<a001bea0>] run_kernel_thread+0x40/0x80
 [<a00499b0>] ____call_usermodehelper+0x0/0xb0
 [<a0023018>] new_thread_handler+0xe8/0x110
 [<a00499b0>] ____call_usermodehelper+0x0/0xb0
 [<a0265298>] __restore+0x0/0x8
 [<a02652f2>] __sigprocmask+0x22/0x50

 
--Boundary-00=_U6h4BIJ4WAB5BxQ--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
