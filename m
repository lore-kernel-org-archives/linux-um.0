Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B62D10BEB
	for <linux-um@archiver.kernel.org>; Sat, 26 Oct 2024 07:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/WqXfrIeQHo/rAQSX2yuRVUGXcb7mNP1J4AFSfm4lKA=; b=tfRI7ZE3vlOJi0oG6sM2H3d+KQ
	rp1dJ3fNizT6gahfC47UpAUWO5F072XyJbbNq284u9giFbzcahNTkNG11Bg15M8mFHZWOJpKb8Cr8
	NkLNjOtV3mwL59mj7rF74EMuhBihwFmcnIBhDNZiRtzkdSotEpD57c4wJ9x6XZs7hwH649d4tVd6n
	hSNmhLpnWB4eb8sHr2KyYmty67LIEtCTcWiMiE175zGBnCB5+MUwrbc5nb930kv07ckkuUGSU/F2v
	3y3WfLFcGkmDiOWiUjDqSsoHP99y5oXk9oip4etdpk8cxewICr3iZYIRAfwpPmDdZkjOaMLMj1y8Z
	Kx5BXiGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4bOe-0000000693B-3aCp;
	Sat, 26 Oct 2024 07:39:40 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4bLF-000000068ZH-0xFQ
	for linux-um@lists.infradead.org;
	Sat, 26 Oct 2024 07:36:22 +0000
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-7ed9c16f687so2038802a12.0
        for <linux-um@lists.infradead.org>; Sat, 26 Oct 2024 00:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729928168; x=1730532968; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/WqXfrIeQHo/rAQSX2yuRVUGXcb7mNP1J4AFSfm4lKA=;
        b=Mj5o4LBU0NrGNSvtLvsyR58cIIehd4yJG79NLQ5gP4596FnJULkuiYHHw/2e0Ne63G
         Km4fNa2/BK7z23FmVxCfd9ENGnI/ET9sFggi9+/z/sTC7yuaT3NapIJFaMZbHe/NSgg7
         w7kOOAdfNIyFB+Hest+cO2Ir9656XYgvAw5WovO12mzbhMD8xuSPk1oXFjb0DfSNgqTR
         ocUeboDu14qrVyjDp2qH6zh0i5vZocEMEtMFGW8u9VU26vgs99vDwEQ2bPl+zCn30ioj
         MNr2CEEDbgmvCEXNv19vzN1hTrdkKffbPyOkhc4Qpskhde9fr2qYcranOcralGsknq/g
         PGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729928168; x=1730532968;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WqXfrIeQHo/rAQSX2yuRVUGXcb7mNP1J4AFSfm4lKA=;
        b=WxYgpzOxmpzQ+ESfdAXlx0FFVmXOLDwHVTXI6sU1cPfemy0mL9FI1x5AudFpd7pRsb
         QhW4uOJ1i4Lg0+4B4YNnv744Ie9lwztab/VrIWNc8d4se05gMR5pofL2TM5Y1QEmavgW
         ofkDHJJ+QabGl4gA4Sn005W55mb02VsbaL/GAfQf4B5sSM5dYleprPLd273EJo5FZz62
         c8OxADVU5bebkSC8nMxQ0OyNvwZKD6YLj446nU3Hp12RHyd8Vap7lpDjy4lNWEo2db7i
         KhHruA5/s3DPszKxqvsHYVZC29YziTJ2BZbjUWkEbFC3VxZ8n9ZWqqmGD5eBAsl1H5U2
         lR6Q==
X-Gm-Message-State: AOJu0Yx88eAkF0+KNot6TTU9R2WmMHOcvq0BNJ9TkpoMRh58VkgPDmcC
	ja+PSxWpUHeaZ4BUFvp+cau5Ify31WmA+V5+bDZC6PsjA4I1WCl22p/egcr0ZvY=
X-Google-Smtp-Source: AGHT+IEs9CGS6lq1P1XdGwmbK899N+uvOx2rEwvcB108fMcoSQpbR4VDJdXXcsS5lyym9z6/cIEdWQ==
X-Received: by 2002:a17:90b:1650:b0:2e2:d181:6808 with SMTP id 98e67ed59e1d1-2e8f11a96c4mr2709447a91.30.1729928168225;
        Sat, 26 Oct 2024 00:36:08 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e534efesm4724435a91.33.2024.10.26.00.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 00:36:07 -0700 (PDT)
Date: Sat, 26 Oct 2024 16:36:03 +0900
Message-ID: <m21q03iae4.wl-thehajime@gmail.com>
From: Hajime Tazaki<thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
 anton.ivanov@cambridgegreys.com, ricarkol@google.com
Subject: Re: [RFC PATCH 05/13] x86/um: nommu: syscall translation by zpoline
In-Reply-To: <6769bac56b1d20233dae036aba2067da3eaf7779.camel@sipsolutions.net>
References: <cover.1729770373.git.thehajime@gmail.com>	<2f3537884533232ab2ef2937e392d32736527bdc.1729770373.git.thehajime@gmail.com>	<75c9b237111431362458ced4c5213b74ca8fcb13.camel@sipsolutions.net>	<m2r084nxu6.wl-thehajime@gmail.com>	<6769bac56b1d20233dae036aba2067da3eaf7779.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241026_003609_330754_056ECD47 
X-CRM114-Status: GOOD (  32.14  )
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


On Sat, 26 Oct 2024 00:20:49 +0900,
Johannes Berg wrote:
> 
> On Fri, 2024-10-25 at 21:58 +0900, Hajime Tazaki wrote:
> > 
> > > > +	if (down_write_killable(&mm->mmap_lock)) {
> > > > +		err = -EINTR;
> > > > +		return err;
> > > 
> > > ?
> > 
> > the lock isn't needed actually so, will remove it.
> 
> Oh, I was just looking at the weird handling of the err variable :)

Ah, now I see. I'd revert the lock part with `return -EINTR` instead.

> > > What happens if the binary JITs some code and you don't find it? I don't
> > > remember from your talk - there you seemed to say this was fine just
> > > slow, but that was zpoline in a different context (container)?
> > 
> > instructions loaded after execve family (like JIT generated code,
> > loaded with dlopen, etc) isn't going to be translated.  we can
> > translated it by tweaking the userspace loader (ld.so w/ LD_PRELOAD)
> > or hook mprotect(2) syscall before executing JIT generated code.
> > generic description is written in the document ([12/13]).
> 
> Guess I should've read that, sorry.

no no, since this part is completely new feature and I'd like to
explain any unclear points to help understanding, so any inputs are
always nice.

# btw, the talk at last netdev was not container specific context, but
  more focus on the syscall hook mechanism itself so, I didn't go much
  detail at that time.

> > > Perhaps UML could additionally install a seccomp filter or something on
> > > itself while running a userspace program? Hmm.
> > 
> > I'm trying to understand the purpose of seccomp filter you suggested
> > here; is it for preventing executed by untranslated code ?
> 
> Yeah, that's what I was wondering.
> 
> Obviously you have to be able to get rid of the seccomp filter again so
> it's not foolproof, but perhaps not _that_ bad?
> 
> I'm not worried about security or so, it's clear this isn't even _meant_
> to have security. But I do wonder about really hard to debug issues if
> userspace suddenly makes syscalls to the host, that'd be ... difficult
> to understand?

I totally understand; I faced similar situations during the developing
this patchset.

Originally our patchset had a whitelist-based seccomp filter (w/
SCMP_ACT_ALLOW), but dropped from this RFC as I found that 1) this is
not the !MMU specific feature (it can be generally applied to all UML
use cases), and 2) we cannot prevent a syscall (e.g., ioctl(2)) from
userspace which is white-listed in our seccomp filter, thus the newly
introduced filter may not be perfect.

the maintenance of the whitelist is also not easy; the syscall used in
one version is renamed at some point in future (what I faced is
SCMP_SYS(open) should be renamed with SCMP_SYS(openat)).

-- Hajime

