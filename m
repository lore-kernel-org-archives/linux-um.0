Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B61C7EE2A
	for <linux-um@archiver.kernel.org>; Wed, 25 Jun 2025 20:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rCbBI18s5H7FHLlfYkRAW6wNGhq7youLUDZICPGHnjA=; b=QcRHJ1r0b1KMMD62vmGFPHw/B7
	6NYgEsOLMyBWvbKqxNnnWD7f6lJOrYYqAZdTB03h4aS0XOYl205IiCzYI4kReLo+l/3dthRXvFIGK
	/tIRHTnkljD6rEUoYl4RG9rYny5AMsOQ97g5u2zjiUqEEWwPmjviHRFlncPddnOchsg7r5zYMuAOz
	ePYaHcq6tqvhaURJ01AFOipI2Q+kFpEYQBsIcxAf3I6zTWmXGdGNewYGwzSZq285W+aXEUxAwoxbf
	2raoMBbzG6ajOOQ8pktO8BFijA9meIdpM063Zmc4L3YrVmaw/qAXf/YDpi4CiPNmZU4XFmD3jCnSo
	5I17SA/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUWq1-00000009rat-0tbM;
	Wed, 25 Jun 2025 20:35:21 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUUmN-00000009Ypp-3AxU
	for linux-um@lists.infradead.org;
	Wed, 25 Jun 2025 18:23:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4FC215C5CFB;
	Wed, 25 Jun 2025 18:21:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70983C4CEEA;
	Wed, 25 Jun 2025 18:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750875806;
	bh=KHcyik54sU9a4F3g4wWfhr7Kb4z9hKrHHqcQm1GxpmQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=q9jukwkIx+EBDWouZnjzi4pW94qojZ5WRAsSV8EyBRygapqlUp/mn86smOPdaDfJ6
	 t8F4s7/pBZioc7nEATRn83w8iBzqPo4oc13nnLV6kW3ElJ979p3y/QVUPpK8cTzW9n
	 gZF6rX9dXLdnLLeYlUUWnKoQti0dAqmpeHo1KiCj1QKVWla5rbvDPaes0LzC2vMLvA
	 Kdc4+x6D97ZwxSCL3KdsP7mBi7STpp36Wdvg8vdPtg9qZLVd+njdkXygjSMQ/3xTyi
	 bg5u9M8I4bwY+m/rMf6FmD5e2Ru+Q5bmtSJMRzWywzai08AaKKgc1WeUeKyqRNc+du
	 wvvS/99orZkRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C133A40FCB;
	Wed, 25 Jun 2025 18:23:54 +0000 (UTC)
Subject: Re: [GIT PULL] uml-for-6.16-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250625121529.42911-3-johannes@sipsolutions.net>
References: <20250625121529.42911-3-johannes@sipsolutions.net>
X-PR-Tracked-List-Id: <linux-um.lists.infradead.org>
X-PR-Tracked-Message-Id: <20250625121529.42911-3-johannes@sipsolutions.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-6.16-rc4
X-PR-Tracked-Commit-Id: 2d65fc13be85c336c56af7077f08ccd3a3a15a4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2dca89df0d1116f722b4be100e4bfcff858058e8
Message-Id: <175087583272.574995.9982017889434110296.pr-tracker-bot@kernel.org>
Date: Wed, 25 Jun 2025 18:23:52 +0000
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_112327_842709_CCCFC52D 
X-CRM114-Status: UNSURE (   3.93  )
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

The pull request you sent on Wed, 25 Jun 2025 14:14:19 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-6.16-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2dca89df0d1116f722b4be100e4bfcff858058e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

