Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1473CE79A9
	for <linux-um@archiver.kernel.org>; Tue, 19 Sep 2023 17:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y6xeUXCB731hV8ALRmgdUBPZkm8C2g90vx1sFM/wPVo=; b=iDO4OD445Qb8KW
	UAlr5Ff8yF3cDpombFGsw96y2J59Dy4ow4vER74ZkoAokDQI7sP/eD4IE7C32u+2oCRjdMtwSSNem
	+N1Wytn0zIWZizs6YS68F0VLz0BmbIuO6i7qF4wB2g4z6qGksIyshK026axfnkyPpZINJTdpM5z9I
	DfiDsGp3HBppMtxi3w+sxW7awPazXUqm7JpPxs0nnqgc3r+hXom465kCpFOrrkATWyVPWOJMbXion
	1h49bsD33FsYUv815qIluTqnOmfDuyBX4ofQa1S122ge7x3jxtB+Vu3Edl7nv6ivGp41yoNzhQmPJ
	GXlgqamATJ757BSiFb6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qieU6-000w6W-0q;
	Tue, 19 Sep 2023 17:26:02 +0000
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qieU3-000w5s-0f
	for linux-um@lists.infradead.org;
	Tue, 19 Sep 2023 17:26:01 +0000
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50309daf971so4875349e87.3
        for <linux-um@lists.infradead.org>; Tue, 19 Sep 2023 10:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695144355; x=1695749155; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PUjFUwCVE5/xUduoxjL7lC1W3crAzRPXEbwf2O/yhew=;
        b=PeuvhZt6lgy/ZwYPOcdNYms+vDI/AWdsKvd4xjjEkvXATRb8/jBBe3rOyRXd1fZ4Uf
         TlVcBkoRqHHDbe8OZHkoggzFQtsbvyAvPkgio3sUNh9BDoBhzhdomiKtChepRkXu+T1M
         oTTBA/0BO2foKPFjOb+Bva6PPZw2M8GWaPeUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695144355; x=1695749155;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PUjFUwCVE5/xUduoxjL7lC1W3crAzRPXEbwf2O/yhew=;
        b=MuBeNsTYZNX7TyI1RRXb7iGqTPh8PmwctpwUxqNIu1DfOzzu1wZUW+pKaE04YcYJ4J
         pvs46v9DR1fysVCu40LrnMjT1s+AKympdNHkMhu1bMMqtZbPRhLY6BOMuZ9ePjDVkg2G
         zJK/Q41h74agGBWVsAoDq/cwShiTFvvENEcymMoMmXu38pPfPXToTSpSfcYa3K1ticm/
         /BDjrxsPK8J2Q3ePm713d/fasF7OqS7kpbISwBQBliXxdIi60iRJ5bHkpiNjbS0bPrnT
         gYD+IENCfNp1LnGRW9GSChz1OwVkkTuTGi77qKC8ziM8xYCrWhwO6ZcB73Iyu7nBnY8I
         qNqw==
X-Gm-Message-State: AOJu0YyYyqGIscEe+4igKVdrh103LuJeWcfHkGsJ+XaiQ0tHk11+H/rn
	qbYmDNtaoGfwajMGg1K2kZM/cjTNHhMUQ3lNkkh685pR
X-Google-Smtp-Source: AGHT+IHP8RRhSK5GDcf/wAsIBSaQiYX7RIQ0g/UQxlCVwVJx9p3/TTY9TbrwoWuOf8wLCgc0mazg4g==
X-Received: by 2002:a05:6512:ea1:b0:503:ca:7b4c with SMTP id bi33-20020a0565120ea100b0050300ca7b4cmr372951lfb.8.1695144355254;
        Tue, 19 Sep 2023 10:25:55 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id fi26-20020a170906da1a00b0099bc8db97bcsm8029717ejb.131.2023.09.19.10.25.54
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 10:25:54 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-31dd10c2b8bso5586064f8f.3
        for <linux-um@lists.infradead.org>; Tue, 19 Sep 2023 10:25:54 -0700 (PDT)
X-Received: by 2002:a19:e04b:0:b0:4fe:3724:fdae with SMTP id
 g11-20020a19e04b000000b004fe3724fdaemr269206lfj.66.1695144333866; Tue, 19 Sep
 2023 10:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <87zg1u1h5t.fsf@oracle.com> <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net> <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net> <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx> <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
 <20230919134218.GA39281@noisy.programming.kicks-ass.net> <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
In-Reply-To: <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 19 Sep 2023 10:25:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgUimqtF7PqFfRw4Ju5H1KYkp6+8F=hBz7amGQ8GaGKkA@mail.gmail.com>
Message-ID: <CAHk-=wgUimqtF7PqFfRw4Ju5H1KYkp6+8F=hBz7amGQ8GaGKkA@mail.gmail.com>
Subject: Re: Arches that don't support PREEMPT
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ankur Arora <ankur.a.arora@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, 
	akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de, 
	rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com, 
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, 
	jgross@suse.com, andrew.cooper3@citrix.com, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, 
	Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230919_102559_274009_D641631B 
X-CRM114-Status: GOOD (  15.21  )
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

On Tue, 19 Sept 2023 at 06:48, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> As Geert poined out, I'm not seeing anything particular problematic with the
> architectures lacking CONFIG_PREEMPT at the moment. This seems to be more
> something about organizing KConfig files.

It can definitely be problematic.

Not the Kconfig file part, and not the preempt count part itself.

But the fact that it has never been used and tested means that there
might be tons of "this architecture code knows it's not preemptible,
because this architecture doesn't support preemption".

So you may have basic architecture code that simply doesn't have the
"preempt_disable()/enable()" pairs that it needs.

PeterZ mentioned the generic entry code, which does this for the entry
path. But it actually goes much deeper: just do a

    git grep preempt_disable arch/x86/kernel

and then do the same for some other architectures.

Looking at alpha, for example, there *are* hits for it, so at least
some of the code there clearly *tries* to do it. But does it cover all
the required parts? If it's never been tested, I'd be surprised if
it's all just ready to go.

I do think we'd need to basically continue to support ARCH_NO_PREEMPT
- and such architectures migth end up with the worst-cast latencies of
only scheduling at return to user space.

               Linus

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
