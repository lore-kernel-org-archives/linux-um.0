Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1758637AbZIRUgK@vger.kernel.org>
From: Tim Abbott <tabbott@ksplice.com>
Subject: [PATCH v2] Linker script cleanup for um
Date: Fri, 18 Sep 2009 16:35:31 -0400
Message-Id: <1253306132-7117-1-git-send-email-tabbott@ksplice.com>
Sender: linux-kernel-owner@vger.kernel.org
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Tim Abbott <tabbott@ksplice.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an updated version of the patch I sent on September 6 cleaning
up the um architecture's linker scripts.  It differs from the previous
version only in having been rebased on top of Linus' current master.

This cross-architecture linker script cleanup project is in
preparation for adding support for building the kernel with
-ffunction-sections -fdata-sections, which is a prerequisite for
Ksplice.

	-Tim Abbott

Tim Abbott (1):
  um: Clean up linker script using standard macros.

 arch/um/include/asm/common.lds.S |   29 ++++++-----------------------
 arch/um/kernel/dyn.lds.S         |    9 ++-------
 arch/um/kernel/uml.lds.S         |   26 ++++++--------------------
 3 files changed, 14 insertions(+), 50 deletions(-)

