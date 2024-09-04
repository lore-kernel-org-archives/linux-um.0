Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E4FCD37B6
	for <linux-um@archiver.kernel.org>; Wed,  4 Sep 2024 08:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jdt4L7B/HVtgHJTf5Ay/37Kjc9tEjPIOz23j2vKvezg=; b=W/yjPd8Taxi2785BiDs6Jaulkl
	ogXPuglmeHtg2BBlG7U3jBEtlnKxkQlTI4b1XX6ZeyA32vjnaH1C1j5li3ExXGWPWTyDdQCKJSCr6
	psVv6nH78EcPeN5hgIAdOCa8Ll9bBRkNLjaUslxIgFgakWu9dSI2RThqfEl5OG9NxrBxMvqs22193
	G/yO0Yz/9lBfOsZ8fB/nO302wD+ON3b0OGU9kgeQrlQrmgN2nMOXUwaXtuWwI8QYGfB5F84NHVdB+
	sRiS3ANjlrvUxt2N1vEkp3/CVFGkLsM9LgTPZg8c6g2pY+y2FK4BWepYNSnCqrDGLr3KhBBpwxSyE
	SqWxXZ2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sllWK-00000003S0i-3ABJ;
	Wed, 04 Sep 2024 08:37:44 +0000
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sllNo-00000003PAh-1LpK
	for linux-um@lists.infradead.org;
	Wed, 04 Sep 2024 08:28:57 +0000
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-70f59acf6c7so311524a34.3
        for <linux-um@lists.infradead.org>; Wed, 04 Sep 2024 01:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725438535; x=1726043335; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdt4L7B/HVtgHJTf5Ay/37Kjc9tEjPIOz23j2vKvezg=;
        b=aj/X2Jv05vpG+WJWiygpqQH4gTrJB0XIelRkzmEV04QxeFKLepXUVj0EKlo1peqrqO
         bp25wmaofkds3d2MrgoxbSgQv5pB3Xr9/mPfkA6oHmxZuQcIQhPcI6oNofAT7d5+ry+8
         2x8UA0VmUlYpBjIToXFUScAT5av1AaNHoAlajoiP2RMP9UdMv7pGmz1bFQja/2eT7Cyi
         h2CMIYGvWjn42zwMhFbuieduA5on1XzFR3ee8l7oYTWbfC5GvjZor3IzcPhF9iYdEOey
         rd8LE1yTm25slkr7DwcfmGMzHPeWax/N57AQ8DEHdM0NCKT49+SRxenoQQEpME+nY0iv
         tm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725438535; x=1726043335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdt4L7B/HVtgHJTf5Ay/37Kjc9tEjPIOz23j2vKvezg=;
        b=A2BFak+xxgaU63CXr80TcTa+3KRQHQ2yms60pvaC9OOsr9rzKBSJ3dQPAlq6S6awnf
         A/cMWPXYDgtJjCqgNQwro5Uv2FrtNJjTtvOYG+lhfePw+z5WdlIRlqfQS6EvUsuAdRDP
         poRhhGXjQF1Cv8wpbl4Syf0PJQVjCw3jOLfOt6jL+P+KOIPcFl7E9LECmQx225RtfOJZ
         3tK3aP8EAvPifOjN237DENdoqKLuu1+3Nhkkt6UeVYLttERQ9KjocEpDBOOVq4qNcDr7
         RnbebmY3IBPQ3QmRALC4n+ZkGzI/ZvHZUYGElPOTbQI3Xnsa3us7Jg+rtn91Pa6Id7LF
         bH2A==
X-Forwarded-Encrypted: i=1; AJvYcCUVssrP36SVZA0M1o1DchMP26CQQEUhu/W5jjXuO6JhKKpqYoWdDj30usOwRsIAd57+3ewRTjM6lQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxCqT9IVs2E22xQMu2w81rpzPLkH3QoOqcH4SaFKX1/RA0ZySnC
	owMNeTsn8tbOT1sWm4xmOWb7Yxr2Uw836gMuJvqPI3UMTJOu+FE6mxLW18QN/wrhAlI/tccDEb0
	6Zpgb401Rn2k6mebp1P25U/+uS7U=
X-Google-Smtp-Source: AGHT+IG7ayScQVV2ACfQehNhc8C8kUzsvNWbtTACdA8kQELKf2OV6f3hSmmCq0rgCq8R7f/fWdFT+b2PvKUGt44U9CM=
X-Received: by 2002:a05:6359:4c93:b0:1ac:a26c:9e91 with SMTP id
 e5c5f4694b2df-1b7e39c063dmr1048812355d.4.1725438534828; Wed, 04 Sep 2024
 01:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240903-mips-rust-v1-0-0fdf0b2fd58f@flygoat.com>
 <20240903-mips-rust-v1-3-0fdf0b2fd58f@flygoat.com> <CANiq72=z1yJm-B_ie=GfueOF1qksaSD9txgFU1YQo2tZx0qQPg@mail.gmail.com>
 <d9591a84-9a0f-4046-9b2a-437061f6882b@app.fastmail.com> <CANiq72m5iFcqRU_qdUCZkoV8ayPhtQQq3TTEDRUYfMEsnNqTDg@mail.gmail.com>
 <6f6f04d7-55b3-4714-9bcd-cb4e1ae6c86a@app.fastmail.com> <CANiq72mvTTgyTjDCWBz_kOdY1f4gopAtWxyC4P4c+Lr0YVkzLA@mail.gmail.com>
 <a6959bc0-f0bb-425b-b3b1-3123d3b809b5@app.fastmail.com>
In-Reply-To: <a6959bc0-f0bb-425b-b3b1-3123d3b809b5@app.fastmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 4 Sep 2024 10:28:42 +0200
Message-ID: <CANiq72mjKEpaBqKccZPiNzpsJL65jb2zp9Ve4FHK0fRd014ACw@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: Enable for MIPS
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
	rust-for-linux@vger.kernel.org, 
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_012856_380396_CE89D955 
X-CRM114-Status: UNSURE (   8.93  )
X-CRM114-Notice: Please train this message.
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

On Wed, Sep 4, 2024 at 9:38=E2=80=AFAM Jiaxun Yang <jiaxun.yang@flygoat.com=
> wrote:
>
> Reported at:
> https://github.com/rust-embedded/wg/issues/792#issuecomment-2328133517

Thanks for the link! Added to our bullet point about the target spec
file in https://github.com/Rust-for-Linux/linux/issues/2.

Cheers,
Miguel

