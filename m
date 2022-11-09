Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93901C433FE
	for <linux-um@archiver.kernel.org>; Wed,  9 Nov 2022 14:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=03Bc01kes1kaLk8VueBRjIjLs4aLTc0n8WsbYVcbi74=; b=s6tLGsEgeklUWp
	SiGjHmcTolKe2DB+9bKMahtUuNVCxR1Rce1sjk2ZewU+zrubXnuMnCFZRDUP7VJKBM/OPY4FmTMXd
	Dz7nvxeY4NVsnU/8m3SOIjBKVQPLdDAL6ghCYT2emYPy9ojO19GTjJvTnsm14gh6VFySYI7aCjlT4
	PSyp0uM0aR6mqUYmO4+V+qCc1+SixPfSIhvMnAaFA5F29L5GhagdhIwsOcrhIW7FHNXEUKWZZbZ5v
	KTMRrOWTuuPPIlpBgFE9USp9pAlZHbi4YkY7w1u4gCAgWxFcPt3RDq0IlTfgLWrXw0v7NJ5/oUuCi
	P8CBxpP6XbZr/KrFkygA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osmRt-00EGq4-EQ; Wed, 09 Nov 2022 14:53:05 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osmRq-00EGmM-Rj
	for linux-um@lists.infradead.org; Wed, 09 Nov 2022 14:53:04 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id E2D661FAD7;
	Wed,  9 Nov 2022 14:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1668005577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FutJ1VPLZFBajZZiyGg8sMOsTn5Qp9A62puyDLQBuTc=;
	b=NPAbe1ETJXR+P7Z6KLWW1x2nSkzeh+d5c1yrGY8P8IPy7nyDazFJyGYAlmQvALrdlTMgNP
	5fHy00+za04xiUEgRAqWbTfZ7mMl+HYDMsLz2jK/lk1lmmX/QDX+YJC9KxcIokGAxevfpa
	fjFac5a3Qqdwecyx4Hmm43B+1eIKCHY=
Received: from suse.cz (unknown [10.100.201.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 7051E2C141;
	Wed,  9 Nov 2022 14:52:57 +0000 (UTC)
Date: Wed, 9 Nov 2022 15:52:57 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH printk v3 09/40] um: kmsg_dump: use console_is_enabled()
Message-ID: <Y2u+yQca3Y5DzPUc@alley>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-10-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221107141638.3790965-10-john.ogness@linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_065303_060572_F4831E76 
X-CRM114-Status: GOOD (  18.58  )
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

On Mon 2022-11-07 15:22:07, John Ogness wrote:
> Replace (console->flags & CON_ENABLED) usage with console_is_enabled().
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  arch/um/kernel/kmsg_dump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
> index 40abf1e9ccb1..f0233e2f8de0 100644
> --- a/arch/um/kernel/kmsg_dump.c
> +++ b/arch/um/kernel/kmsg_dump.c
> @@ -32,7 +32,7 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
>  		 * expected to output the crash information.
>  		 */
>  		if (strcmp(con->name, "ttynull") != 0 &&
> -		    (con->flags & CON_ENABLED)) {
> +		    console_is_enabled(con)) {

The patch does not explain why the racy check is needed here.

I would prefer to merge this patch with the patch switching to the srcu
console list iterator. It will become more or less self-explaining.

Anyway, I agree that the racy check is acceptable here.

Best Regards,
Petr

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
