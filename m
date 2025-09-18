Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE8ACAC59A
	for <linux-um@archiver.kernel.org>; Thu, 18 Sep 2025 16:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FFWpj3DCETV3/+xAs2OoBuO38L7B2vn+mZ0q14cFyC4=; b=oxMufzpkrVcslHPJMHyMMTiwEP
	SIAzcsCkXRWa10cvlX22cuwhQ+EHIxtpp75xnbfvFEWN0WgD9hqro/sxQP9vzRO1PU7hDZbbwuqGn
	W1pDJjcp7etzCRdiIFnhN7FrXRPkmyYKzIAWaTwChayEeM0jP6rMYhbA+a0PzASV5/l3m46XHaU0B
	C23Lqvff6A/44B7qA9gprzQSavbL+yDbU2GCvWwNqdNJTB18xgQsHU0FalK9qxiDeOmaEUxKYODac
	H/o0TfgZPzCsOg8iaIv9J4UtBwRqRgu/MOCpxC27to5Nlcifcj+u2ek6AtjDtlfGEdnOCRCq60iW7
	O5/nUc1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzHr1-00000000h7n-0dDL;
	Thu, 18 Sep 2025 16:51:31 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzHqz-00000000h6y-3h3U
	for linux-um@lists.infradead.org;
	Thu, 18 Sep 2025 16:51:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 42CFC60207;
	Thu, 18 Sep 2025 16:51:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3747C4CEE7;
	Thu, 18 Sep 2025 16:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758214288;
	bh=yp8L8OFoCDjm8nPw/36nCqPVec7FhsvIlFISIRupVi0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YWyxlZiDde0/WKvsoDHkks4vgiC64/y67EDOEob0lVOZUwfVgwvc22FfsCu4tNuWW
	 wiHuqk/TsC118dTi8jYUh5NBNDiNyMWbmvZutKLMkazz7QttADafyhMYTxvFZ4I0Hj
	 c59hV8e+x+J7cGGxfszp1jm0ikRG3fhv9iVhcrJCm6jbGVqyCSQRpxBi4E+0I6sz8C
	 /MDfMeE7YaxYj8d5ULIv9Pz4HWRlmlqW9s8YSTpVxa47Hh38C/VwmMCYokauxKeO6X
	 8TvrWXC4I0gPji5G9MNCKY+n8jiVYprVyJEoy3Uq+O8BHaaVNINYocdP1oXrVx0IcA
	 E6nvYxxON3Ugg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CCE39D0C20;
	Thu, 18 Sep 2025 16:51:30 +0000 (UTC)
Subject: Re: [GIT PULL] uml-for-6.17-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250918082219.6652-3-johannes@sipsolutions.net>
References: <20250918082219.6652-3-johannes@sipsolutions.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250918082219.6652-3-johannes@sipsolutions.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-6.17-rc7
X-PR-Tracked-Commit-Id: df447a3b4a4b961c9979b4b3ffb74317394b9b40
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f03e578c8afe514c82ec9bd9af548b8fe08694e5
Message-Id: <175821428869.2499383.4059485629785074863.pr-tracker-bot@kernel.org>
Date: Thu, 18 Sep 2025 16:51:28 +0000
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
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

The pull request you sent on Thu, 18 Sep 2025 10:20:47 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-6.17-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f03e578c8afe514c82ec9bd9af548b8fe08694e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

