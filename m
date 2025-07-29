Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8525DC83F26
	for <linux-um@archiver.kernel.org>; Tue, 29 Jul 2025 10:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=egSGjMlFbH3dU8UYE7+I38neCytKIOjPn2LRtM5SThY=; b=Xtwek7iKcSESNx8w2iS09LQz7F
	cXa8PGhRwvFO7aEpDVm5+5PR/7H4ykuStjHhKeCE30FMP+Fofyvx7IMkdwfXfH4F8+gr//CfJFwSA
	Jh1v1lFgxAFC+zRyY60nink+tYak4PbsOKx8kVSQSNQ1Le5M3wh7MIjqZjj9aJ29Hrqkbdq3GEWHY
	gVJJfSLrc0G4NxML+DeGVHp0KEkqv9sRV63gYdFydyOJNkODCMwAExfkMgJR4F1RNl/YfV9HMVNqA
	zVsvBu8o7+MLsa5NPASvSPaPXDGtja7rjdQ4DkzWIqtzkvdwn8g/rj9dbdQs/VxwGcJ8Zd2UHeRaM
	KCZ1TYzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ughCo-0000000GTvm-2fFW;
	Tue, 29 Jul 2025 10:05:10 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ughCk-0000000GTuz-1zGo
	for linux-um@lists.infradead.org;
	Tue, 29 Jul 2025 10:05:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=egSGjMlFbH3dU8UYE7+I38neCytKIOjPn2LRtM5SThY=; t=1753783506; x=1754993106; 
	b=E8+j30PjlzZs5lE2gVou5BCmb4FoQyH7qejqnJONdxwVqV3YrIgrPCmashDn+QZFFC/xrkMYKBJ
	GPPSqNZI1QkIb/XDv3t5U09cfNwR6fMpvYgAnig9HKp0cNStT2/DF92ZT64lxOqQx8qNotRWwWbHP
	Jvwaaix3FH5fsQq9nePzlXr+R3wpBAKU6Pbrg1QGraL+P4gthmj7YLmyJTik4bCqJONNYWoA3oWQL
	swhMy8kTP4ftd4V4lGm+9jIOqPoKm9GzpdHLw+elGFiVfFFGvTI2rp7KJPV4eOInwwf3AT1FzfhgL
	kV182uTz2kt6iwb/tOCGP2ggwhBuRTZWdnaw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ughCh-0000000ENqf-0sAD;
	Tue, 29 Jul 2025 12:05:03 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [GIT PULL] uml 6.17-rc1
Date: Tue, 29 Jul 2025 12:02:03 +0200
Message-ID: <20250729100457.14550-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_030506_544296_C1EE152F 
X-CRM114-Status: GOOD (  12.30  )
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

Hi Linus,

There's really not much for UML for 6.17-rc1, mostly
cleanups and two small new features as noted in the
tag message below.

We're still discussing how best to do NOMMU and SMP
(currently have a partial patchset, only kernel-space
is really doing SMP) but neither is ready yet.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af:

  Linux 6.16-rc4 (2025-06-29 13:09:04 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linux-6.17-rc1

for you to fetch changes up to fc9ed2f6589dc2c11f05883e5c323be5f39fd241:

  um: Replace __ASSEMBLY__ with __ASSEMBLER__ in the usermode headers (2025-07-22 17:12:45 +0200)

----------------------------------------------------------------
Mostly cleanups, except:
 - dynamic addition of vfio passthrough devices
 - implementation of HAVE_SYSCALL_TRACEPOINTS

----------------------------------------------------------------
Johannes Berg (1):
      um: simplify syscall header files

Nam Cao (1):
      um: virt-pci: Switch to msi_create_parent_irq_domain()

Thomas Huth (1):
      um: Replace __ASSEMBLY__ with __ASSEMBLER__ in the usermode headers

Thomas Weißschuh (3):
      um/x86: Add system call table to header file
      um/ptrace: Implement HAVE_SYSCALL_TRACEPOINTS
      um: Re-evaluate thread flags repeatedly

Tiwei Bie (9):
      um: virtio_pcidev: Rename UM_PCI_STAT_WAITING
      um: Make unscheduled_userspace_iterations static
      um: Make mm_list and mm_list_lock static
      um: Avoid redefining ARCH_HAS_CACHE_LINE_SIZE
      um: rtc: Avoid shadowing err in uml_rtc_start()
      um: vfio: Support adding devices via mconsole
      um: Use err consistently in userspace()
      um: Remove the pid parameter of handle_trap()
      um: Stop tracking stub's PID via userspace_pid[]

 arch/um/Kconfig                         |  5 ++-
 arch/um/drivers/Kconfig                 |  1 +
 arch/um/drivers/rtc_user.c              |  2 +-
 arch/um/drivers/vfio_kern.c             | 62 ++++++++++++++++++++++++++++++---
 arch/um/drivers/virt-pci.c              | 43 +++++++++++------------
 arch/um/drivers/virtio_pcidev.c         |  8 ++---
 arch/um/include/asm/cpufeature.h        |  4 +--
 arch/um/include/asm/current.h           |  4 +--
 arch/um/include/asm/mmu_context.h       |  9 +----
 arch/um/include/asm/page.h              |  4 +--
 arch/um/include/asm/ptrace-generic.h    |  2 +-
 arch/um/include/asm/thread_info.h       |  8 ++++-
 arch/um/include/shared/as-layout.h      |  2 +-
 arch/um/include/shared/skas/mm_id.h     |  2 --
 arch/um/include/shared/skas/skas.h      |  1 -
 arch/um/kernel/exec.c                   |  2 --
 arch/um/kernel/process.c                | 18 ++++++----
 arch/um/kernel/ptrace.c                 |  9 +++++
 arch/um/kernel/skas/mmu.c               |  4 +--
 arch/um/kernel/skas/process.c           |  2 --
 arch/um/kernel/skas/syscall.c           | 11 ++++--
 arch/um/os-Linux/skas/process.c         | 35 ++++++++-----------
 arch/x86/um/asm/syscall.h               |  2 ++
 arch/x86/um/shared/sysdep/ptrace.h      | 12 -------
 arch/x86/um/shared/sysdep/syscalls.h    |  6 ----
 arch/x86/um/shared/sysdep/syscalls_32.h | 14 --------
 arch/x86/um/shared/sysdep/syscalls_64.h | 28 ---------------
 arch/x86/um/tls_32.c                    |  2 +-
 28 files changed, 151 insertions(+), 151 deletions(-)
 delete mode 100644 arch/x86/um/shared/sysdep/syscalls.h
 delete mode 100644 arch/x86/um/shared/sysdep/syscalls_32.h
 delete mode 100644 arch/x86/um/shared/sysdep/syscalls_64.h

