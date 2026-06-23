Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F07CDB471
	for <linux-um@archiver.kernel.org>; Tue, 23 Jun 2026 22:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0TBG+yy3bfkkaeFG2fJSBl9kcc+7TUsvKyRx3qXNQtc=; b=HjshAm3jgrMnB3E1N764lJTetb
	YJW24NUqATKiUCrZ3RzpbDHbbyqPpZQQqZGnm/01g7GlGJ8LlOE0xZkn4Rq6OCQsTwgsmy70bNZ7q
	RbX+20P9M+seAmHarrx3SNdBE7r1PVfdWiXYI5Bx24NHeiDCum0l09miyGFE6W0PVQ4zmRyshPVP+
	GQfxW4V6goqN77XWnEWR8wowQza1n12ElRzoeaHzo72l/L3Grm1OKMPIV+2PbBh8CvQqxOlg6ag0N
	4R7F+ho3bt78mse3GSlKJfd50A9jh7p3jhs09iyB4IoLfkmt9K+q/7Pt3fWRmrkN3fqrkwJhIlxeN
	1zVyZNWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc9Ie-00000006wFL-0Mgw;
	Tue, 23 Jun 2026 22:08:56 +0000
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc9Ia-00000006wEh-3S4K
	for linux-um@lists.infradead.org;
	Tue, 23 Jun 2026 22:08:54 +0000
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-39669bcaadfso3302561fa.0
        for <linux-um@lists.infradead.org>; Tue, 23 Jun 2026 15:08:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782252530; cv=none;
        d=google.com; s=arc-20240605;
        b=eS5tpb5RE6MY4P+aVm1M8wgftuPCB3tfwzgKqrpjvsWPr3IlTCuknXDIhfVATT6eSM
         brQOfptsbOknAcR92K82JtmZ04M8uqyntD+3YJ1554HoOyWRSLBfQUDZogkcAuyL8IQp
         0W5dlvt95I8Njw9siSsf05oDlo2Og6AR4U4R9s0yluJaUdxrUEUXb6zzJf07hghIV7B+
         GeEVIui3t4FcoaHLpNLci1V+W/Pyo8ptO2VnfOLOUG12wZCqP2pDvPtV2OSPwweqKesG
         nQJWnVDcNCtil6jqIm0CFB+0tIvlfkvKW29RmMOm5kbU6XBM584AYF1xAAYBbXzS197Q
         kwQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0TBG+yy3bfkkaeFG2fJSBl9kcc+7TUsvKyRx3qXNQtc=;
        fh=7UslhID56hOM3TowdMCqGXx7Cegf4QWFn8sdrl8zvUE=;
        b=a5QELFcVh+v0yml7lp9+Ua7jOei4Ti2x66AReAidSAQ/S+2sMmy0ADD7GBa8rFDJ+k
         wMtRG3kTQNylD8vNfmjH+fNUDcngTSVYgNOcF7mswVPJ1Ku2gz5HBBbwMct6xgpceuLk
         FUfWlPRiE8mY2M/zis2IGyP4g4IQYkHC31g3C0zUKIWmEP7OvO23sfsWdMvv7dc37Tp3
         urJ+hwu47oHeyAjaeSpz+kc3Jdvk5/FBUqKtG3fAUZTgzxZx0uPbqdtCKi9WdqnWwc5Y
         YHao8I/MCwIrL4wa4w0G21hprt/maGo3iKwlhP5AQYkudmh9DHzJwM0QsQ10JPd5zKH7
         zJBg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782252530; x=1782857330; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TBG+yy3bfkkaeFG2fJSBl9kcc+7TUsvKyRx3qXNQtc=;
        b=Ndrlxss2I0XB9l0tJElEXhbePxhxnb88zvYNc1MfbBQEJRqDjB7jQGXbsTb0/3V40B
         XouQnGiG7hWohukdACVupg/WBtrgBpK2JgS5URNkQgyFa6+y4zZbN7gZwe4XIYIh/GTn
         em3pE5Lc4vJSwKRYvBlnDFoSo6hHxDe6SQvDiff3qCC+C7BzgZ6pUn2RcdYztsgLOn6q
         vxekvkrrNjFzNoP15SMp9ePK57N8zFPUrX2nZKz3K6Qv4dx35GzBqbGv0kF+3WawkwUo
         3acTzKSnbbZLP99t+sVArV7bPIrfhXDMSO27Vw75yp6hPCa+mRMFZ8s5JzsJ2aC/tkSp
         52+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782252530; x=1782857330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0TBG+yy3bfkkaeFG2fJSBl9kcc+7TUsvKyRx3qXNQtc=;
        b=Wo9k/q0gaNds1k+zDXg5g8btxQAPWgugAy1iTFJyeTn/ggWOkFFaThCdsZk7HymuO0
         nsJDiVLIunyT2SSNtPV1guWNQOyJFa2gzUgOKOfOnjh0CwMZT6aErA8EMwF6fTHoDCQ2
         wrcuO9UnLjhEJYYSRUVXWOjGTliOBHGvlhdTgeJSumwPEjsr9DU1sfpMh7+vhQQ5exXQ
         MoafuBZW8NemTetBAi9vt+hgHtEnEYb1yhwzNrDgE/Joc1QVgz/UvHElzXFPe3IDRU/x
         nb8u7e5h3XWyUs+C9jd9oE/G7r9bvDH3W6wABQbKiAaVZK5SjQxLYLPAmmtarwkr4RWb
         6rkQ==
X-Forwarded-Encrypted: i=1; AFNElJ/fAdoI/e2HouVqgisXAWWwNtiSCsu6bf5paPVAJgIaY8S81Gm2ECjt78+zmoNLaIkg1zpToGa+LA==@lists.infradead.org
X-Gm-Message-State: AOJu0YziRUKeZM9P78L+aY/DU2C24qheORgetxdXiZon4JcsVF+Sltgy
	T8qCZizfswvjd9l9Sn3109HILYjIaryRQEqmNmcPVP8SWx7o+3TAGJsabqXYReHgUVcWPWF8KOq
	Fefy18F4vZf1lkO5M/RxT81bwm/rfwWM=
X-Gm-Gg: AfdE7clMqAlVseKAD8mPNyP4ImfSfV+AZTqzKn07VXrDqnPzUkBkan8IIiA1ZofUKd7
	A3ux5/uIyNxJgasrrOqTjJxuW8qfV5Y1LJCcbioSlWKq7R/VTQKLwSziD99a4n3E2rHO+yYrbnP
	4BZ3UWTHmc7JEu3MG4ztfeA9AB0A+VybVhOG5nDCI1T+tGOooBkj6LLmYaha+7NdeWRNIiJFq9d
	CV7jn/DOBPOrCIAJ+UhSBDhdiZoqGrKtDpZ1I6/aZtHEiaIeCpI2d/gihpAc/En9sBnVx2HO/ux
	m6u9DCcBG8gzhgfa9eEo0bY33R9ETnc=
X-Received: by 2002:a2e:bea9:0:b0:399:9436:15e8 with SMTP id
 38308e7fff4ca-39aba1fca10mr854021fa.21.1782252529367; Tue, 23 Jun 2026
 15:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1781925126.git.xiyou.wangcong@gmail.com> <1e1681eecfa5dd30181534674b1a17756df802f8.camel@sipsolutions.net>
In-Reply-To: <1e1681eecfa5dd30181534674b1a17756df802f8.camel@sipsolutions.net>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Tue, 23 Jun 2026 15:08:36 -0700
X-Gm-Features: AVVi8CcGkZMxNZ9R5zrrD8uEfrD2mbpt7A5FB4TdR69MD8RNJ2Bp0N8pB5Lag4k
Message-ID: <CAM_iQpWj+daY6tsPXKq=B4ekjr-8-tpfX+2twLhW_oGP_YqOHw@mail.gmail.com>
Subject: Re: [PATCH 0/7] um: skas: harden the seccomp userspace stub
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260623_150852_892341_35B7F3FF 
X-CRM114-Status: GOOD (  30.38  )
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

On Mon, Jun 22, 2026 at 5:08=E2=80=AFAM Benjamin Berg <benjamin@sipsolution=
s.net> wrote:
>
> On Fri, 2026-06-19 at 20:22 -0700, Cong Wang wrote:
> > From: Cong Wang <cwang@multikernel.io>
> >
> > In the seccomp ("SECCOMP") userspace mode, each guest userspace process
> > runs in a stub under a seccomp filter and traps to the monitor (the UML
> > kernel) on every syscall. Two items on the stub.c "Known security issue=
s"
> > list could not be addressed by the filter alone:
> >
> >   - a hijacked stub could mmap() arbitrary physmem offsets, which is an
> >     intra-guest disclosure and, on this base (single physmem fd, no
> >     kernel/user split), a host escape; and
> >
> >   - a hijacked stub could block SIGALRM via a crafted rt_sigreturn to
> >     evade preemption and wedge the monitor indefinitely.
> >
> > This series closes both:
> >
> >   1-2: route the stub's mmap() through a SECCOMP_RET_USER_NOTIF listene=
r
> >        owned by the monitor (no behavioural change yet).
> >   3-4: validate each mmap() against the mm's page table -- allowed iff =
the
> >        PTE already maps the requested frame with no more access than it
> >        grants -- including out-of-batch mmaps a hijacked stub issues on
> >        its own.
> >   5:   route and validate munmap() the same way (range-confined below
> >        STUB_START).
>
>
> That approach seems odd to me. Adding an explicit out-of-band check
> means you require two extra context switches per mmap syscall. I would
> expect that this makes the SECCOMP approach a lot slower than ptrace().
> My take is still that it is possible to carefully craft a SECCOMP
> filter as well as stub/kernel code that makes exploitation impossible
> for non-SMP.
>
> The true SMP case is more complicated, but we do not have that anyway,
> so I would not worry about it for now.
>
> Did you run any performance tests?

Sorry, I thought I included them in patch 4/7, but I missed them.

Here they are:

mmap() -- ns/call
-----------------
size   WITH med   WITHOUT med   delta            WITH p99   WITHOUT p99
4K     13056      10368         +2688  (+26%)     17408      15104
16K    13824      11008         +2816  (+26%)     15616      12544
64K    19840      15616         +4224  (+27%)     21760      17408
256K   33152      28928         +4224  (+15%)     36352      31744
1M     95616      84608         +11008 (+13%)     117504     108032

munmap() -- ns/call
-------------------
size   WITH med   WITHOUT med   delta            WITH p99   WITHOUT p99
4K     11008      8448          +2560  (+30%)     13568      11264
16K    10752      8448          +2304  (+27%)     12288      9472
64K    12032      9728          +2304  (+24%)     13824      10752
256K   15360      12800         +2560  (+20%)     17152      14592
1M     27648      24832         +2816  (+11%)     30976      26880

Since this is a clear security-vs-performance balance, I picked security
over performance. Please let me know if you prefer otherwise.

Meanwhile, after a second thought, there is a zero-overhead solution.
pidfd_mmap(), which can be built on top of another patch of mine:
https://lore.kernel.org/all/20260613001533.314739-2-xiyou.wangcong@gmail.co=
m/

Something like:

int map(struct mm_id *mm_idp, unsigned long virt, unsigned long len, int pr=
ot,
        int phys_fd, unsigned long long offset)
{
        return pidfd_mmap(mm_idp->stub_pidfd, (void *)virt, len,
                          prot_to_mmap(prot), MAP_FIXED | MAP_SHARED,
                          phys_fd, offset);
}
int unmap(struct mm_id *mm_idp, unsigned long addr, unsigned long len)
{
        return pidfd_munmap(mm_idp->stub_pidfd, (void *)addr, len);
}

Obviously, this one requires a new syscall for the host kernel first.

>
> >   6:   add a watchdog thread that detects a stub which stops reporting
> >        back (e.g. blocked SIGALRM) and SIGKILLs it, letting the monitor
> >        recover via the existing teardown.
>
> That also seems like an odd solution to me. Architecturally, UML first
> receives the SIGALRM and forwards it to the child. It would seem much
> easier to set a flag and clear it again when the process reports back
> that it received the SIGALRM. Then, when the kernel receives the next
> SIGALRM, just kill the child immediately if the flag is still set.

The flag-and-recheck scheme matches the ptrace path (wait_stub_done), where
the monitor is the tracer: it sees the stub's SIGALRM as a waitpid()
signal-stop and PTRACE_CONTs it, so "monitor receives, then deals with the
child" is accurate there. This patch is on the seccomp path
(wait_stub_done_seccomp), which is architecturally different.

Or am I missing anything?

Thanks for your review.

Regards,
Cong

