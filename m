Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6109D13588
	for <linux-um@archiver.kernel.org>; Mon, 28 Oct 2024 07:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HydMOTERkCBg4kXyFmGssoYwywJwNAdGkunrbPwat6A=; b=G6jjrHONHDcttzntTRR/S/dRmm
	mpbR68H2PfQ+xei99qMrfvTNRT1MZM2bVp/yfuCcO94LNie16JtexUBOBSGzb58WbggMhXVGdHuLs
	e10nUGo1WrWDFZ2SYcapjNN+DIrOhu5T5ja9V7QFEoILatGjKncZ/M90dIGM/WASqygTOc1LqfDpM
	9PQ0O0HemE+sEgIMBos9XmszvmCdAmCZ7HZ2tbABhk/r7VcNeOAzI7Dk5hkq5SxxR3oxFD/W0/qzM
	LDmW03ivSVAqMfxMkISJ5mcURZe+HP27Ah1RFctw0aWc2A9jDIg51rQ8kQxRDGp+YKh4yJNT1Ttyv
	IpHrCrDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5KUf-00000009xR7-0qan;
	Mon, 28 Oct 2024 07:48:53 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5KTM-00000009wyN-3iE3
	for linux-um@lists.infradead.org;
	Mon, 28 Oct 2024 07:47:35 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-71e8235f0b6so2925041b3a.3
        for <linux-um@lists.infradead.org>; Mon, 28 Oct 2024 00:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730101652; x=1730706452; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HydMOTERkCBg4kXyFmGssoYwywJwNAdGkunrbPwat6A=;
        b=gKaoMm4SKfN5JsPEXD4p8AZvYIQIlSraaUXoO2/S3Pd4yjv8K8bGD0tbJIugvwFE1T
         ZJaJXPIFc81gvZmvBQaNMPkOSJXZ759jlBhJgNfKBPUZlL/RWVJgw0bTSs4DQaLxc7OZ
         cm+JwFAyXu2pgUCn0zi6xaz0p47Qch4YlXJbh8h6hofw+mWNzoubFeLVGXbtVZ/XFsXw
         W380EVXb31Pj3Bxx6JLgG4VE9s1cRb0/VtRmHgEp+LAxH8hkhk7mXS4rULKJFZ0dq7j/
         hpUIaCqXxvJ0plI/u1BcyygIU+IQ5sOL3adS4EVCMG0hz1ODfznl06StDyKdZzJ8vDcj
         UHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730101652; x=1730706452;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HydMOTERkCBg4kXyFmGssoYwywJwNAdGkunrbPwat6A=;
        b=RjtB/9ptHG7FTerlIm0HC5nEab2subpNKlA0z8w/t2W2Bj7dyeb2n8EIzJIU+hhnO9
         HYSKzQG/jgZet2oMQq1mYKVsXBa4ovvUDhzwnw2gqMblMAh96RxsPADOWv6eavtxsXxJ
         2v84lu8Mp2E4mEMpTeJf5NZT4slzLcFOGVgoMEB0Rm7k6Qhkq3zNzEJsAkySzAYKs9j0
         QNa9F4rsc9rFN+WQxsQdYfCLeIU9YvZ8+dt1cFiBQ7Fi9jswItY3PDvBFvBhwSH+PcnM
         0S5my6LWfiwnQcitfEALb5IROKKAVFq4J12fhY1IOFVFtI31N6E/UI/od+xpuYmINYMK
         ZRQQ==
X-Gm-Message-State: AOJu0YxC74wsa5qNgGGksQxYiHoOFK5BJjM/FewBTPiy7pT5SuufVOGV
	terkw0PRkXIgmX6G7UkTtVP5YYq/o9xQeRu59Mtw7Lq6t7L+qFBk
X-Google-Smtp-Source: AGHT+IHEFeh54/nYZD+jrRIIB+chfxyJ7KsAOAvdRQ7su+6L5468kjszOFaA1GJtp/AB13u+S5UpeQ==
X-Received: by 2002:a05:6a00:2d84:b0:71e:693c:107c with SMTP id d2e1a72fcca58-72062fb8107mr10711232b3a.11.1730101651937;
        Mon, 28 Oct 2024 00:47:31 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a219efsm5159821b3a.168.2024.10.28.00.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 00:47:31 -0700 (PDT)
Date: Mon, 28 Oct 2024 16:47:28 +0900
Message-ID: <m2v7xchdnz.wl-thehajime@gmail.com>
From: Hajime Tazaki<thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	jdike@addtoit.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	ricarkol@google.com
Subject: Re: [RFC PATCH 05/13] x86/um: nommu: syscall translation by zpoline
In-Reply-To: <44b4a8f1eec8fad1a9c7cb293bff9fcf7985cdb6.camel@sipsolutions.net>
References: <cover.1729770373.git.thehajime@gmail.com>
	<2f3537884533232ab2ef2937e392d32736527bdc.1729770373.git.thehajime@gmail.com>
	<75c9b237111431362458ced4c5213b74ca8fcb13.camel@sipsolutions.net>
	<m2r084nxu6.wl-thehajime@gmail.com>
	<6769bac56b1d20233dae036aba2067da3eaf7779.camel@sipsolutions.net>
	<m21q03iae4.wl-thehajime@gmail.com>
	<44b4a8f1eec8fad1a9c7cb293bff9fcf7985cdb6.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_004732_980176_61D6477C 
X-CRM114-Status: GOOD (  22.44  )
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


Hello,

On Sun, 27 Oct 2024 18:45:39 +0900,
Johannes Berg wrote:
> 
> On Sat, 2024-10-26 at 16:36 +0900, Hajime Tazaki wrote:
> > 
> > Originally our patchset had a whitelist-based seccomp filter (w/
> > SCMP_ACT_ALLOW), but dropped from this RFC as I found that 1) this is
> > not the !MMU specific feature (it can be generally applied to all UML
> > use cases), and 2) we cannot prevent a syscall (e.g., ioctl(2)) from
> > userspace which is white-listed in our seccomp filter, thus the newly
> > introduced filter may not be perfect.
> > 
> > the maintenance of the whitelist is also not easy; the syscall used in
> > one version is renamed at some point in future (what I faced is
> > SCMP_SYS(open) should be renamed with SCMP_SYS(openat)).
> 
> Sure, agree that would be awful. However, only kernel code should be
> making real host syscalls, never userspace code, so you should be able
> to filter simply based on address? Since it's NOMMU there's a single
> process and a single address space, and userspace binaries always have
> to be in certain places, I'd think?

Yes, the address which issued syscall instruction should be able to
identify.

> This should be cheap since
>  (a) it's not doing anything with (guest) syscalls that were already
>      rewritten by zpoline (they don't exist as host syscalls)
>  (b) while the real host syscalls made by the kernel would still be
>      checked by the filter program, it'd just return "sure that's OK"
>      and not redirect anything

totally makes sense to me and the filter is nice to have.
I'm going to investigate to implement it as a seccomp filter.

thanks for the idea,
-- Hajime


