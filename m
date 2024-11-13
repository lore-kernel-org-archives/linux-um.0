Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BBED637D1
	for <linux-um@archiver.kernel.org>; Wed, 13 Nov 2024 23:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Subject:Cc:To:From:
	Message-ID:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uTdUAECq+CtjKVt4lgB+veHtw+zGn6+CLgEFY+NSyi4=; b=s5VSK4K9yJLKZ6smzY5tRBEWkp
	WgWOYIUDCCsbFQupsGV28Ou+OaIZyAQXpk1eT8R20tkL8DzPy5gPdfgkYZvaiKn79coEEcF1IiDkM
	iM3LRvo95SewdZbQd6n7OVMTaqLscFVg0RUqqkI9jZnK+wFSVB9N0VTJ4ZnW898n9mEyKuKqK93UY
	Fl/FYVKkJ2tHAupZVZP982QLzJO6XJd4rRfb9iXD2t1Sk+4t+3NySWv92PqSjqTVmS+KB2eoGcz/1
	SOEOTcJXyitbm0g/HQBAGYxdcXcOMWhynBXwbqNxEszJh0CQomgDnCp8REmXbdmmGnLUZGgLVCta7
	lt1vc4Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBMsb-00000008GP9-2pi7;
	Wed, 13 Nov 2024 23:34:33 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBMqt-00000008G99-00S3
	for linux-um@lists.infradead.org;
	Wed, 13 Nov 2024 23:32:48 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-20ce5e3b116so67429795ad.1
        for <linux-um@lists.infradead.org>; Wed, 13 Nov 2024 15:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731540765; x=1732145565; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uTdUAECq+CtjKVt4lgB+veHtw+zGn6+CLgEFY+NSyi4=;
        b=k/EdfnnrY82qs1V6o7K+bp8MTQGIyKH2fzcwN6N413WAeMSUy+Fug8Xf5IdjnUxkHw
         euEJZDax8xZdGy4MwFiv9B3oUDPPV5FnxNfcMRIYTNcPfbf5n3Bv8lMstqf4x2itCILq
         cbV5YdEZ7BnKPHHhtxiuaqbF58kTbg0BOe+xm+qvAtkIwvkeYwEIlW80UB0rp59JukEp
         0MEvvw+/ocVQDxZ+a+csZ/kiQAYcji7Epdb+DJpKSlfZb38z0ejoPMf5sfR2I0vXztE5
         Vgz/g+LpIe1LHEBxS5c9FyEljRqEVSvPPrb8IFH3sFsNGuUron1nRiggfZva0aYi9bSo
         jiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731540765; x=1732145565;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uTdUAECq+CtjKVt4lgB+veHtw+zGn6+CLgEFY+NSyi4=;
        b=HYOq8Qq7vJ1C05Cp8rei2ruhvM5vWSy/DuKdDOn/k1U4achNlJTs0KSp3GM6OJbFXP
         EY7D/GBSn0JYNDC9IXSnJ4p1gs23jfP0lziKatYEYbfuY66xbrCpk16ry/gDCUOZrnxI
         gRveFxcGij+Yxa0Wc24NMKyEVLmX+NLst3p/A2zkPDitSO5qaYcpKnyNxQWwEM8MKKU5
         n0ZIWVjjdflYvZVksA4Topshmq/hrthidNEpZte0HxFQKQjq4ccCEfmN4EcmDbHkrpqX
         /B1nAWMxh6YWo/TKvbXML4gzpemkXyrgzIXaMhwY0Q7AI66+Q6cvAgeowb+nBOeEuLQE
         IeIg==
X-Forwarded-Encrypted: i=1; AJvYcCXjJ6QesQSjCtzbN9OMrArkXKqHXyB+dELZo8jRJ6T3Sx9R6GA+Oo3baLfMuEVo1d7RTbS8bK0ugg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw0wWpr85eyD3gIGzEq0uG3Fgyjuwex069qQrGUjaJg+0XQqyc9
	XnjcbUbrFL3uBNwcXVa9wWO+GpOkSzv7sDxhQ/TuOoRXBAPphCi4
X-Google-Smtp-Source: AGHT+IFFzcICfb9N8gQggQGq1jmiucB7Uy4NC6ZmyZfMRs4qLXEYndGg+8KwFkASWQtQEkxSu0IRgQ==
X-Received: by 2002:a17:902:e807:b0:20b:a9f3:796d with SMTP id d9443c01a7336-211c5090429mr1784615ad.44.1731540765394;
        Wed, 13 Nov 2024 15:32:45 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc3f3asm115824435ad.3.2024.11.13.15.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 15:32:44 -0800 (PST)
Date: Thu, 14 Nov 2024 08:32:40 +0900
Message-ID: <m2msi2g15z.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: geert@linux-m68k.org
Cc: johannes@sipsolutions.net,
	linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	ebiederm@xmission.com,
	kees@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	gerg@linux-m68k.org,
	dalias@libc.org
Subject: Re: [RFC PATCH v2 02/13] x86/um: nommu: elf loader for fdpic
In-Reply-To: <CAMuHMdXKAz0bxBGrbbHD6haeCbhYh=pCb4stox1fOifCvyCwpw@mail.gmail.com>
References: <cover.1731290567.git.thehajime@gmail.com>
	<ea2a3fb86915664d54ba174e043046f684e7cf8c.1731290567.git.thehajime@gmail.com>
	<CAMuHMdU+Lyj3C-P3kQMd6WfyjBY+YXZSx3Vv6C2y9k__pK45vg@mail.gmail.com>
	<m2pln0f6mm.wl-thehajime@gmail.com>
	<CAMuHMdXC0BbiOjWsiN1Mg8Jkm03_H6_-fERSnFEB2pkW_VWmaA@mail.gmail.com>
	<8bbfe73f7f1ef9f1a4674d963d1c4e8181f33341.camel@sipsolutions.net>
	<f262fb8364037899322b63906b525b13dc4546c2.camel@sipsolutions.net>
	<CAMuHMdVRB46fyFKjZn3Zw2bb8_mqZasqh-J7vse-GQkA3_OQDg@mail.gmail.com>
	<m2o72jff2a.wl-thehajime@gmail.com>
	<CAMuHMdXKAz0bxBGrbbHD6haeCbhYh=pCb4stox1fOifCvyCwpw@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_153247_069449_F22183B8 
X-CRM114-Status: GOOD (  34.43  )
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


On Wed, 13 Nov 2024 22:55:02 +0900,
Geert Uytterhoeven wrote:
> On Wed, Nov 13, 2024 at 2:17=E2=80=AFPM Hajime Tazaki <thehajime@gmail.co=
m> wrote:
> > On Wed, 13 Nov 2024 19:27:08 +0900,
> > Geert Uytterhoeven wrote:
> > > On Wed, Nov 13, 2024 at 9:37=E2=80=AFAM Johannes Berg <johannes@sipso=
lutions.net> wrote:
> > > > On Wed, 2024-11-13 at 09:36 +0100, Johannes Berg wrote:
> > > > > On Wed, 2024-11-13 at 09:19 +0100, Geert Uytterhoeven wrote:
> > > > > >
> > > > > > > > > -       depends on ARM || ((M68K || RISCV || SUPERH || XT=
ENSA) && !MMU)
> > > > > > > > > +       depends on ARM || ((M68K || RISCV || SUPERH || UM=
L || XTENSA) && !MMU)
> > > > > > > >
> > > > > > > > s/UML/X86/?
> > > > > > >
> > > > > > > I guess the fdpic loader can be used to X86, but this patchse=
t only
> > > > > > > adds UML to be able to select it.  I intended to add UML into=
 nommu
> > > > > > > family.
> > > > > >
> > > > > > While currently x86-nommu is supported for UML only, this is re=
ally
> > > > > > x86-specific. I still hope UML will get support for other archi=
tectures
> > > > > > one day, at which point a dependency on UML here will become wr=
ong...
> > > > > >
> > > > >
> > > > > X86 isn't set for UML, X64_32 and X64_64 are though.
> > > > >
> > > > > Given that the no-MMU UM support even is 64-bit only, that probab=
ly
> > > > > should then really be (UML && X86_64).
> > > > >
> > > > > But it already has !MMU, so can't be selected otherwise, and it s=
eems
> > > > > that non-X86 UML
> > > >
> > > > ... would require far more changes in all kinds of places, so not s=
ure
> > > > I'd be too concerned about it here.
> > >
> > > OK, up to you...
> >
> > Indeed, this particular patch [02/13] intends to support the fdpic
> > loader under the condition 1) x86_64 ELF binaries (w/ PIE), 2) on UML,
> > 3) and with) !MMU configured.  Given that situation, the strict check
> > should be like:
> >
> >    depends on ARM || ((M68K || RISCV || SUPERH || (UML && X86_64) || XT=
ENSA) && !MMU)
> >
> > (as Johannes mentioned).
> >
> > on the other hand, the fdpic loader works (afaik) on MMU environment so,
> >
> >    depends on ARM || (UML && X86_64) || ((M68K || RISCV || SUPERH || XT=
ENSA) && !MMU)
> >
> > should also works, but this might be too broad for this patchset (and
> > not sure if this makes a new use case).
>=20
> AFAIK that depends on the architecture's MMU context structure, cfr.
> the comment in commit 782f4c5c44e7d99d ("m68knommu: allow elf_fdpic
> loader to be selected"), which restricts it to nommu on m68k.  If it
> does work on X86_64, you can drop the dependency on UML, and we're
> (almost) back to my initial comment ;-)

I checked and it doesn't work as-is with (UML_X86_64 && MMU).
restricting nommu with UML might be a good to for this patch.

even if it works, I would like to focus on UML && !MMU for this patch
series since I wish to make the (initial) patchset as small as
possible.  If we would like to make it broadly available on x86, that
would be a different patch.

> > anyway, thank you for the comment.
> > # I really wanted to have comments from nommu folks.
>=20
> I've added some in CC...

Thanks,

-- Hajime

