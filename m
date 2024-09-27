Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2333CDD1AA
	for <linux-um@archiver.kernel.org>; Fri, 27 Sep 2024 20:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D07GTudWyxvnB6yq0ZGilSBTHxfoaABcictdRIQt8EA=; b=oW55ZXyxUdc88Hpcxna2VbuaY+
	tApO3kBGz34USHmu+UVy6jqlRFtv9F717bSFp5YHNw/T3R+1wnprm65qOmkDcAVxn190nk2kxQbhH
	yddwqxs/AXpeZW10V6D4eWRHmpNSRP9HkeXzBdceu/hpKVQehTAABrVEuYuq/xqfWT4GwHRbj1djo
	GXkzTAT/8uJsC8GIcJVg1MwQE4HLrLAte9e1KdDP8vPWi/MU1AStspvc/8bZlAy59vQxvnvqKFweP
	T33DhcfkFO0jd6KG+ACnXuwjvv5IPEaphkF6Bk2cKYXETz8ZOM6s2DYg+a19Ndg49ttYIqyVeQZAL
	h5qFMpwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1suH8N-0000000C0UX-1Qx7;
	Fri, 27 Sep 2024 20:00:11 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1suH8L-0000000C0Tt-0Kiq
	for linux-um@lists.infradead.org;
	Fri, 27 Sep 2024 20:00:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A50C7A459F6;
	Fri, 27 Sep 2024 19:59:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84883C4CEC4;
	Fri, 27 Sep 2024 20:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727467207;
	bh=pbhyLntCmBmG5WnoN+uNW3p1jxgLshqLGIyKLMvd2Kw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JJXRYlt5J7qVzDlBe5EhzAbP8+4cVfl9/VcudP4zxpGPUNv0+KvfAgJX0f7MjPIeP
	 HdlGSv58mwBBBZncPx56mlKnNLcZR34zq1dbBed9qhDgHnY7eFuPbmdKy6GRIx1fYX
	 0/5mBhT+y+L0fs5Id9zUsUB/zLKkIIj01Z17MtbhQn5Rgwop0g6KsOpWw03Kx21Crn
	 1rk+tsjFwvqtKbuDjl5R8fLMdnilSrKJ2ouE+2yJiJVGFZqJtO6qPoM/2DoUDbwPsg
	 CDtK11mmS5uNv0O0d7v5GrbpjAdnVOQ+Pr39hSYfAAvxTEPEexrBOmqK76SCkZNSy2
	 Q5S/ohUnUMnfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71ECD3809A80;
	Fri, 27 Sep 2024 20:00:11 +0000 (UTC)
Subject: Re: [GIT PULL] UML updates for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <1875454673.111023.1727465292786.JavaMail.zimbra@nod.at>
References: <1875454673.111023.1727465292786.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-um.lists.infradead.org>
X-PR-Tracked-Message-Id: <1875454673.111023.1727465292786.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.12-rc1
X-PR-Tracked-Commit-Id: 381d2f95c8aa575d5d42bf1fe0ea9a70c4bec0cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12cc5240f41a90b7fabc075c92c04846670c6932
Message-Id: <172746721005.2065768.12778610258506118675.pr-tracker-bot@kernel.org>
Date: Fri, 27 Sep 2024 20:00:10 +0000
To: Richard Weinberger <richard@nod.at>
Cc: torvalds <torvalds@linux-foundation.org>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240927_130009_204480_0063A8AD 
X-CRM114-Status: UNSURE (   3.60  )
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

The pull request you sent on Fri, 27 Sep 2024 21:28:12 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12cc5240f41a90b7fabc075c92c04846670c6932

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

