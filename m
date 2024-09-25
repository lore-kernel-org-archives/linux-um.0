Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E58CCF9EF
	for <linux-um@archiver.kernel.org>; Wed, 25 Sep 2024 20:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MiXpG+arDJiFnMFMgMjQL654lC+ofn0bNWtLmcN+M0U=; b=xKsX770CfmJZXSQEL/seRGHm+D
	7e1sL7KvfnfQHar7LDdRr6ttoFKHY/MuQ742FcEUBsNuwABfS9DtngbfO3zVKA3cZipx3OVqPwQk6
	WDXI5FCG5R5cuNDa/HA6RpI/FKmjSKOXenavx7nP1S2U++YWnOFGVKssmCoGJK0iKWd2Y8AFdm8Uc
	N7y7iOpBavh22oPRYqj/UAcSQ09gLL6NwuytNVn4T0Y83O1WlXYnXYqF2GRsLxc6qVDMSFSQjjoh7
	mytZG4JzN2mYgpaD5FiW/CqR2m9mt00aoVDLV07oh3zb1hMHy+G7YAYw2+R2x3RTTnQhwoAjkZNDp
	XkUNyUcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1stYgv-00000006Uzp-0J8u;
	Wed, 25 Sep 2024 20:32:53 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1stYgs-00000006Uyb-1JAL
	for linux-um@lists.infradead.org;
	Wed, 25 Sep 2024 20:32:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=MiXpG+arDJiFnMFMgMjQL654lC+ofn0bNWtLmcN+M0U=; t=1727296367; x=1728505967; 
	b=FKqjOb18aufI/2z3KPDr6fyqGoNxyhuQ58PK7i7g5aE6KbznLrvMbElaFsjqqzhdNd2+pY1EvwW
	PmxctJ/CgCHBigHdetpXZZLU/B6Dhc5+ST+lOFFSGqZgD5WHGz/DDasDgoG8k9qns86OQVPmV3IPY
	6uaDuIZs6tuIhs0cq6ucWEir8a8Twlv/5CAmlH7V1Eq92n8G6kwQw1zIP2yz7EQqlmPZ/FzAuQmvP
	uhR7lQN9M6V8GKD0uZLL3mPilKoPaDPxIyF36J0hrGFjb12X3ozxtMuV1IuNypGKdrjkSE5jhb4h8
	vxvccNwNvatStI8FpgPU/hGfVQfXa5JBTttQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1stYgm-00000001A19-2xs2;
	Wed, 25 Sep 2024 22:32:45 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC PATCH 0/9] SECCOMP based userspace for UML
Date: Wed, 25 Sep 2024 22:32:23 +0200
Message-ID: <20240925203232.565086-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240925_133250_385230_118F26A2 
X-CRM114-Status: GOOD (  14.06  )
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

this is an updated version of the SECCOMP patchset. The patchset adds a
new userspace handling mode to UML that is based on a SECCOMP filter
and trusted code within each userspace process.

One advantage of this approach is that it saves quite a few context
switches when handling pagefaults (and syscalls to some extend). The
reason is that the ptrace code needs a separate context switch to
execute syscalls in the stub as well as another one to grab the segfault
information.

This new version of the patchset changes the security model to use FD
passing for the memory to ensure only the stub code can use the
permitted syscalls. Note that the current SECCOMP filter is not yet
sufficient to prevent userspace from tricking the kernel (and stub) to
map any physical memory.

Also new is working i386 support.

Benjamin

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

 arch/um/Kconfig                            |  20 +
 arch/um/include/asm/irq.h                  |   5 +-
 arch/um/include/shared/common-offsets.h    |   3 +
 arch/um/include/shared/irq_user.h          |   1 +
 arch/um/include/shared/os.h                |   3 +-
 arch/um/include/shared/skas/mm_id.h        |  16 +
 arch/um/include/shared/skas/skas.h         |   6 +
 arch/um/include/shared/skas/stub-data.h    |  21 +-
 arch/um/kernel/irq.c                       |   5 +
 arch/um/kernel/skas/mmu.c                  |  98 +++-
 arch/um/kernel/skas/stub.c                 | 131 +++++-
 arch/um/kernel/skas/stub_exe.c             | 162 ++++++-
 arch/um/kernel/tlb.c                       |  21 +-
 arch/um/os-Linux/internal.h                |   4 +
 arch/um/os-Linux/process.c                 |  31 ++
 arch/um/os-Linux/registers.c               |   4 +-
 arch/um/os-Linux/signal.c                  |  19 +-
 arch/um/os-Linux/skas/mem.c                | 104 ++++-
 arch/um/os-Linux/skas/process.c            | 501 +++++++++++++++------
 arch/um/os-Linux/start_up.c                | 150 +++++-
 arch/x86/um/os-Linux/mcontext.c            | 203 ++++++++-
 arch/x86/um/shared/sysdep/kernel-offsets.h |   2 +
 arch/x86/um/shared/sysdep/mcontext.h       |   9 +
 arch/x86/um/shared/sysdep/stub-data.h      |  18 +
 arch/x86/um/shared/sysdep/stub.h           |   2 +
 arch/x86/um/shared/sysdep/stub_32.h        |  13 +
 arch/x86/um/shared/sysdep/stub_64.h        |  14 +
 arch/x86/um/tls_32.c                       |  23 +-
 28 files changed, 1388 insertions(+), 201 deletions(-)
 create mode 100644 arch/x86/um/shared/sysdep/stub-data.h

-- 
2.46.1


