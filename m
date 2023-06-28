Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E55C0015E
	for <linux-um@archiver.kernel.org>; Wed, 28 Jun 2023 01:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4U5QEcdWc22NivfQVF9PluHBAaiEfBi+WWUjhCChnZM=; b=2c8TNttvvqMRwz
	8RX16nVWmsV5is5nELWvl+/OTzznJn8+FvfmiYlHeHN/cLUXxhJREMvwfp5hvp7lOsTeKaQ89B0Rr
	mHrvSZFJ3qGw1FiPeQtydVdhMtLfZo55YOCCRnV93fqXnACK1kNSGBN/g61VqZOuK7IuFcknQm8AD
	QL5Eh2R5yrRW/6uCQHwTk5eqMW9W4gjyJCfdbdssOUEp0d6c1YmEET9quCn+B+ivjiAw3xnebR4uY
	zWkQ+FmWoyB+WYUz00rWAHPFk32kRcVbbQEqaZZcufzePaj60Bt61fATlTbP3aqgBZn5ViUviGums
	BUqTNmag9K2qkT/mJrNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEJYi-00ETrl-13;
	Wed, 28 Jun 2023 01:01:24 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEJYf-00ETr9-2Z
	for linux-um@lists.infradead.org;
	Wed, 28 Jun 2023 01:01:23 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4AEF56124B;
	Wed, 28 Jun 2023 01:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC2C2C433C9;
	Wed, 28 Jun 2023 01:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687914080;
	bh=kcxmWFSqu/rIIej6l4AfxdR5n+4Ee1nLq/EBD4SeM24=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dkHDQK2fkSkcTyY/J4+PazHmOkmghV7dEB9j1Tx7+kg2vUoKnBuwdzPs/sfusbNbp
	 4Ta3QBQfi9iNx3MiF2n7i2I6WcGUzRMPd7Zgau7v2HcL6jRdYVlECKE1SyUAKzYJKZ
	 BLk1E/CKwp+bLo9C9imtweYzL4OWyKLhfmp1Xp15/I9iqzohg/YB/SR8Uh0JabKt3i
	 xomkgQ3sVYBuriyEzDaAG9FdnuqgfGHXMR5TvFqvHO44ssAZ1mVSDAlGXRo+AOSPz2
	 nTp4VYRYmk/WrW4fWXT0egZKftXqBadhy9GT14ZAXDEyyIsOxsa9yz+p7Fb4cyNANu
	 0VNslvb8U+aBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 980F2E53807;
	Wed, 28 Jun 2023 01:01:20 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock updates for v6.5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230626084830.717289-1-mic@digikod.net>
References: <20230626084830.717289-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230626084830.717289-1-mic@digikod.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.5-rc1
X-PR-Tracked-Commit-Id: 35ca4239929737bdc021ee923f97ebe7aff8fcc4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26642864f8b212964f80fbd69685eb850ced5f45
Message-Id: <168791408061.14121.7780809571829106804.pr-tracker-bot@kernel.org>
Date: Wed, 28 Jun 2023 01:01:20 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-um@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_180121_872577_654E321F 
X-CRM114-Status: UNSURE (   4.27  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

The pull request you sent on Mon, 26 Jun 2023 10:48:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26642864f8b212964f80fbd69685eb850ced5f45

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
