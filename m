Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA04C5DF67
	for <linux-um@archiver.kernel.org>; Sat, 15 Aug 2026 21:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=31zdeqcy5sPeYzke8us34mex98HuBd1sdQEvsQlannI=; b=PXiPd64iIMBcyZt5/LUUW+uZJt
	T6ybsQ2otvBKCJVHDZ/eLK7kqOw2E7slnlq6Yy6zhz253lV7SFiOm3IfCgciG4GXqyVlz4Y078lPQ
	A+GImoF7EumCeeEzpXdpumqHSR26taRc5fz4aPlKcWCwGF/dqpE+PIBbB10asIuupIC8EPlHfSdzN
	8acc108kcJgkVoFptpNk52DW70/Z8OdINJ6zyyy4DN5XW9EzUF0TqubxJdLaiSoB1ADABr2intLDc
	+FLBiVfpszFc3MK2unxMTzCGTKJw+AR7Pr7MUbw8DYFSpdaXGWPAKNidQBcEN0L3TujnRf8WIfqew
	AE/SPWUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvMOs-00000004DyA-3x8b;
	Sat, 15 Aug 2026 21:58:46 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvMOo-00000004Dxk-3Z6Z
	for linux-um@lists.infradead.org;
	Sat, 15 Aug 2026 21:58:44 +0000
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so2941606a91.0
        for <linux-um@lists.infradead.org>; Sat, 15 Aug 2026 14:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786831122; x=1787435922; darn=lists.infradead.org;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=31zdeqcy5sPeYzke8us34mex98HuBd1sdQEvsQlannI=;
        b=RdvmNoXnNTDI+a6WICCSLbwMBfg40ybYiioc0evqWrI3QOxxcvA477bWIVR+Wrterq
         1Yjr+OE1yOaXsSGPM1vlSH5ogllSYUwpjkaBNprIkGG9w+q7toqzim22zHFq/f98Y8TF
         VaGBDpY+ddanAmFOkXcM/dG6QhAtMH6AutzSLxqSIh5dtOIpRKBYnMJigPgYYAREhvtP
         94SOmElbyCSBF/mM1vye6+ioB9XnUF5NExmjKXGGseA0q9BIpR+8tTVi6eTaTrsSSWcw
         Tz9HfMFfP2IFNfGpDg8ywkudL8GLO/vwFvTie9w6z3LwWygck4KtS+Gwq9oNFCZbQwSE
         AIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786831122; x=1787435922;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=31zdeqcy5sPeYzke8us34mex98HuBd1sdQEvsQlannI=;
        b=N4aiDv9MQXx9aF7M8chonQzitVnCGqmwphvlV/qiVSUQU5lQmXq3/qicu2/UGvR+DD
         172k8gJIcLmCvTIm66VGQZucE53dbf+HOlESy2sRUpz6BpjYx4pXY47BpY/jA4qV3Nt6
         g36MvZ0aIBHuCHbCSIandkx8d9HH0EuzfOC1pTRmXZKFQTIH8v+ua9GbWT+g8EdSxZxB
         gtvOsLC5q9IlUBGRAA/bxPq48DIm0LMNPySgooVVx/HdtV5UBkzHm7ART+XbYF/5kB6p
         VRGFaRt+yiSsKI18XGOLfWwFnncup0tWv1Zh0svOAJody1J7Awas7W8oUylIJZ6KdfID
         PoAA==
X-Forwarded-Encrypted: i=1; AHgh+RqfT5+TF0Z1/xRV23aY/l/BirKQgoYER6CcBd+9rm8sUcN1U6iZWxwMZvJnf9hll4nn87Mx2KjBvQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzE9ByIYkZunQ71CU4xOf3DwFPJZx7a1TMLIZbVToIv4yORzuq4
	Ytg+QRSy3oOL7yUvj15VDDfLzbWUqg97VueD2F0RvDeaCRHVqldIk9GI
X-Gm-Gg: AR+sD12VZd9JMND+lAE2jSLmRw+VuC5brRYZPntPdMz4VNn2ZSUA8okfYeaz/G8uTon
	ZzGLmfy/SrgSmpNc6Grx8NEh/jynswRIHhJsIIPaQweZWnAaVjpWhaP9v4Xdi3CHodt+1NTDi6L
	5seBa7hbACkL21ZuyIweHzxHA9Tp1HV1LJwivd7FujLNYTmZ39jsyfzcZKbzJryAwFEAzgHPrWS
	UYvyBTXa7Wksb/AmVFyJDK4+HFJBNIgA0DywurysL1FmBzQt+aK1XbqW1zTc6OJzlhReL/bJsba
	fb0LIouw7WZ+S9AV0vvu51Y8g5/Bmy3Xa4aY4Fn7lPdMqgxrFwfl3QTOEa6L9sOziXMS+TweCqO
	GJWcmwZFFOVTNM9AxTyRKVypqlyeQsiYKHhP3G+pwr98nU/vyrD0nUGpzEOMIPndqGSqigF2mtH
	acK9s8L5hTlh9NrFE4TmEtkllb0xSEfqcihr5EHQLh6qdvNzqFnhVicCRvvXylNuUTRlN9f8U77
	T3E4+3kKBBPokJyoIG32CUAjOZfm/uZrFuaEPqZmuaTPp108TfLMaFZBRMSa1LtvE795UAxqNEw
	+Ds8WQ==
X-Received: by 2002:a17:90b:5606:b0:38e:6aa7:68ad with SMTP id 98e67ed59e1d1-3933b7fae6amr16351451a91.5.1786831121788;
        Sat, 15 Aug 2026 14:58:41 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ea9722fbsm7233622a91.3.2026.08.15.14.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 14:58:39 -0700 (PDT)
Date: Sun, 16 Aug 2026 06:58:36 +0900
Message-ID: <m2tsovoxkj.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: broonie@kernel.org
Cc: ljs@kernel.org,
	linux-mm@kvack.org,
	geert@linux-m68k.org,
	daniel@thingy.jp,
	shuah@kernel.org,
	kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	jackmanb@google.com,
	liuhangbin@gmail.com,
	rbm@suse.com,
	linux-kselftest@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: Re: [RFC PATCH 5/6] selftests: run tests on nommu architecture
In-Reply-To: <4355a510-2e00-41f7-9bb3-8f6b2d95503b@sirena.org.uk>
References: <20260813063401.1786548-1-thehajime@gmail.com>
	<20260813063401.1786548-6-thehajime@gmail.com>
	<an8MlE22U3586R42@lucifer>
	<4355a510-2e00-41f7-9bb3-8f6b2d95503b@sirena.org.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260815_145842_915197_F0E8C1FC 
X-CRM114-Status: GOOD (  25.99  )
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


Hello Mark,

thank you for your time to review the patch !

On Fri, 14 Aug 2026 23:34:15 +0900,
Mark Brown wrote:
> 
> [1  <text/plain; us-ascii (quoted-printable)>]
> On Fri, Aug 14, 2026 at 01:50:50PM +0100, Lorenzo Stoakes (ARM) wrote:
> 
> > So at this point you're not really running much of the selftests at all,
> > and are only happening to run those that don't do the very basic stuff
> > nommu can't deal with.
> 
> > I think an audit of existing tests to figure out what works with nommu vs
> > what doesn't is really unreasonable again, given nobody tests or seemingly
> > uses these arches.
> 
> > So this patch might beget more nommu carve outs and exceptions and
> > therefore nommu workload and maintenance, which isn't really sustainable.
> 
> > I know I complain about lack of testing on nommu, but at the same time I
> > don't think running arbitrary tests that happen to work on it and who knows
> > if they are valid asserts anyway really fixes things.
> 
> > And given nobody really is doing testing, it's not really a great RoI
> > here...
> 
> Perhaps a good first step here is to start off with getting some public
> CI set up, then build up to getting things running cleanly.  That way
> there'll be visible ongoing coverage which will help motivate getting
> whatever changes integrated, and if the changes are done bit by bit
> there should be clearer explanations for why they make sense on nommu.

thanks,

I'm currently running tests on my personal CI (gh actions) but try to
find a public one to be more visible to others.

> You could perhaps use a skiplist to ignore tests that don't work yet so
> the CI starts off clean?

thanks, that would indeed make nommu tests more cleaner to integrate
as a first step.

-- Hajime


