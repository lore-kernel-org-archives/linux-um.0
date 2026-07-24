Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C8CC531FA
	for <linux-um@archiver.kernel.org>; Fri, 24 Jul 2026 07:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=deZPOYS+3CqcsOVwQlHi7pBO7wO0tbrlEp3bZJ4fioI=; b=h6w/kMVhvRPQUZP3DycSohfva3
	2ZzECyvYKFc7H7F4k/iCMjElEZlTYyDTUrU4A47qCCbhjSYjqnGudDvH/jGN/QqirZEDC9NVlvikC
	7XpNCFCXh5xsXETguQJ1rBNvgq0DCv6IVdYzXxu3W2PzEjDUaYhh+z52x6JLfVi1++NdLb4JCGrrN
	YelVCerj0F7L5TVW/MirBcL5XO6EOZO1Z+5iapvcovYIk9P9QdaFlhhWJmQ4V9QPBZ0Co55tCroxU
	9mE9mSfVeroyCzK5CAAEuGeHfSru+BV3bpJFDIr3cqOHOR39y3bVfUvFWemXHe559MF+bU14DGTZu
	bwbVyoXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnA9S-0000000Ffu0-1rXB;
	Fri, 24 Jul 2026 07:16:58 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnA9O-0000000Ffta-3Y3B
	for linux-um@lists.infradead.org;
	Fri, 24 Jul 2026 07:16:56 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so77682b3a.3
        for <linux-um@lists.infradead.org>; Fri, 24 Jul 2026 00:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784877414; x=1785482214; darn=lists.infradead.org;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=deZPOYS+3CqcsOVwQlHi7pBO7wO0tbrlEp3bZJ4fioI=;
        b=PIivdobDbBZYlmhls1tnzgWmjIQLnKnEBQ+PbEzAOJmTYkePUSz+Jp/ZWJrBwORELL
         IVCx4ISeXQixxSfNi1XIPB52lxrSyNxWCSQ1CpXECOdS73Du0l5Td0sAvoM4vQy1RYfy
         gxBK4+hKxwOpqiH96njUq3n54IAFdmKJfVVrePqcmNMAZzLfyCGqeb8XQeT9ssgFzrI/
         qrDzpaxQcS5w9qoMGGJ5Zx0bjtE2ZySkzWd4KKAe2L451qVNcOUr6SceROy/lIQ/QaRu
         Fd1U709+W28fAJ/VSSC95Exu374pxnH9HTc++wJLqQoT/tpsxqeLH+vpxk744eI74Czw
         iCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784877414; x=1785482214;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=deZPOYS+3CqcsOVwQlHi7pBO7wO0tbrlEp3bZJ4fioI=;
        b=pJRBi/aDXlxYGSSYuFHgitOAcLdGUTzqzKrJcX7GTn49wHr63QLzGN+dUpP6k4W/I5
         u4y3fd1cgM2PDaskCDEtZuqKR4B6ABuwQTDQ8k0QdINlzrJ++v76/Vzm51TOVFZaAmZ7
         SJoj937edQEefHcMhA82ozhubWXftMY43L1BbIMY7JoXb1QFgi2hZe2fY4FpNfG4Jmbi
         V2k2ixifRubU0VRDSOjlOPRzmnIBw6BDm+9cu3LArnnkBM1Mk/Faw/NP5NaZTPzgCqhc
         MnMMxWfWEXAmqSzMOGL3K9eXKvm9Z0/ggBbv0tzDfIQa//EPn4r5eg1VxnWnbu4X8+Tl
         jL1w==
X-Gm-Message-State: AOJu0YyJbCFiiQGP61XvoD2gnqD+0wwRfQXe/q2tWh6Vz0XPcVpILfk4
	8zFIH6wlclWwBHfEIiX7/G8Al75j89OdweMjWA3BpcTuwh7z66c693Kd
X-Gm-Gg: AR+sD137ewgOJbaaKuWJSxkLgQoatRJKWGLrUUfY45xo9sA0Siuft85eGAOlQSsB+cu
	F1Hw2LStOECJcHWqKLtjkC8Qj8B3MG0Tepg1Ka+GKeGwRTd6BIuqWogGuwGgJVX69asu4nHF/3w
	GVTzN+oBgrNcJgUEVD53vO8Oz1CN8xGizM7Y6HZkXblJIV9PVgZExXG4CsWYiNJPXa1K+/5DuNS
	F1+weEOEKRxHlA6zVLL1cQUms+SK17C79S0S6/c84Lqads1esAEmXCXm5m+pCU5FoIeWkTn1DEa
	couqyjHHDHvpVwQSyj1kyGs9+UMaNgtUd4bH2K98PqHRdyCACK52UF8RX8+cWdR4GaVrUrN/HyP
	LUfyfCyDvbHJ82gj5AEv4lPXyzaH+u3BzvOgS5v6vNIckDt/h2ZcCvpu8U36DUbgVF5xa5jV6YK
	BjJ8SMWBPugetQk/bf4Y23QxRDN0ErsaQQU0zLQ3dP6ZkIDGKnl85If7B5BO0QIGbvKCSEw7iy5
	VCgdv95O7xULVCn0tcKAJ0yDkbuFCY=
X-Received: by 2002:a05:6a00:b55:b0:848:2f74:1d5e with SMTP id d2e1a72fcca58-84e2bbecd3bmr7181570b3a.68.1784877398708;
        Fri, 24 Jul 2026 00:16:38 -0700 (PDT)
Received: from jupiter.local.gmail.com (179.62.31.150.dy.iij4u.or.jp. [150.31.62.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e172376ebsm4324439b3a.12.2026.07.24.00.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 00:16:37 -0700 (PDT)
Date: Fri, 24 Jul 2026 16:16:36 +0900
Message-ID: <m1bjbw97sb.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	liam@infradead.org,
	ljs@kernel.org,
	ricarkol@google.com
Subject: Re: [PATCH v2 04/10] um: change machine name for uname output
In-Reply-To: <c5c1a16d1be4658e2f797b21fdfe5f4dc3d9a168.camel@sipsolutions.net>
References: <20260723093633.140989-12-johannes@sipsolutions.net>
	<20260723113633.bcaf234695c5.I226381aaaf6dd46c559b0e694b29370d0102ce3f@changeid>
	<m1ecgs9908.wl-thehajime@gmail.com>
	<c5c1a16d1be4658e2f797b21fdfe5f4dc3d9a168.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260724_001654_894859_804DF748 
X-CRM114-Status: GOOD (  21.74  )
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


On Fri, 24 Jul 2026 15:54:30 +0900,
Johannes Berg wrote:
> 
> On Fri, 2026-07-24 at 15:50 +0900, Hajime Tazaki wrote:
> > On Thu, 23 Jul 2026 18:35:45 +0900,
> > Johannes Berg wrote:
> > > 
> > > From: Hajime Tazaki <thehajime@gmail.com>
> > > 
> > > This commit tries to display MMU/!MMU mode from the output of uname(2)
> > > so that users can distinguish which mode of UML is running right now.
> > > 
> > > Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> > > [remove / to fix regression with systemd userspace]
> > > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> > > ---
> > > v2: regression fix
> > 
> > I'd like to know what kind of regression did you see.
> 
> With your original change, systemd doesn't boot, it asserts here:
> https://github.com/systemd/systemd/blob/main/src/basic/architecture.c#L136

thanks,

> > with only this diff, there is no visible changes with uname command on
> > UML (both mmu/nommu), as setup_machinename() overwrite this.
> 
> Oops. I never tested it, sorry. Just saw the boot failure with my
> standard 64-bit (and maybe 32-bit as well?) boot test filesystems.
> 
> > maybe we could drop this patch if we cannot put a name 'um' in the
> > machine name ?
> 
> Sure, we can drop it. Or arrange so only nommu is different? Or even
> call it SUBARCH-nommu?

systemd detects UML via systemd-detect-virt, not `uname -m`:

https://github.com/obbardc/systemd/blob/master/src/basic/virt.c#L298

it looks like it uses vendor_id field of /proc/cpuinfo.
I guess they are right.

my original intention for this patch (to uname output) is to avoid
confusion (of myself) which UML (MMU or NOMMU) I am running so, it's
purely a kind of debugging purpose.

I think we can drop it and come back later if we really need to
provide a way to detect nommu UML (probably extending show_cpuinfo()).

-- Hajime

