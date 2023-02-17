Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92729C05027
	for <linux-um@archiver.kernel.org>; Fri, 17 Feb 2023 22:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ReaxTBs4wZ2EmIfOxWHPysA5ysalsKotM/ZkJU6zeZI=; b=bOf8d2dSR7QEOl
	haerArF27b5HZGtSW5CZAxONUNXXXdytWJAurtUrYplAy2a3/qhM7rU9UmkC+LVkBDvcKfaO+rR0q
	ynyTVVG9Pv4M6v2FpJ9wOxndOx4/OUsl9SkCWgadBU3hOX875SXaXWvnUzYn4pa1llGW//kqVChal
	7Z9xmyA30YBrf70H/jFELzErZmULUa47xTZ3imf8QLO9BZ+OFOCKBKjtqZiujj1lzjBDYI28uPXVA
	oQBN3L2KvgHhc2GkipndBkghH6Oc/JYVC3YDe8zaNMEueVriHC/cdbuspfbhyT1Jq9YHQ+7I41pW+
	HfyHwmZ/LaB94tX1lqGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pT96a-00FquN-TY; Fri, 17 Feb 2023 22:21:24 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pT96X-00Fqte-Aa
	for linux-um@lists.infradead.org; Fri, 17 Feb 2023 22:21:23 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7BE1561F16;
	Fri, 17 Feb 2023 22:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945E9C433EF;
	Fri, 17 Feb 2023 22:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1676672476;
	bh=740PJSVXbZdU7AhYwW6oAmUTh/+OojLTNZdhKgH29As=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ai+cv9NCxBk8akou8V7QVIMBjrdgaiF0yj0jFLovhEdSklK+AoI4W5S3He2ZsMi/D
	 z8n5DNINXpTBetuQZh67gTrrv3MpGbv92ylT7RdE1R/yUAdWJFmxp5NpdC0nzgaZHa
	 XvJr6SlVem8mhN1eVwPtKzTifuC7OViLhpC0C/pY=
Date: Fri, 17 Feb 2023 14:21:15 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: development@efficientek.com
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Richard Weinberger
 <richard@nod.at>, Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham
 <kbingham@kernel.org>, linux-um <linux-um@lists.infradead.org>, Johannes
 Berg <johannes@sipsolutions.net>, Anton Ivanov
 <anton.ivanov@kot-begemot.co.uk>
Subject: Re: [PATCH v2 0/2] GDB: Support getting current task struct in UML
Message-Id: <20230217142115.b2c844f11aef962c21c53806@linux-foundation.org>
In-Reply-To: <20230217155643.1c1b0b76@crass-HP-ZBook-15-G2>
References: <cover.1676532759.git.development@efficientek.com>
	<8a22d84e-5cf4-bf41-220e-dc5e48fb2fc3@siemens.com>
	<20230216144001.e1a9dea15a6c4f93b7b8a442@linux-foundation.org>
	<283287920.144364.1676588078240.JavaMail.zimbra@nod.at>
	<20230216153309.8b551086ed3a5015a7135957@linux-foundation.org>
	<CAMuHMdWdQH=o9XNAj4YpTA8G7JMKPe+CJSCG2bRf_6H-u50PZg@mail.gmail.com>
	<20230217155643.1c1b0b76@crass-HP-ZBook-15-G2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230217_142121_599536_C6058EDD 
X-CRM114-Status: GOOD (  22.65  )
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

On Fri, 17 Feb 2023 15:56:43 -0600 Glenn Washburn <development@efficientek.=
com> wrote:

> On Fri, 17 Feb 2023 11:14:01 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> =

> > Hi Andrew,
> > =

> > On Fri, Feb 17, 2023 at 12:33 AM Andrew Morton
> > <akpm@linux-foundation.org> wrote:
> > > On Thu, 16 Feb 2023 23:54:38 +0100 (CET) Richard Weinberger
> > > <richard@nod.at> wrote:
> > > > ----- Urspr=FCngliche Mail -----
> > > > > Von: "Andrew Morton" <akpm@linux-foundation.org>
> > > > > Thanks, but I'm not subscribed to linux-um and my usual
> > > > > get-it-from-lkml didn't work.
> > > > >
> > > > > Could we please have a resend, with a cc to linux-kernel?
> > > >
> > > > You can also get the patches in mbox format from:
> > > > https://patchwork.ozlabs.org/project/linux-um/list/?series=3D342212
> > =

> > And from there, you can get the Message-IDs, and use lore:
> > https://lore.kernel.org/r/683d10e752cd4852ac62ef3cc3e9a6972a017bdf.1676=
532759.git.development@efficientek.com
> > or b4:
> > b4 mbox
> > 683d10e752cd4852ac62ef3cc3e9a6972a017bdf.1676532759.git.development@eff=
icientek.com
> > b4 am
> > 683d10e752cd4852ac62ef3cc3e9a6972a017bdf.1676532759.git.development@eff=
icientek.com
> > =

> > > Thanks, but..
> > >
> > > - Can't do reply-to-all if I have comments
> > > - Can't collect people's followup acks and review comments
> > > - No Link tag
> =

> Ok, so do I need to resend after all?

Yes please.  Call it v2, add any acks and reviewed-bys.

> And anther point in need of
> clarification, regardless of subsystem or area of source, when sending
> patches, should I always cc to linux-kernel?

I think it's best.  That's pretty much the only purpose lkml serves now :(


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
