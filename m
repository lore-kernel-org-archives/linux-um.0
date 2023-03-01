Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A29EC7EE32
	for <linux-um@archiver.kernel.org>; Wed,  1 Mar 2023 18:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I3EGvepDVgtGZKy59fcnbX1s5Fl/jPr0XC/5dCFUMag=; b=q9+E0UJz0gxvBV
	ZbXQ8xCw1mVwQTTehzVKxpOumuUovHC0Lu2HXPnxTaUpsnFWA5LXssHXuY1batVeWUuM3ki7udbnR
	ouDoVAZFofjszaOIxBHjF1+iB70hxfRTIv7hHxVZFu49ghenS/CXFf6q3R1dL963jdJCRe37MkH+A
	b1ZD4jZiQmx0DkbXXNIvMC+gvtv/vx4Aca4f0ikbVkqkMw/xeEbe/dVXLI/6GcsYPHJCn1DHWfXJl
	SlxgWDZ2eUfw3npu7W7DXhbYgyNwwKkqgtX2D3EWPXOPGZwM2I09+o4XEOMYLu0jEeGlRyUYnFJXO
	CYpU9DX0lRGhRLIHNI8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXQmL-00H3ky-JR; Wed, 01 Mar 2023 18:02:13 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXQmI-00H3ju-Ic
	for linux-um@lists.infradead.org; Wed, 01 Mar 2023 18:02:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2534261378;
	Wed,  1 Mar 2023 18:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 898B2C433D2;
	Wed,  1 Mar 2023 18:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677693729;
	bh=kO5Wi1sF+r0PAn7FwLozPKkQkacs/Nay+DJ4pfDvRbk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bLfakHSCIDslMw9ZrVqh6VAbxK/Jy6TKX/Gtll4OlxjOS6f7SKgCNyEz95qnyVL+N
	 B9NyjZ6JEYn9+dJEiX6hHt60arV76R9bgycJ6q578YeqaqzQg25pPbkMwx7hl59adS
	 AtF8WPq7UOCpRkXJG847iw6MLGcYbnoIGnluzP7IJt8TVtnQ4RPVwhP5YXVXFrlumR
	 WZfe7kQwsAVlfKJx3L6mjaujVcOuG+FhvWAt3Fo07l2RNeaDDWK7k7xg/+yr79QGOZ
	 SQbU2lpsDnbXkNw1au5gVJmiCV0ZGyPoNxNjOHMgrMlw16zEs/HwTOo/k+bdny5p1Z
	 RCn0IxOTAnU/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 795ADC41676;
	Wed,  1 Mar 2023 18:02:09 +0000 (UTC)
Subject: Re: [GIT PULL] UML changes for v6.3-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <52785855.187162.1677658023892.JavaMail.zimbra@nod.at>
References: <52785855.187162.1677658023892.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-um.lists.infradead.org>
X-PR-Tracked-Message-Id: <52785855.187162.1677658023892.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.3-rc1
X-PR-Tracked-Commit-Id: 04df97e150c83d4640540008e95d0229cb188135
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64e851689e441e66e001ae063d4536602f9f74cb
Message-Id: <167769372948.10213.11066361498534065985.pr-tracker-bot@kernel.org>
Date: Wed, 01 Mar 2023 18:02:09 +0000
To: Richard Weinberger <richard@nod.at>
Cc: torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230301_100210_690848_00F1CC40 
X-CRM114-Status: UNSURE (   5.29  )
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

The pull request you sent on Wed, 1 Mar 2023 09:07:03 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64e851689e441e66e001ae063d4536602f9f74cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
