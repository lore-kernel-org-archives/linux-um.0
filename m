Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDD2C83F17
	for <linux-um@archiver.kernel.org>; Sun, 13 Jul 2025 17:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bb1gMX6oqqkowN9Mysq4XIk/QzuqxoT8IOPSEPw+8Cs=; b=RvKqpRb7mq70IVQLrvqSCcfYn9
	WsEG17KrLbHtH+5XARa32JO+fKMvpdi2fKM5f6OKzI3agimCK0mPiH+VTpAcAzDQPSrLWPM+KEns+
	Auplqf0AYlpDbe/nx7gpbx5TtQdRZa+CSpzxOdWxp78oJsSYDLfEuXxW3h0A3wt6u9wLmy8qxIxMY
	BKzGwA9kiCDKPKSMTNvTt5m7R+aDpSZMbUOtS1ebv9q0DZ7MUu0skmh0zHyL51xsbBqVbusDKZoFV
	0J4i7Ho6ky/u3421YAo+brfz/qJ05C6vSCSYyIAW4rhUBAdZrtrVpeE6e9Mwg+cT0YxN07Snwq5Y5
	+Z5RStsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ub0Ux-00000000RVJ-2PAY;
	Sun, 13 Jul 2025 17:28:23 +0000
Received: from out-180.mta1.migadu.com ([95.215.58.180])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ub0Uu-00000000RKs-3Wrk
	for linux-um@lists.infradead.org;
	Sun, 13 Jul 2025 17:28:22 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752427558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bb1gMX6oqqkowN9Mysq4XIk/QzuqxoT8IOPSEPw+8Cs=;
	b=kv6VCGbP/pfdy9Zfw83p1tgkOCjhIJE71RtWV2y6x0YaBwOcP+5Acno3UuxiqLyqQki8fs
	hoKFaqNUTO9eU7NT4wfDYlPDSwC/bVJJSzBeLWBnuQ2YRuVgocsFxABHN8oPwCrqZd0bEJ
	pEIqwBUXv6dNZu9JPhLK/OIgD3/IhIs=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [RFC PATCH 0/4] um: Add SMP support
Date: Mon, 14 Jul 2025 01:25:32 +0800
Message-Id: <20250713172536.404809-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250713_102821_031435_A70A6B6F 
X-CRM114-Status: GOOD (  10.49  )
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

This is a follow-up to the discussion in this thread:
https://lore.kernel.org/linux-um/20250711065021.2535362-4-tiwei.bie@linux.dev/

Currently, this is still a PoC and requires further improvements.

I performed a kernel build test inside UML with 8 virtual CPUs enabled:

$ tar xf linux-6.15.tar.gz
$ cd linux-6.15
$ make ARCH=um defconfig > /dev/null
$ time make ARCH=um -j16 > /dev/null

real    6m2.529s
user    43m37.665s
sys     0m34.585s
$ ./linux --version
6.15.0
$ cat /proc/cpuinfo | grep -c '^processor'
8

Here are some steps to try out SMP support in UML:

1. Build UML with CONFIG_SMP=y and, for example, CONFIG_NR_CPUS=8.

2. Launch a UML instance with, for example, 8 virtual CPUs.

 $ ./linux mem=16G ncpus=8 nohz=n seccomp=on init=/bin/sh \
           ubd0=$your_rootfs_image

This patchset depends on the following patchset:
https://lore.kernel.org/linux-um/20250711065021.2535362-1-tiwei.bie@linux.dev/

Tiwei Bie (4):
  um: Stop tracking virtual CPUs via mm_cpumask()
  um: Remove unused cpu_data and current_cpu_data macros
  um: vdso: Implement __vdso_getcpu() via syscall
  um: Add SMP support

 arch/um/Kconfig                         |  28 ++-
 arch/um/include/asm/Kbuild              |   3 +
 arch/um/include/asm/current.h           |   5 +-
 arch/um/include/asm/hardirq.h           |  24 ++-
 arch/um/include/asm/irqflags.h          |   4 +-
 arch/um/include/asm/mmu.h               |   7 +
 arch/um/include/asm/mmu_context.h       |  11 --
 arch/um/include/asm/pgtable.h           |   2 +
 arch/um/include/asm/processor-generic.h |   8 +-
 arch/um/include/asm/smp.h               |  31 +++-
 arch/um/include/asm/spinlock.h          |   8 +
 arch/um/include/linux/smp-internal.h    |   8 +
 arch/um/include/linux/time-internal.h   |   3 +
 arch/um/include/shared/kern_util.h      |   2 +
 arch/um/include/shared/longjmp.h        |   3 +-
 arch/um/include/shared/os.h             |  12 +-
 arch/um/include/shared/smp.h            |  14 ++
 arch/um/kernel/Makefile                 |   1 +
 arch/um/kernel/irq.c                    |  31 +++-
 arch/um/kernel/ksyms.c                  |   2 +-
 arch/um/kernel/mem.c                    |   2 +
 arch/um/kernel/process.c                |  19 +-
 arch/um/kernel/skas/mmu.c               |  16 +-
 arch/um/kernel/smp.c                    | 223 ++++++++++++++++++++++++
 arch/um/kernel/time.c                   |  48 +++--
 arch/um/kernel/tlb.c                    |   5 +-
 arch/um/kernel/trap.c                   |   2 +-
 arch/um/kernel/um_arch.c                |  60 ++++++-
 arch/um/os-Linux/Makefile               |   4 +-
 arch/um/os-Linux/file.c                 |  72 ++++++--
 arch/um/os-Linux/main.c                 |   5 +-
 arch/um/os-Linux/process.c              |  15 ++
 arch/um/os-Linux/signal.c               |  16 +-
 arch/um/os-Linux/skas/process.c         |   1 +
 arch/um/os-Linux/smp.c                  |  44 +++++
 arch/um/os-Linux/start_up.c             |   3 +
 arch/um/os-Linux/time.c                 |  29 +--
 arch/um/os-Linux/user_syms.c            |   5 +
 arch/x86/um/vdso/um_vdso.c              |  18 +-
 39 files changed, 695 insertions(+), 99 deletions(-)
 create mode 100644 arch/um/include/asm/spinlock.h
 create mode 100644 arch/um/include/linux/smp-internal.h
 create mode 100644 arch/um/include/shared/smp.h
 create mode 100644 arch/um/kernel/smp.c
 create mode 100644 arch/um/os-Linux/smp.c

-- 
2.34.1


