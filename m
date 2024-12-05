Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA8EE7716D
	for <linux-um@archiver.kernel.org>; Thu,  5 Dec 2024 14:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Subject:Cc:To:From:
	Message-ID:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q2cFSaLi4lvj/HDoVWGnon1kctJ5p9ydzOJ7yYtI++M=; b=OJ4ldH7CBvpJbSIQwYX9JW6meQ
	ijwYrGMCP3Q1LOzI6cDy8tTUDTVSPJXVXvCBmDI6KssaQAZ6PYUSy5sZiy5/Fh2nSh1ufwtXXRBb3
	PGmerd5NhobwZfKmekpBRpL54NLzTNQR0KQViZK9IDzJyK1FiCSZ3e9PVRPoHy1A+z6ihNrOucCGK
	SzKW9i9VsId8VD18sKlQTGx61BXvIcNOMSi1/JhQhQ4tvqKvDg4dBoVMKON0Vw9Jz+nQBr0pw1PK6
	xIfCDaZtes6JnqjJacsj1V2/fmNAH/IXdvVtWzgH9AsSYyexo1iuUrqdCvpfojYY+AWKYUeqJtMn8
	8NZMEWUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJCSN-0000000GGxB-1OZN;
	Thu, 05 Dec 2024 14:03:51 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJCNL-0000000GFzx-09Xj
	for linux-um@lists.infradead.org;
	Thu, 05 Dec 2024 13:58:40 +0000
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2ee86a1a92dso693636a91.1
        for <linux-um@lists.infradead.org>; Thu, 05 Dec 2024 05:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733407118; x=1734011918; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q2cFSaLi4lvj/HDoVWGnon1kctJ5p9ydzOJ7yYtI++M=;
        b=RX81dyBYFIsc3wI0l6rP7FLippaElXoWi6HK4/oBwoK40WmtaKl7++o6dVmVSTFxbm
         Aqm4bf/rSacF16FkCXrCj9YbQxjctjKvhngh2/kCL7H4Pa4+zgnwIw/+imVbJCo2qY8c
         h5aIhf2w06CCkMjfMIN95BrqyncqGITa3DIm6FL+Ihypcl56QjICXd4k08UK9p6QxCRE
         CKUI4+6ZwFiMkYizpZOfwyZv19HDwDB5xr2zuQ2Wl7/aXPMg2aBDAxNxRGvKiMAlcJ9b
         1QWIfMt+i6URjT3hRHkJabOi4gavrxT2HMSuVtGrl/qti8J9tVz8nsjpydq6duIMEJgv
         XuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733407118; x=1734011918;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q2cFSaLi4lvj/HDoVWGnon1kctJ5p9ydzOJ7yYtI++M=;
        b=u2slutBpmoyBvZqu1gTduTMLXs0UZnp1LKavp4ojcdxHtUGMciRaZevsNiEjpwRRA+
         MqmHZJQit8Fb8n6oEtJC11tWAMNkt21NYSJgM2RwbTpWyz3eda7Z/G75UBsutKsqXuRD
         kvTBqkSQoyajczsy6Y6qVK96SO/38s8Rer29qOBAumMTljGGOjbnZilqF5fLco4cOFGd
         4tTwf9sXk7djJKpWc0TYhfHSbzxDhWAZ/VaaTXL75JnQ1fFVaGTarkw7Hy3o3ZoEfGoB
         Sq+Isq2ED1C2mPvDptswe01B4F2KWUMZ5VOCeNbl8GOAG0an9rYBdezYPqUxWJ+JJIl6
         WRvw==
X-Forwarded-Encrypted: i=1; AJvYcCW1Otkxcw1EZdmQNwIuXxthTN2BtRUDpoidDeY5ghXcOFPqU3XUUhIzZnh2SuBNA9rQjkQyUfA8nA==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywj77v+bV345gIWwRgJAgE9DPsPi8nlj/3K8O/altJ8l//qA3Cq
	H0+ti931RXB92hyqmzyoB0GD2TmUyUijDzz4Lr1nRqlYJwUNhcRC
X-Gm-Gg: ASbGncsxf9FQAzhtoqa0C9sREvE8PBTq9KQtLdA8B8WwsU7N0D02kceAmfKY+kCjoL/
	OfYQxcGV2AsgjvE3gJRCpbAlUJj5iPCx9N4MsAcuJNMyL1fIU5Uhe8FeIr7Gq8RgM+7wVwru3PH
	9HrC300ciomufIK68IKnFp9zMZJqVR2iZg5pq8p9AmCHtk3eFGtiE4pXvP7xaZ7G8cwfJ9pickN
	75K0u7HvIs5sKIsFmZs3GC6M/mBnyKDEPnsagtgiaF3Nnt6b8Sc3bIynNFbTej3kAtIfcC/hJb5
	L41oDPxFG5eAJkkgrAL2vnubeGtvznkNJf2J
X-Google-Smtp-Source: AGHT+IFn34tDpS+Id7TB9oBq1QZhB7ndVcw/29T5QUgCBw66JGWKn21JyUugsEpTDWnzl1gd6QZrdQ==
X-Received: by 2002:a17:90b:4fca:b0:2eb:140d:f6df with SMTP id 98e67ed59e1d1-2ef011e6829mr13551361a91.1.1733407117833;
        Thu, 05 Dec 2024 05:58:37 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef4600d3b1sm1397328a91.52.2024.12.05.05.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 05:58:37 -0800 (PST)
Date: Thu, 05 Dec 2024 22:58:33 +0900
Message-ID: <m2zflaut86.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: geert@linux-m68k.org
Cc: johannes@sipsolutions.net,
	linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: Re: [PATCH v3 08/13] um: nommu: configure fs register on host syscall invocation
In-Reply-To: <CAMuHMdV9CGXi-_yL6XBGb-es7CY6QELE8Yp79SCMdTrEAgzEQQ@mail.gmail.com>
References: <cover.1733199769.git.thehajime@gmail.com>
	<e3d540d8a9c034a76d731714ba25bab0a7bc9b4d.1733199769.git.thehajime@gmail.com>
	<8a3bead9e5664de347822a2106c53c9517131e79.camel@sipsolutions.net>
	<CAMuHMdV9CGXi-_yL6XBGb-es7CY6QELE8Yp79SCMdTrEAgzEQQ@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_055839_070782_1D954C8D 
X-CRM114-Status: GOOD (  12.78  )
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


On Thu, 05 Dec 2024 04:31:11 +0900,
Geert Uytterhoeven wrote:
>=20
> On Wed, Dec 4, 2024 at 5:53=E2=80=AFPM Johannes Berg <johannes@sipsolutio=
ns.net> wrote:
> > On Tue, 2024-12-03 at 13:23 +0900, Hajime Tazaki wrote:
> > >
> > > +static int os_x86_arch_prctl(int pid, int option, unsigned long *arg=
2)
> > > +{
> > > +     if (host_has_fsgsbase) {
> > > +             switch (option) {
> > > +             case ARCH_SET_FS:
> > > +                     wrfsbase(*arg2);
> > > +                     break;
> > > +             case ARCH_SET_GS:
> > > +                     wrgsbase(*arg2);
> > > +                     break;
> > > +             case ARCH_GET_FS:
> > > +                     *arg2 =3D rdfsbase();
> > > +                     break;
> > > +             case ARCH_GET_GS:
> > > +                     *arg2 =3D rdgsbase();
> > > +                     break;
> > > +             }
> > > +             return 0;
> > > +     } else {
> >
> > Even checkpatch complains about else after return :) No need.
>=20
> And inverting the check would reduce indentation in the largest
> branch (the smallest branch is just "return os_arch_prctl(...)".

ah, thanks.  will fix it.

-- Hajime

