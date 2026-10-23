Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF835606A32A
	for <linux-um@archiver.kernel.org>; Fri, 23 Oct 2026 12:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AFBwK0o2;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fNzvV8H0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Dw7ixUsZNlBi2ggGvaFZwX+nWP7PGBtWcR/4kzMhp/c=; b=AFBwK0o2TNbhLA
	Ht/oxcgJvZi1VmnMfN+dZXuana9y8wb24MzAKYcVgpos9HDSIPtbln6eBfS3RQgl9W4fNaFCi8sAv
	9lzFlj5ghGNxFADFhayhqp1AbZQ2wzDHPEsFXV1aRYg84Caj0POSTBleJL+NY2mF5MEFgMMYNRO7Q
	lYGZmSaw8RPWuojiPZlAuDdn9EHu8n9FR/SEovaNhPOK9j/wUUmdxedIESn43KmQxbBgMD2yuIeTN
	cdPdR3uqfJyj7JzNOwjyadz8rbieP2b0lhScgo9E5QRpAzDSlYK7+XbEg5TJg79bnsus1Tvh6I41p
	YADq6Pgce+xRv04VR7tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKEeT-0000000GJbU-2uxi;
	Fri, 23 Oct 2026 12:45:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKEeP-0000000GJaY-0Vd7
	for linux-um@lists.infradead.org;
	Fri, 23 Oct 2026 12:45:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792759535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dw7ixUsZNlBi2ggGvaFZwX+nWP7PGBtWcR/4kzMhp/c=;
	b=fNzvV8H0a4CGSeFaVB1kItZellOilDAi0AfZDhWTfDfKWRdS69arafzqPD1tUaxoWmXYZp
	9bIYoQsPaGp97rbfOik74ZNjU6sIvqfubZN3djzdWWu1R2g413RPBcqYZ3H+uedLKmAM1Y
	WQxv+8MCTRorQqtDETgItsta0dOw1wg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-pvWp-aHBNp-ByNH-PgQnMA-1; Fri, 23 Oct 2026 08:45:33 -0400
X-MC-Unique: pvWp-aHBNp-ByNH-PgQnMA-1
X-Mimecast-MFC-AGG-ID: pvWp-aHBNp-ByNH-PgQnMA_1792759532
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c40285df2a0so47870266b.2
        for <linux-um@lists.infradead.org>; Fri, 23 Oct 2026 05:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792759532; x=1793364332;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dw7ixUsZNlBi2ggGvaFZwX+nWP7PGBtWcR/4kzMhp/c=;
        b=Y88LJLk0yFqfffsUZY2TDVkHws1T8n7v4Ml2GpVfjZVpwuphYihDvKd62Q5vaCI8cI
         izzUz5bVrpyvMdRoakClh08ZXO0jfccYeNtE/vbFj2HsUR5uMtowb+zr0vu6FoEOZmFl
         bQnL8/Ju3i9bNnzv/hhZsCUiLmPqF64GUXIqcLB5A5cBt/WbK/ZyAduWyD3nh5dwW1jd
         tuuP0TAJfSPmNj25Rwb6xdvmEaWxxhguZMwDGvoNYCA8famIdL7OJMMJB/UrtHnHtT7/
         E8XUDfydQknyHC4m0316UeXpike71Q2Fea6yPJTjylEETFNwEGKg1S912R+s2FzhnOEo
         0eMQ==
X-Forwarded-Encrypted: i=1; AKwUvBwXIlltGr9CC0TuZizlBZBt87O+Wjw9F5ELZ/9HbiABOr+mQiryezTU+BW0xN2TpkJFswjC5w97aA==@lists.infradead.org
X-Gm-Message-State: AFq9FYJXVxWRwHKBr+Fy6XRJkwO5hgkvsya2BE32ZPVUOd61DdhrMBrJ
	yZn2ACpodHhpqCaOhZdAKJu/JfssiJkc86LSk1mQ4HVnbp+nMjIktws2AQPboykK+WdxbDfhaPL
	bfb0S7PV3KIwaX5mSUIeB1c8xnK9jhZ03fIst7GDNvAqZFvax7S7bml6V5afMD92td4XiuZvcHk
	uVApfv4STG6EzjJzLXk/M9r8E6oOob39tN+kKWGPh/tRCezHbyoYPOaA==
X-Gm-Gg: AYBFou29ZK26T4XWPbSXKb3lMafVnuPmQ1DPYz1bmJ3nuJn0nWlXmYPn1c8CxnRuLyC
	kr5ye6mSZMn7QMN/+rIsAZ3eBwWV0lAB05QDnbk0/Mt5bzCpkJCE30jaDV6LmtO7bsQoPxROwST
	JS/wOvShcUyTsEwfXj5586BKnVID85DXuNxGkmt/+ARFwCJL+33GUJhmH7NQOBYLGCU4LC2TxQC
	dT3nrIbwRk/EqyQQ46MehyI3qcIm1zIRKzcEBaXNl9n5GXegonR2uDA5aSCBH9Zsr0+lCTht8X9
	ir0=
X-Received: by 2002:a17:907:fd8a:b0:c2e:46d0:b802 with SMTP id a640c23a62f3a-c46a92ae6c0mr328361366b.40.1792759532000;
        Fri, 23 Oct 2026 05:45:32 -0700 (PDT)
X-Received: by 2002:a17:907:fd8a:b0:c2e:46d0:b802 with SMTP id
 a640c23a62f3a-c46a92ae6c0mr328354266b.40.1792759531460; Fri, 23 Oct 2026
 05:45:31 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1790088067.git.rrobaina@redhat.com> <CAHC9VhQ=FFYVNmQdiMsqg+5KDDrSC3SZS+H2=r_GkhfwQox8tg@mail.gmail.com>
 <CAABTaaBL=TScs8Qqu3b8F6KZPGMyvwy6cBC3teDaBL6MGMucNg@mail.gmail.com> <CAHC9VhROsmzbm+AP63Sm7mqCokgEy6Zu0AVMY0gxp8qY75Pqiw@mail.gmail.com>
In-Reply-To: <CAHC9VhROsmzbm+AP63Sm7mqCokgEy6Zu0AVMY0gxp8qY75Pqiw@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Fri, 23 Oct 2026 09:45:20 -0300
X-Gm-Features: AclHuK-AKUESe6iHVc-VzwOYib6sgRKlK0BCnAtM6wg5S60Ozyo0oOLLHvDr8CI
Message-ID: <CAABTaaBOrPknzdxc5S6L9hGu7hbFu2e1RZG=Sxjb_B1Cs4Sixw@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: 2keVsAC-c1ek77YRQv9A3Uan9gYiLX4cV04ca-vWoo8_1792759532
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_054537_239954_8964E534 
X-CRM114-Status: GOOD (  17.22  )
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 1:39=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Oct 13, 2026 at 8:36=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.=
com> wrote:
> > On Thu, Oct 1, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > On Tue, Sep 22, 2026 at 3:21=E2=80=AFPM Ricardo Robaina <rrobaina@red=
hat.com> wrote:
>
> ...
>
> > > * As pointed out by Sashiko, when you were converting all of the
> > > arches, it looks like you missed alpha.  I took a quick look and it
> > > appears that it should be a pretty straightforward conversion like
> > > most of the others.
> >
> > I've actually dropped the alpha patch as per Magnus's request [1].
> >
> > [1] https://lore.kernel.org/audit/CA+=3DFv5T4826T2sd0Gbh-nfZsqcWK_phdBK=
y4BLWOvDTt92t5Eg@mail.gmail.com/
>
> The problem is that as things stand, this patchset breaks the build on
> Alpha.  Perhaps this gets resolved during the current merge window,
> but as you know we can't break the kernel build ...
>
> https://lore.kernel.org/oe-kbuild-all/202610041836.6TatRQSm-lkp@intel.com

Of course, you're absolutely right that we can't break the build. I
was afraid that this dependency might cause trouble.

I noticed Magnus posted a pull request a few days ago containing the
"alpha: enable GENERIC_ENTRY" series [1]. It seems this will get
resolved during the current merge window.

For future reference, what's the best way to handle dependencies on
other subsystem changes like this?

[1] https://lore.kernel.org/linux-alpha/ataJlL6L7TrS3gWs@z440.darklands.se/

>
> --
> paul-moore.com
>

-Ricardo


