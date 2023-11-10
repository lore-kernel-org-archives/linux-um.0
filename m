Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28040C4332F
	for <linux-um@archiver.kernel.org>; Fri, 10 Nov 2023 12:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Mq8P1u+EKPUHKA6MqtCHYsOaxhkWHsyLthf2I2PJNUc=; b=LOBxXnqlM+A2a3
	w7N//GSUNyu8MI7KrlXKUzIQMvqglMRcmcggi08vY5xoL/Ea9M4qXsbZX8ltjxZOAsNql6jf28Z9n
	N8m6wTgDFID7AEOv5ahJgWpEXFYe/AyJVHXYYtviMZVVdS/u0K/xPBZ3qNuCnlm2DrCEELlT87WBv
	TGjT4jgleF7o+Ue/ZMUfjnWfxcXcXZwuXuhUoV9/xG/FYP3DWel7CymJRjCfmGF1PnqHdy2B1gZV1
	lWqY/YJB2Xs3kMSBEjgihWukRaMYAkbh5iWnBknQiQFhQIsXtQDPdNB0x2znsDREb5BA9U+jzBXkj
	pIGCNNm3s1Rds1+zDbMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1QHc-008bfC-31;
	Fri, 10 Nov 2023 12:06:44 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1QHa-008bep-0q
	for linux-um@lists.infradead.org;
	Fri, 10 Nov 2023 12:06:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=tS4+O4ajIU8kixe5doB3nfCd0gbbxl1yuPzJr3mTCAg=;
	t=1699617999; x=1700827599; b=tXwPGP/OKRsTgWbeLKqydiwuL5Iv5/01ZNv9gO7nQkLEzEX
	eEI6bpfmG/oB2qCHEqFXNsyaUn7Z2wnSLXhcbdUnPK6MlCrYTtiigOnS4loSsAP8vhyaSfI8LxUr3
	HyuW+S0LLflTrs1mYXtDp1DTl9fi/wT/Az/bzkMruG1Bho6CAZnB6gE4vJ77cqwnreDnHQxJTTb//
	RnqTyd8JXT5QWfPRsbSesTYvfSQ9+wAoaloUBEMkt25sIIxnP4px6IfXn98g2rN2QK2aQVGwjQ9q2
	twm+T+qeQ8trrFQ4SElHpUKGaHsWWyRZdZ/nCr7EFFJywQ4pX9cgrhjFRywup9dQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1r1QHU-00000002z1c-1yz8;
	Fri, 10 Nov 2023 13:06:36 +0100
Message-ID: <a582184be17123a721366c615816708a9f9507a0.camel@sipsolutions.net>
Subject: Re: [PATCH] um: hostfs: catch EINTR and partial read/write
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, 
	linux-um@lists.infradead.org
Date: Fri, 10 Nov 2023 13:06:35 +0100
In-Reply-To: <4cec737d-204f-6add-d262-0bf7e2d4d183@kot-begemot.co.uk>
References: <20231110094425.1810667-1-benjamin@sipsolutions.net>
	 <f0c614a6-cf3a-b6e1-6f40-ad6d59460fcf@kot-begemot.co.uk>
	 <458e033f-1769-fc04-c491-e9a69058c7da@kot-begemot.co.uk>
	 <b94879fbac02117df724d0ef8fa4d3b3b400b8aa.camel@sipsolutions.net>
	 <4cec737d-204f-6add-d262-0bf7e2d4d183@kot-begemot.co.uk>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_040642_296057_129F2D70 
X-CRM114-Status: GOOD (  16.30  )
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

On Fri, 2023-11-10 at 11:12 +0000, Anton Ivanov wrote:
> 
> 
> On 10/11/2023 11:10, Benjamin Berg wrote:
> > Hi,
> > 
> > On Fri, 2023-11-10 at 10:56 +0000, Anton Ivanov wrote:
> > > On 10/11/2023 10:42, Anton Ivanov wrote:
> > > > [SNIP]
> > > > 
> > > > If we are going to use this definition of CATCH_EINTR
> > > > throughout we
> > > > might as well remove the partial read/write code in UBD and
> > > > other
> > > > places.
> > > 
> > > Actually - some of it. In some places it will still be needed
> > > (trying
> > > to get my head around where this will work and where not).
> > 
> > Do you mean that we could just use the os_* helpers here and define
> > them to catch EINTR and also deal with partial read()/write()?
> > 
> 
> Yep :)

Looking at the os_write_file/os_read_file users, the only place where a
full read/write does not seem appropriate to me is in hostaudio_kern.c.

There are quite a few places where a read/write cannot (or should not)
be short, but a retry loop there is completely fine.

Benjamin

> 
> 
> > Benjamin
> > 
> > _______________________________________________
> > linux-um mailing list
> > linux-um@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-um
> > 
> 


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
