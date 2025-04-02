Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985A1C28B20
	for <linux-um@archiver.kernel.org>; Wed,  2 Apr 2025 07:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8Uxm9+F0fhp9GGuGeAfwRTxu3LheUGZ+7gyp1IVY2Dg=; b=VFEKNv+54kE+Rv8MVmyE2sKWxb
	EwaJPBZnG/R6i0WF2RNxpLJxF4uvc3lILm4WS5GzN/Z0iBqcys1cu5CpdoDxvXUAUf01SPx7ZyBJz
	VngYMWZhe3lnW8C8752SayQSJ3UY+PS/t+GbvfzWc08VBkWofYvALtU0cEF2WzMnhtW4A5g8A6K8m
	ylVPatZKpplScwHjDUi8Q+pithY+OprH3QtNchO/da+k5CcKqqqd0VaOHppsk3wwahgrxUz3JA0na
	abAgs8ZXBDdDetp8OWu0UuYD4HleK3tSWLC40o3aDUEzEeeJbRs3gVedWcjjtroaieEPYzulP3KB5
	5zT7BFxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzssc-00000005REg-3eJv;
	Wed, 02 Apr 2025 07:51:22 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzspS-00000005QgB-2jBu
	for linux-um@lists.infradead.org;
	Wed, 02 Apr 2025 07:48:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=8Uxm9+F0fhp9GGuGeAfwRTxu3LheUGZ+7gyp1IVY2Dg=; t=1743580083; x=1744789683; 
	b=yN/YWnroMtMSgJhDHtjYzfUXkzusm6LRlQ9+0YY/JP2jI/yfM7lp6CSEDs7zHTZ3HnCUxyX93Q8
	ACkI3F1dzAF31Ha3BgtECS6Qh8x6Kg1rpig3bhm4wkoqHxRRnQCNf1QQpJn14pfQXQAx5D6x1Eq9Y
	Fk9NwziBajGxhqjGEynq85kPpzqbAzssx3uM96v+u0Cn+JYVWqN13khFh5hUpLEzLjEa6SHFqENlN
	PZJNXNkJ1BeVsLo5THAZUC7Ur5Nc/Edzkrha5KPe2Z0XrGa4+1iHDRJYJ123UQVc4lkngEw5VKFyB
	xVI9kzMjF7hWXLUa+m5/Y+lF24Ak/NjRTGpA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tzspA-0000000DGET-0s9L;
	Wed, 02 Apr 2025 09:47:49 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@kernel.org,
	linux-um@lists.infradead.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: pull-request: uml 6.15-rc1
Date: Wed,  2 Apr 2025 09:47:09 +0200
Message-ID: <20250402074725.12307-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_004806_699618_5EF28004 
X-CRM114-Status: GOOD (  14.13  )
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

So I'm filling in for Richard (CC'ed) since he's been busy
and I've been mostly working on getting things reviewed and
merged this cycle. Nothing super exciting, see the summary
in the tag below.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 7eb172143d5508b4da468ed59ee857c6e5e01da6:

  Linux 6.14-rc5 (2025-03-02 11:48:20 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linux-6.15-rc1

for you to fetch changes up to 33c9da5dfb18c2ff5a88d01aca2cf253cd0ac3bc:

  um: Rewrite the sigio workaround based on epoll and tgkill (2025-03-20 09:28:44 +0100)

----------------------------------------------------------------
Updates for UML for this cycle, notably:
 - proper nofault accesses and read-only rodata
 - hostfs fix for host inode number reuse
 - fixes for host errno handling
 - various cleanups/small fixes

----------------------------------------------------------------
Benjamin Berg (4):
      um: remove copy_from_kernel_nofault_allowed
      um: hostfs: avoid issues on inode number reuse by host
      um: work around sched_yield not yielding in time-travel mode
      um: Store full CSGSFS and SS register from mcontext

David Gow (1):
      um: Pass the correct Rust target and options with gcc

Ethan Carter Edwards (1):
      um: use str_yes_no() to remove hardcoded "yes" and "no"

Hajime Tazaki (1):
      um: x86: clean up elf specific definitions

Johannes Berg (1):
      um: mark rodata read-only and implement _nofault accesses

Tiwei Bie (8):
      um: Allocate vdso page pointer statically
      um: Update min_low_pfn to match changes in uml_reserved
      um: virt-pci: Refactor virtio_pcidev into its own module
      um: Add pthread-based helper support
      um: ubd: Switch to the pthread-based helper
      um: Switch to the pthread-based helper in sigio workaround
      um: Prohibit the VM_CLONE flag in run_helper_thread()
      um: Rewrite the sigio workaround based on epoll and tgkill

Uros Bizjak (1):
      um/locking: Remove semicolon from "lock" prefix

 arch/um/Kconfig                          |   1 +
 arch/um/drivers/Kconfig                  |  12 +-
 arch/um/drivers/Makefile                 |   3 +-
 arch/um/drivers/random.c                 |   2 +-
 arch/um/drivers/rtc_user.c               |   2 +-
 arch/um/drivers/ubd.h                    |   6 +-
 arch/um/drivers/ubd_kern.c               |  25 +-
 arch/um/drivers/ubd_user.c               |  14 +-
 arch/um/drivers/virt-pci.c               | 743 ++++++-------------------------
 arch/um/drivers/virt-pci.h               |  41 ++
 arch/um/drivers/virtio_pcidev.c          | 628 ++++++++++++++++++++++++++
 arch/um/include/asm/Kbuild               |   1 +
 arch/um/include/asm/processor-generic.h  |   2 +
 arch/um/include/asm/uaccess.h            |  20 +-
 arch/um/include/linux/time-internal.h    |   2 +
 arch/um/include/shared/arch.h            |   2 +
 arch/um/include/shared/as-layout.h       |   2 +-
 arch/um/include/shared/irq_user.h        |   3 +-
 arch/um/include/shared/kern_util.h       |  12 +-
 arch/um/include/shared/os.h              |   8 +-
 arch/um/include/shared/sigio.h           |   1 -
 arch/um/kernel/Makefile                  |   2 +-
 arch/um/kernel/irq.c                     |   3 +-
 arch/um/kernel/maccess.c                 |  19 -
 arch/um/kernel/mem.c                     |  11 +
 arch/um/kernel/sigio.c                   |  26 --
 arch/um/kernel/skas/syscall.c            |  11 +
 arch/um/kernel/trap.c                    |  28 +-
 arch/um/kernel/um_arch.c                 |   3 +-
 arch/um/os-Linux/helper.c                |  67 +++
 arch/um/os-Linux/process.c               |  51 ---
 arch/um/os-Linux/sigio.c                 | 358 +++------------
 arch/um/os-Linux/signal.c                |   4 +-
 arch/um/os-Linux/skas/process.c          |   8 +-
 arch/x86/Makefile.um                     |   7 +-
 arch/x86/um/asm/barrier.h                |   6 +-
 arch/x86/um/asm/module.h                 |  24 -
 arch/x86/um/os-Linux/mcontext.c          |  15 +-
 arch/x86/um/shared/sysdep/faultinfo_32.h |  12 +
 arch/x86/um/shared/sysdep/faultinfo_64.h |  12 +
 arch/x86/um/vdso/vma.c                   |  17 +-
 fs/hostfs/hostfs.h                       |   2 +-
 fs/hostfs/hostfs_kern.c                  |   7 +-
 fs/hostfs/hostfs_user.c                  |  59 +--
 44 files changed, 1146 insertions(+), 1136 deletions(-)
 create mode 100644 arch/um/drivers/virt-pci.h
 create mode 100644 arch/um/drivers/virtio_pcidev.c
 delete mode 100644 arch/um/kernel/maccess.c
 delete mode 100644 arch/x86/um/asm/module.h

