Return-Path: <linux-kernel-owner@vger.kernel.org>
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Date: Tue, 29 Dec 2015 21:35:43 +0100
Message-Id: <1451421347-9468-1-git-send-email-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH v3 0/4] um: Add seccomp support
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Shuah Khan <shuahkh@osg.samsung.com>, Chris Metcalf <cmetcalf@ezchip.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, James Hogan <james.hogan@imgtec.com>, Thomas Meyer <thomas@m3y3r.de>, Nicolas Iooss <nicolas.iooss_linux@m4x.org>, Anton Ivanov <aivanov@brocade.com>, user-mode-linux-devel@lists.sourceforge.net, Meredydd Luff <meredydd@senatehouse.org>, David Drysdale <drysdale@google.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This series add seccomp support to User-mode Linux (i386 and x86_64
subarchitectures) and fix ptrace issues. This apply on v4.4-rc7 and pas=
s all
the 48 tests from selftest/seccomp plus the UML ptsc test.

Changes since v2:
* remove get_syscall() from os.h and don't include it in syscall.c [1/4=
]
* rebase to v4.4-rc7

Changes since v1; addressed Richard Weinberger's comments:
* fix a new PTRACE_SETREGS bug on x86_64 [1/4]
* fix an old PTRACE_SETREGS bug when updating orig_ax on i386 [1/4]

Regards,
 Micka=C3=ABl

Micka=C3=ABl Sala=C3=BCn (4):
  um: Fix ptrace GETREGS/SETREGS bugs
  selftests/seccomp: Remove the need for HAVE_ARCH_TRACEHOOK
  um: Add full asm/syscall.h support
  um: Add seccomp support

 .../seccomp/seccomp-filter/arch-support.txt        |   2 +-
 arch/um/Kconfig.common                             |   1 +
 arch/um/Kconfig.um                                 |  16 +++
 arch/um/include/asm/syscall-generic.h              | 138 +++++++++++++=
++++++++
 arch/um/include/asm/thread_info.h                  |   2 +
 arch/um/include/shared/os.h                        |   1 -
 arch/um/kernel/skas/syscall.c                      |  31 +++--
 arch/um/os-Linux/skas/process.c                    |   7 --
 arch/x86/um/asm/syscall.h                          |   1 +
 arch/x86/um/ptrace_32.c                            |   8 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c      |  27 +++-
 11 files changed, 205 insertions(+), 29 deletions(-)
 create mode 100644 arch/um/include/asm/syscall-generic.h

--=20
2.6.4

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

