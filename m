Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF28C4707B
	for <linux-um@archiver.kernel.org>; Thu, 18 Jan 2024 13:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b4b0LLliuCOAaB/+bqKwEsRh79KlqJSMvD21v/eWgQA=; b=xzhA+jzYJ1Nztu9070To0dj0Dd
	dcWslWU+uIXHeUfcHEdh1y1Ni4iAZcAy+E+1nVVYZm/cpZ4jCIJE4XhqEVR8JFl+3lvc+KiA4Nh2x
	tqFvKgn/S3KrTCqSU3/XHpsTkosBUDmXMGXMu4HDdb5RxleF5XhjcCBY6nJjH3wdt15tul5rfCjZj
	ShREOqQ3Wm5waZW8dSYNkGl3mhGxxv/0Q6HHZEdZmMq62qv9AjRz3rBY5qWGJhlJrwtghbmtO+eWw
	85FXunYbYQ1/+N+fGhCdUC4HxI16EBDbHxcG0fIcF00Sru+4WltwuUNZU5vNg9yuyHwKqxgytqBBp
	uNzZvVeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQShe-002sbV-3C;
	Thu, 18 Jan 2024 13:45:06 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQSha-002sas-2i;
	Thu, 18 Jan 2024 13:45:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 6032EB817FE;
	Thu, 18 Jan 2024 13:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC82FC433B2;
	Thu, 18 Jan 2024 13:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705585500;
	bh=gT28Fh3wl8eP/Ljj2XHYVD5ng9wv0/Gy376PoOmymDk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u+3MZbe8ibF/PsJaydFqyRJp8ldbVeNDlHnif9pS4/4cGJp0RDYpZPhpESX+qacPH
	 onPkEixPpCI3mbAQKsqT0BLkRVtfsZwSSr2vEPj79v1OGDs/jP3+P2iwCV9iefkdef
	 6QFcZms6XzJ8vIAUbW2367Ls8jD8nMfDaMUStiiTGymyegb1QmsgMVKR0Efw0kOD2X
	 THGk7SORQtBkEz0/HgFmjH97kcFVNO6kgR6k42jCF/B5U7i9ivjOs0RtUs84cdmoqb
	 1k6B1051EFaLPbHRejKw8QHcE007AYh4dLHDYkq67M+cnoRyuHj1bOBwTNVMa0pDs1
	 6N9eImRIzo7Qg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cd2f472665so130420171fa.2;
        Thu, 18 Jan 2024 05:45:00 -0800 (PST)
X-Gm-Message-State: AOJu0YzMzT3iRhgVkK0/qNpq+P3HQQMkSFgoegnAu4tkLmpg6r6NKtqt
	QlGvjIla0h5coQCW3mogS382N7/Cc6/MGWAB7DZgxOsV4KANtKmTnq6S+ipZZd9E1pCWEaeA4DA
	QZxYf+HsUi6fS+N9+hQUA361OgA==
X-Google-Smtp-Source: AGHT+IHanadODpHlW5kv28ZPQQm1BxNO/Q4y3N+LkzY5cQvNMtQPZvXZQU5q6BYEcqxNmpGoLRuQA+l7epkP//J5f0Q=
X-Received: by 2002:a05:651c:107:b0:2cd:9e6c:7f3f with SMTP id
 a7-20020a05651c010700b002cd9e6c7f3fmr625521ljb.71.1705585498933; Thu, 18 Jan
 2024 05:44:58 -0800 (PST)
MIME-Version: 1.0
References: <20240112200750.4062441-1-sboyd@kernel.org> <20240112200750.4062441-5-sboyd@kernel.org>
 <20240115203230.GA1439771-robh@kernel.org> <cdaadf62222a705cda198dd96dc7c73d.sboyd@kernel.org>
 <20240117174114.GA2779523-robh@kernel.org> <CAMuHMdXg1Y7mwHKTYi_j7a_XGdMJ7Aa7u5dEv5+xsLe8=BMaRw@mail.gmail.com>
In-Reply-To: <CAMuHMdXg1Y7mwHKTYi_j7a_XGdMJ7Aa7u5dEv5+xsLe8=BMaRw@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 18 Jan 2024 07:44:46 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLO89y6577ACi7s4Zhpexszp3Bby=tKMEoDGzK9MY+9Bw@mail.gmail.com>
Message-ID: <CAL_JsqLO89y6577ACi7s4Zhpexszp3Bby=tKMEoDGzK9MY+9Bw@mail.gmail.com>
Subject: Re: [PATCH 4/6] of: Create of_root if no dtb provided by firmware
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	devicetree@vger.kernel.org, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240118_054503_185275_342934B3 
X-CRM114-Status: GOOD (  43.17  )
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

On Thu, Jan 18, 2024 at 2:46=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Rob,
>
> On Wed, Jan 17, 2024 at 6:41=E2=80=AFPM Rob Herring <robh@kernel.org> wro=
te:
> > On Tue, Jan 16, 2024 at 05:18:15PM -0800, Stephen Boyd wrote:
> > > Quoting Rob Herring (2024-01-15 12:32:30)
> > > > On Fri, Jan 12, 2024 at 12:07:47PM -0800, Stephen Boyd wrote:
> > > > > diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> > > > > index da9826accb1b..9628e48baa15 100644
> > > > > --- a/drivers/of/Kconfig
> > > > > +++ b/drivers/of/Kconfig
> > > > > @@ -54,9 +54,14 @@ config OF_FLATTREE
> > > > >       select CRC32
> > > > >
> > > > >  config OF_EARLY_FLATTREE
> > > > > -     bool
> > > > > +     bool "Functions for accessing Flat Devicetree (FDT) early i=
n boot"
> > > >
> > > > I think we could instead just get rid of this kconfig option. Or
> > > > always enable with CONFIG_OF (except on Sparc). The only cost of
> > > > enabling it is init section functions which get freed anyways.
> > >
> > > Getting rid of it is a more massive change. It can be the default and
> > > kept hidden instead? If it can't be selected on Sparc then it should =
be
> > > hidden there anyway.
> >
> > The easier option is certainly fine for this series. I just don't want
> > it visible.
> >
> > > > >       select DMA_DECLARE_COHERENT if HAS_DMA && HAS_IOMEM
> > > > >       select OF_FLATTREE
> > > > > +     help
> > > > > +       Normally selected by platforms that process an FDT that h=
as been
> > > > > +       passed to the kernel by the bootloader.  If the bootloade=
r does not
> > > > > +       pass an FDT to the kernel and you need an empty devicetre=
e that
> > > > > +       contains only a root node to exist, then say Y here.
> > > > >
> > > > >  config OF_PROMTREE
> > > > >       bool
> > > [...]
> > > > > @@ -195,6 +191,17 @@ static inline int of_node_check_flag(const s=
truct device_node *n, unsigned long
> > > > >       return test_bit(flag, &n->_flags);
> > > > >  }
> > > > >
> > > > > +/**
> > > > > + * of_have_populated_dt() - Has DT been populated by bootloader
> > > > > + *
> > > > > + * Return: True if a DTB has been populated by the bootloader an=
d it isn't the
> > > > > + * empty builtin one. False otherwise.
> > > > > + */
> > > > > +static inline bool of_have_populated_dt(void)
> > > > > +{
> > > > > +     return of_root !=3D NULL && !of_node_check_flag(of_root, OF=
_EMPTY_ROOT);
> > > >
> > > > Just a side comment, but I think many/all callers of this function =
could
> > > > just be removed.
> > > >
> > > > I don't love new flags. Another possible way to handle this would b=
e
> > > > checking for "compatible" being present in the root node. I guess t=
his
> > > > is fine as-is for now at least.
> > >
> > > Ok. I can add a check for a compatible property. That's probably bett=
er
> > > anyway. Should there be a compatible property there to signal that th=
is
> > > DT isn't compatible with anything? I worry about DT overlays injectin=
g a
> > > compatible string into the root node, but maybe that is already
> > > prevented.
> >
> > I worry about DT overlays injecting anything...
> >
> > I don't think it is explicitly forbidden, but I have asked that any
> > general purpose interface to apply overlays be restricted to nodes
> > explicitly allowed (e.g. downstream of a connector node). For now, the
> > places (i.e. drivers) overlays are applied are limited.
> >
> > We could probably restrict the root node to new nodes only and no new
> > or changed properties.
>
> Changing (<wild dream>or appending to</wild dream>) the root
> "compatible" and/or "model" properties is useful in case of large
> extension boards, though.  This is also the case for DTBs created from
> a base DTB and one or more overlays using fdtoverlay.

I think appending by adding another compatible value could be okay.
Removing or appending to an existing entry is not. We don't want the
following sequence to be possible:

of_machine_is_compatible("foo") --> true
apply overlay
of_machine_is_compatible("foo") --> false

For Stephen's case, it's going from no root compatible at all to
something. I don't think your case would apply here. To put it another
way, if we've booted with ACPI, compatible in the root node is not
valid.


> For the latter, see also the following threads, where you weren't
> (but probably should have been) CCed:
>
> [1] "[PATCH v9 2/2] arm64: boot: Support Flat Image Tree"
>      https://lore.kernel.org/all/20231202035511.487946-3-sjg@chromium.org
> [2] "Proposal: FIT support for extension boards / overlays"
>     https://lore.kernel.org/all/CAPnjgZ06s64C2ux1rABNAnMv3q4W++sjhNGCO_uP=
MH_9sTF7Mw@mail.gmail.com

That all seems pretty orthogonal to the issues here.

Rob

