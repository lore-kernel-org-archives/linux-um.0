Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 033B7C982D2
	for <linux-um@archiver.kernel.org>; Thu, 17 Sep 2026 16:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ghsNMjszr/YVVrzwI9L3VChkEhVa9VAV3CWSeRoOujg=; b=buaA4pyyc+If/OLp/uAjK9gfQ7
	n1+UV/rH4+I5WzrCiH4lCw4MSxL2bBsSIlgANqDem9b4QmYSWpHwPQlvTT8/XFU6tswl/MO6qc8e2
	jxH++1UDDv724KlwM3wVLoNPF668RS0LxGl+qCbkV9LaqkCjEEfUqnmFjiGi/bfgJWtQFhltu4wC0
	xHWnZpX+4phDsdwHnironrALH6h44F0ymJyzInR/kRFlxXRjHwSbwp0lp3xsu2n+t1e7xC7NNtX9G
	pPU0pLcAxGVf/R8HgJpHITXelbwY+X1qk7kxXQ+pol7+HxHblB4gWz02WtHvHakpmtXFoL3fbG67q
	nryB0UHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7FGy-0000000BzDQ-1n9C;
	Thu, 17 Sep 2026 16:47:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7FGv-0000000BzCA-3Xor
	for linux-um@lists.infradead.org;
	Thu, 17 Sep 2026 16:47:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789663661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghsNMjszr/YVVrzwI9L3VChkEhVa9VAV3CWSeRoOujg=;
	b=eATgGJvglDB/e/XNDRrzgW5WKOMEpiB7LymnGtDf3t8cuHmDceHF6yh3kS+B4K+hNcO7ms
	+q7mwqmlMk4xTiF2LCi9CdNZxB2HVauHdvJoBImez5qV++TOb0SpSxrRysTv9oeZ9rPF7n
	RqubMsnYYyb9IE5olgw4ULYsdRg071o=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-DVXjJjtEN06-sYkSAB8Sfw-1; Thu, 17 Sep 2026 12:47:39 -0400
X-MC-Unique: DVXjJjtEN06-sYkSAB8Sfw-1
X-Mimecast-MFC-AGG-ID: DVXjJjtEN06-sYkSAB8Sfw_1789663658
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6a9b5240fb3so1397879a12.1
        for <linux-um@lists.infradead.org>; Thu, 17 Sep 2026 09:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789663658; x=1790268458;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ghsNMjszr/YVVrzwI9L3VChkEhVa9VAV3CWSeRoOujg=;
        b=AUxqWVnkzKbkqi7Q5IzbQm36CgtLBMraGFIMQtfPHeg3bah4Vr2OtRdH1uzYFjwru1
         PpCj2eXjoDqg+ZrIzgwx5LiW7TcjVmWtLI2Ueui50J8Ow3UFNrhyAtVTcoWJB3gJ4TcN
         Zq9QDiGR5FQuGHYgeK/uNEbHAhaNUbUMJ2Z+QjW1DK5PEdfaBhgvtsXnSj9fGZWhzary
         na0+N+zJYvHWNrUOxQUNFur69bp+hBjZc8InxxEx8MvWpIjy5FZcYf8HzLpxJWtVKJPT
         YpCOsjrihAAOkycwcd2lB5yUa1eMuHX30DL/PCc0KEuQnJAK2KjZAKW1BisqklE2zcPJ
         5F7A==
X-Forwarded-Encrypted: i=1; AKwUvBxN+4y5GNN1nUrDYxPPU3QGWSsdxjKvX0rDkCXCeErDTJwNZAqDfM3LWKkqYlKiuA8y53263ua2/A==@lists.infradead.org
X-Gm-Message-State: AFuF++nsxbhCNCs+lS5IZdFbqrQlRob2PvrhZGB8TGE+0EIrn149vVqc
	sBO6z/NtSZH26PEqNVofpk40fwdHtQuOvagQXH5sxYiouIY5SqMEtgVHGTfVmQZzNY48wfX5pTj
	kso4gGNQtrJ6ySwG0d3MJ4FOgzXEtjuhPoNWqf6wNaTTcAAYEuCoHT7p6Z9aWnsIKxzA/KaKtc2
	hVfM6fygmfKU45djUCAnlHeTojTPiA1mt5sLuJTg6Q
X-Gm-Gg: AYBFou0ZDV831dGz4GWIg709TDF9OjAJ1AxxA2xDLZNWHPd7RWgwsQyseSgQ1Bnlo4t
	VPkYj4qgELTEqewoMp0cfvF/8u9D8vCGJh6a6DSlQ+Pmx38/VuuOs6HbDU7LZR0wppCgy+3JAXn
	Ynruul9ztJVIkktiG8rLWF2b8BKuTfahE3DB2XXOe9F2b0dK2/w0kzBfttQ4zitfWvM/FMyMES8
	/jVL1tknt7EdbdNe93EYhzYzdd6bjmVjRpW0nHVN1TROGEcKYmboNpRecPkQa5/8vQ6k5FDqv8q
	F3s=
X-Received: by 2002:a17:907:1c29:b0:c25:fdbc:52df with SMTP id a640c23a62f3a-c29e5244c19mr627700366b.10.1789663657700;
        Thu, 17 Sep 2026 09:47:37 -0700 (PDT)
X-Received: by 2002:a17:907:1c29:b0:c25:fdbc:52df with SMTP id
 a640c23a62f3a-c29e5244c19mr627698766b.10.1789663657315; Thu, 17 Sep 2026
 09:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1788351089.git.rrobaina@redhat.com> <4ada9fcbb93af8d5c1c9bfe2c83d94fc10bfe327.1788351089.git.rrobaina@redhat.com>
 <CA+=Fv5T4826T2sd0Gbh-nfZsqcWK_phdBKy4BLWOvDTt92t5Eg@mail.gmail.com>
In-Reply-To: <CA+=Fv5T4826T2sd0Gbh-nfZsqcWK_phdBKy4BLWOvDTt92t5Eg@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Thu, 17 Sep 2026 13:47:26 -0300
X-Gm-Features: AcwNN1UQ-9H3EW5aAPKYI2mYiHxV9kMvBFdM8jP3WAhZbefwH7qcxYHE69PGYDs
Message-ID: <CAABTaaAUBzp1uaLve2piMhEB1R5po5n5+Sy+U0mbbe70Ak-SUw@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] alpha: pass pt_regs to audit_syscall_entry()
To: Magnus Lindholm <linmag7@gmail.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, paul@paul-moore.com, 
	eparis@redhat.com, sgrubb@redhat.com, oleg@redhat.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linux@armlinux.org.uk, 
	catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, monstr@monstr.eu, 
	tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WyGGXG_4Z6fWaRQwMuFM32twtwXNZj8xjEzbc_jz7AQ_1789663658
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260917_094741_956544_7B61B976 
X-CRM114-Status: GOOD (  22.56  )
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

On Fri, Sep 4, 2026 at 2:21=E2=80=AFPM Magnus Lindholm <linmag7@gmail.com> =
wrote:
>
> Hi Ricardo,
>
> On Wed, Sep 2, 2026 at 4:44=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.c=
om> wrote:
> >
> > audit_syscall_entry() now takes a pointer to pt_regs and extracts
> > the syscall arguments itself via syscall_get_arguments(). Drop the
> > individual argument registers from the call and pass regs instead.
> >
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  arch/alpha/kernel/ptrace.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/alpha/kernel/ptrace.c b/arch/alpha/kernel/ptrace.c
> > index fc8f6cedbb28..8a39c0473297 100644
> > --- a/arch/alpha/kernel/ptrace.c
> > +++ b/arch/alpha/kernel/ptrace.c
> > @@ -496,8 +496,7 @@ asmlinkage unsigned long syscall_trace_enter(void)
> >         }
> >
> >  #ifdef CONFIG_AUDITSYSCALL
> > -       audit_syscall_entry(syscall_get_nr(current, regs),
> > -               regs->r16, regs->r17, regs->r18, regs->r19);
> > +       audit_syscall_entry(syscall_get_nr(current, regs), regs);
> >  #endif
> >         return syscall_get_nr(current, regs);
> >  }
> > --
> > 2.55.0
> >
> This doesn't apply on top of my "alpha: enable GENERIC_ENTRY" series
>
> https://lore.kernel.org/linux-alpha/20260902184058.198679-1-linmag7@gmail=
.com/T/#t
>
> That series moves alpha's syscall entry onto the generic entry
> framework and removes syscall_trace_enter() and its direct
> audit_syscall_entry() call entirely - verified with git am against
> GENERIC_ENTRY applied, it fails at exactly this hunk.
> You don't need a replacement alpha patch, though. Once GENERIC_ENTRY
> lands, alpha's syscall entry goes through
> syscall_enter_from_user_mode_randomize_stack(), which already calls
> syscall_enter_audit() as part of the shared entry helpers
> (include/linux/entry-common.h). I applied patch 1/13 alone on top of
> GENERIC_ENTRY and confirmed alpha's entry path already routes through
> the updated __audit_syscall_entry() - no alpha-specific code needed.
> So for alpha, you can drop this patch in the next revision rather
> than rebase it.
>
> Regards
> Magnus
>

Hi Magnus,

Thanks for reviewing this patch! Ok, I'll drop this patch from the series.

Thanks!
-Ricardo


