Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGRQ3-0008PR-2R for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Apr 2004 16:46:19 -0700
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BGROb-0006ed-2a for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Apr 2004 16:44:49 -0700
Message-ID: <08bf01c427fb$86cb9520$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <Pine.LNX.4.58.0404162157280.29213@boston.corp.fedex.com>
	<072401c4273d$99b857e0$2000000a@schlepptopp>
	<Pine.LNX.4.58.0404211409570.2147@boston.corp.fedex.com>
Subject: Re: [uml-devel] patch for 2.6.6-rc1
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_08BC_01C4280C.4860AB70"
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
Date: Thu, 22 Apr 2004 01:51:09 +0200
To: Jeff Chua <jeff98@silk.corp.fedex.com>
Cc: UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>


This is a multi-part message in MIME format.

------=_NextPart_000_08BC_01C4280C.4860AB70
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

hi jeff,
sorry, but it still doesn`t work for me.
i tried both kernel 2.6.6-rc1 and 2.6.6-rc2 sources to compile a guest kernel.

i have attached a log from what i have done - errors are at the end.

did anybody have success compiling a 2.6.6-rc1/2 with jeff`s instructions ?

regards
roland

ps:
> You must apply uml-patch-2.6.4-1.bz2 (or the attached uml-patch-2.6.6-0)
> to the host and guest first before applying any other uml patches.
uml-patch-2.6.4-1.bz2 doesn`t apply to 2.6.6-rc1/2 (hunks failed)

pps:
one minor correction:
> bzip2 -d -c patch.2.6.5-uml1.fix | patch -p1
> bzip2 -d -c patch.266rc1-1 | patch -p1
should be:
cat patch.2.6.5-uml1.fix | patch -p1
cat patch.266rc1-1 | patch -p1
because they aren`t compressed attachments

----- Original Message ----- 
From: "Jeff Chua" <jeff98@silk.corp.fedex.com>
To: "roland" <for_spam@gmx.de>
Cc: "UserModeLinux" <user-mode-linux-devel@lists.sourceforge.net>
Sent: Wednesday, April 21, 2004 8:33 AM
Subject: Re: [uml-devel] patch for 2.6.6-rc1


>
>
> You must apply uml-patch-2.6.4-1.bz2 (or the attached uml-patch-2.6.6-0)
> to the host and guest first before applying any other uml patches.
>
> The patches I sent earlier will apply up to 2.6.6-rc2. I've attached all
> these patches here again.
>
> Start with the "host" ...
> cd /usr/src
> /usr/bin/tar --use=bzip2 xpf linux-2.6.5.tar.bz2
> ln -nsf linux-2.6.5 linux
> cd linux
> bzip2 -d -c patch-2.6.6-rc2.bz2 | patch -p1
> bzip2 -d -c uml-patch-2.6.6-0.bz2 | patch -p1
> bzip2 -d -c 00-2.6.6-v0-host-SKAS2.patch.bz2 | patch -p1
> ... ready to compile "host"
>
>
> Now copy the above "host" to "guest" ...
> cd /usr/src
> mkdir uml
> cd /usr/src/linux; find . | cpio -pdum ../uml
> cd ../uml
>
> # undo the SKAS patch ...
> bzip2 -d -c 00-2.6.6-v0-host-SKAS2.patch.bz2 | patch -p1 -R
>
> # apply to get it to compile for 2.6.5
> bzip2 -d -c patch.2.6.5-uml1.fix | patch -p1
>
> make mrproper ARCH=um
>
> # apply to get it to compile for 2.6.6
> bzip2 -d -c patch.266rc1-1 | patch -p1
>
> ... ready to compile "guest" ...
>
>
> Thanks,
> Jeff
> [ jchua@fedex.com ]
>
> On Wed, 21 Apr 2004, roland wrote:
>
> > hi!
> >
> > i tried to compile a 2.6.6-rc1 today - but it didn`t work for me.
> >
> > do i need additional patches besides the ones posted in jeff`s mail ? (jeffs patches seem really small sized - uml-patch is
usually
> > >100kb)
> >
> > applying 00-2.6.6-v0-host-SKAS2.patch.bz2 to a vanilla 2.6.6-rc1 kernel fails. applying the guest patches fails, too.
> >
> > i assume i missed another patch to apply to 2.6.6-rc1 befory applying jeffs patches
> > OR
> > jeff did a mistake
> > OR
> > kernel-2.6.6-r1 changed in the meanwhile (being trojanized on kernel.org?) :)
> >
> > can somebody help me to get a 2.6.6-r1-skas-host and 2.6.6-r1-uml running ?
> >
> > regards
> > roland
> >
> > ----- Original Message -----
> > From: "Jeff Chua" <jeff98@silk.corp.fedex.com>
> > To: "UserModeLinux" <user-mode-linux-devel@lists.sourceforge.net>
> > Sent: Friday, April 16, 2004 4:04 PM
> > Subject: [uml-devel] patch for 2.6.6-rc1
> >
> >
> > >
> > > Here's patch to make uml compiles and run with 2.6.6-rc1.
> > >
> > > 1) Host 2.6.6-rc1 has 00-2.6.6-v0-host-SKAS2.patch.bz2 applied.
> > >
> > > 2) Guest has patch.2.6.5-uml1.fix applied, make mrproper ARCH=um, then
> > >    patch.266rc1-1 applied.
> > >
> > > I fudged those filed to make it compile and run. Please verify. I know
> > > TASK_DEBUGREGS is incorrect, but since I don't use the debug mode, I
> > > simply set to 1 to make it run, but it may not be right if you need to
> > > debug uml. Hopefully someone can come up with a better patch.
> > >
> > >
> > > Thanks,
> > > Jeff
> >
> >
> >
> > -------------------------------------------------------
> > This SF.Net email is sponsored by: IBM Linux Tutorials
> > Free Linux tutorial presented by Daniel Robbins, President and CEO of
> > GenToo technologies. Learn everything from fundamentals to system
> > administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> > _______________________________________________
> > User-mode-linux-devel mailing list
> > User-mode-linux-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> >

------=_NextPart_000_08BC_01C4280C.4860AB70
Content-Type: text/plain;
	name="fail.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="fail.txt"

uml1:/tmp/uml # bzcat linux-2.6.6-rc2.tar.bz2 |tar xvf -=0A=
--snipp--=0A=
=0A=
uml1:/tmp/uml # cd linux-2.6.6-rc2/=0A=
=0A=
uml1:/tmp/uml/linux-2.6.6-rc2 # cat ../uml-patch-2.6.6-0 |patch -p1=0A=
patching file arch/um/config.release=0A=
patching file arch/um/defconfig=0A=
patching file arch/um/drivers/chan_kern.c=0A=
patching file arch/um/drivers/chan_user.c=0A=
patching file arch/um/drivers/cow.h=0A=
patching file arch/um/drivers/cow_kern.c=0A=
patching file arch/um/drivers/cow_sys.h=0A=
patching file arch/um/drivers/cow_user.c=0A=
patching file arch/um/drivers/daemon_user.c=0A=
patching file arch/um/drivers/fd.c=0A=
patching file arch/um/drivers/harddog_user.c=0A=
patching file arch/um/drivers/hostaudio_kern.c=0A=
patching file arch/um/drivers/hostaudio_user.c=0A=
patching file arch/um/drivers/line.c=0A=
patching file arch/um/drivers/Makefile=0A=
patching file arch/um/drivers/mcast_user.c=0A=
patching file arch/um/drivers/mconsole_kern.c=0A=
patching file arch/um/drivers/mconsole_user.c=0A=
patching file arch/um/drivers/mmapper_kern.c=0A=
patching file arch/um/drivers/net_kern.c=0A=
patching file arch/um/drivers/net_user.c=0A=
patching file arch/um/drivers/null.c=0A=
patching file arch/um/drivers/port_kern.c=0A=
patching file arch/um/drivers/port_user.c=0A=
patching file arch/um/drivers/pty.c=0A=
patching file arch/um/drivers/slip_user.c=0A=
patching file arch/um/drivers/slirp_user.c=0A=
patching file arch/um/drivers/ssl.c=0A=
patching file arch/um/drivers/stdio_console.c=0A=
patching file arch/um/drivers/tty.c=0A=
patching file arch/um/drivers/ubd_kern.c=0A=
patching file arch/um/drivers/ubd_user.c=0A=
patching file arch/um/drivers/xterm.c=0A=
patching file arch/um/drivers/xterm_kern.c=0A=
patching file arch/um/dyn.lds.S=0A=
patching file arch/um/include/2_5compat.h=0A=
patching file arch/um/include/irq_kern.h=0A=
patching file arch/um/include/kern_util.h=0A=
patching file arch/um/include/line.h=0A=
patching file arch/um/include/mconsole.h=0A=
patching file arch/um/include/mem.h=0A=
patching file arch/um/include/mem_kern.h=0A=
patching file arch/um/include/mem_user.h=0A=
patching file arch/um/include/os.h=0A=
patching file arch/um/include/signal_user.h=0A=
patching file arch/um/include/skas_ptrace.h=0A=
patching file arch/um/include/sysdep-i386/frame_user.h=0A=
patching file arch/um/include/sysdep-i386/sigcontext.h=0A=
patching file arch/um/include/sysdep-i386/syscalls.h=0A=
patching file arch/um/include/ubd_user.h=0A=
patching file arch/um/include/um_uaccess.h=0A=
patching file arch/um/include/user.h=0A=
patching file arch/um/include/user_util.h=0A=
patching file arch/um/Kconfig=0A=
patching file arch/um/Kconfig_block=0A=
patching file arch/um/Kconfig_net=0A=
patching file arch/um/kernel/config.c.in=0A=
patching file arch/um/kernel/exec_kern.c=0A=
patching file arch/um/kernel/frame.c=0A=
patching file arch/um/kernel/frame_kern.c=0A=
patching file arch/um/kernel/helper.c=0A=
patching file arch/um/kernel/initrd_user.c=0A=
patching file arch/um/kernel/init_task.c=0A=
patching file arch/um/kernel/irq.c=0A=
patching file arch/um/kernel/irq_user.c=0A=
patching file arch/um/kernel/ksyms.c=0A=
patching file arch/um/kernel/Makefile=0A=
patching file arch/um/kernel/mem.c=0A=
patching file arch/um/kernel/mem_user.c=0A=
patching file arch/um/kernel/physmem.c=0A=
patching file arch/um/kernel/process.c=0A=
patching file arch/um/kernel/process_kern.c=0A=
patching file arch/um/kernel/ptrace.c=0A=
patching file arch/um/kernel/reboot.c=0A=
patching file arch/um/kernel/sigio_kern.c=0A=
patching file arch/um/kernel/sigio_user.c=0A=
patching file arch/um/kernel/signal_kern.c=0A=
patching file arch/um/kernel/skas/include/mode.h=0A=
patching file arch/um/kernel/skas/include/skas.h=0A=
patching file arch/um/kernel/skas/include/uaccess.h=0A=
patching file arch/um/kernel/skas/Makefile=0A=
patching file arch/um/kernel/skas/mem_user.c=0A=
patching file arch/um/kernel/skas/mmu.c=0A=
patching file arch/um/kernel/skas/process.c=0A=
patching file arch/um/kernel/skas/process_kern.c=0A=
patching file arch/um/kernel/skas/syscall_kern.c=0A=
patching file arch/um/kernel/skas/sys-i386/Makefile=0A=
patching file arch/um/kernel/skas/sys-i386/sigcontext.c=0A=
patching file arch/um/kernel/skas/trap_user.c=0A=
patching file arch/um/kernel/skas/uaccess.c=0A=
patching file arch/um/kernel/skas/util/Makefile=0A=
patching file arch/um/kernel/skas/util/mk_ptregs.c=0A=
patching file arch/um/kernel/smp.c=0A=
patching file arch/um/kernel/syscall_kern.c=0A=
patching file arch/um/kernel/sys_call_table.c=0A=
patching file arch/um/kernel/sysrq.c=0A=
patching file arch/um/kernel/tempfile.c=0A=
patching file arch/um/kernel/time.c=0A=
patching file arch/um/kernel/time_kern.c=0A=
patching file arch/um/kernel/trap_kern.c=0A=
patching file arch/um/kernel/trap_user.c=0A=
patching file arch/um/kernel/tt/exec_kern.c=0A=
patching file arch/um/kernel/tt/include/mode.h=0A=
patching file arch/um/kernel/tt/include/uaccess.h=0A=
patching file arch/um/kernel/tt/Makefile=0A=
patching file arch/um/kernel/tt/mem_user.c=0A=
patching file arch/um/kernel/tt/process_kern.c=0A=
patching file arch/um/kernel/tt/ptproxy/Makefile=0A=
patching file arch/um/kernel/tt/ptproxy/proxy.c=0A=
patching file arch/um/kernel/tt/ptproxy/sysdep.c=0A=
patching file arch/um/kernel/tt/ptproxy/wait.c=0A=
patching file arch/um/kernel/tt/syscall_kern.c=0A=
patching file arch/um/kernel/tt/sys-i386/Makefile=0A=
patching file arch/um/kernel/tt/tlb.c=0A=
patching file arch/um/kernel/tt/tracer.c=0A=
patching file arch/um/kernel/tt/uaccess.c=0A=
patching file arch/um/kernel/tt/uaccess_user.c=0A=
patching file arch/um/kernel/tt/unmap.c=0A=
patching file arch/um/kernel/tty_log.c=0A=
patching file arch/um/kernel/uaccess_user.c=0A=
patching file arch/um/kernel/um_arch.c=0A=
patching file arch/um/kernel/umid.c=0A=
patching file arch/um/kernel/user_syms.c=0A=
patching file arch/um/kernel/user_util.c=0A=
patching file arch/um/main.c=0A=
patching file arch/um/Makefile=0A=
patching file arch/um/Makefile-i386=0A=
patching file arch/um/Makefile-skas=0A=
patching file arch/um/os-Linux/drivers/ethertap_kern.c=0A=
patching file arch/um/os-Linux/drivers/ethertap_user.c=0A=
patching file arch/um/os-Linux/drivers/tuntap_user.c=0A=
patching file arch/um/os-Linux/file.c=0A=
patching file arch/um/os-Linux/Makefile=0A=
patching file arch/um/os-Linux/process.c=0A=
patching file arch/um/os-Linux/tty.c=0A=
patching file arch/um/os-Linux/user_syms.c=0A=
patching file arch/um/sys-i386/bugs.c=0A=
patching file arch/um/sys-i386/extable.c=0A=
patching file arch/um/sys-i386/fault.c=0A=
patching file arch/um/sys-i386/Makefile=0A=
patching file arch/um/sys-i386/ptrace_user.c=0A=
patching file arch/um/sys-i386/time.c=0A=
patching file arch/um/sys-i386/util/Makefile=0A=
patching file arch/um/sys-i386/util/mk_sc.c=0A=
patching file arch/um/sys-ia64/Makefile=0A=
patching file arch/um/sys-ppc/Makefile=0A=
patching file arch/um/uml.lds.S=0A=
patching file arch/um/util/Makefile=0A=
patching file arch/um/util/mk_constants_kern.c=0A=
patching file fs/hostfs/hostfs.h=0A=
patching file fs/hostfs/hostfs_kern.c=0A=
patching file fs/hostfs/hostfs_user.c=0A=
patching file fs/hostfs/Makefile=0A=
patching file fs/hppfs/hppfs_kern.c=0A=
patching file fs/hppfs/Makefile=0A=
patching file fs/Makefile=0A=
patching file include/asm-um/archparam-i386.h=0A=
patching file include/asm-um/common.lds.S=0A=
patching file include/asm-um/cpufeature.h=0A=
patching file include/asm-um/current.h=0A=
patching file include/asm-um/dma-mapping.h=0A=
patching file include/asm-um/elf.h=0A=
patching file include/asm-um/fixmap.h=0A=
patching file include/asm-um/irq.h=0A=
Hunk #1 succeeded at 7 with fuzz 1 (offset 6 lines).=0A=
Hunk #2 succeeded at 20 with fuzz 2 (offset 1 line).=0A=
patching file include/asm-um/local.h=0A=
patching file include/asm-um/module-generic.h=0A=
patching file include/asm-um/module-i386.h=0A=
patching file include/asm-um/page.h=0A=
patching file include/asm-um/pgtable.h=0A=
patching file include/asm-um/processor-generic.h=0A=
Hunk #4 succeeded at 91 (offset -2 lines).=0A=
patching file include/asm-um/processor-i386.h=0A=
patching file include/asm-um/sections.h=0A=
patching file include/asm-um/smp.h=0A=
patching file include/asm-um/smplock.h=0A=
patching file include/asm-um/spinlock.h=0A=
patching file include/asm-um/system-generic.h=0A=
patching file include/asm-um/thread_info.h=0A=
patching file include/asm-um/timex.h=0A=
patching file include/asm-um/uaccess.h=0A=
patching file include/asm-um/unistd.h=0A=
patching file include/linux/gfp.h=0A=
Hunk #1 succeeded at 69 (offset 6 lines).=0A=
patching file include/linux/ghash.h=0A=
patching file include/linux/mm.h=0A=
Hunk #1 succeeded at 503 with fuzz 2 (offset -2 lines).=0A=
Hunk #2 succeeded at 549 (offset 10 lines).=0A=
Hunk #3 succeeded at 562 (offset 10 lines).=0A=
patching file include/linux/proc_mm.h=0A=
patching file include/linux/time.h=0A=
patching file mm/Makefile=0A=
Hunk #1 succeeded at 14 (offset 2 lines).=0A=
patching file mm/mmap.c=0A=
Hunk #1 succeeded at 480 (offset 19 lines).=0A=
patching file mm/mprotect.c=0A=
Hunk #1 succeeded at 224 (offset 2 lines).=0A=
Hunk #2 succeeded at 248 (offset 2 lines).=0A=
Hunk #3 succeeded at 329 (offset 2 lines).=0A=
patching file mm/page_alloc.c=0A=
Hunk #1 succeeded at 278 (offset 10 lines).=0A=
Hunk #2 succeeded at 472 (offset 13 lines).=0A=
patching file mm/proc_mm.c=0A=
=0A=
uml1:/tmp/uml/linux-2.6.6-rc2 # cat ../patch.2.6.5-uml1.fix |patch -p1=0A=
patching file include/asm-i386/system.h=0A=
patching file arch/um/Makefile-i386=0A=
=0A=
uml1:/tmp/uml/linux-2.6.6-rc2 # make mrproper ARCH=3Dum=0A=
  CLEAN   include/asm-um/module.h include/asm-um/module.h=0A=
=0A=
uml1:/tmp/uml/linux-2.6.6-rc2 # cat ../patch.266rc1-1 |patch -p1      =0A=
patching file arch/um/kernel/Makefile=0A=
patching file arch/um/kernel/skas/process.c=0A=
patching file arch/um/kernel/process.c=0A=
patching file arch/um/util/mk_constants_kern.c=0A=
patching file arch/um/util/mk_task_kern.c=0A=
patching file arch/um/sys-i386/util/mk_thread_kern.c=0A=
patching file arch/um/kernel/physmem.c=0A=
patching file kernel/sched.c=0A=
=0A=
uml1:/tmp/uml/linux-2.6.6-rc2 # make menuconfig ARCH=3Dum=0A=
  HOSTCC  scripts/basic/fixdep=0A=
  HOSTCC  scripts/basic/split-include=0A=
  HOSTCC  scripts/basic/docproc=0A=
  SHIPPED scripts/kconfig/zconf.tab.h=0A=
  HOSTCC  scripts/kconfig/conf.o=0A=
  HOSTCC  scripts/kconfig/mconf.o=0A=
  SHIPPED scripts/kconfig/zconf.tab.c=0A=
  SHIPPED scripts/kconfig/lex.zconf.c=0A=
  HOSTCC  -fPIC scripts/kconfig/zconf.tab.o=0A=
  HOSTLLD -shared scripts/kconfig/libkconfig.so=0A=
  HOSTLD  scripts/kconfig/mconf=0A=
  HOSTCC  scripts/lxdialog/checklist.o=0A=
  HOSTCC  scripts/lxdialog/inputbox.o=0A=
  HOSTCC  scripts/lxdialog/lxdialog.o=0A=
  HOSTCC  scripts/lxdialog/menubox.o=0A=
  HOSTCC  scripts/lxdialog/msgbox.o=0A=
  HOSTCC  scripts/lxdialog/textbox.o=0A=
  HOSTCC  scripts/lxdialog/util.o=0A=
  HOSTCC  scripts/lxdialog/yesno.o=0A=
  HOSTLD  scripts/lxdialog/lxdialog=0A=
scripts/kconfig/mconf arch/um/Kconfig=0A=
#=0A=
# using defaults found in arch/um/defconfig=0A=
#=0A=
arch/um/defconfig:133: trying to assign nonexistent symbol INET_ECN=0A=
arch/um/defconfig:146: trying to assign nonexistent symbol IPV6_SCTP__=0A=
=0A=
=0A=
*** End of Linux kernel configuration.=0A=
*** Execute 'make' to build the kernel or try 'make help'.=0A=
=0A=
=0A=
=0A=
uml1:/tmp/uml/linux-2.6.6-rc2 # make linux ARCH=3Dum=0A=
  CHK     include/linux/version.h=0A=
  UPD     include/linux/version.h=0A=
  SYMLINK include/asm -> include/asm-um=0A=
  SPLIT   include/linux/autoconf.h -> include/config/*=0A=
  HOSTCC  arch/um/sys-i386/util/mk_sc=0A=
  HOSTCC  arch/um/kernel/skas/util/mk_ptregs=0A=
  Generating /tmp/uml/linux-2.6.6-rc2/arch/um/include/skas_ptregs.h =
(updated)=0A=
  CHK     arch/um/include/sysdep-i386/sc.h=0A=
  UPD     arch/um/include/sysdep-i386/sc.h=0A=
cd /tmp/uml/linux-2.6.6-rc2/include/asm-um && ln -sf ../asm-i386 arch=0A=
cd arch/um/include && ln -sf sysdep-i386 sysdep=0A=
cd arch/um && ln -sf os-Linux os=0A=
cd /tmp/uml/linux-2.6.6-rc2/include/asm-um/ ; \=0A=
ln -sf archparam-i386.h archparam.h=0A=
cd /tmp/uml/linux-2.6.6-rc2/include/asm-um/ ; \=0A=
ln -sf system-i386.h system.h=0A=
cd /tmp/uml/linux-2.6.6-rc2/include/asm-um/ ; \=0A=
ln -sf sigcontext-i386.h sigcontext.h=0A=
cd /tmp/uml/linux-2.6.6-rc2/include/asm-um/ ; \=0A=
ln -sf processor-i386.h processor.h=0A=
cd /tmp/uml/linux-2.6.6-rc2/include/asm-um/ ; \=0A=
ln -sf ptrace-i386.h ptrace.h=0A=
cd /tmp/uml/linux-2.6.6-rc2/include/asm-um/ ; \=0A=
ln -sf arch-signal-i386.h arch-signal.h=0A=
cd /tmp/uml/linux-2.6.6-rc2/include/asm-um/ ; \=0A=
ln -sf module-i386.h module.h=0A=
  CHK     arch/um/include/uml-config.h=0A=
  UPD     arch/um/include/uml-config.h=0A=
  HOSTCC  arch/um/util/mk_constants_kern.o=0A=
  HOSTCC  arch/um/util/mk_constants_user.o=0A=
  HOSTCC  arch/um/util/mk_task_kern.o=0A=
  HOSTCC  arch/um/util/mk_task_user.o=0A=
  HOSTLD  arch/um/util/mk_task=0A=
  HOSTLD  arch/um/util/mk_constants=0A=
  CHK     arch/um/include/task.h=0A=
  UPD     arch/um/include/task.h=0A=
  CHK     arch/um/include/kern_constants.h=0A=
  UPD     arch/um/include/kern_constants.h=0A=
  HOSTCC  arch/um/sys-i386/util/mk_thread_kern.o=0A=
  HOSTCC  arch/um/sys-i386/util/mk_thread_user.o=0A=
  HOSTLD  arch/um/sys-i386/util/mk_thread=0A=
CHK     arch/um/include/sysdep-i386/thread.h=0A=
  UPD     arch/um/include/sysdep-i386/thread.h=0A=
  HOSTCC  scripts/conmakehash=0A=
  HOSTCC  scripts/kallsyms=0A=
  CC      scripts/empty.o=0A=
  HOSTCC  scripts/mk_elfconfig=0A=
  MKELF   scripts/elfconfig.h=0A=
  HOSTCC  scripts/file2alias.o=0A=
  HOSTCC  scripts/modpost.o=0A=
  HOSTCC  scripts/sumversion.o=0A=
  HOSTLD  scripts/modpost=0A=
  HOSTCC  scripts/pnmtologo=0A=
  HOSTCC  scripts/bin2c=0A=
  CC      init/main.o=0A=
  CHK     include/linux/compile.h=0A=
  UPD     include/linux/compile.h=0A=
  CC      init/version.o=0A=
  CC      init/do_mounts.o=0A=
  CC      init/do_mounts_devfs.o=0A=
  CC      init/do_mounts_rd.o=0A=
  CC      init/do_mounts_initrd.o=0A=
 LD      init/mounts.o=0A=
  CC      init/initramfs.o=0A=
  LD      init/built-in.o=0A=
  HOSTCC  usr/gen_init_cpio=0A=
  CPIO    usr/initramfs_data.cpio=0A=
  GZIP    usr/initramfs_data.cpio.gz=0A=
  AS      usr/initramfs_data.o=0A=
  LD      usr/built-in.o=0A=
  CC      arch/um/kernel/checksum.o=0A=
  QUOTE arch/um/kernel/config.c=0A=
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=3D\"i386\" =
-D_LARGEFILE64_SOURCE   -Iarch/um/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/tt/include =
-I/tmp/uml/linux-2.6.6-rc2/arch/um/kernel/skas/include -D_GNU_SOURCE -O2 =
-g -c -o arch/um/kernel/config.o arch/um/kernel/config.c=0A=
arch/um/kernel/config.c:10:34: missing terminating " character=0A=
arch/um/kernel/config.c:11:3: invalid preprocessing directive =
#Automatically=0A=
arch/um/kernel/config.c:11:43: missing terminating ' character=0A=
arch/um/kernel/config.c:13: error: parse error before "CONFIG_USERMODE"=0A=
arch/um/kernel/config.c:19:3: invalid preprocessing directive #UML=0A=
arch/um/kernel/config.c:30:3: invalid preprocessing directive =
#CONFIG_HOST_2G_2G=0A=
arch/um/kernel/config.c:31:3: invalid preprocessing directive =
#CONFIG_UML_SMP=0A=
arch/um/kernel/config.c:32:3: invalid preprocessing directive #CONFIG_SMP=0A=
arch/um/kernel/config.c:35:3: invalid preprocessing directive =
#CONFIG_HIGHMEM=0A=
arch/um/kernel/config.c:41:3: invalid preprocessing directive #Code=0A=
arch/um/kernel/config.c:49:3: invalid preprocessing directive #General=0A=
arch/um/kernel/config.c:53:3: invalid preprocessing directive =
#CONFIG_POSIX_MQUEUE=0A=
arch/um/kernel/config.c:56:3: invalid preprocessing directive =
#CONFIG_AUDIT=0A=
arch/um/kernel/config.c:58:3: invalid preprocessing directive =
#CONFIG_HOTPLUG=0A=
arch/um/kernel/config.c:59:3: invalid preprocessing directive =
#CONFIG_IKCONFIG=0A=
arch/um/kernel/config.c:60:3: invalid preprocessing directive =
#CONFIG_EMBEDDED=0A=
arch/um/kernel/config.c:68:3: invalid preprocessing directive =
#CONFIG_CC_OPTIMIZE_FOR_SIZE=0A=
arch/um/kernel/config.c:71:3: invalid preprocessing directive #Loadable=0A=
arch/um/kernel/config.c:73:3: invalid preprocessing directive =
#CONFIG_MODULES=0A=
arch/um/kernel/config.c:76:3: invalid preprocessing directive #Generic=0A=
arch/um/kernel/config.c:80:3: invalid preprocessing directive #Character=0A=
arch/um/kernel/config.c:90: error: stray '\' in program=0A=
arch/um/kernel/config.c:90:23: missing terminating " character=0A=
arch/um/kernel/config.c:91: error: stray '\' in program=0A=
arch/um/kernel/config.c:91:18: missing terminating " character=0A=
arch/um/kernel/config.c:92: error: stray '\' in program=0A=
arch/um/kernel/config.c:92:18: missing terminating " character=0A=
arch/um/kernel/config.c:95:3: invalid preprocessing directive =
#CONFIG_WATCHDOG=0A=
arch/um/kernel/config.c:101:3: invalid preprocessing directive #Block=0A=
arch/um/kernel/config.c:104:3: invalid preprocessing directive =
#CONFIG_BLK_DEV_UBD_SYNC=0A=
arch/um/kernel/config.c:111:3: invalid preprocessing directive =
#CONFIG_MMAPPER=0A=
arch/um/kernel/config.c:115:3: invalid preprocessing directive #UML=0A=
arch/um/kernel/config.c:123:3: invalid preprocessing directive =
#CONFIG_UML_NET_PCAP=0A=
arch/um/kernel/config.c:127:3: invalid preprocessing directive =
#Networking=0A=
arch/um/kernel/config.c:131:3: invalid preprocessing directive =
#Networking=0A=
arch/um/kernel/config.c:135:3: invalid preprocessing directive =
#CONFIG_NETLINK_DEV=0A=
arch/um/kernel/config.c:137:3: invalid preprocessing directive =
#CONFIG_NET_KEY=0A=
arch/um/kernel/config.c:139:3: invalid preprocessing directive =
#CONFIG_IP_MULTICAST=0A=
arch/um/kernel/config.c:140:3: invalid preprocessing directive =
#CONFIG_IP_ADVANCED_ROUTER=0A=
arch/um/kernel/config.c:141:3: invalid preprocessing directive =
#CONFIG_IP_PNP=0A=
arch/um/kernel/config.c:142:3: invalid preprocessing directive =
#CONFIG_NET_IPIP=0A=
arch/um/kernel/config.c:143:3: invalid preprocessing directive =
#CONFIG_NET_IPGRE=0A=
arch/um/kernel/config.c:144:3: invalid preprocessing directive =
#CONFIG_ARPD=0A=
arch/um/kernel/config.c:145:3: invalid preprocessing directive =
#CONFIG_SYN_COOKIES=0A=
arch/um/kernel/config.c:146:3: invalid preprocessing directive =
#CONFIG_INET_AH=0A=
arch/um/kernel/config.c:147:3: invalid preprocessing directive =
#CONFIG_INET_ESP=0A=
arch/um/kernel/config.c:148:3: invalid preprocessing directive =
#CONFIG_INET_IPCOMP=0A=
arch/um/kernel/config.c:149:3: invalid preprocessing directive =
#CONFIG_IPV6=0A=
arch/um/kernel/config.c:150:3: invalid preprocessing directive =
#CONFIG_NETFILTER=0A=
arch/um/kernel/config.c:153:3: invalid preprocessing directive #SCTP=0A=
arch/um/kernel/config.c:155:3: invalid preprocessing directive =
#CONFIG_IP_SCTP=0A=
arch/um/kernel/config.c:156:3: invalid preprocessing directive =
#CONFIG_ATM=0A=
arch/um/kernel/config.c:157:3: invalid preprocessing directive =
#CONFIG_BRIDGE=0A=
arch/um/kernel/config.c:158:3: invalid preprocessing directive =
#CONFIG_VLAN_8021Q=0A=
arch/um/kernel/config.c:159:3: invalid preprocessing directive =
#CONFIG_DECNET=0A=
arch/um/kernel/config.c:160:3: invalid preprocessing directive =
#CONFIG_LLC2=0A=
arch/um/kernel/config.c:161:3: invalid preprocessing directive =
#CONFIG_IPX=0A=
arch/um/kernel/config.c:162:3: invalid preprocessing directive =
#CONFIG_ATALK=0A=
arch/um/kernel/config.c:163:3: invalid preprocessing directive =
#CONFIG_X25=0A=
arch/um/kernel/config.c:164:3: invalid preprocessing directive =
#CONFIG_LAPB=0A=
arch/um/kernel/config.c:165:3: invalid preprocessing directive =
#CONFIG_NET_DIVERT=0A=
arch/um/kernel/config.c:166:3: invalid preprocessing directive =
#CONFIG_ECONET=0A=
arch/um/kernel/config.c:167:3: invalid preprocessing directive =
#CONFIG_WAN_ROUTER=0A=
arch/um/kernel/config.c:168:3: invalid preprocessing directive =
#CONFIG_NET_FASTROUTE=0A=
arch/um/kernel/config.c:169:3: invalid preprocessing directive =
#CONFIG_NET_HW_FLOWCONTROL=0A=
arch/um/kernel/config.c:172:3: invalid preprocessing directive #QoS=0A=
arch/um/kernel/config.c:174:3: invalid preprocessing directive =
#CONFIG_NET_SCHED=0A=
arch/um/kernel/config.c:177:3: invalid preprocessing directive #Network=0A=
arch/um/kernel/config.c:179:3: invalid preprocessing directive =
#CONFIG_NET_PKTGEN=0A=
arch/um/kernel/config.c:180:3: invalid preprocessing directive =
#CONFIG_NETPOLL=0A=
arch/um/kernel/config.c:181:3: invalid preprocessing directive =
#CONFIG_NET_POLL_CONTROLLER=0A=
arch/um/kernel/config.c:182:3: invalid preprocessing directive =
#CONFIG_HAMRADIO=0A=
arch/um/kernel/config.c:183:3: invalid preprocessing directive =
#CONFIG_IRDA=0A=
arch/um/kernel/config.c:184:3: invalid preprocessing directive #CONFIG_BT=0A=
arch/um/kernel/config.c:186:3: invalid preprocessing directive =
#CONFIG_BONDING=0A=
arch/um/kernel/config.c:187:3: invalid preprocessing directive =
#CONFIG_EQUALIZER=0A=
arch/um/kernel/config.c:191:3: invalid preprocessing directive #Ethernet=0A=
arch/um/kernel/config.c:193:3: invalid preprocessing directive =
#CONFIG_NET_ETHERNET=0A=
arch/um/kernel/config.c:196:3: invalid preprocessing directive #Ethernet=0A=
arch/um/kernel/config.c:200:3: invalid preprocessing directive #Ethernet=0A=
arch/um/kernel/config.c:204:3: invalid preprocessing directive #Token=0A=
arch/um/kernel/config.c:208:3: invalid preprocessing directive #Wireless=0A=
arch/um/kernel/config.c:210:3: invalid preprocessing directive =
#CONFIG_NET_RADIO=0A=
arch/um/kernel/config.c:213:3: invalid preprocessing directive #Wan=0A=
arch/um/kernel/config.c:215:3: invalid preprocessing directive =
#CONFIG_WAN=0A=
arch/um/kernel/config.c:217:3: invalid preprocessing directive =
#CONFIG_PPP_MULTILINK=0A=
arch/um/kernel/config.c:218:3: invalid preprocessing directive =
#CONFIG_PPP_FILTER=0A=
arch/um/kernel/config.c:219:3: invalid preprocessing directive =
#CONFIG_PPP_ASYNC=0A=
arch/um/kernel/config.c:220:3: invalid preprocessing directive =
#CONFIG_PPP_SYNC_TTY=0A=
arch/um/kernel/config.c:221:3: invalid preprocessing directive =
#CONFIG_PPP_DEFLATE=0A=
arch/um/kernel/config.c:222:3: invalid preprocessing directive =
#CONFIG_PPP_BSDCOMP=0A=
arch/um/kernel/config.c:223:3: invalid preprocessing directive =
#CONFIG_PPPOE=0A=
arch/um/kernel/config.c:225:3: invalid preprocessing directive =
#CONFIG_SLIP_COMPRESSED=0A=
arch/um/kernel/config.c:226:3: invalid preprocessing directive =
#CONFIG_SLIP_SMART=0A=
arch/um/kernel/config.c:227:3: invalid preprocessing directive =
#CONFIG_SLIP_MODE_SLIP6=0A=
arch/um/kernel/config.c:228:3: invalid preprocessing directive =
#CONFIG_SHAPER=0A=
arch/um/kernel/config.c:229:3: invalid preprocessing directive =
#CONFIG_NETCONSOLE=0A=
arch/um/kernel/config.c:232:3: invalid preprocessing directive #File=0A=
arch/um/kernel/config.c:235:3: invalid preprocessing directive =
#CONFIG_EXT2_FS_XATTR=0A=
arch/um/kernel/config.c:236:3: invalid preprocessing directive =
#CONFIG_EXT3_FS=0A=
arch/um/kernel/config.c:237:3: invalid preprocessing directive =
#CONFIG_JBD=0A=
arch/um/kernel/config.c:239:3: invalid preprocessing directive =
#CONFIG_REISERFS_CHECK=0A=
arch/um/kernel/config.c:240:3: invalid preprocessing directive =
#CONFIG_REISERFS_PROC_INFO=0A=
arch/um/kernel/config.c:241:3: invalid preprocessing directive =
#CONFIG_JFS_FS=0A=
arch/um/kernel/config.c:242:3: invalid preprocessing directive =
#CONFIG_XFS_FS=0A=
arch/um/kernel/config.c:244:3: invalid preprocessing directive =
#CONFIG_ROMFS_FS=0A=
arch/um/kernel/config.c:246:3: invalid preprocessing directive =
#CONFIG_QFMT_V1=0A=
arch/um/kernel/config.c:247:3: invalid preprocessing directive =
#CONFIG_QFMT_V2=0A=
arch/um/kernel/config.c:253:3: invalid preprocessing directive #CD=0A=
arch/um/kernel/config.c:256:3: invalid preprocessing directive =
#CONFIG_JOLIET=0A=
arch/um/kernel/config.c:257:3: invalid preprocessing directive =
#CONFIG_ZISOFS=0A=
arch/um/kernel/config.c:258:3: invalid preprocessing directive =
#CONFIG_UDF_FS=0A=
arch/um/kernel/config.c:261:3: invalid preprocessing directive #DOS=0A=
arch/um/kernel/config.c:266:3: invalid preprocessing directive =
#CONFIG_NTFS_FS=0A=
arch/um/kernel/config.c:269:3: invalid preprocessing directive #Pseudo=0A=
arch/um/kernel/config.c:276:3: invalid preprocessing directive =
#CONFIG_DEVFS_DEBUG=0A=
arch/um/kernel/config.c:277:3: invalid preprocessing directive =
#CONFIG_DEVPTS_FS_XATTR=0A=
arch/um/kernel/config.c:279:3: invalid preprocessing directive =
#CONFIG_HUGETLB_PAGE=0A=
arch/um/kernel/config.c:283:3: invalid preprocessing directive =
#Miscellaneous=0A=
arch/um/kernel/config.c:285:3: invalid preprocessing directive =
#CONFIG_ADFS_FS=0A=
arch/um/kernel/config.c:286:3: invalid preprocessing directive =
#CONFIG_AFFS_FS=0A=
arch/um/kernel/config.c:287:3: invalid preprocessing directive =
#CONFIG_HFS_FS=0A=
arch/um/kernel/config.c:288:3: invalid preprocessing directive =
#CONFIG_HFSPLUS_FS=0A=
arch/um/kernel/config.c:289:3: invalid preprocessing directive =
#CONFIG_BEFS_FS=0A=
arch/um/kernel/config.c:290:3: invalid preprocessing directive =
#CONFIG_BFS_FS=0A=
arch/um/kernel/config.c:291:3: invalid preprocessing directive =
#CONFIG_EFS_FS=0A=
arch/um/kernel/config.c:294:3: invalid preprocessing directive =
#CONFIG_JFFS2_FS=0A=
arch/um/kernel/config.c:295:3: invalid preprocessing directive =
#CONFIG_CRAMFS=0A=
arch/um/kernel/config.c:296:3: invalid preprocessing directive =
#CONFIG_VXFS_FS=0A=
arch/um/kernel/config.c:297:3: invalid preprocessing directive =
#CONFIG_HPFS_FS=0A=
arch/um/kernel/config.c:298:3: invalid preprocessing directive =
#CONFIG_QNX4FS_FS=0A=
arch/um/kernel/config.c:299:3: invalid preprocessing directive =
#CONFIG_SYSV_FS=0A=
arch/um/kernel/config.c:300:3: invalid preprocessing directive =
#CONFIG_UFS_FS=0A=
arch/um/kernel/config.c:303:3: invalid preprocessing directive #Network=0A=
arch/um/kernel/config.c:305:3: invalid preprocessing directive =
#CONFIG_NFS_FS=0A=
arch/um/kernel/config.c:306:3: invalid preprocessing directive =
#CONFIG_NFSD=0A=
arch/um/kernel/config.c:307:3: invalid preprocessing directive =
#CONFIG_EXPORTFS=0A=
arch/um/kernel/config.c:308:3: invalid preprocessing directive =
#CONFIG_SMB_FS=0A=
arch/um/kernel/config.c:309:3: invalid preprocessing directive =
#CONFIG_CIFS=0A=
arch/um/kernel/config.c:310:3: invalid preprocessing directive =
#CONFIG_NCP_FS=0A=
arch/um/kernel/config.c:311:3: invalid preprocessing directive =
#CONFIG_CODA_FS=0A=
arch/um/kernel/config.c:312:3: invalid preprocessing directive =
#CONFIG_INTERMEZZO_FS=0A=
arch/um/kernel/config.c:313:3: invalid preprocessing directive =
#CONFIG_AFS_FS=0A=
arch/um/kernel/config.c:316:3: invalid preprocessing directive #Partition=0A=
arch/um/kernel/config.c:318:3: invalid preprocessing directive =
#CONFIG_PARTITION_ADVANCED=0A=
arch/um/kernel/config.c:322:3: invalid preprocessing directive #Native=0A=
arch/um/kernel/config.c:325: error: stray '\' in program=0A=
arch/um/kernel/config.c:325:21: missing terminating " character=0A=
arch/um/kernel/config.c:326:3: invalid preprocessing directive =
#CONFIG_NLS_CODEPAGE_437=0A=
arch/um/kernel/config.c:327:3: invalid preprocessing directive =
#CONFIG_NLS_CODEPAGE_737=0A=
arch/um/kernel/config.c:328:3: invalid preprocessing directive =
#CONFIG_NLS_CODEPAGE_775=0A=
arch/um/kernel/config.c:329:3: invalid preprocessing directive =
#CONFIG_NLS_CODEPAGE_850=0A=
arch/um/kernel/config.c:330:3: invalid preprocessing directive =
#CONFIG_NLS_CODEPAGE_852=0A=
arch/um/kernel/config.c:331:3: invalid preprocessing directive =
#CONFIG_NLS_CODEPAGE_855=0A=
arch/um/kernel/config.c:332:3: invalid preprocessing directive =
#CONFIG_NLS_CODEPAGE_857=0A=
arch/um/kernel/config.c:333:3: invalid preprocessing directive =
#CONFIG_NLS_CODEPAGE_860=0A=
arch/um/kernel/config.c:334:3: invalid preprocessing directive =
#CONFIG_NLS_CODEPAGE_861=0A=
arch/um/kernel/config.c:335:3: invalid preprocessing directive =
#CONFIG_NLS_CODEPAGE_862=0A=
arch/um/kernel/config.c:336:3: invalid preprocessing directive =
#CONFIG_NLS_CODEPAGE_863=0A=
arch/um/kernel/config.c:337:3: invalid preprocessing directive =
#CONFIG_NLS_CODEPAGE_864=0A=
arch/um/kernel/config.c:338:3: invalid preprocessing directive =
#CONFIG_NLS_CODEPAGE_865=0A=
arch/um/kernel/config.c:339:3: invalid preprocessing directive =
#CONFIG_NLS_CODEPAGE_866=0A=
arch/um/kernel/config.c:340:3: invalid preprocessing directive =
#CONFIG_NLS_CODEPAGE_869=0A=
arch/um/kernel/config.c:341:3: invalid preprocessing directive =
#CONFIG_NLS_CODEPAGE_936=0A=
arch/um/kernel/config.c:342:3: invalid preprocessing directive =
#CONFIG_NLS_CODEPAGE_950=0A=
arch/um/kernel/config.c:343:3: invalid preprocessing directive =
#CONFIG_NLS_CODEPAGE_932=0A=
arch/um/kernel/config.c:344:3: invalid preprocessing directive =
#CONFIG_NLS_CODEPAGE_949=0A=
arch/um/kernel/config.c:345:3: invalid preprocessing directive =
#CONFIG_NLS_CODEPAGE_874=0A=
arch/um/kernel/config.c:346:3: invalid preprocessing directive =
#CONFIG_NLS_ISO8859_8=0A=
arch/um/kernel/config.c:347:3: invalid preprocessing directive =
#CONFIG_NLS_CODEPAGE_1250=0A=
arch/um/kernel/config.c:348:3: invalid preprocessing directive =
#CONFIG_NLS_CODEPAGE_1251=0A=
arch/um/kernel/config.c:349:3: invalid preprocessing directive =
#CONFIG_NLS_ISO8859_1=0A=
arch/um/kernel/config.c:350:3: invalid preprocessing directive =
#CONFIG_NLS_ISO8859_2=0A=
arch/um/kernel/config.c:351:3: invalid preprocessing directive =
#CONFIG_NLS_ISO8859_3=0A=
arch/um/kernel/config.c:352:3: invalid preprocessing directive =
#CONFIG_NLS_ISO8859_4=0A=
arch/um/kernel/config.c:353:3: invalid preprocessing directive =
#CONFIG_NLS_ISO8859_5=0A=
arch/um/kernel/config.c:354:3: invalid preprocessing directive =
#CONFIG_NLS_ISO8859_6=0A=
arch/um/kernel/config.c:355:3: invalid preprocessing directive =
#CONFIG_NLS_ISO8859_7=0A=
arch/um/kernel/config.c:356:3: invalid preprocessing directive =
#CONFIG_NLS_ISO8859_9=0A=
arch/um/kernel/config.c:357:3: invalid preprocessing directive =
#CONFIG_NLS_ISO8859_13=0A=
arch/um/kernel/config.c:358:3: invalid preprocessing directive =
#CONFIG_NLS_ISO8859_14=0A=
arch/um/kernel/config.c:359:3: invalid preprocessing directive =
#CONFIG_NLS_ISO8859_15=0A=
arch/um/kernel/config.c:360:3: invalid preprocessing directive =
#CONFIG_NLS_KOI8_R=0A=
arch/um/kernel/config.c:361:3: invalid preprocessing directive =
#CONFIG_NLS_KOI8_U=0A=
arch/um/kernel/config.c:362:3: invalid preprocessing directive =
#CONFIG_NLS_UTF8=0A=
arch/um/kernel/config.c:365:3: invalid preprocessing directive #Security=0A=
arch/um/kernel/config.c:367:3: invalid preprocessing directive =
#CONFIG_SECURITY=0A=
arch/um/kernel/config.c:370:3: invalid preprocessing directive =
#Cryptographic=0A=
arch/um/kernel/config.c:372:3: invalid preprocessing directive =
#CONFIG_CRYPTO=0A=
arch/um/kernel/config.c:375:3: invalid preprocessing directive #Library=0A=
arch/um/kernel/config.c:377:3: invalid preprocessing directive =
#CONFIG_CRC32=0A=
arch/um/kernel/config.c:380:3: invalid preprocessing directive #SCSI=0A=
arch/um/kernel/config.c:382:3: invalid preprocessing directive =
#CONFIG_SCSI=0A=
arch/um/kernel/config.c:385:3: invalid preprocessing directive #Multi=0A=
arch/um/kernel/config.c:387:3: invalid preprocessing directive #CONFIG_MD=0A=
arch/um/kernel/config.c:390:3: invalid preprocessing directive #Memory=0A=
arch/um/kernel/config.c:393:3: invalid preprocessing directive =
#CONFIG_MTD_DEBUG=0A=
arch/um/kernel/config.c:394:3: invalid preprocessing directive =
#CONFIG_MTD_PARTITIONS=0A=
arch/um/kernel/config.c:395:3: invalid preprocessing directive =
#CONFIG_MTD_CONCAT=0A=
arch/um/kernel/config.c:398:3: invalid preprocessing directive #User=0A=
arch/um/kernel/config.c:402:3: invalid preprocessing directive =
#CONFIG_FTL=0A=
arch/um/kernel/config.c:403:3: invalid preprocessing directive =
#CONFIG_NFTL=0A=
arch/um/kernel/config.c:404:3: invalid preprocessing directive =
#CONFIG_INFTL=0A=
arch/um/kernel/config.c:407:3: invalid preprocessing directive #RAM=0A=
arch/um/kernel/config.c:409:3: invalid preprocessing directive =
#CONFIG_MTD_CFI=0A=
arch/um/kernel/config.c:410:3: invalid preprocessing directive =
#CONFIG_MTD_JEDECPROBE=0A=
arch/um/kernel/config.c:411:3: invalid preprocessing directive =
#CONFIG_MTD_RAM=0A=
arch/um/kernel/config.c:412:3: invalid preprocessing directive =
#CONFIG_MTD_ROM=0A=
arch/um/kernel/config.c:413:3: invalid preprocessing directive =
#CONFIG_MTD_ABSENT=0A=
arch/um/kernel/config.c:414:3: invalid preprocessing directive =
#CONFIG_MTD_OBSOLETE_CHIPS=0A=
arch/um/kernel/config.c:417:3: invalid preprocessing directive #Mapping=0A=
arch/um/kernel/config.c:419:3: invalid preprocessing directive =
#CONFIG_MTD_COMPLEX_MAPPINGS=0A=
arch/um/kernel/config.c:422:3: invalid preprocessing directive #Self=0A=
arch/um/kernel/config.c:424:3: invalid preprocessing directive =
#CONFIG_MTD_SLRAM=0A=
arch/um/kernel/config.c:425:3: invalid preprocessing directive =
#CONFIG_MTD_MTDRAM=0A=
arch/um/kernel/config.c:429:3: invalid preprocessing directive #Disk=0A=
arch/um/kernel/config.c:431:3: invalid preprocessing directive =
#CONFIG_MTD_DOC2000=0A=
arch/um/kernel/config.c:432:3: invalid preprocessing directive =
#CONFIG_MTD_DOC2001=0A=
arch/um/kernel/config.c:433:3: invalid preprocessing directive =
#CONFIG_MTD_DOC2001PLUS=0A=
arch/um/kernel/config.c:436:3: invalid preprocessing directive #NAND=0A=
arch/um/kernel/config.c:438:3: invalid preprocessing directive =
#CONFIG_MTD_NAND=0A=
arch/um/kernel/config.c:441:3: invalid preprocessing directive #Kernel=0A=
arch/um/kernel/config.c:443:3: invalid preprocessing directive =
#CONFIG_DEBUG_SLAB=0A=
arch/um/kernel/config.c:444:3: invalid preprocessing directive =
#CONFIG_DEBUG_SPINLOCK=0A=
arch/um/kernel/config.c:448:3: invalid preprocessing directive =
#CONFIG_GPROF=0A=
arch/um/kernel/config.c:449:3: invalid preprocessing directive =
#CONFIG_GCOV=0A=
arch/um/kernel/config.c:450:1: missing terminating " character=0A=
arch/um/kernel/config.c:455: error: parse error before numeric constant=0A=
arch/um/kernel/config.c:455: warning: type defaults to `int' in =
declaration of `exit'=0A=
arch/um/kernel/config.c:455: warning: function declaration isn't a =
prototype=0A=
arch/um/kernel/config.c:455: error: conflicting types for `exit'=0A=
/usr/include/stdlib.h:612: error: previous declaration of `exit'=0A=
arch/um/kernel/config.c:455: warning: data definition has no type or =
storage class=0A=
arch/um/kernel/config.c:461: error: `print_config' undeclared here (not =
in a function)=0A=
arch/um/kernel/config.c:461: error: initializer element is not constant=0A=
arch/um/kernel/config.c:461: error: (near initialization for =
`__uml_setup_print_config.setup_func')=0A=
arch/um/kernel/config.c:10: warning: `config' defined but not used=0A=
make[1]: *** [arch/um/kernel/config.o] Error 1=0A=
make: *** [arch/um/kernel] Error 2=0A=
=0A=
=0A=

------=_NextPart_000_08BC_01C4280C.4860AB70--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
