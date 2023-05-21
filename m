Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8690C77B73
	for <linux-um@archiver.kernel.org>; Sun, 21 May 2023 21:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PIHywq9D5ZlWcEVNyY2gppRHUDAAtuBmbTjwNn/UBMA=; b=Y/67U00D8LaWLk
	kpX0dXeDIWGTZDp78H+Men9bejF4arP/0kP3lNtemYYzXwI42KWTLM7xjaA9gR7h8yLGFISoI5GwX
	o4JBOH5Angk0S7NGnrLRJHQaoDpz/2wEEKEuDlV803cHUap1eVaib3IxkWleYSjIGa9xmnnTotyBM
	YcdW0rQaCWHYPWz/Z9QZ8JRWvzLyPAsZpN6kyPBcsg9ClYfcfMXcno+N/6KqkfWfCUYrwXxAWg0qD
	0wAkq+N2dBD1hbevuFBuxzDOcQOHrBoD/m3CYB5p3m2PIZAzDmV8aEwA5LpvKzaDMc8vkLOzUwxlR
	0X/mOg6j47sraXvRLUOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q0qEa-004fXX-01;
	Sun, 21 May 2023 21:04:56 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q0qEX-004fX9-0D
	for linux-um@lists.infradead.org;
	Sun, 21 May 2023 21:04:54 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6F4BF617EB;
	Sun, 21 May 2023 21:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D308EC433D2;
	Sun, 21 May 2023 21:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684703091;
	bh=fJS5rbYIDNbLQX5J4VmvwHyFPCLIwLhwflXUWTy+wbQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gLfeCajHKPXhYwKyQnLiHC4vORuaGY+AbdIR+nTQiluObAwyV33385YAz1Na0P6+C
	 Eu/qWZSxcLk7ZW7nr7r8spX+dwSlwUynqysPss9RNjExFhzXUqCSSvBICx4ZLLfA+n
	 44TLEz/aJOtD0gC5D6j0wcn7UxBvAK5HPG+XaEU0x/x103ECYZRsAMAY2r3mALYli0
	 VKf9cj1U3l3h9kcY+azxk2wRczs4dYaC5g26brTgq6Azsb6EObzhjcXdXacRVgFZuE
	 D1buRjOof87PDGLkdniqcsqR7AD/+VOjL06XBvSjevHeK/UW0fl/ZJ8y2ScNZkZ4lD
	 9wvpw3pin+DAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE0E4C41672;
	Sun, 21 May 2023 21:04:51 +0000 (UTC)
Subject: Re: [GIT PULL] UML fix for v6.4-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <541536756.9328228.1684699797626.JavaMail.zimbra@nod.at>
References: <541536756.9328228.1684699797626.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <541536756.9328228.1684699797626.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.4-rc3
X-PR-Tracked-Commit-Id: 73a23d7710331a530e972903318528b75e5a5f58
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa4fe8ce4256bee870eae1c4a5b33ad463590230
Message-Id: <168470309177.10838.17577002282279990550.pr-tracker-bot@kernel.org>
Date: Sun, 21 May 2023 21:04:51 +0000
To: Richard Weinberger <richard@nod.at>
Cc: torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230521_140453_149969_A0BAF459 
X-CRM114-Status: UNSURE (   4.53  )
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

The pull request you sent on Sun, 21 May 2023 22:09:57 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa4fe8ce4256bee870eae1c4a5b33ad463590230

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
