Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612A2C531F7
	for <linux-um@archiver.kernel.org>; Thu, 23 Jul 2026 15:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RdBdgCK7BfzRGUHMI7MzYTNkx4x5KLeBpWlA8S2KvCY=; b=u4+Ju9pW0Rl9xAVbCuPvd1cvLe
	4XWcBvhdrNZMGjDUyuA3V7M472ZDAAEw2oWW9hsg3t/RF76LqwqmPmJKGqhXcPNFuCXt4zaHmGyBn
	WNmlOvpLOH09gZEiD+/5A5k0jDL5btEQW68z1J7ea5mC0Z2LUW3S9BkymKkvka+f/q3zpngxrNmGJ
	7DkiHT/goq90p/TEX63pzD4jnGnSnkuO5ikVMYUAybpYNs+d9bEENHdeGzHId8nWjEzgxnfx6TYVk
	AaRkNQp/GNpXs7uSVmX5CF+u0qduJVhj+OjNdgBd3o0EbjrgBF2gv8apVmDSdvVCvPmMocVZG4hum
	anKHUB1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmv5B-0000000EZ8r-2gZ3;
	Thu, 23 Jul 2026 15:11:33 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmv59-0000000EZ8F-3Dsi
	for linux-um@lists.infradead.org;
	Thu, 23 Jul 2026 15:11:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3259D40E29;
	Thu, 23 Jul 2026 15:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96B01F00A3A;
	Thu, 23 Jul 2026 15:11:29 +0000 (UTC)
Date: Thu, 23 Jul 2026 16:11:15 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Hajime Tazaki <thehajime@gmail.com>, 
	liam@infradead.org, Ricardo Koller <ricarkol@google.com>
Subject: Re: [PATCH v2 00/10] simplified UML/NOMMU approach
Message-ID: <amIuutfG32p10iTV@lucifer>
References: <20260723093633.140989-12-johannes@sipsolutions.net>
 <amH-fdSinCFd6sQ_@lucifer>
 <07b3c945a5aeeb08fb25955fb072308e3744402e.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07b3c945a5aeeb08fb25955fb072308e3744402e.camel@sipsolutions.net>
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

On Thu, Jul 23, 2026 at 02:22:50PM +0200, Johannes Berg wrote:
> On Thu, 2026-07-23 at 12:50 +0100, Lorenzo Stoakes (ARM) wrote:
> > On Thu, Jul 23, 2026 at 11:35:41AM +0200, Johannes Berg wrote:
> > > Prior RFC/v1 was here:
> > > https://lore.kernel.org/linux-um/20260720185103.530603-11-johannes@sipsolutions.net/
> >
> > Thanks for this! I really really want a nommu UML mode for testing purposes so
> > I'm very happy you're doing this :)
>
> :)
>
> > One mildly annoying note though - it'd be good for the cover letter to summarise
> > what the series is about, what it achieves, how it compares for instance to
> > Hajime's original approach ([0]).
> >
> > I guess how cover letters are used varies by subsystem somewhat but I find it
> > really actively useful to see a summary in the cover letter.
> >
> > Anyway reading thorugh the RFC which already covers this seems that this
> > achieves nommu UML with less changes needed which sounds really interesting!
>
> Right, sorry, I got lazy and didn't copy/paste the RFC cover letter but
> only put the link to it instead. Is there something beyond what I wrote
> there that you were looking for?

No, I think the previous version covered it off well, just a nag (hence being
self aware about the mildly annoying nature of it :P)

UML isn't really my area so can't give in-depth review but I really want
this to be a thing so happy to be cc'd on this!

>
>
> > I may pull this series locally and have a play... :)
>
> If you do, let us know how it goes :)

Will do! :)

>
> johannes

Cheers, Lorenzo

