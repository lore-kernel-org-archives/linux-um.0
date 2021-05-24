Return-Path: <linux-arch-owner@vger.kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] LOCKDEP: reduce LOCKDEP dependency list
Date: Mon, 24 May 2021 15:41:50 -0700
Message-Id: <20210524224150.8009-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Johannes Berg <johannes@sipsolutions.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org, Julian Braha <julianbraha@gmail.com>, linux-arch@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>

Some arches (um, sparc64, riscv, xtensa) cause a Kconfig warning for
LOCKDEP.
These arch-es select LOCKDEP_SUPPORT but they are not listed as one
of the arch-es that LOCKDEP depends on.

Since (16) arch-es define the Kconfig symbol LOCKDEP_SUPPORT if they
intend to have LOCKDEP support, replace the awkward list of
arch-es that LOCKDEP depends on with the LOCKDEP_SUPPORT symbol.

But wait. LOCKDEP_SUPPORT is included in LOCK_DEBUGGING_SUPPORT,
which is already a dependency here, so LOCKDEP_SUPPORT is redundant
and not needed.
That leaves the FRAME_POINTER dependency, but it is part of an
expression like this:
	depends on (A && B) && (FRAME_POINTER || B')
where B' is a dependency of B so if B is true then B' is true
and the value of FRAME_POINTER does not matter.
Thus we can also delete the FRAME_POINTER dependency.

Fixes this kconfig warning: (for um, sparc64, riscv, xtensa)

WARNING: unmet direct dependencies detected for LOCKDEP
  Depends on [n]: DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y] && (FRAME_POINTER [=n] || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86)
  Selected by [y]:
  - PROVE_LOCKING [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
  - LOCK_STAT [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
  - DEBUG_LOCK_ALLOC [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]

Link to v1: https://lore.kernel.org/lkml/20210517034430.9569-1-rdunlap@infradead.org/

Fixes: 7d37cb2c912d ("lib: fix kconfig dependency on ARCH_WANT_FRAME_POINTERS")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
Cc: Julian Braha <julianbraha@gmail.com>
Cc: linux-arch@vger.kernel.org
---
@Julian: please take a look. I'm a little concerned about the
  FRAME_POINTER dependency going away when our 2 patches are combined.

v2: drop depends on LOCKDEP_SUPPORT for LOCKDEP; the use of
    LOCK_DEBUGGING_SUPPORT already covers that dependency;
    drop FRAME_POINTER dependency (thanks to Waiman Long
    for both of these suggestions)
v2: add CC: to linux-arch

 lib/Kconfig.debug |    1 -
 1 file changed, 1 deletion(-)

--- linux-next-20210524.orig/lib/Kconfig.debug
+++ linux-next-20210524/lib/Kconfig.debug
@@ -1383,7 +1383,6 @@ config LOCKDEP
 	bool
 	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
 	select STACKTRACE
-	depends on FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86
 	select KALLSYMS
 	select KALLSYMS_ALL
 

