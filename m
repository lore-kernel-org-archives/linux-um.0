Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F649C369BD
	for <linux-um@archiver.kernel.org>; Tue, 15 Apr 2025 17:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+Js5M+95wLTneRomTBU32Yp3P2fILyuAwj0B/Yofyb0=; b=wWzQK791JDqyhWCapxRktJT9K1
	n3+aWYrlQBRemVf4HZIPi/mx/xBBQcnMC1y3rMJH53vurxrOy+G7dUw5IdHD93kX9AtHAfmmtNipS
	zrPI/t9ZJ/aNhoJRSTSWuq/x1ksA+JqLAg2d+yu9cXh0JM1Z4wwSKKMMGZ98oHgZC0Fxrje/a4hGJ
	916IOxwwXY4Dd4djeat1IzD5vCSiwlLul4SMJy6bZk8JZtwh/nOmWtpUO6M0tj5CATAxVM58Je3LN
	wY9Sfk3FkO78DmrLa3p9Vg2hztblPeN9pXI7UPAnL1uT3aGu/r3vADIPiFQWPCVy7JsbEuc1Qg8UA
	ibrwdc7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4kWq-00000006e1S-34Sm;
	Tue, 15 Apr 2025 17:57:00 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4k6q-00000006ZOV-0Z5s
	for linux-um@lists.infradead.org;
	Tue, 15 Apr 2025 17:30:09 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2260202c2a1so6482235ad.3
        for <linux-um@lists.infradead.org>; Tue, 15 Apr 2025 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744738207; x=1745343007; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Js5M+95wLTneRomTBU32Yp3P2fILyuAwj0B/Yofyb0=;
        b=C9zojhZaBVPEQzTzFAQOh3ejPRLGPS8KZ/EU1gOH6lXbQMLsobGsdpvy7SYV6OG7eG
         wzVhHJz7ZT8DjpPTI+s2UttGMMbBh+7hloBQFlJaczONV+ooVjxvmGh07qZQ8YhoJhIi
         p2Azla0DmEvJ4l4HcTfogrmLboo7CgwwoKGd+xk3UY10IFh9nwgUmuG1AbBTT3/6v3A8
         u7sKjQJUd7SDqLtVSqR8vLoagLwSJyW9IROkKAb7BkjRzXe3I+4gYYmxlj2QkPdrV6mQ
         B/J87pZzSclfdVvPgQDWEGJ3poAfJetDC6uzJxOo8N35fs6sIT3yIT/QSfcAPdiHJf9L
         3h1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744738207; x=1745343007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Js5M+95wLTneRomTBU32Yp3P2fILyuAwj0B/Yofyb0=;
        b=OV9QmbZiphcTcZhWSJo1TGc+KEqEOEetixqx9l3jigiiK4nxzn4LIRCqXMnvoVlUV1
         BJZCQkgfm6pw2A+cbca6U898GqbFLYEzMWQr21Zp6QEY6fvrgLfxdPiJPI/0/lcIAZhV
         wNjEPkO/sYyHYMSYVK5cKVDADuAjRNykrtm96JATeERqt6kwGZN1zB2oCjKeXJP7Eexr
         e01nlswosUaw4FHkDih4Jmnr585hph3/DQpLpa3vKirSAo5aVP5a1u3xvsAEUftePegw
         kD5KGyZuNLv3xdpycyejVkVtvum28XQrXPapRbXnnwWzyfzS3P1dKwkVoT9T98bgtyyr
         UTWA==
X-Forwarded-Encrypted: i=1; AJvYcCVZGO/II7SvNAOk3Y4NWMRYohVDy7A2j2xgW02nd7b0qDD3BN4NyOzaqIeQl+tyhOXuFFiEnh0BWA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwQM6ZGkF9f9K3S0uUTNZmUkFiLGaN41NPUk1yYp3CKiSPW11sF
	BtZqr9yp+TMFE+r/EwLzZ9pGthlhLq/u/hDL/1ZLLcgp1+Ly+rO1P0Oqd6BFg7J2LzqhDW84ckx
	MwLP9IEjf1ejJY94lTBH1bpmhcOU=
X-Gm-Gg: ASbGncvqzb+lmJFLUlFNK4VnGoN3C1k4E/Ii0vQ6B75bbS3KXLkEObNxozvGkYPFuXU
	6Jo8K4BniQPcgcGdqoTZ4AmFAdBdLaVanUKpSN5MEOPr4He7X5epyNz+V18TJ2ynKCI7R6RWi5t
	gX+JZNkZgGD4/1xu8USiFbcQ==
X-Google-Smtp-Source: AGHT+IF86/W5joyNhnMKEOp6FpUc1iEdUNMAZtE7UId0k2IgQ1cdYhnfxa5fKD6bVVMc42q5MQVfnb/y9HWpGm6PJeU=
X-Received: by 2002:a17:903:2282:b0:224:1579:b347 with SMTP id
 d9443c01a7336-22bea4c6a86mr93429145ad.7.1744738207158; Tue, 15 Apr 2025
 10:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250412005341.157150-1-fujita.tomonori@gmail.com>
 <CANiq72=Grg+T-c0+TxcyubHj4kvHPQKiVm3AZp5DgeUVXsitEQ@mail.gmail.com> <0c844b70-19c7-4b14-ba29-fc99ae0d69f0@app.fastmail.com>
In-Reply-To: <0c844b70-19c7-4b14-ba29-fc99ae0d69f0@app.fastmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 15 Apr 2025 19:29:54 +0200
X-Gm-Features: ATxdqUGlMo9mwnVK9FU0IkQMA7-diVybbG5Se3U2h-rLaU0Lq9-uXtFdgpVIojY
Message-ID: <CANiq72mLAMQ8T7qK738SKRKUrywxwE4xYdtLrYfL49-TKO-qnA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: helpers: Remove volatile qualifier from io helpers
To: Arnd Bergmann <arnd@arndb.de>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Geert Uytterhoeven <geert@linux-m68k.org>, logang@deltatee.com, 
	Stephen Bates <sbates@raithlin.com>, Danilo Krummrich <dakr@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_103008_172545_BC37F0C7 
X-CRM114-Status: GOOD (  16.19  )
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

On Tue, Apr 15, 2025 at 6:54=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> Rihgt, I tried this last week when it came up first, removing the
> 'volatile' annotations in the asm-generic/io.h header and then
> all the ones that caused build regressions on arm/arm64/x86
> randconfig and allmodconfig builds.  This patch is a little
> longer than my original version as I did run into a few
> regressions later.
>
> As far as I can tell, none of these volatile annotations have
> any actual effect, and most of them date back to ancient kernels
> where this may have been required.
>
> Leaving it out of the rust interface is clearly the right way,
> and it shouldn't be too hard to upstream the changes below
> when we need to, but I also don't see any priority to send these.
> If anyone wants to help out, I can send them the whole patch.

Thanks a lot Arnd -- then let's go without them on the Rust side. I
will pick it as a fix.

I added an issue in case someone wants to help:

    https://github.com/Rust-for-Linux/linux/issues/1156

Cheers,
Miguel

