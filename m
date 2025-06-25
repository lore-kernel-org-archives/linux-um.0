Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11978C7EE2A
	for <linux-um@archiver.kernel.org>; Wed, 25 Jun 2025 16:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/vBL7C4EXHe/g4EvFuPaZIotbyPumXb6WtXEmPrqPvw=; b=ugQjo3pK5IJIN0Sl6E0trd7GNJ
	UrBqpcztAhF+yyKDVX1gWCgXE+ll5Q0k8ikOCO1+u/hD4/HcU8jxtm3zC2iJGBatdVrmiSjiZMuOq
	y4jadGCp/pHL+dYpF0En2mlmjhXi2rOQL6p3CScz59i53PrdSig9XnmXBW47oVOPWqefRcAsHcXlk
	0Y2JTOrmIg9t/MwaNS5DqLkt5sUK7wAcr1ddm3Hw2sBdVp/wD3zvQx1bUGTiaCh1skz5AMqVOjmKM
	/9XKvW4k6TPkZI1pgaEytDG+8at/4W8NatppxUcm7D4akLxoZmQ8UDEy4ctN/itF9oRBJyXzxQ9Uc
	YeWqwSjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUT21-00000009J8N-1LHM;
	Wed, 25 Jun 2025 16:31:29 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUP2O-00000008at6-1OhS
	for linux-um@lists.infradead.org;
	Wed, 25 Jun 2025 12:15:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=/vBL7C4EXHe/g4EvFuPaZIotbyPumXb6WtXEmPrqPvw=; t=1750853735; x=1752063335; 
	b=xsIE2si0jB/FYEQT0O+oZlNJwyv9vWSqB5NJvR/wTSAwZyJPnORZHAFGBe9/TvqPSnswoeWqVyt
	BNXWCQrIJE8Kvz+XkJ9e13PcWVwFzWulIq/D48W/P+tKDRziVLzA1KV/kJUB1Zf2c/gxi2k2dXgTw
	YwGZP+L/Xi9VwFb927ggA9/Bpsf9J+IIiLXIZqI027tqyOXyWlyxySahIKvgjOZi5LnOPgXIFj6t4
	fS1//YYh6nCA0KUHefgxO0ubCFMXAgyeIV7aXG3B4y1eTSNnJ6aDrAXRAF34yofHCrjBy+bMY2p9T
	bAFmfMJDszQfhvdN1NZRqTkUpL7O8/HVPJRA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uUP2K-00000009xSo-48of;
	Wed, 25 Jun 2025 14:15:33 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [GIT PULL] uml-for-6.16-rc4
Date: Wed, 25 Jun 2025 14:14:19 +0200
Message-ID: <20250625121529.42911-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_051536_382380_6A35E687 
X-CRM114-Status: UNSURE (   9.10  )
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

For UML we have a few fixes, all from Tiwei and mostly for
recently added code (though one is just a compiler version
thing.)

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 86731a2a651e58953fc949573895f2fa6d456841:

  Linux 6.16-rc3 (2025-06-22 13:30:08 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-6.16-rc4

for you to fetch changes up to 2d65fc13be85c336c56af7077f08ccd3a3a15a4a:

  um: vector: Reduce stack usage in vector_eth_configure() (2025-06-25 09:28:17 +0200)

----------------------------------------------------------------
Just a few fixes:
 - fix FP registers in seccomp mode
 - prevent duplicate devices in VFIO support
 - don't ignore errors in UBD thread start
 - reduce stack use with clang 19

----------------------------------------------------------------
Tiwei Bie (4):
      um: ubd: Add missing error check in start_io_thread()
      um: vfio: Prevent duplicate device assignments
      um: Use correct data source in fpregs_legacy_set()
      um: vector: Reduce stack usage in vector_eth_configure()

 arch/um/drivers/ubd_user.c    |  2 +-
 arch/um/drivers/vector_kern.c | 42 +++++++++++++-----------------------------
 arch/um/drivers/vfio_kern.c   | 14 ++++++++++++++
 arch/x86/um/ptrace.c          |  2 +-
 4 files changed, 29 insertions(+), 31 deletions(-)

