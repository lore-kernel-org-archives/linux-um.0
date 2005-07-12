Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Re: Problems about fork-not-clone (was: Re:
	[uml-user] UML exits after "tracing thread pid")
References: <1119527920.4679.15.camel@FC3-bernhard-1.acousta.local>
	<1121068129.4682.15.camel@FC3-bernhard-1.acousta.local>
	<200507112321.20457.blaisorblade@yahoo.it>
In-Reply-To: <200507112321.20457.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507120253.38724.rob@landley.net>
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
Date: Tue, 12 Jul 2005 02:53:38 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Blaisorblade <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-user@lists.sourceforge.net

On Monday 11 July 2005 16:21, Blaisorblade wrote:
> > As long as
> > skas0 is not in kernel mainline and enabled in main distributions, it
> > has no relevance for corporate level (at least in my case).
> >
> > UML gives us the chance to build a compile and debug environment without
> > a relevance on which distribution it runs. The image used to boot UML is
> > a copy for each developer and each of them could compile applications
> > having the same environment as on the target system.
>
> There's a bit of misunderstanding: SKAS0 is a patch for UML only, not an
> host patch. It's numbered "0" because it has "0" dependencies, or because
> it does not depend on host SKAS patch (nor SKAS1, nor SKAS2, nor SKAS3).

But how do you trigger it?

I tried applying your "uml-2.6.12-bb2-skas0.patch.bz2" patch to 2.6.12.2, 
doing "make ARCH=um allnoconfig", following to .config:

CONFIG_MODE_TT=y
CONFIG_LD_SCRIPT_STATIC=y
CONFIG_BINFMT_ELF=y
CONFIG_HOSTFS=y
CONFIG_SYSCTL=y
CONFIG_STDERR_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_LBD=y
CONFIG_EXT2_FS=y
CONFIG_PROC_FS=y

doing a "yes '' | make ARCH=um oldconfig", and then make ARCH=um.

Then I run the result with "./linux rootfstype=hostfs rootflags=/ mem=48M 
init=/bin/sh"

And I get:

Checking for /proc/mm...not found
Checking for the skas3 patch in the host...not found
Checking PROT_EXEC mmap in /tmp...OK
Linux version 2.6.12.2-bb2-skas0 (landley@driftwood) (gcc version 3.3.5 
(Debian 1:3.3.5-8ubuntu2)) #2 Tue Jul 12 02:37:24 CDT 2005
Built 1 zonelists
Kernel command line: rootfstype=hostfs rootflags=/ mem=48M init=/bin/sh 
root=98:0
PID hash table entries: 256 (order: 8, 4096 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 46720k available
Mount-cache hash table entries: 512
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...missing
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with errno 2)
Linux NoNET1.0 for Linux 2.6
io scheduler noop registered
loop: loaded (max 8 devices)
Initialized stdio console driver
Console initialized on /dev/tty0
VFS: Mounted root (hostfs filesystem) readonly.
Kernel panic - not syncing: get_skas_faultinfo : failed to wait for 
SIGUSR1/SIGTRAP, pid = 15117, n = 15117, errno = 0, status = 0xb


EIP: 0073:[<40000c22>] CPU: 0 Not tainted ESP: 007b:bfbddd60 EFLAGS: 00210246
    Not tainted
EAX: bfbddd60 EBX: 00000000 ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: 00000000 EBP: 00000000 DS: 007b ES: 007b
088e7bc0:  [<0807ad9d>] notifier_call_chain+0x2d/0x50
088e7bd0:  [<080e25e6>] bust_spinlocks+0x46/0x50
088e7be0:  [<0806b911>] panic+0x71/0x120
088e7c00:  [<0805e7e2>] wait_stub_done+0xa2/0xf0
088e7c30:  [<0805e8aa>] get_skas_faultinfo+0x7a/0xa0
088e7c50:  [<080602d2>] user_signal+0x82/0x90
088e7c70:  [<0805ef60>] userspace+0x180/0x220
088e7cd4:  [<08054e90>] init+0x0/0x110
088e7ce0:  [<0805f8f2>] new_thread_handler+0xf2/0x130




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
