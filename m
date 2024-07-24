Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C0DC3DA61
	for <linux-um@archiver.kernel.org>; Wed, 24 Jul 2024 15:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:Message-ID:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ze6r7/KhF9TjhphazFrIUVB9b7lRY0oWWGmfvsW+qjc=; b=f7DbwDa2CmU2pzg/a0OEkgwuxc
	pBaXccyu8n2LEQyBVndOBlO6DKFQDy7T8dafMZfR9mOEVy5SxbB9BYYtAe9BNW+CxU3VzlJ9kK9gR
	+pbUuO3pPgZr/Bg7eiodruypPm44UJ3nlDatWWifPOLD1+WUMJyPRCP9SRDbQ37ZFLs6KmDiuPaNm
	I+8mPAMRYZ1xO4Lw/vZX5khBUtP65PmjnQNtMpTn6LFgSm1gLDcn+Y69F3HeUNH487VVuYy/95dux
	iy6VPyyTO1jgDy+olGMHj5ePHdaOzpkCsGi5slrFPqqClB4s9Lod6A2jP0QwGFSR31DSXo4qvHsb4
	w4bIz0oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWeJq-0000000FqS9-0Hhp;
	Wed, 24 Jul 2024 15:54:22 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWeJm-0000000FqPW-3NRc
	for linux-um@lists.infradead.org;
	Wed, 24 Jul 2024 15:54:20 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 5E0CB64A3D02;
	Wed, 24 Jul 2024 17:54:07 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 2N7Ivzn96uxj; Wed, 24 Jul 2024 17:54:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C389E64A3D08;
	Wed, 24 Jul 2024 17:54:06 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id L0jP27k3j6rD; Wed, 24 Jul 2024 17:54:06 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 99D0064A3D02;
	Wed, 24 Jul 2024 17:54:06 +0200 (CEST)
Date: Wed, 24 Jul 2024 17:54:06 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: torvalds <torvalds@linux-foundation.org>
Cc: linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <158184774.112608.1721836446346.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML Changes for v6.11-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: wQNab6Gx6T+BtYDYnsBlJQD6ezYbRg==
Thread-Topic: UML Changes for v6.11-rc1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240724_085419_179839_B4009E6D 
X-CRM114-Status: GOOD (  10.47  )
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

Linus,

The following changes since commit 22a40d14b572deb80c0648557f4bd502d7e83826:

  Linux 6.10-rc6 (2024-06-30 14:40:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.11-rc1

for you to fetch changes up to 98ff534ec2cd02496c166614e6c1391d8e092e51:

  um: vector: always reset vp->opened (2024-07-04 12:03:26 +0200)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Support for preemption
- i386 Rust support
- Huge cleanup by Benjamin Berg
- UBSAN support
- Removal of dead code

----------------------------------------------------------------
Anton Ivanov (2):
      um: Remove obsolete pcap driver
      um: Enable preemption in UML

Benjamin Berg (16):
      um: irqs: process outstanding IRQs when unblocking signals
      um: chan_user: catch EINTR when reading and writing
      um: chan_user: retry partial writes
      um: chan: use blocking IO for console output for time-travel
      um: Remove stub-data.h include from common-offsets.h
      um: Create signal stack memory assignment in stub_data
      um: Add generic stub_syscall6 function
      um: Rework syscall handling
      um: compress memory related stub syscalls while adding them
      um: remove LDT support
      um: remove copy_context_skas0
      um: Delay flushing syscalls until the thread is restarted
      um: Do not flush MM in flush_thread
      um: remove force_flush_all from fork_handler
      um: simplify and consolidate TLB updates
      um: refactor TLB update handling

David Gow (2):
      arch: um: rust: Use the generated target.json again
      arch: um: rust: Add i386 support for Rust

Dr. David Alan Gilbert (1):
      ubd: Remove unused mutex 'ubd_mutex'

Jeff Johnson (2):
      um: harddog: add missing MODULE_DESCRIPTION() macro
      hostfs: add missing MODULE_DESCRIPTION() macro

Johannes Berg (13):
      um: time-travel: fix time-travel-start option
      um: enable UBSAN
      hostfs: fix dev_t handling
      um: generalize os_rcv_fd
      um: add mmap/mremap OS calls
      um: add shared memory optimisation for time-travel=ext
      um: time-travel: remove time_exit()
      um: time-travel: fix signal blocking race/hang
      um: remove pcap driver from documentation
      um: line: always fill *error_out in setup_one_line()
      um: register power-off handler
      um: vector: remove vp->lock
      um: vector: always reset vp->opened

Mordechay Goodstein (1):
      um: time-travel: support time-travel protocol broadcast messages

Niklas Schnelle (1):
      um: Select HAS_IOREMAP for UML_IOMEM_EMULATION

Tiwei Bie (2):
      um: Remove unused ncpus variable
      um: Remove /proc/sysemu support code

Wei Yang (1):
      um/mm: remove redundant assignment of max_low_pfn

 Documentation/rust/arch-support.rst                |   2 +-
 .../virt/uml/user_mode_linux_howto_v2.rst          |   2 -
 arch/um/Kconfig                                    |   8 +-
 arch/um/drivers/Kconfig                            |  20 -
 arch/um/drivers/Makefile                           |  10 +-
 arch/um/drivers/chan.h                             |   3 +-
 arch/um/drivers/chan_kern.c                        |  81 ++-
 arch/um/drivers/chan_user.c                        |  20 +-
 arch/um/drivers/harddog_kern.c                     |   1 +
 arch/um/drivers/line.c                             |   2 +
 arch/um/drivers/pcap_kern.c                        | 113 -----
 arch/um/drivers/pcap_user.c                        | 137 ------
 arch/um/drivers/pcap_user.h                        |  21 -
 arch/um/drivers/port_kern.c                        |  14 +-
 arch/um/drivers/ubd_kern.c                         |   3 -
 arch/um/drivers/vector_kern.c                      |  19 +-
 arch/um/drivers/vector_kern.h                      |   1 -
 arch/um/drivers/xterm.c                            |   2 +-
 arch/um/drivers/xterm_kern.c                       |  13 +-
 arch/um/include/asm/mmu.h                          |  10 +-
 arch/um/include/asm/mmu_context.h                  |   2 -
 arch/um/include/asm/pgtable.h                      |  32 ++
 arch/um/include/asm/tlbflush.h                     |  46 +-
 arch/um/include/shared/as-layout.h                 |   2 +-
 arch/um/include/shared/common-offsets.h            |   5 -
 arch/um/include/shared/kern_util.h                 |   1 -
 arch/um/include/shared/os.h                        |  33 +-
 arch/um/include/shared/skas/mm_id.h                |   2 +-
 arch/um/include/shared/skas/skas.h                 |   2 +
 arch/um/include/shared/skas/stub-data.h            |  36 +-
 arch/um/include/shared/timetravel.h                |   9 +
 arch/um/include/shared/user.h                      |   8 +
 arch/um/kernel/exec.c                              |   9 -
 arch/um/kernel/irq.c                               |  80 +--
 arch/um/kernel/ksyms.c                             |   2 +-
 arch/um/kernel/mem.c                               |   1 -
 arch/um/kernel/process.c                           |  69 ---
 arch/um/kernel/reboot.c                            |  15 +
 arch/um/kernel/skas/Makefile                       |   9 +-
 arch/um/kernel/skas/clone.c                        |  48 --
 arch/um/kernel/skas/mmu.c                          |  54 +-
 arch/um/kernel/skas/process.c                      |  18 +
 arch/um/kernel/skas/stub.c                         |  69 +++
 arch/um/kernel/time.c                              | 187 ++++++-
 arch/um/kernel/tlb.c                               | 545 ++++-----------------
 arch/um/kernel/trap.c                              |  15 +-
 arch/um/kernel/um_arch.c                           |   3 -
 arch/um/os-Linux/file.c                            |  94 ++--
 arch/um/os-Linux/signal.c                          | 118 ++++-
 arch/um/os-Linux/skas/mem.c                        | 245 +++++----
 arch/um/os-Linux/skas/process.c                    | 124 +----
 arch/um/os-Linux/start_up.c                        |   1 +
 arch/x86/Makefile.um                               |   1 +
 arch/x86/um/Makefile                               |   5 +-
 arch/x86/um/asm/mm_context.h                       |  70 ---
 arch/x86/um/ldt.c                                  | 380 --------------
 arch/x86/um/shared/sysdep/stub.h                   |   2 +-
 arch/x86/um/shared/sysdep/stub_32.h                |  45 +-
 arch/x86/um/shared/sysdep/stub_64.h                |  41 +-
 arch/x86/um/stub_32.S                              |  56 ---
 arch/x86/um/stub_64.S                              |  50 --
 arch/x86/um/tls_32.c                               |   1 +
 fs/hostfs/hostfs.h                                 |   7 +-
 fs/hostfs/hostfs_kern.c                            |  11 +-
 fs/hostfs/hostfs_user.c                            |   7 +-
 include/uapi/linux/um_timetravel.h                 | 190 ++++++-
 rust/Makefile                                      |   2 +-
 scripts/Makefile                                   |   2 +-
 scripts/generate_rust_target.rs                    |  17 +
 69 files changed, 1297 insertions(+), 1956 deletions(-)
 delete mode 100644 arch/um/drivers/pcap_kern.c
 delete mode 100644 arch/um/drivers/pcap_user.c
 delete mode 100644 arch/um/drivers/pcap_user.h
 delete mode 100644 arch/um/kernel/skas/clone.c
 create mode 100644 arch/um/kernel/skas/stub.c
 delete mode 100644 arch/x86/um/asm/mm_context.h
 delete mode 100644 arch/x86/um/ldt.c
 delete mode 100644 arch/x86/um/stub_32.S
 delete mode 100644 arch/x86/um/stub_64.S

