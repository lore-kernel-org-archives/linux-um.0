Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHTqx-005UJB-2M
 for linux-um@lists.infradead.org; Wed, 03 Mar 2021 15:56:02 +0000
From: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 00/27] Implement SECCOMP based userland
Date: Wed,  3 Mar 2021 16:54:56 +0100
Message-Id: <20210303155523.124277-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>

Currently UML uses ptrace in order to implement userspace processes. This
works really well, however, it requires six context switches per pagefault
(get faultinfo, run syscalls, continue process).

By switching to use SECCOMP, the whole process becomes more collaborative
as the userspace process can run code, including host syscalls, before
jumping into the kernel and after the kernel returns control. This means
pagefaults only require two context switches to be processed.

In pagefault heavy scenarios (e.g. fork/exec) the performance increase of
doing this can be considerable, with runtimes dropping by 30% or more.

Note that this implementation is not safe as userspace code could jump
directly to the syscall instruction in order to execute an arbitrary host
syscall. This should be fixable by remapping the page RW for a short time
in order to NOP out the syscall instruction.
Because of this, the seccomp mode is disabled by default.

Benjamin Berg (27):
  um: Switch printk calls to adhere to correct coding style
  um: Declare fix_range_common as a static function
  um: Drop support for hosts without SYSEMU_SINGLESTEP support
  um: Drop NULL check from start_userspace
  um: Make errors to stop ptraced child fatal during startup
  um: Don't use vfprintf() for os_info()
  um: Do not use printk in SIGWINCH helper thread
  um: Reap winch thread if it fails
  um: Do not use printk in userspace trampoline
  um: Always inline stub functions
  um: Rely on PTRACE_SETREGSET to set FS/GS base registers
  um: Remove unused register save/restore functions
  um: Mark 32bit syscall helpers as clobbering memory
  um: Create signal stack memory assignment in stub_data
  um: Add generic stub_syscall6 function
  um: Rework syscall handling
  um: Store full CSGSFS and SS register from mcontext
  um: Pass full mm_id to functions creating helper processes
  um: Move faultinfo extraction into userspace routine
  um: Use struct uml_pt_regs for copy_context_skas0
  um: Add UML_SECCOMP configuration option
  um: Add stub side of SECCOMP/futex based process handling
  um: Add helper functions to get/set state for SECCOMP
  um: Add SECCOMP support detection and initialization
  um: Die if a child dies unexpectedly in seccomp mode
  um: Implement kernel side of SECCOMP based process handling
  um: Delay flushing syscalls until the thread is restarted

 arch/um/Kconfig                         |  19 +
 arch/um/drivers/chan_user.c             |  41 +-
 arch/um/drivers/line.c                  |  13 +-
 arch/um/include/asm/processor-generic.h |   1 -
 arch/um/include/shared/kern_util.h      |   1 -
 arch/um/include/shared/os.h             |  32 +-
 arch/um/include/shared/ptrace_user.h    |  41 --
 arch/um/include/shared/registers.h      |   2 -
 arch/um/include/shared/skas/mm_id.h     |   1 +
 arch/um/include/shared/skas/skas.h      |   7 +
 arch/um/include/shared/skas/stub-data.h |  41 +-
 arch/um/include/shared/user.h           |   8 +
 arch/um/kernel/exec.c                   |  10 +-
 arch/um/kernel/process.c                |  75 +--
 arch/um/kernel/ptrace.c                 |   2 -
 arch/um/kernel/signal.c                 |  12 -
 arch/um/kernel/skas/Makefile            |   4 +-
 arch/um/kernel/skas/clone.c             |  32 +-
 arch/um/kernel/skas/mmu.c               |   6 +-
 arch/um/kernel/skas/process.c           |   8 +
 arch/um/kernel/skas/stub.c              | 105 ++++
 arch/um/kernel/tlb.c                    |  54 +-
 arch/um/os-Linux/process.c              |  40 ++
 arch/um/os-Linux/registers.c            |  24 +-
 arch/um/os-Linux/signal.c               |   7 +
 arch/um/os-Linux/skas/mem.c             | 278 ++++-----
 arch/um/os-Linux/skas/process.c         | 722 ++++++++++++++++--------
 arch/um/os-Linux/start_up.c             | 240 ++++----
 arch/um/os-Linux/util.c                 |  19 +-
 arch/x86/um/Makefile                    |   2 +-
 arch/x86/um/asm/elf.h                   |   4 +-
 arch/x86/um/asm/processor_64.h          |   3 -
 arch/x86/um/ldt.c                       |  45 +-
 arch/x86/um/os-Linux/Makefile           |   1 -
 arch/x86/um/os-Linux/mcontext.c         | 103 +++-
 arch/x86/um/os-Linux/prctl.c            |  12 -
 arch/x86/um/ptrace_32.c                 |  24 -
 arch/x86/um/ptrace_64.c                 |  26 -
 arch/x86/um/shared/sysdep/mcontext.h    |   9 +
 arch/x86/um/shared/sysdep/ptrace_32.h   |   4 -
 arch/x86/um/shared/sysdep/stub-data.h   |  11 +
 arch/x86/um/shared/sysdep/stub.h        |   4 +
 arch/x86/um/shared/sysdep/stub_32.h     |  66 ++-
 arch/x86/um/shared/sysdep/stub_64.h     |  41 +-
 arch/x86/um/stub_32.S                   |  56 --
 arch/x86/um/stub_64.S                   |  50 --
 arch/x86/um/syscalls_64.c               |  59 +-
 arch/x86/um/tls_64.c                    |   2 +-
 48 files changed, 1375 insertions(+), 992 deletions(-)
 create mode 100644 arch/um/kernel/skas/stub.c
 delete mode 100644 arch/x86/um/os-Linux/prctl.c
 create mode 100644 arch/x86/um/shared/sysdep/stub-data.h
 delete mode 100644 arch/x86/um/stub_32.S
 delete mode 100644 arch/x86/um/stub_64.S

-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

