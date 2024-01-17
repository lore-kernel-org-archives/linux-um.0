Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A656C47258
	for <linux-um@archiver.kernel.org>; Wed, 17 Jan 2024 20:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4NONjUZBaosNnUfOSR+JLddUm7U8j74XwNAjCXRfdNA=; b=FePrXkFDc6Gp8hFnWEfQaGoWk9
	v9vcH5GlvlqVEDLmJRQ+qPErtdCLZYEx2dnxkmFnDNeggvif4trm/LV61hJEajgKfIpwtMHO7VNx/
	yhq8v5hUkOGKTOn8B0YHNr5MWAIPCqn/ecU9DEQ3a8Tq7C01Ujca0cUVsUKTtFmf6TFqS44kqT21r
	fwEa0jimzaL8cW7JpuVU3pPbwzhCr93mDQblcIk/nq3NnoO1kBzj5ur+gaVjhcxi34lP793NYsPUx
	1lLhMUKkaLh4yOvVWhzZJ06Tfvx2hxRfbgmg9cBErkO6lysnbU3lTrdx1lUEcqH1aSU+GYv/+oLZq
	6/7uRqPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQC8l-000afQ-2S;
	Wed, 17 Jan 2024 20:03:59 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQC8h-000aZr-1S
	for linux-um@lists.infradead.org;
	Wed, 17 Jan 2024 20:03:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 08761CE1D0C;
	Wed, 17 Jan 2024 20:03:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45A0EC433F1;
	Wed, 17 Jan 2024 20:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705521829;
	bh=u/18+wrcOaSYpC+wdRWxxLpbbgLUNGOBSI18d5aWRoI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rnvAe5QaJqWi7iK2z32HyuWTTv4m0ZkUeQWyUPwEUwsfn6/6nfrKHm0QL95S5LglS
	 uejai86Ag8QktvKoJ+abf2ONOgoshSTE3BmHcEQbZbcV6pflKeyAGbT6u4Iea5605d
	 P/PbRidSHD2sGVaT7xNM4Gqeq2lAc8QylkSGuaP1pC6PwhulxemYko+bOTItlix2WR
	 5r5SU5Y+2ohrCssM8tAy5ZI0vyNRNE9z+s2DxETxJS7i6A7T339JtFNMCShU+jIA9g
	 i9clbQAkuaXn6pqqlUVA8rGrSMMn2m5F+XMq7UxrGsv1WEDwAjC42suVoxoRSzXvzc
	 chqnSD5sjDEfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33586D8C96C;
	Wed, 17 Jan 2024 20:03:49 +0000 (UTC)
Subject: Re: [GIT PULL] UML updates for v6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <618175332.231559.1705178304902.JavaMail.zimbra@nod.at>
References: <618175332.231559.1705178304902.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-um.lists.infradead.org>
X-PR-Tracked-Message-Id: <618175332.231559.1705178304902.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.8-rc1
X-PR-Tracked-Commit-Id: 83aec96c631e0fa75cfe6d6a1b113a32151aaa88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6cff79f4b90a42d73f039564f09fa5d59ec3d8ab
Message-Id: <170552182920.2985.5913378982154556147.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jan 2024 20:03:49 +0000
To: Richard Weinberger <richard@nod.at>
Cc: torvalds <torvalds@linux-foundation.org>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_120356_339251_01A4352B 
X-CRM114-Status: UNSURE (   2.88  )
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

The pull request you sent on Sat, 13 Jan 2024 21:38:24 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6cff79f4b90a42d73f039564f09fa5d59ec3d8ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

