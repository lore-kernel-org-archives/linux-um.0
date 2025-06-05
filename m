Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C0CC5AE59
	for <linux-um@archiver.kernel.org>; Thu,  5 Jun 2025 18:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PGxFa2uf7+2Gm/ZY+fJjO/Q/ApM3TzF5s+0ZRzOQPv8=; b=Kws4fHbJg5UQ8EOWIlSpgO2PMj
	rCBWmN1IGozMJI9VuaF1CBP4mQDRfNsikKwJWVl/e4kBlrXvkRWRuHG07MQi6wXFJ5DHj8QffSjOD
	AwCtUsj08FeIPpcGzU+jiyusshi0oezS/NK6P5XwFPu8neDE6RDDgKB5nYX8ZRq51/BJKhxYtfEGg
	2nY995+HqQt0ID9EwNTyZXEcLq4PsW5GwNk9L5G99cPz6yNk64ddVcCZiu6t/cfvlZqkhU0msMqn5
	q3ndhnZbGjulKt8PsNd6RZ6HtKwixkiqdOS40Sum9uucToHcu29ZhVguHEy/XQtBWhsNQ5ArMQlED
	LTjE46OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNFhv-0000000GQRv-0AFw;
	Thu, 05 Jun 2025 18:52:55 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNFht-0000000GQRn-3VHH
	for linux-um@lists.infradead.org;
	Thu, 05 Jun 2025 18:52:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 438A3614B8;
	Thu,  5 Jun 2025 18:52:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DBBC4CEE7;
	Thu,  5 Jun 2025 18:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749149572;
	bh=nyOTJpThVJsfUYv/oE5C1pTn08Qj95h5whErxwTkch0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dbbXAkzLbv6mgraPk9/kDdOEZFy53+4Lgm7vvBw6ZXvVXde7DPIk0bLhdDsM6lqv5
	 5LB8VI61vC1S3u2hchEU5cTEdNWFNtZ23tUTfTwRqOP3mSvxM2ar3FsXzya7lAQAy2
	 sBAVjhEzO2RCW7ylnkE3N9GsZO4IUeUsk8T3+Hdit9o5s+oBKaciDwZuVfCm64QDAf
	 GxSpDlXuGDowpll/Pbjv/f44efXjLaanIt/3mpZWwmIbfitCUhv+7Q3aU5RCLxkE0c
	 06lSRH7euiv+vYnX1n/X3OsB/0552k0kVWMP+/rZEhz99JqIUFmN0O1wc+10Ml5OQc
	 nlGZp5WW1SW7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB33739D60B4;
	Thu,  5 Jun 2025 18:53:25 +0000 (UTC)
Subject: Re: [GIT PULL] uml 6.16-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250605092423.14973-3-johannes@sipsolutions.net>
References: <20250605092423.14973-3-johannes@sipsolutions.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250605092423.14973-3-johannes@sipsolutions.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linux-6.16-rc1
X-PR-Tracked-Commit-Id: e56a50ff7c12983aba710bd02a2c2ad401379e91
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cfc4ca8986bb1f6182da6cd7bb57f228590b4643
Message-Id: <174914960462.3197273.4053353076250915287.pr-tracker-bot@kernel.org>
Date: Thu, 05 Jun 2025 18:53:24 +0000
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

The pull request you sent on Thu,  5 Jun 2025 11:20:57 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linux-6.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cfc4ca8986bb1f6182da6cd7bb57f228590b4643

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

