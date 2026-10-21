Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBCE606A31C
	for <linux-um@archiver.kernel.org>; Wed, 21 Oct 2026 08:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=w5WwevLN;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=xE7xERJt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TKa2RUGDTuW7MaQZY0caVZamvGGq5PFEOZyolx/azi4=; b=w5WwevLN4XTdgwgbg13CcdBy2I
	j7BdvSCMGn9LV6boPyHzuGKIIt1h9vewmAf5OdCNiRRr7L7z8BZx35oHgYMTn/rWmL4kTyEDfKXTS
	t5JmN3COvMktMaGbo9hd8KxY+DjgtY28xu+BrQ72Tvcg5I19e3gWRY+Az/OyOzKMv+ZCw21i8FDhp
	LUhDr/+BTk2aBOYNIuyZLwPDpkyZ11j5je4+E9T/EJm4VybFlA/ap9mpnxNLos50Km6Q/UBgT/2Hu
	e+NG15wn8WB0ew0gotIYNugWxOG9ttk2Rw5ZUnNkPtbJzZs1GuemB8lyb2YFGcZUd8ozHjf1IC/eT
	yOt2Kdkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJRTJ-0000000BJiY-120e;
	Wed, 21 Oct 2026 08:14:53 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJRTG-0000000BJhr-0wOf
	for linux-um@lists.infradead.org;
	Wed, 21 Oct 2026 08:14:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=TKa2RUGDTuW7MaQZY0caVZamvGGq5PFEOZyolx/azi4=; t=1792570490; x=1793780090; 
	b=xE7xERJtbWN42xd9Z4MnBzgRgpWovQ51Ag0AX/FiNG1w7cb+MkF9mx4O5PMVlTymXZhehKUWks+
	8eJnoiNVLzx/tBtZdN1u/EC6M2ksuNq23rWXYAty5C+ATUOPG0en6cpGOMvKLAbzDNB5HtjOfM4xV
	jI8+X+GWGEh3gdV7AQdWDjiYYhxIvswM5t7nwsybB5MgZyBxvlr/267lTDedT9nIXzGk/tAS2b6Q9
	g3qYNiLv91UBFyj9DlpnK7qskjk5j05gvA++BWz/xt8izLbhxE1YvdSFAm52Dshi+dFgh/rV3YXM8
	mGvXpJa6h6wJ8X6eJBxra2mw8BWbxb9v0JHg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xJRTB-00000001uEY-1hd4;
	Wed, 21 Oct 2026 10:14:46 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [GIT PULL] uml-for-7.4
Date: Wed, 21 Oct 2026 10:13:21 +0200
Message-ID: <20261021081440.697408-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_011450_702368_49E1B56C 
X-CRM114-Status: GOOD (  18.03  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-22.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Linus,

The last couple of cycles were a lull for UML, in part
because not _that_ much happened, and in part because
we were all busy with "more important" things (*ahem*).
We're back ;-) Still no huge changes, but we're adding
the long-awaited NOMMU support this round.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 93f51579e7df248780214094418f205253383cc5:

  Linux 7.3-rc4 (2026-09-20 13:48:15 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-7.4

for you to fetch changes up to 4ad423aa2108485f8bc5dde51fdf9c1ed979ee4b:

  um: place large BSS inputs in an output section (2026-10-12 17:03:17 +0200)

----------------------------------------------------------------
ARCH=um updates:

 - NOMMU support, mostly for mm/ testing

   The only bigger change, we added support for building with
   !CONFIG_MMU, mostly for testing, e.g. via kunit. Some new
   selftests targetted to NOMMU are moving elsewhere, but are
   runnable on ARCH=um without MMU.

 - Tighter page permissions

   Tighten page permissions to catch more bugs (ARCH=um is,
   after all, often used for testing), and also mark __init
   memory inaccessible for the same reason.

 - Various maintenance/cleanups

   Fix build on really old hosts, fix leaks, make the code a
   bit more robust, header cleanups, typo fixes, the usual.

----------------------------------------------------------------
Andy Shevchenko (1):
      um: vector: Use %pM format specifier for MAC addresses

Benjamin Berg (1):
      um: virtio-pci: free the IRQ message buffers

Ethan Nelson-Moore (1):
      x86/um: remove unused <asm/required-features.h> header

Florian Fainelli (1):
      um: Add definition of __NR_close_range for older host OSs

Hajime Tazaki (7):
      x86/um: nommu: elf loader for fdpic
      um: decouple MMU specific code from the common part
      um: nommu: memory handling
      x86/um/vdso: nommu: vdso memory update
      um: allow deselecting CONFIG_MMU
      um: require MMU for UML PCI support
      um: place large BSS inputs in an output section

Hemanth Selam (1):
      um: fix typo "hander" in comment

Henry Barreto (1):
      um: vector: avoid NULL queue dereference in legacy RX mode

Johan Hovold (1):
      um: virtio_uml: switch to dynamic root device

Johannes Berg (14):
      um: fix futex implementation
      um: further decouple MMU related code
      um: nommu: add SMP futex operations
      um: nommu: add userspace runner processes
      Documentation: um: document nommu UML
      um: add perf-event support
      um: link .lbss/.ldata/.lrodata correctly
      um: make stub compilation more robust
      um: improve checking for --no-warn-rwx-segments
      um: move init text between __init_begin/end
      um: mprotect() __init memory
      um: use %pB to print functions in stack traces
      um: time-travel: fix sched_yield() behaviour
      um: fix shutdown __inittext access

Maninder Singh (1):
      um: take reference of stack before using it in get_wchan

Michael Bommarito (2):
      um: virtio_uml: fix heap overflow in vhost_user_get_config()
      um: ubd: validate COW header fields before use

Pengpeng Hou (3):
      um: account for the separator in add_arg() bounds checking
      um: mconsole: use bounded version string formatting
      um: vector: reject too many interface arguments

Sasha Levin (1):
      um: Consolidate MAGIC_SYSRQ into generic Kconfig definition

Shengzhuo Wei (1):
      um: mconsole: Fix out-of-bounds read in mconsole_log()

Tiwei Bie (2):
      um: vector: Remove unnecessary NULL check in destroy_queue()
      um: Tighten exec permissions on page mappings

 Documentation/virt/index.rst            |   1 +
 Documentation/virt/uml/nommu-uml.rst    |  54 ++++++++
 arch/um/Kconfig                         |  40 +++---
 arch/um/Makefile                        |   7 +-
 arch/um/drivers/Kconfig                 |   3 +
 arch/um/drivers/cow_user.c              |  34 ++++-
 arch/um/drivers/mconsole_kern.c         |  14 +-
 arch/um/drivers/vector_kern.c           |  37 +++--
 arch/um/drivers/vector_user.c           |   3 +
 arch/um/drivers/virtio_pcidev.c         |  19 ++-
 arch/um/drivers/virtio_uml.c            |  26 ++--
 arch/um/include/asm/common.lds.S        |   2 +
 arch/um/include/asm/futex.h             |  53 +++++++
 arch/um/include/asm/mmu.h               |   8 ++
 arch/um/include/asm/mmu_context.h       |   2 +
 arch/um/include/asm/perf_event.h        |   7 +
 arch/um/include/asm/pgtable.h           |  25 ++--
 arch/um/include/asm/ptrace-generic.h    |   6 +
 arch/um/include/asm/tlbflush.h          |  20 +++
 arch/um/include/asm/uaccess.h           |   6 +-
 arch/um/include/shared/as-layout.h      |   3 +-
 arch/um/include/shared/kern_util.h      |   3 +-
 arch/um/include/shared/longjmp.h        |   3 +-
 arch/um/include/shared/os.h             |   6 +-
 arch/um/include/shared/skas/stub-data.h |   9 ++
 arch/um/kernel/Makefile                 |   6 +-
 arch/um/kernel/dyn.lds.S                |   9 +-
 arch/um/kernel/mem-pgtable.c            |  55 ++++++++
 arch/um/kernel/mem.c                    |  47 ++-----
 arch/um/kernel/physmem.c                |   7 +
 arch/um/kernel/process.c                |  23 +++-
 arch/um/kernel/skas/Makefile            |  16 ++-
 arch/um/kernel/skas/mmu.c               |  25 ++++
 arch/um/kernel/skas/nommu.c             |  91 ++++++++++++
 arch/um/kernel/skas/process.c           |  32 +----
 arch/um/kernel/skas/syscall.c           |   5 +-
 arch/um/kernel/skas/uaccess.c           | 134 +++++++-----------
 arch/um/kernel/smp.c                    |   3 +-
 arch/um/kernel/sysrq.c                  |   2 +-
 arch/um/kernel/time.c                   |   3 +-
 arch/um/kernel/tlb.c                    |   7 -
 arch/um/kernel/trap-mmu.c               | 237 ++++++++++++++++++++++++++++++++
 arch/um/kernel/trap-nommu.c             |  13 ++
 arch/um/kernel/trap.c                   | 219 -----------------------------
 arch/um/kernel/um_arch.c                |  11 +-
 arch/um/kernel/uml.lds.S                |  11 +-
 arch/um/os-Linux/main.c                 |  17 ++-
 arch/um/os-Linux/signal.c               |   2 +-
 arch/um/os-Linux/skas/process.c         |  11 +-
 arch/x86/um/Makefile                    |   3 +
 arch/x86/um/asm/elf.h                   |   8 +-
 arch/x86/um/asm/required-features.h     |   9 --
 arch/x86/um/vdso/vma.c                  |  13 +-
 fs/Kconfig.binfmt                       |   2 +-
 lib/Kconfig.debug                       |  10 +-
 lib/kunit/Kconfig                       |   2 +-
 56 files changed, 907 insertions(+), 517 deletions(-)
 create mode 100644 Documentation/virt/uml/nommu-uml.rst
 create mode 100644 arch/um/include/asm/perf_event.h
 create mode 100644 arch/um/kernel/mem-pgtable.c
 create mode 100644 arch/um/kernel/skas/nommu.c
 create mode 100644 arch/um/kernel/trap-mmu.c
 create mode 100644 arch/um/kernel/trap-nommu.c
 delete mode 100644 arch/x86/um/asm/required-features.h

