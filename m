Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58099C04FF8
	for <linux-um@archiver.kernel.org>; Thu, 18 Apr 2024 09:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QAqu1EObyO2AUUPkmwjgqPM1zMAXA//Yf/WXvlkBwzs=; b=Z2nwyUkbby1dQKXRXMNfrYVmy+
	Jm4ZtnaJfw8ytdxvFllnjNNQAZfIc41xStZjbVn20npz7bm5NWrXFv7ZxUKcnpj8BQByPjr9MRGyH
	zYPODD17H2jjWWAHalo3z5/Ujwzrcy7u6Zj4EuK+Y82S39RQYXR9DyDt8UEfxrXy2w1UonMJEJ2vt
	Zu4aJRa1HmtDWcblLOllyxlg0JK78xwjF2NhnsMXqb/j/NmzIUbYszVHTTdVC+PTXa7Fg/U1osywT
	bHWC+4YLAJ/NISvHuo/N/Re2OmFPkhzjJZJmokIJw3xO1QPGBjFrN4Awc+jlzuYhizklnuvhDqXXt
	NRetZ1MA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxO0n-00000001bGi-39jt;
	Thu, 18 Apr 2024 09:24:57 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxO0k-00000001bBy-0GxF
	for linux-um@lists.infradead.org;
	Thu, 18 Apr 2024 09:24:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=QAqu1EObyO2AUUPkmwjgqPM1zMAXA//Yf/WXvlkBwzs=; t=1713432291; x=1714641891; 
	b=S3T4PTiUz0NdAbmoOnxubwNa9AePYmN57mqvCR9XvbZIPqXnU8+sKokkFinrihyYjNFep3jn1oU
	Cuz49gYWCxLr58lCmTT6PX+myA33bOkAxvUSaStaV4FzvDirUnLrENMS7EopB4j7A6GtvGgBHCCfn
	xY+DvTpZZkOYWdGG/a0l3YnR5nhQEOtNhBUnkswRkis77vxYTV8EkLRrmzNeC8XurNz7zSVtT2xil
	VWm2kE0osHeqjN2uQ8VWGeeCuCx/mNQFZuNDzYFOZjtrv1uqnQFGiNCEOJBa7oyzIvoZ6aJmhD2PQ
	ou/QmBeSdXgVd7D7z1fYwlyHHMUPmdIVLjUw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1rxO0d-0000000CKXH-4C2F;
	Thu, 18 Apr 2024 11:24:48 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 00/12] Rework stub syscall and page table handling
Date: Thu, 18 Apr 2024 11:23:15 +0200
Message-ID: <20240418092327.860135-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_022454_592261_3A0B2E05 
X-CRM114-Status: GOOD (  11.96  )
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

This patchset reworks the stub syscall handling and also redos how page
table updates are tracked and synchronized. Some of this originated in
the SECCOMP patchset, but it became clear that these refactorings make
sense independently as they result in a considerably fewer page faults.

As an example, these changes bring the runtime of one of the hostapd
hwsim test modules from 121 seconds down to 103 seconds. Actual results
will depend heavily on how pagefault heavy the workload is.

Lowering the amount of pagefaults is due to proactively syncing PTEs
that are set (and were previously unset) and also delaying
synchronization so that multiple updates can be done in one step rather
than requiring multiple task switches.

This refactoring also fixes various odd corner cases in how UML was
handling memory and cloning of MMs. As part of this work, support for
LDTs has been dropped. My expectation is that this is not a problem as
it should only be needed by legacy applications.

Benjamin Berg (12):
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

 arch/um/include/asm/mmu.h               |  10 +-
 arch/um/include/asm/mmu_context.h       |   2 -
 arch/um/include/asm/pgtable.h           |  32 ++
 arch/um/include/asm/tlbflush.h          |  46 +-
 arch/um/include/shared/as-layout.h      |   2 +-
 arch/um/include/shared/common-offsets.h |   5 -
 arch/um/include/shared/os.h             |  27 +-
 arch/um/include/shared/skas/mm_id.h     |   2 +-
 arch/um/include/shared/skas/skas.h      |   2 +
 arch/um/include/shared/skas/stub-data.h |  35 +-
 arch/um/include/shared/user.h           |   8 +
 arch/um/kernel/exec.c                   |   9 -
 arch/um/kernel/process.c                |   2 -
 arch/um/kernel/skas/Makefile            |   9 +-
 arch/um/kernel/skas/clone.c             |  48 ---
 arch/um/kernel/skas/mmu.c               |  33 +-
 arch/um/kernel/skas/process.c           |  18 +
 arch/um/kernel/skas/stub.c              |  69 +++
 arch/um/kernel/tlb.c                    | 551 ++++--------------------
 arch/um/kernel/trap.c                   |  15 +-
 arch/um/os-Linux/skas/mem.c             | 248 ++++++-----
 arch/um/os-Linux/skas/process.c         | 121 +-----
 arch/um/os-Linux/start_up.c             |   1 +
 arch/x86/um/Makefile                    |   4 +-
 arch/x86/um/asm/mm_context.h            |  70 ---
 arch/x86/um/ldt.c                       | 380 ----------------
 arch/x86/um/shared/sysdep/stub.h        |   1 +
 arch/x86/um/shared/sysdep/stub_32.h     |  29 +-
 arch/x86/um/shared/sysdep/stub_64.h     |  23 +-
 arch/x86/um/stub_32.S                   |  56 ---
 arch/x86/um/stub_64.S                   |  50 ---
 arch/x86/um/tls_32.c                    |   1 +
 32 files changed, 543 insertions(+), 1366 deletions(-)
 delete mode 100644 arch/um/kernel/skas/clone.c
 create mode 100644 arch/um/kernel/skas/stub.c
 delete mode 100644 arch/x86/um/asm/mm_context.h
 delete mode 100644 arch/x86/um/ldt.c
 delete mode 100644 arch/x86/um/stub_32.S
 delete mode 100644 arch/x86/um/stub_64.S

-- 
2.44.0


