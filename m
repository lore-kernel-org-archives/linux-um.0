Return-Path: <linux-kernel-owner@vger.kernel.org>
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Date: Thu, 24 Dec 2015 13:12:11 +0100
Message-Id: <1450959131-5113-1-git-send-email-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH v3] um: Fix build error and kconfig for i386
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, Josh Triplett <josh@joshtriplett.org>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Michal Marek <mmarek@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, stable@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

=46ix build error by generating elfcore.o only when ELF_CORE (depending=
 on
COREDUMP) is selected:

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
 arch/x86/um/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index a8fecc226946..3ee2bb6b440b 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -17,7 +17,7 @@ obj-y =3D bug.o bugs_$(BITS).o delay.o fault.o ksyms.=
o ldt.o \
 ifeq ($(CONFIG_X86_32),y)
=20
 obj-y +=3D checksum_32.o
-obj-$(CONFIG_BINFMT_ELF) +=3D elfcore.o
+obj-$(CONFIG_ELF_CORE) +=3D elfcore.o
=20
 subarch-y =3D ../lib/string_32.o ../lib/atomic64_32.o ../lib/atomic64_=
cx8_32.o
 subarch-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) +=3D ../lib/rwsem.o
--=20
2.6.4

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

