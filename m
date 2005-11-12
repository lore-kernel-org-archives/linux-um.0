Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eb4Ik-0006XU-Ek for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Nov 2005 14:56:50 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Eb4Ij-0004gq-7N
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Nov 2005 14:56:50 -0800
Received: from localhost.localdomain (localhost [127.0.0.1])
	by grelber.thyrsus.com (8.13.4/8.13.4) with ESMTP id jAD0U8mt018983
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 12 Nov 2005 19:30:12 -0500
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dMndDuL3/Ow7LAQ"
Message-Id: <200511121656.29445.rob@landley.net>
Subject: [uml-devel] No surprise that 2.6.15-rc1 doesn't build?
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
Date: Sat, 12 Nov 2005 16:56:29 -0600
To: user-mode-linux-devel@lists.sourceforge.net

--Boundary-00=_dMndDuL3/Ow7LAQ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Linus says if we're going to test something, test -rc1, so I did.

It went boing.

I'm still trying to get -skas0 working on x86-64, but this was a standard x86 
build...

Rob

--Boundary-00=_dMndDuL3/Ow7LAQ
Content-Type: text/plain;
  charset="us-ascii";
  name="out.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="out.txt"

  CHK     arch/um/include/uml-config.h
  UPD     arch/um/include/uml-config.h
gcc -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestanding -O2 -fomit-frame-pointer -D__arch_um__ -DSUBARCH=\"i386\" -Dvmap=kernel_vmap -Din6addr_loopback=kernel_in6addr_loopback -Iarch/um/include  -D_FILE_OFFSET_BITS=64 -march=i686 -mpreferred-stack-boundary=2 -D_GNU_SOURCE -D_LARGEFILE64_SOURCE -S -o arch/um/user-offsets.s arch/um/sys-i386/user-offsets.c
  CHK     arch/um/include/user_constants.h
  UPD     arch/um/include/user_constants.h
  CHK     include/linux/version.h
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/split-include
  HOSTCC  scripts/basic/docproc
  SPLIT   include/linux/autoconf.h -> include/config/*
gcc -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestanding -O2     -fomit-frame-pointer  -D__arch_um__ -DSUBARCH=\"i386\" -Iarch/um/include  -Dvmap=kernel_vmap -Din6addr_loopback=kernel_in6addr_loopback -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask  -U__i386__ -Ui386 -march=i686 -mpreferred-stack-boundary=2 -D_LARGEFILE64_SOURCE    -nostdinc -isystem /usr/lib/gcc-lib/i486-linux/3.3.5/include -D__KERNEL__ -Iinclude  -include include/linux/autoconf.h -S -o arch/um/kernel-offsets.s arch/um/sys-i386/kernel-offsets.c
  CHK     arch/um/include/kern_constants.h
  UPD     arch/um/include/kern_constants.h
  CC      arch/um/kernel/asm-offsets.s
  GEN     include/asm-um/asm-offsets.h
  HOSTCC  scripts/kallsyms
  CC      init/main.o
In file included from include/asm/uaccess.h:33,
                 from include/asm/unistd.h:11,
                 from include/linux/unistd.h:9,
                 from init/main.c:46:
arch/um/include/um_uaccess.h: In function `copy_from_user':
arch/um/include/um_uaccess.h:25: warning: implicit declaration of function `CHOOSE_MODE'
arch/um/include/um_uaccess.h:25: warning: implicit declaration of function `copy_from_user_tt'
arch/um/include/um_uaccess.h:25: warning: implicit declaration of function `copy_from_user_skas'
arch/um/include/um_uaccess.h: In function `copy_to_user':
arch/um/include/um_uaccess.h:31: warning: implicit declaration of function `copy_to_user_tt'
arch/um/include/um_uaccess.h:31: warning: implicit declaration of function `copy_to_user_skas'
arch/um/include/um_uaccess.h: In function `strncpy_from_user':
arch/um/include/um_uaccess.h:56: warning: implicit declaration of function `strncpy_from_user_tt'
arch/um/include/um_uaccess.h:56: warning: implicit declaration of function `strncpy_from_user_skas'
arch/um/include/um_uaccess.h: In function `__clear_user':
arch/um/include/um_uaccess.h:73: warning: implicit declaration of function `__clear_user_tt'
arch/um/include/um_uaccess.h:73: warning: implicit declaration of function `__clear_user_skas'
arch/um/include/um_uaccess.h: In function `clear_user':
arch/um/include/um_uaccess.h:88: warning: implicit declaration of function `clear_user_tt'
arch/um/include/um_uaccess.h:88: warning: implicit declaration of function `clear_user_skas'
arch/um/include/um_uaccess.h: In function `strnlen_user':
arch/um/include/um_uaccess.h:104: warning: implicit declaration of function `strnlen_user_tt'
arch/um/include/um_uaccess.h:104: warning: implicit declaration of function `strnlen_user_skas'
In file included from include/asm/checksum.h:4,
                 from include/net/checksum.h:26,
                 from include/linux/skbuff.h:31,
                 from include/linux/if_ether.h:109,
                 from include/linux/netdevice.h:29,
                 from include/net/sock.h:48,
                 from init/main.c:50:
arch/um/include/sysdep/checksum.h: In function `csum_and_copy_to_user':
arch/um/include/sysdep/checksum.h:198: warning: implicit declaration of function `access_ok_tt'
arch/um/include/sysdep/checksum.h:198: warning: implicit declaration of function `access_ok_skas'
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  CC      init/do_mounts.o
In file included from include/asm/uaccess.h:33,
                 from include/linux/pagemap.h:12,
                 from include/linux/nfs_fs.h:15,
                 from init/do_mounts.c:12:
arch/um/include/um_uaccess.h: In function `copy_from_user':
arch/um/include/um_uaccess.h:25: warning: implicit declaration of function `CHOOSE_MODE'
arch/um/include/um_uaccess.h:25: warning: implicit declaration of function `copy_from_user_tt'
arch/um/include/um_uaccess.h:25: warning: implicit declaration of function `copy_from_user_skas'
arch/um/include/um_uaccess.h: In function `copy_to_user':
arch/um/include/um_uaccess.h:31: warning: implicit declaration of function `copy_to_user_tt'
arch/um/include/um_uaccess.h:31: warning: implicit declaration of function `copy_to_user_skas'
arch/um/include/um_uaccess.h: In function `strncpy_from_user':
arch/um/include/um_uaccess.h:56: warning: implicit declaration of function `strncpy_from_user_tt'
arch/um/include/um_uaccess.h:56: warning: implicit declaration of function `strncpy_from_user_skas'
arch/um/include/um_uaccess.h: In function `__clear_user':
arch/um/include/um_uaccess.h:73: warning: implicit declaration of function `__clear_user_tt'
arch/um/include/um_uaccess.h:73: warning: implicit declaration of function `__clear_user_skas'
arch/um/include/um_uaccess.h: In function `clear_user':
arch/um/include/um_uaccess.h:88: warning: implicit declaration of function `clear_user_tt'
arch/um/include/um_uaccess.h:88: warning: implicit declaration of function `clear_user_skas'
arch/um/include/um_uaccess.h: In function `strnlen_user':
arch/um/include/um_uaccess.h:104: warning: implicit declaration of function `strnlen_user_tt'
arch/um/include/um_uaccess.h:104: warning: implicit declaration of function `strnlen_user_skas'
  LD      init/mounts.o
  CC      init/initramfs.o
  CC      init/calibrate.o
  LD      init/built-in.o
  HOSTCC  usr/gen_init_cpio
  CHK     usr/initramfs_list
  UPD     usr/initramfs_list
  CPIO    usr/initramfs_data.cpio
  GZIP    usr/initramfs_data.cpio.gz
  AS      usr/initramfs_data.o
  LD      usr/built-in.o
  QUOTE   arch/um/kernel/config.tmp
  QUOTE   arch/um/kernel/config.c
  CC      arch/um/kernel/config.o
  CC      arch/um/kernel/exec_kern.o
In file included from include/asm/uaccess.h:33,
                 from arch/um/kernel/exec_kern.c:12:
arch/um/include/um_uaccess.h: In function `copy_from_user':
arch/um/include/um_uaccess.h:25: warning: implicit declaration of function `CHOOSE_MODE'
arch/um/include/um_uaccess.h:25: warning: implicit declaration of function `copy_from_user_tt'
arch/um/include/um_uaccess.h:25: warning: implicit declaration of function `copy_from_user_skas'
arch/um/include/um_uaccess.h: In function `copy_to_user':
arch/um/include/um_uaccess.h:31: warning: implicit declaration of function `copy_to_user_tt'
arch/um/include/um_uaccess.h:31: warning: implicit declaration of function `copy_to_user_skas'
arch/um/include/um_uaccess.h: In function `strncpy_from_user':
arch/um/include/um_uaccess.h:56: warning: implicit declaration of function `strncpy_from_user_tt'
arch/um/include/um_uaccess.h:56: warning: implicit declaration of function `strncpy_from_user_skas'
arch/um/include/um_uaccess.h: In function `__clear_user':
arch/um/include/um_uaccess.h:73: warning: implicit declaration of function `__clear_user_tt'
arch/um/include/um_uaccess.h:73: warning: implicit declaration of function `__clear_user_skas'
arch/um/include/um_uaccess.h: In function `clear_user':
arch/um/include/um_uaccess.h:88: warning: implicit declaration of function `clear_user_tt'
arch/um/include/um_uaccess.h:88: warning: implicit declaration of function `clear_user_skas'
arch/um/include/um_uaccess.h: In function `strnlen_user':
arch/um/include/um_uaccess.h:104: warning: implicit declaration of function `strnlen_user_tt'
arch/um/include/um_uaccess.h:104: warning: implicit declaration of function `strnlen_user_skas'
arch/um/kernel/exec_kern.c: In function `flush_thread':
arch/um/kernel/exec_kern.c:26: warning: implicit declaration of function `flush_thread_tt'
arch/um/kernel/exec_kern.c:26: warning: implicit declaration of function `flush_thread_skas'
arch/um/kernel/exec_kern.c: In function `start_thread':
arch/um/kernel/exec_kern.c:31: warning: implicit declaration of function `start_thread_tt'
arch/um/kernel/exec_kern.c:31: warning: implicit declaration of function `start_thread_skas'
  CC      arch/um/kernel/exitcode.o
In file included from include/asm/uaccess.h:33,
                 from arch/um/kernel/exitcode.c:9:
arch/um/include/um_uaccess.h: In function `copy_from_user':
arch/um/include/um_uaccess.h:25: warning: implicit declaration of function `CHOOSE_MODE'
arch/um/include/um_uaccess.h:25: warning: implicit declaration of function `copy_from_user_tt'
arch/um/include/um_uaccess.h:25: warning: implicit declaration of function `copy_from_user_skas'
arch/um/include/um_uaccess.h: In function `copy_to_user':
arch/um/include/um_uaccess.h:31: warning: implicit declaration of function `copy_to_user_tt'
arch/um/include/um_uaccess.h:31: warning: implicit declaration of function `copy_to_user_skas'
arch/um/include/um_uaccess.h: In function `strncpy_from_user':
arch/um/include/um_uaccess.h:56: warning: implicit declaration of function `strncpy_from_user_tt'
arch/um/include/um_uaccess.h:56: warning: implicit declaration of function `strncpy_from_user_skas'
arch/um/include/um_uaccess.h: In function `__clear_user':
arch/um/include/um_uaccess.h:73: warning: implicit declaration of function `__clear_user_tt'
arch/um/include/um_uaccess.h:73: warning: implicit declaration of function `__clear_user_skas'
arch/um/include/um_uaccess.h: In function `clear_user':
arch/um/include/um_uaccess.h:88: warning: implicit declaration of function `clear_user_tt'
arch/um/include/um_uaccess.h:88: warning: implicit declaration of function `clear_user_skas'
arch/um/include/um_uaccess.h: In function `strnlen_user':
arch/um/include/um_uaccess.h:104: warning: implicit declaration of function `strnlen_user_tt'
arch/um/include/um_uaccess.h:104: warning: implicit declaration of function `strnlen_user_skas'
  CC      arch/um/kernel/init_task.o
In file included from include/asm/uaccess.h:33,
                 from arch/um/kernel/init_task.c:12:
arch/um/include/um_uaccess.h: In function `copy_from_user':
arch/um/include/um_uaccess.h:25: warning: implicit declaration of function `CHOOSE_MODE'
arch/um/include/um_uaccess.h:25: warning: implicit declaration of function `copy_from_user_tt'
arch/um/include/um_uaccess.h:25: warning: implicit declaration of function `copy_from_user_skas'
arch/um/include/um_uaccess.h: In function `copy_to_user':
arch/um/include/um_uaccess.h:31: warning: implicit declaration of function `copy_to_user_tt'
arch/um/include/um_uaccess.h:31: warning: implicit declaration of function `copy_to_user_skas'
arch/um/include/um_uaccess.h: In function `strncpy_from_user':
arch/um/include/um_uaccess.h:56: warning: implicit declaration of function `strncpy_from_user_tt'
arch/um/include/um_uaccess.h:56: warning: implicit declaration of function `strncpy_from_user_skas'
arch/um/include/um_uaccess.h: In function `__clear_user':
arch/um/include/um_uaccess.h:73: warning: implicit declaration of function `__clear_user_tt'
arch/um/include/um_uaccess.h:73: warning: implicit declaration of function `__clear_user_skas'
arch/um/include/um_uaccess.h: In function `clear_user':
arch/um/include/um_uaccess.h:88: warning: implicit declaration of function `clear_user_tt'
arch/um/include/um_uaccess.h:88: warning: implicit declaration of function `clear_user_skas'
arch/um/include/um_uaccess.h: In function `strnlen_user':
arch/um/include/um_uaccess.h:104: warning: implicit declaration of function `strnlen_user_tt'
arch/um/include/um_uaccess.h:104: warning: implicit declaration of function `strnlen_user_skas'
  CC      arch/um/kernel/irq.o
In file included from include/asm/uaccess.h:33,
                 from arch/um/kernel/irq.c:28:
arch/um/include/um_uaccess.h: In function `copy_from_user':
arch/um/include/um_uaccess.h:25: warning: implicit declaration of function `CHOOSE_MODE'
arch/um/include/um_uaccess.h:25: warning: implicit declaration of function `copy_from_user_tt'
arch/um/include/um_uaccess.h:25: warning: implicit declaration of function `copy_from_user_skas'
arch/um/include/um_uaccess.h: In function `copy_to_user':
arch/um/include/um_uaccess.h:31: warning: implicit declaration of function `copy_to_user_tt'
arch/um/include/um_uaccess.h:31: warning: implicit declaration of function `copy_to_user_skas'
arch/um/include/um_uaccess.h: In function `strncpy_from_user':
arch/um/include/um_uaccess.h:56: warning: implicit declaration of function `strncpy_from_user_tt'
arch/um/include/um_uaccess.h:56: warning: implicit declaration of function `strncpy_from_user_skas'
arch/um/include/um_uaccess.h: In function `__clear_user':
arch/um/include/um_uaccess.h:73: warning: implicit declaration of function `__clear_user_tt'
arch/um/include/um_uaccess.h:73: warning: implicit declaration of function `__clear_user_skas'
arch/um/include/um_uaccess.h: In function `clear_user':
arch/um/include/um_uaccess.h:88: warning: implicit declaration of function `clear_user_tt'
arch/um/include/um_uaccess.h:88: warning: implicit declaration of function `clear_user_skas'
arch/um/include/um_uaccess.h: In function `strnlen_user':
arch/um/include/um_uaccess.h:104: warning: implicit declaration of function `strnlen_user_tt'
arch/um/include/um_uaccess.h:104: warning: implicit declaration of function `strnlen_user_skas'
  CC      arch/um/kernel/irq_user.o
  CC      arch/um/kernel/ksyms.o
In file included from include/asm/uaccess.h:33,
                 from include/asm/unistd.h:11,
                 from arch/um/kernel/ksyms.c:14:
arch/um/include/um_uaccess.h: In function `copy_from_user':
arch/um/include/um_uaccess.h:25: warning: implicit declaration of function `CHOOSE_MODE'
arch/um/include/um_uaccess.h:25: warning: implicit declaration of function `copy_from_user_tt'
arch/um/include/um_uaccess.h:25: warning: implicit declaration of function `copy_from_user_skas'
arch/um/include/um_uaccess.h: In function `copy_to_user':
arch/um/include/um_uaccess.h:31: warning: implicit declaration of function `copy_to_user_tt'
arch/um/include/um_uaccess.h:31: warning: implicit declaration of function `copy_to_user_skas'
arch/um/include/um_uaccess.h: In function `strncpy_from_user':
arch/um/include/um_uaccess.h:56: warning: implicit declaration of function `strncpy_from_user_tt'
arch/um/include/um_uaccess.h:56: warning: implicit declaration of function `strncpy_from_user_skas'
arch/um/include/um_uaccess.h: In function `__clear_user':
arch/um/include/um_uaccess.h:73: warning: implicit declaration of function `__clear_user_tt'
arch/um/include/um_uaccess.h:73: warning: implicit declaration of function `__clear_user_skas'
arch/um/include/um_uaccess.h: In function `clear_user':
arch/um/include/um_uaccess.h:88: warning: implicit declaration of function `clear_user_tt'
arch/um/include/um_uaccess.h:88: warning: implicit declaration of function `clear_user_skas'
arch/um/include/um_uaccess.h: In function `strnlen_user':
arch/um/include/um_uaccess.h:104: warning: implicit declaration of function `strnlen_user_tt'
arch/um/include/um_uaccess.h:104: warning: implicit declaration of function `strnlen_user_skas'
  CC      arch/um/kernel/mem.o
  CC      arch/um/kernel/physmem.o
arch/um/kernel/physmem.c: In function `get_kmem_end':
arch/um/kernel/physmem.c:297: warning: implicit declaration of function `CHOOSE_MODE'
arch/um/kernel/physmem.c:297: error: `kmem_end_tt' undeclared (first use in this function)
arch/um/kernel/physmem.c:297: error: (Each undeclared identifier is reported only once
arch/um/kernel/physmem.c:297: error: for each function it appears in.)
arch/um/kernel/physmem.c:297: error: `kmem_end_skas' undeclared (first use in this function)
make[1]: *** [arch/um/kernel/physmem.o] Error 1
make: *** [arch/um/kernel] Error 2

--Boundary-00=_dMndDuL3/Ow7LAQ
Content-Type: text/plain;
  charset="us-ascii";
  name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=".config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.15-rc1
# Sat Nov 12 16:49:54 2005
#
CONFIG_GENERIC_HARDIRQS=y
CONFIG_UML=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_IRQ_RELEASE_METHOD=y

#
# Host processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y

#
# UML-specific options
#
# CONFIG_MODE_TT is not set
# CONFIG_STATIC_LINK is not set
# CONFIG_MODE_SKAS is not set
CONFIG_UML_X86=y
# CONFIG_64BIT is not set
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_TOP_ADDR=0xc0000000
# CONFIG_3_LEVEL_PGTABLES is not set
CONFIG_STUB_CODE=0xbfffe000
CONFIG_STUB_DATA=0xbffff000
CONFIG_STUB_START=0xbfffe000
CONFIG_ARCH_HAS_SC_SIGNALS=y
CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA=y
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_LD_SCRIPT_DYN=y
# CONFIG_NET is not set
# CONFIG_BINFMT_ELF is not set
# CONFIG_BINFMT_MISC is not set
# CONFIG_HOSTFS is not set
# CONFIG_HPPFS is not set
# CONFIG_MCONSOLE is not set
CONFIG_NEST_LEVEL=0
# CONFIG_HIGHMEM is not set
CONFIG_KERNEL_STACK_ORDER=2
# CONFIG_UML_REAL_TIME_CLOCK is not set

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
# CONFIG_LOCALVERSION_AUTO is not set
# CONFIG_SWAP is not set
# CONFIG_SYSVIPC is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_SYSCTL is not set
# CONFIG_HOTPLUG is not set
# CONFIG_IKCONFIG is not set
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
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
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0

#
# Loadable module support
#
# CONFIG_MODULES is not set

#
# Block layer
#
# CONFIG_LBD is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_AS is not set
# CONFIG_IOSCHED_DEADLINE is not set
# CONFIG_IOSCHED_CFQ is not set
# CONFIG_DEFAULT_AS is not set
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
CONFIG_DEFAULT_NOOP=y
CONFIG_DEFAULT_IOSCHED="noop"

#
# Networking
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
# CONFIG_FW_LOADER is not set

#
# Character Devices
#
# CONFIG_STDERR_CONSOLE is not set
CONFIG_STDIO_CONSOLE=y
# CONFIG_SSL is not set
# CONFIG_NULL_CHAN is not set
# CONFIG_PORT_CHAN is not set
# CONFIG_PTY_CHAN is not set
# CONFIG_TTY_CHAN is not set
# CONFIG_XTERM_CHAN is not set
CONFIG_NOCONFIG_CHAN=y
CONFIG_CON_ZERO_CHAN="fd:0,fd:1"
CONFIG_CON_CHAN="xterm"
CONFIG_SSL_CHAN="pty"
# CONFIG_UNIX98_PTYS is not set
# CONFIG_LEGACY_PTYS is not set
# CONFIG_WATCHDOG is not set
# CONFIG_UML_SOUND is not set
# CONFIG_SOUND is not set
# CONFIG_HOSTAUDIO is not set
# CONFIG_UML_RANDOM is not set
# CONFIG_MMAPPER is not set

#
# Block devices
#
# CONFIG_BLK_DEV_UBD is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_BLK_DEV_RAM_COUNT=16
# CONFIG_NETDEVICES is not set

#
# Network device support
#
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# File systems
#
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_INOTIFY is not set
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
# CONFIG_PROC_FS is not set
CONFIG_SYSFS=y
# CONFIG_TMPFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
# CONFIG_RELAYFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_HFSPLUS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
# CONFIG_NLS is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Hardware crypto devices
#

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
# CONFIG_CRC32 is not set
# CONFIG_LIBCRC32C is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_INPUT is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
# CONFIG_DEBUG_KERNEL is not set
CONFIG_LOG_BUF_SHIFT=14

--Boundary-00=_dMndDuL3/Ow7LAQ--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
