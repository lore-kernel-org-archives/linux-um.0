Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A407C55173
	for <linux-um@archiver.kernel.org>; Fri, 31 Jul 2026 18:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y9j1TjlyaztVjSl6eBVMkrysbU9q/GMXZwx/H99GjOo=; b=SgF6qBqwp2k8rvB0tctvE/IoLQ
	DOa2Y7SFWgP+FyLIg02tEu4NC9DYMAwqYhU67WZ8qlmfTZNAY7o+U51V4uQLe7QACI1aEtur0Z6Ag
	5GofYSyiYcJBQIfh5axGAhsgvXn5ZTfbFFw8cPWxNaWNEsSGxjENP6FyLf8gWjOcV+urElPj+sqWp
	SvLak3QjdAURFgg63Fx9gz4CFPnYtuGOikxlZ18Z0vqN+8Xr4xcf8guqGWAbowGG0ln+i+nzeojFc
	OVrrPkYmhYbovZuV37Vx7JpN87RG8rwuYz4KExWYmu4C3CUWholGN2Grp9KHCw6cIL2LQ0UrntGKh
	73w34NTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wps83-0000000DOUe-1xM2;
	Fri, 31 Jul 2026 18:38:43 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wps82-0000000DOUQ-2pHM
	for linux-um@lists.infradead.org;
	Fri, 31 Jul 2026 18:38:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D798640F82;
	Fri, 31 Jul 2026 18:38:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB1C1F00ACF;
	Fri, 31 Jul 2026 18:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785523121;
	bh=y9j1TjlyaztVjSl6eBVMkrysbU9q/GMXZwx/H99GjOo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=DDuFxzWiKU6HRPq5u1/I1W0sPPO5o3BXfuVd6mLpuSB+M2BiX3t6kPPMXYYFtabAC
	 5fSGPrOcAqHiNic4qtCD+3vwp/Bh5/TMMN4xxGc1MMmmLwpAqySRgQg3tjeMwnsbE8
	 R/qCPH3s3Em0SGwsNyJED4C5CHVGouxQO9c80g+YVA6tCQbq8f5vlCZ+F0xzewVKbq
	 wocMh7FgfezaFbRZJoYMquwhavalWhB9bu9eyNV5fNxo9aqMt1tCOnVBSAOZs3XNl7
	 KuJWGTTRwWJJbQ03Vv+Qev4aHEvXIh2JAgbNh2BrdcPxXsw6faybbd9uNjQmd/K1vx
	 oP/m57+B9CrBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BC139263B9;
	Fri, 31 Jul 2026 18:38:05 +0000 (UTC)
Subject: Re: [GIT PULL] uml-for-linus-7.2-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <5798606.zjCzTo3RIR@nailgun>
References: <5798606.zjCzTo3RIR@nailgun>
X-PR-Tracked-List-Id: <linux-um.lists.infradead.org>
X-PR-Tracked-Message-Id: <5798606.zjCzTo3RIR@nailgun>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-7.2-rc5
X-PR-Tracked-Commit-Id: af421e9aed3920c7ac88c24daa48606c7112feca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 05b165b6c8ab87e11222f99654f878885fb437f4
Message-Id: <178552308455.857209.90685511595625617.pr-tracker-bot@kernel.org>
Date: Fri, 31 Jul 2026 18:38:04 +0000
To: Richard Weinberger <richard@sigma-star.at>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
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

The pull request you sent on Fri, 31 Jul 2026 16:51:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-7.2-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/05b165b6c8ab87e11222f99654f878885fb437f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

