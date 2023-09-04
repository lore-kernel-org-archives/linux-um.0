Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5A2C83F3F
	for <linux-um@archiver.kernel.org>; Mon,  4 Sep 2023 18:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UfZp61cm9awBUOoVKGKzZNL1eebwWbfk6o92u8vIqaU=; b=S7zYsa1jHcKUNO
	ND7P6yJ6TL9CYj9XGOFkP3nSJaz68U76uqcisJvy81qGwaw8UK2HHO1u3noqgr4NLyQNwnk0xv5Ki
	mlZDl4A44898QPIQX4XlDQYVUzWW5NHekJ5420E9qBsynI9ZxQWHac5DFNhq2Ztfe2mWGlMlSB2FG
	noJV5WTdPeQZWh8z7QzvIsI+K8kvQaqnhslutdIQFbmxAd25xf8sd+e5pcXzHs5ZoVb+0IqwIBfHH
	0rwrtSXgleV9TrBMgkm/YESpNilrmYkz4mnluzrNIfZ/jW3Wj8UwzO57wRV9ZKpRK8hkHwz701YQp
	7uMDE9ggL8Njof15fFrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdEY8-004boE-0U;
	Mon, 04 Sep 2023 18:43:48 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdEY5-004bnn-06
	for linux-um@lists.infradead.org;
	Mon, 04 Sep 2023 18:43:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 44A6BCE0F98;
	Mon,  4 Sep 2023 18:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79D84C433D9;
	Mon,  4 Sep 2023 18:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693853021;
	bh=bI+YB52Xw74DRpIaQIe7SUhFxJoXxGzZRCttgmOOmMA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mdw4hmlFjTh68eHLoRK0v6dczI4TDOthZuMX9/3F/5lDXQgZhdDdrOPm38zNh3WJW
	 LHQpFUVpkDQ8lQtCGbJs4o7Cxc2YjHg0ZbMNbUzj7KXqB8SeX5SnOaWtyoPBYoT9Z3
	 za+X3gSoIN/nwJsF0gaDWen3i5gI+RosPgJLcN4MXe12g3N2j29WqeWlJ2vR2XuK/L
	 WI40nrb5TRJ/nVvq0Hf3a+Oh/RAuwnx5yt8c5IVLrWwHWZQQA6mgffeHln26seBEGN
	 AFqSOK35Jdc3Pf78RFOOlYN4CDwwwq8EqBqsU8lQHUXyk1+F7P0nDaMAzhFQWRkAiJ
	 3SlmriiqMaY4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F109C04DD9;
	Mon,  4 Sep 2023 18:43:41 +0000 (UTC)
Subject: Re: [GIT PULL] UML Changes for v6.6-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <1189803925.12843.1693768434048.JavaMail.zimbra@nod.at>
References: <1189803925.12843.1693768434048.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-um.lists.infradead.org>
X-PR-Tracked-Message-Id: <1189803925.12843.1693768434048.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.6-rc1
X-PR-Tracked-Commit-Id: 974b808d85abbc03c3914af63d60d5816aabf2ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 68d76d4e7e506664ffb7b28805469ed73044368f
Message-Id: <169385302138.15626.673868116805116131.pr-tracker-bot@kernel.org>
Date: Mon, 04 Sep 2023 18:43:41 +0000
To: Richard Weinberger <richard@nod.at>
Cc: torvalds <torvalds@linux-foundation.org>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230904_114345_273215_D62E10AE 
X-CRM114-Status: UNSURE (   4.64  )
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

The pull request you sent on Sun, 3 Sep 2023 21:13:54 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/68d76d4e7e506664ffb7b28805469ed73044368f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
