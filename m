Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407DDC433FE
	for <linux-um@archiver.kernel.org>; Tue,  8 Nov 2022 12:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2xoZbWwe9K6993xvyinX/6KkFtplHhokKaowghk5I6Y=; b=ivCyJd7WpjtDJ0
	n+tSh6P+7OTrb2pMKR5A1QrtmL25BykEwmJQpZrQQnOJt937/6g3i4ifcvBvYJ9O0HMdWeQX2t1LP
	J09Gwl1WmIt4yzrWIjX6GFr65dPsurdowVdD+YiCFVmbKUMh5IUQDPKN9/4+cvSyF5InJ1OtjcsIr
	qF1/vg8r0kjO9pLft1Sc67A8jxLdeyNZ3DrWKMIXyh5gjQh+2gAEn2JVm+v/0/6etwaUI68q610l6
	sZLRGB8BR3mEG/MuSF3Bvr8ZsYoptl2H/+IcXI2pYFQlFWGtMo9SjMGfwVhL5D2U5xdmnMIacwY9m
	LkXNjK5R+WT8bNlU1Fhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osNuj-005IiI-45; Tue, 08 Nov 2022 12:41:13 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osNuf-005Idn-H8
	for linux-um@lists.infradead.org; Tue, 08 Nov 2022 12:41:11 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id B6128224A0;
	Tue,  8 Nov 2022 12:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1667911265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c3dZM4uCLlwzncmOgKppFTjizqzC3KOzooj1gFTH490=;
	b=OHWhrJS4mb795unDDeporWwSHoWUPrjMOCIy07QYr/0hrnUV/nHxV/IYLNsd32ea+izcGH
	HxwR3L2w97NZlULzWu73QcSmSX4oJZyTj/2cqiEMQv3/E+E8SQfoXpwACBXb/K19kauNLf
	XkoijjZ27KhF4I4ed+q7TSRmDIfDNe8=
Received: from suse.cz (unknown [10.100.208.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 508A72C142;
	Tue,  8 Nov 2022 12:41:05 +0000 (UTC)
Date: Tue, 8 Nov 2022 13:41:04 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH printk v3 06/40] um: kmsg_dump: only dump when no output
 console available
Message-ID: <Y2pOYBkNPY3wd6vn@alley>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-7-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221107141638.3790965-7-john.ogness@linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_044109_754644_1EA45F80 
X-CRM114-Status: GOOD (  14.90  )
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

On Mon 2022-11-07 15:22:04, John Ogness wrote:
> The initial intention of the UML kmsg_dumper is to dump the kernel
> buffers to stdout if there is no console available to perform the
> regular crash output.
> 
> However, if ttynull was registered as a console, no crash output was
> seen. Commit e23fe90dec28 ("um: kmsg_dumper: always dump when not tty
> console") tried to fix this by performing the kmsg_dump unless the
> stdio console was behind /dev/console or enabled. But this allowed
> kmsg dumping to occur even if other non-stdio consoles will output
> the crash output. Also, a console being the driver behind
> /dev/console has nothing to do with a crash scenario.
> 
> Restore the initial intention by dumping the kernel buffers to stdout
> only if a non-ttynull console is registered and enabled. Also add
> detailed comments so that it is clear why these rules are applied.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

The change makes sense to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
