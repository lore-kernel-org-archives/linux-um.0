Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC7EC43458
	for <linux-um@archiver.kernel.org>; Wed,  1 Jul 2026 21:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fzhHNkHTtUH7+JVWv2Nef9hQzP+OnzWLr6r7q+yiG/4=; b=IL09kffr3K20n6dujQMiL6sK6A
	J3STdgaDx8ET6+IGvrwnXfTmxG9J87WDyK4Nu9G7KFT29hyKtZaJjgq7WZEO1obooMdQG4Jh8R7Ut
	e0v9oLD5uULZxQQK/bvpd7j2ZkwDHKdoIj7su6h1YCNf6dfrMo58Sfdi4Uc30hYeHRv3MwL1kt0k4
	5NKV0SKEWieSl83fkOw8oD7wScdn26zl+B4b3tyxz0zctt0dJWyrSXQuhMVySK6yh2VvsWe5g41Z9
	FpRaIzwUXDTQoVacLJcuGH7GI0hz6aGYOlvjaO6CPacaZYVqo8iGLqZP15da4euPgqMSQGO9g1xtr
	y6vodRrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wf2XA-000000033ii-2hXt;
	Wed, 01 Jul 2026 21:31:52 +0000
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wf2X7-000000033iB-05a4
	for linux-um@lists.infradead.org;
	Wed, 01 Jul 2026 21:31:51 +0000
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-39b355f96afso9534401fa.3
        for <linux-um@lists.infradead.org>; Wed, 01 Jul 2026 14:31:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782941506; cv=none;
        d=google.com; s=arc-20260327;
        b=T73Fl7iDXS9MUAKsj+FSKfZH9yIAF+0Bo0EUKDyU1gHc6NzkSvqGoIXGL7tqkcxcyL
         4CMNFR78/y+TkktIk7pHQrWsuA2tm6KHYMuATAMav+QsQrvpCCrDF1G3yQf51UfHhENr
         nzXFRPELKPOoh+YtoXfeH3qlz6V5b+P/lG44U5jQQ+7Ym6pBoEySu4HU29mbDOFSdlDQ
         4+9hbtfR2Cte9jMIvvB2+dHSje37YvGXhppvu4nD2by2711hfUHcudTLi3TubT3BUUQb
         Kvyyk1OpB2I3Qom+hlEYeJsXz6SRjFnMU2d/Mf/BU5oI3jODCvksXnkH0zbcNPwiJW/i
         qkrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fzhHNkHTtUH7+JVWv2Nef9hQzP+OnzWLr6r7q+yiG/4=;
        fh=5g9cGj/IJ6QRQEWzOBB/QDBn+ZXZo1R/7P7qRAXOuM4=;
        b=od5a/2x6BS70zVbNN6oHQb+OqIMmh75aTgtJeFNOagbSpZvCxm431TABADGhGYjMp2
         6rMwIYIJN3oPsAniSKGqJ+jnFGJpCUC60ldjo8QC46GYLXVRM0AOPHXUsY2hX6dBd+RY
         4Xcq+KZ+92E2CQlIEuE+a6UchPNF40iLopnI1PFn9wL7WExVgl2FwxudqI6iFGwpobSJ
         lPCFmgeEohVFPomh0c+3IQvNzxwx1pdPMml3rS8ZUuENo3nc0InTI6j9RXiSBkoJ3IC1
         jT3X5KysRDOMvqsVFLIsuqQsgmReWnU822P4aSufLo0kVmD5JOY6OmvNxMSbsG1geI/X
         8J/A==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782941506; x=1783546306; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzhHNkHTtUH7+JVWv2Nef9hQzP+OnzWLr6r7q+yiG/4=;
        b=X68GlmncCKOlgfB3w3hZ8juexhgtXTrh6odP3m3Td712lG9tLsULPWsAzTtVhPWV1D
         4yAZcUAH82TR9Qng1wxcnzRa+zhGmOMzLhAZ0UWThWJfr3EUsdED4Q3/zpuavui4DHXU
         AwMne3n6WP3XeTSlpGrDC4nYSMVKUE55d8+OmJmpS9RFDYzFNmQAuuKJ8rK9kH8eZe/i
         0eaMgm7IMVYcnJ721+p5Ja9XY2Znp2MGh7YoG+D6T8Vab5iGfAwaHZF/KFC8P78yobbK
         vUVEB6qP03zQZIK1yiEbnBjCfKZCooVruArREyIzegcSwQX/oQmwWaOPssuGqRcx9PO6
         /i1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782941506; x=1783546306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fzhHNkHTtUH7+JVWv2Nef9hQzP+OnzWLr6r7q+yiG/4=;
        b=FcJkDFg+ZakoOl5jc7/rhYc3s2cJDEGunH3fe8XnRBg6xLPjb6O218Qgia6j1uaS5B
         Ayml2dsIGjpnHlvg1wsGDMgRXt2aCTrYiwdNZcTvPWUCNTmMqW/BbT/i74QjzBKwaV0a
         9Rn4PbKIOzsynLMioXq/JE3gqNC6acGpYe+V3xsEn8EoFeV/dtrZhPQ50rjpwgIDE0/v
         qOM/KBvv+HuQP7htsXTL48JSd5MP6n4QweTdmrzecynb3RJ1cBh7ZCACqgUTqj8xzFr3
         XK2+XornAYPTgCuB5pUXw4s8bBAYB+rvoCeHS2L9qoeYL5uVFA18lBolu1aKG1xYUU+u
         QEgg==
X-Forwarded-Encrypted: i=1; AHgh+Ro8fsCOX9U/pKYA57EHmdD9aaj+261v22uXKqE9sWqU8LoEyFoGKo6lcKCaUuPXI/PZnNnZDb6Yxw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyb6jGrJAUX6pYcVxuLwpNFsbQaCylp5o2zrsb2XbDhR8Yfywe/
	4B+OgQ4ZpM7uUXyrTRdNwqmOZryfc0QyuxSnOFEdgAwsokeQtldR0qnUi+skYplQqzRO7w6F5XV
	TiabUp9h+0/Iu9nLpJy48u3768cpNW6Yzq1iD
X-Gm-Gg: AfdE7cl3bXhlWlNiQu1RlilqcOp2RdEdy7YUTa8oz5RFI5Knd1Op1AZB1KAbCqWj0M6
	DsU9Jchml1j+5nhjdK5YNU4jBDPPtrb/a5Q+SfReRA2EMM6KsyWThgYx6FlWlVk9r2t6Hg11n9Y
	cmCeIZCLb/Y/J89KxjVrYQPLByIB5gPa7TUozQFFagL8T0yHncLbt2Uwai8V0rGluSQGDbdCARV
	/3ipyANQCqcqSls+/z/QbBp3ALMKgBM5oygW7+kFCjWFHzuGn5vay+BdfwuEuadScpIuLinLkNC
	BmzseXIg7Y8VgUu0zhYhY7MhyGVumKU=
X-Received: by 2002:a05:651c:1516:b0:39a:e29b:78f8 with SMTP id
 38308e7fff4ca-39b3705c516mr5912741fa.36.1782941505990; Wed, 01 Jul 2026
 14:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1781925126.git.xiyou.wangcong@gmail.com>
 <1e1681eecfa5dd30181534674b1a17756df802f8.camel@sipsolutions.net>
 <CAM_iQpWj+daY6tsPXKq=B4ekjr-8-tpfX+2twLhW_oGP_YqOHw@mail.gmail.com>
 <03b2134eea62d664781069c8bd072705e0fc4aee.camel@sipsolutions.net>
 <CAM_iQpUc4dQvYXbGpUgBXke+a8hVXnBCtjziXd1QX=QJXWiwjA@mail.gmail.com> <c4bc735d4413410c6ff5c5011ebdf0fffe05866f.camel@sipsolutions.net>
In-Reply-To: <c4bc735d4413410c6ff5c5011ebdf0fffe05866f.camel@sipsolutions.net>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Wed, 1 Jul 2026 14:31:34 -0700
X-Gm-Features: AVVi8CfZnNXcV363BSFPmL3tzKr1nIKlwWVWhVAIBEBHYMujtOgJCwbvSy29i1Q
Message-ID: <CAM_iQpU_GdBn3b=PmWRgoKYmJOoAN58+-sO7xsEb5oTQvDopTw@mail.gmail.com>
Subject: Re: [PATCH 0/7] um: skas: harden the seccomp userspace stub
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260701_143149_155314_3B7B9393 
X-CRM114-Status: GOOD (  68.58  )
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

On Sat, Jun 27, 2026 at 9:21=E2=80=AFAM Benjamin Berg <benjamin@sipsolution=
s.net> wrote:
>
> Hi,
>
> On Wed, 2026-06-24 at 16:12 -0700, Cong Wang wrote:
> > On Wed, Jun 24, 2026 at 12:54=E2=80=AFAM Benjamin Berg
> > <benjamin@sipsolutions.net> wrote:
> > >
> > > On Tue, 2026-06-23 at 15:08 -0700, Cong Wang wrote:
> > > > On Mon, Jun 22, 2026 at 5:08=E2=80=AFAM Benjamin Berg <benjamin@sip=
solutions.net> wrote:
> > > > >
> > > > > On Fri, 2026-06-19 at 20:22 -0700, Cong Wang wrote:
> > > > > > From: Cong Wang <cwang@multikernel.io>
> > > > > >
> > > > > > In the seccomp ("SECCOMP") userspace mode, each guest userspace=
 process
> > > > > > runs in a stub under a seccomp filter and traps to the monitor =
(the UML
> > > > > > kernel) on every syscall. Two items on the stub.c "Known securi=
ty issues"
> > > > > > list could not be addressed by the filter alone:
> > > > > >
> > > > > >   - a hijacked stub could mmap() arbitrary physmem offsets, whi=
ch is an
> > > > > >     intra-guest disclosure and, on this base (single physmem fd=
, no
> > > > > >     kernel/user split), a host escape; and
> > > > > >
> > > > > >   - a hijacked stub could block SIGALRM via a crafted rt_sigret=
urn to
> > > > > >     evade preemption and wedge the monitor indefinitely.
> > > > > >
> > > > > > This series closes both:
> > > > > >
> > > > > >   1-2: route the stub's mmap() through a SECCOMP_RET_USER_NOTIF=
 listener
> > > > > >        owned by the monitor (no behavioural change yet).
> > > > > >   3-4: validate each mmap() against the mm's page table -- allo=
wed iff the
> > > > > >        PTE already maps the requested frame with no more access=
 than it
> > > > > >        grants -- including out-of-batch mmaps a hijacked stub i=
ssues on
> > > > > >        its own.
> > > > > >   5:   route and validate munmap() the same way (range-confined=
 below
> > > > > >        STUB_START).
> > > > >
> > > > >
> > > > > That approach seems odd to me. Adding an explicit out-of-band che=
ck
> > > > > means you require two extra context switches per mmap syscall. I =
would
> > > > > expect that this makes the SECCOMP approach a lot slower than ptr=
ace().
> > > > > My take is still that it is possible to carefully craft a SECCOMP
> > > > > filter as well as stub/kernel code that makes exploitation imposs=
ible
> > > > > for non-SMP.
> > > > >
> > > > > The true SMP case is more complicated, but we do not have that an=
yway,
> > > > > so I would not worry about it for now.
> > > > >
> > > > > Did you run any performance tests?
> > > >
> > > > Sorry, I thought I included them in patch 4/7, but I missed them.
> > > >
> > > > Here they are:
> > > >
> > > > mmap() -- ns/call
> > > > -----------------
> > > > size   WITH med   WITHOUT med   delta            WITH p99   WITHOUT=
 p99
> > > > 4K     13056      10368         +2688  (+26%)     17408      15104
> > > > 16K    13824      11008         +2816  (+26%)     15616      12544
> > > > 64K    19840      15616         +4224  (+27%)     21760      17408
> > > > 256K   33152      28928         +4224  (+15%)     36352      31744
> > > > 1M     95616      84608         +11008 (+13%)     117504     108032
> > > >
> > > > munmap() -- ns/call
> > > > -------------------
> > > > size   WITH med   WITHOUT med   delta            WITH p99   WITHOUT=
 p99
> > > > 4K     11008      8448          +2560  (+30%)     13568      11264
> > > > 16K    10752      8448          +2304  (+27%)     12288      9472
> > > > 64K    12032      9728          +2304  (+24%)     13824      10752
> > > > 256K   15360      12800         +2560  (+20%)     17152      14592
> > > > 1M     27648      24832         +2816  (+11%)     30976      26880
> > > >
> > > > Since this is a clear security-vs-performance balance, I picked sec=
urity
> > > > over performance. Please let me know if you prefer otherwise.
> > >
> > > So, I still believe that (almost) zero-overhead is possible in the
> > > current framework. Maybe one could add a non-zero overhead option, bu=
t
> > > then I would like to be able to disable it as there are plenty of
> > > scenarios where security is of no concern.
> >
> > This is fair, I can add an option to keep it disabled by default.
>
> Sure. But I still think that a discussion is needed on whether another
> option is viable. I would really prefer not adding your proposed
> solution if another low/zero overhead option is viable.
>
> And I still absolutely believe that it is viable to modify the current
> code and make it secure. I just never finished that work because it
> requires a lot of care and it is not that important to us.

OK. Just to provide more context: I am evaluating using UML for
multi-tenant cloud, security is a must there, not just optional.

I guess I might be the first one doing so, otherwise these security
issues would have been resolved. :)

>
> > > Also, I am unsure what you measured there. When you write "mmap" here=
,
> > > is that an "mmap" call made by the userspace process (which might not
> > > actually change the page mappings), or is that an "mmap" call that wa=
s
> > > queued for the stub to process?
> > >
> > > A large amount of the overhead that UML tends to have happens when
> > > handling both minor and major page faults. Simple tests for this is f=
or
> > > example a relatively tight fork/exec loop or just applications starti=
ng
> > > up. In our test runs, we saw major speed improvements (>10%) just by
> > > fixing bugs in the TLB handling code that resulted in fewer page faul=
ts
> > > happening at application runtime.
> >
> > It is just a simple user-space mmap() loop just for benchmarking this
> > patchset.
>
> If you just say "mmap() loop" I think that you are purely doing an
> mmap/unmap syscall of anonymous memory in a loop. However, the kernel
> may not map any of those pages until they are actually accessed. I
> would not have been surprised if you did not see any performance
> difference at all in such a test.
>
> Are you actually touching (writing) each of the mapped pages?

Yes, with MAP_POPULATE. Sorry for forgetting to mention it.

>
> > > > Meanwhile, after a second thought, there is a zero-overhead solutio=
n.
> > > > pidfd_mmap(), which can be built on top of another patch of mine:
> > > > https://lore.kernel.org/all/20260613001533.314739-2-xiyou.wangcong@=
gmail.com/
> > >
> > > Sure, should some sort of method land that allows directly modifying
> > > the mappings of the remote process, that would be rather convenient.
> > >
> >
> > Great. I will work on it. One question: should I drop this one or we ca=
n use
> > this one as the short term solution before the pidfd_mmap() solution ge=
ts in?
> > Even if we had pidfd_mmap(), UML might still want to keep compatibility=
 with
> > older host kernels?
>
> Of course, UML should not regress on older kernels. Also, any new API
> like that will probably still take a while. That said, I am not sure
> there is a pressing need to fix the security problem as long as we have
> ptrace mode available.

Maybe I am greedy, I want both security and performance. I ruled out
ptrace model due to low performance and try to improve seccomp mode
for better security.

Anyway, I agree to drop this patchset and work on pidfd_mmap(),
I will send them out shortly.

>
> >
> > > > Something like:
> > > >
> > > > int map(struct mm_id *mm_idp, unsigned long virt, unsigned long len=
, int prot,
> > > >         int phys_fd, unsigned long long offset)
> > > > {
> > > >         return pidfd_mmap(mm_idp->stub_pidfd, (void *)virt, len,
> > > >                           prot_to_mmap(prot), MAP_FIXED | MAP_SHARE=
D,
> > > >                           phys_fd, offset);
> > > > }
> > > > int unmap(struct mm_id *mm_idp, unsigned long addr, unsigned long l=
en)
> > > > {
> > > >         return pidfd_munmap(mm_idp->stub_pidfd, (void *)addr, len);
> > > > }
> > > >
> > > > Obviously, this one requires a new syscall for the host kernel firs=
t.
> > > >
> > > > >
> > > > > >   6:   add a watchdog thread that detects a stub which stops re=
porting
> > > > > >        back (e.g. blocked SIGALRM) and SIGKILLs it, letting the=
 monitor
> > > > > >        recover via the existing teardown.
> > > > >
> > > > > That also seems like an odd solution to me. Architecturally, UML =
first
> > > > > receives the SIGALRM and forwards it to the child. It would seem =
much
> > > > > easier to set a flag and clear it again when the process reports =
back
> > > > > that it received the SIGALRM. Then, when the kernel receives the =
next
> > > > > SIGALRM, just kill the child immediately if the flag is still set=
.
> > > >
> > > > The flag-and-recheck scheme matches the ptrace path (wait_stub_done=
), where
> > > > the monitor is the tracer: it sees the stub's SIGALRM as a waitpid(=
)
> > > > signal-stop and PTRACE_CONTs it, so "monitor receives, then deals w=
ith the
> > > > child" is accurate there. This patch is on the seccomp path
> > > > (wait_stub_done_seccomp), which is architecturally different.
> > > >
> > > > Or am I missing anything?
> > >
> > > The fact that it is not actually different from an architectural
> > > standpoint. In both cases SIGALRM is reported back to the kernel. It
> > > obviously has to be reported back, otherwise scheduling would not wor=
k.
> >
> > You're right.
> >
> > In the seccomp path the monitor also receives the SIGALRM and
> > forwards it to the stub: the per-vCPU POSIX timer targets the monitor t=
hread
> > and um_timer() -> os_alarm_process() -> kill(stub, SIGALRM) forwards
> > the tick. ptrace vs. seccomp differ only in how the monitor
> > learns the stub stopped (waitpid vs. futex), not in the point you raise=
d.
> >
> > So the watchdog thread is redundant. The inner FUTEX_WAIT loop in
> > wait_stub_done_seccomp already wakes on every forwarded tick via EINTR;
> > responsive stub acks by flipping data->futex out of FUTEX_IN_CHILD, a
> > SIGALRM-blocking one doesn't, exactly your flag scheme. I'll drop the h=
elper
> > thread and timerfd and detect the stall inline: count consecutive ticks=
 where
> > the stub didn't report and goto out_kill past a small threshold.
>
> Not sure I follow and the description makes me wonder if it was written
> by an LLM. To me it seems overly complicated and incorrect in subtle
> ways.

Yes, I marked it with Assisted-by: Claude:claude-opus-4.8.

Thanks.

