Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B11C87FCF
	for <linux-um@archiver.kernel.org>; Sun, 10 Aug 2025 05:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OY9LQOI81twPnsUMH9vJVddG4XSsD5uF/LCYVEwzvNk=; b=v002XOXuEvKGNCyuyggkxa9cUP
	9ctlEV+kn8T8+JCydKy10GctS/3G74lYXGPtlOMMeup17Mq7QChFCtHkXWMR9vyKjtyzYz9OE61lF
	/zRJckJgpvKmw/wWM1dZ9nQiI9XIMr8Ef7EhHTeeAwFl2zD4J6uDi1Ppj5yLMTNuYIHZ18uHCRX9u
	xGfeZTeoA1LC+A4zva1VQM4QTGejfW22p9Fxg8mVqs6/uWynFHXDkgqYtQhPsMSE2KhbzXUPMG2cg
	ieJ8Ve2p8mA5DyTyhH7YSkKpBv2qCu0k+qBEDfxxr9q9p3KBGtTBqG4iBzgWRBC/tFX86iX5rhpCU
	3jgOtGLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukyya-00000005ILq-2qC1;
	Sun, 10 Aug 2025 05:52:12 +0000
Received: from out-174.mta0.migadu.com ([91.218.175.174])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukyyY-00000005IJs-0KJK
	for linux-um@lists.infradead.org;
	Sun, 10 Aug 2025 05:52:11 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754805118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OY9LQOI81twPnsUMH9vJVddG4XSsD5uF/LCYVEwzvNk=;
	b=TB1SUbnL/IDYIAB5IEH0QhIw/5VLJmHFbATKiv8XQCWef2T5fdHif5CAb1UfQR1PiP3kil
	0C2/sDx0Gy+dPXU2kF/J+zpmTA5KHL4lkul9sy9MuKt1fyR31XF2WX+5dJ1naxR7fONTdj
	oo/pptdVhlVMH9PUBsXeV+yZ1BOyd7Q=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	benjamin@sipsolutions.net,
	arnd@arndb.de,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH v2 00/10] um: Add SMP support
Date: Sun, 10 Aug 2025 13:51:26 +0800
Message-Id: <20250810055136.897712-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250809_225210_414527_A535F314 
X-CRM114-Status: GOOD (  13.24  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Tiwei Bie <tiwei.btw@antgroup.com>

This series adds initial symmetric multi-processing (SMP) support
to UML. With this support, it is now possible for users to tell
UML to start multiple virtual CPUs, each represented as a separate
host thread.

In UML, kthreads and normal threads (when running in kernel mode)
can be scheduled and executed simultaneously on different virtual
CPUs. However, the userspace code of normal threads currently still
runs within their respective single-threaded stubs.

So SMP within the kernel is supported. SMP across different processes
in userspace is also supported. Currently, the limitation is that
multi-threading within the same process does not yet support true SMP
in userspace, because it would require converting the stub into a
multi-threaded implementation, which is not covered in this series.

Extending the stub to support true SMP in userspace within the same
process could be done later and requires careful design. It may be
better to handle it in a follow-up series.

Here are some steps to try out SMP support in UML:

1. Build UML with CONFIG_SMP=y and, for example, CONFIG_NR_CPUS=8.

2. Launch a UML instance with, for example, 8 virtual CPUs.

 $ ./linux mem=16G ncpus=8 seccomp=on init=/bin/sh ubd0=$your_rootfs_image

v2:
- Implement IPI based on RT signal; (Johannes)
- Fix raw_smp_processor_id() for non-SMP case; (Johannes)
- Add sparse check for turnstile; (Johannes)
- Implement spinlock in $SUBARCH;
- Fix potential race on stub's siginfo;
- Rewrite AP bring-up (e.g. switch to generic idle thread);
- Misc fixes and cleanups;

v1: https://lore.kernel.org/linux-um/20250727062937.1369050-1-tiwei.bie@linux.dev/

RFC: https://lore.kernel.org/linux-um/20250713172536.404809-1-tiwei.bie@linux.dev/

Tiwei Bie (10):
  um: Stop tracking virtual CPUs via mm_cpumask()
  um: Remove unused cpu_data and current_cpu_data macros
  um: vdso: Implement __vdso_getcpu() via syscall
  um: Turn signals_* into thread-local variables
  um: Determine sleep based on need_resched()
  um: Define timers on a per-CPU basis
  um: Remove unused ipi_pipe field from cpuinfo_um
  um: Add initial SMP support
  asm-generic: percpu: Add assembly guard
  um: Enable SMP support on x86

 .../core/generic-idle-thread/arch-support.txt |   2 +-
 arch/um/Kconfig                               |  46 +++-
 arch/um/include/asm/current.h                 |   5 +-
 arch/um/include/asm/hardirq.h                 |  24 +-
 arch/um/include/asm/irqflags.h                |   4 +-
 arch/um/include/asm/mmu.h                     |  10 +
 arch/um/include/asm/mmu_context.h             |  11 -
 arch/um/include/asm/pgtable.h                 |   2 +
 arch/um/include/asm/processor-generic.h       |   3 -
 arch/um/include/asm/smp.h                     |  15 +-
 arch/um/include/linux/smp-internal.h          |  17 ++
 arch/um/include/linux/time-internal.h         |   3 +
 arch/um/include/shared/kern_util.h            |   2 +
 arch/um/include/shared/longjmp.h              |   3 +-
 arch/um/include/shared/os.h                   |  23 +-
 arch/um/include/shared/skas/mm_id.h           |   5 +
 arch/um/include/shared/smp.h                  |  20 ++
 arch/um/kernel/Makefile                       |   1 +
 arch/um/kernel/irq.c                          |  27 +-
 arch/um/kernel/ksyms.c                        |   2 +-
 arch/um/kernel/mem.c                          |   2 +
 arch/um/kernel/process.c                      |  19 +-
 arch/um/kernel/skas/mmu.c                     |  32 ++-
 arch/um/kernel/skas/process.c                 |   7 +-
 arch/um/kernel/smp.c                          | 239 ++++++++++++++++++
 arch/um/kernel/time.c                         |  58 +++--
 arch/um/kernel/tlb.c                          |   5 +-
 arch/um/kernel/trap.c                         |   2 +-
 arch/um/kernel/um_arch.c                      |  28 +-
 arch/um/os-Linux/Makefile                     |   4 +-
 arch/um/os-Linux/internal.h                   |   7 +
 arch/um/os-Linux/main.c                       |   5 +-
 arch/um/os-Linux/process.c                    |  20 ++
 arch/um/os-Linux/signal.c                     |  40 ++-
 arch/um/os-Linux/skas/process.c               |  22 +-
 arch/um/os-Linux/smp.c                        | 142 +++++++++++
 arch/um/os-Linux/start_up.c                   |   4 +
 arch/um/os-Linux/time.c                       |  46 ++--
 arch/x86/um/Kconfig                           |   3 +
 arch/x86/um/asm/spinlock.h                    |   8 +
 arch/x86/um/vdso/um_vdso.c                    |  18 +-
 include/asm-generic/percpu.h                  |   3 +
 42 files changed, 827 insertions(+), 112 deletions(-)
 create mode 100644 arch/um/include/linux/smp-internal.h
 create mode 100644 arch/um/include/shared/smp.h
 create mode 100644 arch/um/kernel/smp.c
 create mode 100644 arch/um/os-Linux/smp.c
 create mode 100644 arch/x86/um/asm/spinlock.h

-- 
2.34.1


