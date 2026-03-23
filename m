Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3544F46135
	for <linux-um@archiver.kernel.org>; Mon, 23 Mar 2026 14:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LI8/dUz99GIMIFX7jL9A6Uqav/8pN6H5Y3gQQrLVq3g=; b=DI5MXDlyCLOkhOEBx1NZwVU9cl
	t/PbUPeGSE+gNhVITlwRnagX2o6XzWzQsfihTIjRUD40Y6mfCSwqzp3drfS9ka0kKpU45S0Puxr07
	RGEW6dZ8lDwvEAKj4qtUJW04uiJO6tr2jP/o1iLmZ2fvFo9C+MrBCmIsaVG0L5MX7/FHoMWajoTVe
	ImngDIdXYgNZewt+lxyulys0soLq2E0TxJCd+BB8o++NxvBByL3/CPSh6HuTAL2LAJSJWUmqfhlx+
	93boWz4IasQmYVt+LdGqz8UzJkOdfyaYqmh6A2TtNfcyBjVSjtslLK3YEUIydh9v1auO2D2x1VmrH
	StPGOYJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4gex-0000000GxMu-06bq;
	Mon, 23 Mar 2026 14:53:39 +0000
Received: from mail-dy1-x132a.google.com ([2607:f8b0:4864:20::132a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4geu-0000000GxM5-0b6I
	for linux-um@lists.infradead.org;
	Mon, 23 Mar 2026 14:53:38 +0000
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-2bd801b40dbso196333eec.0
        for <linux-um@lists.infradead.org>; Mon, 23 Mar 2026 07:53:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774277615; cv=none;
        d=google.com; s=arc-20240605;
        b=OXVGXLGwz3Fmmpi7h1zSPS2ZNLJVYYdEPAOwqSBIr6rSCDs3wiy15+2Ut6s1viKjhC
         LAw0NdK3I0spxaS7rEA76+IUJmnkp2ma08giUB/XAk+h2Duy8Zh2SuPmPEi7hMOt+Lkx
         4gQ7ZmZDd4PnxfvfF6K8q+feZeDW3Pr+Z+xHGS/1PJNC0as2vrl0P0GVOK1TCTAVbhCG
         XtY2H+EpdYwKMW0ceV49jeb9X1XJki/ZJQ1P3BaeS9/eBWZ87ISYGFQUtv6ooBWAYrU1
         Pee0q1M29Ea2vfUecSIVUcE1HCrgjh/XQW2q8Ax/h5jbO4Fc2WDrVSO8SsP55rv/rZa0
         2FZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LI8/dUz99GIMIFX7jL9A6Uqav/8pN6H5Y3gQQrLVq3g=;
        fh=/f50ZuQ0a5tdx+TfuohP1OrwPUyXueA5PgvG8su/X+g=;
        b=JsxQXleoV+yISH2zTOaWuqP0xMF+5qvFbdcek3uo7EGuMgj3dUesJQo09oyii/KWpO
         Gyz8s2n3/nDVr/T6dWDWeBjRdyie9Vuu6jpwLyUQSyDfx6Uxi+J+dbqgX5SSC3Ea5or4
         QLKKw9ukcXSlHCYVArvdh0UnB2n+mORvhf86qHmXjxJ+XLDAolbbnezCAhbkh6JtzqPf
         2O42XmA8jWoQe5GIz/ViYk6RgW5i69aoH+686PD9ght4GJJ2HbjLhKZt0gW6ueQUx+dL
         iWMq1/o5sqLmh6fyzBOfB1RovlGdczMgjLDs46z22nErk+ptLFtlWuUtqrzRLB1s0+Zt
         Cw1g==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774277615; x=1774882415; darn=lists.infradead.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LI8/dUz99GIMIFX7jL9A6Uqav/8pN6H5Y3gQQrLVq3g=;
        b=FRJlwAWLeQtckrDNCLh8nmQVNn3NB8oNpqSvEUiFsFAoKs6Ism/foEn2EEH3UkXBgC
         p3MZUZyT7FSd7XIF4nHKe1qfhNZHoRa66dHZistfzyZbedjo59X1B9jqaOxbzJkVWeXv
         nt4tYkG5XRRL6OiCDR7LPsdd48xP10zUXkpGdjVd2cmVjQ+sCEgyEjOYh4Ol2to/jRwj
         gxHVE2Tt+hEAt68agCNRjVItNfNtvR+YumFpqrYQCAmXNI+lPv8zkK0ctU/6gEKnFotD
         /KM25/sFvlyAQKPE1Qc8kOebyh4r2lVVyDOStIxNdbqc32dvbw1+PWUF8J71R2y3HSn4
         1eeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774277615; x=1774882415;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LI8/dUz99GIMIFX7jL9A6Uqav/8pN6H5Y3gQQrLVq3g=;
        b=bjndy737TlcMdpBpJ9ytn4Lw7EVM3FHQbJlxCKxlmE5/WsXbPSwqKm4Wy7DFRYBrkZ
         Ogh0CQlH4fRoxXW1SPASpqnomDXFLVFnQ0VuFCnziaTysqb7cvLNSPlTaJNWbEmdx9gT
         vdl1Mt99Tll92H0OBzpVjoDhKE7o7HNuREitIdBqOlhZvBFfGB1rtmEL03PPkA/TFn1V
         hu7I0dQvNE9VRrJ4+kb4YfiODcThHHQVCzDZektRdGlfFzgLpG6ITwhHBBm01nXF5qke
         q/f7bC2d1t4YzXmzGR48XxQNpng6LFzMF2qN7F9CwI+XKsJ2JVcT7AfXhbmwolAHq4NF
         OppQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpuxHjBfQhN4Ay9zxZIW6gzxuk2e61V95PiGAs6dHbg1GcRClbh6ysAU9ywzBVmTz9oq7VJQXHlA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwEHm1tOHQTyfYElZ+zBTiqfk4YI4ldsnr83ZcZU3cClMJPKx+N
	wdJsBjXZ8fEdFboAe3P4iXRHxbl2eWimznGo2IAdBxwulr1x/xZMgT3UbL5+r19vCJDsv0QohZI
	ecMnx6kgR/VEQCmMxe1JP/KbPh/a9Uqw=
X-Gm-Gg: ATEYQzw0bAN8ed/V5AFr++V18zO4ppD2ZM091S2hHrDJISDQV3364os+zCe6lAD0Mma
	ETElljQoVlD0+7M3hAguQ8EDb7JNss2v4D/Swwks05OcNXAFXR8ASIaWlC6OaWKMIe7QPH2s2Zq
	PEzbqzDEb+mVBPH5Ss5zQNYCFWmivMkEcYzQv5Uzy2/RQPyfAvpRkqbrL7+C+ZWyhYrRKfKsGQx
	urx+4klt8CFwp0C+xQvZ7uxeSV8GxjeCXUiF45t+1mvhuqabBVUVcx68d11smu2ozJ1uXjFU39h
	aauhcAP5oEmIjxpAlshRkgEPkvnht4NLyJcsE30yztHbQ3lO/ylo9aUFj/74YqS3BKzEoHmApAi
	9b1fP06Sktg4ayebYiu1YvnU=
X-Received: by 2002:a05:7300:3215:b0:2c1:27c:758c with SMTP id
 5a478bee46e88-2c109938d44mr2357139eec.8.1774277615132; Mon, 23 Mar 2026
 07:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260322192159.88138-1-ojeda@kernel.org> <20260322193830.89324-1-ojeda@kernel.org>
 <4fba0163-547e-4099-8b37-5d8429bda6da@sirena.org.uk>
In-Reply-To: <4fba0163-547e-4099-8b37-5d8429bda6da@sirena.org.uk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 23 Mar 2026 15:53:21 +0100
X-Gm-Features: AQROBzBN4j7-1buNPtn5ON4A_wtJBuiQQ3UlTVe5clvsCt_bKh7FB_BsDwGf67A
Message-ID: <CANiq72nmFsnoP3dv_-0PWH0XBpf0OuPzNR2CP9Hw56Z+RVifAg@mail.gmail.com>
Subject: Re: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
To: Miguel Ojeda <ojeda@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Jean Delvare <khali@linux-fr.org>, 
	linux-kernel@vger.kernel.org, a.hindborg@kernel.org, acourbot@nvidia.com, 
	akpm@linux-foundation.org, aliceryhl@google.com, 
	anton.ivanov@cambridgegreys.com, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, dakr@kernel.org, david@davidgow.net, gary@garyguo.net, 
	johannes@sipsolutions.net, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, 
	linux-mm@kvack.org, linux-um@lists.infradead.org, linux@armlinux.org.uk, 
	llvm@lists.linux.dev, lossin@kernel.org, mark.rutland@arm.com, 
	mmaurer@google.com, morbo@google.com, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, nicolas.schier@linux.dev, nsc@kernel.org, 
	peterz@infradead.org, richard@nod.at, rust-for-linux@vger.kernel.org, 
	tmgross@umich.edu, urezki@gmail.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_075336_185264_2E3C04FB 
X-CRM114-Status: GOOD (  14.65  )
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

On Mon, Mar 23, 2026 at 2:54=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> Callers should never treat NULL any differently to any other non-error
> pointer, this is not a value intended for inspection by users.
>
> Having specific handling for NULLs is very much not a preferred
> interface, and most things shouldn't.  The caller should probably have
> it's own !CONFIG_REGULATOR checks rather than using the return value.

Yeah, that is the understanding I got from reading both the docs and
the comment, but I think the docs (i.e. not the comment in the stub)
could point that `NULL` is one possible pointer value (perhaps
including discouraging relying on particular values at the same time,
and perhaps mentioning `!CONFIG_REGULATOR`).

i.e. to me, "Pointer to a struct regulator corresponding to the
regulator producer," sounds in the docs a bit too much like it will be
a valid one... no?

Another perspective is that, when one reads the rendered docs:

  https://docs.kernel.org/driver-api/regulator.html#c.regulator_get

one sees the postconditions, but they happen to not apply in all cases
(in fact, perhaps not having the "Returns" there would increase the
chances one realizes that, but I understand that you want them to
treat it as fully opaque as much as possible).

It could also help things like AI review systems which may only notice
the docs and not the comment inside the stub.

Perhaps it could be at least a one-line comment in the real
definition, even if not in the rendered docs, to have a chance for
others to notice.

I don't know -- I hope that helps, in any case. Perhaps Daniel can
tell us what he thought when he was writing the code, as another
perspective, i.e. whether it was the docs or not the issue.

Thanks!

Cheers,
Miguel

