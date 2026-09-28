Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF888C9832F
	for <linux-um@archiver.kernel.org>; Mon, 28 Sep 2026 08:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WpISsSMTyY1axSmV/f4lSLSIYTVX0V5UWy41/GPiWhQ=; b=f6hYWJ3yxevmsoznTk89JNhYcS
	WDVH2SYwup/P+QVxzGlb+MWF5JQcVXjroPJmcXO4KAmaYEosA2zmJcJKbiU/3uMdqS6LL0NqDvAdR
	ogI0vC6kN6COLi6cIw9zDqeM9yqvHRezr4JEJZzw0RZYZVxbcLMwjGubFTryGu+nME28MpnFHkbkp
	etMPOF+yrWdGt/A0JN7r77CU4eU9nOsDdkYiYYS6QhtXyHsrxousv3Eh2qnyMYGdyXaWGs865eBZy
	1pIzPZAgqLNDoxjqp41ZmnNA73ZFT28hncpTRCGwwM8mnm+808KEtQJtfP/kW5j5f+nQna+FEOkC0
	3abYk/BQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB6Sb-000000002Lq-3wmX;
	Mon, 28 Sep 2026 08:11:41 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB6Sa-000000002Kp-0tYV
	for linux-um@lists.infradead.org;
	Mon, 28 Sep 2026 08:11:41 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2caced6038eso17025985ad.0
        for <linux-um@lists.infradead.org>; Mon, 28 Sep 2026 01:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790583099; x=1791187899; darn=lists.infradead.org;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WpISsSMTyY1axSmV/f4lSLSIYTVX0V5UWy41/GPiWhQ=;
        b=rXmqgKnjKEsCV+aDpkd3AbUnEMVxmj80/N2n9CVlWBRuTWcbG5XDVpopuRLXmz4ku8
         XE2Xz1AbHmYMcXFh7dT5W6aq0apVrV/cExbSGxIhNpzvf5RmichtMbR35/joCOVZtxln
         OO8GbmrcuB/EPMFKA3JMxBAmfoBKqov9BZ2pTVW2rA2UM6Nj3AXh2U4V7ZWTsMIEkhCA
         RiXatkwQA5HWew2T0hW7Sk0YkhDDZhtHtgQmZa1KuZMVpzZhOUzLpT82nUWLzTeb33rq
         qQ0Wu5PYnwXyXdMXHJkVsyYRbanltdTrmWztEYIGIPwEu9xREm54ljr8nBSzLJLBEZbF
         EVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790583099; x=1791187899;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WpISsSMTyY1axSmV/f4lSLSIYTVX0V5UWy41/GPiWhQ=;
        b=tJeZ/ylhJ6Z8mSYKs56i/EI3jrhEOWvv/NzLOoIakNlrC0Ts7vEjeMouIqVx9taPzR
         Ca2ShGh6yEAcVOofABJDcZ6Rg9oBVjVXLIqmDtSMwvU5k0+HqpxXhBF4zVk98Y7hjQLA
         uQy9GlDtT8WLcLalKC30MABfC68T+upcdIMkN+fQgv/bdW7wwdGCY9YRbEAB+GtfRAR9
         SzfJyFwMvbH1O1iuXRyDjq3+bRZB0qJvwDhbO1AtJvXwBag3G8KMDr8syvbb8wRkqQPD
         4SCH9i5HjYk1scanjE72pFbUiF9775HKRx4PbuSDC0bXT/1b3r+O0yvSN56MEYTrvfER
         mbPQ==
X-Gm-Message-State: AFq9FYJEuHy0V4/vexRyGFrvg7FBZjk3wpkuXR5EBVj4RpYNp7+ZccH2
	cykwTMiRdQy2kIv4HADHsHOAPDsLPEXfjw7QvYojrVLLFO/UyfJedT0H
X-Gm-Gg: AYBFou3r24+pwW5Hbz5vbv31+P2KtN2/pLsHP1aiwQCjowyJ7XcrLDxIrKiZb8dClzl
	RIU/WTu1de4uFyRe4kcv9FTUHBOGbpVs+EBrqjPfhfOlbLao9h16tCVDIKC7Dp1Aav5fb7R2QrC
	bTifqQwPZ+0saajdZ8gVIG7rjZUSwKfdeD1U1JhNqo5cekt4MKC3j8P2NMpdHtoMpcV/5Ej7qcd
	fezTCCnH7l8NxcZzEiBzhpiZCTIhx8Ncz0DCF6/1c5XQoyJTHQOrheU7QeYAkCNc5POosz5PQNR
	tmuVh0nEKBI0KPq2LOXvjguFg7Qhfk8caphfUFOq/tmO12Mhin9ob0FakYk6vvi/BTMQC9vtPP6
	I0L72pACcIni1/mN5oXevn4UsDSQa0MMLhe2qcb4hgMitJQrY+djt7p/uEc48G4kTL9U098vaVE
	JnLKS8eCc39lpvy2MyNEwSw8EtdCguiSxHSd0wVDoR625ChwnoOSgNrUKsb/7oZM4EcbzI8Bpw0
	rPws/y3mSAj6Hyyr5paVNEMDz2Pv18fBymiN3thMvRkYmeKvHoCEPYl0F9Lwu1EX4VmN+6ECMBK
	ZJHUR51sFrPOAEzn+bAK+km3i/MGZ7Q3IY03GgaGutRfJZwX07o36p2OEy2zv22XpKDOqTGpOTL
	k
X-Received: by 2002:a17:903:38cf:b0:2dd:86a3:232d with SMTP id d9443c01a7336-2df7dea604cmr72271675ad.8.1790583099211;
        Mon, 28 Sep 2026 01:11:39 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9b4172c8sm33066915ad.65.2026.09.28.01.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 01:11:38 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:11:36 +0900
Message-ID: <m233ut4wxz.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	johannes.berg@intel.com
Subject: Re: [PATCH] um: fix shutdown __inittext access
In-Reply-To: <20260928093934.ca7af44c59ca.I470ece16d176ea704aa6e5767b755055d106da35@changeid>
References: <20260928093934.ca7af44c59ca.I470ece16d176ea704aa6e5767b755055d106da35@changeid>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_011140_258539_080826FE 
X-CRM114-Status: GOOD (  14.00  )
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


On Mon, 28 Sep 2026 16:39:35 +0900,
Johannes Berg wrote:
> 
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Since first moving __init text into the right place in commit
> 8966ed0b2d48 ("um: move init text between __init_begin/end")
> and then making all init sections inaccessible, shutdown and
> reboot crash instead of working correctly, for the obvious
> reason that the functions are __init but run on the way out.
> 
> Removing the __init markers would work in some way, but that
> would bubble through a lot of functions.
> 
> Instead, mark the relevant functions __noreturn (including
> longjmp() since that's now needed so start_idle_thread() can
> be __noreturn), and split out the part of main() that's done
> on the way out into a new os_exit() function that's called
> directly.
> 
> Reported-by: Hajime Tazaki <thehajime@gmail.com>
> Closes: https://lore.kernel.org/linux-um/m24ifc4v6m.wl-thehajime@gmail.com/
> Fixes: a418ab8fddea ("um: mprotect() __init memory")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

thanks, separating the exit path from __init code is much nicer.

Tested-by: Hajime Tazaki <thehajime@gmail.com>

-- Hajime

