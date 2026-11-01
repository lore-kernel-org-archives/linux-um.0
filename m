Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55190607412A
	for <linux-um@archiver.kernel.org>; Sun,  1 Nov 2026 22:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Or+aSERm;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RI6vqfud
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=7jMaG7E0faIciRuA0j8698KDnNXPdfgqG5SZCjrpwFM=; b=Or+aSERmH4SWHp
	w8zsMzMdbGQ52GKnJ3qEFNDy6vcj+xhVbPS7P7+enECzDsw/W3D+B5Y1DnyoTnwjgvcjtfRvo3a6L
	XTr6VnzwF9LXZYpPa7nPYbnJcoOYQwMzPGuRSJPGEs/SO5k42rmOChd5YISADafoe2ZIW4cKeP6NL
	dlwZolaij5pZwhIY0QBINz9sBkdUl8R91RLyhHOT0Fkmpr+E2y8I3VgNUHHOTvOaArFTVXqJl7/Xx
	5tKUAuql+MBn07qts/ghHC6TvCv80n7UOmm2/5b/Vc91ItvNdC3nlzOr8zuDs7Fv/4EBSsa/Q5Vmz
	zWb9/2gPaWz6i0d4hqfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNdrL-0000000F24A-1wpD;
	Sun, 01 Nov 2026 22:17:03 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNdqq-0000000F0YQ-3GQb;
	Sun, 01 Nov 2026 22:16:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7FC2441815;
	Sun,  1 Nov 2026 22:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4D81F000C1;
	Sun,  1 Nov 2026 22:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793571392;
	bh=7jMaG7E0faIciRuA0j8698KDnNXPdfgqG5SZCjrpwFM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RI6vqfudUDAPQJyogDLl2CpARmQSYi02Z/r+Di8qbeK3KcSdM0cWSldHGeHFd7Wmg
	 oZkcWTzbyfmhEOg5tcfCHfhpf6iaGm+isSH86qaujprBW88A0OM503IaD8+WPv9717
	 bpcrsoSfdrv6EFgcaHxAfgeqBVd+9Lh2jlei+lTKhKmrMmF1DDRxKwuNJ2YAzniH64
	 bTK3lBMxJ6uc9UCiWTe96qjtjhpAxsSnnRxROmumhMt3+M7z/8Bl4vxi21IO/fXVoH
	 wUHNq2epY1lAcTmYzulW8paMq9f4RX7rYBp2SAoAq4o7yj3fGB1UzuSY/Wrq1aK7S0
	 zpB9EvUeVfZow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5347838003B8;
	Sun,  1 Nov 2026 22:16:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/8] mm: Drop pxd_ERROR()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: <179357139104.2624073.10186400247460209292.git-patchwork-notify@kernel.org>
Date: Sun, 01 Nov 2026 22:16:31 +0000
References: <20260831054331.625505-1-anshuman.khandual@arm.com>
In-Reply-To: <20260831054331.625505-1-anshuman.khandual@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-riscv@lists.infradead.org, linux-mm@kvack.org,
 samuel.holland@sifive.com, david@kernel.org, rppt@kernel.org,
 akpm@linux-foundation.org, ljs@kernel.org, ysato@users.sourceforge.jp,
 dalias@libc.org, glaubitz@physik.fu-berlin.de,
 James.Bottomley@HansenPartnership.com, deller@gmx.de, chenhuacai@kernel.org,
 kernel@xen0n.name, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

This series was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Mon, 31 Aug 2026 11:13:22 +0530 you wrote:
> pxd_ERROR() macros have been provided by all platforms, which are very much
> identical and can be dropped off completely if these pgtable printing could
> be moved to callers in generic MM aka all pxd_clear_bad().
> 
> But first cleanups and re-organizations are required in some platforms that
> are using these macros internally. Afterwards [pte|pmd|pud|p4d|pgd]_ERROR()
> macros have been completely dropped from the entire tree.
> 
> [...]

Here is the summary with links:
  - [1/8] mm: Make ptval_to_str() generally available
    (no matching commit)
  - [2/8] mm: Stop using pxd_ERROR()
    https://git.kernel.org/riscv/c/0666fc9d4432
  - [3/8] loongarch/mm: Stop using pte_ERROR()
    https://git.kernel.org/riscv/c/ea8763ac3af7
  - [4/8] parisc/mm: Directly use generic [pmd|pgd]_clear_bad()
    https://git.kernel.org/riscv/c/94d6c5466d1a
  - [5/8] sh/mm: Stop using pte_ERROR()
    https://git.kernel.org/riscv/c/6858e42cc2bc
  - [6/8] sh/mm: Stop using [p4d|pud|pmd]_ERROR()
    https://git.kernel.org/riscv/c/3b225ce37f62
  - [7/8] sh/mm: Stop using pgd_ERROR()
    https://git.kernel.org/riscv/c/66a0441a1791
  - [8/8] mm: Drop pxd_ERROR()
    https://git.kernel.org/riscv/c/c970236c300f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



