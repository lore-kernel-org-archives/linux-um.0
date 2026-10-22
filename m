Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB37606B7D1
	for <linux-um@archiver.kernel.org>; Thu, 22 Oct 2026 18:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Z6d69TkW;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oSY0SkPV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=houCfpQumQUvgNpKAR6G1uMk9OC0BWmJbHWo907DfxU=; b=Z6d69TkWJj5WJ1N3Lhg+mEYQCV
	/zBlq7FVlnMbd41xzJMg4p9FAOfmyNznM4YDBe0G1CpsFW77MPA6lx4jP81CCy/QR/SOEorwN9TXI
	5wD7vNmwWWgbFkbT/HvJreN0me4Ls8iDIuzKSDOFuWFOKN/qa6PlzGecF3ZFxsLQ5KglYdZ0QCiPR
	yPQwFSIrhbbzk2xtWFtUwnfGKZ1ccwq/cTbOZZGdtb9npx3IH/1JYxnw0MN+flH5RmFs6JcXFuGT9
	K7xunuB8dI1K2Q7Ykzcx09ZvF/wHn1Cxf4CUE8necqucMxC75165T3G6eydcgw72dAptBJEa6tCpU
	G01KBUQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJxZk-0000000EiHl-0Jmg;
	Thu, 22 Oct 2026 18:31:40 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJxZi-0000000EiEs-18xM
	for linux-um@lists.infradead.org;
	Thu, 22 Oct 2026 18:31:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B480C60213;
	Thu, 22 Oct 2026 18:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E31B1F031E2;
	Thu, 22 Oct 2026 18:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792693897;
	bh=houCfpQumQUvgNpKAR6G1uMk9OC0BWmJbHWo907DfxU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=oSY0SkPVcU+zWu1jejWdElrlyEeszdhAXeGj2zO09r7SsaFMR0B3co1iy8xBmjPP0
	 nGz8+7abd/Zig+en6pTlihgGtVNegVLDwXvP5t2yVeFmXN2vrcgAumMFcTS3adnRCO
	 fABdRYR7d3Bfolozt5bgCUL2A9c1JiAQiDhdL4I3XdNwFZNaxtMYgOvcg7O10nbkLL
	 WIdyrJOFtxOiGoySfSDF9kMVX4EE3fnRttFeaqBcBrhTHN6o7p3TcsiSANqNVc6KJg
	 qaalSGpLF8bdmuPBbjaS0+jy/m8kMPVFv7H8Y0zaGZ9cS7Mb3riIpt0Zo3d9r7YK5u
	 xpuUCNO38Yg6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 650F1380822E;
	Thu, 22 Oct 2026 18:31:37 +0000 (UTC)
Subject: Re: [GIT PULL] uml-for-7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261021081440.697408-3-johannes@sipsolutions.net>
References: <20261021081440.697408-3-johannes@sipsolutions.net>
X-PR-Tracked-List-Id: <linux-um.lists.infradead.org>
X-PR-Tracked-Message-Id: <20261021081440.697408-3-johannes@sipsolutions.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-7.4
X-PR-Tracked-Commit-Id: 4ad423aa2108485f8bc5dde51fdf9c1ed979ee4b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7cd80b8168c9269e4b11788ce815c0f446ab5b34
Message-Id: <179269389626.87271.15718849308077192326.pr-tracker-bot@kernel.org>
Date: Thu, 22 Oct 2026 18:31:36 +0000
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

The pull request you sent on Wed, 21 Oct 2026 10:13:21 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-7.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7cd80b8168c9269e4b11788ce815c0f446ab5b34

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

