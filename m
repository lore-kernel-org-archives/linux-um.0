Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69631C5AD49
	for <linux-um@archiver.kernel.org>; Mon,  2 Jun 2025 13:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wgki+cMOC8pHzeodgCagi2iIVprgOhLci+G/dKq1d6c=; b=tNXz9jro7gBWEliVX+JlY5WiZV
	fliMA4dxEY3+OJXY8ggqtK3+KpFQY3gs0WOWuPQB4b42zgQQedMDWlM7migdZt4cd6++iIZbj90C6
	Nl7Afs3gYyLAv/l4j2R/sgZWN9UAVpyXclgM8DYj0RHGTDI9O2WZecBN9I/Mg1CWze38wXvi7E3/w
	kK4jwYNeLSBq6jVeKL8iAgn77qpOTqiMBYhe+/bJ2eQWGXSrrGhy/eFVy8b4gjDX69/t/QdTOAfjF
	0HvLaXH2ubTBJiHXBprsfDkE24G8gVr0FP8mDpeFPGqwbz8BrU0gArQoKPu0TO8PqbrYN4Q5ON0Dy
	pvLsVJ0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uM4oL-00000007PmU-09ZP;
	Mon, 02 Jun 2025 13:02:41 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uM4nM-00000007Pe0-3x0f
	for linux-um@lists.infradead.org;
	Mon, 02 Jun 2025 13:01:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=wgki+cMOC8pHzeodgCagi2iIVprgOhLci+G/dKq1d6c=; t=1748869299; x=1750078899; 
	b=Ey6aGxdHjA6hcS3viNPXccZu201okvPVBQP/+p/ZFhJrhKgywN0FOlhSSruK1cWcAro0kRhBVu8
	lbKK8FGtfNPH2DvqcaXn+frrQ1s4KwV7/s8+Nw4JakysH5KsyDRLHgQ6tUFixw9Vo2rHxW+EacEJO
	7fGgOUQKYRrL/Tn9JxDxPWkldkWQ8Puvm9yK6HGssmvIKnRvy3+P1Mxy8yMKwUo5aHpaziQr0bIXT
	Xt0oAZyWLIBsUN974tYxUImTyy9MMA4ltHNyN1cSsAJ1ISpULEkt0QOzsyuWiUHOkK/c7NIOwBh2U
	9QaEMt44u3bA+XiRXw38V3Sv+jVvUG5MzkMw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uM4nH-00000005j9h-2bua;
	Mon, 02 Jun 2025 15:01:35 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 0/7] SECCOMP based userspace for UML
Date: Mon,  2 Jun 2025 15:00:45 +0200
Message-ID: <20250602130052.545733-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250602_060141_004397_CE806E28 
X-CRM114-Status: GOOD (  10.77  )
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

we should be getting close to a usable SECCOMP patchset now. This
revision mostly fixes an issue with FP size detection and makes SECCOMP
mode a runtime rather than compile time option.

Benjamin

v3:
- Fix an issue where the FP size was not detected (memor was not shared)
- Use runtime configuration instead of compile time configuration

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

Benjamin Berg (7):
  um: Move faultinfo extraction into userspace routine
  um: Add stub side of SECCOMP/futex based process handling
  um: Add helper functions to get/set state for SECCOMP
  um: Track userspace children dying in SECCOMP mode
  um: Implement kernel side of SECCOMP based process handling
  um: Add SECCOMP support detection and initialization
  um: pass FD for memory operations when needed

 arch/um/include/asm/irq.h                  |   5 +-
 arch/um/include/asm/mmu.h                  |   3 +
 arch/um/include/shared/common-offsets.h    |   4 +
 arch/um/include/shared/irq_user.h          |   2 +
 arch/um/include/shared/os.h                |   3 +-
 arch/um/include/shared/skas/mm_id.h        |   9 +
 arch/um/include/shared/skas/skas.h         |   1 +
 arch/um/include/shared/skas/stub-data.h    |  20 +-
 arch/um/kernel/irq.c                       |   6 +
 arch/um/kernel/skas/mmu.c                  |  89 +++-
 arch/um/kernel/skas/stub.c                 | 130 +++++-
 arch/um/kernel/skas/stub_exe.c             | 159 ++++++-
 arch/um/os-Linux/internal.h                |   5 +-
 arch/um/os-Linux/process.c                 |  31 ++
 arch/um/os-Linux/registers.c               |   4 +-
 arch/um/os-Linux/signal.c                  |  19 +-
 arch/um/os-Linux/skas/mem.c                | 103 ++++-
 arch/um/os-Linux/skas/process.c            | 482 +++++++++++++++------
 arch/um/os-Linux/start_up.c                | 181 +++++++-
 arch/x86/um/os-Linux/mcontext.c            | 218 +++++++++-
 arch/x86/um/ptrace.c                       |  76 +++-
 arch/x86/um/shared/sysdep/kernel-offsets.h |   2 +
 arch/x86/um/shared/sysdep/mcontext.h       |   9 +
 arch/x86/um/shared/sysdep/stub-data.h      |  23 +
 arch/x86/um/shared/sysdep/stub.h           |   2 +
 arch/x86/um/shared/sysdep/stub_32.h        |  13 +
 arch/x86/um/shared/sysdep/stub_64.h        |  17 +
 arch/x86/um/tls_32.c                       |  23 +-
 28 files changed, 1434 insertions(+), 205 deletions(-)
 create mode 100644 arch/x86/um/shared/sysdep/stub-data.h

-- 
2.49.0


