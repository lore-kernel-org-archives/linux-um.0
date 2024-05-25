Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1058DC25B7A
	for <linux-um@archiver.kernel.org>; Sat, 25 May 2024 21:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vmUIxH9eiQvP/jcutl58LMjAABFhmfU2Gv6SAMTfwgM=; b=d53inlnK+aeRWvkK7gr8CVnc1o
	f7qOqx2LrBMrnfYwrmcc60jv2Kh50UnbZ1ePx+e7LQAnoVgXwYilUyFMmbJbG0r8YfHPE6H4ATf/1
	Ft2EWIa5Pc8nVk/zqonBmCOpGUAbdXPDFQYATe6qoZ2skpUuay4rGwVctgN4v8E9pC6AlbltOIeK9
	MCYKoGlexqHgWefhxdTK2LEFU8JVp+kCmo8UtFwEj/JWBiqdCkZDAmEuR+VDVFbV3k9DN8QWrpOI9
	y0pFIaLUqA25gU7QdektQmHhRR1lMeY15nRyqBu+gFFBKYK+kVcy06gUYjBGnHFdCWZ+h+MX1Pu0T
	jnyypHqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAycx-0000000BhA5-474g;
	Sat, 25 May 2024 21:08:31 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAycv-0000000Bh8D-2Rgy
	for linux-um@lists.infradead.org;
	Sat, 25 May 2024 21:08:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id A023BCE0ABC;
	Sat, 25 May 2024 21:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF231C2BD11;
	Sat, 25 May 2024 21:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716671306;
	bh=RAZPcuVaUgluuMJrmJ8VJE4uzWC0bD7VIThHXQfwhRE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lJ1mQ8WA0DAF3DuFpb2oHlsbaYYxchU75tvIyBN0MKWRe61VQZ8AjoBAlb6uUXC2u
	 AR1yOuuSmW3TfCqsqDyxyBpDqRl+UF3tGzed6MuX9hwuh6AH5C0IiuS3+CbWuYOYf7
	 wmKeqUczmz+Nzg/beKOpLGdkJqipVE1ByS4W0u0trCcJJTP90aDAFP0veyfUkgRAc0
	 zPpzeb1eb9i/zg3u4N2zaSSTqG2cm8581r3sJOqDa5r6KtUywWJ0mMaPF3rwP5/Kp7
	 09GViwCFWJeZDdCKvYJ51eVO8ZxUa9pXyU8tHWacbBOiVuNxauuPbUo0dx5EeEFqyi
	 VJa3LcQrk5/cg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7526C43617;
	Sat, 25 May 2024 21:08:26 +0000 (UTC)
Subject: Re: [GIT PULL] UML changes for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <291644210.144818.1716585972644.JavaMail.zimbra@nod.at>
References: <291644210.144818.1716585972644.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-um.lists.infradead.org>
X-PR-Tracked-Message-Id: <291644210.144818.1716585972644.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.10-rc1
X-PR-Tracked-Commit-Id: 919e3ece7f5aaf7b5f3c54538d5303b6eeeb053b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2313022ec5942e3ddd2e4e57002ed71926887f87
Message-Id: <171667130687.10959.410466621483892256.pr-tracker-bot@kernel.org>
Date: Sat, 25 May 2024 21:08:26 +0000
To: Richard Weinberger <richard@nod.at>
Cc: torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240525_140829_820388_F48E35B3 
X-CRM114-Status: UNSURE (   2.60  )
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

The pull request you sent on Fri, 24 May 2024 23:26:12 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2313022ec5942e3ddd2e4e57002ed71926887f87

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

