Return-Path: <linux-kernel-owner@vger.kernel.org>
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Date: Wed, 23 Dec 2015 13:59:13 +0100
Message-Id: <1450875553-17717-1-git-send-email-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH v2] um: Fix build error and kconfig for i386
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, Josh Triplett <josh@joshtriplett.org>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Michal Marek <mmarek@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, stable@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

=46ix build error by selecting COREDUMP when X86_32 is selected:

arch/x86/um/built-in.o: In function `elf_core_write_extra_phdrs':
(.text+0x3e62): undefined reference to `dump_emit'
arch/x86/um/built-in.o: In function `elf_core_write_extra_data':
(.text+0x3eef): undefined reference to `dump_emit'

=46ixes: 5d2acfc7b974 ("kconfig: make allnoconfig disable options behin=
d EMBEDDED and EXPERT")
Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Michal Marek <mmarek@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/um/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index ed56a1c4ae73..bb7cd8b38043 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -26,6 +26,7 @@ config X86_32
 	select CLONE_BACKWARDS
 	select OLD_SIGSUSPEND3
 	select OLD_SIGACTION
+	select COREDUMP
=20
 config X86_64
 	def_bool 64BIT
--=20
2.6.4

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

