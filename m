Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509B6CAC5B1
	for <linux-um@archiver.kernel.org>; Thu, 25 Sep 2025 17:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s5E6NQtQfTfIKPQQ0U9jD4/CMTy4US3OKTTLePkEQTI=; b=KBRTqQqpibO7z7Zezqla0/M2xG
	0MFOTUJ8Fa4b/aHGtPg1M4RqeZjJn7+dwfx5NA6igSacTQBAZi6wRXpwI35zPchKdj4VY3MDXQX4I
	FaXhDX3/sZkX/GTF3OtJHbexhNmWOnD9/73ZWi9rddPqHxfgBL6yhiY2weOl1SEDGP2JZI+5tDEp7
	PAvckJi7lyQw/zJ+ZMtUmoIMHWju0d9QF2zigfftknrrS7fLp0dNPSX4o3WO02xelBVK45gql5+fz
	wTQYEIMNUE28RZkI3bEz1fD1zZlpLxs8MggOd52hPvEEKAd7RN/OhHWn0UNZMI8HILOL+Rgbw2vQ9
	lJsa7B0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1pcA-0000000BTM2-0Jxj;
	Thu, 25 Sep 2025 17:18:42 +0000
Received: from ms.lwn.net ([2600:3c01:e000:3a1::42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1pc6-0000000BTIl-35va;
	Thu, 25 Sep 2025 17:18:40 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A312E406FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1758820716; bh=s5E6NQtQfTfIKPQQ0U9jD4/CMTy4US3OKTTLePkEQTI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=R0Wn+1obn8KJeQvchJRf2wnbf497DYVq2eKLFn6QktuoOjJ3ybxEAFLi03ACkYszP
	 aV/OjxtFF+hU4Tsh169FcOQDax4qxVQ9VTRQ5PJJSjch78kboyCe+GLpFs9u3faXwK
	 sLzdeUNWhiACyJ/ZAjFBZLz6tdfkBQ6C8B7WndqpWsfVcZvxEwMZH1A4qhyV9lZo3Q
	 b2wTCYQQXw6BYIqMZBrOclNa/e8um3UEGq8N8lfZ1blNtXGR699/rVD18qJIcDrCWL
	 7pPTqB2KjqyLNniqzC3PcY5nELWvyV6nwZIgjgws1HbGWRaL1WoJz8JVj6dHvLD/SZ
	 AqCkRcme8WerA==
Received: from localhost (mi-18-37-83.service.infuturo.it [151.18.37.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A312E406FA;
	Thu, 25 Sep 2025 17:18:35 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Lukas Bulwahn <lbulwahn@redhat.com>, linux-doc@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-um@lists.infradead.org,
 linux-openrisc@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] Documentation/features: Update feature lists for 6.17-rc7
In-Reply-To: <20250925073634.112142-1-lukas.bulwahn@redhat.com>
References: <20250925073634.112142-1-lukas.bulwahn@redhat.com>
Date: Thu, 25 Sep 2025 11:18:31 -0600
Message-ID: <87qzvu30yg.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_101838_784352_CDFB921A 
X-CRM114-Status: GOOD (  17.54  )
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

Lukas Bulwahn <lbulwahn@redhat.com> writes:

> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>
> It seems that ./Documentation/features/scripts/features-refresh.sh was most
> recently used in December 2022, with the latest kernel release v6.1-rc7 at
> that time (see commit 7f2e60ff51ca ("Documentation/features: Update feature
> lists for 6.1") to update the feature lists in this subdirectory. All
> further changes to Documentation/features/ since then have probably been
> done manually, without checking for changes in other architectures and
> features, that missed to update this part of the documentation.
>
> Running ./Documentation/features/scripts/features-refresh.sh now showed
> seven changes of supported features in various architectures (one in arc,
> two in parisc, one in riscv, one in openrisc, and two in um), which were
> not reflected yet in the current documentation.
>
> To confirm the sanity of this script's suggested changes, I checked if the
> commit messages confirm that the features have in fact been added in the
> following commits:
>
>   - commit f122668ddcce ("ARC: Add eBPF JIT support")
>   - commit 4800a6215e33 ("parisc: Wire up eBPF JIT compiler")
>   - commit a869b8c29f86 ("riscv: enable mseal sysmap for RV64")
>   - commit 2f681ba4b352 ("um: move thread info into task")
>   - commit 3f17fed21491 ("um: switch to regset API and depend on XSTATE")
>   - commit 7ce8716e2769 ("openrisc: Add HAVE_REGS_AND_STACK_ACCESS_API support")
>   - commit b5ff52be8913 ("parisc: Convert to generic clockevents")
>
> So, update all documents to the current state with features-refresh.sh.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>  Documentation/features/core/eBPF-JIT/arch-support.txt         | 4 ++--
>  .../features/core/mseal_sys_mappings/arch-support.txt         | 2 +-
>  .../features/core/thread-info-in-task/arch-support.txt        | 2 +-
>  Documentation/features/core/tracehook/arch-support.txt        | 2 +-
>  Documentation/features/perf/kprobes-event/arch-support.txt    | 2 +-
>  Documentation/features/time/clockevents/arch-support.txt      | 2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)

OK, I went ahead and applied this one, thanks.

jon

