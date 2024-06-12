Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA28C27C77
	for <linux-um@archiver.kernel.org>; Wed, 12 Jun 2024 14:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UHp+7/VR/IANgT4vjY42gXHSd7Au2OErdRfzGQ4iTv8=; b=PKgc4HIN90d8UmzQ4x2KGji/Id
	TWNojDutXCnddEjgOdN3O0KQFD472umH5AY9ZBZsdFUV0U1mcGqtB0q1dTa6k4nCJeAH1QmK7360p
	gQoTz9BH3RwYy7JeRXSKvyNY44JfgQCOXzP1T87bjrFdUL5asThqRNH1xiHD/Cm8NuxpXqZlHwxVz
	o4Y/KsUXNpkQ4VFebWq+0yF78w3Wv7z4O/ifECKv8by36qfbmhrElNqwN5rFpKMOpyE0N53w7q8ol
	MNEulO5cXo8jiFu/Fa+n2lKBogXL436KBUjyWtgDuc4sGBEmJamutxc8RXT0wXgPn8CE0S/jwIGY1
	9oCfLtfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHOgl-0000000CtZa-30BJ;
	Wed, 12 Jun 2024 14:10:59 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHOgi-0000000CtXS-3JCk
	for linux-um@lists.infradead.org;
	Wed, 12 Jun 2024 14:10:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=UHp+7/VR/IANgT4vjY42gXHSd7Au2OErdRfzGQ4iTv8=; t=1718201456; x=1719411056; 
	b=bJqOcmNDOLjnOefd4diqKaRqZJVXqzVO1DDpJhWi/7UY5JAVSJ7/RmMBb/YWEbnMEwfnb4m0TH5
	buPaLLR4bk2Wh5/NMggsxX+w22fk48Nc5kyq7cxL12vLNKc+ifBZErRVOvPKIzDBx6KUZfQYZTxNG
	b5YAsrmVfIPL3RbcfGeFMtj2UrLcXVuQYj5eEtWHcMotRTs3N74bqidKrZ2YI29dL2wgSIrzKM3SE
	I+pRFzeZm7y7KjehxJowpu1AMP/IfgTcg/bL5rV/4hlN0+7WV9WyU00nPrxaInRlL2Km7vg8e5rO0
	S5hXVo80tSXl3QpqCyc5XtV1S5Dc4J0JqENg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sHOgg-0000000AN5N-0Us7;
	Wed, 12 Jun 2024 16:10:54 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 0/5] Increased address space for 64 bit
Date: Wed, 12 Jun 2024 16:10:42 +0200
Message-ID: <20240612141047.1633303-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_071056_873048_34A1C707 
X-CRM114-Status: UNSURE (   8.21  )
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

v3:
* Undo incorrect change in child wait loop

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
 arch/um/os-Linux/skas/process.c      |  53 +++++++++++-
 arch/x86/um/Kconfig                  |  38 ++++++---
 arch/x86/um/os-Linux/task_size.c     |  19 ++++-
 13 files changed, 273 insertions(+), 32 deletions(-)
 create mode 100644 arch/um/include/asm/pgtable-4level.h

-- 
2.45.1


