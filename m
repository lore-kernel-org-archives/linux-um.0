Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH v2 0/6] um: Output messages to stderr and support quiet option
Date: Mon,  8 May 2017 15:15:21 +0900
Message-Id: <149422411127.11101.13017249012576512464.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hello,

Here is version 2 of um-quiet series.

This series fixes some boot time printf output to stderr
by adding os_info() and os_warn(). The information-level
messages via os_info() are suppressed when "quiet" kernel
option is specified.
Also the last one allows user to pass "console=" option
to kernel.

Note that the output of --help and --version are still
sent to stdout since they are intentionally shown by
the user.

Changes from v1:
 - Introduce os_info() and os_warn() to replace most of
   printf() instead of reusing non_fatal().
 - Replace fprintf(stderr, ...) with os_warn() for error
   messages.

Thank you,

---

Masami Hiramatsu (6):
      um: Use printk instead of printf in make_uml_dir
      um: Add os_info() for pre-boot information messages
      um: Use os_info for the messages on normal path
      um: Add os_warn() for pre-boot warning/error messages
      um: Use os_warn to print out pre-boot warning/error messages
      um: console: Ignore console= option


 arch/um/drivers/stdio_console.c |    3 +++
 arch/um/include/shared/os.h     |    4 ++++
 arch/um/kernel/physmem.c        |   10 +++++-----
 arch/um/kernel/um_arch.c        |   16 +++++++++-------
 arch/um/kernel/umid.c           |    4 ++--
 arch/um/os-Linux/execvp.c       |    2 +-
 arch/um/os-Linux/main.c         |    9 ++++-----
 arch/um/os-Linux/mem.c          |   28 ++++++++++++++--------------
 arch/um/os-Linux/start_up.c     |   28 +++++++++++++++-------------
 arch/um/os-Linux/umid.c         |   19 +++++++++++--------
 arch/um/os-Linux/util.c         |   34 ++++++++++++++++++++++++++++++++++
 11 files changed, 102 insertions(+), 55 deletions(-)

--
Masami Hiramatsu <mhiramat@kernel.org>

