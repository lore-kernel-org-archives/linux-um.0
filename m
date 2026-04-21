Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BB2F5A8A2
	for <linux-um@archiver.kernel.org>; Tue, 21 Apr 2026 00:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C+5XAe57bUm6LVoZJuSZ1y1bUR5zzkUFhL9Z/LPCM/w=; b=aMaanB3WRNzAJT+RscNIkdlK3j
	YAhpPFe4HFILKGaBm26WZwyBV0xcgF423ysH9Qu5VAoMlPs/UDqFJhX6ez4xySRhDizNvZd8bgQyd
	LyWjYNx863X3l12PQHiQQH7e8uJ8j0yOgj5rYNR2FaCcr/ytPmc+uIzlsAr25/9QKcJRS1yCdm4uY
	72NwiGkqWVgJht1hqamQ/aEDm8/BtQavF15rvI/nZgTwdo2p6Af5GhJNi5ko1ggjtxMuLRJX/hBDy
	uPBqR+ze7xCeayu7EyPe7XRQPupB4DxqoDm5uGK1riKesg3it2ovIuCUDbh4HkhmzR5T874ewRFWl
	MjfSaIpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEz27-00000007s2Q-34Pr;
	Tue, 21 Apr 2026 00:32:07 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEz21-00000007s1y-3Na7
	for linux-um@lists.infradead.org;
	Tue, 21 Apr 2026 00:32:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 747534078A;
	Tue, 21 Apr 2026 00:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F059C2BCB3;
	Tue, 21 Apr 2026 00:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776731520;
	bh=+3IdaYa2VdMpLGvwxTcOILLtpgFomhVHUkaFb71wk3U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IpN03wIsYsWxEWieVhWBQ1Hp3HPRlDPQ5cSVtEuitEdHHGpjLE58ODg2qnKHqWPbc
	 makVhJkpHmpKI1hFdv6UXoOM/zSIv/qyhB6+xh4phbmyZw491xZHINqtf7P4WRMrp3
	 kAo6XskQkcNLj9JeBGhaC2HiSixz00PZQ92iEdIlsr5bcgn1AzBqVFw/MwWRiCo49L
	 S0niHm2UuJxzLTVlfG3OpvScRwj0SojK9alHHnZcCnMOsSOgBT1P/u/uyDUAkGkydk
	 MlUR0a9y+UegNo/56su8pbqsyu9ov1F/smqrxGarT9Md36IEuoLeVw6BisnBWvToD7
	 XWjBMbb3Etkfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D1B33930023;
	Tue, 21 Apr 2026 00:31:25 +0000 (UTC)
Subject: Re: [GIT PULL] uml-for-7.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260420132821.364484-3-johannes@sipsolutions.net>
References: <20260420132821.364484-3-johannes@sipsolutions.net>
X-PR-Tracked-List-Id: <linux-um.lists.infradead.org>
X-PR-Tracked-Message-Id: <20260420132821.364484-3-johannes@sipsolutions.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-7.1-rc1
X-PR-Tracked-Commit-Id: 6522fe5c1b007c376fc5f2de1016c99a18b0af8e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 065c4e67cc2c40e6dd94649e8e720096fbabd4ee
Message-Id: <177673148411.2145745.16251126765052810684.pr-tracker-bot@kernel.org>
Date: Tue, 21 Apr 2026 00:31:24 +0000
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_173201_862707_656E0AA8 
X-CRM114-Status: UNSURE (   4.05  )
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

The pull request you sent on Mon, 20 Apr 2026 15:26:12 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-7.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/065c4e67cc2c40e6dd94649e8e720096fbabd4ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

