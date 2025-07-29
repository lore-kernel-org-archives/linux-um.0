Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE152C83F26
	for <linux-um@archiver.kernel.org>; Tue, 29 Jul 2025 01:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yr8KDwnS8yCHzRHikp953ERke/RESR+CuC69C8dL30I=; b=OzkoVUOXG0M1pJFxEiufXL6A8V
	nMI0Yjs2m163MWRlBuuM+p9IWuKjxtWrZmpQ6FTflafGGfjBAKW3wgcOxaFh/XbNMDUBBqTgx/dW9
	rcVscxh/4kdZSKN30pH5LVKhO5KzGbRpBx71geX9WeLMGNg5bWqpwxmMKXzlMrsV5D2Ps8ITRPQoJ
	RojUnPgCYQqyIZuNRj2ItLAtiU3wr8nnjRkalybmOUzsmpOB16dki3rKklIK2KicORIevJ+/yBzV4
	xfpUnGzhuyXAe4w/gaSWOf2y6h3ovkWPqVdKyLLg8JBKdGiVajWdiWy81+ea+euGH33JnNB3DVokH
	3iRd2lnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugYsX-0000000FgIh-1f8C;
	Tue, 29 Jul 2025 01:11:41 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugYsU-0000000FgIJ-2brt;
	Tue, 29 Jul 2025 01:11:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D1D7A601EB;
	Tue, 29 Jul 2025 01:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A19EC4CEEF;
	Tue, 29 Jul 2025 01:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753751496;
	bh=8ZaxoHBTEhVL12axKf/WX+LwUM3Y/BFGh5lAMOgD5zg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VYacduDBsz15Xg+SgB5nuf2LLCwR/ZQLnHAeY89QssQwJkwueQk+gOc3P9X3M8ERc
	 StQHaCIjU+ApLe7jJ1kkQ1SZSrlnoE0XfZBTw8Yh+roL1ES9ZIfl3oMlPK7Nd5vIme
	 keZEIUjTWzO7k+Xn5laz3kmccx4u/wXUQCxvKazPAkCcbgCoN5asGQOK49wsxNUWzg
	 4V8Tr4vXYS3H1wOaKUIe57TRZzvYstxc8p2ZRo6fWA+RbWlSndzB3fEL4aGd9Fgn3b
	 ZBNnQvFR6RJKhSTgEfjDhuJgvmCxPS2qK55MY85inxik6zCKjNO7RH2cHI8IhVIhst
	 yOtThARlrGBsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34A0C383BF5F;
	Tue, 29 Jul 2025 01:11:54 +0000 (UTC)
Subject: Re: [GIT PULL] execve updates for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <202507261437.F2079B3B7@keescook>
References: <202507261437.F2079B3B7@keescook>
X-PR-Tracked-List-Id: <linux-sh.vger.kernel.org>
X-PR-Tracked-Message-Id: <202507261437.F2079B3B7@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.17
X-PR-Tracked-Commit-Id: 7f71195c15dcf5f34c4c7f056603659374e3a525
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d900c4ce638d707f09c7e5c2afa71e035c0bb33d
Message-Id: <175375151288.918485.7118599213274098690.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 01:11:52 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Akihiko Odaki <akihiko.odaki@daynix.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Albert Ou <aou@eecs.berkeley.edu>, Alexander Gordeev <agordeev@linux.ibm.com>, Alexandre Ghiti <alex@ghiti.fr>, Andreas Larsson <andreas@gaisler.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Chris Zankel <chris@zankel.net>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Martin <Dave.Martin@arm.com>, David Hildenbrand <david@redhat.com>, "David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, Dishank Jogi <dishank.jogi@siqol.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, "H. Peter Anvin" <hpa@
 zytor.com>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Johannes Berg <johannes@sipsolutions.net>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Jonas Bonn <jonas@southpole.se>, Kees Cook <kees@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, loongarch@lists.linux.dev, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Oleg Nesterov
  <oleg@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Richard Weinberger <richard@nod.at>, Rich Felker <dalias@libc.org>, Russell King <linux@armlinux.org.uk>, sparclinux@vger.kernel.org, Stafford Horne <shorne@gmail.com>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Sven Schnelle <svens@linux.ibm.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>, x86@kernel.org, Yin Fengwei <fengwei_yin@linux.alibaba.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
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

The pull request you sent on Sat, 26 Jul 2025 14:39:20 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d900c4ce638d707f09c7e5c2afa71e035c0bb33d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

