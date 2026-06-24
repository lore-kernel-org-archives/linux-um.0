Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1990CDE000
	for <linux-um@archiver.kernel.org>; Wed, 24 Jun 2026 23:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=52gsJGG5VhB8ooQR6GAEEZ7SFvHiGdJxoQUfRIoAwGg=; b=o4lyqD23ayNjSt/CCPh7DJE/IB
	fCQbcDq9hjXX0K5vYIux22Bh3fE0GT0VshOldA8in8C9Nlrp33Gy0qUCN3j6/g27cbbtpegs8CGQt
	6ZeBP9YdWnipZI62rFyW6sC3k1FyBNC/+gXqX2FLbIKTx/S+4OwaKw63jGxDM6yN5tYlfudGsb7s+
	vyPuFtM1dIslWqEjnkOcH7AvWyzjHvJsrOgaIKr67tmXHdqeaYeMmzq15ORenJvLSte5Ki8tsYYxH
	Zw5iIyC77LDrrEvBjvSkhMnG+jMfp0Qc/ao04uWAKXr8yRUuq872wzd3JGFPHcHNSXFZibT51SE42
	2VhWe8Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcWm8-00000008QqD-2lA2;
	Wed, 24 Jun 2026 23:12:56 +0000
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcWm6-00000008Qpp-05vm
	for linux-um@lists.infradead.org;
	Wed, 24 Jun 2026 23:12:55 +0000
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-3998ea7847dso14386971fa.2
        for <linux-um@lists.infradead.org>; Wed, 24 Jun 2026 16:12:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782342771; cv=none;
        d=google.com; s=arc-20240605;
        b=COTigEpG6Pmh1PO/s6Z6uhgbJ8VjC+J3Gd2Zw+vau7oh+F9+fKT2BQ3GCneczLDB2+
         xE5Mql9DDesmHl03yo2ZbQkOlgMynjKfIOk20con21f78vFUsFfcBXOZKGFc1/e9DYlE
         3hEIZGk48LFH96SN/k5729BQf4nyIFYhlf0GCrpzMGV1+2Z7hc7NXi2qGkPMFoyzxMBp
         XinPGwFMBCfVHORO6X+1YAzxd/CNMoKy/CKkaMXsxmQ7UCaSyY3fd89dtrqHqwZAT/dF
         k3f60Os1x6zJ/Y2+suNgZcme63ONzofX9mYCnliHN5a41Nnb/C0UDaAxAuZ5ANsyj0ru
         iziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=52gsJGG5VhB8ooQR6GAEEZ7SFvHiGdJxoQUfRIoAwGg=;
        fh=4PNDHaG3HzmCd5OJUwGNWCQFkFI62lOKmQ6Ak4suWq4=;
        b=MB4D6vsBieBPAUGPWuQE4Z8CC+VryJ7f2BQVLGmfYyxmNuOqobhgz+OSLWaVJjvUl2
         /eTdQ4l0H74Y0m+rU7aUPRgFq63+6AWAQ2YxeCogY+UKFHkifwxrtU3fs2DBEwJ3UvA7
         ScYq/zDp03/k6b+LwiB1Vr8nCRqEGldFK0hK4tqWcE4DDSfs9D2CFgxOOHiLSYUHSXVf
         wWsylEhBIqlUWTYbHh21XLB01n3C4vk1bgLg/4w7D+UnbpoN9rnLl44TGyt55hd8IKfp
         mjEl+szMl+wsP3XlCXKq8W1xJw6YXbdHS5S5o5szNCxotJirr3a3NExuA5Jn8Zn1xGbu
         dXZA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782342771; x=1782947571; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52gsJGG5VhB8ooQR6GAEEZ7SFvHiGdJxoQUfRIoAwGg=;
        b=huM+KjAnMLA4o9MBpLTExJhL+KWoLDK8YPqmK7Y793ysx3v2icAJa5FE8mmO+fiLrB
         0KOJdFBEwKzfKpOFVSTPJ5yfbhn5KajkI4fzy3+NZJ0+raxWYlIYLSJJgUuwX5ww7a72
         wOEH1I2UfdaJPYtx0Hkk+KcrCWAq+R6hrIS2r9xq2aKFScJLmvMnl3JevQHVHsTe9jEH
         K8kvGlQvDOjXmLeHqoKNEy6tCT+uhIskNGb3sS6TLRyRE+XHbCFPgAc94VKFcSWuET9V
         ygAkXcJ7rU3ZAUFKhjgZ7p/ZQqpVD5tN5098mxK/CqcCqZr31nsw4/ZMAkpwRhE1lCGi
         ASIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782342771; x=1782947571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=52gsJGG5VhB8ooQR6GAEEZ7SFvHiGdJxoQUfRIoAwGg=;
        b=KoVzsYoVawgm/Eio9ingcXxLQoBrF43ZSggLUoINfYF8l2+K7twUt3KEQESgvKc8Mv
         iOld9c9oGoEUmedCCNxRIVumHB0AkMquJ5Pat82h34Qcm8/MG37RyPXwTFB0Aw0U6bZI
         V4gO6IlCTfLCaRsXN9xa6qvIr/fWct9h5zz6b42H478EYYjn5eOuwPUME+r7jom+hne+
         qc3qGaLHMqwWxG+9aOqFISHMR4FI2TmnUfju5wpqxhFM5GtLndcfaKavLoJj8Xt4ntQs
         X3+LtcFycDVXwi73tD875tj8DXbmOOJ1w0IKiw8KutdDrM67HxxWfXGFLMHS+S40Li+y
         6jVQ==
X-Forwarded-Encrypted: i=1; AHgh+RooKftWeFigLVOMY4RfC5icRUipziOiZm82wcMDCdjWHsiqwaL4tiAQ2lqJhqmc+v4re1fjPcOFFw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz2+kM7qCbz6HBdQWx/FbL1kpBrDZFM7mWYxZEeU/G9CpqmTkwX
	ZD4feBOz+GtMTISZ5FPO2r2UuS1zrFo8IhMd6i1YMOF2F576ZYxrkqd0ZKXFqIqkaFVLKme/pe1
	LEW8pAhnLljdXzkQRpdXZl8Yla2WbRIo=
X-Gm-Gg: AfdE7cn7mtvR0K2XFAcWE8aXH0xKztYvnUBpAaCq2b8dthlzevY8uDoCYwgcCl3Q00J
	/HiS+42Hk6tACrXzczRmZyBDocX99lOz0P1VDAuli7PQNTxVRVSco+ZMn1umleQxwRKX0WdtpXZ
	Uxv+BB4bSdeG3IpiA08BaajpohCAG59tFq7aoFaJYEWJkpmCziKanvlOnhMthsZJQOAKkN327k2
	L3oE/FZ4TDng5KcyzbIdonAqEMSj/H+U9bGnCwf56yBrp9uJj0Kx4rVSqr9DnZlHXwqckKgkrYx
	XLSc7vBa+TtX88XIj5ZjXV5197/kECUaV77Bbn27Yi8zdykLXLbpvB1Y3P0StQ==
X-Received: by 2002:a05:651c:1551:b0:38e:a777:f393 with SMTP id
 38308e7fff4ca-39aba203deemr15718441fa.19.1782342770791; Wed, 24 Jun 2026
 16:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1781925126.git.xiyou.wangcong@gmail.com>
 <1e1681eecfa5dd30181534674b1a17756df802f8.camel@sipsolutions.net>
 <CAM_iQpWj+daY6tsPXKq=B4ekjr-8-tpfX+2twLhW_oGP_YqOHw@mail.gmail.com> <03b2134eea62d664781069c8bd072705e0fc4aee.camel@sipsolutions.net>
In-Reply-To: <03b2134eea62d664781069c8bd072705e0fc4aee.camel@sipsolutions.net>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Wed, 24 Jun 2026 16:12:39 -0700
X-Gm-Features: AVVi8Cds4veP6x5J3mzbPlrwDLOIy9BbF4M0fYZnIPC5M7gBUV1vh2YGfo98nPo
Message-ID: <CAM_iQpUc4dQvYXbGpUgBXke+a8hVXnBCtjziXd1QX=QJXWiwjA@mail.gmail.com>
Subject: Re: [PATCH 0/7] um: skas: harden the seccomp userspace stub
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260624_161254_142821_BF3F5967 
X-CRM114-Status: GOOD (  49.54  )
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

On Wed, Jun 24, 2026 at 12:54=E2=80=AFAM Benjamin Berg
<benjamin@sipsolutions.net> wrote:
>
> On Tue, 2026-06-23 at 15:08 -0700, Cong Wang wrote:
> > On Mon, Jun 22, 2026 at 5:08=E2=80=AFAM Benjamin Berg <benjamin@sipsolu=
tions.net> wrote:
> > >
> > > On Fri, 2026-06-19 at 20:22 -0700, Cong Wang wrote:
> > > > From: Cong Wang <cwang@multikernel.io>
> > > >
> > > > In the seccomp ("SECCOMP") userspace mode, each guest userspace pro=
cess
> > > > runs in a stub under a seccomp filter and traps to the monitor (the=
 UML
> > > > kernel) on every syscall. Two items on the stub.c "Known security i=
ssues"
> > > > list could not be addressed by the filter alone:
> > > >
> > > >   - a hijacked stub could mmap() arbitrary physmem offsets, which i=
s an
> > > >     intra-guest disclosure and, on this base (single physmem fd, no
> > > >     kernel/user split), a host escape; and
> > > >
> > > >   - a hijacked stub could block SIGALRM via a crafted rt_sigreturn =
to
> > > >     evade preemption and wedge the monitor indefinitely.
> > > >
> > > > This series closes both:
> > > >
> > > >   1-2: route the stub's mmap() through a SECCOMP_RET_USER_NOTIF lis=
tener
> > > >        owned by the monitor (no behavioural change yet).
> > > >   3-4: validate each mmap() against the mm's page table -- allowed =
iff the
> > > >        PTE already maps the requested frame with no more access tha=
n it
> > > >        grants -- including out-of-batch mmaps a hijacked stub issue=
s on
> > > >        its own.
> > > >   5:   route and validate munmap() the same way (range-confined bel=
ow
> > > >        STUB_START).
> > >
> > >
> > > That approach seems odd to me. Adding an explicit out-of-band check
> > > means you require two extra context switches per mmap syscall. I woul=
d
> > > expect that this makes the SECCOMP approach a lot slower than ptrace(=
).
> > > My take is still that it is possible to carefully craft a SECCOMP
> > > filter as well as stub/kernel code that makes exploitation impossible
> > > for non-SMP.
> > >
> > > The true SMP case is more complicated, but we do not have that anyway=
,
> > > so I would not worry about it for now.
> > >
> > > Did you run any performance tests?
> >
> > Sorry, I thought I included them in patch 4/7, but I missed them.
> >
> > Here they are:
> >
> > mmap() -- ns/call
> > -----------------
> > size   WITH med   WITHOUT med   delta            WITH p99   WITHOUT p99
> > 4K     13056      10368         +2688  (+26%)     17408      15104
> > 16K    13824      11008         +2816  (+26%)     15616      12544
> > 64K    19840      15616         +4224  (+27%)     21760      17408
> > 256K   33152      28928         +4224  (+15%)     36352      31744
> > 1M     95616      84608         +11008 (+13%)     117504     108032
> >
> > munmap() -- ns/call
> > -------------------
> > size   WITH med   WITHOUT med   delta            WITH p99   WITHOUT p99
> > 4K     11008      8448          +2560  (+30%)     13568      11264
> > 16K    10752      8448          +2304  (+27%)     12288      9472
> > 64K    12032      9728          +2304  (+24%)     13824      10752
> > 256K   15360      12800         +2560  (+20%)     17152      14592
> > 1M     27648      24832         +2816  (+11%)     30976      26880
> >
> > Since this is a clear security-vs-performance balance, I picked securit=
y
> > over performance. Please let me know if you prefer otherwise.
>
> So, I still believe that (almost) zero-overhead is possible in the
> current framework. Maybe one could add a non-zero overhead option, but
> then I would like to be able to disable it as there are plenty of
> scenarios where security is of no concern.

This is fair, I can add an option to keep it disabled by default.

>
> Also, I am unsure what you measured there. When you write "mmap" here,
> is that an "mmap" call made by the userspace process (which might not
> actually change the page mappings), or is that an "mmap" call that was
> queued for the stub to process?
>
> A large amount of the overhead that UML tends to have happens when
> handling both minor and major page faults. Simple tests for this is for
> example a relatively tight fork/exec loop or just applications starting
> up. In our test runs, we saw major speed improvements (>10%) just by
> fixing bugs in the TLB handling code that resulted in fewer page faults
> happening at application runtime.

It is just a simple user-space mmap() loop just for benchmarking this
patchset.

>
> > Meanwhile, after a second thought, there is a zero-overhead solution.
> > pidfd_mmap(), which can be built on top of another patch of mine:
> > https://lore.kernel.org/all/20260613001533.314739-2-xiyou.wangcong@gmai=
l.com/
>
> Sure, should some sort of method land that allows directly modifying
> the mappings of the remote process, that would be rather convenient.
>

Great. I will work on it. One question: should I drop this one or we can us=
e
this one as the short term solution before the pidfd_mmap() solution gets i=
n?
Even if we had pidfd_mmap(), UML might still want to keep compatibility wit=
h
older host kernels?


> > Something like:
> >
> > int map(struct mm_id *mm_idp, unsigned long virt, unsigned long len, in=
t prot,
> >         int phys_fd, unsigned long long offset)
> > {
> >         return pidfd_mmap(mm_idp->stub_pidfd, (void *)virt, len,
> >                           prot_to_mmap(prot), MAP_FIXED | MAP_SHARED,
> >                           phys_fd, offset);
> > }
> > int unmap(struct mm_id *mm_idp, unsigned long addr, unsigned long len)
> > {
> >         return pidfd_munmap(mm_idp->stub_pidfd, (void *)addr, len);
> > }
> >
> > Obviously, this one requires a new syscall for the host kernel first.
> >
> > >
> > > >   6:   add a watchdog thread that detects a stub which stops report=
ing
> > > >        back (e.g. blocked SIGALRM) and SIGKILLs it, letting the mon=
itor
> > > >        recover via the existing teardown.
> > >
> > > That also seems like an odd solution to me. Architecturally, UML firs=
t
> > > receives the SIGALRM and forwards it to the child. It would seem much
> > > easier to set a flag and clear it again when the process reports back
> > > that it received the SIGALRM. Then, when the kernel receives the next
> > > SIGALRM, just kill the child immediately if the flag is still set.
> >
> > The flag-and-recheck scheme matches the ptrace path (wait_stub_done), w=
here
> > the monitor is the tracer: it sees the stub's SIGALRM as a waitpid()
> > signal-stop and PTRACE_CONTs it, so "monitor receives, then deals with =
the
> > child" is accurate there. This patch is on the seccomp path
> > (wait_stub_done_seccomp), which is architecturally different.
> >
> > Or am I missing anything?
>
> The fact that it is not actually different from an architectural
> standpoint. In both cases SIGALRM is reported back to the kernel. It
> obviously has to be reported back, otherwise scheduling would not work.

You're right.

In the seccomp path the monitor also receives the SIGALRM and
forwards it to the stub: the per-vCPU POSIX timer targets the monitor threa=
d
and um_timer() -> os_alarm_process() -> kill(stub, SIGALRM) forwards
the tick. ptrace vs. seccomp differ only in how the monitor
learns the stub stopped (waitpid vs. futex), not in the point you raised.

So the watchdog thread is redundant. The inner FUTEX_WAIT loop in
wait_stub_done_seccomp already wakes on every forwarded tick via EINTR;
responsive stub acks by flipping data->futex out of FUTEX_IN_CHILD, a
SIGALRM-blocking one doesn't, exactly your flag scheme. I'll drop the helpe=
r
thread and timerfd and detect the stall inline: count consecutive ticks whe=
re
the stub didn't report and goto out_kill past a small threshold.

Thanks!

