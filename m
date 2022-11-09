Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AC8C4332F
	for <linux-um@archiver.kernel.org>; Wed,  9 Nov 2022 14:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ggEYjVbn6qjPcu/OL7ltl+Vt9eVRCvcFZdFIGF11hcw=; b=CIQCH+wRfz9Z37
	B0NfTe1g+bYUSh56L1oTF8XPsNNcH5ZWH1Hp1F+8qywsqOo/RJrsEVhZfaCaOsQ7iBTyzwnRLYsWb
	71X1epCSZeZ44iekITjpea9xQg5J3fU3BaZwx9Kyrcl9y+z4eI42TKpvk83wuHDkmCcl4/4Wn/KHH
	sA6dAVpy/LhigBf+QygTDFakUMHUfms+upKTq+SSb6aWq6Uvfpjf450XKNoDs65QIAHTUYVtrORn+
	l94Q/6H6rYYTEoaOHQLvYEJ5xCWIOPhy5GnB3fX5UGAW3ECUfP8kwS6337sWqlxGJJVqLbAw41nse
	/O/BN9n21kZ1XophS8ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osmWD-00EJMZ-JI; Wed, 09 Nov 2022 14:57:33 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osmWB-00EJJs-45
	for linux-um@lists.infradead.org; Wed, 09 Nov 2022 14:57:32 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id C2C0E1FAE5;
	Wed,  9 Nov 2022 14:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1668005849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wEwcwLQjvB03L0PsEWQ50R/B4fE+de9uaYeUoWQhFII=;
	b=ZRJNv9tNtvncUyEsEgPEbvLUGvr+NA93hObyBVa5th+rPnY6NF4AHxK/923wEbQtVKKZDh
	CvigJnfOKdtZwc3X34hhxojjp7bWyAaV4xqhp0yb7vnmryBuZWooC4PXflI++OGo8Cr4YT
	rs10UhYcEjpBcDWK2+yPgQnX0xvwq5Q=
Received: from suse.cz (unknown [10.100.201.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id A71742C141;
	Wed,  9 Nov 2022 14:57:29 +0000 (UTC)
Date: Wed, 9 Nov 2022 15:57:29 +0100
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
Message-ID: <Y2u/2TGbaFlQrGIx@alley>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-10-john.ogness@linutronix.de>
 <Y2u/i9EgSe5BYIA5@alley>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y2u/i9EgSe5BYIA5@alley>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_065731_339651_58D26165 
X-CRM114-Status: GOOD (  18.33  )
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

On Wed 2022-11-09 15:56:11, Petr Mladek wrote:
> On Mon 2022-11-07 15:22:07, John Ogness wrote:
> > Replace (console->flags & CON_ENABLED) usage with console_is_enabled().
> > 
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> > ---
> >  arch/um/kernel/kmsg_dump.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
> > index 40abf1e9ccb1..f0233e2f8de0 100644
> > --- a/arch/um/kernel/kmsg_dump.c
> > +++ b/arch/um/kernel/kmsg_dump.c
> > @@ -32,7 +32,7 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
> >  		 * expected to output the crash information.
> >  		 */
> >  		if (strcmp(con->name, "ttynull") != 0 &&
> > -		    (con->flags & CON_ENABLED)) {
> > +		    console_is_enabled(con)) {
> 
> Same as with the 9th patch. I would merge this with the patch
> switching to the srcu console list iterator. It will explain
> why the racy check is needed here. This change does not make
> sense without the other.

Ah, this was supposed to be for the 10th patch.

I am sorry for confusion.

Best Regards,
Petr

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
