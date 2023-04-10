Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC30FC77B71
	for <linux-um@archiver.kernel.org>; Mon, 10 Apr 2023 21:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DTdwSuaNbnpkqlhG3a4s2zDDFJyHueXPfEaS7i5R16U=; b=vpPzawDymSZTTo
	na1Ckkw5mju2Hklf+6ruV//WM4WAB4ztEzUIdC/izapjffCMrxEovppxWzkI+ZMt4qfqs2gxixE+G
	q32jR1DS1ntmED5+9byI2QmdgsjDXz+38/zH5bPiCC0KCWwGfaAOAfCUhiUN/g1ig9qITc6bkHtDj
	dxbGDM5J8yeas7yhP+TYvUdn60vzyxiJhtPkwUTN/GIZ7R/ZpOyDpvkgXsXaHLJpu3cMPbcfWpL6i
	ZzqG78u7VB0pXrMP3ijyT75+eLqwisqdG6vcXsp9+Du2N4e6NKUA38fWQShrWcNGKEtSyj8rpiwuO
	8C/Mkv/z5c6m/UGQDJfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1plywx-00FxZe-2s;
	Mon, 10 Apr 2023 21:21:19 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1plywu-00FxYq-2z
	for linux-um@lists.infradead.org;
	Mon, 10 Apr 2023 21:21:18 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D49FF61230;
	Mon, 10 Apr 2023 21:21:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CA6BC433D2;
	Mon, 10 Apr 2023 21:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681161675;
	bh=GQTjWmQAYl0Bg2Q6G9vHO18Jx6bb8XxaEpN+pDKGi2s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oU7NEJDsVf1Axh8FqwBn/NxqLPB9F9nXT+nVPdEsCYb7zV0N+EdreqhaxWHp7OY0q
	 sfIB3chokYG+vkR9cTuq4kaTFU7+2Y4TUjw+UbirP2huDugkSaQIP8LSZ0MeIhSGmc
	 sBq94qJkvCuR3fOl0OI5FHnGRHdoYBUcEnLlkbzrvfTGEr30DO2XPjCFY2QPZRmBhg
	 U7T1SRuk1gcIVIqgZq0U5g0L3g8R2LWFmMzUEfRCLL77MJsBARsoFVZnoLthhOrbdh
	 6SZa51ZH2SnUOJfwxTOJwCNdxNaLYngPJL3ZQmWepdDtvsohN6JUWwKqEPafPir6dq
	 UJYbxJrZbj5MQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A57BE21EEE;
	Mon, 10 Apr 2023 21:21:15 +0000 (UTC)
Subject: Re: [GIT PULL] UML fix for v6.3-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <272357376.30348.1681071196889.JavaMail.zimbra@nod.at>
References: <272357376.30348.1681071196889.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <272357376.30348.1681071196889.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.3-rc7
X-PR-Tracked-Commit-Id: a3046a618a284579d1189af8711765f553eed707
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 411eb014108594d160a20381e8738de6c62e2e5b
Message-Id: <168116167516.31176.14322304442055505493.pr-tracker-bot@kernel.org>
Date: Mon, 10 Apr 2023 21:21:15 +0000
To: Richard Weinberger <richard@nod.at>
Cc: torvalds <torvalds@linux-foundation.org>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230410_142117_023337_831F9316 
X-CRM114-Status: UNSURE (   5.11  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

The pull request you sent on Sun, 9 Apr 2023 22:13:16 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/411eb014108594d160a20381e8738de6c62e2e5b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
