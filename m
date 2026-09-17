Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D71C982D2
	for <linux-um@archiver.kernel.org>; Thu, 17 Sep 2026 16:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wFVtn7TG6f4mxtK33dq+a4hRgCkKck590tubt0IqX6w=; b=eVFyhYhHsK4Ln7guJMWBoSw5Pr
	ZWCAYmVSlGyBxjOvaePJKELcZu4BRdaTTjtKmkkiseMDV/AInddncGc4K1J4pC+cuB1gQ2ZrYWzlo
	d6yWzCZhIWbF4WZrF4hRDKNWszKrc9Njy2MrdTYgfZZJU7AxRKuAusvITGrhlWItA5L9it0VnE9gl
	MSia7PiLeixa+/2+qoGBSLnj4iwQ0L95TnALgWukWNQ13g8GcSRIAZ1k15IAXJ37RKUWPcSDqVZY9
	9OvBrAuFbYMHx1AoQVHyp7Yvkut013p5WoDEDKq3TOY8OmkF4iPnbh0ZT3sIBV3ILVaKwQdfojr3w
	3KgxGC9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7FF6-0000000Byh2-2dA4;
	Thu, 17 Sep 2026 16:45:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7FF3-0000000Byfv-26EW
	for linux-um@lists.infradead.org;
	Thu, 17 Sep 2026 16:45:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789663543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wFVtn7TG6f4mxtK33dq+a4hRgCkKck590tubt0IqX6w=;
	b=Ac38Nh8f7PO/3QG9demuUPIA6WwGSHz0vdtEu4+uIs9mO85qITzNalWfOXBk7yQ2YWjazP
	IzaK3d5C6Rqwb5CL7PQ6b+X9q6sXs52NSM4TFxj7p+ODA9C4aPQao/v0kkKV5bLuIL+IEh
	N6HrVdg+TrTa5IajZrQifgloieP9R0g=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-JAS3CUrUPlSam6xbcPIDPw-1; Thu, 17 Sep 2026 12:45:41 -0400
X-MC-Unique: JAS3CUrUPlSam6xbcPIDPw-1
X-Mimecast-MFC-AGG-ID: JAS3CUrUPlSam6xbcPIDPw_1789663540
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c252634bc4dso121169066b.1
        for <linux-um@lists.infradead.org>; Thu, 17 Sep 2026 09:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789663540; x=1790268340;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wFVtn7TG6f4mxtK33dq+a4hRgCkKck590tubt0IqX6w=;
        b=dnwrMezbbgsEwBBI5bXXmfVeD1HLfwa9Z21PlWcQ+9OwU5x3W2aVWV4dXod2JipJsj
         0+VtMXfwiSQvxNQiWwoOnXKcOh2sz7F8dBvbZkvIszEva3Nlxa3bg7g7rebvc7vMInWx
         iaTlsUeHgOWwpZt0v6SBHhWPfieDVUrc3Fr9JLuWczUUe7cskRwmJJ/jWkYymnUyeZVd
         mvtjhJRxM/zCOxFHTKD8t5c0EducWz+lEtaUlOSRknSH9IARVoRpS6McZ9wXsfLMH/qj
         RyYjxs06qbHddFva4+x3XjqHC5cJQuMArnvGDbmWI+KDs4YkYJ5fchGPkMoLnYszV/dw
         tt+A==
X-Forwarded-Encrypted: i=1; AKwUvBxQPXOe04BwzwOuzcZzvH+7OkWwkRu6UzZvTYABBZPpgz5VyrhanbLhi7fJF2dKO5l3qvGleRb2pA==@lists.infradead.org
X-Gm-Message-State: AFuF++mYsWsxpDf2rQiWatGv9M/mmbm52if1fD4jOfWFwO/uR/VYgfiD
	m298zuefTj0UMufMLCoMEAbJtX9S7ojVs+/mCUdLj8dL8hRN+1DWVyVTGIfFtq0LeBHaYyOVhIt
	8Wi6wYrReJQk+VBNChfv161qzEs7mywHZLqYzBVDSiVT0XA/tA2QHU1nlcaK5S5WgqMsDMELO5Q
	t79SwObTi6ybh+shw6Jo6pJtKaBsc+ZgOdJ4vXWWP/
X-Gm-Gg: AYBFou3wpoOCsODpy2uP6uK+wdiGCR5Da9WbVFvbR0Qc/JdPfXjGysQTAYlK5ft7F+m
	zlieifl7vqfmfQs800GOAtQAl94HmCpKSEGJiIrrA/DkjoXFXXiI25lGSKbwnUEHVCNzfw1DRqO
	yS+ZMAOB+82/VlejJUupgyRZqE7gxjSMkE8ZD7VwvQ5g4z6PPpjLz+TUdbCqmR6FUghbhwG9JZ9
	Z/6OZCBZKFjyboNp85QkYgRuzPt4xxgLzJ1LLIg7YyUGiNgrk4S1I+yt9BSjo+souUEwfDJWICQ
	TU4=
X-Received: by 2002:a17:907:9603:b0:c29:f5d5:5a9b with SMTP id a640c23a62f3a-c29f5d56177mr278872166b.37.1789663539826;
        Thu, 17 Sep 2026 09:45:39 -0700 (PDT)
X-Received: by 2002:a17:907:9603:b0:c29:f5d5:5a9b with SMTP id
 a640c23a62f3a-c29f5d56177mr278866966b.37.1789663539386; Thu, 17 Sep 2026
 09:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1788351089.git.rrobaina@redhat.com> <b30076994d49fa393251c836b5a57a725f218572.1788351089.git.rrobaina@redhat.com>
 <apkuGoWQwLJ7AcUC@willie-the-truck>
In-Reply-To: <apkuGoWQwLJ7AcUC@willie-the-truck>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Thu, 17 Sep 2026 13:45:27 -0300
X-Gm-Features: AcwNN1VE92GuCfaSbB45oDCoyv2ZqeewbUd4A5IjqOoYsq0pANwtPdd_-Sv6Jfw
Message-ID: <CAABTaaA7ZbfLxaQvTegaE9prKUPAu5fbfVt5wiaSZK=ohhjL1Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] audit: log all six syscall arguments in the
 SYSCALL record
To: Will Deacon <will@kernel.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, paul@paul-moore.com, 
	eparis@redhat.com, sgrubb@redhat.com, oleg@redhat.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, guoren@kernel.org, 
	monstr@monstr.eu, tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6h_UrCvT9Z4xYgAKdB54ll-fhFe0iYuTYRxtLmFyrJ8_1789663540
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260917_094545_889079_45734986 
X-CRM114-Status: GOOD (  24.15  )
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

On Thu, Sep 3, 2026 at 5:22=E2=80=AFAM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Sep 02, 2026 at 11:43:34AM -0300, Ricardo Robaina wrote:
> > The SYSCALL record currently logs only four of the six syscall
> > arguments (a0-a3). The remaining two are captured but silently
> > discarded before reaching the audit context. This leads to the
> > need for auxiliary records when audit-relevant data lands in the
> > 5th or 6th argument of a syscall.
> >
> > Extend the SYSCALL record to log all six arguments, by adding
> > arguments a4 and a5 (5th and 6th syscall arguments respectively)
> > inline within the existing record. Also add the two new args to
> > the audit rules switch case, so audit rules can filter on them.
> >
> > Rather than plumbing two more register arguments through every
> > architecture's syscall entry path, change __audit_syscall_entry()
> > to take a pointer to pt_regs and use syscall_get_arguments() to
> > retrieve all six arguments.
> >
> >  audit-testsuite# make test
> >  audit-testsuite# ausearch -i -m SYSCALL
> >  ...
> >  type=3DSYSCALL ... syscall=3Dsendto success=3Dyes exit=3D1088 a0=3D0x4
> >   a1=3D0x7ffe43518b60 a2=3D0x440 a3=3D0x0 a4=3D7ffe43518b4c a5=3Dc
> >  type=3DSYSCALL ... syscall=3Dopenat2 success=3Dyes exit=3D4 a0=3D0x3
> >   a1=3D0x7fffc74692c8 a2=3D0x7fffc7467390 a3=3D0x18 a4=3D0 a5=3D7fffc74=
674f8
> >  type=3DSYSCALL ... syscall=3Dopenat success=3Dyes exit=3D3 a0=3DAT_FDC=
WD
> >   a1=3D0x557ced4141a2 a2=3DO_RDWR|O_NONBLOCK a3=3D0x0 a4=3D0 a5=3D0
> >  ...
> >
> > Suggested-by: Will Deacon <will@kernel.org>
> > Link: https://lore.kernel.org/audit/CAHC9VhSjEt_-Bsra4AEqWv+Daw5Ff=3Dgq=
y7dX4Ah11RVhdyCBUQ@mail.gmail.com/T/#t
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  include/linux/audit.h         | 13 ++++---------
> >  include/uapi/linux/audit.h    |  2 ++
> >  kernel/audit.h                |  2 +-
> >  kernel/auditfilter.c          |  2 ++
> >  kernel/auditsc.c              | 19 ++++++++-----------
> >  kernel/entry/syscall-common.c |  4 +---
> >  6 files changed, 18 insertions(+), 24 deletions(-)
> >
> > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > index 45abb3722d30..9ce5962bc537 100644
> > --- a/include/linux/audit.h
> > +++ b/include/linux/audit.h
> > @@ -323,8 +323,7 @@ extern int  audit_alloc(struct task_struct *task);
> >  extern void __audit_free(struct task_struct *task);
> >  extern void __audit_uring_entry(u8 op);
> >  extern void __audit_uring_exit(int success, long code);
> > -extern void __audit_syscall_entry(int major, unsigned long a0, unsigne=
d long a1,
> > -                               unsigned long a2, unsigned long a3);
> > +extern void __audit_syscall_entry(int major, struct pt_regs *regs);
> >  extern void __audit_syscall_exit(int ret_success, long ret_value);
> >  extern void __audit_getname(struct filename *name);
> >  extern void __audit_inode(struct filename *name, const struct dentry *=
dentry,
> > @@ -373,12 +372,10 @@ static inline void audit_uring_exit(int success, =
long code)
> >       if (unlikely(audit_context()))
> >               __audit_uring_exit(success, code);
> >  }
> > -static inline void audit_syscall_entry(int major, unsigned long a0,
> > -                                    unsigned long a1, unsigned long a2=
,
> > -                                    unsigned long a3)
> > +static inline void audit_syscall_entry(int major, struct pt_regs *regs=
)
> >  {
> >       if (unlikely(audit_context()))
> > -             __audit_syscall_entry(major, a0, a1, a2, a3);
> > +             __audit_syscall_entry(major, regs);
> >  }
>
> Won't this (temporarily) break the build? Maybe you need to introduce a
> new helper e.g. audit_syscall_entry_regs(), then convert everybody over
> to that, then rename it to audit_syscall_entry() at the end to keep the
> series bisectable.
>
> Will
>

Yes, you're right Will. Thanks for your suggestion I'll do that in the
next version.

Thanks!
-Ricardo


