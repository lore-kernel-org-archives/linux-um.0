Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16675C41513
	for <linux-um@archiver.kernel.org>; Wed, 26 Jun 2024 13:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ElRwMJryiLcDzY3l7xy1FrJtnhufSrTOPCrLy9/uir4=; b=fe1p55dTQtfI69IfyB8Px3eXDs
	QUs6hnffRAGbMJZQ9P2C7ZVcpjFUGni31OF5yD5/ER5x3GJxqEheYQhOiy+m5SIKJfZ9u+IQjY0yv
	+FrV0d6K92CcyyfoWjtxsBiU1khn1qyTodLxc2mWZo+GADtNgugbdva3Bc5koIiuh2ekReMA0SaDX
	B/0zT/ZEmlNeh9C7ZUuIpPCFErTepE7UB2mMmj1Yq0NiquveEew5E7Vq+uO0wwSeqr9O3u4Bo0g9n
	dc0c8GwTbyaXYyAqgqrUc5a/oRVCZME7PqJ1lD3IZukLIKbvwPqgLrtan4zYmAaXGoJ2LZL2XV5lR
	0v6A1BjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMT87-000000074fW-0tXP;
	Wed, 26 Jun 2024 13:56:11 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMT7z-000000074c2-46F3
	for linux-um@lists.infradead.org;
	Wed, 26 Jun 2024 13:56:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=ElRwMJryiLcDzY3l7xy1FrJtnhufSrTOPCrLy9/uir4=; t=1719410162; x=1720619762; 
	b=qxWQDanoQw5R3M8sS0B+p2uFpvawt/oNdo6nlpNxyEru2BMP1WajPEAaIznnymysh4HQa+WAGy0
	CyWTpFFNEcwbJ5tRe38sR3Ef3FdTtJeytxYD5g8qIl1OfjeCHoi+9WSl8PSYFy9w1sHSFmG0WQT0o
	YxajFBSudnLSjS9d8k0NICCwFPYhWeg7CphxwOk7C7uz7wsX+kKKgbX0jEO06WbUA3w6vb4G48cbr
	QyT06oDQL2OmYhQcYGI1rUOz+nHs+RcLyhRUGs7ZQ/Mvqkg2rwC0qgc/OGVR6t3PJ4squ2lFLDUeh
	ch5K6kLkTdsXVqLuxS1jksAM2C1gW6gbvqEQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sMT7v-00000003rXd-1JTL;
	Wed, 26 Jun 2024 15:55:59 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v6 0/7] Increased address space for 64 bit
Date: Wed, 26 Jun 2024 15:53:43 +0200
Message-ID: <20240626135350.493110-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_065604_349916_3ED5FA27 
X-CRM114-Status: GOOD (  10.94  )
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

v6:
* Apply fixes pointed out by Tiwei Bie
* Add temporary file fallback as memfd is not always supported

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
  um: use execveat to create userspace MMs
  um: Fix stub_start address calculation
  um: Limit TASK_SIZE to the addressable range
  um: Discover host_task_size from envp
  um: Add 4 level page table support

 arch/um/Kconfig                         |   1 +
 arch/um/include/asm/page.h              |  14 +-
 arch/um/include/asm/pgalloc.h           |  11 +-
 arch/um/include/asm/pgtable-4level.h    | 119 +++++++++++++++++
 arch/um/include/asm/pgtable.h           |   6 +-
 arch/um/include/shared/as-layout.h      |   2 +-
 arch/um/include/shared/os.h             |   2 +-
 arch/um/include/shared/skas/stub-data.h |  11 ++
 arch/um/kernel/mem.c                    |  17 ++-
 arch/um/kernel/um_arch.c                |  14 +-
 arch/um/os-Linux/main.c                 |   9 +-
 arch/um/os-Linux/skas/process.c         | 171 ++++++++++++++++--------
 arch/x86/um/.gitignore                  |   2 +
 arch/x86/um/Kconfig                     |  38 ++++--
 arch/x86/um/Makefile                    |  32 ++++-
 arch/x86/um/os-Linux/task_size.c        |  19 ++-
 arch/x86/um/shared/sysdep/stub_32.h     |  22 +++
 arch/x86/um/shared/sysdep/stub_64.h     |  27 ++++
 arch/x86/um/stub_elf.c                  |  86 ++++++++++++
 arch/x86/um/stub_elf_embed.S            |  11 ++
 20 files changed, 528 insertions(+), 86 deletions(-)
 create mode 100644 arch/um/include/asm/pgtable-4level.h
 create mode 100644 arch/x86/um/.gitignore
 create mode 100644 arch/x86/um/stub_elf.c
 create mode 100644 arch/x86/um/stub_elf_embed.S

-- 
2.45.2


