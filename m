Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2BAD3ABD6
	for <linux-um@archiver.kernel.org>; Sat,  6 Dec 2025 01:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YJpfxLcZG8PF8wjN5D2r/HtI/JfERlEvJ6/x80YG1lo=; b=CbDg8FSgcCGhfa2rxGDqr2W4AN
	YMrOdwDlbFzwAblRl7vxDcFRJYynk3lgwtihgjMp9YIJiv2VLFCcJP5SLA54jnsOVFZL4EenO4+l0
	K9reVxHQM1dc2iQAyoVNFgGOOP4qTP9c9g9H8ZyDLJfc30uqMe1M2QHRYj++P6JIZZ/Aksxdfkvxn
	IxVqC5T9IhbMdRGTdO01GqeDYexniDJy0nRn59DIqNLaJ4C1Izh5s/c/dNxaDJNKm0D8BKiy9ZHYh
	LsLLytVopo9wNA2w5PKN24BrTpZg583Klhhvnyyxt8HeUVAKCQUO3sluvT0nL1hjpgkbnGJj4lP3S
	owQ87KQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRh1S-0000000AQ88-2OpA;
	Sat, 06 Dec 2025 01:23:42 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRh1R-0000000AQ7v-1Fnr
	for linux-um@lists.infradead.org;
	Sat, 06 Dec 2025 01:23:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A763A60156;
	Sat,  6 Dec 2025 01:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA98C116C6;
	Sat,  6 Dec 2025 01:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764984220;
	bh=m1ksqoHtNQKVq0MPoDSQVxg+Gr/kalfGr82wLJo1l1A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ByWwQEOCDfC/9BbZ8zdtihXoyq2W5L6Z4Wz4T5agpuvpczr1GJPwoXb9y67QOvN85
	 KTlV6ubbm4Ail54MLcDZb243M6YR4XtzhOrUXtYyMzyR8kJ2FzsXZdiHBeVpL5Ae7b
	 A8fWj0kOb1peVv3pBJiwCKhnlGekRscqdcN80bVQ36M70cy4nNxgvHLsTeahuWBP4/
	 /1d8HpBYrKkBWECtHorFLAuNfzLuY7wv5k/FjxKuSHTFXPsXQloWuwgULu3a+Qs0ra
	 MRho/+v7YIjSN9z+BoqtwY5FVfE7GcphDE2W2onOkHm3jCNMX1dokcEEDtKzJHWz8C
	 fGLi/SW/4TeEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 045CA3808201;
	Sat,  6 Dec 2025 01:20:39 +0000 (UTC)
Subject: Re: [GIT PULL] uml 6.19-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251205091317.8896-3-johannes@sipsolutions.net>
References: <20251205091317.8896-3-johannes@sipsolutions.net>
X-PR-Tracked-List-Id: <linux-um.lists.infradead.org>
X-PR-Tracked-Message-Id: <20251205091317.8896-3-johannes@sipsolutions.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linux-6.19-rc1
X-PR-Tracked-Commit-Id: a3209bb94b36351f11e0d9e72ac44e5dd777a069
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 399ead3a6d76cbdd29a716660db5c84a314dab70
Message-Id: <176498403795.1907434.4955029683143053180.pr-tracker-bot@kernel.org>
Date: Sat, 06 Dec 2025 01:20:37 +0000
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

The pull request you sent on Fri,  5 Dec 2025 10:07:44 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linux-6.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/399ead3a6d76cbdd29a716660db5c84a314dab70

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

