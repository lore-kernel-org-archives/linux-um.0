Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D726C36002
	for <linux-um@archiver.kernel.org>; Wed,  9 Apr 2025 15:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t+sfbVV4SiI1C5sy+DzovZKb19HUWpMy4SsLijVQ49c=; b=4wuLkaPwDzav4nB/+9oPKLQTNX
	Cr+iCrw2Z1qdzw9A+KuWlkIR2g+BHe1DK1gUAgzBgdq273nFruO5XkeRPjsizFFMshluxoeGn9Ndz
	xAyAITLFms1Ve8gIVZuigqEmNrD5tpEpr627I12DlNA6fQclxRuE0ZD2+rNKvnUenWb+7uNv/MUW1
	l0ZshV9IGhLFeRYPHKSXBoYnQmtu6o7/JD1pwZdclAWUlC1GhClylaIjMjOnmZCWGS0RMtANqHkW0
	CE63iuTBjcaWr0gHwL4Kyz3MVmsJo/gQEPsGorCgA1F7+0HB2iG0tA1rL2JZVAOaA4whigMPpFQJI
	Y0tCvPdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Wy0-00000007awR-0iqS;
	Wed, 09 Apr 2025 15:03:52 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Wik-00000007X88-49dW
	for linux-um@lists.infradead.org;
	Wed, 09 Apr 2025 14:48:08 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-223f7b10cbbso5918385ad.3
        for <linux-um@lists.infradead.org>; Wed, 09 Apr 2025 07:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744210086; x=1744814886; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+sfbVV4SiI1C5sy+DzovZKb19HUWpMy4SsLijVQ49c=;
        b=fr1jD9AcAKnDjWfiVt3epFDnG5PDLokoXArFqjY1+uRSNamfU/mgH+f0pmsqPmyXzM
         +8SZ80NMI7TXceAfReWbcV4RH3HkC/M2LA1Iq+I3kE55WA1RR9NVYKtn/nSQTpd1J4Kz
         FX/gog7abrflk5AGQmmg+RyEVxTKk1VYY40eqgd7C+OWZ/tHwGjDsAyp6WiuTvm5O1Bf
         nAXKVfw/EolWRrj+I5u5JJTnTiuvoKphDCBPLIfR3KlYTSsnla+M2Z1QK7cQE/pWJN5E
         tH2xmXW9Yb4OIKrWC/BJq/x3AZ2JWt7eX4Ge0bETu576+utfMVp+y3fjv8/JZZfNq3hf
         sLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744210086; x=1744814886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+sfbVV4SiI1C5sy+DzovZKb19HUWpMy4SsLijVQ49c=;
        b=kw0m9VnvvF0EO5sgP6hZXibF8YCYSilh0cAr7fJWRjdU4l4UXSipCGxGP+sudOnk8M
         Qcq5Hth3tr6pmSOJIcJCkiKZKeNwQi/8B2b8lYrbxhMU76r7HdnzBReeaCVVHFXKBRt3
         PU0wKpl4ZTvRggBOv9Pnx0PjdBPrcYUepmMKHmIl7lm1GYZEYwu50HtiPKAJi4LTfHxr
         8z6/dspbT4EdgsRooPp/Ve367mkKDcreS08SIT+3m52I3COHuWizzpmXS5l/1yrXLBWo
         mPRT96tnpXo/dxjFD59p3O/zgqXg/Uq0nHYPxNEJIxYW4orvrXxwuekBYgqdQrw2lqtC
         gx5w==
X-Forwarded-Encrypted: i=1; AJvYcCWJpRWUYoPSR2vrn1cAt8jboCIWU/MpYa59iWJ8vX3cUcBmoWLNHJaqdqaOPGvYnUUDBL0MSsey6Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YytmXfUXx6Ng3dMcOzwA5G8z5NRl0mNa+9jDHDGE8wUw8SqKlqi
	snH55ceAOZf/P3+JWUZWMipqcSE9TGCF15hz6hgW02PnUn1nimJqna9BYts6m+H9jKiTx9LsS97
	t40hgyko5qGPcNI3z4i7+ZlpNwlI=
X-Gm-Gg: ASbGncs+lib4K2FrdtlCrgX6nFlfQ1k3/1v4wEz96W+u2FJWNw0Cgrmj4eoc+jHRXm8
	BFP2r0JNGdP54IZabqgq/tVkdKPTBtEcD+EaWXZIAOOg0iCoDXA3SoT4XfLCfWce1KGRvyejBq4
	d6lKKu1p0Lqw3+H08FgNzo7ivI2BABvoZn
X-Google-Smtp-Source: AGHT+IFu3m+E2XPPJm9CpPYU0T8chUkLDG5jm5xrgDt4moQJnQIHZ/KUoOKRsStmjsw1fnexQET8vOP2opD9TB+qELU=
X-Received: by 2002:a17:902:db0d:b0:224:10a2:cad1 with SMTP id
 d9443c01a7336-22ac3f13978mr17062085ad.10.1744210085546; Wed, 09 Apr 2025
 07:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250409061129.136788-1-fujita.tomonori@gmail.com>
In-Reply-To: <20250409061129.136788-1-fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 9 Apr 2025 16:47:52 +0200
X-Gm-Features: ATxdqUFqVu5MaC3L7mL4r0bbWRkrPzcLXrBDchUoh9IuHJeyx16OliIVVo32LbY
Message-ID: <CANiq72mbci8kxEx5jrq=HVc6WKuJqq8NCLzNsjH1wFcJNoHm+w@mail.gmail.com>
Subject: Re: [PATCH v1] um: fix incompatible argument type in iounmap()
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, 
	Stephen Bates <sbates@raithlin.com>, Danilo Krummrich <dakr@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_074807_025710_46A6D01F 
X-CRM114-Status: UNSURE (   5.72  )
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

On Wed, Apr 9, 2025 at 8:16=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Align iounmap() signature with other architectures.

Most indeed have `volatile`, but nios2 and m68k don't -- Cc'ing them
just in case.

Cc'ing also the original authors of both sides too.

Thanks!

Cheers,
Miguel

