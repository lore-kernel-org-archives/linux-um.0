Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8A9C87FCE
	for <linux-um@archiver.kernel.org>; Sun, 27 Jul 2025 06:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5HWXEmeku3lnMzilpD9u1Y29u7fITzVqpod9y7RNw2c=; b=gTWc0JVxTRnM8doqwkyVPBV/BW
	wOpTGoxKES2p+SIarLa451F+gO9eH7jMDulMHFgLFKwSkGAt99FD0LvHyjQPavNTHU3CtLK9EA8df
	CCj6h2n55hqjoIPziRn2YpCFpN1Ski4U8QDFGoJnHzWbG3LZyjF7E/0d4mpXQpjpT8TOHkYstuYHg
	VuTjkAFnWJ2U/OBozsWHGbfnt0ibma4LKobeZBmc0SS8us+xoea+ThJ6maknN/M0QS3y8wFfJYq/v
	tLe+Jg1HpLRl+g5J2VehpINBLjYdcMLvMs57hu/9flNbcg2ay+/550a3aD9pEGtJAaeVkn4RLpVws
	GdLUs9xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufuts-0000000CNtp-1pl2;
	Sun, 27 Jul 2025 06:30:24 +0000
Received: from out-189.mta0.migadu.com ([2001:41d0:1004:224b::bd])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufutp-0000000CNnO-39er
	for linux-um@lists.infradead.org;
	Sun, 27 Jul 2025 06:30:23 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753597804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5HWXEmeku3lnMzilpD9u1Y29u7fITzVqpod9y7RNw2c=;
	b=BVoQJ3/hKGkibyK5CfaxlAeM+q+oMSFy3t3UEEW4HMc1/nhzW1O9KIycaSoSNymkboA1Cb
	E2h6zFTA2HgLWvIvdAo0OGUWyiEpvbImQ3NjQtmW2qYFnn67VaapD5nOB4cY45k8MMKmdC
	dlXJDRDL/BSWU8xRVTR5B3NC7kNseJ4=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH 0/9] um: Add SMP support
Date: Sun, 27 Jul 2025 14:29:28 +0800
Message-Id: <20250727062937.1369050-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250726_233021_936857_C10F31E6 
X-CRM114-Status: GOOD (  12.37  )
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
to UML. With this support, users can tell UML to start multiple
virtual CPUs, each represented as a separate host thread.

In UML, kthreads and normal threads (when running in kernel mode)
can be scheduled and executed simultaneously on different virtual
CPUs. However, the userspace code of normal threads currently still
runs within their respective single-threaded stubs.

So SMP within the kernel is supported. SMP across different guest
processes is also supported. Currently, the limitation is that
multi-threading within the same guest process does not yet support
true SMP in userspace, as it would require converting the stub into
a multi-threaded implementation, which is not covered in this series.

Extending the stub to support true SMP in userspace could be done
later and requires careful design. It may be better to handle it in
a follow-up series.

Here are some steps to try out SMP support in UML:

1. Build UML with CONFIG_SMP=y and, for example, CONFIG_NR_CPUS=8.

2. Launch a UML instance with, for example, 8 virtual CPUs.

 $ ./linux mem=16G ncpus=8 seccomp=on init=/bin/sh ubd0=$your_rootfs_image

RFC: https://lore.kernel.org/linux-um/20250713172536.404809-1-tiwei.bie@linux.dev/

Tiwei Bie (9):
  um: Stop tracking virtual CPUs via mm_cpumask()
  um: Remove unused cpu_data and current_cpu_data macros
  um: vdso: Implement __vdso_getcpu() via syscall
  um: Preserve errno within signal handler
  um: Turn signals_* into thread-local variables
  um: Determine sleep based on need_resched()
  um: Define timers on a per-CPU basis
  um: Support directing IO signals to calling thread
  um: Add initial SMP support

 arch/um/Kconfig                         |  39 +++-
 arch/um/include/asm/Kbuild              |   3 +-
 arch/um/include/asm/current.h           |   5 +-
 arch/um/include/asm/hardirq.h           |  24 ++-
 arch/um/include/asm/irqflags.h          |   4 +-
 arch/um/include/asm/mmu.h               |  10 +
 arch/um/include/asm/mmu_context.h       |  11 -
 arch/um/include/asm/percpu.h            |  20 ++
 arch/um/include/asm/pgtable.h           |   2 +
 arch/um/include/asm/processor-generic.h |   8 +-
 arch/um/include/asm/smp.h               |  23 +-
 arch/um/include/asm/spinlock.h          |   8 +
 arch/um/include/linux/smp-internal.h    |  21 ++
 arch/um/include/linux/time-internal.h   |   3 +
 arch/um/include/shared/kern_util.h      |   2 +
 arch/um/include/shared/longjmp.h        |   3 +-
 arch/um/include/shared/os.h             |  15 +-
 arch/um/include/shared/skas/mm_id.h     |   3 +
 arch/um/include/shared/smp.h            |  19 ++
 arch/um/kernel/Makefile                 |   1 +
 arch/um/kernel/irq.c                    |  35 +++-
 arch/um/kernel/ksyms.c                  |   2 +-
 arch/um/kernel/mem.c                    |   2 +
 arch/um/kernel/process.c                |  20 +-
 arch/um/kernel/skas/mmu.c               |  32 ++-
 arch/um/kernel/smp.c                    | 266 ++++++++++++++++++++++++
 arch/um/kernel/time.c                   |  54 +++--
 arch/um/kernel/tlb.c                    |   5 +-
 arch/um/kernel/trap.c                   |   2 +-
 arch/um/kernel/um_arch.c                |  24 ++-
 arch/um/os-Linux/Makefile               |   4 +-
 arch/um/os-Linux/file.c                 |  10 +-
 arch/um/os-Linux/main.c                 |   5 +-
 arch/um/os-Linux/process.c              |  10 +
 arch/um/os-Linux/signal.c               |  14 +-
 arch/um/os-Linux/skas/process.c         |   9 +
 arch/um/os-Linux/smp.c                  |  86 ++++++++
 arch/um/os-Linux/start_up.c             |   4 +
 arch/um/os-Linux/time.c                 |  42 ++--
 arch/x86/um/vdso/um_vdso.c              |  18 +-
 40 files changed, 769 insertions(+), 99 deletions(-)
 create mode 100644 arch/um/include/asm/percpu.h
 create mode 100644 arch/um/include/asm/spinlock.h
 create mode 100644 arch/um/include/linux/smp-internal.h
 create mode 100644 arch/um/include/shared/smp.h
 create mode 100644 arch/um/kernel/smp.c
 create mode 100644 arch/um/os-Linux/smp.c

-- 
2.34.1


