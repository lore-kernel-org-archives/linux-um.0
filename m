Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBE9E7716D
	for <linux-um@archiver.kernel.org>; Wed,  4 Dec 2024 19:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4xosw9NqFTKXT4FOtZe+hndAbirYXJ7xhm4lOse8Qqc=; b=EHXpVWfFjS3i3vEtNjXhIhrKaz
	06SRLj9boczyLpqG0+GOldwOvbYROFEWg3Mx8++C2DoMPKC9NVUburlLT49b9oKuy94AdQBw4/LDT
	ZnpAy5H2LexryhXVyIZEmKHHgS+x+qwg4qu3Dijxj42EfxA2U+1McHwNP27JMx7kiOw6ffIP8SgFX
	NB2tM1bAcKgwDr9oYdOwrEoezNp4ZDJUhsIEfcANx6FV78VW33DePDK8b+lqO3SEKa53g+gpsLP3F
	XVLywb1KVzmKVMBGVzWVzNDhynYPiCc8GKUCouqKALZ9bAFaPX2h/l9t6KR23qqO9gWW9BPT9o8n9
	Ta67xqww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIv5s-0000000DgtK-2hJq;
	Wed, 04 Dec 2024 19:31:28 +0000
Received: from mail-qk1-f179.google.com ([209.85.222.179])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIv5q-0000000Dgsu-1ImA
	for linux-um@lists.infradead.org;
	Wed, 04 Dec 2024 19:31:27 +0000
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b15467f383so8021085a.3
        for <linux-um@lists.infradead.org>; Wed, 04 Dec 2024 11:31:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733340683; x=1733945483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xosw9NqFTKXT4FOtZe+hndAbirYXJ7xhm4lOse8Qqc=;
        b=DygtNVzYg6sAlNlSU1KH9nVkK+v/lLww1YeJPgbYerTuB7CRlLsJCG4T4MinlRidC1
         z0Mpe35jIL+XP01etPCxSzRQNRr1d0NeNxkqBktsREz86+47nrn9X3TNYMlMKF7j2vtt
         s8eHTwM2vnnqpClq4UZNmTFoMvkOb+zfFtidJDBZu4kfFWnL8RSPaDN2m7lXi857iFGp
         fBbOiTN/JakkBzrac6tgh2+7csezeGxOWiZYqhpI+KEKOBNAA0uzKRU+WBHsHdHVmOUZ
         nf98H59DGkw1v4edpLgsKMOzickSUIaWfkOQ/KPye+7ZEXCU/VdAg+juw6gXyl4C6oxB
         NgwA==
X-Forwarded-Encrypted: i=1; AJvYcCW3XfgLUN3XVP2kEm+tJuK+ihqWChNPgJZUlDo08jND75gnUzsphKmHdVFiR7qk6msIWpoS5xWeZA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxk/u0Ol3qBO13oFwFeyE7N+8ll07PWkPoiTXIEUezpOi/uZp+x
	jKMrgTTDIIFsMK3TnE0sdxj4vw8N717PtJO3AU0u3+U5Okr/rOBDW1Ny+skn
X-Gm-Gg: ASbGncvFX6y1jAxj+LvqA7lT3JDGXbpsk6z2WSC0eQLD35KjS32eqZO3MNWJRB0uA6b
	X4ovWwQ8MQv/MDGsJw0QP/w4iTl4VatMI0dfLi++dsB01BZgkwWR+ixcbz16Z9Pr7eNiHsZ5TML
	Iv28NL2P0XkcvPDMIJneMv+UgM3b8PrculDyx4wqDLAxsHi9y+BmRo03GewieEcfrn++5ZJYYc1
	rZFYzsDDpVEspWTROxRi4ZGuMgBbf4OtSBGj5jrsn8mg2FV9cbRz5hGZqTbMtTlzSTcOpL7BbV8
	49rsFsW+80eeNnhI
X-Google-Smtp-Source: AGHT+IHFK5GVPf9NbSDTGnHV2vbCr1heQgLozEogx5FBmvxLX+nN+403AQhHXD8wjbvbaXVIcoEO3Q==
X-Received: by 2002:a05:620a:e0d:b0:7a3:5004:43dc with SMTP id af79cd13be357-7b6a5dac15bmr916213085a.40.1733340683528;
        Wed, 04 Dec 2024 11:31:23 -0800 (PST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b68492e7d3sm640504885a.46.2024.12.04.11.31.22
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 11:31:23 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b15467f383so8019985a.3
        for <linux-um@lists.infradead.org>; Wed, 04 Dec 2024 11:31:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVyEBcyQgbfnjh6FJ7W5F+waZMugAhFYvpPJ5P53q3HEujPsofkQeP3amL1vAOjsLvAtQJy97HyGQ==@lists.infradead.org
X-Received: by 2002:a05:620a:688b:b0:7b1:4f5c:6e86 with SMTP id
 af79cd13be357-7b6a5d2fa6fmr1132298485a.17.1733340682770; Wed, 04 Dec 2024
 11:31:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1733199769.git.thehajime@gmail.com> <e3d540d8a9c034a76d731714ba25bab0a7bc9b4d.1733199769.git.thehajime@gmail.com>
 <8a3bead9e5664de347822a2106c53c9517131e79.camel@sipsolutions.net>
In-Reply-To: <8a3bead9e5664de347822a2106c53c9517131e79.camel@sipsolutions.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 4 Dec 2024 20:31:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV9CGXi-_yL6XBGb-es7CY6QELE8Yp79SCMdTrEAgzEQQ@mail.gmail.com>
Message-ID: <CAMuHMdV9CGXi-_yL6XBGb-es7CY6QELE8Yp79SCMdTrEAgzEQQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/13] um: nommu: configure fs register on host syscall invocation
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org, ricarkol@google.com, 
	Liam.Howlett@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_113126_348274_33A496FA 
X-CRM114-Status: GOOD (  17.47  )
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

On Wed, Dec 4, 2024 at 5:53=E2=80=AFPM Johannes Berg <johannes@sipsolutions=
.net> wrote:
> On Tue, 2024-12-03 at 13:23 +0900, Hajime Tazaki wrote:
> >
> > +static int os_x86_arch_prctl(int pid, int option, unsigned long *arg2)
> > +{
> > +     if (host_has_fsgsbase) {
> > +             switch (option) {
> > +             case ARCH_SET_FS:
> > +                     wrfsbase(*arg2);
> > +                     break;
> > +             case ARCH_SET_GS:
> > +                     wrgsbase(*arg2);
> > +                     break;
> > +             case ARCH_GET_FS:
> > +                     *arg2 =3D rdfsbase();
> > +                     break;
> > +             case ARCH_GET_GS:
> > +                     *arg2 =3D rdgsbase();
> > +                     break;
> > +             }
> > +             return 0;
> > +     } else {
>
> Even checkpatch complains about else after return :) No need.

And inverting the check would reduce indentation in the largest
branch (the smallest branch is just "return os_arch_prctl(...)".

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

