Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <F47F4E3B83BE854AA0BCB998C69295169D2BB4@tiki.fastmail.usf.edu>
From: "Gaspar, Alessio (USF Lakeland)" <alessio@lklnd.usf.edu>
Subject: [uml-devel] RE: 2.6.12-bb2-skas0 hanging after INIT  (CORRECTION
	PREVIOUS POST)
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
Date: Tue, 12 Jul 2005 14:15:49 -0400
Content-Transfer-Encoding: 8bit
To: user-mode-linux-user@lists.sourceforge.net
Cc: user-mode-linux-devel@lists.sourceforge.net, Blaisorblade <blaisorblade@yahoo.it>

> On Tuesday 12 July 2005 18:45, Gaspar, Alessio (USF Lakeland) wrote:
> > err... please read 2.6.12-bb2-skas0 in my previous post instead of
> > 2.6.12-bs1-skas0. I did try too many patches lately :)
> Granted, but what about using plain -bs1? SKAS0 is still development
code
> (and
> I'm not very acquainted with it), so I would avoid it in case of
problems.
> 
> After that, UML has not a lovely relation with 2.6.10 and 2.6.9, so if
you
> can
> go to either 2.6.8.1 or 2.6.11 it would be mairveillous...

Sorry can't do (trust me I'd prefer too :)
I just browsed again openSSI.org and we need their 1.9.x version which,
of course, is based on 2.6.10.

Concerning 2.6.12-bs1, I already tried it before but, since I couldn't
recall what went wrong, I re-compiled the guest uml kernel using this
time various options (support for SKAS and/or TT) and re-tested the
whole thing

Each version was compiled by doing a 
make ARCH=um mrproper
make ARCH=um defconfig
make ARCH=um menuconfig (to edit changes between trials)
make ARCH=um linux 

Summary of results

SKAS + TT			./linux-tt-skas
hangs  
				./linux-tt-skas mode=tt		hangs
TT only			./linux-tt 				hangs


In all cases, boot hangs on sleeping process gets unexpected signal 10
This is the original bug I bumped into and which led me to try the skas0
approach to escape any TT mode related problem

SKAS 	(dyn linking)	./linux-skas-dynamic		
	(stat linking)	./linux-skas-static	

These are useless since there is no skas support in the host kernel

I don't know if this info helps but it may spare others useless
compilations at least.



Details & snapshots below
____________________________________________
Compiled w/ SKAS & TT support (defconfig defaults)
./linux-tt-skas

Checking for /proc/mm...not found
Checking PROT_EXEC mmap in /tmp...OK
tracing thread pid = 70910
Linux version 2.6.12.2-bs1 (alessio@xxx) (gcc version 3.3.5 (Debian
1:3.3.5-13)) #1 Tue Jul 12 13:34:18 EDT 2005
Built 1 zonelists
Kernel command line: root=98:0
PID hash table entries: 256 (order: 8, 4096 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 28884k available
Mount-cache hash table entries: 512
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...missing
Checking that host ptys support output SIGIO...No, enabling workaround
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with
errno 2)
NET: Registered protocol family 16
mconsole (version 2) initialized on /home/alessio/.uml/1WQ0b8/mconsole
ubd: Synchronous mode
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
NET: Registered protocol family 1
NET: Registered protocol family 17
Initialized stdio console driver
Console initialized on /dev/tty0
Initializing software serial port version 1
 ubda: unknown partition table
VFS: Mounted root (ext2 filesystem) readonly.
sleeping process 70915 got unexpected signal : 10


./linux-tt-skas mode=tt



Checking PROT_EXEC mmap in /tmp...OK
tracing thread pid = 71470
Linux version 2.6.12.2-bs1 (alessio@xxx) (gcc version 3.3.5 (Debian
1:3.3.5-13)) #1 Tue Jul 12 13:34:18 EDT 2005
Built 1 zonelists
Kernel command line: mode=tt root=98:0
PID hash table entries: 256 (order: 8, 4096 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 28884k available
Mount-cache hash table entries: 512
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...missing
Checking that host ptys support output SIGIO...No, enabling workaround
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with
errno 2)
NET: Registered protocol family 16
mconsole (version 2) initialized on /home/alessio/.uml/qvG0sg/mconsole
ubd: Synchronous mode
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
NET: Registered protocol family 1
NET: Registered protocol family 17
Initialized stdio console driver
Console initialized on /dev/tty0
Initializing software serial port version 1
 ubda: unknown partition table
VFS: Mounted root (ext2 filesystem) readonly.
sleeping process 71475 got unexpected signal : 10


____________________________________________
Compiled w/ TT support only
./linux-tt


Checking PROT_EXEC mmap in /tmp...OK
tracing thread pid = 72054
Linux version 2.6.12.2-bs1 (alessio@xxx) (gcc version 3.3.5 (Debian
1:3.3.5-13)) #1 Tue Jul 12 13:43:37 EDT 2005
Built 1 zonelists
Kernel command line: root=98:0
PID hash table entries: 256 (order: 8, 4096 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 28952k available
Mount-cache hash table entries: 512
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...missing
Checking that host ptys support output SIGIO...No, enabling workaround
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with
errno 2)
NET: Registered protocol family 16
mconsole (version 2) initialized on /home/alessio/.uml/8LF8r7/mconsole
ubd: Synchronous mode
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
NET: Registered protocol family 1
NET: Registered protocol family 17
Initialized stdio console driver
Console initialized on /dev/tty0
Initializing software serial port version 1
 ubda: unknown partition table
VFS: Mounted root (ext2 filesystem) readonly.
sleeping process 72059 got unexpected signal : 10





-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
