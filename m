Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5364606A324
	for <linux-um@archiver.kernel.org>; Wed,  4 Nov 2026 00:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fkM1kAOf;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=QUGb8K8u
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=fPNnZyQIDXSKNoVkiNoUdoJZWsQu0g4dBkxCnrIJvKA=; b=fkM1kAOfdmiq1y
	kAG91WOVS34eDjmCUXbGygzVtMMaH9OhigkcNeHLyjKdDc4WcViDL+IEan/4VJ6BLjOdclL3172Va
	U+cBftfU8AcY5e/SbqAV0xzcbKI+i1X+t2P05E8f5dM3/pP2PowoLgp1r71VCsqV0wAMg+PXzTyUv
	NRBpnGzJtp6lRG7fTxUH3wQuAqgxbkFBN4nCCoS3QFp9y+bVXbBnEs1z1HjqNCDlJwsBGpog3bz07
	xiRSlxTTZ39FYfxkKVRYPLSgtLnZh1Fv51hhLuqfcnxhRkVCymezFiYwk4HrnenVTTELLP3wGv1uz
	qsMeoL1O67jTgh1SQrhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOP3s-000000040Uf-0YxM;
	Wed, 04 Nov 2026 00:41:08 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOP3o-000000040Tr-31ic
	for linux-um@lists.infradead.org;
	Wed, 04 Nov 2026 00:41:06 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-8a60f90a924so95653b3a.3
        for <linux-um@lists.infradead.org>; Tue, 03 Nov 2026 16:41:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793752863; cv=none;
        d=google.com; s=arc-20260327;
        b=bbXxT64kBkl/LBm7as8zVfo75qdn/vmz9fBeVuZk/JD7xebTI8G781zTKGFCx6FxwC
         BVTWyemt9ZEKAsgfmltiqx31MHUPYQrPtDPmI/AaOlq2HyUkUFG3p5AgGAuX3NOvfusj
         2o92h0L9GtAhU+BDm4yTn+tnQlduohcX3SYvhm91CO1U0L/I+fsBIoCeFDoJCY3n/3d8
         7nNFOR/sMe6V4bnxDarSt25bQnTqe/neB1KNWoP+HiuKr1EwF3taoCpHuXAnKZAl/5V4
         cwIx+ObMH5fz+tTI4HJxpNjs6QwcV5TcrPinymoIGj6T+5otHRxP9VO/0bQBgFHENAn2
         5YOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fPNnZyQIDXSKNoVkiNoUdoJZWsQu0g4dBkxCnrIJvKA=;
        fh=9WXnCWOUF1fZaGy0Sph/EYDHOYSCnmsYPghe3pxfiEY=;
        b=dRGCP84j1PqtTlKrNWBhHBfn+eO4eOjcomCM5HNpHdwNGxFRxi4g0UQw8oLNt6Npal
         LNsP6luvrbpE7ZX0QE2ShZnBpPFSvoX4+vn4CsqSVN+/9UeG/JTsRxOSN11fP7jhLTOz
         oR+6VTnhDfMJzkOZigM/wYfjbH5Tuu43PqhT3P85zsZEW8m8Vyq0aeybmrkA1t1XXKA9
         I0YkhHuawY1skU/AwtfZMA5fH/fhQSxsH4GAJjs/N6UaDBORvf78/Jyx/+mmggDGg2nk
         0WImf7Se7qGReyiseHlPB9UVRr/wzc9a+mJRxRK2VkhHToocFgTbyyL1YYQ6GLXlD1NB
         ySxA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793752863; x=1794357663; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fPNnZyQIDXSKNoVkiNoUdoJZWsQu0g4dBkxCnrIJvKA=;
        b=QUGb8K8umTn2hWfFZYytEB+qhak/mfmfyIHYnpbI9DKFoFmzq1DZWmx7rScW2aEaCn
         YBWm/DuOHGdfK8p3p8+n466BrY5PZBo+nC+dKIjhHuk8A/jF/GpQK/gA7JF8DraTmAqc
         mQBuGfqxkcoxkM8jLKU+0dBQ9MeVKY3QbnWWR03eBVQkxuxQjF/J5iKuNJwyjFe16Jic
         pjQYAJsuD8WyvcnNMPXF2bgJb37ebs/Sb6KJFf71AvDIEbWfHeNIulOgwymq+yBOc/yE
         ojMbDaZS+Ul16aOXuosa16i4sOredb30MAJyCmSIuB93cTM872a75TLumx8zJ51OC8Nc
         mmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793752863; x=1794357663;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fPNnZyQIDXSKNoVkiNoUdoJZWsQu0g4dBkxCnrIJvKA=;
        b=AuP4ixoyLdfnaEYVeg5S600pQxllec9cSAyHpj2u8n+VlXHm2jydpb232p1n/hwTCc
         mXcbgFG2y1VZFVihxlW/+Idfp/ukpGS4OAHGQDg6bP+CJ+DwOiFFrBPTTLGBtvPysQ0N
         r4Usdin7Nr4SXjo8MDaPnfUR0XamzGaK8BWfXZxDqxfo8RqF3WZsqb6ib3GgtajHTBeY
         8MF4E2ShqNrH/jg6nR6IrW752WUnyfi6f4xKHtbOU9Q8BilihFhpCo6wSpKt1MWTL7hW
         kg/YGk27+dO1m4QKPI5/MbBi0n2MlSf9T/XYmjbV+LsTVDfQU+W3ciGol9iyIDA8lHqa
         jfwQ==
X-Forwarded-Encrypted: i=1; AKwUvBzW0+e4CvIdtXgZZ7oztiLj+daPatRFQ/C9tLeBdlwQcA+/paNfZ1jauICfm7nXafwTGLqdWl7Heg==@lists.infradead.org
X-Gm-Message-State: APuU4Z+6ViH3179b4R4BphxJvcj6ZBzt2db/p85SNlTAtc4GI1rPwhfd
	ZBE5oxpWS/iXyTnrJWtURKmc5M5WRgvCk1T+7fYtkvAQIH5KZRiD9evhD9xJtNE2HnDd5kop1RB
	hNy4vKlOS2PuUsEvRQDcxbNeQ5u5bx4quQPrCAfCb
X-Gm-Gg: AYBFou1wUkNTtaYdnhkX3+CHq5J7n1auG2fdIHm5pqvY9doTHjDrY+xHebbxEHx4xC1
	WMVp1pubYLpQLIFFIk/1+vlbXVhEtf9vPrznIew6Ln63o2Q4++R5iHBAQGdox6wVoUXX5Acn/zq
	CVxxakDEpvDwUyBZbJlUprPXgcoMxl9mlQf9Dptnw5ag/Q5A1cdeWjpX+kNttQj7Ekm1g7NqIpe
	GFYi/XmrWildTXHC+LXoJgXIBEAXKpp7VWMfV19ZMbIoNehtByMsDDOZx/ZxkRKZq815HsGE86A
	2e6oyhN/d7NydxLHe2GZbEiH6zwHCUHMjWmNWpGmyirApgMWRUHsQs35nLoyWp+dwP4DivUkfDA
	j7WEr136Xqogq8siS0y4dJdcBCRvYVZbgUppyr7iyTrRz4B9ag+c/ZUHHOrrHE3JVeVaw
X-Received: by 2002:a05:6a00:2d96:b0:88d:4b30:1c11 with SMTP id
 d2e1a72fcca58-8a9ba703bc9mr11394030b3a.6.1793752863107; Tue, 03 Nov 2026
 16:41:03 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1790088067.git.rrobaina@redhat.com> <CAHC9VhQ=FFYVNmQdiMsqg+5KDDrSC3SZS+H2=r_GkhfwQox8tg@mail.gmail.com>
 <CAABTaaBL=TScs8Qqu3b8F6KZPGMyvwy6cBC3teDaBL6MGMucNg@mail.gmail.com>
 <CAHC9VhROsmzbm+AP63Sm7mqCokgEy6Zu0AVMY0gxp8qY75Pqiw@mail.gmail.com> <CAABTaaBOrPknzdxc5S6L9hGu7hbFu2e1RZG=Sxjb_B1Cs4Sixw@mail.gmail.com>
In-Reply-To: <CAABTaaBOrPknzdxc5S6L9hGu7hbFu2e1RZG=Sxjb_B1Cs4Sixw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Nov 2026 19:40:51 -0500
X-Gm-Features: AclHuK_mzIhdjHPxjnkTYRthyfMgrzjS55JZuNf6mZPYYsQQvO81kKGlvJUv8_0
Message-ID: <CAHC9VhQ4U-Z2KkGurfMihJgzGgwD3miWSW4wWAjWvUdDxLpH7Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] audit: log all six syscall arguments in the
 SYSCALL record
To: Ricardo Robaina <rrobaina@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_164104_765110_54ED48AF 
X-CRM114-Status: GOOD (  24.13  )
X-Spam-Score: -2.1 (--)
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

On Fri, Oct 23, 2026 at 8:45=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
> On Tue, Oct 20, 2026 at 1:39=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Tue, Oct 13, 2026 at 8:36=E2=80=AFAM Ricardo Robaina <rrobaina@redha=
t.com> wrote:
> > > On Thu, Oct 1, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > > On Tue, Sep 22, 2026 at 3:21=E2=80=AFPM Ricardo Robaina <rrobaina@r=
edhat.com> wrote:
> >
> > ...
> >
> > > > * As pointed out by Sashiko, when you were converting all of the
> > > > arches, it looks like you missed alpha.  I took a quick look and it
> > > > appears that it should be a pretty straightforward conversion like
> > > > most of the others.
> > >
> > > I've actually dropped the alpha patch as per Magnus's request [1].
> > >
> > > [1] https://lore.kernel.org/audit/CA+=3DFv5T4826T2sd0Gbh-nfZsqcWK_phd=
BKy4BLWOvDTt92t5Eg@mail.gmail.com/
> >
> > The problem is that as things stand, this patchset breaks the build on
> > Alpha.  Perhaps this gets resolved during the current merge window,
> > but as you know we can't break the kernel build ...
> >
> > https://lore.kernel.org/oe-kbuild-all/202610041836.6TatRQSm-lkp@intel.c=
om
>
> Of course, you're absolutely right that we can't break the build. I
> was afraid that this dependency might cause trouble.
>
> I noticed Magnus posted a pull request a few days ago containing the
> "alpha: enable GENERIC_ENTRY" series [1]. It seems this will get
> resolved during the current merge window.

... and it has, or at least it appears to me to be resolved.  I
rebased the audit/dev-staging branch against v7.4-rc1 and Alpha does
indeed appear to be using the generic syscall entry/exit code in v7.4.
I think we should be all set here wrt Alpha, thanks.

> For future reference, what's the best way to handle dependencies on
> other subsystem changes like this?

Generally speaking communication and coordination :)  Talk with the
subsystem devs/maintainers to understand what they are doing, let them
know what you want to do, and find the best way to order things so
that it all lands in Linus' tree without making a mess.  In this
particular case, with the syscall arg audit patchset not being ready
(missing maintainer ACKs) and the Alpha changes going into v7.4 it
turns out to be quite easy, which is an important lesson: sometimes it
is better to defer a new feature for a release just to ease the
coordination burden, enable better testing, etc.

--=20
paul-moore.com

