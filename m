Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F56AC433FE
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 10:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=KZ9ygnjogY6VDK4DXN1QmuywMo+RI/qHwKbGEIbiQq8=; b=qBUlWE93ocOYzP
	Ic2bk+9nPtz3K+LI7CL53KjDWIl4r1DNK2O9ss5sfGudz13QqiVJ/UiDr/qcfUCojpyDONdyP8Uqh
	sFhFvDbiCB8BPjRZUMaiWS5EUMCKn0N9qJAOH1rN/a+d/YOOaDce/7cM3v28CDPPwW38GGfmwnyQ1
	yrPLvmtGa98TGI90DvCi0la4Ci22lJPr8wqflmDfrmxo/LroX+LB3m7MT/I7Ow2+V4HC40I+dnOK1
	s6H76vzVpu7U8ofSvkMMVC/HPz1wzLOt/Zd50NIGDJN1tgkO0cU5no7pv8/3d9sdDhUXyRHuIsx/h
	nkBiPPeeqC4Aks5wNlYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQUa-007o1a-3Q; Tue, 22 Nov 2022 10:27:04 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQTM-007nKg-F3
	for linux-um@bombadil.infradead.org; Tue, 22 Nov 2022 10:25:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=DNc04u2/z2XeWk5h65EgPG9tu4VgW9enlbCVAWrG8B4=; b=peuasRCaZdQ993BqTPFyzoYKA7
	4wbL1HzrAuJ3B8v0AlC8aeWgLjVG3jBHKB2pZhYWFaoMw1JfW2xx8WD7duwpuVOj4fiMY9hoErUEJ
	jcIH2Up+tlkH+vxQMUBhceWATdB4hFg6qdAtQFv3VxM5YRTwBKV/D42VOXNQAMtmMZsAzAIsp8VgT
	je0B30RL9pdF3402ndBPe4u3OyC0tB7bo3J/8lGlEt55wq/BnxGYEa6GsjM1oeS3q5EHzoUHdcb9J
	3EhlgppeWqArPgQuHwLiDAgj8NZKWemUHMpCC0CPCmbXnt6x11aPV+Dl+QoJwFGANO6Uhbsf6Qq+t
	nrsboN/A==;
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQF1-003P1u-8F
	for linux-um@lists.infradead.org; Tue, 22 Nov 2022 10:11:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=DNc04u2/z2XeWk5h65EgPG9tu4VgW9enlbCVAWrG8B4=; t=1669111859; x=1670321459; 
	b=fRZHYG94mx2GYl49YeknyW7+EcTMbfPC9KaeUaxEHj1JrFov+Madyv19y8fWve0XpqpfAZzaXdq
	oeDvWTJzKoGEX+BcSNIsQCL30UzLw6Xxo6SitpGf15Q2mgqbYOH4n+BCcpK231z9VcuIdz4819EI3
	/camDElrsvBdVXysEAnVw3V2deeAZOiucRqTkWgTyuLqyOeWvl4PvAS7mYODg0wHOEcOcVbECAo0t
	QKRPV8k9XdCrU4o87mpnGl8IaGAft/qfdP/T2gKJUHxz1WyzwbW5R0Gc/in73MdTZt5H6KrPwVaMb
	x9Ys7mFiCb2PgUPiv/YJWgVJEvQdHbbHyx+w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1oxQEg-006IGn-1D;
	Tue, 22 Nov 2022 11:10:38 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v2 00/28] Implement SECCOMP based userland
Date: Tue, 22 Nov 2022 11:07:31 +0100
Message-Id: <20221122100759.208290-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_101100_332761_F6B7AD9E 
X-CRM114-Status: GOOD (  16.04  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Benjamin Berg <benjamin@sipsolutions.net>

Currently UML uses ptrace in order to implement userspace processes. This
works really well, however, it requires six context switches per pagefault
(get faultinfo, run syscalls, continue process).

By switching to use SECCOMP, the whole process becomes more collaborative
as the userspace process can run code, including host syscalls, before
jumping into the kernel and after the kernel returns control. This means
pagefaults only require two context switches to be processed.

In pagefault heavy scenarios (e.g. fork/exec) the performance increase of
doing this can be considerable, with runtimes dropping by 30% or more.

Note that the current syscall filter can easily be abused by a userspace
process to execute arbitrary host syscalls. I think it is possible to
efficiently detect such attempts and kill the offending processes by
(ab)using the rt_sigaction syscall in order to set/get a flag that
userspace code cannot tamper with.

v2:
 * Fixed FP register store/restore
 * Plenty of other fixes and improvements

Benjamin Berg (28):
  um: Switch printk calls to adhere to correct coding style
  um: Declare fix_range_common as a static function
  um: Drop support for hosts without SYSEMU_SINGLESTEP support
  um: Drop NULL check from start_userspace
  um: Make errors to stop ptraced child fatal during startup
  um: Don't use vfprintf() for os_info()
  um: Do not use printk in SIGWINCH helper thread
  um: Reap winch thread if it fails
  um: Do not use printk in userspace trampoline
  um: Always inline stub functions
  um: Rely on PTRACE_SETREGSET to set FS/GS base registers
  um: Remove unused register save/restore functions
  um: Mark 32bit syscall helpers as clobbering memory
  um: Remove stub-data.h include from common-offsets.h
  um: Create signal stack memory assignment in stub_data
  um: Add generic stub_syscall6 function
  um: Rework syscall handling
  um: Store full CSGSFS and SS register from mcontext
  um: Pass full mm_id to functions creating helper processes
  um: Move faultinfo extraction into userspace routine
  um: Use struct uml_pt_regs for copy_context_skas0
  um: Add UML_SECCOMP configuration option
  um: Add stub side of SECCOMP/futex based process handling
  um: Add helper functions to get/set state for SECCOMP
  um: Add SECCOMP support detection and initialization
  um: Die if a child dies unexpectedly in seccomp mode
  um: Implement kernel side of SECCOMP based process handling
  um: Delay flushing syscalls until the thread is restarted

 arch/um/Kconfig                         |  19 +
 arch/um/drivers/chan_user.c             |  42 +-
 arch/um/drivers/line.c                  |  13 +-
 arch/um/include/asm/processor-generic.h |   1 -
 arch/um/include/shared/as-layout.h      |   2 +-
 arch/um/include/shared/common-offsets.h |  14 +-
 arch/um/include/shared/kern_util.h      |   3 +-
 arch/um/include/shared/os.h             |  33 +-
 arch/um/include/shared/ptrace_user.h    |  41 --
 arch/um/include/shared/registers.h      |   2 -
 arch/um/include/shared/skas/mm_id.h     |   1 +
 arch/um/include/shared/skas/skas.h      |   7 +
 arch/um/include/shared/skas/stub-data.h |  41 +-
 arch/um/include/shared/user.h           |   8 +
 arch/um/kernel/exec.c                   |  10 +-
 arch/um/kernel/process.c                |  12 +-
 arch/um/kernel/ptrace.c                 |   2 -
 arch/um/kernel/signal.c                 |  12 -
 arch/um/kernel/skas/Makefile            |   4 +-
 arch/um/kernel/skas/clone.c             |  33 +-
 arch/um/kernel/skas/mmu.c               |  16 +-
 arch/um/kernel/skas/process.c           |   8 +
 arch/um/kernel/skas/stub.c              | 101 ++++
 arch/um/kernel/tlb.c                    |  54 +-
 arch/um/os-Linux/process.c              |  40 ++
 arch/um/os-Linux/registers.c            |  24 +-
 arch/um/os-Linux/signal.c               |   7 +
 arch/um/os-Linux/skas/mem.c             | 288 +++++----
 arch/um/os-Linux/skas/process.c         | 749 ++++++++++++++++--------
 arch/um/os-Linux/start_up.c             | 244 +++++---
 arch/um/os-Linux/util.c                 |  19 +-
 arch/x86/um/Makefile                    |   2 +-
 arch/x86/um/asm/elf.h                   |   4 +-
 arch/x86/um/asm/processor_64.h          |   3 -
 arch/x86/um/ldt.c                       |  47 +-
 arch/x86/um/os-Linux/Makefile           |   1 -
 arch/x86/um/os-Linux/mcontext.c         | 153 ++++-
 arch/x86/um/os-Linux/prctl.c            |  12 -
 arch/x86/um/ptrace_32.c                 |  24 -
 arch/x86/um/ptrace_64.c                 |  26 -
 arch/x86/um/shared/sysdep/mcontext.h    |   9 +
 arch/x86/um/shared/sysdep/ptrace_32.h   |   4 -
 arch/x86/um/shared/sysdep/ptrace_user.h |  12 +-
 arch/x86/um/shared/sysdep/stub-data.h   |  12 +
 arch/x86/um/shared/sysdep/stub.h        |   4 +
 arch/x86/um/shared/sysdep/stub_32.h     |  78 ++-
 arch/x86/um/shared/sysdep/stub_64.h     |  57 +-
 arch/x86/um/stub_32.S                   |  56 --
 arch/x86/um/stub_64.S                   |  50 --
 arch/x86/um/syscalls_64.c               |  62 +-
 arch/x86/um/tls_64.c                    |   2 +-
 51 files changed, 1500 insertions(+), 968 deletions(-)
 create mode 100644 arch/um/kernel/skas/stub.c
 delete mode 100644 arch/x86/um/os-Linux/prctl.c
 create mode 100644 arch/x86/um/shared/sysdep/stub-data.h
 delete mode 100644 arch/x86/um/stub_32.S
 delete mode 100644 arch/x86/um/stub_64.S

-- 
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
