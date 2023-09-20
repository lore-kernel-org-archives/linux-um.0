Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6209CCE79AF
	for <linux-um@archiver.kernel.org>; Wed, 20 Sep 2023 07:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BtGaYwJVgPxSiQdHd5eRs6bV+Phy4D65BcT8OIrcFiI=; b=myEP8FtJqCoYFB
	lq//Qtxt3+4kDn7wQ3SjaEuKs4p90q1PDCeqBPgJ56mOauDSDK18ewHkAgaB4SP0dtM8Qtf9O59Gq
	+oC5DTwyq1v91THy2PefjgJBLb+JP1gxMK0ZVb9fwiqeIOu3RGJklQ+pgdVc0dF3Zbm7fLz7GAsUy
	W5JBPg9cC0T+GEQFFco0paAKzjNYbnH39kKbdYc/a562yM0v5lZqnHm6wTRyvRLDIwzcMzuHgK4N9
	Q5DxacQExELbVdDKSXlzI6twzyWXnZNQ54injfyI42SSvWxaXUyezlTDSymohRwN7iBSdmkEouPzn
	E8/Ha/52XDfoQoBx7SjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qireM-0028gI-2q;
	Wed, 20 Sep 2023 07:29:30 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qireK-0028f5-2Q
	for linux-um@lists.infradead.org;
	Wed, 20 Sep 2023 07:29:30 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-404732a0700so66871235e9.0
        for <linux-um@lists.infradead.org>; Wed, 20 Sep 2023 00:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695194965; x=1695799765; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9FUmFWGdaoCCAX+yBYd9oidTjhPdRU5Hczc1k2R6GM=;
        b=XdjgZCgTfqYmkQ8D4Tc7BGZHKETb5R+f2J7h8vCy6Wz+Zimwy6MNixns3OIxonV7jd
         hQvPzES9CVal8ULfxyZeE8J77mwcDTaqPUHj1VYktLpLsppeGTC3ClxN1s93MwI6EaOy
         9+GNXtyDTM2xfYjHl8QP44MCFXiKp18D86GnDbalUnoBkWJYLn30kOnfBppU8DPIISqi
         qg6pOQK0O0wvpatTLyaBkXybBLYwPaFaxBIdwD9076y5HA0JwjBx/hWlyvRrZjn+LpNQ
         3qClgzxPaJ2AJQexjoSJLUzlzCMuIEgAvMh2329IY8lDwKz6iWVtNtwle38cbaHuGxvj
         kvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695194965; x=1695799765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9FUmFWGdaoCCAX+yBYd9oidTjhPdRU5Hczc1k2R6GM=;
        b=WMs/5SdIRp73EGdQ1p0vw9V5DRKne9kLHWoNg5iBCIr/ltIVzWT4T9NP4znxuEAEX5
         ntRUgGV/JOkQMVHD/at+F5Q7AzZmCcothx8OXw8pIWZWuKDBd8iZIez8jmRU/YUvSdBw
         +DgCThIWx/04q3oCVJ/8Y+6/X8xSPVym9c5rjehKNhxRfSSuN0oqKvxXCB97V5OoseVL
         mshyw/J34RZSp0dtcxheC+HzF+9ZKqtAXSHKklJM+5C81Bti3NIVUEy9UOvKwmEWgL91
         vOg63iFKYepZ4KwMxWvoZdj5Z845Yant+2Awed5QDHBzyvCJilQ2JkkscDOC/GMsXKUf
         DPMA==
X-Gm-Message-State: AOJu0YxTeGA6+fAvOWwEixniWD9RSiwdo10ovQ6CCdn0DgQBhgmyjq6i
	jJKin+Y08DOThokpcd47mdU=
X-Google-Smtp-Source: AGHT+IEpVnT/Cd2oEohbdKSMFoVqTb9dtDqJrcJ42h6au+YxgKEXvw3MWUudbGLbWXtUB4DWJ+z6pA==
X-Received: by 2002:a05:600c:152:b0:404:2dbb:8943 with SMTP id w18-20020a05600c015200b004042dbb8943mr1805727wmm.2.1695194965229;
        Wed, 20 Sep 2023 00:29:25 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id t19-20020a7bc3d3000000b003fefca26c72sm1136535wmj.23.2023.09.20.00.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 00:29:24 -0700 (PDT)
Date: Wed, 20 Sep 2023 09:29:21 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de,
	rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com,
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com,
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
Message-ID: <ZQqfURDGaXQdTzZS@gmail.com>
References: <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx>
 <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
 <20230919134218.GA39281@noisy.programming.kicks-ass.net>
 <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
 <CAHk-=wgUimqtF7PqFfRw4Ju5H1KYkp6+8F=hBz7amGQ8GaGKkA@mail.gmail.com>
 <87pm2eui95.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87pm2eui95.ffs@tglx>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_002928_786792_7A4A296E 
X-CRM114-Status: GOOD (  32.81  )
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


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Tue, Sep 19 2023 at 10:25, Linus Torvalds wrote:
> > On Tue, 19 Sept 2023 at 06:48, John Paul Adrian Glaubitz
> > <glaubitz@physik.fu-berlin.de> wrote:
> >>
> >> As Geert poined out, I'm not seeing anything particular problematic with the
> >> architectures lacking CONFIG_PREEMPT at the moment. This seems to be more
> >> something about organizing KConfig files.
> >
> > It can definitely be problematic.
> >
> > Not the Kconfig file part, and not the preempt count part itself.
> >
> > But the fact that it has never been used and tested means that there
> > might be tons of "this architecture code knows it's not preemptible,
> > because this architecture doesn't support preemption".
> >
> > So you may have basic architecture code that simply doesn't have the
> > "preempt_disable()/enable()" pairs that it needs.
> >
> > PeterZ mentioned the generic entry code, which does this for the entry
> > path. But it actually goes much deeper: just do a
> >
> >     git grep preempt_disable arch/x86/kernel
> >
> > and then do the same for some other architectures.
> >
> > Looking at alpha, for example, there *are* hits for it, so at least
> > some of the code there clearly *tries* to do it. But does it cover all
> > the required parts? If it's never been tested, I'd be surprised if
> > it's all just ready to go.
> >
> > I do think we'd need to basically continue to support ARCH_NO_PREEMPT
> > - and such architectures migth end up with the worst-cast latencies of
> > only scheduling at return to user space.
> 
> The only thing these architectures should gain is the preempt counter 
> itself, [...]

And if any of these machines are still used, there's the small benefit of 
preempt_count increasing debuggability of scheduling in supposedly 
preempt-off sections that were ignored silently previously, as most of 
these architectures do not even enable CONFIG_DEBUG_ATOMIC_SLEEP=y in their 
defconfigs:

  $ for ARCH in alpha hexagon m68k um; do git grep DEBUG_ATOMIC_SLEEP arch/$ARCH; done
  $

Plus the efficiency of CONFIG_DEBUG_ATOMIC_SLEEP=y is much reduced on 
non-PREEMPT kernels to begin with: it will basically only detect scheduling 
in hardirqs-off critical sections.

So IMHO there's a distinct debuggability & robustness plus in enabling the 
preemption count on all architectures, even if they don't or cannot use the 
rescheduling points.

> [...] but yes the extra preemption points are not mandatory to have, i.e. 
> we simply do not enable them for the nostalgia club.
> 
> The removal of cond_resched() might cause latencies, but then I doubt 
> that these museus pieces are used for real work :)

I'm not sure we should initially remove *explicit* legacy cond_resched() 
points, except from high-freq paths where they hurt - and of course remove 
them from might_sleep().

Thanks,

	Ingo

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
