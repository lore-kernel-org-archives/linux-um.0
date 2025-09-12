Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AC0CAC587
	for <linux-um@archiver.kernel.org>; Fri, 12 Sep 2025 00:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KZADqpJA3chbnPl0WXJWbUaCgH9PLpd374WzwmzV8WI=; b=weQM5PQXxOfp+90uOOsjHLQeGr
	JKWqQLa5DMnmrpnJxaT+njE5Y+KSutab7rVfSXtpknAC2x7oa3r+xkqESht9vhLZ0XEff02zmP4fd
	oBi9PXDIg9t1mCDcP2IIrRmDjKdqDsno369Sy2//Kj2Hh8RGzCg8bPm4cCbA1jDCQVCmSzp/428sm
	05NfcdCaj9nePQPs4EbxeJA2xdedHk5frmPMOMaQeIay0RoFKH4gBxTRLriNPpb+0ijTL+SmQ/XSM
	0PxoGXzgfl9I9y+OImZBHw62sDm37OhLI3cKjzLCMxonQKSaasG+1WktMPxS/YjC2+sxlLun3IU1g
	rHevmATQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uws48-00000006BP3-2oNO;
	Fri, 12 Sep 2025 00:55:04 +0000
Received: from out-188.mta1.migadu.com ([2001:41d0:203:375::bc])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uws45-00000006BNv-1b1M
	for linux-um@lists.infradead.org;
	Fri, 12 Sep 2025 00:55:02 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757638497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KZADqpJA3chbnPl0WXJWbUaCgH9PLpd374WzwmzV8WI=;
	b=VNgIb7Y+r1rY2UrwKxf6twi9K4pop7vR7RL6IPTh1M5eiUHOpdQ1Ty9fJBgnmB56bx7HVr
	YfORy3vcBD+ZPi/fxmi0p8mbK4K3AjEiILYFyOEvN7wAqSaViF6CcBmQKLilaXZpP/bZWA
	sA9EI5hLSaQFzSPnHh423pWouswL0Is=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: johannes@sipsolutions.net
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	benjamin@sipsolutions.net,
	arnd@arndb.de,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: Re: [PATCH v2 05/10] um: Determine sleep based on need_resched()
Date: Fri, 12 Sep 2025 08:54:28 +0800
Message-Id: <20250912005428.2567361-1-tiwei.bie@linux.dev>
In-Reply-To: <78c8e39d9719a26c6e492e895b070794eb8218ea.camel@sipsolutions.net>
References: <78c8e39d9719a26c6e492e895b070794eb8218ea.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_175501_562903_45A4A851 
X-CRM114-Status: GOOD (  10.19  )
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

On Thu, 11 Sep 2025 11:27:04 +0200, Johannes Berg wrote:
> On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> > 
> >  void um_idle_sleep(void)
> >  {
> > -	if (time_travel_mode != TT_MODE_OFF)
> > +	if (time_travel_mode != TT_MODE_OFF) {
> >  		time_travel_sleep();
> > -	else
> > +	} else {
> > +		raw_local_irq_enable();
> >  		os_idle_sleep();
> > +		raw_local_irq_disable();
> > +	}
> 
> This seems wrong, with it, lockdep gets really unhappy, and if I remove
> this change it seems to work OK?
> 
> I'll note that arch_cpu_idle() for x86 also doesn't change anything with
> interrupts.

Thanks for catching that! I missed it. I'll take a closer look.

Regards,
Tiwei

