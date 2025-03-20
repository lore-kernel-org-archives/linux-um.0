Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED79C28B30
	for <linux-um@archiver.kernel.org>; Thu, 20 Mar 2025 10:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j11DFSETqOLtc+vMOz1k4rHgXFA118EedepjEdU8Zqw=; b=MHOrIBpNsp+ikl3w0GGaRXBoaz
	XazrDoCE3CPwuPZKVsfFzZ3Ri4PIc4ehoHJSrd6Hquy+3K78s5Oq8ujZ+OplxC+DRThiTjZzGm2rp
	Mtv73+NMrsuVeNSnlsFUSb52wrIDayN7gXEtpWOaePHFjPXLCq+vN8HGZL8h0IsQkcEV6xodqvwwP
	o3cuLC30HoISPQD1GgNYr53uqdHdwNrc0nzuHFZsGeAtWVNjJscAyfTcyS6+too4kjO2bHjPJHNJh
	tipqs/TZpJK1p02rQeO7uqZLXnn31DcTUSFDwGE1dThQqwMhr6RaV5UfT6IEOpOAqHJ5TuuNc13lW
	CMksD+dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvDPw-0000000BqgP-3Szq;
	Thu, 20 Mar 2025 10:46:28 +0000
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvDOE-0000000BqQJ-10Em
	for linux-um@lists.infradead.org;
	Thu, 20 Mar 2025 10:44:43 +0000
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-43d3b211d0eso9419225e9.1
        for <linux-um@lists.infradead.org>; Thu, 20 Mar 2025 03:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742467480; x=1743072280; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j11DFSETqOLtc+vMOz1k4rHgXFA118EedepjEdU8Zqw=;
        b=GS8RrzE2vwAeGIaqR5zLiyJSzd2zaxwuhxrLwkE8WHU1pmJAFltVU/jPwH5g02Ipsk
         /HLtC1YtosNokwMiybWwMxr9RM7ao6QMvMNBmqiXNzSS+j/63tEVfTQ3DeU5fBNLQ0YK
         PB0W0+fhy/gi7pGUTN4MmNOFBfxKWK+Gd3mjQEep0myZuf/9zJC5nPNK+5eafqJdFTX3
         cWHK3/6r1f+ENqqYAzwJvIfO/c7dq+dKev2ORVOlKidpXK0R+AXh/HWMg+eHMxL49ZS3
         4Ca5wf54yWZuj0bfRZ5/rO7u+x+emthzQ4WL3xI/Vj9Qph5opobyDTBaVmt0/uxIW0O4
         Cctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742467480; x=1743072280;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j11DFSETqOLtc+vMOz1k4rHgXFA118EedepjEdU8Zqw=;
        b=gSzyaq2E/3/Vc50dmdUnbjuoSnTOY/G35hL8qFq1JAsf6mqp6ap4mRr6aO+HSxJ9/S
         8E2wt9+BLL31M+VBh+B42lJobQXIkqL1mhqqdn9ioj3Bh1KmLxobS8+6PRfIEaLcdP+d
         RMnrSREIw3WZ54oXTIfhSASM/0FqI/S5mUdFJz7CdTtfoE/Um2UsfRt2Ow+lEEuzqOX/
         o4BHdvGjlIhmUTvGnFrXwzwIZSGQ10koleQUz0SCDbaxW6Piha2Zo76PS3eiQxO5nSPQ
         dNd/HYSon8xrWBulPmvcyCRbgAjhQ3Ull8tpYgV99Oy5+YRWCkJvR/xZturyjU3gn2b4
         9Zuw==
X-Forwarded-Encrypted: i=1; AJvYcCWo3tI8273BLnocrHhm6sGpfyJRH7nKkDdeOW8ZguZrN7NuW5XpgBhRZwmEGeDBEFdXDph2kQa9aw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxY40ErKcNVgNUdA30rqm9aM62qQhtOKiouejy4s2lRgzrpHRPY
	cd5WhyUo0YHQ9K//trFUl92DXqkXVIwRx3mmUNJfPasA9xIugQI3Qo0ntjTwLgeGWfXOtFBCsZl
	1HiqUkTRtXQ==
X-Google-Smtp-Source: AGHT+IHmhdHTuCMOMffmpvyIMCzJObzjHJotMPvb7/CKZriBN1WJ2Qe2CHVhTxdEuiWThlixsbw8H9oOiShQMA==
X-Received: from wmgg15.prod.google.com ([2002:a05:600d:f:b0:43b:c450:ea70])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1da2:b0:439:5f04:4f8d with SMTP id 5b1f17b1804b1-43d49187ba9mr20806165e9.12.1742467480075;
 Thu, 20 Mar 2025 03:44:40 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:44:38 +0000
In-Reply-To: <Z9sRQ0cK0rupEiT-@google.com>
Mime-Version: 1.0
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
 <20250110-asi-rfc-v2-v2-4-8419288bc805@google.com> <20250319172935.GMZ9r-_zzXhyhHBLfj@fat_crate.local>
 <Z9sRQ0cK0rupEiT-@google.com>
X-Mailer: aerc 0.18.2
Message-ID: <D8L164U8HBTB.G5MS86AIISLM@google.com>
Subject: Re: [PATCH RFC v2 04/29] mm: asi: Add infrastructure for boot-time enablement
From: Brendan Jackman <jackmanb@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>, Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-alpha@vger.kernel.org>, <linux-snps-arc@lists.infradead.org>, 
	<linux-arm-kernel@lists.infradead.org>, <linux-csky@vger.kernel.org>, 
	<linux-hexagon@vger.kernel.org>, <loongarch@lists.linux.dev>, 
	<linux-m68k@lists.linux-m68k.org>, <linux-mips@vger.kernel.org>, 
	<linux-openrisc@vger.kernel.org>, <linux-parisc@vger.kernel.org>, 
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>, 
	<linux-s390@vger.kernel.org>, <linux-sh@vger.kernel.org>, 
	<sparclinux@vger.kernel.org>, <linux-um@lists.infradead.org>, 
	<linux-arch@vger.kernel.org>, <linux-mm@kvack.org>, 
	<linux-trace-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>, 
	<kvm@vger.kernel.org>, <linux-efi@vger.kernel.org>, 
	Junaid Shahid <junaids@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_034442_272094_DFEFDDBF 
X-CRM114-Status: GOOD (  34.85  )
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

On Wed Mar 19, 2025 at 6:47 PM UTC, Yosry Ahmed wrote:
> On Wed, Mar 19, 2025 at 06:29:35PM +0100, Borislav Petkov wrote:
> > On Fri, Jan 10, 2025 at 06:40:30PM +0000, Brendan Jackman wrote:
> > > Add a boot time parameter to control the newly added X86_FEATURE_ASI.
> > > "asi=on" or "asi=off" can be used in the kernel command line to enable
> > > or disable ASI at boot time. If not specified, ASI enablement depends
> > > on CONFIG_ADDRESS_SPACE_ISOLATION_DEFAULT_ON, which is off by default.
> > 
> > I don't know yet why we need this default-on thing...
>
> It's a convenience to avoid needing to set asi=on if you want ASI to be
> on by default. It's similar to HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON
> or ZSWAP_DEFAULT_ON.
>
> [..]
> > > @@ -175,7 +184,11 @@ static __always_inline bool asi_is_restricted(void)
> > >  	return (bool)asi_get_current();
> > >  }
> > >  
> > > -/* If we exit/have exited, can we stay that way until the next asi_enter? */
> > > +/*
> > > + * If we exit/have exited, can we stay that way until the next asi_enter?
> > 
> > What is that supposed to mean here?
>
> asi_is_relaxed() checks if the thread is outside an ASI critical
> section.
>
> I say "the thread" because it will also return true if we are executing
> an interrupt that arrived during the critical section, even though the
> interrupt handler is not technically part of the critical section.
>
> Now the reason it says "if we exit we stay that way" is probably
> referring to the fact that an asi_exit() when interrupting a critical
> section will be undone in the interrupt epilogue by re-entering ASI.
>
> I agree the wording here is confusing. We should probably describe this
> more explicitly and probably rename the function after the API
> discussions you had in the previous patch.

Yeah, this is confusing. It's trying to very concisely define the
concept of "relaxed" but now I see it through Boris' eyes I realise
it's really unhelpful to try and do that. And yeah we should probably
just rework the terminology/API.

To re-iterate what Yosry said, aside from my too-clever comment style
the more fundamental thing that's confusing here is that, using the
terminology currently in the code there are two concepts at play:

- The critical section: this is the path from asi_enter() to
  asi_relax(). The critical section can be interrupted, and code
  running in those interupts is not said to be "in the critical
  section".

- Being "tense" vs "relaxed". Being "tense" means the _task_ is in a
  critical section, but the current code might not be.

This distinction is theoretically relevant because e.g. it's a bug to
access sensitive data in a critical section, but it's OK to access it
while in the tense state (we will switch to the restricted address
space, but this is OK because we will have a chance to asi_enter()
again before we get back to the untrusted code). 

BTW, just to be clear:

1. Both of these are only relevant to code that's pretty deeply aware
   of ASI. (TLB flushing code, entry code, stuff like that).

2. To be honest whenever you write:

     if (asi_in_critical_section())

   You probably mean:

     if (WARN_ON(asi_in_critical_section()))

   For example if we try to flush the TLB in the critical section,
   there's a thing we can do to handle it. But that really shouldn't
   be necessary.  We want the critical section code to be very small
   and straight-line code.

   And indeed in the present code we don't use
   asi_in_critical_section() for anything bur WARNing.

> asi_is_relaxed() checks if the thread is outside an ASI critical
> section.

Now I see it written this way, this is probably the best way to
conceptualise it. Instead of having two concepts "tense/relaxed" vs
"ASI critical section" we could just say "the task is in a critical
section" vs "the CPU is in a critical section". So we could have
something like:

bool asi_task_critical(void);
bool asi_cpu_critical(void);

(They could also accept an argument for the task/CPU, but I can't see
any reason why you'd peek at another context like that).

--

For everything else, Ack to Boris or +1 to Yosry respectively.

