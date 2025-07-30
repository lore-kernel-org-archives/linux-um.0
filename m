Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC739C87FC9
	for <linux-um@archiver.kernel.org>; Wed, 30 Jul 2025 03:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vao6KAU+LX3ApE0BswBL665NJ2GeUowm4PWTy2jXFb4=; b=QylmbqKuuLu3ajnUm5SJoRRuzB
	QICnThcFPIdH5n4bJNkqf0E1P3lkwl7uIIiYWuMdpSRTrmJviHoPjhcx19N2f5JsCAxUhrp5KaAMY
	Lp7+NzEilkxTUWhlS3ER/xYjgHg7OsFMa6S9nkVIAhInxdyJCdL7pmCU+PYuqzxoxSoa5W8HABpTw
	udopq4HVqddHTzw4BBtbCtTTFD1xJ7p+6JsQbzxuJMcnV66HI2fKNjQD86+1mBDiB95FPeEqxsin/
	yFbPcQ1+Ffhut5N/SVeyi7P68dRbYvdcHOTwGebjC4kQFq6aGap7kflbQMtQ2bGw1ts0IYq5MtBFH
	L7p9GIRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugxi6-00000000dXb-1CUz;
	Wed, 30 Jul 2025 03:42:34 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugxfR-00000000d1U-3VZY
	for linux-um@lists.infradead.org;
	Wed, 30 Jul 2025 03:39:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5997A5C59E3;
	Wed, 30 Jul 2025 03:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC8FC4CEE7;
	Wed, 30 Jul 2025 03:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753846789;
	bh=Lgmo1+CGQX4gXmlpgvxlKHV/6i+kdUYiGaxJQcUCDG0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Vd2HHbIX2HCv9KtJDeXp1MFG3MAa1/YLMd3dgVSymq1Qb4MnV5bRVsh/+0Xmua4Xg
	 Sg1hR4SN4JxPpqkpglZa409/Kt6CaZ5dmnP5QhEUmRIg7BkeV89rxr/BdAR1v8G2c0
	 J4dvl3bzo9dlF3H2hIzmuTg5dsn4mp7V+0TLO5bmPJl5lHJH77zeCENjyKohRdX3s7
	 4fDvj/ek7S4Mt/oaBeI9OjUerQvVrVW7ypN28v5gdB2IZkLGcc/qQxjkNA5ZVTMgr7
	 7bX3FY/jroJuJPQU4iOjfJveEL/6R9/SalStFamyMLnIOZQdkBNAbSL569h1lQPCWb
	 984OQrIZm6pOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E90383BF5F;
	Wed, 30 Jul 2025 03:40:06 +0000 (UTC)
Subject: Re: [GIT PULL] uml 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250729100457.14550-3-johannes@sipsolutions.net>
References: <20250729100457.14550-3-johannes@sipsolutions.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250729100457.14550-3-johannes@sipsolutions.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linux-6.17-rc1
X-PR-Tracked-Commit-Id: fc9ed2f6589dc2c11f05883e5c323be5f39fd241
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: beb6c8326eb4e7006c4aa16b0fee3e303d42e685
Message-Id: <175384680492.1749338.7260404881755511172.pr-tracker-bot@kernel.org>
Date: Wed, 30 Jul 2025 03:40:04 +0000
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_203949_914683_ADC458A6 
X-CRM114-Status: UNSURE (   3.88  )
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

The pull request you sent on Tue, 29 Jul 2025 12:02:03 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linux-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/beb6c8326eb4e7006c4aa16b0fee3e303d42e685

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

