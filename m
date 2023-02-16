Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE39EC636CC
	for <linux-um@archiver.kernel.org>; Thu, 16 Feb 2023 22:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Edh2mBybwI+AfmnbYu0HO0XD4nM2RUenrEVXKVWbVLI=; b=ownu14QkA7iGtX
	IHWtpiHVz9TaGjUgfeCcq6fTtYtRAISRl92mBgLzCQDOSfUms2S+qmZqGolsCtglEmP+t2ZB5OyQp
	3geFdcA5fp73VtTqRxUR05J4IA59EUc6+raFKVMn2gB4RyWRyUFseTEf4rkfUQvSG0PJnwnNicugW
	pmMcTdgGvd8VDg7M5Vqg5X35qAIVH1RsXhcF7gyrA72gKtCsNZHlygnyeUoSjsn/nixo/zi4yTsz2
	TmUiY6gd2sBant1Q/14N0vrECVJuO+b0f+eou4ptgeGRWwVAT8Fv3gMvWN7Jfd7jRnH1Z5QB44piH
	MjuzFx38FNoSsyQBh7Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSmv9-00C37R-6P; Thu, 16 Feb 2023 22:40:07 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSmv6-00C36n-A7
	for linux-um@lists.infradead.org; Thu, 16 Feb 2023 22:40:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B5EC860CEE;
	Thu, 16 Feb 2023 22:40:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D972CC433EF;
	Thu, 16 Feb 2023 22:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1676587202;
	bh=vXkDaJ8R0sf8JFGHfCsgguIb9Gw1GL9NZtcdUry2sCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JCAzjZxj/yZCb9XDPiroiWs94PTyJOff5Nl/IA8fHXtVuvSrH3HLX+x83Iwj2zAO6
	 7Nra7sLfJBD2nupmtOzqdd9JuqGcpvt7z3WTWF17aTuzFh7EhYUX0foHhc8u+LDhWW
	 zDWxdwFxCvClLNrN1BFM/UVNLClgvw3QwaioK3/s=
Date: Thu, 16 Feb 2023 14:40:01 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Glenn Washburn <development@efficientek.com>, Kieran Bingham
 <kbingham@kernel.org>, linux-um <linux-um@lists.infradead.org>, Richard
 Weinberger <richard@nod.at>, Johannes Berg <johannes@sipsolutions.net>,
 Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Subject: Re: [PATCH v2 0/2] GDB: Support getting current task struct in UML
Message-Id: <20230216144001.e1a9dea15a6c4f93b7b8a442@linux-foundation.org>
In-Reply-To: <8a22d84e-5cf4-bf41-220e-dc5e48fb2fc3@siemens.com>
References: <cover.1676532759.git.development@efficientek.com>
	<8a22d84e-5cf4-bf41-220e-dc5e48fb2fc3@siemens.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230216_144004_441026_7E853580 
X-CRM114-Status: GOOD (  11.82  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Thu, 16 Feb 2023 08:51:52 +0100 Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On 16.02.23 08:37, Glenn Washburn wrote:
> > Added suggestions from Jan.
> > 
> > Glenn
> > 
> > Glenn Washburn (2):
> >   scripts/gdb: Correct indentation in get_current_task
> >   scripts/gdb: Support getting current task struct in UML
> > 
>
> ...
>
> Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>
> 

Thanks, but I'm not subscribed to linux-um and my usual
get-it-from-lkml didn't work.

Could we please have a resend, with a cc to linux-kernel?

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
