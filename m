Return-Path: <linux-kernel-owner@vger.kernel.org>
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Subject: [PATCH v1 0/3] Fix seccomp for UM (next)
Date: Mon, 11 Jul 2016 23:56:59 +0200
Message-Id: <1468274222-31726-1-git-send-email-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Kees Cook <keescook@chromium.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, James Morris <jmorris@namei.org>, Olof Johansson <olof@lixom.net>, user-mode-linux-devel@lists.sourceforge.net, linux-security-module@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi,

This series fix the recent seccomp update for the User-mode Linux architecture
(32-bit and 64-bit) since commit 26703c636c1f3272b39bd0f6d04d2e970984f1b6
(close the hole where ptrace can change a syscall out from under seccomp).

Regards,

Mickaël Salaün (3):
  um/ptrace: Fix the syscall_trace_leave call
  um/ptrace: Fix the syscall number update after a ptrace
  seccomp: Remove 2-phase API documentation

 arch/Kconfig                  | 11 -----------
 arch/um/kernel/skas/syscall.c | 10 +++-------
 arch/x86/um/ptrace_32.c       |  3 +++
 arch/x86/um/ptrace_64.c       |  4 ++++
 4 files changed, 10 insertions(+), 18 deletions(-)

-- 
2.8.1


