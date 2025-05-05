Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FD3C3ABB0
	for <linux-um@archiver.kernel.org>; Mon,  5 May 2025 08:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yqYrW0kL68U4pB/ROcFLjIt0w7CoMEKnknDWg+6P7ZY=; b=tsszXO6fc5QsfKlxZe3BiYR7/x
	JW0Xo3I4wnjZP2IMFhlmr1LyrNoeUgCVCkfpFLY+2gIZnc9BWj4meUlAFvn8B/fpgWy5qME2RfJ/1
	c8/6XZuG0AyKGXbZo+gtC0b+mhrSFwPzHn7l/1XxvlnrqY6681GBYhAP0n8aYXKqkM5frAYu8cEqi
	v1rsnPN2Ts0VTgHy+Ue26CKJXJYHS1D9zwNgZqZM6piHOtb4b9t6NgMSw+hramoMXz+L4Vw//PUET
	+PRtIExSM1bm8ctLSFa72wxtziUmddqPvbodgTX8CadeICE6tOUPzk6g9nZL1IpU7xEDzF54qEOxx
	z8lHR+IQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBr1f-00000006lID-3YDB;
	Mon, 05 May 2025 08:18:11 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBr1c-00000006lG9-41nL
	for linux-um@lists.infradead.org;
	Mon, 05 May 2025 08:18:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=yqYrW0kL68U4pB/ROcFLjIt0w7CoMEKnknDWg+6P7ZY=; t=1746433086; x=1747642686; 
	b=rlGnLSJlHtN19DnAUwV5X1BH1wltt1u7B2lof0pxPEvbfcJLa57SPJHhGPFkqW5yjTfkNWAryyR
	La/Wf7haaKvzpDuOLYtbJL0KgIicvXgrobzY5O0scZIJrI9NPdYdveWzaQ+DwC9lhOGh2N/GmeDjD
	uVReXLO87AfdEf3NFUWKBEE4jgjsv4UrUjLUTocU1zIu+iJiE5z1QtIkVwZJzgSaBxiYuTfbq5i5J
	9mN55xRbuY/BzUlZDecNrInIQAgtkDIxevCSYBjfnEGBKAnXa1dweu9IvOuwZwLHVuJo1I1Kf+hAS
	o9+iX0HqNq2GsDVR3Hmpw4GzfC4RPaTO/vVA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uBr1X-000000043hu-2IA3;
	Mon, 05 May 2025 10:18:03 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [GIT PULL] uml 6.15-rc6
Date: Mon,  5 May 2025 10:15:32 +0200
Message-ID: <20250505081753.12266-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_011808_995802_3FC671D5 
X-CRM114-Status: UNSURE (   9.00  )
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

We really should've sent this much earlier, apologies.
There's just a single fix here for the _nofault changes
that were causing issues with clang, and then when we
looked at it some other issues seemed to exist.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 92a09c47464d040866cf2b4cd052bc60555185fb:

  Linux 6.15-rc5 (2025-05-04 13:55:04 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linux-6.15-rc6

for you to fetch changes up to 68025adfc13e6cd15eebe2293f77659f47daf13b:

  um: fix _nofault accesses (2025-05-05 10:06:51 +0200)

----------------------------------------------------------------
A single fix for _nofault infrastructure.

----------------------------------------------------------------
Johannes Berg (1):
      um: fix _nofault accesses

 arch/um/include/asm/uaccess.h            |  2 ++
 arch/um/kernel/trap.c                    | 26 +++++++++++++-------------
 arch/x86/um/shared/sysdep/faultinfo_32.h |  2 +-
 arch/x86/um/shared/sysdep/faultinfo_64.h |  2 +-
 4 files changed, 17 insertions(+), 15 deletions(-)

