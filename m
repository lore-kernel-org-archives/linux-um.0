Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 0/3] x86/build: clean-up of vdso Makefile
Date: Tue, 15 May 2018 11:52:21 +0900
Message-Id: <1526352744-28229-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, "H. Peter Anvin" <hpa@zytor.com>, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>, Andy Lutomirski <luto@amacapital.net>, Jeff Dike <jdike@addtoit.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>




Masahiro Yamada (3):
  x86/build: vdso: remove unused $(vobjs-nox32) in Makefile
  x86/build: vdso: remove unnecessary export in Makefile
  x86/build: vdso: put generated linker scripts to $(obj)/

 arch/x86/entry/vdso/Makefile | 11 ++++-------
 arch/x86/um/vdso/Makefile    |  4 ++--
 2 files changed, 6 insertions(+), 9 deletions(-)

-- 
2.7.4


