Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JyHF4-0001mB-SO for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 May 2008 19:06:24 -0700
Received: from an-out-0708.google.com ([209.85.132.251])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JyHF3-0005Hs-U6
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 May 2008 19:06:18 -0700
Received: by an-out-0708.google.com with SMTP id b21so538405ana.6
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 19 May 2008 19:06:17 -0700 (PDT)
Message-ID: <804dabb00805191906k1f8081e9u174f198e4cee3862@mail.gmail.com>
Date: Tue, 20 May 2008 10:06:16 +0800
From: "Peter Teoh" <htmldeveloper@gmail.com>
In-Reply-To: <20080519160652.GA17500@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
References: <804dabb00805180206wc937036x8e50336967f78ee3@mail.gmail.com>
	<20080518140121.GA5635@c2.user-mode-linux.org>
	<804dabb00805180830s6abedeb1o39b592f235fe5319@mail.gmail.com>
	<20080519160652.GA17500@c2.user-mode-linux.org>
Subject: Re: [uml-devel] ?struct thread_struct? has no member named ?mode?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On 5/20/08, Jeff Dike <jdike@addtoit.com> wrote:
> On Sun, May 18, 2008 at 11:30:13PM +0800, Peter Teoh wrote:
>  > Thank you Jeff.....what distros are u on?   I think my machine(s) may
>  > have some problem...or possibly the distros itself...
>  > following your steps EXACTLY (thank you for the elaborate explanation
>  > :-)) I got the following in my FC5, FC6 and FC7 machines:
>
>
> These all say the same thing:
>
>  > *** You have not yet configured your kernel!
>  > *** (missing kernel .config file)
>  > ***
>  > *** Please run some configurator (e.g. "make oldconfig" or
>  > *** "make menuconfig" or "make xconfig").
>  > ***
>
>  Given that you're running defconfig, it's bizarre that it's
>  complaining about a missing .config.  The only thing I can think of
>  which could cause this is some Kbuild running something and getting a
>  non-standard tool that you have earlier in your search path than the
>  standard one.
>
>  Since it's complaining about the lack of a .config, try
>       cp arch/um/defconfig uml/.config
>  and try the defconfig again.
>
>
>  > Ok...in conclusion:   I need to install FC9 now.....
>
>
> This has nothing to do with your distro, since FC5 through FC7 all say
>  the same thing.  Also, if UML didn't build on all of them, I'd think
>  someone would have noticed by now.
>

Thank you for your stamina, I almost giving it up...now shall try again:

Ok, first I copied the defconfig to uml subdirectory as .config.   Next:

/mnt/sdc3/linux-2.6.24.2>make defconfig ARCH=um O=uml
make[2]: Nothing to be done for `/mnt/sdc3/linux-2.6.24.2/Makefile'.
  GEN     /mnt/sdc3/linux-2.6.24.2/uml/Makefile
scripts/kconfig/conf -s arch/um/Kconfig
*
* Restart config...
*
*
* Host processor type and features
*
Processor family
  1. 486 (M486)
  2. 586/K5/5x86/6x86/6x86MX (M586)
  3. Pentium-Classic (M586TSC)
  4. Pentium-MMX (M586MMX)
> 5. Pentium-Pro (M686)
  6. Pentium-II/Celeron(pre-Coppermine) (MPENTIUMII)
  7. Pentium-III/Celeron(Coppermine)/Pentium-III Xeon (MPENTIUMIII)
  8. Pentium M (MPENTIUMM)
  9. Pentium-4/Celeron(P4-based)/Pentium-4 M/older Xeon (MPENTIUM4)
  10. K6/K6-II/K6-III (MK6)
  11. Athlon/Duron/K7 (MK7)
  12. Opteron/Athlon64/Hammer/K8 (MK8)
  13. Crusoe (MCRUSOE)
  14. Efficeon (MEFFICEON)
  15. Winchip-C6 (MWINCHIPC6)
  16. Winchip-2 (MWINCHIP2)
  17. Winchip-2A/Winchip-3 (MWINCHIP3D)
  18. GeodeGX1 (MGEODEGX1)
  19. Geode GX/LX (MGEODE_LX)
  20. CyrixIII/VIA-C3 (MCYRIXIII)
  21. VIA C3-2 (Nehemiah) (MVIAC3_2)
  22. VIA C7 (MVIAC7)
  23. Core 2/newer Xeon (MCORE2) (NEW)
choice[1-23]:

Next I just "ENTER" for all default parameters.

Next it gone into infinite loop:

Stack utilization instrumentation (DEBUG_STACK_USAGE) [N/y/?] n
#
# configuration written to .config
#
make[3]: Nothing to be done for `/mnt/sdc3/linux-2.6.24.2/uml'.
make[3]: Nothing to be done for `/mnt/sdc3/linux-2.6.24.2/uml'.
make[4]: Nothing to be done for `/mnt/sdc3/linux-2.6.24.2/Makefile'.
make[5]: Nothing to be done for `/mnt/sdc3/linux-2.6.24.2/uml'.
make[5]: Nothing to be done for `/mnt/sdc3/linux-2.6.24.2/uml'.
make[6]: Nothing to be done for `/mnt/sdc3/linux-2.6.24.2/Makefile'.
make[8]: Nothing to be done for `/mnt/sdc3/linux-2.6.24.2/Makefile'.
make[9]: Nothing to be done for `/mnt/sdc3/linux-2.6.24.2/uml'.
make[9]: Nothing to be done for `/mnt/sdc3/linux-2.6.24.2/uml'.
make[10]: Nothing to be done for `/mnt/sdc3/linux-2.6.24.2/Makefile'.
make[11]: Nothing to be done for `/mnt/sdc3/linux-2.6.24.2/uml'.
make[11]: Nothing to be done for `/mnt/sdc3/linux-2.6.24.2/uml'.
make[12]: Nothing to be done for `/mnt/sdc3/linux-2.6.24.2/Makefile'.
make[13]: Nothing to be done for `/mnt/sdc3/linux-2.6.24.2/uml'.
make[13]: Nothing to be done for `/mnt/sdc3/linux-2.6.24.2/uml'.
make[14]: Nothing to be done for `/mnt/sdc3/linux-2.6.24.2/Makefile'.
^Cmake[14]: *** [sub-make] Interrupt
make[13]: *** [/mnt/sdc3/linux-2.6.24.2/uml] Interrupt
make[12]: *** [sub-make] Interrupt
make[11]: *** [defconfig] Interrupt
make[10]: *** [sub-make] Interrupt
make[9]: *** [defconfig] Interrupt
make[8]: *** [sub-make] Interrupt
make[7]: *** [defconfig] Interrupt
make[6]: *** [sub-make] Interrupt
make[5]: *** [defconfig] Interrupt
make[4]: *** [sub-make] Interrupt
make[3]: *** [defconfig] Interrupt
make[2]: *** [sub-make] Interrupt
make[1]: *** [defconfig] Interrupt
make: *** [sub-make] Interrupt

For the following:

/mnt/sdc3/linux-2.6.24.2>make ARCH=um O=uml
make[1]: Nothing to be done for `/mnt/sdc3/linux-2.6.24.2/uml'.

(just a one-liner output)

But for another:

/mnt/sdc3/linux-2.6.24.2>make linux ARCH=um O=uml
make[1]: Nothing to be done for `/mnt/sdc3/linux-2.6.24.2/uml'.
  SYMLINK arch/um/include/kern_constants.h
  SYMLINK arch/um/include/sysdep
  CHK     arch/um/include/uml-config.h
  UPD     arch/um/include/uml-config.h
make[2]: `arch/um/sys-i386/user-offsets.s' is up to date.
  Using /mnt/sdc3/linux-2.6.24.2 as source for kernel
  GEN     /mnt/sdc3/linux-2.6.24.2/uml/Makefile
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
ERROR: the symlink include/asm points to asm-x86 but asm-um was expected
       set ARCH or save .config and run 'make mrproper' to fix it
make[1]: *** [include/asm] Error 1
make: *** [sub-make] Error 2


So I did a copy of defconfig into uml subdirectory, make oldconfig
ARCH=um O=uml, and then make linux ARCH=um O=uml:

  CC      arch/um/kernel/umid.o
  CC      arch/um/kernel/skas/clone.o
  CC      arch/um/kernel/skas/mmu.o
  CC      arch/um/kernel/skas/process.o
  CC      arch/um/kernel/skas/syscall.o
  LD      arch/um/kernel/built-in.o
ld: arch/um/kernel/skas/built-in.o: No such file: No such file or directory
make[2]: *** [arch/um/kernel/built-in.o] Error 1
make[1]: *** [arch/um/kernel] Error 2
make: *** [sub-make] Error 2

Next I did:   make modules ARCH=um O=uml:

  CC      arch/um/os-Linux/skas/trap.o
  LD      arch/um/os-Linux/skas/built-in.o
  CC      arch/um/os-Linux/sys-i386/registers.o
  CC      arch/um/os-Linux/sys-i386/signal.o
  CC      arch/um/os-Linux/sys-i386/tls.o
  LD      arch/um/os-Linux/sys-i386/built-in.o
  LD      arch/um/os-Linux/built-in.o
ld: arch/um/os-Linux/drivers/built-in.o: No such file: No such file or directory
make[2]: *** [arch/um/os-Linux/built-in.o] Error 1
make[1]: *** [arch/um/os-Linux] Error 2

Noticed it resolved the skas errors, but got new ones....now go back again:

make linux ARCH=um O=uml, coredump once, repeat again:

  LD      net/xfrm/built-in.o
  CC      net/sysctl_net.o
  LD      net/built-in.o
ld: net/ipv4/built-in.o: No such file: No such file or directory
make[2]: *** [net/built-in.o] Error 1
make[1]: *** [net] Error 2
make: *** [sub-make] Error 2

So next:

/mnt/sdc3/linux-2.6.24.2>make modules ARCH=um O=uml
make[1]: Nothing to be done for `/mnt/sdc3/linux-2.6.24.2/uml'.
  SYMLINK arch/um/include/kern_constants.h
  SYMLINK arch/um/include/sysdep
make[2]: `arch/um/sys-i386/user-offsets.s' is up to

  CC      fs/xattr.o
  CC      fs/libfs.o
make[1]: *** [fs] Segmentation fault (core dumped)
make: *** [sub-make] Error 2

So repeat make modules again (generally when core dump, just repeat again):

  LD      init/built-in.o
  LD      .tmp_vmlinux1
gcc: mm/built-in.o: No such file or directory
gcc: fs/built-in.o: No such file or directory
  KSYM    .tmp_kallsyms1.S
nm: '.tmp_vmlinux1': No such file
No valid symbol.
make[1]: *** [.tmp_kallsyms1.S] Error 1
make: *** [sub-make] Error 2

So make linux again:

  CC      fs/sysfs/bin.o
  CC      fs/sysfs/group.o
  LD      fs/sysfs/built-in.o
  LD      fs/built-in.o
ld: fs/proc/built-in.o: No such file: No such file or directory
make[2]: *** [fs/built-in.o] Error 1
make[1]: *** [fs] Error 2
make: *** [sub-make] Error 2

So make module:

  CC      fs/reiserfs/super.o
  CC      fs/reiserfs/prints.o
  CC      fs/reiserfs/objectid.o
  LD      fs/built-in.o
ld: fs/reiserfs/built-in.o: No such file: No such file or directory
make[2]: *** [fs/built-in.o] Error 1
make[1]: *** [fs] Error 2
make: *** [sub-make] Error 2

So make linux this time:

/mnt/sdc3/linux-2.6.24.2>make linux ARCH=um O=uml
make[1]: Nothing to be done for `/mnt/sdc3/linux-2.6.24.2/uml'.
  SYMLINK arch/um/include/kern_constants.h
  SYMLINK arch/um/include/sysdep
make[2]: `arch/um/sys-i386/user-offsets.s' is up to date.
  Using /mnt/sdc3/linux-2.6.24.2 as source for kernel
  GEN     /mnt/sdc3/linux-2.6.24.2/uml/Makefile
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CALL    /mnt/sdc3/linux-2.6.24.2/scripts/checksyscalls.sh
  CHK     include/linux/compile.h
  CC      fs/reiserfs/lbalance.o
  CC      fs/reiserfs/ibalance.o
  CC      fs/reiserfs/stree.o
  CC      fs/reiserfs/hashes.o
  CC      fs/reiserfs/tail_conversion.o
  CC      fs/reiserfs/journal.o
  CC      fs/reiserfs/resize.o
  CC      fs/reiserfs/item_ops.o
  LD      fs/built-in.o
ld: fs/reiserfs/built-in.o: No such file: No such file or directory
make[2]: *** [fs/built-in.o] Error 1
make[1]: *** [fs] Error 2
make: *** [sub-make] Error 2

Back to make modules again:

/mnt/sdc3/linux-2.6.24.2>make modules ARCH=um O=uml
make[1]: Nothing to be done for `/mnt/sdc3/linux-2.6.24.2/uml'.
  SYMLINK arch/um/include/kern_constants.h
  SYMLINK arch/um/include/sysdep

Success!!!

Make linux again:

/mnt/sdc3/linux-2.6.24.2>make linux ARCH=um O=uml
make[1]: Nothing to be done for `/mnt/sdc3/linux-2.6.24.2/uml'.
  SYMLINK arch/um/include/kern_constants.h
  SYMLINK arch/um/include/sysdep
make[2]: `arch/um/sys-i386/user-offsets.s' is up to date.
  Using /mnt/sdc3/linux-2.6.24.2 as source for kernel
  GEN     /mnt/sdc3/linux-2.6.24.2/uml/Makefile
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CALL    /mnt/sdc3/linux-2.6.24.2/scripts/checksyscalls.sh
  CHK     include/linux/compile.h
  CC      fs/reiserfs/ioctl.o
  CC      fs/reiserfs/procfs.o
  LD      fs/reiserfs/reiserfs.o
  LD      fs/reiserfs/built-in.o
  LD      fs/built-in.o
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
  KSYM    .tmp_kallsyms1.S
  AS      .tmp_kallsyms1.o
  LD      .tmp_vmlinux2
  KSYM    .tmp_kallsyms2.S
  AS      .tmp_kallsyms2.o
  LD      .tmp_vmlinux3
  KSYM    .tmp_kallsyms3.S
  AS      .tmp_kallsyms3.o
  LD      vmlinux.o
  MODPOST vmlinux.o
  LD      vmlinux
  SYSMAP  System.map
  SYSMAP  .tmp_System.map
  LINK linux

And cd to uml subdirectory....so many core-dumps etc.

The same message (infinite loop, and one line ending message) also
happened for my NEWLY INSTALLED Ubuntu 7.10 running on 2.6.22-14
kernel.   But I don't think it is necessary to build into the same
version of the kernel (2.6.24.2) in order to build the UML component
right?   I have tried this crazy alternation of make linux/modules
yet, but I have never done this before, and have never read up
anything like this before.

Ok....UML is seemingly starting now:

/mnt/sdc3/linux-2.6.24.2/uml>./linux
Core dump limits :
        soft - NONE
        hard - NONE
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...OK
Checking for tmpfs mount on /dev/shm...OK
Checking PROT_EXEC mmap in /dev/shm/...OK
Checking for the skas3 patch in the host:
  - /proc/mm...not found: No such file or directory
  - PTRACE_FAULTINFO...not found
  - PTRACE_LDT...not found
UML running in SKAS0 mode
Linux version 2.6.24.2 (root@xentiger) (gcc version 4.1.2 20070925
(Red Hat 4.1.2-27)) #2 Tue May 20 09:16:22 SGT 2008
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8128
Kernel command line: root=98:0
PID hash table entries: 128 (order: 7, 512 bytes)
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 30200k available
Mount-cache hash table entries: 512
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
net_namespace: 64 bytes
Using 2.6 host AIO
NET: Registered protocol family 16
NET: Registered protocol family 2
Time: itimer clocksource has been installed.
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 1024 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
TCP reno registered
Checking host MADV_REMOVE support...OK
mconsole (version 2) initialized on /root/.uml/lkdBWU/mconsole
Host TLS support detected
Detected host type: i386
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Initialized stdio console driver
Console initialized on /dev/tty0
console [tty0] enabled
Initializing software serial port version 1
console [mc-1] enabled
Couldn't stat "root_fs" : err = 2
Failed to initialize ubd device 0 :Couldn't determine size of device's file
VFS: Cannot open root device "98:0" or unknown-block(98,0)
Please append a correct "root=" boot option; here are the available partitions:
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(98,0)

EIP: 0073:[<b7f24424>] CPU: 0 Not tainted ESP: 007b:bfe22518 EFLAGS: 00000246
    Not tainted
EAX: 00000000 EBX: 000053cc ECX: 00000013 EDX: 000053cc
ESI: 000053c8 EDI: 00000001 EBP: bfe2253c DS: 007b ES: 007b
09c5ae6c:  [<08069d14>] show_regs+0xb4/0xb9
09c5ae98:  [<08058a6e>] panic_exit+0x25/0x3f
09c5aeac:  [<08085158>] notifier_call_chain+0x21/0x46
09c5aecc:  [<080851f3>] __atomic_notifier_call_chain+0x17/0x19
09c5aee8:  [<0808520a>] atomic_notifier_call_chain+0x15/0x17
09c5af04:  [<08070576>] panic+0x52/0xdd
09c5af24:  [<08049a88>] mount_block_root+0xf8/0x10e
09c5af78:  [<08049aea>] mount_root+0x4c/0x54
09c5af9c:  [<08049bfe>] prepare_namespace+0x10c/0x133
09c5afa4:  [<080497b3>] kernel_init+0x79/0x85
09c5afb4:  [<08063f2c>] run_kernel_thread+0x37/0x3f
09c5afe0:  [<080567cb>] new_thread_handler+0x57/0x7e
09c5affc:  [<00000000>] _sinittext+0xf7fb7000/0x88

Segmentation fault (core dumped)

I will attempt to progress from here.....thanks for the support/help!!!

-- 
Regards,
Peter Teoh

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
