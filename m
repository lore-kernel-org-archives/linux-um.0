Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EF3C0218A
	for <linux-um@archiver.kernel.org>; Fri, 31 Jan 2025 02:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e6BgG9edDrq97MqZzc0l+J07DuSK0WDXwtUo4HmlZ88=; b=tWvaTnmUrNfccRLQ4ARUSK7o5f
	5qSDNuIuw7+PyrSuDQbssGF+gwJ11VMPJ1H7F33VslZ+xith5Y3YFOuJ0ZpPdj9yUlh4CmhHt56jm
	k/QM7iGvo8b+kFBIplVTILSUaUSOLWT0Xu8JB/DMIgo9HyGDwmmMzF+Vk7hJUdj8yDcRLsVWFlZla
	MI2Cnntdt0B37SDogqGK4me9cauhZ7gyT9du4w83UYcChiyuN/BL32JP8YLci5oLBxv9SBoKb4ZlT
	Pc0+VcjdiqnRgKfO3J60aQHLBo1cbrqApaovfw1/QgskQLxNxZE2qo6st6OAnv7lYZAWqveZ/WyO3
	MZyAkJig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdgpQ-00000009wOx-2RC1;
	Fri, 31 Jan 2025 02:32:20 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdgpO-00000009wOd-1PPR
	for linux-um@lists.infradead.org;
	Fri, 31 Jan 2025 02:32:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 7F324A4034F;
	Fri, 31 Jan 2025 02:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E25C4CED2;
	Fri, 31 Jan 2025 02:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738290736;
	bh=n0btgpOVEaK9cjwukf4WHWCJO7EIm7N6TtbUfHDZzrs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ptFkiomqfP3SiGihfR7YUQ1ayXpAzY68PPj02vc7bqIUWtY2EcxPjiafCLqzR46GN
	 n+WsSJmM1R0tIpBlj09D1l/JcbaCuXNSBrAtJIJwNS6q3J2cMFzRxdb5PMuuJ3/O/z
	 jN12UGah959DvaKaRMGsLvobpzOMEJpTj72UsWV0WvUiipvl/zOHXfC9OD1rYOilAo
	 EOfBgPm8XvyjmkkBsAg7cw3UsyLf0Dr4cVBmxV+5nQg4gzz7K+orrkQE/eSkso7Pcu
	 reYGJHOymJwP5dJSaCItsYno8VpcisszzLZbzZDLqPutmADEpbBGXaqLzmW+Yx0NR0
	 E0IUGKocIhGlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2DB380AA66;
	Fri, 31 Jan 2025 02:32:43 +0000 (UTC)
Subject: Re: [GIT PULL] UML changes for v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <1821733080.304331864.1738275118129.JavaMail.zimbra@nod.at>
References: <1821733080.304331864.1738275118129.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-um.lists.infradead.org>
X-PR-Tracked-Message-Id: <1821733080.304331864.1738275118129.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.14-rc1
X-PR-Tracked-Commit-Id: 2d2b61ae38bd91217ea7cc5bc700a2b9e75b3937
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69e858e0b8b2ea07759e995aa383e8780d9d140c
Message-Id: <173829076262.1153141.8687646823693580370.pr-tracker-bot@kernel.org>
Date: Fri, 31 Jan 2025 02:32:42 +0000
To: Richard Weinberger <richard@nod.at>
Cc: torvalds <torvalds@linux-foundation.org>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250130_183218_441762_3C72B369 
X-CRM114-Status: UNSURE (   3.20  )
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

The pull request you sent on Thu, 30 Jan 2025 23:11:58 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69e858e0b8b2ea07759e995aa383e8780d9d140c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

