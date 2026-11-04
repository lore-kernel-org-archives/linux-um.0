Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84F7606A332
	for <linux-um@archiver.kernel.org>; Wed,  4 Nov 2026 13:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jJIng37Q;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=apDpBAmV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=JLATmvImDg/5VrDBag7NLO/Ra27QQfElNkmu7cHAdiY=; b=jJIng37QNH8tGd
	iHz1IBKa7XleRkDueBCHNeTh/g060YcNKUsVzi9CqIkR7Si98AQFKCfUqERfkxv3U+9n2aTSos9Db
	shiiyuFWKADZu+FU/mlZfgY1SkWNXaIZWEN9bEs7PR2MY9ltYyw/bKwHCM8i9BMURn4ixn2Anr9JU
	p6eYqnhbznfLWOCUOP6DG+fvP8XZpBoCFvoTPwNeeb4kBV+fQjHVAZS+gt6z4dExxVUxu/bL8DmcN
	qt5trvYufmi7/CgQkPXkvOG/eb3Of4i011Esn0jCNDliC+h0FrHabecjxGOSkcuI31ZEBVJmI6phN
	fk7w9oyrp7vWqANB6mPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObGc-00000005VXJ-1Tdv;
	Wed, 04 Nov 2026 13:43:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObGY-00000005VWf-3YZ5
	for linux-um@lists.infradead.org;
	Wed, 04 Nov 2026 13:43:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793799780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JLATmvImDg/5VrDBag7NLO/Ra27QQfElNkmu7cHAdiY=;
	b=apDpBAmVyHsE8c3Flsxy9Ca82GUT6I+55gzpzWCTdUXVsJI9n3ccEwuf4/Obnn4yWBkAem
	HqBD5dLRmJdJxj8R2GQC20jDlFRwYnvfSKyGcVECq60ENLzqVljorLRXl3T1yOpIX/xvrC
	d+bSQqkg0EFxXymI/5arWzTYgt9yAJo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-X3FVxUbjMAC11g2Ni80rJQ-1; Wed, 04 Nov 2026 08:42:59 -0500
X-MC-Unique: X3FVxUbjMAC11g2Ni80rJQ-1
X-Mimecast-MFC-AGG-ID: X3FVxUbjMAC11g2Ni80rJQ_1793799778
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c4d1684d1b3so57479466b.1
        for <linux-um@lists.infradead.org>; Wed, 04 Nov 2026 05:42:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793799778; x=1794404578;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JLATmvImDg/5VrDBag7NLO/Ra27QQfElNkmu7cHAdiY=;
        b=SYflf2t5xvRlVCkLOKVHcwEQv2078WEhHZ9z3GuGJNqZ14NUoemvttqq+8d0xYaaNH
         LHB2OBqB18QmZUMc/vvDSIo5fnvNKMw4b8vh8tIp5vFcg+AbuHOmThSKw2fcc1d50vjI
         bw9NvzYETXrpCk1h1XpEDTUyzFIbr6Ew4XBipIY3H6JbESzPnKenkeroJOu7yFV545Yu
         r6pX02N9mqoauyw394DlG0GgY4H/+0UnLgT79HSEAaM1RMW4hS7KOQucwSB+0yEjWlkP
         VC3mztLZcgRC0ZnhdtBgglu0JjbueFJpOwotqZElY38X+2qU3TqesJ28jbRhqPxzuhvC
         XdaA==
X-Forwarded-Encrypted: i=1; AKwUvBwt/R4UnnsPKZ+6aBT1wW2EnpmS3Axx5pqboJWde0TnyeSjZ8HUspFLLK8rhEwVan5UnUGSMgN85w==@lists.infradead.org
X-Gm-Message-State: APuU4Z8/5k7XIIeDc3dDdyr0gd3oBZhbF4kSkUa8l2cCnRs4xvF6g/kR
	dNEKmK4lcvYCm53Z3TopDTi4MnOA+ILs+qrkuCvmpvNfUfoqswG7UCfH5T6uiAfcv1o4J5S9k2m
	MOqPewrtVck29Drn1lcRCcNDDMGG4AS5YjwejWts5cJur/1HGDwcgTzC7X3uAp3XIWnkj75yV0f
	/L05uNGy9MVV73TAOZBdWQJAhoXrqBbjHl2gV2mBsI
X-Gm-Gg: AYBFou2uDFNkFE+kbxMeTLBredNu2BiN0vDYMYf3kJx3uDVgbq8NtChSgbOsudHEMTY
	k6mtTR1SvW3nF6uZO+/7KH9E9qgwQmnaSj/96ZHbEv+0SqdMeTD+ZP3RbcRwr3ADEMEXJs/6ARD
	PPy3KDvwvsX5mx7hFFHLdgmR1gp6m17bJNGemZzgT4WFlqe4/aCjrOqsXH6ylboW94l+CxOHARo
	1B5QMPDlf/di0dW4D2yNvY4Suw8kBLZwaKrfwpm9NH+sw==
X-Received: by 2002:a17:907:1ca4:b0:c24:adf4:5c73 with SMTP id a640c23a62f3a-c4ca795d0cemr1327724166b.1.1793799778224;
        Wed, 04 Nov 2026 05:42:58 -0800 (PST)
X-Received: by 2002:a17:907:1ca4:b0:c24:adf4:5c73 with SMTP id
 a640c23a62f3a-c4ca795d0cemr1327717466b.1.1793799777447; Wed, 04 Nov 2026
 05:42:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1790088067.git.rrobaina@redhat.com> <CAHC9VhQ=FFYVNmQdiMsqg+5KDDrSC3SZS+H2=r_GkhfwQox8tg@mail.gmail.com>
 <CAABTaaBL=TScs8Qqu3b8F6KZPGMyvwy6cBC3teDaBL6MGMucNg@mail.gmail.com>
 <CAHC9VhROsmzbm+AP63Sm7mqCokgEy6Zu0AVMY0gxp8qY75Pqiw@mail.gmail.com>
 <CAABTaaBOrPknzdxc5S6L9hGu7hbFu2e1RZG=Sxjb_B1Cs4Sixw@mail.gmail.com> <CAHC9VhQ4U-Z2KkGurfMihJgzGgwD3miWSW4wWAjWvUdDxLpH7Q@mail.gmail.com>
In-Reply-To: <CAHC9VhQ4U-Z2KkGurfMihJgzGgwD3miWSW4wWAjWvUdDxLpH7Q@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 4 Nov 2026 10:42:46 -0300
X-Gm-Features: AclHuK9fArBl2NqgMDWGc__kMOSMhBxMeP1FQYdilvQJHUxXbryD-TLWb0XsxW4
Message-ID: <CAABTaaAYn1oBwHSkoGm0a98c9YUZKf6ie=yUOtR4FQuSjrusjg@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] audit: log all six syscall arguments in the
 SYSCALL record
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, eparis@redhat.com, 
	sgrubb@redhat.com, oleg@redhat.com, richard.henderson@linaro.org, 
	mattst88@gmail.com, linmag7@gmail.com, linux@armlinux.org.uk, 
	catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, monstr@monstr.eu, 
	tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _1mlYt1XqqBRGbvgI9WS_l0IjfndqR6E40cw3D2DYKM_1793799778
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_054302_966049_82205736 
X-CRM114-Status: GOOD (  28.68  )
X-Spam-Score: -2.8 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 3, 2026 at 9:41=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Fri, Oct 23, 2026 at 8:45=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.=
com> wrote:
> > On Tue, Oct 20, 2026 at 1:39=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Tue, Oct 13, 2026 at 8:36=E2=80=AFAM Ricardo Robaina <rrobaina@red=
hat.com> wrote:
> > > > On Thu, Oct 1, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.=
com> wrote:
> > > > > On Tue, Sep 22, 2026 at 3:21=E2=80=AFPM Ricardo Robaina <rrobaina=
@redhat.com> wrote:
> > >
> > > ...
> > >
> > > > > * As pointed out by Sashiko, when you were converting all of the
> > > > > arches, it looks like you missed alpha.  I took a quick look and =
it
> > > > > appears that it should be a pretty straightforward conversion lik=
e
> > > > > most of the others.
> > > >
> > > > I've actually dropped the alpha patch as per Magnus's request [1].
> > > >
> > > > [1] https://lore.kernel.org/audit/CA+=3DFv5T4826T2sd0Gbh-nfZsqcWK_p=
hdBKy4BLWOvDTt92t5Eg@mail.gmail.com/
> > >
> > > The problem is that as things stand, this patchset breaks the build o=
n
> > > Alpha.  Perhaps this gets resolved during the current merge window,
> > > but as you know we can't break the kernel build ...
> > >
> > > https://lore.kernel.org/oe-kbuild-all/202610041836.6TatRQSm-lkp@intel=
.com
> >
> > Of course, you're absolutely right that we can't break the build. I
> > was afraid that this dependency might cause trouble.
> >
> > I noticed Magnus posted a pull request a few days ago containing the
> > "alpha: enable GENERIC_ENTRY" series [1]. It seems this will get
> > resolved during the current merge window.
>
> ... and it has, or at least it appears to me to be resolved.  I
> rebased the audit/dev-staging branch against v7.4-rc1 and Alpha does
> indeed appear to be using the generic syscall entry/exit code in v7.4.
> I think we should be all set here wrt Alpha, thanks.

I'm happy to hear it.

>
> > For future reference, what's the best way to handle dependencies on
> > other subsystem changes like this?
>
> Generally speaking communication and coordination :)  Talk with the
> subsystem devs/maintainers to understand what they are doing, let them
> know what you want to do, and find the best way to order things so
> that it all lands in Linus' tree without making a mess.  In this
> particular case, with the syscall arg audit patchset not being ready
> (missing maintainer ACKs) and the Alpha changes going into v7.4 it
> turns out to be quite easy, which is an important lesson: sometimes it
> is better to defer a new feature for a release just to ease the
> coordination burden, enable better testing, etc.
>
> --
> paul-moore.com
>

Thanks, Paul!


