Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06341CAC59A
	for <linux-um@archiver.kernel.org>; Thu, 18 Sep 2025 08:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Iq4mMU+i+i800xk3CHLuHmJu8rG3VMtn4q43wrwNg6M=; b=JgEYkOweiEXbFUzRb4JNT7iPEs
	BzxkDvlWByOVYCTfjUPGW6Z9Td977mI4HAqXJOCx1IAUMBT4FyKnsCU+xEm9IfT5HMHje3GeQHpfu
	mBPpOAX1skvRUQsUdmX5DOXtwCNqdO5Wa9qwQHNy05KWaN9R6/ysH8Edep12ebep+SIzLX6YfGcBP
	9Pq+0MmHos5FBAb+tmNrZ5SKT3FoUIUgyRfljHhMwDeV5uWzaGxa1yNKQDK6jgdptixdDZXfjWgqB
	geEPxDGKySDyXRk3t4d2ss1KCULhDi5b1TWxeNhu23vgTIu9YSd2nd5Hdgy03RebCGPOjHaA2Zvl9
	fgEvhiNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9uT-0000000GgYw-0jrz;
	Thu, 18 Sep 2025 08:22:33 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9uQ-0000000GgYG-12OC
	for linux-um@lists.infradead.org;
	Thu, 18 Sep 2025 08:22:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=Iq4mMU+i+i800xk3CHLuHmJu8rG3VMtn4q43wrwNg6M=; t=1758183750; x=1759393350; 
	b=g/2EEwGMJluNyGvR70k1clhRWr3oFxMCFHoYfG5/DfBMug28B5kiW5M6V7Qb5mQAAk+jd44gzUB
	3rJe6RTpsbH6RhwXeyHDHLhNWFPo+ldqUyMFuD6m7eq5TiLkR1vMxf3WpA8iaxGhbYaxAy1KzzeUD
	3awo9E8N2OgcsHGKIL6BCmHNaOm8EFb7FwcwLOZKpBzRrjahyTsuOXyRHkRDpngDcW617Ybvy/Im1
	298RnYZhhLdUt0gA0qjB4tM3Q6X9n78usHcV1u8NGzgnKgDL0xO0p1t615S6X6lfgQixiVv5LpPKv
	/8CUg2asQ4TrpRK8Ome/wuESsSjNIXP1kioA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uz9uJ-0000000D8og-3mcZ;
	Thu, 18 Sep 2025 10:22:24 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [GIT PULL] uml-for-6.17-rc7
Date: Thu, 18 Sep 2025 10:20:47 +0200
Message-ID: <20250918082219.6652-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_012230_314373_46C9F640 
X-CRM114-Status: UNSURE (   9.73  )
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

Hi Linus,

So we still have a couple of fixes for ARCH=um, which I'd
meant to send earlier but then forgot. All of them are
pretty long-standing issues that are either not really
happening (the UAF), in rarely used code (the FD buffer
issue), or an issue only for some host configurations
(the executable stack.)

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:

  Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-6.17-rc7

for you to fetch changes up to df447a3b4a4b961c9979b4b3ffb74317394b9b40:

  um: Fix FD copy size in os_rcv_fd_msg() (2025-09-10 14:24:19 +0200)

----------------------------------------------------------------
A few fixes for UML:
 * mark stack not executable to work on
   more modern systems with selinux
 * fix use-after-free in a virtio error path
 * fix stack buffer overflow in external
   unix socket FD receive function

----------------------------------------------------------------
Miaoqian Lin (1):
      um: virtio_uml: Fix use-after-free after put_device in probe

Richard Weinberger (1):
      um: Don't mark stack executable

Tiwei Bie (1):
      um: Fix FD copy size in os_rcv_fd_msg()

 arch/um/drivers/virtio_uml.c | 6 ++++--
 arch/um/os-Linux/file.c      | 2 +-
 arch/um/os-Linux/util.c      | 3 +--
 3 files changed, 6 insertions(+), 5 deletions(-)

