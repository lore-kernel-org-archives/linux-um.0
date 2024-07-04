Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEB9C30653
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 12:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oswOPQ88LI9ZZ4dLvGzzNSGgsrVZFJ4bTKOLf0jSje0=; b=THqg3S7patG2IjbsECobqpAvm5
	iy7/9K0Zd2flmJTXTJXPLFdNaoVn4/Q9CelGYk7KlhIU5u+Shg3rVXDigPb64b8KREHD6CDsPG9lU
	oF1JgMkld66wkJviLN6NjNOeP6zJlJE5xuVJ9JFNVMUggxqqqRvDTlA0TGhuoBq3WKsZf9Yltku0G
	nM6B9yHilRe5VWiL24Gbg7UH0Slf0w7FPIaOqtysPkOK5ghyMeYAXGfnuW3lyb884fDSZxKej4Ycf
	SyfkhPYmLta+I3q9bnrH2e9qdOQ1oAnOxBsEiIsHpD6XnDUDAWXjOU4TRGuviU3LlItX1lHUSiKee
	cVpU69cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPLje-0000000D9bk-0EM4;
	Thu, 04 Jul 2024 12:38:50 +0000
Received: from smtp-bc08.mail.infomaniak.ch ([2001:1600:4:17::bc08])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPLjZ-0000000D9bD-2GwS
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 12:38:48 +0000
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WFGR31j82zGlt;
	Thu,  4 Jul 2024 14:38:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720096718;
	bh=oswOPQ88LI9ZZ4dLvGzzNSGgsrVZFJ4bTKOLf0jSje0=;
	h=From:To:Cc:Subject:Date:From;
	b=v5xkoXT9pt4oLWpOuURpdCIOvi1n0uymB7k3u96ouDEmBvC0lD8MqV90lJsEHNyxb
	 9LLj8NgKnPtojW0nAYAXI0k6VeBhNqPxWqzsReKLhg7KTFIRy0m7YhBk+U7Lzlswft
	 y8jT8CBMTr2/BYwxKDDCRKEfmdIRJHlyzwNZgOZo=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WFGQy0YxQz14Q;
	Thu,  4 Jul 2024 14:38:33 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Brendan Higgins <brendanhiggins@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Gow <davidgow@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jon Hunter <jonathanh@nvidia.com>,
	Kees Cook <keescook@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Ron Economos <re@w6rz.net>,
	Ronald Warsow <rwarsow@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-um@lists.infradead.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [GIT PULL] Kselftest fixes for v6.10
Date: Thu,  4 Jul 2024 14:38:16 +0200
Message-ID: <20240704123816.669022-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_053846_044650_B97DA551 
X-CRM114-Status: UNSURE (   5.39  )
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

This PR fixes a few kselftests [1].  This has been in linux-next for a week and
rebased to add Mark Brown's Tested-by.  The race condition found while writing
this fix is not new and seems specific to UML's hostfs (I also tested against
ext4 and btrfs without being able to trigger this issue).

Feel free to take this PR if you see fit.

Regards,
 Mickaël

[1] https://lore.kernel.org/r/9341d4db-5e21-418c-bf9e-9ae2da7877e1@sirena.org.uk

--
The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454:

  Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/kselftest-fix-2024-07-04

for you to fetch changes up to 130e42806773013e9cf32d211922c935ae2df86c:

  selftests/harness: Fix tests timeout and race condition (2024-06-28 16:06:03 +0200)

----------------------------------------------------------------
Fix Kselftests timeout and race condition

----------------------------------------------------------------
Mickaël Salaün (1):
      selftests/harness: Fix tests timeout and race condition

 tools/testing/selftests/kselftest_harness.h | 43 ++++++++++++++++-------------
 1 file changed, 24 insertions(+), 19 deletions(-)

