Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78128D10BEC
	for <linux-um@archiver.kernel.org>; Sat, 26 Oct 2024 07:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Subject:Cc:To:From:
	Message-ID:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ePh62g2wb48iljlb1BBAGkxhpGP83R2KPzPR1bB/Rj8=; b=ekU+gdLktwZDucpsQ6FmEIyeZm
	Nzn/BZF+94AbXemXTuSqdUAX3k3RQj/XYFx8mS/AulIwrMU2eVDCuJ3P93fLhHh7nKxVW2c/dSR6U
	PSOPMqClq0PfIA4PkCX23e855Y4tZGpRo5KjJM7G1koZknBNTE+NA0ksCnoadMW8pyCUmDukJsTa6
	xUQzi20qaeHG+Ythgj/4ThUiz/XH/hyzhXjD5IndOu04t1AWm2khSMNfPKySo/fvE1ZXqSoszuPsy
	n+CTGU8drrSvsovLRw9J7UqZ7JZZpRbqp9FILEhFQUkxdoa70pBwGB4RbCgvX/cONeM5dDfjx5HRk
	AP2BD/Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4bOf-0000000693P-0pS2;
	Sat, 26 Oct 2024 07:39:41 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4bLm-000000068h6-1yzZ
	for linux-um@lists.infradead.org;
	Sat, 26 Oct 2024 07:36:43 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-20b5affde14so19802455ad.3
        for <linux-um@lists.infradead.org>; Sat, 26 Oct 2024 00:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729928201; x=1730533001; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ePh62g2wb48iljlb1BBAGkxhpGP83R2KPzPR1bB/Rj8=;
        b=ki1RGvpwkbXm8K/w6ow+vww2pGo1H29lxqcTxng4U7Hkt4CH6ACTOC1QthFQxUmzPV
         zlRLH9WNQLdnvIt2fIOs6LrvpfgNN27xxhQIhyMLVdlNHTuzQIqQh0xCCgVuQRIn2p0j
         tMu718GxcQRxrzE9mEk4nCTwtsvVJN5E6GBrXJu8L939AXhFvz4OUTlb7JLDAB7oB9wq
         KrYTzDwEBWxYznjr7nL/nGPzSj9e1JvoLMhKBVtLWkS7XVfmRXR66vXB+xi1pnBaH3vy
         /axE2CJDx85LthtyG0TP0TkxyDG6hck+BtInxfa/PWfwIDszNIKR+x/AooWcUA5dHTv6
         Cd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729928201; x=1730533001;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ePh62g2wb48iljlb1BBAGkxhpGP83R2KPzPR1bB/Rj8=;
        b=YHW+VeHpDD+ikr/kjS/YN/UK51AcogTor0TBq1eZ6YWoTnPOGyLCHXf9cN0Y9uoztV
         1pMi0B+hTjj2foej15b2TDXXtKTHXR1fGSNY60yZoXTHHBNsixfO6uASfgdeLw/zcXKh
         5Rxi8YzBCUByl+Vpib102eJZMMLfyVTQri5xI9xNkXe4kbKYdiAzt7pL7oS5YrHrxfAP
         ijiBcz8GeOJRtAGBYQagBIM8EImmaeMVl4m2WSOMc0kZgJhjuPpAmyFRbSL1wjP4fKYm
         fUnMprwOi9/4leQjW24kTXzYrMRBSNnEziahCM0b4pkr/P4KtTBri8K8xYUg9AlhmUvD
         /QKg==
X-Gm-Message-State: AOJu0YyHk4RmkXVDoefHlcvSGzAl/OycHhdaDY3gE5BsXDP5Cz1aCy+F
	eiWlBAjn8pEfMpKGyoHgdZ1v4cHO0sJFyg5bDy27haaPSALQkxPc
X-Google-Smtp-Source: AGHT+IHU0a0Tux8mUHxhTtWVqybQWDx0aVNpKOUTq7AzuvYzFtrnmYxK2zZR8qg84F+GOCvTtECDyA==
X-Received: by 2002:a17:902:d485:b0:20c:7c09:b2ac with SMTP id d9443c01a7336-210c6c5db72mr21959835ad.52.1729928201385;
        Sat, 26 Oct 2024 00:36:41 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc0864d7sm19828825ad.303.2024.10.26.00.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 00:36:40 -0700 (PDT)
Date: Sat, 26 Oct 2024 16:36:37 +0900
Message-ID: <m2zfmrgvsq.wl-thehajime@gmail.com>
From: Hajime Tazaki<thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	jdike@addtoit.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	ricarkol@google.com
Subject: Re: [RFC PATCH 13/13] um: nommu: plug nommu code into build system
In-Reply-To: <e711d2ed2ecc455e6de5b9fd7e904ad34c978b1e.camel@sipsolutions.net>
References: <cover.1729770373.git.thehajime@gmail.com>
	<82a7ee8b31c51edb47e144922581824a3b5e371d.1729770373.git.thehajime@gmail.com>
	<ce4a00dadcaf888ff1bf7887b3af722a385e694e.camel@sipsolutions.net>
	<m2msisnxiw.wl-thehajime@gmail.com>
	<e711d2ed2ecc455e6de5b9fd7e904ad34c978b1e.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241026_003642_536811_008AE8EC 
X-CRM114-Status: GOOD (  24.76  )
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


On Sat, 26 Oct 2024 00:27:08 +0900,
Johannes Berg wrote:
>=20
> On Fri, 2024-10-25 at 22:05 +0900, Hajime Tazaki wrote:
> > On Fri, 25 Oct 2024 18:33:06 +0900,
> > Johannes Berg wrote:
> > >=20
> > > On Thu, 2024-10-24 at 21:09 +0900, Hajime Tazaki wrote:
> > > >=20
> > > >  config MMU
> > > > -	bool
> > > > +	bool "MMU-based Paged Memory Management Support"
> > > >  	default y
> > >=20
> > > "if !64bit" or something
> >=20
> > not sure if I understand correctly but where do you suggest to add "if
> > !64bit" in this block ?
>=20
> config MMU
> 	bool "..." if 64BIT
>=20
> was what I was thinking, since you cannot allow !MMU on 32-bit.
>=20
> As you wrote it, the user would get prompted on both 32 and 64 bit, and
> get an invalid configuration on 32-bit if they turn off MMU.

Ah, thanks.  Yes, the !MMU isn't available for now on 32-bit subarch
so, will fix it.

> > > > +config ARCH_FORCE_MAX_ORDER
> > > > +	int "Order of maximal physically contiguous allocations"
> > > > +	default "10" if MMU
> > > > +	default "16" if !
> > >=20
> > > Should there even a be user prompt for it?
> > > Perhaps "if EXPERT" or something?
> >=20
> > I think it's already user-editable=A0
>=20
> It is now, but it didn't even exist before, so nobody would've been
> asked. I'm not sure it's _too_ useful to ask the users though? When
> would they know how to set it? (Perhaps also add some help text? I'm
> guessing it's related to the size of binaries or so?)

Ah, you're right.
I thought I only added !MMU part of this block (but it's not
correct)...

> > but your suggestion is to limit with 'if EXPERT' ?
>=20
> Or maybe it should just not be user editable at all?

agreed to add if EXPERT.
I'll also add help text to that.

-- Hajime

