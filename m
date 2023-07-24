Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6925C0015E
	for <linux-um@archiver.kernel.org>; Mon, 24 Jul 2023 16:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MEJ0TgAZKi2PBDH1/tb3ShYovDrQ/FVW428aEdug9eM=; b=4YXtVrTc/g3WQe
	ffJzihyWnLb3QUDT0VoAn4oX8c7xAAL1i4T7AcRl/h5g19n8Z6IFJli2rkkbzfNujPwB/vE+UKcwW
	1mhzyTGgtL7/dI95RIOGaRDxC5P+k2FUFRWQrV49FYVEe+T/8BbvfRO84tx/rnVnMFIRwowOlJTfQ
	qL0baAGtaJKP11RjwDc4wbHFY/tAgmoZgzH6tYOjcTVTNveqCWtwYi5AMkevh8FVbCU+UnNVVbD/J
	QEIFJc4b+vKwWjRvHOXcoGBssgU/4OO5ItCDD99D9qBTSnttuXisFmdLPSmtq+JxY1npN2RURmLuJ
	p54ENGUD86/nAPGCJc4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNyOj-004sK4-0G;
	Mon, 24 Jul 2023 16:27:01 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNyOg-004sJR-25
	for linux-um@lists.infradead.org;
	Mon, 24 Jul 2023 16:26:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 05AFB61268;
	Mon, 24 Jul 2023 16:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CB9C433C8;
	Mon, 24 Jul 2023 16:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1690216017;
	bh=d7DmTXzRTVmIFN5K5gqsKRTU+7eTWOeYBkhb0UMLBaA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hJgTUzB0NTTJxbx/yfsAh3TTjuxFQT0a3L5h4+wJ9LSWSpxHAvWeW7eDpy/gtl9XM
	 sdlT5JUlyJb7+oQb/GRnUhDIYY9dS4KBgP8q/DFQkDgu8HD8PPDj9wxLdOzKHdv4/Q
	 r87cMTmQ5izWiINGEcmfvh+PwNS2gJ+m40JPrKw4=
Date: Mon, 24 Jul 2023 09:26:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Richard
 Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Herve Codina <herve.codina@bootlin.com>, "Jason A. Donenfeld"
 <Jason@zx2c4.com>, Yang Guang <yang.guang5@zte.com.cn>, kernel test robot
 <lkp@intel.com>
Subject: Re: [PATCH v2 1/1] Revert "um: Use swap() to make code cleaner"
Message-Id: <20230724092655.1982074ea5c6cf484c79317a@linux-foundation.org>
In-Reply-To: <20230724143131.30090-1-andriy.shevchenko@linux.intel.com>
References: <20230724143131.30090-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_092658_755011_0AB31313 
X-CRM114-Status: GOOD (  11.02  )
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

On Mon, 24 Jul 2023 17:31:31 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> This reverts commit 9b0da3f22307af693be80f5d3a89dc4c7f360a85.
> 
> The sigio.c is clearly user space code which is handled by
> arch/um/scripts/Makefile.rules (see USER_OBJS rule).
> 
> The above mentioned commit simply broke this agreement,
> we may not use Linux kernel internal headers in them without
> thorough thinking.
> 
> Hence, revert the wrong commit.

As it fixes a build error I'll add cc:stable to this.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
