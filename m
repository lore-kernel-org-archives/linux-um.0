Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D82C77B7C
	for <linux-um@archiver.kernel.org>; Wed, 25 Jun 2025 17:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CRwRhM1MtMEUcOGQgquJfle4LDepcccXWla+ZKxsdwI=; b=jwCCmV1C1m2pEfdgMVgKu2QQwm
	5MvpNZzMLFm1zywg1cQoTxw4jHszuE3gBRe6PDeyRVXhKlgbyIvNIkq5hOSB+MYrn7DfK8x0R6tQq
	GDtV8dBHXmHY4sZZMKH6OzCneSmC7tBKUqIWEDaTeQVz5dLCK6zwqLLzWHsikyZIodjg4Az+/+poV
	Ne59SXbIPhrHndoP/AL9Xv/wA7lTSbERLPCsPzMDKJPae7706HMfiKbNCTvA8vGLSm8ZErj5oCc7x
	iCq+A3HJM/H+9uheE1oIpT7OKwvJ+d9vvwzErpUoV2GJdvkR2Eqdz4QQDT6wXJehmrMkuy1Ft42ey
	XpUfvrmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUU3D-00000009TH1-0F0p;
	Wed, 25 Jun 2025 17:36:47 +0000
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUPaj-00000008gA1-3s5B;
	Wed, 25 Jun 2025 12:51:07 +0000
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-553be4d2fbfso6600154e87.0;
        Wed, 25 Jun 2025 05:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750855864; x=1751460664; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRwRhM1MtMEUcOGQgquJfle4LDepcccXWla+ZKxsdwI=;
        b=BU6xVWBg/ibbOr8gJhiMnCRzkqcQoFIE6tzMC0OIj4BF6g68VPl/UzumEvGPY3MfTl
         wg/HKuoJ1klXLDaRmQF6cI5Sxp2o8TOHaCNxa0qhZaZhUiDKnwOxC+m9ArH27u0u05zt
         C3DEfjHiRv0j/0Gfm5WHSCm5jey2zuViX4RuZgcVzTelhBklrFKpG1fu2iE4BatTyOp0
         GXikk+7mQspEcboYyaeap8AqMSjJ87zSG78ZdUVT9cnvUsQ5TILsSm71/LAcCZ8KHZqL
         YBYD2jkaJWO65p4vGEtWQyDR+F4ZxPqBkMGrQ8wC4RKrhSvqaNHSD5w+kfbhBb+xqwHm
         CGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750855864; x=1751460664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRwRhM1MtMEUcOGQgquJfle4LDepcccXWla+ZKxsdwI=;
        b=nAzwLJzs2BOQDvhCPi37AM9PTYnzIgpZp3EmlKU+48rtuBmyM5+prUoPYgTrRolvdE
         1+uIs/moVLlEvgf10OtNcUJpgl697ROp8JZv7GSDwP9eCYieyxiBciI+PvicbGFmjp39
         5bT09p1FJMzjMzYwBm6b17Mh8hAI5XJqZzT71O+uYxnVhVuy0XA7YBzXOAbP5WOeI9tN
         6Jhkr3velx6r2tz46b3eOQ2QBiqjD09/alS9PiJ6+Xf/vA2vX9uwoJUZ51BHvW3KzYh7
         SsC3XuTtpCcGbESSSwbzl3nE4jtgNAy8h1z5d86goIdUVhdiQYmZNJcjemDdqtk4K7hc
         sHNA==
X-Forwarded-Encrypted: i=1; AJvYcCUYpbtSlcMIT7a8ntjSc/EyIzcYi6HYQFrc//7L07SBWP/8WwpW/vNacIq7i81Qn+Mp5Mc+0Ok/pF0=@lists.infradead.org, AJvYcCWPW3jiXl0ulUYtvy4wmd4zvDxE7I8DbXL1Hv97notcHbpsrCOTYV8aG2KZQm7/VNctvQD2w0Mw81fEF8oqOgH8@lists.infradead.org
X-Gm-Message-State: AOJu0YwI5mwGxN25howMPdK8LWiPf/XdRclg85H/nxcAWB1/nceN6ROX
	41I6r+KQ62HgK9xbgYLg+8k2LkSCKoLmlAt6HQINiZoV+l5BLEneTjn2IWWLBI+x8T/S9coA6LZ
	Qds0Je3o6w+PPIj8fnceJfsovspEQbzs=
X-Gm-Gg: ASbGncs1kXL7nrrL14z4Dbon1Tsf11KH0EpgEoU8KOK1Ewu4F37MXFwaRDqV8183MK4
	MZGyAKZT1/o+lzPifZcyzj/2F8IwVcrzeGUxzizhUUFqLUdCJ204K2IrLi6DFnoYJvnSoYLzyCJ
	UhFmO4eqWo8FInUF7a+aLPdFaCkmsKnU0C5STh/OnsDQ==
X-Google-Smtp-Source: AGHT+IH4AdTi7obPWXsCps0Kqqd3RJ5D/he3Lezfcy1G4Eg5fA0HGJmj1VDSyHt6qyIqHAybfxlMpWZQjVgI2Xx3Mto=
X-Received: by 2002:a05:6512:4011:b0:553:297b:3d45 with SMTP id
 2adb3069b0e04-554fde58124mr1020525e87.43.1750855863865; Wed, 25 Jun 2025
 05:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250625095224.118679-1-snovitoll@gmail.com> <20250625095224.118679-3-snovitoll@gmail.com>
 <750b6617-7abf-4adc-b3e6-6194ff10c547@csgroup.eu> <81a8b60be5b99ecd9b322d188738016376aff4aa.camel@sipsolutions.net>
In-Reply-To: <81a8b60be5b99ecd9b322d188738016376aff4aa.camel@sipsolutions.net>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Wed, 25 Jun 2025 17:50:46 +0500
X-Gm-Features: Ac12FXwt1iee6Yaba3PMavifTn-RFaMv0HhE7s3qnJv0p52DgpRl1n7RcMDkzZs
Message-ID: <CACzwLxgCH6KuVDRS3d9MrmA=wY_rMA6R5TPB_v37BkD8-A9yuw@mail.gmail.com>
Subject: Re: [PATCH 2/9] kasan: replace kasan_arch_is_ready with kasan_enabled
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, ryabinin.a.a@gmail.com, glider@google.com, 
	andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com, 
	catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org, 
	kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, dave.hansen@linux.intel.com, luto@kernel.org, 
	peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	x86@kernel.org, hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	akpm@linux-foundation.org, guoweikang.kernel@gmail.com, geert@linux-m68k.org, 
	rppt@kernel.org, tiwei.btw@antgroup.com, richard.weiyang@gmail.com, 
	benjamin.berg@intel.com, kevin.brodsky@arm.com, kasan-dev@googlegroups.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_055105_962911_E517F875 
X-CRM114-Status: GOOD (  15.85  )
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

On Wed, Jun 25, 2025 at 5:24=E2=80=AFPM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Wed, 2025-06-25 at 12:27 +0200, Christophe Leroy wrote:
> >
> > Le 25/06/2025 =C3=A0 11:52, Sabyrzhan Tasbolatov a =C3=A9crit :
> > > Replace the existing kasan_arch_is_ready() calls with kasan_enabled()=
.
> > > Drop checks where the caller is already under kasan_enabled() conditi=
on.
> >
> > If I understand correctly, it means that KASAN won't work anymore
> > between patch 2 and 9, because until the arch calls kasan_init_generic(=
)
> > kasan_enabled() will return false.
> >
> > The transition should be smooth and your series should remain bisectabl=
e.
> >
> > Or am I missing something ?
> >
>
> Seems right to me, it won't work for architectures that define
> kasan_arch_is_ready themselves I think?
>
> But since they have to literally #define it, could #ifdef on that
> temporarily?

Thanks for catching it. You're right. I need to change the order of patches=
 :

- kasan: unify static kasan_flag_enabled across modes

, then we should apply arch specific changes
where we call kasan_init_generic in kasan_init.

- kasan: replace kasan_arch_is_ready with kasan_enabled

>
> johannes

