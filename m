Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EG52J-0006nk-Qa	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Sep 2005 18:29:07 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EG52J-0006U3-C3
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Sep 2005 18:29:07 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] 2.6.14-rc1 x86 on 2.6.13.1 amd64 host: guest
	segfaults
References: <1126803951.5268.39.camel@localhost.localdomain>
	<20050915190633.GB8106@ccure.user-mode-linux.org>
	<1126820388.1391.4.camel@localhost>
In-Reply-To: <1126820388.1391.4.camel@localhost>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_P/hKDcji6mE26sP"
Message-Id: <200509152028.47194.rob@landley.net>
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
Date: Thu, 15 Sep 2005 20:28:46 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: antoine <antoine@nagafix.co.uk>, Jeff Dike <jdike@addtoit.com>

--Boundary-00=_P/hKDcji6mE26sP
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 15 September 2005 16:39, antoine wrote:
> On Thu, 2005-09-15 at 15:06 -0400, Jeff Dike wrote:
> > On Thu, Sep 15, 2005 at 06:05:51PM +0100, Antoine Martin wrote:
> > > I tried mode=skas0 but it seems to always default to TT.
> > > Or has this not been merged in mainline yet?
> >
> > It's in mainline.  What's the guest?
>
> 2.6.14-rc1
>
> > > **
> > > And here is a amd64 guest:
> > > (This trace was much much longer)
> >
> > Did this one come up in skas0 or tt mode?
>
> I think it was tt (will check tomorrow on that box)
> As I said above, it seems to always use TT, ignoring mode=skas0

I have a little trick I do, which is to build a minimal UML with hostfs 
(sample config file attached), and then booting it ala:

./linux rootfstype=hostfs rootflags=/ rw mem=48M init=/bin/sh

This should come up with /bin/sh as pid 1 attached to /dev/console which is 
going to stdin and stdout of the UML process.  (I.E. bog simple uml wrapper 
for a command shell.)

If I compile it in tt mode, it works fine on ubuntu (hoar-infested hedgehog 
release).

If I compile it instead for skas mode, it makes it all the way to mounting the 
rootfs (which it will only do if skas0 is in, because the ubuntu host kernel 
doesn't have skas support), but then barfs saying it can't intialize the TLS 
environment, kills PID 1, dumps a panic, and gives me my host kernel's shell 
prompt back.

(Easy way to tell which system you're running: "whoami".  If it says root, 
you're in the child kernel.  "mount -t proc /proc /proc" followed by 
"cat /proc/cpuinfo" is good too...)

When I build both in, skas0 wins (at least in that it gives me the can't setup 
tls message and corresponding panic).

Rob

--Boundary-00=_P/hKDcji6mE26sP
Content-Type: text/plain;
  charset="utf-8";
  name="config-uml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="config-uml"

CONFIG_GENERIC_HARDIRQS=y
CONFIG_UML=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_IRQ_RELEASE_METHOD=y
CONFIG_MODE_SKAS=y
CONFIG_UML_X86=y
CONFIG_TOP_ADDR=0xc0000000
CONFIG_STUB_CODE=0xbfffe000
CONFIG_STUB_DATA=0xbffff000
CONFIG_STUB_START=0xbfffe000
CONFIG_ARCH_HAS_SC_SIGNALS=y
CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA=y
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_LD_SCRIPT_DYN=y
CONFIG_NET=y
CONFIG_BINFMT_ELF=y
CONFIG_HOSTFS=y
CONFIG_NEST_LEVEL=0
CONFIG_KERNEL_HALF_GIGS=1
CONFIG_KERNEL_STACK_ORDER=2
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_LOCALVERSION=""
CONFIG_SYSCTL=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_KALLSYMS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
CONFIG_BASE_SMALL=0
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_STANDALONE=y
CONFIG_STDERR_CONSOLE=y
CONFIG_STDIO_CONSOLE=y
CONFIG_XTERM_CHAN=y
CONFIG_NOCONFIG_CHAN=y
CONFIG_CON_ZERO_CHAN="fd:0,fd:1"
CONFIG_CON_CHAN="xterm"
CONFIG_SSL_CHAN="pty"
CONFIG_UNIX98_PTYS=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_INITRAMFS_SOURCE=""
CONFIG_LBD=y
CONFIG_IOSCHED_NOOP=y
CONFIG_NETDEVICES=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_DNOTIFY=y
CONFIG_PROC_FS=y
CONFIG_SYSFS=y
CONFIG_RAMFS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_LOG_BUF_SHIFT=14

--Boundary-00=_P/hKDcji6mE26sP--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
