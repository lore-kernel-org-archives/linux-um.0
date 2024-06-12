Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CC7C27C53
	for <linux-um@archiver.kernel.org>; Wed, 12 Jun 2024 13:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2zUirtCZ/cdwbbd8Dv3VvUvuOonejBGJ+V456KzLKDg=; b=T2xrtY6vT17+6OKOZ/ypck3Vcu
	6bljBMYLArd65r1DDFOCngR/c0hAD5N3VkzlWArHu3swN6sOyRbR3uvBDL7kEni/dYolcL9BKfmjf
	2jLE8JTXnQULduWAv9H6mru5BED+tr02gfppDE4KnbgchLcrADwirXd2bG0qLhVHzgYWJpwEkcTEw
	FrfISV6XSnltbgp+6XVh+d5BARpMNQofpeXWLolfo9915CnADLSHu9KWKg9EK6Y5KhfXLVG+YEy+f
	Axv8TGpinQek1WKFklgb+pF07H0O37gHcsRu4nJ1zCTIb4+b6wSyVUYtup1co7WzRMq2O3b3bhvdg
	MVqsP3eQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHOKz-0000000CnTZ-2seK;
	Wed, 12 Jun 2024 13:48:29 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHOKw-0000000CnRa-3laS
	for linux-um@lists.infradead.org;
	Wed, 12 Jun 2024 13:48:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=2zUirtCZ/cdwbbd8Dv3VvUvuOonejBGJ+V456KzLKDg=; t=1718200104; x=1719409704; 
	b=LKU0eID+G1eIJXQYXtAboDp0LZHm4nxl0zFNm71yHvzSCLxOlVNoUJuRiHOOZKW8g7PuK85Ow97
	H35cwksRk0s2oUvMe/BGaRDkL802Vn8cMFQpwzu8lq1YOnQBfAqOW9xHzSE8rv7vpZWNRimjFavLu
	NPFnFEqmGyv1cpqSH4fv0Z0API8JEVikpRsXQ4NQlfoiSO/e+BpponxU9KxtImfpNh72nTK1CzENO
	bM6w4HCfapraH9STt3lTTDzhn2Pg40QOJWVabREeV5Kz8kDV3NB90/P3zVjenetOU1yVbhqeWBIoV
	KXga8DySHNTLUbjZfRk96qtFvNt6PpbAQK9A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sHOKr-0000000ALhN-1Fqd;
	Wed, 12 Jun 2024 15:48:21 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 0/5] Increased address space for 64 bit
Date: Wed, 12 Jun 2024 15:47:59 +0200
Message-ID: <20240612134804.1626427-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_064826_967064_D1F4E585 
X-CRM114-Status: UNSURE (   7.92  )
X-CRM114-Notice: Please train this message.
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

This patchset fixes a few bugs, adds a new method of discovering the
host task size and finally adds four level page table support. All of
this means the userspace TASK_SIZE is much larger and in turns permits
userspace applications that need a lot of virtual addresses to work
fine.

One such application is ASAN which uses a fixed address in memory that
would otherwise not be addressable.

v2:
* Improved double clone logic using CLONE_VFORK
* Kconfig fixes pointed out by Tiwei Bie

Benjamin Berg (5):
  um: Fix stub_start address calculation
  um: Limit TASK_SIZE to the addressable range
  um: Do a double clone to disable rseq
  um: Discover host_task_size from envp
  um: Add 4 level page table support

 arch/um/Kconfig                      |   1 +
 arch/um/include/asm/page.h           |  14 +++-
 arch/um/include/asm/pgalloc.h        |  11 ++-
 arch/um/include/asm/pgtable-4level.h | 119 +++++++++++++++++++++++++++
 arch/um/include/asm/pgtable.h        |   6 +-
 arch/um/include/shared/as-layout.h   |   2 +-
 arch/um/include/shared/os.h          |   2 +-
 arch/um/kernel/mem.c                 |  17 +++-
 arch/um/kernel/um_arch.c             |  14 +++-
 arch/um/os-Linux/main.c              |   9 +-
 arch/um/os-Linux/skas/process.c      |  55 +++++++++++--
 arch/x86/um/Kconfig                  |  38 ++++++---
 arch/x86/um/os-Linux/task_size.c     |  19 ++++-
 13 files changed, 274 insertions(+), 33 deletions(-)
 create mode 100644 arch/um/include/asm/pgtable-4level.h

-- 
2.45.1


