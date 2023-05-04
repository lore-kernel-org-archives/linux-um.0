Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F685C77B75
	for <linux-um@archiver.kernel.org>; Thu,  4 May 2023 03:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dvcR1/BwYrCkdQ5ax7mQpUENCqX70BFRw5z2c6Xc0D4=; b=sFdowLL1DZKgc/
	wuDmsMyUdoQkC/dvqbgDXUf75AKklLItBzj1ZUtMckNbPKOqPNgnZKJ4TxYoY8yum5UO0PjaRqbTi
	Y0GwC80cz9mqXsxGOhz4E8J58npTrrhjN7MSx9MgvTVZS3PApQ/brri/HkmPRo/IemL5fvdgThfKK
	93I7tB4c5vALI+9SQO2I9TNBK4EltCbeW8GGR58R8JT7uFogWDf02BczBm2m11WugLNp96skY6yDS
	1TPLWvhJMdKYTs3x3nkXQ3/E9hEzQtptI3Ho7IPIRLS4LcnLJjrSSPJMwGxW8BFtk9skIlbBLt0pM
	gHrhRI6E2VtAazynym/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puPPV-006RvW-2S;
	Thu, 04 May 2023 03:13:37 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puPPT-006RuP-1Y
	for linux-um@lists.infradead.org;
	Thu, 04 May 2023 03:13:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8F82561142;
	Thu,  4 May 2023 03:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3C88C433D2;
	Thu,  4 May 2023 03:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683170014;
	bh=BT17TKv14sHR5a5L0wHp6uZenNcjtUAts+/j2AlaLt4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YVApyGFuteAKQKDiAo+vjztt6QpnEXHISgCnL+UkFVq5ITBwhpRDBGSa81bNGAI7P
	 XKqdrmtnybGvkMU0KdihHRe+Zdlbkue8cgFfCSZ/H+7MPejA89QzIVIGRjbeZuwK2+
	 GVSbcXu8Odq0gfu525DBxET2YuON1pI67OGJlvqtmn8ca3Wd6I00j22iYq3sHp0hif
	 UZbCbE3uA5c8opeSRqyU3Z/uOWDWLswr+t/RokkUxAvsXbe5bPP9xyQJLrWUyqZK5F
	 OUe/lY6wCVdT2F1dxODssg1HJJD3fqsf81lsZFskMLYqhv8eJeBP7ehaHAE6oCHp6Q
	 81DgMSU8xpnVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2518C43158;
	Thu,  4 May 2023 03:13:33 +0000 (UTC)
Subject: Re: [GIT PULL] UML changes for v6.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <1396818281.2692347.1683141946452.JavaMail.zimbra@nod.at>
References: <1396818281.2692347.1683141946452.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1396818281.2692347.1683141946452.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.4-rc1
X-PR-Tracked-Commit-Id: 6032aca0deb9c138df122192f8ef02de1fdccf25
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 342528ff00e8a7dd31c1ea0c0093c2289d769b39
Message-Id: <168317001392.23861.17628098609837409912.pr-tracker-bot@kernel.org>
Date: Thu, 04 May 2023 03:13:33 +0000
To: Richard Weinberger <richard@nod.at>
Cc: torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_201335_563635_01079C16 
X-CRM114-Status: UNSURE (   5.08  )
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

The pull request you sent on Wed, 3 May 2023 21:25:46 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/342528ff00e8a7dd31c1ea0c0093c2289d769b39

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
