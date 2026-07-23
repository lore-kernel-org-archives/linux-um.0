Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB50C44524
	for <linux-um@archiver.kernel.org>; Thu, 23 Jul 2026 04:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vJuXzxtE1Qs6UqnljOx5NHv3ZZ5lEmIyHzl0pQhJtZs=; b=NYkwSXnLv+OpurUczJDRiSUfQA
	5u8wjRzsvVKIupq1v2JgQtqtCtSIJEzVfhoN9AEIxk5CzED6Ok2TL24xHg78l/CPXRRDhWNE7iYOa
	ME95FV+Q6G8a9M6xdK7JCATnmeIeZvG1PK4iHEfn+96gYGv3HdsdFEqdHs52L0TFPR1xQeO69czQl
	fZUfgvlimbdAiBi8XtsMuPKmZAvQ1QgnsoHBXTv6WxefAdxO8n5CLJ2SYdH7F38dgwsTJTy+Fy24T
	pIXBAg7vXM3S3kFaDaDHBVY+ojEkH/AtjoUmqxHNW7TpqynXRhMDlF0NCk9zJ/2fRPWSlT/XCg/EA
	sCnT9zqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmlLa-0000000DQg7-2uJd;
	Thu, 23 Jul 2026 04:47:50 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmlLY-0000000DQfg-2mXX
	for linux-um@lists.infradead.org;
	Thu, 23 Jul 2026 04:47:49 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2cf452def93so343595ad.1
        for <linux-um@lists.infradead.org>; Wed, 22 Jul 2026 21:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784782067; x=1785386867; darn=lists.infradead.org;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vJuXzxtE1Qs6UqnljOx5NHv3ZZ5lEmIyHzl0pQhJtZs=;
        b=li/cfN7i+pG7a1Qfj4FfP1VyP7CLRyO82DeRXdgtgPGVTWWM2BktNvx6ThyDvEP6xv
         6s0Q3IZu50YuPTzWOOxZZKkNCTuMoDmNOAB1V/wG2kZi5MzcfwZ5Dp33viPKebqoukAw
         YJpsUv38mjjkE7Mkb7tX7fTVyFnzRDbMne5HVUI/JiVKYdYjF9bCU1LltkfcBIwVhm0P
         TUVbKONsG7pqaBSQHbj/pLg3nRhs1TwWi6S4PvSxSOU8eZYQ5hPGP6iuJy7kvXReh1vu
         VnORiXl2g0yI6kiStpsyaIFIjp52K+ATURMkXYgacxT7ZCgclcKpbni+OF4eUBXwO8M1
         vQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784782067; x=1785386867;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vJuXzxtE1Qs6UqnljOx5NHv3ZZ5lEmIyHzl0pQhJtZs=;
        b=GWfqimkYYfj3Xw9FHj+p4NajcnB4HqXtt6SEyudiKhTFDONZfSYLZra0Azb/n8MuyJ
         2o4UOe/Nli2k3bLujz+4tkTlZ50yiubvAfICIHFgxXa6oACZU+JyaqbA9Wm6gRRONl88
         YarhRTgIaFBAtz4WlxXZ//aMmp/pwLzmINhw8Ib1X+TjKzmvCsewLECr5IyNLTu5L9dT
         e04wYLcmcTYKAo+RaxOQ5VDjAltnyDiozX6K4CNEXOME09HqLVIqUM53V9c6axUUlX3h
         WN5CvZo6TLNQlwKAXMldBHyzoE+xILrUQ8xkRNIo928LmUBbPAIwFB2/L+9rgwHYQQM6
         ZsIw==
X-Gm-Message-State: AOJu0YyB2879y2dY0YyT7Pa2W+ZWenGkQ8ekU9AG8L36l9voM5ONLDwB
	vPW1iWt0URoRxrEjJn3GSs9K7zTUbPYWOdcTQrbHLGA0Wly1QZCd4f18biDMzQ==
X-Gm-Gg: AR+sD11ShnTjJ3gYPAsOGVjhVKlfTzKCUnyF0Vjz9kHVDVE4NWnBCw5jGqr3vmlyxhQ
	Q1AJYR+nv+su3BlsH/DhlQco3ZE6MVT8HRjmt2WSX/epg45v16qgBxPSxtqkMk1dhfo43Ogi2EP
	hqJBl2lkZM7FuLSnlyp3QwqZa3GMQyJTboTEuKRX8GkKpgoPpsiwKYzYwPJ9A1p3+nL7tbO7ZYe
	oWEm6tuIvl7hdjoZRMyFh4Neal9C/qG4szQ4d+k/wqhTHD5dHaZEIMEDFK11eELvqDj8+aEY1P7
	JbuQJ8KjnTJBnSmaM2o/fqpvBtfUHj4B7rCo6hiSdE1TNlRlIJ5Y96hQB18ARm8oLX3/uzCGU/G
	RC+bnBE/0j2oc86RBj3VGsD4lbV71SxVLc/MxsN4k0qczR5I7V4f/oNIjbHoN1GO9OjRGTo1j2e
	BzC3hTUHdLbwTMvYIto023Yq+cyu1WCMxnqUt5wJwGHVldXnQ6LBIJF8I9
X-Received: by 2002:a17:903:11d1:b0:2cf:70d2:da7c with SMTP id d9443c01a7336-2cfa94554e8mr13898715ad.12.1784782067314;
        Wed, 22 Jul 2026 21:47:47 -0700 (PDT)
Received: from earth2.local.gmail.com ([210.173.24.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efdbfd0sm25623195ad.21.2026.07.22.21.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 21:47:45 -0700 (PDT)
Date: Thu, 23 Jul 2026 13:47:42 +0900
Message-ID: <m25x26z501.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org
Subject: Re: [RFC PATCH 8/9] um: nommu: add userspace runner processes
In-Reply-To: <f749582f2e2fe9219a854b8645c58df3f6b9ebf7.camel@sipsolutions.net>
References: <20260720185103.530603-11-johannes@sipsolutions.net>
	<20260720205103.5a666eac428b.I9f810f3ed177d6dc980cad36c231f8c745dee48f@changeid>
	<m27bmn4xqv.wl-thehajime@gmail.com>
	<f749582f2e2fe9219a854b8645c58df3f6b9ebf7.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_214748_709729_B8255213 
X-CRM114-Status: GOOD (  49.29  )
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


On Wed, 22 Jul 2026 21:44:56 +0900,
Johannes Berg wrote:
> 
> On Wed, 2026-07-22 at 10:30 +0900, Hajime Tazaki wrote:
> > I was wondering where kernel address is located in this mode.
> > although it doesn't have to be, under nommu, kernel address is located
> > in the same address space with all userspace processes in my
> > understanding.
> 
> Why wouldn't it have to be? If you have a real nommu system, then
> there's no MMU, and so it has to be, no? (but see below)

As you see, nommu doesn't mean it cannot have protection (or
isolation) features (e.g., with some CPU extension etc). that's why I
said it doesn't have to be (if it is documented).

> > the kernel address is accessible (danger but it's !MMU) from userspace
> > thus __access_ok() always returns 1.  so just wondering what is the
> > case with this runner process approach.
> 
> It's still the case, in the runner startup I mapped the whole thing into
> the runner process(es):
> 
> + map(&r->mm_id, uml_reserved, high_physmem - uml_reserved,
> + UM_PROT_READ | UM_PROT_WRITE | UM_PROT_EXEC, fd, offset);
> 
> > a program accessing kernel address may fail (or crash in some case),
> > but with the runner it won't ?
> 
> It still will, I believe, since it is mapped into the same address
> space.

I thought the kernel address is invisible/inaccessible, or isolated
(somehow) from the userspace code.

let me check more and get you back here if I have any questions.

> I did consider some other things:
> 
>    1. Using clone(CLONE_VM) instead - however that means I cannot use
>       the stub as-is, and to work without it requires doing a bunch of
>       setup in the runner process(es) - which is mostly equivalent to
>       the stub.
>       
>       I did get this working (at least in seccomp mode, not sure now if
>       it worked in ptrace too), but it requires shuffling around and
>       duplicating quite a bit more code (e.g. the seccomp setup etc.).
>       
>       This would've made it more obvious, but has a fairly high code
>       cost and no real (other) benefit.

understand.

>    2. Conversely, with this approach, it *is* possible to not map the
>       whole kernel into the userspace runners. I didn't try this yet,
>       but it shouldn't actually be hard - just adjust the above map()
>       call a bit? OK, it's a bit trickier with the VDSO etc.
>       
>       This would possibly be a benefit for testing, although userspace
>       processes still need to be able to reach (and crash) each other
>       anyway, so it'd just crash them if they tried to erroneously
>       access the kernel.
>       
>       I don't think this would be very hard to do, but I also didn't
>       fully think through the consequences - is the VDSO really the only
>       thing the kernel assumes can be accessed?

I think the current way should be fine as a base version.
will see any additional fixups if needed.

>    3. Some real nommu devices have MPUs instead, e.g. CONFIG_ARM_MPU. I
>       didn't look into what this actually ends up protecting, but I
>       could imagine that e.g. we actually make read-only sections read-
>       only, etc. I don't see any general infrastructure for this though,
>       and the ARM code (arch/arm/mm/pmsa-v7.c, arch/arm/mm/pmsa-v8.c)
>       just seems to set up some static, more or less hard-coded,
>       protections. But I didn't really look into that in detail.

I'm not familiar neither, but nice to know those.  thanks.

>    4. We could perhaps support XIP? But that's a whole different can of
>       worms. Maybe it's not even NOMMU related.

might be interesting to have.

> Anyway, I also decided that all of this (except 1, which I discarded as
> a design decision to simplify, after prototyping it) could be done as
> later additional patches.

agree.

> I also just realized I didn't really respond fully to your question
> about what I want to do with this ... so if you're happy with this set
> and I can hopefully get some of the others to review it, then I think
> I'll send it as real [PATCH] and we can merge it, and go from there. I
> also had some docs (based on yours) that I didn't include here, but that
> I should include then.

thanks, it works for me as well.
Please Cc Lorenzo and Liam as well to the patch (as I have requested
from them).

> And then we can see - maybe we want to rename "skas" (after you pointed
> out what that really means), maybe we want to more generally clean up or
> separate out the code a bit?

for the rename, well, Im not sure.
for the clean up, I agree and wish to help this.

-- Hajime

