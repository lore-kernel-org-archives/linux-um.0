Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A35D735F2
	for <linux-um@archiver.kernel.org>; Sat, 30 Nov 2024 18:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X1cn49xAPPCCqEVNvr+wQMcn+IPEAWDb0v9tAuYkOxw=; b=t6pf5BzXvdyn0EdX4xHEHMTqo0
	KuLLm7+B3GI5cOE9niLqFMt8DmSQN3nOjQIKRW7OiZdpHprPFZy/uMVNGFWNuK9O/tDWjZVIlzOMz
	TNumJ9S0nQq8iECr/EjUfl6KYagMh3cFo0bUhJDKVwMwG8opgVY4PM/xxBcBwBUBmX9N+qXWTDf+u
	0rxX8ML3yDaTJsvTSTTMt7Vu+BGoCSPYlZBmswisfAN6AIlKeQlwh8lrHK1dKectkg9TZ/mHe3rj1
	URMupe8tDPz2WMOs+HD1tQ7jBU6KTT7Jo6TSTxcHh5NfP4EDghqYBbYzZNNpVGWJvT54E1eTttrMA
	mXIyh1rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tHSMS-00000002QKK-2ePG;
	Sat, 30 Nov 2024 18:38:32 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tHSMQ-00000002QJu-1Hiv
	for linux-um@lists.infradead.org;
	Sat, 30 Nov 2024 18:38:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 89FB35C48EA;
	Sat, 30 Nov 2024 18:37:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E22C4CECC;
	Sat, 30 Nov 2024 18:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732991909;
	bh=W/QJuPQIZUogHzPC03u+zV7UBqdHKiYcFHeWPcuY+h4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gx10rEwMnsCW5SNUWSLF3SfOrwaQOu1i1tVcSTq9sxZSv75Tv7KVc5SjmP+OOOqHQ
	 iYXDvc7zQgohVpxKd/dXWMZxkA1rGz9xre2QJlbv+2vMXqZeI+ImD51iLpDbEWciLQ
	 rzX/8DLkegLkfqOX59GDvXrxfeXJBz623qdmWAJfQaDv8eENtedfwqDOaLcN2NwSho
	 ddxnnbPsLkzZS5+DkXQjW8G0DU0OLCOU2K3q3IVFPEGDPEgSmMfQmnrK60haU30ZDi
	 HUzSJfkiDQbYDLYKTi1ZlO/ZpySCZB8620JxdbqPm9MtYYp72NCNrGRfqvDw4LyTTO
	 j3M8BFS8toWHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34478380A944;
	Sat, 30 Nov 2024 18:38:44 +0000 (UTC)
Subject: Re: [GIT PULL] UML changes for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <1155823186.11802667.1732921581257.JavaMail.zimbra@nod.at>
References: <1155823186.11802667.1732921581257.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-um.lists.infradead.org>
X-PR-Tracked-Message-Id: <1155823186.11802667.1732921581257.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.13-rc1
X-PR-Tracked-Commit-Id: bed2cc482600296fe04edbc38005ba2851449c10
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 831c1926ee728c3e747255f7c0f434762e8e863d
Message-Id: <173299192287.2451487.16897611469630516621.pr-tracker-bot@kernel.org>
Date: Sat, 30 Nov 2024 18:38:42 +0000
To: Richard Weinberger <richard@nod.at>
Cc: torvalds <torvalds@linux-foundation.org>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241130_103830_406956_3E6C43E9 
X-CRM114-Status: UNSURE (   3.64  )
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

The pull request you sent on Sat, 30 Nov 2024 00:06:21 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/831c1926ee728c3e747255f7c0f434762e8e863d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

