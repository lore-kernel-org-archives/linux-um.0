Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29504C7EE2D
	for <linux-um@archiver.kernel.org>; Sun, 26 Feb 2023 19:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9hGyste6afWl+AK4twqu22gn/sUG1Khiz0s4eh6opJY=; b=zII3pu1gn0pK6Z
	aW6E8eXedKiRW5bnKcB5UMUS/uFCRGjdDMdRFzFE3RxhebRGOwH8BCnOANDhI4Zm9mfKSLQqhV09e
	80ekW2nf7uNlE69qPquTHASVQYP/BbF4ZXl4N5o8QWTN5x3LNhsCceqwGlLIeAaB2L7Z+JBCOtlmi
	/2o/Kfjf+PHaUgn5hFQEnfXj1eZJStuS1C3UoQYOZzuorfCjWpqkilSc9FU3senAXIQDEugvM+Zde
	Te6va4B09KS5qGQFPk0cowJ47twW8zS90wnaEkBnHTHK/vP0CJNW6/DpboHejpUXp2rJW1rTA+Sex
	uaFCqJzz1JBVwQdING5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWMnr-007n7J-R3; Sun, 26 Feb 2023 19:35:23 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWMno-007n6L-JM
	for linux-um@lists.infradead.org; Sun, 26 Feb 2023 19:35:21 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2884460C16;
	Sun, 26 Feb 2023 19:35:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37519C433EF;
	Sun, 26 Feb 2023 19:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1677440116;
	bh=KanthtavbaTElqnrhLtx2la6P52pYyOcpsYV7O0BfT0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YmvmAV8s9B1S7J1cy5wRwKamJ6c/g92oCcQWkdWEVwMWLxdi5IcnBaIUs3h2ExkGB
	 3FqIZhVMgsDGS6wgJapoPX3wyvSiwrvc9AZMha1bvj0CrtrCW2GbEXRbh/0Q693LPR
	 sQvJ7B23pnaG4zPhBNlYsNEVgJNs072zLvDG8H/g=
Date: Sun, 26 Feb 2023 11:35:15 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: development@efficientek.com
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham
 <kbingham@kernel.org>, linux-kernel@vger.kernel.org, linux-um
 <linux-um@lists.infradead.org>, Richard Weinberger <richard@nod.at>,
 Johannes Berg <johannes@sipsolutions.net>, Anton Ivanov
 <anton.ivanov@kot-begemot.co.uk>
Subject: Re: [PATCH v2 0/2] GDB: Support getting current task struct in UML
Message-Id: <20230226113515.841f43730e4842f6c20b5999@linux-foundation.org>
In-Reply-To: <20230226004503.1856e58d@crass-HP-ZBook-15-G2>
References: <cover.1676532759.git.development@efficientek.com>
	<20230223131402.6d6a662f76348b14574121d3@linux-foundation.org>
	<20230226004503.1856e58d@crass-HP-ZBook-15-G2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230226_113520_748741_33E5DD9E 
X-CRM114-Status: UNSURE (   8.39  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Sun, 26 Feb 2023 00:47:19 -0600 Glenn Washburn <development@efficientek.com> wrote:

> Would you like me to resent the series rebased onto v6.2?

Yes please ;)  Against current linus tip if possible.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
