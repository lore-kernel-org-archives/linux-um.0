Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B37C3DA6E
	for <linux-um@archiver.kernel.org>; Wed,  3 Jan 2024 12:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WoF2s0uRV+cqw1VWBTcFGBkH3Zao0oa/Uvqf0zzrfME=; b=DbvlWJNm/LHbFmqkULiuMKQaYC
	e+34N63wWn9jMYCVP4umoqdjTmSSWWgezmao6gJ8tamKKlmbU/VP0tpd3CEIVibeeUWYJPeJWraPr
	z+spbOtk/nsh7jFDR+dASgG2v6dgAYyD2DLD+WhhVSJp1Mx6mJeA76Fg+uXF7iklLliwbrypAkWfM
	MmwkMiFNx2A0a7Ie/KehSdLXt35OQBacNX7D0Q1WOdy83/JQd/iJvfO53cu8JXa6urmmZ1eu0+Xgp
	WQ6SoLnaV7Ljvy48iTZA6VgVwU3hjt8B2w2gvLvM2KIgOyCet37OIU8j1h3ain12AW5nhhr1oBjtj
	UgEXRvvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rL0jB-00ArT5-0W;
	Wed, 03 Jan 2024 12:52:09 +0000
Received: from bee.tesarici.cz ([2a03:3b40:fe:2d4::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rL0j7-00ArSQ-2p
	for linux-um@lists.infradead.org;
	Wed, 03 Jan 2024 12:52:07 +0000
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id E5C041A3C63;
	Wed,  3 Jan 2024 13:51:54 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1704286315; bh=wKn5TMlthQCZ3vs0qTpEXgCIHH7fKp9SdgkEDZ0ZHZc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EvJXkIjHo6OQAa1ocgCSe/azb5fwTjmqztDGKgAZikY6aglX32yMZNKe35ufw5hWL
	 p86sarBKbG+zkVlQoAjwg6iYJLw5G61op2fXj2it/MKk0+LahlcSNtEQ72VzgmabsH
	 KkgkXuNoofUkg2jYlyLGnrSn/67JM221k1eEgIMibxlQ7YeBSq48rR03wgIo8rUmLa
	 yctwIORqq5QZ1rzUTuqWMGwONlOZRFmnMOtp6E0S4On7zl/bHmeBL4Rm7vZkzB99BB
	 npQaaM3Z1nni1vu1W9zCLLRHJd2sB6telxpL/mCn7RumviAndxz1CJ+USsDZqeqrBR
	 EQpITYk0UGv3A==
Date: Wed, 3 Jan 2024 13:51:53 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>
Cc: Petr Tesarik <petrtesarik@huaweicloud.com>, linux-um@lists.infradead.org
 (open list:USER-MODE LINUX (UML)), linux-kernel@vger.kernel.org (open
 list), Roberto Sassu <roberto.sassu@huaweicloud.com>, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH 0/2] um: improve UML page fault handling
Message-ID: <20240103135153.4696cb0f@meshulam.tesarici.cz>
In-Reply-To: <20231215121431.680-1-petrtesarik@huaweicloud.com>
References: <20231215121431.680-1-petrtesarik@huaweicloud.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240103_045206_381672_AD5659D6 
X-CRM114-Status: GOOD (  11.31  )
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

Happy New Year, everyone!

I can fully understand that you all have had other priorities around
the year end; it was no different with me. ;-)

However, may I kindly ask for some feedback on my proposed fixes?

Petr T

On Fri, 15 Dec 2023 13:14:29 +0100
Petr Tesarik <petrtesarik@huaweicloud.com> wrote:

> From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> 
> Improve UML handling of segmentation faults in kernel mode. Although
> such page faults are generally caused by a kernel bug, it is annoying
> if they cause an infinite loop, or panic the kernel. More importantly,
> a robust implementation allows to write KUnit tests for various guard
> pages, preventing potential kernel self-protection regressions.
> 
> Petr Tesarik (2):
>   um: do not panic on kernel mode faults
>   um: oops on accessing an non-present page in the vmalloc area
> 
>  arch/um/kernel/trap.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 


