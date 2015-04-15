Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <552EC316.9080802@nod.at>
Date: Wed, 15 Apr 2015 21:59:18 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="BISn8IWxqm2p0N8ahAp3IligESLvkuMVJ"
Sender: linux-kernel-owner@vger.kernel.org
Subject: [GIT PULL] UML updates for 4.1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BISn8IWxqm2p0N8ahAp3IligESLvkuMVJ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Linus,

the following changes since commit bc465aa9d045feb0e13b4a8f32cc33c1943f62=
d6:

  Linux 4.0-rc5 (2015-03-22 16:50:21 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus=
-4.1

for you to fetch changes up to fe205bdd1321f95f8f3c35d243ea7cb22af8fbe1:

  um: Print minimum physical memory requirement (2015-04-13 21:17:46 +020=
0)

----------------------------------------------------------------
* hostfs saw a face lifting
* Old/broken stuff was removed (SMP, HIGHMEM, SKAS3/4)
* Random cleanups and bug fixes

----------------------------------------------------------------
Andrey Ryabinin (1):
      x86, UML: fix integer overflow in ELF_ET_DYN_BASE

Richard Weinberger (22):
      hostfs: hostfs_file_open: Switch to data locking model
      hostfs: hostfs_file_open: Fix a fd leak in hostfs_file_open
      hostfs: Allow fsync on directories
      hostfs: Handle bogus st.mode
      hostfs: Make hostfs_readpage more readable
      hostfs: Add a BUG_ON to detect behavior changes of dentry_path_raw(=
)
      hostfs: Remove open coded strcpy()
      hostfs: Use __getname() in follow_link
      hostfs: Report append flag in ->show_options()
      hostfs: Remove superfluous test in hostfs_open()
      hostfs: hostfs_open: Reset open flags upon each retry
      hostfs: Remove superfluous initializations in hostfs_open()
      hostfs: Set page flags in hostfs_readpage() correctly
      hostfs: Use page_offset()
      hostfs: No need to box and later unbox the file mode
      um: Remove dead code from stacktrace
      um: Remove ia64 cruft
      um: Remove ppc cruft
      um: Remove SKAS3/4 support
      um: Remove broken SMP support
      um: Remove broken highmem support
      um: hostfs: Reduce number of syscalls in readdir

Thomas Meyer (3):
      um: add a kmsg_dumper
      um: Move uml_postsetup in the init_thread stack
      um: Print minimum physical memory requirement

 arch/um/Kconfig.um                          |  42 -----
 arch/um/Makefile-ia64                       |   1 -
 arch/um/Makefile-ppc                        |   9 --
 arch/um/include/asm/fixmap.h                |   4 -
 arch/um/include/asm/pgtable.h               |   6 +-
 arch/um/include/asm/processor-generic.h     |   8 -
 arch/um/include/asm/smp.h                   |  26 ---
 arch/um/include/shared/as-layout.h          |   1 +
 arch/um/include/shared/os.h                 |   2 -
 arch/um/include/shared/skas/proc_mm.h       |  44 -----
 arch/um/include/shared/skas/skas.h          |   3 -
 arch/um/include/shared/skas_ptrace.h        |  14 --
 arch/um/kernel/Makefile                     |   4 +-
 arch/um/kernel/irq.c                        |   3 -
 arch/um/kernel/kmsg_dump.c                  |  43 +++++
 arch/um/kernel/mem.c                        |  66 --------
 arch/um/kernel/physmem.c                    |  41 ++++-
 arch/um/kernel/process.c                    |  11 --
 arch/um/kernel/ptrace.c                     |  32 ----
 arch/um/kernel/reboot.c                     |  35 ++--
 arch/um/kernel/skas/mmu.c                   |  68 +++-----
 arch/um/kernel/skas/process.c               |  31 +---
 arch/um/kernel/smp.c                        | 238 ----------------------=
------
 arch/um/kernel/sysrq.c                      |   6 +-
 arch/um/kernel/trap.c                       |   2 +-
 arch/um/kernel/um_arch.c                    |  67 ++------
 arch/um/os-Linux/process.c                  |  16 --
 arch/um/os-Linux/skas/mem.c                 | 100 ++----------
 arch/um/os-Linux/skas/process.c             | 202 ++++++----------------=
-
 arch/um/os-Linux/start_up.c                 | 154 ------------------
 arch/um/sys-ia64/Makefile                   |  11 --
 arch/um/sys-ia64/sysdep/ptrace.h            |  16 --
 arch/um/sys-ia64/sysdep/sigcontext.h        |  10 --
 arch/um/sys-ia64/sysdep/skas_ptrace.h       |  22 ---
 arch/um/sys-ia64/sysdep/syscalls.h          |  10 --
 arch/um/sys-ppc/Makefile                    |  65 --------
 arch/um/sys-ppc/asm/archparam.h             |   8 -
 arch/um/sys-ppc/asm/elf.h                   |  51 ------
 arch/um/sys-ppc/asm/processor.h             |  15 --
 arch/um/sys-ppc/misc.S                      | 111 -------------
 arch/um/sys-ppc/miscthings.c                |  42 -----
 arch/um/sys-ppc/ptrace.c                    |  58 -------
 arch/um/sys-ppc/ptrace_user.c               |  29 ----
 arch/um/sys-ppc/shared/sysdep/ptrace.h      |  93 -----------
 arch/um/sys-ppc/shared/sysdep/sigcontext.h  |  52 ------
 arch/um/sys-ppc/shared/sysdep/skas_ptrace.h |  22 ---
 arch/um/sys-ppc/shared/sysdep/syscalls.h    |  43 -----
 arch/um/sys-ppc/sigcontext.c                |   4 -
 arch/um/sys-ppc/sysrq.c                     |  33 ----
 arch/x86/um/Makefile                        |   1 -
 arch/x86/um/asm/barrier.h                   |  11 --
 arch/x86/um/asm/elf.h                       |   2 +-
 arch/x86/um/ldt.c                           | 227 ++++++----------------=
----
 arch/x86/um/shared/sysdep/faultinfo_32.h    |   3 -
 arch/x86/um/shared/sysdep/faultinfo_64.h    |   3 -
 arch/x86/um/shared/sysdep/skas_ptrace.h     |  22 ---
 fs/hostfs/hostfs.h                          |   6 +-
 fs/hostfs/hostfs_kern.c                     | 112 +++++++------
 fs/hostfs/hostfs_user.c                     |  29 ++--
 59 files changed, 323 insertions(+), 2067 deletions(-)
 delete mode 100644 arch/um/Makefile-ia64
 delete mode 100644 arch/um/Makefile-ppc
 delete mode 100644 arch/um/include/shared/skas/proc_mm.h
 delete mode 100644 arch/um/include/shared/skas_ptrace.h
 create mode 100644 arch/um/kernel/kmsg_dump.c
 delete mode 100644 arch/um/kernel/smp.c
 delete mode 100644 arch/um/sys-ia64/Makefile
 delete mode 100644 arch/um/sys-ia64/sysdep/ptrace.h
 delete mode 100644 arch/um/sys-ia64/sysdep/sigcontext.h
 delete mode 100644 arch/um/sys-ia64/sysdep/skas_ptrace.h
 delete mode 100644 arch/um/sys-ia64/sysdep/syscalls.h
 delete mode 100644 arch/um/sys-ppc/Makefile
 delete mode 100644 arch/um/sys-ppc/asm/archparam.h
 delete mode 100644 arch/um/sys-ppc/asm/elf.h
 delete mode 100644 arch/um/sys-ppc/asm/processor.h
 delete mode 100644 arch/um/sys-ppc/misc.S
 delete mode 100644 arch/um/sys-ppc/miscthings.c
 delete mode 100644 arch/um/sys-ppc/ptrace.c
 delete mode 100644 arch/um/sys-ppc/ptrace_user.c
 delete mode 100644 arch/um/sys-ppc/shared/sysdep/ptrace.h
 delete mode 100644 arch/um/sys-ppc/shared/sysdep/sigcontext.h
 delete mode 100644 arch/um/sys-ppc/shared/sysdep/skas_ptrace.h
 delete mode 100644 arch/um/sys-ppc/shared/sysdep/syscalls.h
 delete mode 100644 arch/um/sys-ppc/sigcontext.c
 delete mode 100644 arch/um/sys-ppc/sysrq.c
 delete mode 100644 arch/x86/um/shared/sysdep/skas_ptrace.h


--BISn8IWxqm2p0N8ahAp3IligESLvkuMVJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVLsMWAAoJEPmeIjfg4UaamqsQAILEpb20tUwL2hXEc5EtCqVy
srzAwNx1Y6VABEvP4ucXsEJzWbJlQHljfoAql6VwHf3nvTlflq7KCvC0zw+g1cyn
ee6G4jV/rMUZVKvcdeaXZ38wyQPUN+lbDZslXxQL8KShocXfsBDQ5m7/QIqEQyAV
V6A+kgjs5QNZTkwo5i8v22Ds9UKsuVye63KTTUQx+PyFR4liqUcByPFBOYNRaaS/
jJBK0h8AQmlNy4AC2fAx31BIyshuyMW+9xyRxWB2aFhz4DJHf+Ml/19psdc8qeFi
hT5hjyfs6UmjCPCjOvnxd+fp6UqbpF0DVv3sy7nupkPf5pEZhe86kokNDlelBmCg
ALJeD1b0wF515fuBObMNc//0Ko9Fx7eleqL+QPkzWDNUNxmWBKOJ1eJ8nysGQge9
4VapDSE5vWFkYMdb4dRvu+FqBqfGXk5GQhQOpk2q6e801O/1VXI7wHkXjz3ECW4A
oqUmeqGgcwjS79eTVQEOtJZHb+ZUFtQruRff8EXXxIhYWfI+F05xpxIazSjrP54s
MryRTcfyGY5WzQTM7x8Ql7RrWRTrCQ/SJIj4+C55a82qezbcLi9xU75hYVK3OG5y
NtDYJGOhuP4ICkyDodk7KCuOjbkfQvWiWEnmAu16C0GHOOfYnF+AadDwpzuB75XT
PDELYEU0c3cxF43AEFbN
=Gcxe
-----END PGP SIGNATURE-----

--BISn8IWxqm2p0N8ahAp3IligESLvkuMVJ--
