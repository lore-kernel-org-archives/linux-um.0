Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5520FC3ABBC
	for <linux-um@archiver.kernel.org>; Mon,  5 May 2025 17:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iN/EEF1jOVTqR39xbN9YKCFlFu1VJHc4ZsVAcGLkmx4=; b=q418WtZQ3OCR+jpXljT0GcJP0J
	2fjoF6AHyB8AeTGecouHbHvdSR+JVIJ4BthLZIPeBwt6Ha6j4xsz0B1lPV5H7m5UixmD6dpyrOtaB
	VSuL27/uUjXYtUtn5c8VtXHfoSB5dugj2qFpEaU0dEdQvHAlVf5/xxkxlgBsWAuOQ7VVFuKzAIesf
	7wE1WO1TUwGrgUvhFXvWZ2XVi1+A+zdC6TKad1z6/eippKb+ILxY31xwQQmb5IR9J1OCrc9AwAU8o
	AN6b6dgL7HLur7874uTWB5Ij0zclmKtofOrOs9yFCZ3mTA+AXTUtrz0JjeCXz0BERatWDDN43Oij/
	iUTnLowA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC00i-00000008Dxo-1Vav;
	Mon, 05 May 2025 17:53:48 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBzfV-00000008A9B-2YU6
	for linux-um@lists.infradead.org;
	Mon, 05 May 2025 17:31:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 1062BA4ADE9;
	Mon,  5 May 2025 17:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF0BC4CEE4;
	Mon,  5 May 2025 17:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746466312;
	bh=kdADjjFy+mNmxeZsV/v3n+fXiF9baLpep1/olt+IprM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IEVU4yZrXD8Nlfi+yScIuMiWZDlpwzZ7tZopYV979Eyr0PJNLh+b1FwYeIkK5Vu3R
	 PVzYDjiECT0qDxzbEGw+KGL/bQ1VdzQep8e82MsPRIQbuoWlgmcG1isclLLbbjHgcV
	 tAcuI9s4SctP4/SocIYiavjaPsPFah67idcGr9+sUHGXFD2VHgvQUnIU7B00bvL0wc
	 ub86hTZVWhq26evXKZJze1e0Udx9J28Ypu/wvjtOdFGnR2ljN3qdKLWl6raw1ekuLb
	 KnUPmlIJ85kdcedVc0cWZhSCRoicYdp2AbJR7w1TAvspWyuVMcWzhPIKH9nyrtnNas
	 1JbEdSEsuqICA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE0239D60BC;
	Mon,  5 May 2025 17:32:32 +0000 (UTC)
Subject: Re: [GIT PULL] uml 6.15-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250505081753.12266-3-johannes@sipsolutions.net>
References: <20250505081753.12266-3-johannes@sipsolutions.net>
X-PR-Tracked-List-Id: <linux-um.lists.infradead.org>
X-PR-Tracked-Message-Id: <20250505081753.12266-3-johannes@sipsolutions.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linux-6.15-rc6
X-PR-Tracked-Commit-Id: 68025adfc13e6cd15eebe2293f77659f47daf13b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01f95500a162fca88cefab9ed64ceded5afabc12
Message-Id: <174646635166.836049.1116985620593938370.pr-tracker-bot@kernel.org>
Date: Mon, 05 May 2025 17:32:31 +0000
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_103153_708385_7606DAC0 
X-CRM114-Status: UNSURE (   3.78  )
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

The pull request you sent on Mon,  5 May 2025 10:15:32 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linux-6.15-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01f95500a162fca88cefab9ed64ceded5afabc12

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

