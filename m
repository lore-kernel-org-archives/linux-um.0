Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB128C021A4
	for <linux-um@archiver.kernel.org>; Mon, 24 Feb 2025 18:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=y8Hts69TuipCZUetM7H3jiUp/y1ZiJoQVTMfxIKJATM=; b=gDcEm6IYL/xp3ncFxbjxw8xnV5
	4bgcmpaKyhQwSUqMe4XyjU3gHoePtOjXwiFOsMjuik7wWPEmvYZmRNRtWcHB8hihlav9snnEAKY3K
	td2ClnwgGWMosCItPXftvS1v7HjtwfaW7uf02y+G9zo+WdmvaFUOkiDRfp/RSyO3VZQMLSV0NQ6p7
	asJomtYHW4hOj6j47HL+itfVLhLi7CFFche8KtDExEJtYq7Cufup1eaXydzowN/e6mSn5/hSPfovI
	+zU7yXIOaK50XvAsWTjflCYji3uoNlM2GiqC8Q/bY6ClbDoVpQInGJVK/ksNyx5gl051IL6Pg6I8V
	d9sZXlUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmd8Q-0000000EnL8-0rZb;
	Mon, 24 Feb 2025 18:24:54 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmd2p-0000000Em7q-0NtO
	for linux-um@lists.infradead.org;
	Mon, 24 Feb 2025 18:19:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=y8Hts69TuipCZUetM7H3jiUp/y1ZiJoQVTMfxIKJATM=; t=1740421145; x=1741630745; 
	b=bHVUYQGJ+Hf8hZ3+nYx7RZZXS3xpeOjh17YvS0oYGsTS7lh7UtsPmZGn7M9RRHPJT7puLhx19uY
	4MpuWX5coFnAiO7OBc6zdt9gHp4rHYHAywbfrkBsgAX62VZ8GeFjGOyDjLOARGmMHuG0ooiXFgnMZ
	cO+L8qHAtBZ7wQzyyWlyg3TClTPbKmPjjhL+JGr/FP2+nRZ7Jwa0iTScpd/qcP4fdrQI5lKnEgitW
	QGSGFgIc8ZuJHeUF4tipPctD9snH0jpzuo1lPqwS0E3kCtP8PBG9GXYSLL5bfwjsqYRUMJ5nRWzkT
	npCiPM5rHKknIfA//QAzpe9AgAjnmkmxm+OA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tmd2j-00000008tWp-2acQ;
	Mon, 24 Feb 2025 19:19:02 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 0/9] SECCOMP based userspace for UML
Date: Mon, 24 Feb 2025 19:18:18 +0100
Message-ID: <20250224181827.647129-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_101907_142853_BD19255B 
X-CRM114-Status: GOOD (  11.49  )
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

Benjamin Berg (9):
  um: Store full CSGSFS and SS register from mcontext
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
 arch/um/include/shared/irq_user.h          |   1 +
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
 arch/x86/um/os-Linux/mcontext.c            | 223 +++++++++-
 arch/x86/um/ptrace.c                       |  76 +++-
 arch/x86/um/shared/sysdep/kernel-offsets.h |   2 +
 arch/x86/um/shared/sysdep/mcontext.h       |   9 +
 arch/x86/um/shared/sysdep/stub-data.h      |  23 +
 arch/x86/um/shared/sysdep/stub.h           |   2 +
 arch/x86/um/shared/sysdep/stub_32.h        |  13 +
 arch/x86/um/shared/sysdep/stub_64.h        |  17 +
 arch/x86/um/tls_32.c                       |  23 +-
 29 files changed, 1439 insertions(+), 207 deletions(-)
 create mode 100644 arch/x86/um/shared/sysdep/stub-data.h

-- 
2.48.1


