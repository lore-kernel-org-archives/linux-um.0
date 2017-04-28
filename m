Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH 0/7] um: Fix printf usage and support quiet option
Date: Fri, 28 Apr 2017 19:19:51 +0900
Message-Id: <149337478135.14717.16640886389891283.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hello,

This series fixes some boot time printf output to stderr
by default, and support "quiet" option to suppress non-
fatal error (or warning) messages in user-mode-linux.
Also the last one allows user to pass "console=" option
to kernel.



Thank you,

---

Masami Hiramatsu (7):
      um: Use printk instead of printf in make_uml_dir
      um: Use non_fatal() in check_coredump_limit
      um: Make non_fatal non-static for other files
      um: Use non_fatal() for non-fatal information/warning messages
      um: Print out fatal error in stderr
      um: Suppress non-fatal messages when quiet
      um: console: Ignore console= option


 arch/um/drivers/stdio_console.c |    3 +++
 arch/um/include/shared/os.h     |    1 +
 arch/um/kernel/physmem.c        |    8 ++++----
 arch/um/kernel/um_arch.c        |   16 +++++++++-------
 arch/um/kernel/umid.c           |    4 ++--
 arch/um/os-Linux/main.c         |   10 +++++-----
 arch/um/os-Linux/mem.c          |   24 ++++++++++++------------
 arch/um/os-Linux/start_up.c     |   23 ++++++++---------------
 arch/um/os-Linux/umid.c         |   14 ++++++++------
 arch/um/os-Linux/util.c         |   25 +++++++++++++++++++++++++
 10 files changed, 77 insertions(+), 51 deletions(-)

--
Masami Hiramatsu <mhiramat@kernel.org>

