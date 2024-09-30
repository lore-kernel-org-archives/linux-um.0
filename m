Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3542CE837B
	for <linux-um@archiver.kernel.org>; Mon, 30 Sep 2024 17:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ERWUip0Hd+3xSPGc5KF+LIvmSrz8p98q0i+WVSFZa2o=; b=wZnGgmfZHpvHOaPFILlCIbB3lg
	ZzOcEVF6cboyUbhW5xQm2iGNGL5nugL/xovizVNKvdBnCh0TVrhfCx9CSKw15rCqpUTM+1kdbfhsa
	MpfCUPTTSvg1UtW0e8GXRuDv0eZsmq3E6fkGGUEPOCJmy2kQKQTZmlJEico1tJj7rM+LAHCXoTlxK
	siatotmz33T4FulFJty13XAuBrrvJiD2ayP3ULgXsaAopiIK14JBV0+bog3WRbGYdag0mzSNyGWfY
	Bcgpbbb9j/18/JcNNVI4cgnvAjYjpLwb9aIJxCzf4SWrzTPxCS9Id83RFeeGlMbAmIzlB+ET1LoSV
	skTVdKpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1svKZP-00000000Qdg-02Fc;
	Mon, 30 Sep 2024 17:52:27 +0000
Received: from mail-yb1-f182.google.com ([209.85.219.182])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1svKY9-00000000QUN-3su5;
	Mon, 30 Sep 2024 17:51:11 +0000
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e25c5ed057dso4480770276.3;
        Mon, 30 Sep 2024 10:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727718667; x=1728323467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERWUip0Hd+3xSPGc5KF+LIvmSrz8p98q0i+WVSFZa2o=;
        b=llhOTpbLjaYlJ91Zf/Vg1+NwjDdd/NVEOGbkrOaBGc/EhtqksvwLKkhDIJD+7m9p7Y
         +GxnLA1WTA8SgWXmwcydjhI7ojA26Z6SWySwAT2RbXUo9DuL14tpps7R3KDjfbPKo301
         tTYCpvsutH9j3ZfakH6huWiw8eWbwgqMUZ/a7VlonH8FUfdkXXZiEySKnfVRBSAmLKHc
         y4XRZBIMm2NwCGLx/GPV8ItE5l8WYtcxiOxuR5Pctjzh4e9mC3A5uAyyCzVhOO+IN7OV
         Ceo2EYDp/cV96lnC6uyfGNNBtgHbEP2xvk19VtxQiFuMqgYzGJY2dgx/2PbbBRl0COzk
         ImQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBIee81FYTwRrXSFl/6Oo9Zl448HTkfVkqXSmdyx88PfukCyAqYRfNlCJX5KJRxAM8RadsJfsc3CB0Wo1PcrL9@lists.infradead.org, AJvYcCVDEw6DuvWNMwhJ5kcbHCr2deK4S4Vit9sDAp3RpvjsDX+VYgM+gn/f00HLe33Hiysp5aMmw7LwWaQ=@lists.infradead.org
X-Gm-Message-State: AOJu0YwTZEubTVwsDt/Ri8XRQ4o8+CVuD06iAWoKzU172quXh8kjQZ/7
	/DNcvDwztOCLF7UaHj+U+dSYPUc7GtEBneJP1cBOYf+ucLAFz+Fs0qsp3fqO
X-Google-Smtp-Source: AGHT+IG2PPFt4CoR/LDB3gNfN/inlhlEwH32Cv1RUUg31xMXZ0hyqZscJ+PFxqjJat8rCaic0SDzlA==
X-Received: by 2002:a05:6902:158a:b0:e25:cf3a:a2c8 with SMTP id 3f1490d57ef6-e2604b33985mr10088346276.23.1727718667544;
        Mon, 30 Sep 2024 10:51:07 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e25e400f721sm2407818276.14.2024.09.30.10.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 10:51:07 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6db4b602e38so37014987b3.1;
        Mon, 30 Sep 2024 10:51:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBX8kSMsQ8OgBVBb/XTWPPdDnBFa4HD6yc5cRBl8O80u5kZHZwVxAfK7Z1Fg4x+H/2Q84lNTTIf007SKZhC6gl@lists.infradead.org, AJvYcCWFWwlw5zhjhTi5qDWhKGEVxKhkljxEddXMmK/X6ou+L7aH20NbySdBJPUypqd3NRB78BAE87XDTnI=@lists.infradead.org
X-Received: by 2002:a05:690c:c0f:b0:6d3:d842:5733 with SMTP id
 00721157ae682-6e2475e3050mr104508727b3.35.1727718666765; Mon, 30 Sep 2024
 10:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240930132321.2785718-1-jvetter@kalrayinc.com> <20240930132321.2785718-11-jvetter@kalrayinc.com>
In-Reply-To: <20240930132321.2785718-11-jvetter@kalrayinc.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 Sep 2024 19:50:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX03ornwefrTfSYfH-XoEE4CHN+u5m7ay5_LrTq8XHOJA@mail.gmail.com>
Message-ID: <CAMuHMdX03ornwefrTfSYfH-XoEE4CHN+u5m7ay5_LrTq8XHOJA@mail.gmail.com>
Subject: Re: [PATCH v7 10/10] arm: Align prototype of IO memset
To: Julian Vetter <jvetter@kalrayinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-alpha@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	Yann Sionneau <ysionneau@kalrayinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240930_105109_983935_6C0FBA4F 
X-CRM114-Status: GOOD (  16.33  )
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

On Mon, Sep 30, 2024 at 3:25=E2=80=AFPM Julian Vetter <jvetter@kalrayinc.co=
m> wrote:
> Align prototype of the memset_io function with the new one from
> iomap_copy.c
>
> Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
> Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
> ---
> Changes for v7:
> - New patch

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

