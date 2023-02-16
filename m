Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3556EC636CC
	for <linux-um@archiver.kernel.org>; Thu, 16 Feb 2023 23:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9cSz4puBlnwZ3nRMMwafe9GTNHJP6Zweq02i1hR6TpY=; b=NpOgh1H3RREGPI
	lmWFyPAa5RK87gUOdHNicFVXIy6gT7ETMkE3qpW3UIB5Qvw0EAjuq6AO24mfMwgc+TBa/Gaw6PO6K
	B75wDfYOjHrThytXxG94+zlsg/VuWtSZvKlVf4Ab8LV/w46vL6Owy/u+jFPVL4QLN5LmTbxkqibuA
	SMP/I7YE1ZA694sYqVmrSmdcwJldKVWruEyM02bj4p46ucJd5OL+TyHv2EX5uUOnhtNyU+NMiOFhY
	rnVZEpus69eB/2cKq5SL9xZbMyw6MWlwmNI+OAYLLUDGqtyn1J1GzbLgat9coT0x0gurEQjhYzlDh
	OLmXZNX/43V1WpIUei2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSnkc-00C7sQ-2q; Thu, 16 Feb 2023 23:33:18 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSnkY-00C7rn-2C
	for linux-um@lists.infradead.org; Thu, 16 Feb 2023 23:33:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id BE04FB828D4;
	Thu, 16 Feb 2023 23:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E162C433EF;
	Thu, 16 Feb 2023 23:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1676590390;
	bh=m9EWJ7nCwV6rxEWoZ4d9RfO2wwbiPQ2yWmV04Sp8C/0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nrboMbw2rxDr83Ir9k+1en2NwcOgzK+o9GE4dwyEDnOuI1gNbADFloFfNC8y2GFqy
	 vRS+nlCbp9Btd+dnI71t4147sIvQcnq2LMr6uBh6zsTZGi9o862JthzArxy1Ub9eA+
	 JNt+IJJhpUNPQSF4cjcfGRfs/KnfLLnAVJXhpKf4=
Date: Thu, 16 Feb 2023 15:33:09 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Richard Weinberger <richard@nod.at>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Glenn Washburn
 <development@efficientek.com>, Kieran Bingham <kbingham@kernel.org>,
 linux-um <linux-um@lists.infradead.org>, Johannes Berg
 <johannes@sipsolutions.net>, Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Subject: Re: [PATCH v2 0/2] GDB: Support getting current task struct in UML
Message-Id: <20230216153309.8b551086ed3a5015a7135957@linux-foundation.org>
In-Reply-To: <283287920.144364.1676588078240.JavaMail.zimbra@nod.at>
References: <cover.1676532759.git.development@efficientek.com>
	<8a22d84e-5cf4-bf41-220e-dc5e48fb2fc3@siemens.com>
	<20230216144001.e1a9dea15a6c4f93b7b8a442@linux-foundation.org>
	<283287920.144364.1676588078240.JavaMail.zimbra@nod.at>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230216_153314_296515_05BD3056 
X-CRM114-Status: GOOD (  12.97  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Thu, 16 Feb 2023 23:54:38 +0100 (CET) Richard Weinberger <richard@nod.at=
> wrote:

> ----- Urspr=FCngliche Mail -----
> > Von: "Andrew Morton" <akpm@linux-foundation.org>
> > Thanks, but I'm not subscribed to linux-um and my usual
> > get-it-from-lkml didn't work.
> > =

> > Could we please have a resend, with a cc to linux-kernel?
> =

> You can also get the patches in mbox format from:
> https://patchwork.ozlabs.org/project/linux-um/list/?series=3D342212

Thanks, but..

- Can't do reply-to-all if I have comments
- Can't collect people's followup acks and review comments
- No Link tag

etc.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
