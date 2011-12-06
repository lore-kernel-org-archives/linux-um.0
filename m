Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "H. Peter Anvin" <hpa@linux.intel.com>
Date: Mon,  5 Dec 2011 17:05:46 -0800
Message-Id: <1323133549-13590-1-git-send-email-hpa@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 0/3] UML fixes for tip:x86/syscall
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, user-mode-linux-devel@lists.sourceforge.net, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@linux.intel.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: "H. Peter Anvin" <hpa@linux.intel.com>

The patch series currently in -tip as x86/syscall, which builds
syscall tables from a simple text file also broke UML.

I intend to apply this patch to tip:x86/syscall, but if the UML folks
would either holler or ack that would be appreciated.

This patch series enables using generated host header files in UML,
and then uses the new x86 generated syscall tables in the same uniform
style as the native kernel.

The native kernel relies on asm-offsets.h to generate the syscall
fencepost symbols automatically (it is done that way rather in the
script to make the future extension to multiple supported ABIs work
better.)  On UML, asm-offsets.h is generated globally, but
user-constants.h has per-subarchitecture support; it feels a little
like an odd place for it but I put the fenceposts there.  The UML
folks might want to holler if that is too broken.

 arch/um/Makefile                |    9 +++++-
 arch/x86/um/Makefile            |    3 +-
 arch/x86/um/sys_call_table_32.S |   26 ------------------
 arch/x86/um/sys_call_table_32.c |   55 +++++++++++++++++++++++++++++++++++++++
 arch/x86/um/sys_call_table_64.c |   31 ++++++++-------------
 arch/x86/um/user-offsets.c      |   15 ++++++++++
 6 files changed, 91 insertions(+), 48 deletions(-)

