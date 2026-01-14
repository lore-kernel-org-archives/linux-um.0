Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A895D38FE9
	for <linux-um@archiver.kernel.org>; Wed, 14 Jan 2026 16:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3O46Pj7m8kkRm5o6FCiKeQjNffkaPKNOyTPfHDTuyTM=; b=jzTxdkpVK8bOAF2YoO7T/yHGe+
	crFbYH3H99m0c9jGnSrI4FtF7FyoQHBX3pzOA0g4CMUgsobLH7XPfHrQaFLnJS0nyXPImn8nhZuI0
	8GjmFpNRZoX/QYNKqV/9VnpcptnHIYfZgcz5cYHxJOCCa/qeht6Cy1GEl5qAEeD0drNHOg0/Yt/Gm
	Hbx6FxT8nRhIggW+WF7GvC58LBCG0Pml3eWdjL0dLyCNJbYR8q03mN9n8tFF0zpv1+4QCMqZHF6Sp
	RvylUfbkk1k11w24fFEcps1rLihoUjHISq+J7easHx66453Rrs60dyTy00R/5/t4Q8NqgB53OsvPu
	32hzunVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg3tW-00000009xEj-0BoQ;
	Wed, 14 Jan 2026 16:38:54 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg3tT-00000009xDV-1pde;
	Wed, 14 Jan 2026 16:38:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9A323408E4;
	Wed, 14 Jan 2026 16:38:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80489C4CEF7;
	Wed, 14 Jan 2026 16:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768408730;
	bh=3O46Pj7m8kkRm5o6FCiKeQjNffkaPKNOyTPfHDTuyTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rX3NXa+ZIaH3nFwhK4UUCK7Tl+BkdrM7lAWylErEBVX8n4+UiQ4G9G3ZhsgmdM3kk
	 vN8PXFoQ+O9dscO4bKZ3M3QWmyyXJXre63JLVYqnzZ2NTakKl+OU0g0oj8iEefzjr3
	 mgengyjgYNSq8vnqi/nIcJdbHx722ODGLyY8W8WF4jD1J44QYJo3q7W39OBPor2Wnp
	 mtMB1YriAKD7oAMO5DENXpRw1aefTtMKh3nXtSKTmIbbZIhuLzX4/xt9jCGtUk6R4U
	 0bsnyWbYeo3xcvSjczR5clmShq482fExnV7dzxGfD2Q4FGvs3AgYwtJ9KizIe5aoQq
	 liWKl6bOegsTQ==
Date: Wed, 14 Jan 2026 16:38:39 +0000
From: Daniel Thompson <danielt@kernel.org>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Daniel Thompson <daniel@riscstar.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Douglas Anderson <dianders@chromium.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andreas Larsson <andreas@gaisler.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
	netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/19] printk cleanup - part 3
Message-ID: <aWfGj1eQhj2fAWB-@aspen.lan>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <aVuz_hpbrk8oSCVC@aspen.lan>
 <aVvF2hivCm0vIlfE@aspen.lan>
 <a5d83903fe2d2c2eb21de1527007913ff00847c5.camel@suse.com>
 <89409a0f48e6998ff6dd2245691b9954f0e1e435.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89409a0f48e6998ff6dd2245691b9954f0e1e435.camel@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260114_083851_515283_422FFDEA 
X-CRM114-Status: GOOD (  15.24  )
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

On Tue, Jan 13, 2026 at 09:32:33PM -0300, Marcos Paulo de Souza wrote:
> I talked with Petr Mladek and it would need to rework the way that we
> register a console, and he's already working on it. For now I believe
> that we could take a look in all the patches besides the last one that
> currently breaks the earlycon with kgdb and maybe other usecases.
>
> Sorry for not catching this issue before. I'll use kgdb next time to
> make sure that it keeps working :)

As I understood things the bug was in earlycon rather then kgdb.

It was picked up by the kgdbtest suite since kgdb does some cool things
with earlycon (thanks to Doug Anderson) so I added a few earlycon tests
to the kgdbtest suite. However it wasn't kgdb itself that failed here.

So... if you want to run https://gitlab.com/daniel-thompson/kgdbtest
then certainly feel free but its probably less effort just to include
a couple of earlycon checks in your testing.


Daniel.

