Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A715D597B1
	for <linux-um@archiver.kernel.org>; Tue, 12 Nov 2024 22:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Subject:Cc:To:From:
	Message-ID:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d+UW2Op7GE7GQXptwht/lcrjAza1pTojZMwL+TK4pmQ=; b=iSzDvAfzck9fxRFZAB/F3ng8Z1
	22jH0v3lzb7GigdXl47/rkRfCT/7BmlzjGmsxAdEyRbDeq4Vv54NIZJPHYBP8PsDfabhDj+qoRMUW
	MYAvvGoA7mzryOdPY3tFvJV4xDP6VeeOedOzh0QIoZEwHZ9jownUfap7ZX69HNqSd18fh5THmNROc
	hS9Wn0/gwBjgYPS+mg4r1+IaxCTCW/T9rkeQMC7KgO3vsxudUfUiwydOtFuh1pKNvfy0n7DNsS+Pr
	7YrlQArgZPoHK+i1IEvSMPWJkv5pH7cql9P37btZ8iE4gY3mggICe/i3HS6hBOxIHjhHKwmIV4rIF
	edOp1yFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAz3D-000000056I9-0N0e;
	Tue, 12 Nov 2024 22:07:55 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAz3B-000000056HO-01rp
	for linux-um@lists.infradead.org;
	Tue, 12 Nov 2024 22:07:54 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-720d14c8dbfso5925322b3a.0
        for <linux-um@lists.infradead.org>; Tue, 12 Nov 2024 14:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731449271; x=1732054071; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d+UW2Op7GE7GQXptwht/lcrjAza1pTojZMwL+TK4pmQ=;
        b=Oiyxlx1xkarnpAyRWg9+1h1in+4TG67Ry4wJoon0rlxzNh1NESpmfhHEO80m5opAeM
         AkXI3cUSa7jOJrtkyh8kcv+y/ukvHiArHeJcLfeGUwplow61u9jmnij4JZJCAgke1xeR
         CCzJcD/jfQJElOWssogo2hlTzhfsRCrqULAQBzfMKRelSs9l7+JUBbIducWSEBQn3U2r
         N/iOX4ACOPc7hcKp3fd5GkcN+8osRN4mtneUwigrUVSux3uTS/0vP3rWKkJ6pAxaaNEj
         YEVZB0vaj4QUji74hU4efZbHCH1lrTHpsme9YlH6G09rIyPtHfDSr0K2F9MXPB3rHPHf
         unsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731449271; x=1732054071;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d+UW2Op7GE7GQXptwht/lcrjAza1pTojZMwL+TK4pmQ=;
        b=X2Q/HebSy1dsDY0ExZ4VdaLCTb8Y4PT+35wrCiiPWdy5SLo72CwWtXN4rVT+tV3j3N
         0qTC/rGNxr7gX41xCO6dWt1MrecqSeorfbixuBKw9GbUjYtvqQ/vAq0YUk5HI78GA51y
         T8evsfjmxgU3Ov2d8MBvI+ZanHyT/hpuerG6eX6c5HQC6kRqvmu7pJ4fQv/COdtT/VHg
         Z6XEjrmgRnoW3WxV6Egw1SqN7bbxHlgR4mxuspsFF9ZYXHHqTtfsWZmMbgyW8P79cVeE
         zm7chLIdcIxTWzPyL/mR/KnTLe0/TjfBl2LOvGO3l0MpIO6GeGIou/CPzA3ykFYicKYD
         xIiQ==
X-Gm-Message-State: AOJu0Yxgv8vaQ1X3MOaIJ5JwM0AGBjPwGLwhHQgKrQxJCB8ZjrZVDzCy
	yhUW5LQ2dj0hcaejpDfoF47S642JJJpi5REoYcLhFT8MGQmmaax3
X-Google-Smtp-Source: AGHT+IGiSna4phvEa18H2dmaztl3E7zrI8XNXhPBJZoWXHLfFfW7LEz/pSyGk/kBpuZb2oG9B5sMpg==
X-Received: by 2002:a17:90b:1c8f:b0:2e2:cfef:86 with SMTP id 98e67ed59e1d1-2e9f2c4ef4cmr641002a91.4.1731449271222;
        Tue, 12 Nov 2024 14:07:51 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc9073sm98363485ad.1.2024.11.12.14.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 14:07:50 -0800 (PST)
Date: Wed, 13 Nov 2024 07:07:45 +0900
Message-ID: <m2pln0f6mm.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: geert@linux-m68k.org
Cc: linux-um@lists.infradead.org,
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
In-Reply-To: <CAMuHMdU+Lyj3C-P3kQMd6WfyjBY+YXZSx3Vv6C2y9k__pK45vg@mail.gmail.com>
References: <cover.1731290567.git.thehajime@gmail.com>
	<ea2a3fb86915664d54ba174e043046f684e7cf8c.1731290567.git.thehajime@gmail.com>
	<CAMuHMdU+Lyj3C-P3kQMd6WfyjBY+YXZSx3Vv6C2y9k__pK45vg@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241112_140753_066253_A8730B26 
X-CRM114-Status: GOOD (  18.73  )
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


Hello Geert,

thank you for the message.

On Tue, 12 Nov 2024 21:48:28 +0900,
Geert Uytterhoeven wrote:
>
> On Mon, Nov 11, 2024 at 7:28=E2=80=AFAM Hajime Tazaki <thehajime@gmail.co=
m> wrote:
> > As UML supports CONFIG_MMU=3Dn case, it has to use an alternate ELF
> > loader, FDPIC ELF loader.  In this commit, we added necessary
> > definitions in the arch, as UML has not been used so far.  It also
> > updates Kconfig file to use BINFMT_ELF_FDPIC under !MMU environment.
> >
> > Cc: Eric Biederman <ebiederm@xmission.com>
> > Cc: Kees Cook <kees@kernel.org>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: linux-mm@kvack.org
> > Cc: linux-fsdevel@vger.kernel.org
> > Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> > Signed-off-by: Ricardo Koller <ricarkol@google.com>
>=20
> Thanks for your patch!
>=20
> > --- a/fs/Kconfig.binfmt
> > +++ b/fs/Kconfig.binfmt
> > @@ -58,7 +58,7 @@ config ARCH_USE_GNU_PROPERTY
> >  config BINFMT_ELF_FDPIC
> >         bool "Kernel support for FDPIC ELF binaries"
> >         default y if !BINFMT_ELF
> > -       depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !MMU)
> > +       depends on ARM || ((M68K || RISCV || SUPERH || UML || XTENSA) &=
& !MMU)
>=20
> s/UML/X86/?

I guess the fdpic loader can be used to X86, but this patchset only
adds UML to be able to select it.  I intended to add UML into nommu
family.

-- Hajime

