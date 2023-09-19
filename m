Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29763CE79A9
	for <linux-um@archiver.kernel.org>; Tue, 19 Sep 2023 18:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qZMOYt/XNK7V9ZGfgcqkwPe5w8jCwGIuYh2UzMH4F6Q=; b=0gtUDwqOH6lwrv
	TgPmz0YINRsJ2CEeCZaKzTPVTKATDSOuaf0fDgehRf7eBCV2yd1Mjg7z9uJxZ2B2jIc6ONasvyZWC
	qf8ObyNuyBUUs6dBpJeGsXHKtw6QKFMcveGR0kPRc6OdRAbrCd/qDJQaH7gDxOPSMJfSL+D3p4Ozl
	GIVsvZx6/ciIE/D6Rq7gulQ5q0NStu7Vr4IgQiz5LsmGvYVmHNHLwtU3ux5jDmwpafObUWD7k2/L9
	j2r+hYTfURjrL1oLDUL4KSsvAjZ393yDIItaeMDeGMNUM2gq+lB9/yhQy9hvo+HD2OziVQ0mkdb6u
	GX2erUQO2RJzojq/NS3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qifqM-0016ZJ-0d;
	Tue, 19 Sep 2023 18:53:06 +0000
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qifqJ-0016Yh-0w
	for linux-um@lists.infradead.org;
	Tue, 19 Sep 2023 18:53:04 +0000
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bff7d81b5eso52252801fa.0
        for <linux-um@lists.infradead.org>; Tue, 19 Sep 2023 11:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695149580; x=1695754380; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qoumeRTE+qtQQI/kZW10ezE5GjBnHd3+HNtP5YPVTpo=;
        b=ZOQo5jICghLvDPsTjJ7jy37PY+OP4IKUPcRcOrXQwrPTAnO5jUKsLAwgKFn5Nn80Uj
         UBQSi42oBMV68lsz4gIdQGwiWiQfkpgilybdy0DfqacdPd+HTHHMp0aSqdwhzNZW7Ug2
         M7RUdt1k71I6axzwKdNsRJoJuJheCOE5pn4Zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695149580; x=1695754380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qoumeRTE+qtQQI/kZW10ezE5GjBnHd3+HNtP5YPVTpo=;
        b=RElRyPDAutdvNhHg1TfkcKS6Qd0C2c06fsXYgQ/x9Eo1U70+lxZ2197nzd6JnTZ8fA
         EseRdwUAbu0ECKLzMKYlVCJy3I0Ci22Kpjjv6pKRIyaOhHHf960RPM4GMb3qiIU2w39h
         97soaLRjZ1UOZizFbQToLu//UpTm1Ud/JqkhI62Y7Ip/1h1qbNlm38ci3f0/INt1Fw8L
         cfHpERUxQ2VVn+W7qMU8RNnCxHj+jfhLCFiajZg18zoJ65Nqu33/VE/CFBWZALUM0ODY
         MQ0gY/B/QGyDxdyXxRRGNPpeSu97OtI0vgMOdoFLer0G78luvcgBpsefd0Qay/BXBjyr
         C6bg==
X-Gm-Message-State: AOJu0YzJVmTYaCL1n5wLs/9hAx+KUWCKVUifV/gUvFzDMTVP9iOQ5QGM
	OQipQjohDHF5SnOoZhpHCJIwPW3L+sIcsCh31atakcA2
X-Google-Smtp-Source: AGHT+IH1a0BKN76oDD4TbyNtGLgCGWYerflR90IVBs2DlPdeIbWlpSVMODSXboxCBV3BFC0C5Kf8qw==
X-Received: by 2002:a2e:9317:0:b0:2c0:293c:ad12 with SMTP id e23-20020a2e9317000000b002c0293cad12mr192354ljh.17.1695149580357;
        Tue, 19 Sep 2023 11:53:00 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id ks21-20020a170906f85500b0099b6becb107sm8283239ejb.95.2023.09.19.11.52.59
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 11:53:00 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5315b70c50dso2437475a12.2
        for <linux-um@lists.infradead.org>; Tue, 19 Sep 2023 11:52:59 -0700 (PDT)
X-Received: by 2002:a50:fc0e:0:b0:532:e71b:5ead with SMTP id
 i14-20020a50fc0e000000b00532e71b5eadmr258934edr.32.1695149559235; Tue, 19 Sep
 2023 11:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <87zg1u1h5t.fsf@oracle.com> <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net> <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net> <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx> <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
 <20230919134218.GA39281@noisy.programming.kicks-ass.net> <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
 <CAHk-=wgUimqtF7PqFfRw4Ju5H1KYkp6+8F=hBz7amGQ8GaGKkA@mail.gmail.com>
 <87pm2eui95.ffs@tglx> <20230919143816.1741760a@gandalf.local.home>
In-Reply-To: <20230919143816.1741760a@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 19 Sep 2023 11:52:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wizB-G40OxALNnz3-uNxuEAPf95H9hubAPeG2r2mrhwHA@mail.gmail.com>
Message-ID: <CAHk-=wizB-G40OxALNnz3-uNxuEAPf95H9hubAPeG2r2mrhwHA@mail.gmail.com>
Subject: Re: Arches that don't support PREEMPT
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Peter Zijlstra <peterz@infradead.org>, 
	Matthew Wilcox <willy@infradead.org>, Ankur Arora <ankur.a.arora@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, 
	akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de, 
	jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com, 
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, jgross@suse.com, 
	andrew.cooper3@citrix.com, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-m68k@lists.linux-m68k.org, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-um@lists.infradead.org, Brian Cain <bcain@quicinc.com>, 
	linux-hexagon@vger.kernel.org, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230919_115303_327779_85F28B97 
X-CRM114-Status: GOOD (  10.52  )
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

On Tue, 19 Sept 2023 at 11:37, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> We could simply leave the cond_resched() around but defined as nops for
> everything but the "nostalgia club" to keep them from having any regressions.

I doubt the nostalgia club cares about some latencies (that are
usually only noticeable under extreme loads anyway).

And if they do, maybe that would make somebody sit down and look into
doing it right.

So I think keeping it around would actually be both useless and
counter-productive.

              Linus

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
