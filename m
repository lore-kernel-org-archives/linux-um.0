Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C18DC4332F
	for <linux-um@archiver.kernel.org>; Sat, 15 Oct 2022 01:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oMjbLdpr+VGdnKnigvKJqt6asoo+GxdpT33/FGiImxA=; b=M5Y254DNIOlnXZ
	JyDjC/jXayg1IPRRY3hlfHVfDOsxbH6rGREhDaWaBrrEV90eOyFJ50NvggJLhQvdRAIh6+AUnlF7n
	5URDDoFgnUpyolNzK9yNYZN+exKfQ01gsmzdNvXG/EIrp6NXmfVayIjZhU0xAZ2u4JYReR0YXACBl
	XquvjhY3nfPdamc8rZ3PjCq238w2lbDFD9PqtYFdZCug2LO9c5QeSIFjD78ZK8FUk8IAGVRteb4R/
	KSgH/1yDbFCT3HFAiMzteOgZQ3bNZLQsTz1rU2BH3NMBWRdppFTv6YT9zzbSwxcJexR0W9S6fl1qk
	W/S0Epx/HfhfL/YvsG4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ojVx3-00GGVm-Gy; Sat, 15 Oct 2022 01:26:57 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ojVwz-00GGTi-7s
	for linux-um@lists.infradead.org; Sat, 15 Oct 2022 01:26:54 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 75F88B818B2;
	Sat, 15 Oct 2022 01:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29E10C433B5;
	Sat, 15 Oct 2022 01:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665797203;
	bh=c/fGbm9B1WCtqJFUkSd72KRFVg9PAxNIyOwfuz3qOzA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=n5qTwF2DFa2H2E2JcWB8344j9FDyED/KdABThTyvJhnJOtqOgwi6zhD+OhuEojV0A
	 R1HKOu/foHW34um1GowJtRREnUrC/4DZ6y1MmlrrAO87hR1OLrcVbX2JF63GSRihi6
	 MpZUJ9bBFICBzbfsDKDRN2Oeb3gNzNWJUIgLDhONs1dhLD5uYAkfZqZDoC4uuQkh8D
	 LRV03Y0TF/2A0oj7zHE0rCEIIV68OSjEnTUnkKK23zIEnR7Uq7zxv7BaNtJODgs2f7
	 fQ3qS8O7O6sqXZC8PWOHSY3jM8PR6roiRs/HFXWTG7bh/FC3GXCaOGGC161pjZ3Bhr
	 NBp6cKrcqn1KA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16C0BE270EF;
	Sat, 15 Oct 2022 01:26:43 +0000 (UTC)
Subject: Re: [GIT PULL] UML updates for 6.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <1664125781.30715.1665782235123.JavaMail.zimbra@nod.at>
References: <1664125781.30715.1665782235123.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1664125781.30715.1665782235123.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/for-linus-6.1-rc1
X-PR-Tracked-Commit-Id: 193cb8372424184dde28088a4230a5fed0afb0ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91080ab38f3eaa2a0af4888220d007698a2e7b03
Message-Id: <166579720308.30479.14940625172124884688.pr-tracker-bot@kernel.org>
Date: Sat, 15 Oct 2022 01:26:43 +0000
To: Richard Weinberger <richard@nod.at>
Cc: torvalds <torvalds@linux-foundation.org>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221014_182653_439172_74A4FE7A 
X-CRM114-Status: UNSURE (   4.25  )
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

The pull request you sent on Fri, 14 Oct 2022 23:17:15 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/for-linus-6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91080ab38f3eaa2a0af4888220d007698a2e7b03

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
