Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4281CD37B0
	for <linux-um@archiver.kernel.org>; Mon, 18 Sep 2023 14:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k4Jz0yWz30JkyNNWQAuleOPvY0zavGr+CYFxUXYhC4o=; b=3f9CLghtpEKRxE
	XXdge4gArSoKUGfdMJI+xcKIWxGiIuZ7GDToVAFya9/vHNwaNBlDU/p2mFpIwrZMPiHJrNadMUS6C
	79KeSBEiQKhOkKNIzzf2LugHG6V8GaGgXgAquA4gANmFOay3Wb3A70E/+56YxFk7BU/e3/oJLZec4
	jY7lGb8BuDGFoBdUjGeIwWbYVH17KOIlBni2+H2OohHYEhbcuerWkXNPigZBQMfOjmX+QPPWyTroA
	QWA5a+2oUaIRnppayUpO5GDTGhNoLP+g71/iws0tKE2TzZJF6636Opnoo/Jk+0uqK7ZMWOa0YuiBa
	N6E5cPK4DCkqqMu06psg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiFBS-00FedQ-0S;
	Mon, 18 Sep 2023 14:25:06 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiFBN-00Feci-08
	for linux-um@lists.infradead.org;
	Mon, 18 Sep 2023 14:25:03 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9CE631FF20;
	Mon, 18 Sep 2023 14:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1695047099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7k/zMUERva64SewvTMtFZgYEqcH6fC89q9sFyyJsq/k=;
	b=Cl7e3mvx918s/0zUuN7kT7+zYVdL6sMszlDz1QEmDIXo/ku1cks5d61Bx6NZyKw2Hv/Z85
	Yphvifl7ReKud1tVOfnn0uUb7N8e2IAF29cwib2jkC511YpIoBG1XcEJyOGlF2r6yo1ggp
	oW6Ki1FdHP4dbew/XIolCDspW/mcoUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1695047099;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7k/zMUERva64SewvTMtFZgYEqcH6fC89q9sFyyJsq/k=;
	b=Zr+B2n9JSNfwINesiPLJEqTd0qEXVM/hfLdX0H6Zf3DZN9mgd19Tm8kzd0OsK/SwmAVWh6
	s8dNKrYGpkvt1GCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8DB3113480;
	Mon, 18 Sep 2023 14:24:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 4yiKIrtdCGV7NgAAMHmgww
	(envelope-from <jack@suse.cz>); Mon, 18 Sep 2023 14:24:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0609FA0759; Mon, 18 Sep 2023 16:24:59 +0200 (CEST)
Date: Mon, 18 Sep 2023 16:24:58 +0200
From: Jan Kara <jack@suse.cz>
To: Peter Lafreniere <peter@n8pjl.ca>
Cc: jack@suse.cz, linux-um@lists.infradead.org,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	reiserfs-devel@vger.kernel.org, richard@nod.at
Subject: Re: [PATCH RESEND] um: Remove CONFIG_REISERFS_FS from defconfig
Message-ID: <20230918142458.cwktedwchg5bm5cc@quack3>
References: <20230910232640.113938-1-peter@n8pjl.ca>
 <20230918125744.4342-1-peter@n8pjl.ca>
 <20230918132614.zmmuc72purc2psik@quack3>
 <20230918141359.11097-1-peter@n8pjl.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230918141359.11097-1-peter@n8pjl.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230918_072501_245848_245D02AE 
X-CRM114-Status: GOOD (  18.14  )
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

On Mon 18-09-23 14:14:21, Peter Lafreniere wrote:
> On Monday, September 18th, 2023 at 09:26, Jan Kara <jack@suse.cz> wrote:
> > On Mon 18-09-23 12:58:26, Peter Lafreniere wrote:
> > 
> > > ReiserFS has been deprecated for a year and a half, yet is still built
> > > as part of a defconfig UML kernel.
> > > 
> > > According to commit eb103a51640e ("reiserfs: Deprecate reiserfs"), the
> > > filesystem is slated to be removed in 2025. Remove it from the defconfig
> > > profile now, as part of its deprecation process.
> > > 
> > > Signed-off-by: Peter Lafreniere peter@n8pjl.ca
> > 
> > 
> > Makes sense but I've noticed there are many more architectures that define
> > CONFIG_REISERFS_FS in their defconfig (sh, powerpc, mips, m68k, ia64, arm,
> > alpha). So perhaps we should do this for all of them when we are at it?
> 
> I agree. I can send a patch series for those arches except for ia64, which has
> already been removed from linux-next.

Than would be great. Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
