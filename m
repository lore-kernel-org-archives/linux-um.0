Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADDBC531CA
	for <linux-um@archiver.kernel.org>; Thu, 23 Jul 2026 11:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YGZ8WLIYtOXEV5jsz7vZ9bwtjKxNaB7on2xYq5douJ4=; b=hlkfJld6+sNRgnfFngQ0e8Cbto
	rlkMPwFEFCWXd2/XEJmFTlaSl/uD+bhdzqFDadVFESZd1ua9xm+9xdsE39nS08xE1mJzd62A8F65s
	9iw6X5q6u1N8HEx58pVZvsz5k6WS3XJneGZl9THQDc13Oaz4SB4gHnZ311EiRSrLtU7LItqf83V8+
	Sb/HFfjk9hJ/7GqbwzYUof72dZi1KPBy8m/YpPFYmbBiws/GscOxOGJBL/8St8C5rP25DVaDBVmAb
	zIW94G8vlUktPqvLRkmlRa4IB8cBNPR1PGltGfSATpqncxvYLeHxU6F+dTsSlTw3UFpPzCYD6n1He
	2plMrbhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmrxC-0000000EC6I-0EKg;
	Thu, 23 Jul 2026 11:51:06 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmrxB-0000000EC62-0ktu
	for linux-um@lists.infradead.org;
	Thu, 23 Jul 2026 11:51:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A11BC600AD;
	Thu, 23 Jul 2026 11:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B281F000E9;
	Thu, 23 Jul 2026 11:51:02 +0000 (UTC)
Date: Thu, 23 Jul 2026 12:50:45 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Hajime Tazaki <thehajime@gmail.com>, 
	liam@infradead.org, Ricardo Koller <ricarkol@google.com>
Subject: Re: [PATCH v2 00/10] simplified UML/NOMMU approach
Message-ID: <amH-fdSinCFd6sQ_@lucifer>
References: <20260723093633.140989-12-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723093633.140989-12-johannes@sipsolutions.net>
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

On Thu, Jul 23, 2026 at 11:35:41AM +0200, Johannes Berg wrote:
> Prior RFC/v1 was here:
> https://lore.kernel.org/linux-um/20260720185103.530603-11-johannes@sipsolutions.net/

Thanks for this! I really really want a nommu UML mode for testing purposes so
I'm very happy you're doing this :)

One mildly annoying note though - it'd be good for the cover letter to summarise
what the series is about, what it achieves, how it compares for instance to
Hajime's original approach ([0]).

I guess how cover letters are used varies by subsystem somewhat but I find it
really actively useful to see a summary in the cover letter.

Anyway reading thorugh the RFC which already covers this seems that this
achieves nommu UML with less changes needed which sounds really interesting!

I may pull this series locally and have a play... :)

>
> I cleaned up and added the docs commit now, other changes:
>  - fixed futex implementation after discussions
>  - fixed regression in earlier uname change
>
> johannes
>

Cheers, Lorenzo

[0]:https://lore.kernel.org/all/m2framxerm.wl-thehajime@gmail.com/

