Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <f.fainelli@gmail.com>) id 1UHJUH-0004fk-VH
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 17 Mar 2013 19:43:22 +0000
Received: from mail-wg0-f44.google.com ([74.125.82.44])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UHJUG-0006vW-Kk
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 17 Mar 2013 19:43:21 +0000
Received: by mail-wg0-f44.google.com with SMTP id dr12so4447249wgb.35
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 17 Mar 2013 12:43:14 -0700 (PDT)
From: Florian Fainelli <florian@openwrt.org>
Date: Sun, 17 Mar 2013 20:43:10 +0100
Message-ID: <5783794.b5gPVMPLlO@bender>
MIME-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH] UM: fix make headers_install after UAPI header
	installation
To: user-mode-linux-devel@lists.sourceforge.net
Cc: dhowells@redhat.com, richard@nod.at, jdike@addtoit.com

Commit 10b63956 (UAPI: Plumb the UAPI Kbuilds into the user
header installation and checking) breaks UML make headers_install with
the following:

$ ARCH=um make headers_install
  CHK     include/generated/uapi/linux/version.h
  UPD     include/generated/uapi/linux/version.h
  HOSTCC  scripts/basic/fixdep
  WRAP    arch/um/include/generated/asm/bug.h
[snip]
  WRAP    arch/um/include/generated/asm/trace_clock.h
  SYSHDR  arch/x86/syscalls/../include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/syscalls/../include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/syscalls/../include/generated/uapi/asm/unistd_x32.h
  SYSTBL  arch/x86/syscalls/../include/generated/asm/syscalls_32.h
  HOSTCC  scripts/unifdef
Makefile:912: *** Headers not exportable for the um architecture.  Stop.
zsh: exit 2     ARCH=um make headers_install

The reason for that is because the top-level Makefile does the
following:
        $(if $(wildcard $(srctree)/arch/$(hdr-arch)/include/uapi/asm/Kbuild),, \
          $(error Headers not exportable for the $(SRCARCH) architecture))

we end-up in the else part of the $(if) statement because UML still uses
the old path in arch/um/include/asm/Kbuild. This patch fixes the issue
by moving the header files to be in arch/um/include/uapi/asm/ thus
making headers_install (and other make targets checking for uapi) to
succeed.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Richard, this is applicable to 3.7 onwards, I will submit per-version patches
if you want to. Thanks!

 arch/um/include/{ => uapi}/asm/Kbuild              |    0
 arch/um/include/{ => uapi}/asm/a.out-core.h        |    0
 arch/um/include/{ => uapi}/asm/bugs.h              |    0
 arch/um/include/{ => uapi}/asm/cache.h             |    0
 arch/um/include/{ => uapi}/asm/common.lds.S        |    0
 arch/um/include/{ => uapi}/asm/dma.h               |    0
 arch/um/include/{ => uapi}/asm/fixmap.h            |    0
 arch/um/include/{ => uapi}/asm/irq.h               |    0
 arch/um/include/{ => uapi}/asm/irqflags.h          |    0
 arch/um/include/{ => uapi}/asm/kmap_types.h        |    0
 arch/um/include/{ => uapi}/asm/kvm_para.h          |    0
 arch/um/include/{ => uapi}/asm/mmu.h               |    0
 arch/um/include/{ => uapi}/asm/mmu_context.h       |    0
 arch/um/include/{ => uapi}/asm/page.h              |    0
 arch/um/include/{ => uapi}/asm/pgalloc.h           |    0
 arch/um/include/{ => uapi}/asm/pgtable-2level.h    |    0
 arch/um/include/{ => uapi}/asm/pgtable-3level.h    |    0
 arch/um/include/{ => uapi}/asm/pgtable.h           |    0
 arch/um/include/{ => uapi}/asm/processor-generic.h |    0
 arch/um/include/{ => uapi}/asm/ptrace-generic.h    |    0
 arch/um/include/{ => uapi}/asm/setup.h             |    0
 arch/um/include/{ => uapi}/asm/smp.h               |    0
 arch/um/include/{ => uapi}/asm/sysrq.h             |    0
 arch/um/include/{ => uapi}/asm/thread_info.h       |    0
 arch/um/include/{ => uapi}/asm/timex.h             |    0
 arch/um/include/{ => uapi}/asm/tlb.h               |    0
 arch/um/include/{ => uapi}/asm/tlbflush.h          |    0
 arch/um/include/{ => uapi}/asm/uaccess.h           |    0
 28 files changed, 0 insertions(+), 0 deletions(-)
 rename arch/um/include/{ => uapi}/asm/Kbuild (100%)
 rename arch/um/include/{ => uapi}/asm/a.out-core.h (100%)
 rename arch/um/include/{ => uapi}/asm/bugs.h (100%)
 rename arch/um/include/{ => uapi}/asm/cache.h (100%)
 rename arch/um/include/{ => uapi}/asm/common.lds.S (100%)
 rename arch/um/include/{ => uapi}/asm/dma.h (100%)
 rename arch/um/include/{ => uapi}/asm/fixmap.h (100%)
 rename arch/um/include/{ => uapi}/asm/irq.h (100%)
 rename arch/um/include/{ => uapi}/asm/irqflags.h (100%)
 rename arch/um/include/{ => uapi}/asm/kmap_types.h (100%)
 rename arch/um/include/{ => uapi}/asm/kvm_para.h (100%)
 rename arch/um/include/{ => uapi}/asm/mmu.h (100%)
 rename arch/um/include/{ => uapi}/asm/mmu_context.h (100%)
 rename arch/um/include/{ => uapi}/asm/page.h (100%)
 rename arch/um/include/{ => uapi}/asm/pgalloc.h (100%)
 rename arch/um/include/{ => uapi}/asm/pgtable-2level.h (100%)
 rename arch/um/include/{ => uapi}/asm/pgtable-3level.h (100%)
 rename arch/um/include/{ => uapi}/asm/pgtable.h (100%)
 rename arch/um/include/{ => uapi}/asm/processor-generic.h (100%)
 rename arch/um/include/{ => uapi}/asm/ptrace-generic.h (100%)
 rename arch/um/include/{ => uapi}/asm/setup.h (100%)
 rename arch/um/include/{ => uapi}/asm/smp.h (100%)
 rename arch/um/include/{ => uapi}/asm/sysrq.h (100%)
 rename arch/um/include/{ => uapi}/asm/thread_info.h (100%)
 rename arch/um/include/{ => uapi}/asm/timex.h (100%)
 rename arch/um/include/{ => uapi}/asm/tlb.h (100%)
 rename arch/um/include/{ => uapi}/asm/tlbflush.h (100%)
 rename arch/um/include/{ => uapi}/asm/uaccess.h (100%)

diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/uapi/asm/Kbuild
similarity index 100%
rename from arch/um/include/asm/Kbuild
rename to arch/um/include/uapi/asm/Kbuild
diff --git a/arch/um/include/asm/a.out-core.h b/arch/um/include/uapi/asm/a.out-core.h
similarity index 100%
rename from arch/um/include/asm/a.out-core.h
rename to arch/um/include/uapi/asm/a.out-core.h
diff --git a/arch/um/include/asm/bugs.h b/arch/um/include/uapi/asm/bugs.h
similarity index 100%
rename from arch/um/include/asm/bugs.h
rename to arch/um/include/uapi/asm/bugs.h
diff --git a/arch/um/include/asm/cache.h b/arch/um/include/uapi/asm/cache.h
similarity index 100%
rename from arch/um/include/asm/cache.h
rename to arch/um/include/uapi/asm/cache.h
diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/uapi/asm/common.lds.S
similarity index 100%
rename from arch/um/include/asm/common.lds.S
rename to arch/um/include/uapi/asm/common.lds.S
diff --git a/arch/um/include/asm/dma.h b/arch/um/include/uapi/asm/dma.h
similarity index 100%
rename from arch/um/include/asm/dma.h
rename to arch/um/include/uapi/asm/dma.h
diff --git a/arch/um/include/asm/fixmap.h b/arch/um/include/uapi/asm/fixmap.h
similarity index 100%
rename from arch/um/include/asm/fixmap.h
rename to arch/um/include/uapi/asm/fixmap.h
diff --git a/arch/um/include/asm/irq.h b/arch/um/include/uapi/asm/irq.h
similarity index 100%
rename from arch/um/include/asm/irq.h
rename to arch/um/include/uapi/asm/irq.h
diff --git a/arch/um/include/asm/irqflags.h b/arch/um/include/uapi/asm/irqflags.h
similarity index 100%
rename from arch/um/include/asm/irqflags.h
rename to arch/um/include/uapi/asm/irqflags.h
diff --git a/arch/um/include/asm/kmap_types.h b/arch/um/include/uapi/asm/kmap_types.h
similarity index 100%
rename from arch/um/include/asm/kmap_types.h
rename to arch/um/include/uapi/asm/kmap_types.h
diff --git a/arch/um/include/asm/kvm_para.h b/arch/um/include/uapi/asm/kvm_para.h
similarity index 100%
rename from arch/um/include/asm/kvm_para.h
rename to arch/um/include/uapi/asm/kvm_para.h
diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/uapi/asm/mmu.h
similarity index 100%
rename from arch/um/include/asm/mmu.h
rename to arch/um/include/uapi/asm/mmu.h
diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/uapi/asm/mmu_context.h
similarity index 100%
rename from arch/um/include/asm/mmu_context.h
rename to arch/um/include/uapi/asm/mmu_context.h
diff --git a/arch/um/include/asm/page.h b/arch/um/include/uapi/asm/page.h
similarity index 100%
rename from arch/um/include/asm/page.h
rename to arch/um/include/uapi/asm/page.h
diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/uapi/asm/pgalloc.h
similarity index 100%
rename from arch/um/include/asm/pgalloc.h
rename to arch/um/include/uapi/asm/pgalloc.h
diff --git a/arch/um/include/asm/pgtable-2level.h b/arch/um/include/uapi/asm/pgtable-2level.h
similarity index 100%
rename from arch/um/include/asm/pgtable-2level.h
rename to arch/um/include/uapi/asm/pgtable-2level.h
diff --git a/arch/um/include/asm/pgtable-3level.h b/arch/um/include/uapi/asm/pgtable-3level.h
similarity index 100%
rename from arch/um/include/asm/pgtable-3level.h
rename to arch/um/include/uapi/asm/pgtable-3level.h
diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/uapi/asm/pgtable.h
similarity index 100%
rename from arch/um/include/asm/pgtable.h
rename to arch/um/include/uapi/asm/pgtable.h
diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/uapi/asm/processor-generic.h
similarity index 100%
rename from arch/um/include/asm/processor-generic.h
rename to arch/um/include/uapi/asm/processor-generic.h
diff --git a/arch/um/include/asm/ptrace-generic.h b/arch/um/include/uapi/asm/ptrace-generic.h
similarity index 100%
rename from arch/um/include/asm/ptrace-generic.h
rename to arch/um/include/uapi/asm/ptrace-generic.h
diff --git a/arch/um/include/asm/setup.h b/arch/um/include/uapi/asm/setup.h
similarity index 100%
rename from arch/um/include/asm/setup.h
rename to arch/um/include/uapi/asm/setup.h
diff --git a/arch/um/include/asm/smp.h b/arch/um/include/uapi/asm/smp.h
similarity index 100%
rename from arch/um/include/asm/smp.h
rename to arch/um/include/uapi/asm/smp.h
diff --git a/arch/um/include/asm/sysrq.h b/arch/um/include/uapi/asm/sysrq.h
similarity index 100%
rename from arch/um/include/asm/sysrq.h
rename to arch/um/include/uapi/asm/sysrq.h
diff --git a/arch/um/include/asm/thread_info.h b/arch/um/include/uapi/asm/thread_info.h
similarity index 100%
rename from arch/um/include/asm/thread_info.h
rename to arch/um/include/uapi/asm/thread_info.h
diff --git a/arch/um/include/asm/timex.h b/arch/um/include/uapi/asm/timex.h
similarity index 100%
rename from arch/um/include/asm/timex.h
rename to arch/um/include/uapi/asm/timex.h
diff --git a/arch/um/include/asm/tlb.h b/arch/um/include/uapi/asm/tlb.h
similarity index 100%
rename from arch/um/include/asm/tlb.h
rename to arch/um/include/uapi/asm/tlb.h
diff --git a/arch/um/include/asm/tlbflush.h b/arch/um/include/uapi/asm/tlbflush.h
similarity index 100%
rename from arch/um/include/asm/tlbflush.h
rename to arch/um/include/uapi/asm/tlbflush.h
diff --git a/arch/um/include/asm/uaccess.h b/arch/um/include/uapi/asm/uaccess.h
similarity index 100%
rename from arch/um/include/asm/uaccess.h
rename to arch/um/include/uapi/asm/uaccess.h
-- 
1.7.10.4

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

