Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F0DC433FE
	for <linux-um@archiver.kernel.org>; Wed,  9 Nov 2022 15:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rNEiRogncGY3uclcr36ogqj0z6s3TKqdEf12R1C4Z24=; b=mg2xSvs4kkNdL7
	cWVVmZUG6vcNlCCJMFGDm6/7xgTxb0CBkuuyLSaxE3Kbpfj1hfKiwfD6+DCjYcqDatTeeqPACW1Nu
	ovM0mrXpTAuV90ltqkUklNd232oOHpEJx5diKO73UrZvi3mN2d07TVpxAyhMlpVtjMj8SMeNEP2js
	yixNt3rvPZkQw48q5OFlCC+1VlxgaUBAPYBTxqtgxB79AtVkpeFqeDdni4JyUF3eD9C4VCzypMEEP
	o6z4MPvf4qFxunsdHHYe8E4lzAWH/2gFHbBKnng1nf7QfGGAq4SvVt2QKR9brsrM8aWPEn6B4Rwf7
	HVzhjRlEhQ+6Dq1z2Mrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osmdc-00EN6t-Ut; Wed, 09 Nov 2022 15:05:12 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osmda-00EN59-Ab
	for linux-um@lists.infradead.org; Wed, 09 Nov 2022 15:05:11 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 0E5DA229A1;
	Wed,  9 Nov 2022 15:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1668006305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=krocaAMDDtdy6F5qydB2s4VN3uyIXVFWbhEHxDiWMks=;
	b=S+p3CMwVhelWzXHJYg2fhhYLkN0+Ub4hViBMnv+TSb7CM+SA6Ise9E6i0C5lOBtP9Fjk4J
	uVJuNY8PuD2aVAFGjZEGC5FAIHQBM+rTSRNJH7/3SCQZB4ETRxCLFP0KOfgCUvMu59fGQH
	friXNSBGNWcl22ZS9GLUDB9cXsCZXtU=
Received: from suse.cz (unknown [10.100.201.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id E7B522C141;
	Wed,  9 Nov 2022 15:05:04 +0000 (UTC)
Date: Wed, 9 Nov 2022 16:05:04 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH printk v3 11/40] um: kmsg_dumper: use srcu console list
 iterator
Message-ID: <Y2vBoPZUNGPalQLq@alley>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-12-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221107141638.3790965-12-john.ogness@linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_070510_531549_B7376D54 
X-CRM114-Status: UNSURE (   9.28  )
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

On Mon 2022-11-07 15:22:09, John Ogness wrote:
> Rather than using the console_lock to guarantee safe console list
> traversal, use srcu console list iteration.

It might be obvious. But I would add:

"It allows to dump the messages even when console_lock() is blocked
during panic()."

It will help to understand this is a clear win.

> Signed-off-by: John Ogness <john.ogness@linutronix.de>

After merging with 9th patch for using the racy console_is_enabled(con):

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
