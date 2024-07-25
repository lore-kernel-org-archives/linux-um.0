Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876F9C3DA5D
	for <linux-um@archiver.kernel.org>; Thu, 25 Jul 2024 20:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OCIaIawHKdfpxvbGM0nvOPp/vxUa7udyHhEOqJXPxzE=; b=0hY9zAVb/WBR2JnPs/iAQaFZ4K
	m9fKZAx6rhKYNcG9LmsADTSmtyE6RpXpplZ4EZgC9TVIDxbhKBIs8TBjTPMrYrBAmTCAy9Gaf75zV
	/EhozsniviVQPTF28NklfC/7Ga8og9LSLuqVr5aoAimh47mOhiXUXlugVllr/EUISmXQDktrKTRXS
	IMH0XGhrTCllUQ++T9xFL+UT1vYMcjgAH/iFAQ6jRCs1cGtH/x7BKXTs48EI863EBxgjAyww9fFrn
	Gpe0IbsFjgFY+3R1mOek8wMaDDH6dej8dOl/hS7j0HU9ONYVZuViED+Hz8rZgOlGJ64pdvYR9oI+y
	JZl+P8EQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sX5D4-000000023op-2M1E;
	Thu, 25 Jul 2024 20:37:10 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sX5D0-000000023mh-3ktv
	for linux-um@lists.infradead.org;
	Thu, 25 Jul 2024 20:37:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 888A66131B;
	Thu, 25 Jul 2024 20:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3891BC116B1;
	Thu, 25 Jul 2024 20:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721939825;
	bh=D9RjB2jXGKqnWUMj3zxynbFufpuXvEAe+wy285cSBR8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZYXJ5pXwE4+B3u1fKTQPHXLPtwWrtvZ7yGYwFes8SLDQC7hMBSSmHNPNxV9mQLPhT
	 Ip7O5AIqCYtTGVZUWTEEJWenlYCsgrtdcmvl8y4eOtZaMtdkRs9eR70Gx4oqK5MVSH
	 cmMQ4ScHZQGsmY18OYk4wUC3o7ElN9nBHjqoPYlohj76PtKKzXM4XAI0wMPtAXv/iy
	 TUhWmFOrSeX0sFkm12VqTN3MvCMvEtrkQAhR2TkkqSPW5XzmbsWa/7ypi1+D7UmWSE
	 ynBr4jan7cvjPpKOjHqP21JqHbKJW/ANd+dGBYzXdysXb4Wv/+ctSYjeHddcR+f1iO
	 LA71ub4e/pZpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D172C43445;
	Thu, 25 Jul 2024 20:37:05 +0000 (UTC)
Subject: Re: [GIT PULL] UML Changes for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <158184774.112608.1721836446346.JavaMail.zimbra@nod.at>
References: <158184774.112608.1721836446346.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158184774.112608.1721836446346.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.11-rc1
X-PR-Tracked-Commit-Id: 98ff534ec2cd02496c166614e6c1391d8e092e51
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f9bcc61ad1fbe7dbc6bdd71d31254e429100a009
Message-Id: <172193982517.17931.4930183829469370163.pr-tracker-bot@kernel.org>
Date: Thu, 25 Jul 2024 20:37:05 +0000
To: Richard Weinberger <richard@nod.at>
Cc: torvalds <torvalds@linux-foundation.org>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240725_133707_018136_5B9FD053 
X-CRM114-Status: UNSURE (   3.44  )
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

The pull request you sent on Wed, 24 Jul 2024 17:54:06 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f9bcc61ad1fbe7dbc6bdd71d31254e429100a009

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

