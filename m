Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FCAC021A0
	for <linux-um@archiver.kernel.org>; Sun, 16 Feb 2025 01:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XfgD0mQKaTUFB81kSdNU+hTs1CbhopZNnr51hHZRMDE=; b=DpQ+D6VyS3SB4GuZRc5vBmGneu
	BJLuiH/Ds7UvrdqllYp6c8LhjFgTcoza8xjc8qjD4H02qUazDTikzoHK2FYYyXGbtOiy6VNG3MdQc
	v2dkLMhGnoe53IYOQcwLtxQIlHMRw96NIHkFKATD9z9r1NROz0FpD1ZuGZTWJzb9nqL7tmgkyPBQT
	6x+odQhD+hTGkaREVFJaWlx5ylEVPAqtOSkBddk5EELVxN/2fu/NOmbHVKZ8YVKx7tDPy2nPM6ToP
	DgPSvjewN8lysXjKKmcX02NP5NsTH5Mm90UFsWkkViYgo33o/rzf+BKvZKQmCTCASolD+dKJROJoA
	FmqxFnoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tjTUq-000000011PX-1xQx;
	Sun, 16 Feb 2025 01:31:00 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tjTUn-000000011PE-3H6P
	for linux-um@lists.infradead.org;
	Sun, 16 Feb 2025 01:30:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 3A588A40351;
	Sun, 16 Feb 2025 01:29:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015E0C4CEE7;
	Sun, 16 Feb 2025 01:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739669456;
	bh=3YetL3Lv/olz+1YE4egUUtPuEGACFO8MJgaedyA2Ulw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rXnMh5bLZTlwGnY41OxSogb+Ogrv2YcN2bu8rRIcRS1PBIBMTx1WfgeRudDhokGYM
	 iuncG6Mo1UeaufuoCYgQUIrORpBYtzYsdEPjzGxaOM1wUE8ZxwCzUcbhmricuzz2Le
	 uSulO4WVbz3C+V0VyNtr9i+h2oPTiIA+vK0Tpn39/0/KaUHDJno7aSCKiNjfdu6Jvo
	 ORgT/sUjLpv6yBTSGgvtHTsBa7t0bMj3Z9lGFdnEhJsHUU8eENZtfKVInX4tL/v8kM
	 99k6CXlfQaqgLoXFXEfABTZGpzFpkyJPciKd8frw5hLCOpQnSyONnUQhgck8dL49UW
	 /KVaPWjR6yUlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB10D380AA7E;
	Sun, 16 Feb 2025 01:31:26 +0000 (UTC)
Subject: Re: [GIT PULL] UML fixes for v6.14-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <153400218.11019314.1739658063786.JavaMail.zimbra@nod.at>
References: <153400218.11019314.1739658063786.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-um.lists.infradead.org>
X-PR-Tracked-Message-Id: <153400218.11019314.1739658063786.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.14-rc3
X-PR-Tracked-Commit-Id: 96178631c3f53398044ed437010f7632ad764bf8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad73b9a17d66366d8c9198bc90f1ea99f24a912c
Message-Id: <173966948559.2369003.2899535406284130331.pr-tracker-bot@kernel.org>
Date: Sun, 16 Feb 2025 01:31:25 +0000
To: Richard Weinberger <richard@nod.at>
Cc: torvalds <torvalds@linux-foundation.org>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250215_173058_274406_9C11984C 
X-CRM114-Status: UNSURE (   3.02  )
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

The pull request you sent on Sat, 15 Feb 2025 23:21:03 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.14-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad73b9a17d66366d8c9198bc90f1ea99f24a912c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

