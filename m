Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE4EC7EE39
	for <linux-um@archiver.kernel.org>; Thu, 26 Jun 2025 21:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=68E0kFqcENmprIL6SwAqbHz/pjvxICU7Zu0O2hi4uwo=; b=i37ueR+hKCrzWCYEKsKmJYpsOQ
	hSTIvukdZUzlyEBYyliCahcOkvsYA+d1NA+WI86UOFoA9cUqtxWcjCbXJHLU5WiQm3d0TKYwVX+OR
	035e0BJ86GZZ/vx1QRKZtOwA/2tibOX7FK/Ini2SkFtEr2T1YOToO1qXsk05aTSD3yFrK9+PvP59d
	gCDbYTwDJ5nMQ13HEf3/ewHkm0VH/7cgfnagXg+q50f6JkEXxgMgUNJpC0dn1ndATINCKtzPknaWz
	vXGR7rV9Ai+pYbOc7sRh7tn0KTZovv0PAPJ/T4ooU3snFvOKJiVgA67/7RQQAVBevyNOI32amK334
	ilXPWktg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUuBL-0000000CqJ5-1Ern;
	Thu, 26 Jun 2025 21:30:55 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUske-0000000Cfgi-2ibD
	for linux-um@lists.infradead.org;
	Thu, 26 Jun 2025 19:59:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=68E0kFqcENmprIL6SwAqbHz/pjvxICU7Zu0O2hi4uwo=; t=1750967956; x=1752177556; 
	b=sbG76sKDOl6uscNWzvuhVlCnJalLyTtqgkW2NwQDGme2OHT6zTwoIpZqHClQbiRUL2A2ypVq94m
	10xPpPzVNOOZ/wAwALAG/oO9PqG+4UtKxnL2oZWtYI1kAFsLpJ7fGoQiWQHJBLchHksi2b9v2isOu
	+yJiU2Dk0oMhC7qhD14tHR2KNZabI97dfCYOzf9RhG6Vuq6g7SGpK2HDDAHprRHEZxMl+XO1eWDx3
	OI62z9p5qo0Ujec05CyGRPOGrylq8xaFO4J/tYV8UuS1XcKfZBuPKAOmUhxcyFm5QICgIUVFYHzVP
	+3olDmgaLeG01OqRaRRnCBxwdYXsPNaowoVg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uUska-0000000C0lZ-23ed;
	Thu, 26 Jun 2025 21:59:13 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: kunit-dev@googlegroups.com,
	linux-um@lists.infradead.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC 0/2] Experimental kunit test for signal context handling
Date: Thu, 26 Jun 2025 21:57:12 +0200
Message-ID: <20250626195714.2123694-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_125916_687528_FFFCA643 
X-CRM114-Status: GOOD (  11.53  )
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

Hi,

so I saw the UAPI testing framework patches and wondered whether I could
hack up a kunit test for userspace signal mcontext handling. I already
had some code, but never knew where to include it. Having it as a kunit
test in this way seems nice as it makes running the test really simple.

This is a very rough attempt with an extra patch to add sigaction
support as that is needed by the test.

Note that this type of test could possibly be shared with the x86
architecture (though UM does not support all features). And, a 64 bit
build might even want to include a second 32 bit binary. So, I suppose
one would ideally want the test to be in arch/x86/tests, with some way
to pick up it up in arch/x86/um/tests.

Does this seem sensible in general?

Benjamin

Benjamin Berg (2):
  tools/nolibc: add sigaction()
  um: add a mcontext FP register handling test

 arch/x86/um/Makefile                     |   2 +
 arch/x86/um/tests/Makefile               |  12 +++
 arch/x86/um/tests/registers.c            |  22 +++++
 arch/x86/um/tests/test-fp-save-restore.c | 118 +++++++++++++++++++++++
 tools/include/nolibc/nolibc.h            |   3 +
 tools/include/nolibc/signal.h            |  34 +++++++
 6 files changed, 191 insertions(+)
 create mode 100644 arch/x86/um/tests/Makefile
 create mode 100644 arch/x86/um/tests/registers.c
 create mode 100644 arch/x86/um/tests/test-fp-save-restore.c

-- 
2.50.0


