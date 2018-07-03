Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 0/2] x86/build/vdso: a little more Makefile cleanups
Date: Tue,  3 Jul 2018 10:50:12 +0900
Message-Id: <1530582614-5173-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>, Andy Lutomirski <luto@kernel.org>, Jeff Dike <jdike@addtoit.com>
List-ID: <linux-um.lists.infradead.org>


At first, I sent the first patch to UML ML,
but they did not pick it up.
Instead, I was able to get Acked-by from Richard,
one of the UML maintainers.

https://patchwork.kernel.org/patch/10399787/

I am resending it to x86 ML.



Masahiro Yamada (2):
  x86/build/vdso: remove unused vdso-syms.lds
  x86/build/vdso: simplify cmd_vdso2c

 arch/x86/entry/vdso/Makefile |  4 +---
 arch/x86/um/vdso/.gitignore  |  1 -
 arch/x86/um/vdso/Makefile    | 16 ----------------
 3 files changed, 1 insertion(+), 20 deletions(-)

-- 
2.7.4


