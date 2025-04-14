Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B47C369B2
	for <linux-um@archiver.kernel.org>; Mon, 14 Apr 2025 21:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YCT11I+4z3fYSOlmnYsG/8YrqDzOXTAgBC8m1U8ZDv0=; b=1Y1DduZmjnSgSYDpCAhXAqkIdd
	5EJBNlKLGOWyLfmFoWU3bZVT62leVV7i/rXYbNOFmLMSDn942HV1bmhYY7Kbb2yoftxa5Hc2+6IT6
	N5BFeTY/TH0N1VQdKiNDDYrYQnTxsATdLwEhcvU88pQPqeT97FPZmpcXvDczX1twTmhIY9UF/+IQC
	0vs/lHM6oAed0aZY9G7NoF7y5zYBojF25yjjxoP1zOe8EzZ51TJROECI7pTtC/pk6QoWxdjkIx6yd
	7F4+cL8SVaRoK1Euca/JuNJLIe4L9h5UD1wZuSd89vwUdGg9fdGYWtRm25ref7AOmrqsUSJbl6FA4
	Rj38gn6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4RIE-00000003YkM-32fL;
	Mon, 14 Apr 2025 21:24:38 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4RIC-00000003Yju-0sNW
	for linux-um@lists.infradead.org;
	Mon, 14 Apr 2025 21:24:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5A65F5C4899;
	Mon, 14 Apr 2025 21:22:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F71FC4CEE2;
	Mon, 14 Apr 2025 21:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744665875;
	bh=r51HquxAjj1e3J4hoZ8kYc6DK4uVQyCgiKCWgJu3yuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B3AgtQT1DqOXlNGmXFoDoJbQ6DOgxRNLyOEjvDIE9ujvy4plDoQO0/b5GxMBgteKi
	 IjfE8ZP5/9mQS7VOwwAH2Z2Zw2waobvHpR0Y2q06MKtvhEsUzYE9iMpwNbbraohHB7
	 tyWJs35onHfoJdGoMrQzHb0PlMZvrhv1kzqnBqYmp5OaXmnqt2DeRjxjTlKS/Sz8tQ
	 89ddgTHxjzQ+sgAbpPk70oNLRdWivQfFhw/Atay5WNDe7Fy5bT5Ugq6xk8AkLfKSXd
	 AQ+RfixN1GOinFfSKBQ3D+7GLrrYp4Pw132+7krF0qEXnmUZ9eupL9T+/4cnZ0vSUY
	 BkoqBXkvQU3sA==
Date: Mon, 14 Apr 2025 23:24:29 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	geert@linux-m68k.org, logang@deltatee.com, sbates@raithlin.com,
	dinguyen@kernel.org, miguel.ojeda.sandonis@gmail.com, arnd@arndb.de
Subject: Re: [PATCH v2] rust: helpers: Remove volatile qualifier from io
 helpers
Message-ID: <Z_19DaVwN2TRt_nG@cassiopeiae>
References: <20250412005341.157150-1-fujita.tomonori@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412005341.157150-1-fujita.tomonori@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_142436_302316_76540252 
X-CRM114-Status: GOOD (  10.06  )
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

On Sat, Apr 12, 2025 at 09:53:41AM +0900, FUJITA Tomonori wrote:
> Remove the `volatile` qualifier used with __iomem in helper functions
> in io.c. These helper functions are just wrappers around the
> corresponding accessors so they are unnecessary.
> 
> This fixes the following UML build error with CONFIG_RUST enabled:
> 
> In file included from /home/fujita/git/linux-rust/rust/helpers/helpers.c:19:
> /home/fujita/git/linux-rust/rust/helpers/io.c:12:10: error: passing 'volatile void *' to parameter of type 'void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>    12 |         iounmap(addr);
>       |                 ^~~~
> /home/fujita/git/linux-rust/arch/um/include/asm/io.h:19:42: note: passing argument to parameter 'addr' here
>    19 | static inline void iounmap(void __iomem *addr)
>       |                                          ^
> 1 error generated.
> 
> Fixes: ce30d94e6855 ("rust: add `io::{Io, IoRaw}` base types")
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

@Miguel: This originally landed through driver-core, but I guess subsequent
patches should go through the Rust tree.

