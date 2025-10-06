Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B77CCA470
	for <linux-um@archiver.kernel.org>; Mon,  6 Oct 2025 21:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b62gRjOU3IMX5XW2AzSgfCYGHtngiY8jxv4zMgOlLvM=; b=DqeJt6pbTPVGEIC/0/hC6QCdmb
	GKTXF4+iWxQaDIYXz6b0XH7jjE/azi2b2yXuFRqlb5+iKWXCErVeDjrZ74loS6FD12O+bjVoMYqsb
	NOP+H3jarR2QtoDH069MYg7fyy/4sV12oS9cVstjieJfaBQKB9PuVfe2B1H4qGdicZCXWPZQlrXXz
	q+5w+8i3zVKWlr35xT0jHRPR4rjytgqazRi3WRTrUi1BafAo1t4GNsiLsRV2Xsq468lP+diMxcU+B
	DUK4CHODqXFBS4dZjA+ptMX7QHPbPnhf192W5Q6xH27rY95nQS9epj5+jxpDzbf0HM/ZNnjXJpriW
	HVRrnqMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5sKO-00000000nmX-1C5P;
	Mon, 06 Oct 2025 21:01:04 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5sKM-00000000nm1-23JP
	for linux-um@lists.infradead.org;
	Mon, 06 Oct 2025 21:01:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E6BB661156;
	Mon,  6 Oct 2025 21:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAAAC4CEF7;
	Mon,  6 Oct 2025 21:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759784461;
	bh=vhZ7HKajK6lxxXMq+INHP5c8Q0eOE8Gyvz38BbtjKMg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=V6JdPQlMrvfXf3sSUVj2Z28DITSgn2WdjUtwLoYggdZuWvQ1mXHqozm4eObt7Atvw
	 xqWAdMYfpIYKWLIsnCBTs4RLJ8h6Y67YF7UUe5NwKGPYPHe6EZYHeqS9k33KtlBT8j
	 ChEzx59/aHh6Dcn3+dzMyqwzXxW5Sp+zH7v85i+N3lyUod5eQuGBNup2esb7fIozFJ
	 IpjiII7CWW8yLo3/1wgcEtMz7Y18oIEnI6lzFg1wldSoqroOhHGCwo4Uz0cruZoGe5
	 fohTjcR8+rWLzwuIpDGgYQal9sfjBsZugIy+tyE/kuC6ps2jwF7xgFAn252wzolt1i
	 /2N9Te7VHqpiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 72F0939D0C1B;
	Mon,  6 Oct 2025 21:00:52 +0000 (UTC)
Subject: Re: [GIT PULL] uml 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251006093601.33082-3-johannes@sipsolutions.net>
References: <20251006093601.33082-3-johannes@sipsolutions.net>
X-PR-Tracked-List-Id: <linux-um.lists.infradead.org>
X-PR-Tracked-Message-Id: <20251006093601.33082-3-johannes@sipsolutions.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linux-6.18-rc1
X-PR-Tracked-Commit-Id: e66ae377fe219c98d3d5b8a0d35da4413a5390ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc282d1731ec4686c1a84f8aca50c0c421e593b5
Message-Id: <175978445107.1594692.3062366928983165088.pr-tracker-bot@kernel.org>
Date: Mon, 06 Oct 2025 21:00:51 +0000
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

The pull request you sent on Mon,  6 Oct 2025 11:34:50 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linux-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc282d1731ec4686c1a84f8aca50c0c421e593b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

