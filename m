Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2916ACE79AB
	for <linux-um@archiver.kernel.org>; Wed, 20 Sep 2023 07:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nCzdxdxlUwoDEb5zqvZn5lNUKdFngirQXYmkZ919FaA=; b=CQJSV3Kp/zir71
	nG/dD/JGYX3bRtQgnL0rJYQuUXpXQvCEftdD7/t7oqlmQB11TWysaIfRc8r154eYZVC9HcH4MfVZ/
	EgpKObu7eQTBElcirQhPOaV8OPMWejso4uK5JopFhW5ecimlFayqaIKCfknt1VKtnWAQk0+l3fc9Q
	ggxaygBXMbh+bpD8WsOb3c66gVmkcv7za5ljUDTwk4SHZ0w3AVnVr72brLqMin6dMcJ+FDcLUTjRV
	+p3y/M6mt0jicnFK03wOlq8y24OE2dvK/0qYffYa+zFeDS0HVEKX2v5I6Hc1TarGJBxqWTKk87f8d
	PH8KiyHjN+Fct4kD2Tow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qirhX-0028zo-2K;
	Wed, 20 Sep 2023 07:32:47 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qirhV-0028ye-0F
	for linux-um@lists.infradead.org;
	Wed, 20 Sep 2023 07:32:46 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-401ec23be82so69882105e9.0
        for <linux-um@lists.infradead.org>; Wed, 20 Sep 2023 00:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695195162; x=1695799962; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jWzgC+PpnfmZJpwJToZon+LX7cLfjuMVcroIeSc6zGs=;
        b=XxkiSmiM1FLmMGmUxLArXSP4sQEU+V/4tVvz5M/FMxyiG7rV9ciNWE9M+S5SeXaejF
         1Wwsw/87bKyks1kP/O6zJdAfAkFZ0AV16aafLDA5XfOb+4E6SITOHDBhxaeFcMNS4RNN
         lzjmj5/X2U8jb3kwRrGtn7gBQfg5w/7OFDDyMebvy64OhL+5Gdb0Tmbvr0FozwgItBET
         W3k21onDGjzfsxaUEyjaU352bPbtePfnfLWNvmV2I4LebIaHNceccyRHZFP0pTO69dpz
         vO1N/CHIuC7z/FURdVhSo9L7Yz3vivNx+LP6GtCrGrFuzQTbhrICj6JKDMjG/jKQwmk5
         jlug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695195162; x=1695799962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWzgC+PpnfmZJpwJToZon+LX7cLfjuMVcroIeSc6zGs=;
        b=jcfxvPJX04CyDjdf+0zI68fmXfycB1rmgRVd/sleHQVYuHab0w6iytLVlQSXltavSD
         xgoE4bw9X2mRdemjI2sHlK8stq/FW/gmfK3fZND6KUEU+l1JOmN8mZsh3RtLfBF9dHGu
         fLniU6YU8jhUa1qDG6TfgnpfZp5ZksIV8aN09S5obMC0Y8GzPUi8S2iuZxH+uLMOsV/U
         q1fADbtVjQBgXDu9fNeFHdxSM4BA14wp0ysM/m2fqDz8NNzDwZL4FAu3tgH0OKoIEFAV
         Dx8o0SZCtODdKrC88E7tvdh0BkJhdyXaQ84ngFglgqkUs4vw51jU1MiVYXRy7cpPtbAJ
         7Fyw==
X-Gm-Message-State: AOJu0YxTKnHX3cc9NoYSTqe9Tfav41YVWzXyD6p9tFtAK2N4Qxb+aD95
	e9cYmN+hu5Nv5dhRF6MScpI=
X-Google-Smtp-Source: AGHT+IFlh1qPrteRsulMqGbbOgPwlxP6U162lurEOGcRJRUAWbbb9DGlfVvYxyhGzmU9ONgAgb+Ukw==
X-Received: by 2002:a7b:cbc5:0:b0:3fd:30f7:2be1 with SMTP id n5-20020a7bcbc5000000b003fd30f72be1mr1579415wmi.39.1695195161611;
        Wed, 20 Sep 2023 00:32:41 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id h4-20020a05600c350400b00402f713c56esm1165817wmq.2.2023.09.20.00.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 00:32:41 -0700 (PDT)
Date: Wed, 20 Sep 2023 09:32:38 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de,
	jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, jgross@suse.com,
	andrew.cooper3@citrix.com,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org, Brian Cain <bcain@quicinc.com>,
	linux-hexagon@vger.kernel.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: Re: Arches that don't support PREEMPT
Message-ID: <ZQqgFpA6l1eK1KKV@gmail.com>
References: <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx>
 <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
 <20230919134218.GA39281@noisy.programming.kicks-ass.net>
 <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
 <CAHk-=wgUimqtF7PqFfRw4Ju5H1KYkp6+8F=hBz7amGQ8GaGKkA@mail.gmail.com>
 <87pm2eui95.ffs@tglx>
 <20230919143816.1741760a@gandalf.local.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230919143816.1741760a@gandalf.local.home>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_003245_112170_556A7130 
X-CRM114-Status: GOOD (  14.04  )
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 19 Sep 2023 20:31:50 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > The removal of cond_resched() might cause latencies, but then I doubt
> > that these museus pieces are used for real work :)
> 
> We could simply leave the cond_resched() around but defined as nops for
> everything but the "nostalgia club" to keep them from having any regressions.

That's not a good idea IMO, it's an invitation for accelerated rate bitrot 
turning cond_resched() meaningless very quickly.

We should remove cond_resched() - but probably not as the first step. They 
are conceptually independent of NEED_RESCHED_LAZY and we don't *have to* 
remove them straight away.

By removing cond_resched() separately there's an easily bisectable point to 
blame for any longer latencies on legacy platforms, should any of them 
still be used with recent kernels.

Thanks,

	Ingo

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
