Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA3BC2BA15
	for <linux-um@archiver.kernel.org>; Wed, 19 Jun 2024 15:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UwXLDNff2qTr2jA3yBoLMYO9Uzh/+nzqYOY72TVbf0I=; b=iNEXIi2MUkZi1HBuk2ON4zndN8
	846/8hZwpKVTFXr8LvdSFVAxg7OWCAMQ8BmbY8E8SA1YKPoxbR7WJyZSPAnFzH7BIdZVpNxJ9Le4O
	Lh7bkxdmRp9w/fRUrPXLsnbmWIFRidGwhhCKMXuUTzMBN/RqLm9x4eOGQHXqmhkTK5UcbVaUZwXWY
	seF3aoZMY8LY3oEqj67a4N4mW1+YM2hdj4vc6nuXiiUhuyRx759KxESsG8obmpC2DuNq7jipK2hbs
	vsBkfYPAAAQ4FeweOK5YBaVgfyidPYkczLD8AoTDbqDbsoOS1gm0+qXoXJcv53NS3C8iXWkYQAzPK
	B/ru0JMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJxLl-00000001pNQ-3xai;
	Wed, 19 Jun 2024 15:35:54 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJxLh-00000001pJs-20TM
	for linux-um@lists.infradead.org;
	Wed, 19 Jun 2024 15:35:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=UwXLDNff2qTr2jA3yBoLMYO9Uzh/+nzqYOY72TVbf0I=; t=1718811347; x=1720020947; 
	b=GeCVi94U+o3dBB0HsEcqEDkmn3I27y9T+8nTsqxIE6JTYNooaMFrzQMGETB7dKf6R/BN1WlCMny
	HJzWxiXNFOdQ1xz4TmxcTnZjXrzV/h2OQlt36JJYis91VNWDZbE3BwsH4b3qp50uVtwK8tdBBr31b
	sSPnb8GsaeupNAgWnnZak/1/J9MlUkElFYSnjRGnUUBWglVS4y/iXT/tfNytLc2wKr0IlAHHUB6Hq
	8ClznXq/JfRo7zC6pgyO+wtxymxtc2xpf8qKn66wYEG2QT3zrftP2PTcJSJSVh3dLRW4xfcOSx2Kv
	a+AHjHoppggvd53wPlRSKWPDDuw6WZp0owLw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sJxLa-000000072rR-2eer;
	Wed, 19 Jun 2024 17:35:43 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v5 0/7] Increased address space for 64 bit
Date: Wed, 19 Jun 2024 17:34:04 +0200
Message-ID: <20240619153411.2596774-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_083549_545357_A325F48A 
X-CRM114-Status: GOOD (  11.24  )
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

The new version of the patchset uses execveat on a memfd instead of
cloning twice to disable rseq. This should be much more robust going
forward as it will also avoid issues with other new features like mseal.

This patchset fixes a few bugs, adds a new method of discovering the
host task size and finally adds four level page table support. All of
this means the userspace TASK_SIZE is much larger and in turns permits
userspace applications that need a lot of virtual addresses to work
fine.

One such application is ASAN which uses a fixed address in memory that
would otherwise not be addressable.

v5:
* Use execveat with memfd instead of double clone

v4:
* Do not use WNOHANG in wait for CLONE_VFORK

v3:
* Undo incorrect change in child wait loop

v2:
* Improved double clone logic using CLONE_VFORK
* Kconfig fixes pointed out by Tiwei Bie

Benjamin Berg (7):
  um: Add generic stub_syscall6 function
  um: Add generic stub_syscall1 function
  um: use execveat on memfd to create userspace MMs
  um: Fix stub_start address calculation
  um: Limit TASK_SIZE to the addressable range
  um: Discover host_task_size from envp
  um: Add 4 level page table support

 arch/um/Kconfig                         |   1 +
 arch/um/include/asm/page.h              |  14 ++-
 arch/um/include/asm/pgalloc.h           |  11 +-
 arch/um/include/asm/pgtable-4level.h    | 119 +++++++++++++++++++
 arch/um/include/asm/pgtable.h           |   6 +-
 arch/um/include/shared/as-layout.h      |   2 +-
 arch/um/include/shared/os.h             |   2 +-
 arch/um/include/shared/skas/stub-data.h |  11 ++
 arch/um/kernel/mem.c                    |  17 ++-
 arch/um/kernel/um_arch.c                |  14 ++-
 arch/um/os-Linux/main.c                 |   9 +-
 arch/um/os-Linux/skas/process.c         | 145 +++++++++++++++---------
 arch/x86/um/.gitignore                  |   2 +
 arch/x86/um/Kconfig                     |  38 +++++--
 arch/x86/um/Makefile                    |  32 +++++-
 arch/x86/um/os-Linux/task_size.c        |  19 +++-
 arch/x86/um/shared/sysdep/stub_32.h     |  22 ++++
 arch/x86/um/shared/sysdep/stub_64.h     |  27 +++++
 arch/x86/um/stub_elf.c                  |  84 ++++++++++++++
 arch/x86/um/stub_elf_embed.S            |  11 ++
 20 files changed, 500 insertions(+), 86 deletions(-)
 create mode 100644 arch/um/include/asm/pgtable-4level.h
 create mode 100644 arch/x86/um/.gitignore
 create mode 100644 arch/x86/um/stub_elf.c
 create mode 100644 arch/x86/um/stub_elf_embed.S

-- 
2.45.1


