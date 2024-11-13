Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDA7D41C3E
	for <linux-um@archiver.kernel.org>; Wed, 13 Nov 2024 13:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Subject:Cc:To:From:
	Message-ID:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GASOn7QbrM9ZEmoRoXiZ13AI8Ncr2uZ/48itT1ixPSo=; b=JDb2xmv6WNZQJheQTfLBKLZ93m
	6G7rmUpI96nmbsRX3mYSnrW9we7C6CcpOyK/nsTeu8SLriAuY9XzlptKC3dpqZAoS5sH1F536YDnZ
	muTsUA/c8qep8vrVdR8aXpafiIfap+Ifam1cv0kZR7xVF65qDdcSnNw17Ej/8Oto04i8xXznvPPNL
	Q6n8BrmLX+/j9a+a3Gx/LTUHzhOcChgb9UDR/3p52OeMM9o0gWBl2GlIawxjCIm5a+Ziffp75Z7xL
	VJvWulcq692t4c0FUqYUQkTHUdXjJ6B7lVWXSBguKGD4msBhF/B3xmmiwNhsRelQKi9bNBQz3iVcR
	ZQ8jpiSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBDFs-00000006tNc-47xc;
	Wed, 13 Nov 2024 13:17:56 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBDFr-00000006tNI-0ZkF
	for linux-um@lists.infradead.org;
	Wed, 13 Nov 2024 13:17:56 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-21145812538so63409405ad.0
        for <linux-um@lists.infradead.org>; Wed, 13 Nov 2024 05:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731503874; x=1732108674; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GASOn7QbrM9ZEmoRoXiZ13AI8Ncr2uZ/48itT1ixPSo=;
        b=X/y1CDrSnR3Bw3paNVlrBdVsNZRPnm6aUL3nuQzl1Ps/e8vi6PUCnj/B0l5K1eiLkO
         i8ufXFCHL+cRrhsGVUQg9VFG2B8TFZLwsKTaIq8JH/ffHrVfgLKKtPWgs+yq/n5LN+TG
         jluXfUz2VX/b0qUzlbyabmAx18JA8O6HDDQ6eT0FAxz2e6cawyM+ZQH5NU09OdshexEx
         XPNbWDFG4ZkoBCHY+B1VF3CD1++fxxXvDicgETQ0JIzPR9DV0vjMXUM3LaVEg9zEqUk/
         zQJS4BTmE4S+Ujh64NrbQAiaE4NXgl08NGVqePCICCEfEZrEocyfBRUB/wu5PDOqNMiC
         QPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731503874; x=1732108674;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GASOn7QbrM9ZEmoRoXiZ13AI8Ncr2uZ/48itT1ixPSo=;
        b=w2XfIwz0RnPkPtNoPPsUNfUm0PAyVinV/6pojIlYL29ShFDViGqeSjVJgKErcQ+ajZ
         Qey+uWlMlvVZyd+2W4JMEW5v8A/DIqUIMXr9sjtd3rWKlQNK2MLaprROlj6iSEVCRml1
         HXTctDcfUGAai/a6NPGQWOrj/mwbjvGlN9KCuBqHD3QMDfnFfeqeczs/jCMPmyawGbGT
         6dnAIBxbQHDkQcwZ4K23Emc/eTuaJ6oevrhBnEhxZAtOA7xJ8xlFj9t9t6Tv4jzg7tIx
         L4jZoFjKLRYmVj72fcYjt+zM8wXNemXXVXNED0ft0lJAbxjRcKyevbn2CW7joplqtK2Q
         xO3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVr/MT7tdnAVw2wTaLKNqGiYs5dlZy2l2A7POTNJnXc3Rf3w5YlFnArLp4Ib9DPLsFZezBKR8WphQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzV3Wr4LINXVuvlN2B/AP9Wet2FibtT4GPtON8t9/Gnu9Y+AExG
	hm4Oh88WyMaIVchThP6rgfpaoWVPmZS89ziHaRpKYCAI8UcUh93s
X-Google-Smtp-Source: AGHT+IFkQjy5RcuzRtl+x2005T/fhBQQsWhUH09XQKI+0v0sV3eMr4pYS4nOBNx708rEayi0aGK5hA==
X-Received: by 2002:a17:902:e5c6:b0:20b:57f0:b38b with SMTP id d9443c01a7336-21183c97540mr294341675ad.19.1731503873799;
        Wed, 13 Nov 2024 05:17:53 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e5d7a6sm109808345ad.215.2024.11.13.05.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 05:17:52 -0800 (PST)
Date: Wed, 13 Nov 2024 22:17:49 +0900
Message-ID: <m2o72jff2a.wl-thehajime@gmail.com>
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
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v2 02/13] x86/um: nommu: elf loader for fdpic
In-Reply-To: <CAMuHMdVRB46fyFKjZn3Zw2bb8_mqZasqh-J7vse-GQkA3_OQDg@mail.gmail.com>
References: <cover.1731290567.git.thehajime@gmail.com>
	<ea2a3fb86915664d54ba174e043046f684e7cf8c.1731290567.git.thehajime@gmail.com>
	<CAMuHMdU+Lyj3C-P3kQMd6WfyjBY+YXZSx3Vv6C2y9k__pK45vg@mail.gmail.com>
	<m2pln0f6mm.wl-thehajime@gmail.com>
	<CAMuHMdXC0BbiOjWsiN1Mg8Jkm03_H6_-fERSnFEB2pkW_VWmaA@mail.gmail.com>
	<8bbfe73f7f1ef9f1a4674d963d1c4e8181f33341.camel@sipsolutions.net>
	<f262fb8364037899322b63906b525b13dc4546c2.camel@sipsolutions.net>
	<CAMuHMdVRB46fyFKjZn3Zw2bb8_mqZasqh-J7vse-GQkA3_OQDg@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_051755_201541_5737D211 
X-CRM114-Status: GOOD (  24.21  )
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


Hello,

thanks for the inputs Geert, Johannes,

On Wed, 13 Nov 2024 19:27:08 +0900,
Geert Uytterhoeven wrote:
>=20
> Hi Johannes,
>=20
> On Wed, Nov 13, 2024 at 9:37=E2=80=AFAM Johannes Berg <johannes@sipsoluti=
ons.net> wrote:
> > On Wed, 2024-11-13 at 09:36 +0100, Johannes Berg wrote:
> > > On Wed, 2024-11-13 at 09:19 +0100, Geert Uytterhoeven wrote:
> > > >
> > > > > > > -       depends on ARM || ((M68K || RISCV || SUPERH || XTENSA=
) && !MMU)
> > > > > > > +       depends on ARM || ((M68K || RISCV || SUPERH || UML ||=
 XTENSA) && !MMU)
> > > > > >
> > > > > > s/UML/X86/?
> > > > >
> > > > > I guess the fdpic loader can be used to X86, but this patchset on=
ly
> > > > > adds UML to be able to select it.  I intended to add UML into nom=
mu
> > > > > family.
> > > >
> > > > While currently x86-nommu is supported for UML only, this is really
> > > > x86-specific. I still hope UML will get support for other architect=
ures
> > > > one day, at which point a dependency on UML here will become wrong.=
..
> > > >
> > >
> > > X86 isn't set for UML, X64_32 and X64_64 are though.
> > >
> > > Given that the no-MMU UM support even is 64-bit only, that probably
> > > should then really be (UML && X86_64).
> > >
> > > But it already has !MMU, so can't be selected otherwise, and it seems
> > > that non-X86 UML
> >
> > ... would require far more changes in all kinds of places, so not sure
> > I'd be too concerned about it here.
>=20
> OK, up to you...

Indeed, this particular patch [02/13] intends to support the fdpic
loader under the condition 1) x86_64 ELF binaries (w/ PIE), 2) on UML,
3) and with) !MMU configured.  Given that situation, the strict check
should be like:

   depends on ARM || ((M68K || RISCV || SUPERH || (UML && X86_64) || XTENSA=
) && !MMU)

(as Johannes mentioned).

on the other hand, the fdpic loader works (afaik) on MMU environment so,

   depends on ARM || (UML && X86_64) || ((M68K || RISCV || SUPERH || XTENSA=
) && !MMU)

should also works, but this might be too broad for this patchset (and
not sure if this makes a new use case).

anyway, thank you for the comment.
# I really wanted to have comments from nommu folks.

-- Hajime

