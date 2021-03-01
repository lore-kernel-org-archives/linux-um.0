Return-Path: <masahiroy@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 0/7] x86: fix warnings and refactor syscall code
Date: Mon,  1 Mar 2021 22:15:25 +0900
Message-Id: <20210301131533.64671-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Brian Gerst <brgerst@gmail.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Jeff Dike <jdike@addtoit.com>, Johannes Berg <johannes.berg@intel.com>, Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org
List-ID: <linux-um.lists.infradead.org>


This patch series makes a lot of cleanups.
We can remove a lot of lines.
The code diff is attractive.



Masahiro Yamada (7):
  x86/syscalls: fix -Wmissing-prototypes warnings from COND_SYSCALL()
  x86/entry/x32: rename __x32_compat_sys_* to __x64_compat_sys_*
  x86/syscalls: switch to generic syscalltbl.sh
  x86/syscalls: stop filling syscall arrays with *_sys_ni_syscall
  x86/unistd: define X32_NR_syscalls only for 64-bit kernel
  x86/syscalls: use __NR_syscalls instead of __NR_syscall_max
  x86/syscalls: switch to generic syscallhdr.sh

 arch/um/kernel/skas/syscall.c          |  2 +-
 arch/x86/entry/syscall_32.c            | 20 +++++------
 arch/x86/entry/syscall_64.c            | 17 +++-------
 arch/x86/entry/syscall_x32.c           | 35 ++++----------------
 arch/x86/entry/syscalls/Makefile       | 36 +++++++++++---------
 arch/x86/entry/syscalls/syscallhdr.sh  | 35 --------------------
 arch/x86/entry/syscalls/syscalltbl.sh  | 46 --------------------------
 arch/x86/include/asm/Kbuild            |  1 +
 arch/x86/include/asm/syscall_wrapper.h | 11 +++---
 arch/x86/include/asm/unistd.h          |  8 ++---
 arch/x86/um/sys_call_table_32.c        | 14 +++-----
 arch/x86/um/sys_call_table_64.c        | 15 ++-------
 12 files changed, 61 insertions(+), 179 deletions(-)
 delete mode 100644 arch/x86/entry/syscalls/syscallhdr.sh
 delete mode 100644 arch/x86/entry/syscalls/syscalltbl.sh

-- 
2.27.0


