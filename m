Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30050C4332F
	for <linux-um@archiver.kernel.org>; Sat, 17 Dec 2022 11:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=apTl0qF2L3D9WlThcxA32SbXZkXvtYsX2XBnlat4+VY=; b=ztT2JTwwbJWUR5
	HR3byN8S+0OKbTwsOqb/DE1g83wF8aD5hcBHtSl3QIQRa2G1jBsjKQ5XXPdAn2DxKceVPP5XGllON
	heVBmds81w1YSGLS3HOOMDCUi036OXaeWNAqxa7ehQeOGYKy6tDP3pYkIjrT2gxsIorsDmxmgM2og
	AEsAdxEFZ0JTT1DX5ohcbBaaaNE5NGBLHosf9O6E4cJc6epcnroUyAjAJjHK349OPjrjNY9Qh7QHr
	Aq4++suFcV1wAUygkl0e6Q7Kz3agZ3bTENadXkO/oSvRzDGR0mIQh9xYkqQPtbKI803kgG1gvSaGZ
	BwSOKO4+Z+hn3pdbZjFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6Vqu-009Dof-SH; Sat, 17 Dec 2022 11:59:40 +0000
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6Vqt-009Dno-58
	for linux-um@lists.infradead.org; Sat, 17 Dec 2022 11:59:40 +0000
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-3f15a6f72d0so68718767b3.1
        for <linux-um@lists.infradead.org>; Sat, 17 Dec 2022 03:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rE0oBKTowIW25OwfMNBrVynx9tRsGIghoSQzivHM5+k=;
        b=hpB40kFK/csHhF8tnrhg44BII0yfzhxMur7Ruk9uvXWd2CWHIIbOMzk+CxvyRGohIE
         gN26nd5qWK230ub5XXo81hr9sa2RjLIAy9c6pxR0I7eETb9Dsm4lRL5bk9Hb6y6+U507
         Mv43dwTygE/GLCden1Ea26abdU4c/nRgL/iplj53zxPIGEb3AXuKSt4xPKnZ1hcWsTrr
         mS706sXENCc7C0FHWEqxBogHVdtMT+Zb5ocgbmW+IyjN94NNymTou7Fh/01Ez0ksoXsn
         C/XYamggXt/zyOjqAPFqo2OevlgdHKx0xi6KY+kCfqbz51c8mfYuRIPH/h4kmctrhzbg
         7ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rE0oBKTowIW25OwfMNBrVynx9tRsGIghoSQzivHM5+k=;
        b=Yxwyz2G+t+6m9N4Dnz7EU/Tctr+p3uFZ121l4jkxKhkbXR/JJoG6+5fU0lrKm0K+GG
         1zHeAgOp2lhpkww6aeGVaUa4dkwYevUh1eiN4i7NaULNwrBN6PzpBCBHPwOYgJ1B4t7S
         wS0k1y5LG4tc9hW0J/wnq6v1INRgBKWtEPBeVamkHo9JRQ5bCciD7AL1GjfUifB9Wd1B
         h+TmFSFLwa4+a1ucouqpJxODoXCkZQC5bVA0R7Q3NVUozsbVlTGtuUz4WVfQ5WoKEpuf
         904j7UCc1iOlMiERSGQCXwSUgSTLNLOk3E0dETn4N5FDsq7+VvZ/DnpbSVSYR48Jwr7Z
         aufA==
X-Gm-Message-State: ANoB5plfkhPc9auFBA+izdStSWZHcc/ylWsdi9v+PdJIzfoulUFaSROF
	6lF9LYZYcgUtVu48/QQTXchZlmx3lV2dN50+QDI=
X-Google-Smtp-Source: AA0mqf6Sg8SR47w1xjUSAitaiDIbC5Yl+Hj+ggD2OOSN67ffz5Gx79lZL7+Z36B2bdVAnQHLJ9XgKwwtLSQXjU07bNc=
X-Received: by 2002:a0d:c4c3:0:b0:3bc:7270:cb70 with SMTP id
 g186-20020a0dc4c3000000b003bc7270cb70mr3436784ywd.83.1671278376633; Sat, 17
 Dec 2022 03:59:36 -0800 (PST)
MIME-Version: 1.0
References: <20221217044436.4138642-1-davidgow@google.com>
In-Reply-To: <20221217044436.4138642-1-davidgow@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 17 Dec 2022 12:59:25 +0100
Message-ID: <CANiq72nsTR0Ez4_q_J=Vhoy+SACwnNzRVLKx6_707mP8N6VgGA@mail.gmail.com>
Subject: Re: [PATCH 0/3] rust: arch/um: Rust support for UML
To: David Gow <davidgow@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, rust-for-linux@vger.kernel.org, 
	linux-um@lists.infradead.org, llvm@lists.linux.dev, linux-doc@vger.kernel.org, 
	kunit-dev@googlegroups.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Daniel Latypov <dlatypov@google.com>, 
	Jonathan Corbet <corbet@lwn.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221217_035939_242233_0DE75D6A 
X-CRM114-Status: GOOD (  14.19  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Sat, Dec 17, 2022 at 5:44 AM David Gow <davidgow@google.com> wrote:
>
> This series adds support for building and running code in the Rust
> programming language under x86_64 UML kernels.

Thanks for all your work and support on getting KUnit/UML + Rust ready
(long before we landed in mainline!).

> This series is currently based on the uml/next branch: I'm happy to
> rebase it next year once we're past the 6.2 merge window (though it
> applies cleanly to torvalds/master at the moment). Equally, it
> should be possible to take these changes in via the rust tree instead,
> but since it's mostly UML Makefile changes, it probably makes more sense
> for it to go in via the uml tree.

Agreed.

> Also note that this series marks UML as a "maintained" architecture for
> Rust support. It's definitely my intention to keep this working, but if

That is great -- thanks for stepping up!

Cheers,
Miguel

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
