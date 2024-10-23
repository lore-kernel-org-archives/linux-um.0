Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC9FCF538E
	for <linux-um@archiver.kernel.org>; Wed, 23 Oct 2024 14:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2Gaq5kZuSr1XESNAScZqZeRTyDyAMqFHxxLMTBY++FY=; b=KVVjkzXnpdh03WJHdQcsB3gswo
	kU4vX7Pim3o9vXJzBGEWDfzZZLcnTmu4XOsy06sktyeyNgxDc+tguAR5sOQkPsPyxpU7o8/zMJvQT
	PEMyUDn7dOsBTihfMtAum7sfxIJeYC/JFHwRXLuEh18FEZm4685DG6UufxEMTXk6dqi5f5xpyjUIi
	5E+SepDXuLcQTnRiMiP41fjZPGLEp79+6Tg+4vVtOnA66HrHgZP+4e3pg6wP2vvWr2/Te+h65fg1l
	Rw/lE78bkOIUT4PRXAaa4940izv2M8KjLaEKkw49Vx9OJajdWemBrbD1Kg6zQpzBC2EhwkV62sSyM
	VdYiQWLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3c36-0000000EeI1-391v;
	Wed, 23 Oct 2024 14:09:20 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3c33-0000000EeFM-04T7
	for linux-um@lists.infradead.org;
	Wed, 23 Oct 2024 14:09:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=2Gaq5kZuSr1XESNAScZqZeRTyDyAMqFHxxLMTBY++FY=; t=1729692555; x=1730902155; 
	b=GOOkkmxZnxGo5pH619tI21rWaTybvy+3Z/bqZhrCxKDeRPhPhPtTKuO3jNY2QrHlHpomvxYTRqD
	GsqW/LIjHrMiUIXUbiWpZQ5D6nBltiWooxK5+W5wgV6P3GHxlNRRM1AsWPO/UmzocAPJ0MAsL9cpt
	a3E9N0V3A4dL4qulD3G1BZVz1ac7O8FZXViRc0TZ63Sv6+LyylL1lLCtAt/gDQ8UzChfBoedXUTCm
	3I4yULdSENVx5gjzeV74UPYktFswwLmzXOxe4TZPG6sA01HuwXxs8pt2esL6w1RmkvM9ynO6CJ7ja
	f97dgdJ6QyXUb/RsOWQJmJS053IS5Dn/1p9A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t3c2y-00000002hDF-2rts;
	Wed, 23 Oct 2024 16:09:12 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC PATCH v2 0/9] SECCOMP based userspace for UML
Date: Wed, 23 Oct 2024 16:08:18 +0200
Message-ID: <20241023140827.136550-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_070917_079514_792C4CE9 
X-CRM114-Status: GOOD (  12.58  )
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

here is an updated version of the SECCOMP patchset. The main improvement
to the previous RFC version is that now FP registers will work correctly
on 32 bit. I hope it is in a relatively good state overall, but I expect
we will not merge this into 6.13.

The patchset adds a new userspace handling mode to UML that is based on
a SECCOMP filter and trusted code within each userspace process.

One advantage of this approach is that it saves quite a few context
switches when handling pagefaults (and syscalls to some extend). The
reason is that the ptrace code needs a separate context switch to
execute syscalls in the stub as well as another one to grab the segfault
information.

Benjamin

RFCv2:
- Fix FP handling on i386
- Improved MM list for userspace sigchild handling

Benjamin Berg (9):
  um: Store full CSGSFS and SS register from mcontext
  um: Move faultinfo extraction into userspace routine
  um: Add UML_SECCOMP configuration option
  um: Add stub side of SECCOMP/futex based process handling
  um: Add helper functions to get/set state for SECCOMP
  um: Add SECCOMP support detection and initialization
  um: Track userspace children dying in SECCOMP mode
  um: Implement kernel side of SECCOMP based process handling
  um: pass FD for memory operations when needed

 arch/um/Kconfig                            |  19 +
 arch/um/include/asm/irq.h                  |   5 +-
 arch/um/include/asm/mmu.h                  |   3 +
 arch/um/include/shared/common-offsets.h    |   4 +
 arch/um/include/shared/irq_user.h          |   1 +
 arch/um/include/shared/os.h                |   3 +-
 arch/um/include/shared/skas/mm_id.h        |  13 +
 arch/um/include/shared/skas/skas.h         |   6 +
 arch/um/include/shared/skas/stub-data.h    |  21 +-
 arch/um/kernel/irq.c                       |   5 +
 arch/um/kernel/skas/mmu.c                  |  90 +++-
 arch/um/kernel/skas/stub.c                 | 131 +++++-
 arch/um/kernel/skas/stub_exe.c             | 156 ++++++-
 arch/um/os-Linux/internal.h                |   4 +
 arch/um/os-Linux/process.c                 |  31 ++
 arch/um/os-Linux/registers.c               |   4 +-
 arch/um/os-Linux/signal.c                  |  19 +-
 arch/um/os-Linux/skas/mem.c                | 104 ++++-
 arch/um/os-Linux/skas/process.c            | 493 +++++++++++++++------
 arch/um/os-Linux/start_up.c                | 148 ++++++-
 arch/x86/um/os-Linux/mcontext.c            | 223 +++++++++-
 arch/x86/um/ptrace.c                       |  76 +++-
 arch/x86/um/shared/sysdep/kernel-offsets.h |   2 +
 arch/x86/um/shared/sysdep/mcontext.h       |  10 +
 arch/x86/um/shared/sysdep/stub-data.h      |  23 +
 arch/x86/um/shared/sysdep/stub.h           |   2 +
 arch/x86/um/shared/sysdep/stub_32.h        |  13 +
 arch/x86/um/shared/sysdep/stub_64.h        |  14 +
 arch/x86/um/tls_32.c                       |  23 +-
 29 files changed, 1437 insertions(+), 209 deletions(-)
 create mode 100644 arch/x86/um/shared/sysdep/stub-data.h

-- 
2.47.0


