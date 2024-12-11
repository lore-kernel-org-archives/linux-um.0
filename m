Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D29E7717D
	for <linux-um@archiver.kernel.org>; Wed, 11 Dec 2024 23:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hUEjsdsK5sfW+WU0cV/OJN+y9IF7umfVVUFeM2GVr84=; b=ljppUMoBYVMfl8JdLtwod25lKI
	5Z0+wF/iD6lYCO31dT+Xl+UnmiwoDEJn01x4je43vCdhOV3VlI3ikh6pJMPK+jPAzdOBdWlkN6+wD
	MviTg5HccyImyzfLay9Waq3f42jEJt6553sPGLyRoCONVhTF1LTzGQUKaeBlMLhPAZx5NRZyRyaV8
	pU0JcvfSqE3KONQ7wUH65hprY4IK+GUJQBoUAWvBvdYwNpWynZmXPlKlBzauKmMHE0dIuAr+PTOlv
	imdHaV8/Gi3zHNUbuHaSXXZ3IvOXyGFkXfDh6h1zPkKpG0owtYC16AuxLOx0TQfOFXIHnkFeFOoeG
	IEbW6YMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLWOT-0000000GWWv-1Zv6;
	Wed, 11 Dec 2024 23:45:25 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLVFt-0000000GKUf-27c7;
	Wed, 11 Dec 2024 22:32:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7FB125C67E6;
	Wed, 11 Dec 2024 22:31:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AB6C4CED2;
	Wed, 11 Dec 2024 22:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956348;
	bh=BsLL13WVfc3NzEKIjd52mjnoMrC/Et1GCt0kRWiLCQo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qv6gvZPdDzbdVPybtFSPx8+F0xql/LHjAUoa61PxHbq7BiNILQmSVN3xV/Fk+jm3l
	 eRj2euKpGQwhzha10D0yvWpJ5jdjr8+V1iYsps4/RL/90xpWyAoPlqxLTgT8H2p1Qr
	 znxHE8HzGGVb3bxCyQgvVT/2hoGKZW56OU+GylgAoSP4eq7TpXB3MZRt3VoyD522af
	 qGwcNNMDDsGqYKHkYodSX7oguHOLk4TTwi/8Q8fATZ6k5VUR9Dw7CkfxIhk8aSQAz0
	 q46lv24Cq5nGqzFQZkxa8IXK7+L/Hgf8e5dM0N1jW5ubxUNiav+to559ZbObo4j7v8
	 24oLtA9z8Jf7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFBE380A965;
	Wed, 11 Dec 2024 22:32:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] asm-generic: provide generic page_to_phys and
 phys_to_page implementations
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: <173395636448.1729195.13128530873311699126.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:32:44 +0000
References: <20241023053644.311692-2-hch@lst.de>
In-Reply-To: <20241023053644.311692-2-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-riscv@lists.infradead.org, arnd@arndb.de,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 linux-arch@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_143229_581455_0A385D32 
X-CRM114-Status: UNSURE (   9.64  )
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

Hello:

This series was applied to riscv/linux.git (fixes)
by Arnd Bergmann <arnd@arndb.de>:

On Wed, 23 Oct 2024 07:36:36 +0200 you wrote:
> page_to_phys is duplicated by all architectures, and from some strange
> reason placed in <asm/io.h> where it doesn't fit at all.
> 
> phys_to_page is only provided by a few architectures despite having a lot
> of open coded users.
> 
> Provide generic versions in <asm-generic/memory_model.h> to make these
> helpers more easily usable.
> 
> [...]

Here is the summary with links:
  - [1/2] asm-generic: provide generic page_to_phys and phys_to_page implementations
    https://git.kernel.org/riscv/c/c5c3238d9b8c
  - [2/2] asm-generic: add an optional pfn_valid check to page_to_phys
    https://git.kernel.org/riscv/c/3e25d5a49f99

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



