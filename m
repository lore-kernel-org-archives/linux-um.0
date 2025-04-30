Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6023BC369D9
	for <linux-um@archiver.kernel.org>; Wed, 30 Apr 2025 16:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hsIzPzF+5jZYZ5GcRhRx6Gx6ji780sAcd4puveiGVNg=; b=OjWXMIoIX7/zaIQc9OzFODn8G/
	2zQjTeDpVV1YOWY5CtToXYm1sVX3mgRT7/n0TvMEIRxrYiHYRa/8n/2nSJbMEzeDpLdd5TH+pAsIZ
	pAHylEFpatdfDbTlhWm2OPk0QoAOW7ZcrejsnCxBu3DrkIrIZBCzRZrSTViW7kzYkAaTZ294OT29j
	l/eoRuPdn+tCe5bQKZVB/MB0V93ebTuvLWickdKT/KS1czOtPOK9mGxDkJyv0IS0sgnjwfXrPyEMm
	zctxY0xioxWThuQJGmAKnQ0EAUTCmbR1P/kVeVBtslWT9ZMND6QkjsZhY7xzyKqxjGwrwHBMXQ52e
	Hfa5ZuCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA9zU-0000000DO14-15is;
	Wed, 30 Apr 2025 16:08:56 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA9wr-0000000DNf3-1itT
	for linux-um@lists.infradead.org;
	Wed, 30 Apr 2025 16:06:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=hsIzPzF+5jZYZ5GcRhRx6Gx6ji780sAcd4puveiGVNg=; t=1746029171; x=1747238771; 
	b=LpwT8jyChyeoDgiyd8jHojWa7ZEt2g9KgMDVxcG3lKUon7ylceKtm7wvdonVO+WoljoDwE+F/zo
	QMQezK2n1QREzLXD6bWKdnBUKUu5Dh9g3JEyPvRZsX1APhRmv3mlCmgrK2p7Vx9kFml1gVWnrAHUl
	p29pGXzJ0788HSkY4EueFdcyw/WohguT9aVNh7pWl47sb/QtkM+rCPptAc7gVZY60ZLkEs81r0s5B
	0JaGeuvQ/7wXDG6sTnYCppXMx1uv5H1icuQN09JC0SdRFQ7xsoGcDssnFQdFNiIbbnCacmRw3t98Q
	u+q96f3oepd4eG40iJvU1y6uIvY4sABHsMMg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uA9wm-0000000DxyX-2OEH;
	Wed, 30 Apr 2025 18:06:08 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 0/8] SECCOMP based userspace for UML
Date: Wed, 30 Apr 2025 18:04:05 +0200
Message-ID: <20250430160413.3250227-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_090613_447997_DA869D41 
X-CRM114-Status: GOOD (  11.71  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

Hi all,

another version of the SECCOMP patchset. I think that this should now be
good enough for general consumption. Compared to the last RFC version
there is an important bugfix that caused a SIGSEGV loop and various
other small bugfixes and cleanups.

The patchset adds a new userspace handling mode to UML that is based on
a SECCOMP filter and trusted code within each userspace process.

The motivation the new SECCOMP mode is that it saves context switches
when handling pagefaults and for syscalls like mmap. The approach may
also permit SMP support in the future and might make it easier to port
UML to further host architectures.

Benjamin

v2:
- Simple rebase dropping the merged patche

v1:
- Remove explicit (and insufficient) kconfig.h includes
- Change commit order to move configuration to the end
- Fix futex wait race condition
- Also handle child dying during stub startup

RFCv2:
- Fix FP handling on i386
- Improved MM list for userspace sigchild handling
- Remove kconfig.h includes
- Minor cleanups

Benjamin Berg (8):
  um: Move faultinfo extraction into userspace routine
  um: Add stub side of SECCOMP/futex based process handling
  um: Add helper functions to get/set state for SECCOMP
  um: Add SECCOMP support detection and initialization
  um: Track userspace children dying in SECCOMP mode
  um: Implement kernel side of SECCOMP based process handling
  um: pass FD for memory operations when needed
  um: Add UML_SECCOMP configuration option

 arch/um/Kconfig                            |  19 +
 arch/um/include/asm/irq.h                  |   5 +-
 arch/um/include/asm/mmu.h                  |   3 +
 arch/um/include/shared/common-offsets.h    |   4 +
 arch/um/include/shared/irq_user.h          |   2 +
 arch/um/include/shared/os.h                |   3 +-
 arch/um/include/shared/skas/mm_id.h        |  13 +
 arch/um/include/shared/skas/skas.h         |   5 +
 arch/um/include/shared/skas/stub-data.h    |  20 +-
 arch/um/kernel/irq.c                       |   6 +
 arch/um/kernel/skas/mmu.c                  |  89 +++-
 arch/um/kernel/skas/stub.c                 | 134 +++++-
 arch/um/kernel/skas/stub_exe.c             | 159 ++++++-
 arch/um/os-Linux/internal.h                |   5 +-
 arch/um/os-Linux/process.c                 |  31 ++
 arch/um/os-Linux/registers.c               |   4 +-
 arch/um/os-Linux/signal.c                  |  19 +-
 arch/um/os-Linux/skas/mem.c                | 103 ++++-
 arch/um/os-Linux/skas/process.c            | 485 +++++++++++++++------
 arch/um/os-Linux/start_up.c                | 150 ++++++-
 arch/x86/um/os-Linux/mcontext.c            | 220 +++++++++-
 arch/x86/um/ptrace.c                       |  76 +++-
 arch/x86/um/shared/sysdep/kernel-offsets.h |   2 +
 arch/x86/um/shared/sysdep/mcontext.h       |   9 +
 arch/x86/um/shared/sysdep/stub-data.h      |  23 +
 arch/x86/um/shared/sysdep/stub.h           |   2 +
 arch/x86/um/shared/sysdep/stub_32.h        |  13 +
 arch/x86/um/shared/sysdep/stub_64.h        |  17 +
 arch/x86/um/tls_32.c                       |  23 +-
 29 files changed, 1439 insertions(+), 205 deletions(-)
 create mode 100644 arch/x86/um/shared/sysdep/stub-data.h

-- 
2.49.0


