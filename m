Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF7FE77170
	for <linux-um@archiver.kernel.org>; Thu,  5 Dec 2024 13:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ubq/hu+G8nIeTPOnP/0HoBADQynW4UrQMSyrrxs/8V0=; b=bY2F2UpLeDvx7hMJvgTwpZL1uY
	zNnnIiRvaxLgWst9X/8wIKtUpJnTSk33pTEZnNAV4jbhXFRZoR84vpUr4iFmTmh9E1qU+9Jg+/99F
	vgvgbvdrOHdr/tvVCQ3csSRUePYtl6SJlI6GUd19mkzxdVUYFX3KULh0xxUK8tzXpS/Ggdhlg0C48
	i3WC5ZQWOpxFKXadAO7BSaUJ47eWV9jxBWWSVqITUBZue1RjtYw8gfbBc+6FyCo8taA/QAcjNCmDe
	c3pL5zTzxhXSWFkAKAQT5Q7lIL/nEppJjqRITXoJQDdtRwg0K6N0t2ZniUcNr0gqWE31N9YCLovSy
	C58zzxnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJCCp-0000000GDiu-0Iel;
	Thu, 05 Dec 2024 13:47:47 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJCCk-0000000GDgo-23Aa
	for linux-um@lists.infradead.org;
	Thu, 05 Dec 2024 13:47:43 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-7259d6ae0c8so918342b3a.0
        for <linux-um@lists.infradead.org>; Thu, 05 Dec 2024 05:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733406461; x=1734011261; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ubq/hu+G8nIeTPOnP/0HoBADQynW4UrQMSyrrxs/8V0=;
        b=gxB7kGEBakUIttiVy3UO06KUUrA6OamrN1qAFFXaOJFUdezc9rY/9q+6XmhxsSI9RE
         C6FjzJT5d/PEPCslYuaE8cEqAUmdW6h64Uv258wo2zb1WOux4K9K9ZOJApqu5JF8avmk
         CI0zWBDIN2nWvOk4kb0KZAcqyhxYs4PR2Q5o4F8qrAecWSPVhhPcqblkCb1QbOJYb2p2
         dBN73RvK8LmcvGh7N9inVwB+0utu301o50Gsz+c0bb8cqmM1auwX37LwUL0ikKoVHPJt
         UJRVZa2+EY50z8lLPWNDofpmxN62ZK2SfuuEaEHJnLvBaldBdGP51Ti3gSrPsFx33sCf
         lClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733406461; x=1734011261;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ubq/hu+G8nIeTPOnP/0HoBADQynW4UrQMSyrrxs/8V0=;
        b=lAUns2kCvWKqtxHlSY4bVqRNqahJlYTab3yViBGuGRmvepnJ/16n2e+S9aA1cnlHy4
         dt7KHWt29BoFCCrOBFiMlDYNrfQvUaA/RQADTu8lrjG6MqhNlEJZyb6cvpg/Tc4LP9nI
         jEP+LcOQr4/O7Vzx2knoCDr4UpBJehezLyUW9zbYEMEXGXFyANXGDby+gDZeE60mbeLa
         mh2ttmzLTo29egKqZdvUji63Lhy5ZoTCcDz7pBK5Ip1g5goHziP/O1GlngVhUO1Hcybw
         q/AVauNJMJSE+b1w/y+hi26EVpzNa0+3rHUCsmtQf1FpTG0oJy6VA/Ei/BS58+IhIW0l
         WGJg==
X-Gm-Message-State: AOJu0Yzu6Vl82n67i6eJkpLS9FwXYV40RVHjDM+cKzQ6+uIQdn3qSZCI
	DIbBnKTm/bPTtS8zDBsGjaTih9isKyco5KwHk/3oW+IjDCh0nOgf
X-Gm-Gg: ASbGncvHENLLXFnN5qDKcM+ATI6Mt46C8NsqXUI044RqgnkjGlVIKtzxNvaj4nCuJeU
	Bal3wavRFWrx5JI6jRv4vKVzvLb99d7FT1mgDpIfyn3cKJr00E3WzPg54RtlUY6vERlOt2dl74y
	kt/zW8hgPNekh0zb5IgqvZJVnGrannT7VdgUe2jbRUvuKGV6buJSkiMrmA1JBduel5otsp6Gedw
	9EHPgI1A7qqUBvnQ1qbks0ez9pgHQ45RExC1vcIDYHjvSIn51Qaka0H6b3liss5tmIufkSfUjCO
	HwUYWBhXQvO+iw67uZDO0pBPsZFjxnjWos9I
X-Google-Smtp-Source: AGHT+IFmE6TFJa5a/6oJnG2MRL1RxmB+SkIDMAegrWEtQ4ekoHNV2yAy9f2KI5Dh4XYErruUdxxVSA==
X-Received: by 2002:a17:902:dacf:b0:212:615f:c6 with SMTP id d9443c01a7336-215bd250c13mr124468745ad.50.1733406461365;
        Thu, 05 Dec 2024 05:47:41 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e3e875sm12678305ad.19.2024.12.05.05.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 05:47:40 -0800 (PST)
Date: Thu, 05 Dec 2024 22:47:37 +0900
Message-ID: <m25xnyw8au.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: Re: [PATCH v3 04/13] x86/um: nommu: syscall handling
In-Reply-To: <4628fa35659910f21e38087a96953975a7dbe0fc.camel@sipsolutions.net>
References: <cover.1733199769.git.thehajime@gmail.com>
	<682460c3db1967aaa041b7e14342d48be3604c04.1733199769.git.thehajime@gmail.com>
	<4628fa35659910f21e38087a96953975a7dbe0fc.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_054742_528592_31539373 
X-CRM114-Status: GOOD (  11.18  )
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


On Thu, 05 Dec 2024 01:37:14 +0900,
Johannes Berg wrote:

> >  arch/x86/um/do_syscall_64.c             | 37 +++++++++++
> >  arch/x86/um/entry_64.S                  | 87 +++++++++++++++++++++++++
> > 
> 
> As I said before, I think it needs to be something obviously nommu.
> Maybe in a new directory, or maybe nommu_syscall_64.c or something like
> that.

agree.  I will make a directory for that.

> Also needs comment style fixes and I'm not sure about all the
> pr_debug(), but I guess they don't matter unless someone defines it? 

if you meant to the commented `//#define DEBUG` line, I will remove
it.

-- Hajime

