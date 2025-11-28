Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EFBD116F1
	for <linux-um@archiver.kernel.org>; Fri, 28 Nov 2025 12:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i0e4sEMhWKJpG15SRogICDaVX6hinUkaKf0qiXuZhnY=; b=mbwuqyK5h89DzoJQcCHWWnT33Y
	AK3lC02nOihtU2s5qL5Lo6KN4v425i1Fve4NiqU97LzevBDQWETqQO7pAv26BO0rDw9QCFs1pVS7y
	UA6IQDds8u9aCvPKOica031mFtDE7nFftqurcWdRzUAC1xNhwjlldOL50PYOTBTt3WKQvhqyVX4j6
	mqPME+3JjZWBVtmHTOE2agVR3+jZdobcD/Sb9AFxz5Y8ZCt/FP95aLsgt37OcjG2t3dUZ4jcySDR+
	oBLGJOwUWLBRmvPyVFR20E27Uw3BH+bf88+GPWfLWo8D74+JL/7G7t7yP0+lI/SpJY0/gamwqPjLu
	1XGOrnjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOy33-00000000S16-0BY4;
	Fri, 28 Nov 2025 12:58:05 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOy2z-00000000S0N-3UNj
	for linux-um@lists.infradead.org;
	Fri, 28 Nov 2025 12:58:03 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-343ee44d89aso2426608a91.2
        for <linux-um@lists.infradead.org>; Fri, 28 Nov 2025 04:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764334681; x=1764939481; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i0e4sEMhWKJpG15SRogICDaVX6hinUkaKf0qiXuZhnY=;
        b=Ej2hAgZ2iibz3Vh7cd4zi8PfpTAAzgNvXbqjEMHWdns5Qt342B6XGtGbGth5xoFnoO
         8cnefvYucoUWmHu3pezfST03Ty3k9O7Tsbuzk6fnvoSj3sghC8JYf9RUCmMrkMVhQl//
         md1GK6f+noUHQPPyviJMlL9xpgHANUvIOzDiEmk18j/f/fTZyT+F0gIPrCB4qk3asXbR
         E5ZqbS40bOCLkUPFZXBTSuT9IPhOHkTz0lsGwkPx6dHGzekCoLwHxK42K7pKpMR1QxFr
         t0MiWHHFWheyN3uvos7WQKO8IDtXSs9H8iqXOquzrg3WKKSrDxXxAOZn1Lw7kD+Ljio5
         jGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764334681; x=1764939481;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0e4sEMhWKJpG15SRogICDaVX6hinUkaKf0qiXuZhnY=;
        b=Q75MRQPkwa+o83uQU5TXiMpLvYUF9GxnV2OqP9HhXeIkwp20Oec+le+aBJSQqqAX73
         WV8uPtYYCIInuhFmNuQeqTN7Yue6fXCmIgUwl55YIEXxwyPn8KrMEletQsbQUJNHIOj4
         04DIm7L2A+AXkjGYtcBp6O8wj9QOtHLgpS02ApvIBbgfDm+xJ6wIh044sXEJT5JfsRbf
         yLhrkUP3LrByBOjoHT8GUSx2nilqaa+fhvgAJuyJlX3vcfg7dojwbQcPBvG7X4Q14j4q
         RQAi55KlTY91goRNSCdPj4ulac1/xBWcvK8SkU6lysJXqZ+cxcNSoJz0tcGIcbq5xfJQ
         xJnw==
X-Forwarded-Encrypted: i=1; AJvYcCVevRoYZnv3usjOItk/3lPQVmqU3WiLutAqNEAjrigEM6eLB87KEZlt8HDXTWr1XvaQcOBu/8RgUA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy38N1OGHW0bzbyNTgDnOyj1kF7LgtZgGeI6w49NF64uriFwIwq
	yQQ4qfJt/1brPGvaO4zUakLH6gmWFJNfzf2+v+NZxjQxA3sHb/1I+zwk
X-Gm-Gg: ASbGncu3KNJ1z97gJcCg4UGYrWPTX/FuaKqZdB0vYVJHc0R/mAfAl4mLRzHhmU8Hxfw
	TtyWT36NGS1vdiiDV9JL/gx5Q9cI6wS4aNa0YIi6NvekFQR+YbkaBK5f9hVpF+qsEzpFqDRf1hq
	PCs40C0JCE/PNQn2DnS/xxYhGtcaUWTSjbb/DzQprngUu0Q/91o/mDyhAWyrqfqrX4Y613ONb++
	/41DoA2726uCXaaU3UIuXtXzhrIGzfS7ZjXrLBAieM88G8YTD2kMXf6MWGFOHkWpPahUsza7toa
	nkgkdkhr3wmPnUVLxPIhoMAm880RTsLhM3ED4XLklNzn3ueOja1uoMcYLQ22+jci+XqSchKVVIe
	JLbYZyu8orNjgfqE7dibkOWNXapPUHjwIFAWx9pgQ4bW/Rc4q6peRmUMkLYCUPzE4HhVOXFvGkY
	HKmqAL6W+6ptccaJyNQ6BUHtyfGYqcqhrGwWbSHa7z3bSMQNNQTlLILFv/IUTDFYPLKz0i2Mttb
	jWi1uVqi0uUr0gLMtAzue00cR0HdBe4
X-Google-Smtp-Source: AGHT+IHigNX3YamvAxF+IgpmNjfpWxV42jLO+NgzYIgH1hQlOrFdeR/11VjQDjnqKJMmbIfw4Aiq7g==
X-Received: by 2002:a17:90b:274c:b0:32b:9506:1780 with SMTP id 98e67ed59e1d1-34733e60873mr25624331a91.9.1764334680348;
        Fri, 28 Nov 2025 04:58:00 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3476a55ed00sm8572809a91.5.2025.11.28.04.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 04:57:59 -0800 (PST)
Date: Fri, 28 Nov 2025 21:57:55 +0900
Message-ID: <m2y0nqwbzg.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: hch@infradead.org,
	linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 00/13] nommu UML
In-Reply-To: <defcec3945fbc37e90070b030bf1596b11b6d926.camel@sipsolutions.net>
References: <cover.1762588860.git.thehajime@gmail.com>
	<aRGs8lPjH22NqMZc@infradead.org>
	<m2framxerm.wl-thehajime@gmail.com>
	<0a84c16f862026c82271c0adbc91d98b812a78b4.camel@sipsolutions.net>
	<m2bjl7y6mv.wl-thehajime@gmail.com>
	<defcec3945fbc37e90070b030bf1596b11b6d926.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251128_045801_926496_74861433 
X-CRM114-Status: GOOD (  60.55  )
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


On Tue, 25 Nov 2025 18:58:53 +0900,
Johannes Berg wrote:
> 
> On Wed, 2025-11-12 at 17:52 +0900, Hajime Tazaki wrote:
> > > >   What is it for ?
> > > >   ================
> > > >   
> > > >   - Alleviate syscall hook overhead implemented with ptrace(2)
> > > >   - To exercises nommu code over UML (and over KUnit)
> > > >   - Less dependency to host facilities
> > > 
> > > FWIW, in some way, this order of priorities is exactly why this hasn't
> > > been going anywhere, and every time I looked at it I got somewhat
> > > annoyed by what seems to me like choices made to support especially the
> > > first bullet.
> > 
> > over the past versions, I've been emphasized that the 2nd bullet (testing)
> > is the primary usecase as I saw several actually cases from mm folks,
> > 
> > https://lists.infradead.org/pipermail/maple-tree/2024-November/003775.html
> > https://lore.kernel.org/all/cb1cf0be-871d-4982-9a1b-5fdd54deec8d@lucifer.local/
> > 
> > and I think this is not limited to mm code.
> 
> Not sure there's much value in testing much else in no-MMU, but sure,
> I'll give you that it's useful for testing.

under the tree,

% global -xr CONFIG_MMU | grep ifndef  | grep -v -E "arch/|mm/" | wc -l
45

this is a rough picture but there are places to be tested other than
mm codebase.

> > other 2 bullets are additional benefits which we observed in a
> > comment, and our experience.
> 
> But are they really _worthwhile_ benefits? A lot of this design adds
> additional complexity, and it doesn't really seem necessary for the
> testing use case. Making it faster is nice, but it's not like the
> speedup really is 20x for arbitrary tests, that's just for corner cases
> like "sit in a loop of gettimeofday()". And for kunit there's no syscall
> boundary at all, so there's no speedup.

I agree and as I said the reason to take a single-host-process
approach is from the speed and simplicity of removing interaction
between host processes.

I have never claimed that tests should execute fast.
and agree that kunit doesn't benefit from speed as there is no syscall
(unless kunit-uapi patch will be in).

> > > I suspect that the first and third bullet are not even really true any
> > > more, since you moved to seccomp (per our request), yet I think design
> > > choices influenced by them persist.
> > 
> > this observation is not true; the first bullet is still true even
> > using seccomp.  please look at the benchmark result in the patch
> > [12/13], quoted below.
> 
> > [snip]
> 
> So thanks for the correction. If that's the case, however, it means the
> speedup can't be due to the syscall boundary itself (seccomp) but must
> rather be due to some pagefault/mapping handling issue? Which would be
> inherent in no-MMU, even taking an approach of using two host processes
> rather than embedding everything into one.

I'll explain this later in this email.

# nommu doesn't have page fault as there are only physical address.

> > > However, I'm not yet convinced that all of the complexities presented in
> > > this patchset (such as completely separate seccomp implementation) are
> > > actually necessary in support of _just_ the second bullet. These seem to
> > > me like design choices necessary to support the _first_ bullet [1].
> > 
> > separate seccomp implementation is indeed needed due to the design
> > choice we made, to use a single process to host a (um) userspace.
> 
> That sounds misleading or even wrong to me, I'd say it's due to putting
> the (um) userspace in the same host process as the kernel space?

not sure if this is different from my explanation...

> > I don't see why you see this as a _complexity_, as functionally both
> > seccomp handling don't interfere each other.
> 
> The complexity isn't so much in the separate code, which is a small
> factor, but in the "put everything into the same process" aspect of it.
> That has consequences around the host context state handling, things we
> didn't really need to consider before suddenly become crucially
> important. In the current (with-MMU) design, we only need to worry about
> being able to correctly switch between userspace tasks/threads within a
> userspace mm (host) process. With the no-MMU design you propose, we also
> need to be able to correctly switch between kernel and userspace tasks
> within the same single (host) process.
> 
> I think this is a pretty significant difference, and saying "there's no
> complexity here" is simply pretending it isn't a relevant difference. I
> believe you're not even handling this correctly right now in this patch
> set, specifically wrt. the GS register which has been pointed out
> before, but I wouldn't say that I even have a complete picture in my
> head over what state handling would be necessary and sufficient.
> 
> So yeah, I think this warrants taking another look as to whether or not
> the approach of putting everything into the same host process is even
> worth it. I tend to believe that it isn't, given the use cases. And if
> you say the speedup still is with seccomp, that kills the speed argument
> too.

I understand your concern on complexity, thanks for the detail.

the host context state handling is indeed new thing. we've only
verified a limited set of code path, with a basic operation with um +
drivers and some userspace programs.  this should not be perfect at
this moment but can be improved.

> > > I've thought about what would happen if we stuck to creating a (single)
> > > separate process on the host to execute userspace, and just used
> > > CLONE_VM for it. That way, it's still no-MMU with full memory access,
> > > but there's some implicit isolation between the kernel and userspace
> > > processes which will likely remove complexities around FP/SSE/AVX
> > > handling, may completely remove the need for a separate seccomp
> > > implementation, etc.
> > 
> > this would be doable I think, but we went the different way, as
> > using separate host processes (with ptrace/seccomp) is slow and add
> > complexity by the synchronization between processes, which we think
> > it's not easy to maintain in the future.
> 
> Which one is it then, slow or not? Not sure I follow. You just said you
> do have seccomp when comparing speeds, so that in itself doesn't make it
> slow. What synchronization? It'd (have to) be CLONE_VM, but that
> actually _simplifies_ state transfer/synchronization, and we already
> have (to have) state transfer between different userspace threads in the
> same host process for the with-MMU case.

Since I included speed characteristics in the document, I should
explain more on the impact of this, compared to the existing
design/implementation of uml.

many documents, articles said uml is slow (uml document in tree also
mentioned a bit), but cannot find detailed analysis, so I look closely
at how nommu (w/ seccomp) and mmu w/ seccomp behave.

suppose we have a userspace program running under uml (on seccomp-mmu,
seccomp-nommu).


	struct timespec ts1, ts2;
	clock_gettime(CLOCK_REALTIME, &ts1);  // 1)
	getpid()                              // 2)
	clock_gettime(CLOCK_REALTIME, &ts2);  // 3)

# this is a chunk from the benchmark program used in the document.

then collected several events (sched_switch, signal_generate, and
sys_enter_futex) via ftrace.

looking at 3 SIGSYS (sig=31) signals on above code, and below is the
output of the `trace-cmd report`.

- frace seecomp-mmu, 2)-3)= 11 usec
 uml-userspace-3092637 [002] 1749286.670199: signal_generate:      sig=31 errno=0 code=1 comm=uml-userspace pid=3092637 grp=0 res=0    => 1)
 uml-userspace-3092637 [002] 1749286.670200: sys_enter_futex:      op=FUTEX_WAKE uaddr=0x7fffffffdf8c val=1
 uml-userspace-3092637 [002] 1749286.670201: sys_enter_futex:      op=FUTEX_WAIT uaddr=0x7fffffffdf8c val=0x00000001 utime=0x00000000
 uml-userspace-3092637 [002] 1749286.670202: sched_switch:         uml-userspace:3092637 [120] S ==> swapper/2:0 [120]
          <idle>-0     [028] 1749286.670203: sched_switch:         swapper/28:0 [120] R ==> vmlinux:3092631 [120]
       vmlinux-3092631 [028] 1749286.670205: sys_enter_futex:      op=FUTEX_WAKE uaddr=0x60b64f8c val=1
       vmlinux-3092631 [028] 1749286.670206: sys_enter_futex:      op=FUTEX_WAIT uaddr=0x60b64f8c val=0x00000000 utime=0x00000000
       vmlinux-3092631 [028] 1749286.670207: sched_switch:         vmlinux:3092631 [120] S ==> swapper/28:0 [120]
          <idle>-0     [002] 1749286.670209: sched_switch:         swapper/2:0 [120] R ==> uml-userspace:3092637 [120]
 uml-userspace-3092637 [002] 1749286.670211: signal_generate:      sig=31 errno=0 code=1 comm=uml-userspace pid=3092637 grp=0 res=0    => 2)
 uml-userspace-3092637 [002] 1749286.670212: sys_enter_futex:      op=FUTEX_WAKE uaddr=0x7fffffffdf8c val=1
 uml-userspace-3092637 [002] 1749286.670213: sys_enter_futex:      op=FUTEX_WAIT uaddr=0x7fffffffdf8c val=0x00000001 utime=0x00000000
 uml-userspace-3092637 [002] 1749286.670214: sched_switch:         uml-userspace:3092637 [120] S ==> swapper/2:0 [120]
          <idle>-0     [028] 1749286.670215: sched_switch:         swapper/28:0 [120] R ==> vmlinux:3092631 [120]
       vmlinux-3092631 [028] 1749286.670216: sys_enter_futex:      op=FUTEX_WAKE uaddr=0x60b64f8c val=1
       vmlinux-3092631 [028] 1749286.670217: sys_enter_futex:      op=FUTEX_WAIT uaddr=0x60b64f8c val=0x00000000 utime=0x00000000
       vmlinux-3092631 [028] 1749286.670218: sched_switch:         vmlinux:3092631 [120] S ==> swapper/28:0 [120]
          <idle>-0     [002] 1749286.670220: sched_switch:         swapper/2:0 [120] R ==> uml-userspace:3092637 [120]
 uml-userspace-3092637 [002] 1749286.670222: signal_generate:      sig=31 errno=0 code=1 comm=uml-userspace pid=3092637 grp=0 res=0    => 3)


- ftrace seccomp-nommu, 2)-3) =  3 usec
       vmlinux-3092542 [006] 1749158.829292: signal_generate:      sig=31 errno=0 code=1 comm=vmlinux pid=3092542 grp=0 res=0    => 1)
       vmlinux-3092542 [006] 1749158.829294: signal_generate:      sig=31 errno=0 code=1 comm=vmlinux pid=3092542 grp=0 res=0    => 2)
       vmlinux-3092542 [006] 1749158.829297: signal_generate:      sig=31 errno=0 code=1 comm=vmlinux pid=3092542 grp=0 res=0    => 3)

with seccomp-mmu, a host process for userspace (uml-userspace) is
notified with SIGSYS (sig=31) upon syscall from userspace, and switched
task (of host) to vmlinux (um kernel), with the wake/wait
synchronization (which I meant synchronization in my previous email),
and switch back to uml-userspace to continue the userspace process.

so, at least 4 host sched_switch-es per single um syscall.

with current nommu using a single host process, notifications via
SIGSYS is same as seccomp-mmu, but after that there is no context
switch upon syscall issued by a userspace, in the same context to the
next syscall.

nommu implementation with CLONE_VM (btw, the host process, uml-userspace
is already created with CLONE_VM flag IIUC) might face the similar
situation as seccomp-mmu, seeing the same switches between processes.

this becomes the difference between the benchmark results of getpid, which
um-mmu (seccomp)/um-nommu (seccomp) is mostly x10 (26.242 and 2.599
usec) (this was described as an example of benchmark in the patchset).

I didn't look at ptrace mode of MMU, but expect to see the similar (or
more) duration on a single syscall.




in addition to this ftrace measurement above, I conducted more
practical benchmark with iperf3 (forward/reverse path) and netperf
(TCP_STREAM/MAERTS), which aren't corner cases I believe, and below is
the result.

all use the vector driver with gro on via host tap devices.
iperf3/netperf server run on a host and client runs inside uml.

# I can give a complete script to reproduce this if needed.


- iperf3 (Mbps)
              um-mmu(seccomp)	 um-nommu(seccomp)
--------------------------------------------------
iperf3(f)       7984             13152
iperf3(r)       8009             14363

- netperf (Mbps, bufsize=65507bytes)
              um-mmu(seccomp)	 um-nommu(seccomp)
--------------------------------------------------
netperf(STREAM)   5912.93        10792.02
netperf(MAERTS)  29263.53        33970.06


not significant different as we saw with simple syscall benchmark with
getpid(2), but still see an impact with difference.

I would say these results only show partial cases of what UML can do,
different workloads may show different result, but it is still
valuable to present one of the benefits to see the nature of the
feature (of what single process design can do).

Of course, nommu will come with various limitations as I described in
the document; like applications should be aware of the kernel is nommu
(i.e., need to use vfork, PIE binaries, etc).  So traditional uml is
more generic and has broader usage, but with this characteristic of
speed with nommu, I think it is worthwhile and users benefit from this
if they need speed.

I hope this clarifies a bit.

-- Hajime

