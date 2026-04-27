Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F78FF8872
	for <linux-um@archiver.kernel.org>; Mon, 27 Apr 2026 21:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=; b=xvyyUg8OADJzXXr7Gg9s5XV/Lq
	V5FT35KRaHF8TiWX0Q0AHJk4jZVpA46Qo91b3pf5HyZpTfXq9ZXiUnLsaffvgpUxXLnSUikit4k37
	5zuqTNFNbtGeDyHC5t7gV6m5U80O1JYs2ZciXG70L0+rMHRxpLAj4G5iyzSW8clSeNoJt0vBAVhyv
	0bhX+0ZBmL2rhBKd/8VNcy6SU8I+3/+HbwYfi9ypLtRDkgy3psP7iy/3BWtf10VADW07HDtj4/Wjo
	BkZ62w3s1KLT3nhrkuW/x6IfAi3oZ6kFYDH5TCKZuyKYd454ngwD22FSXBAXODQzIN2iADFoFiKTm
	gifX6Qwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHTg6-00000000Bej-2AqS;
	Mon, 27 Apr 2026 21:39:42 +0000
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHTg4-00000000BdP-16xt
	for linux-um@lists.infradead.org;
	Mon, 27 Apr 2026 21:39:41 +0000
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-b9c01854477so696012566b.0
        for <linux-um@lists.infradead.org>; Mon, 27 Apr 2026 14:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777325978; x=1777930778; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=QAUpiBdIA2mC+W/P1k7YutUmngLnXnN05mipHgG6qDRcznLga5FqYmgA7CLQ9yV9Od
         VHVgOT4lHxQJnLexpV7cycmYoWXuqKe3vk1oH0tv+C8DqgW55oALrLf5ANnCCeI6Pt4l
         3L81SUDWF9xjp1gGP6LWSZiq8JT8K6iedBQ8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777325978; x=1777930778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=hvH102hrEdAzX+Bic8aYW4cD004ggACcj/MkqGE/V5PKSh80zKjGONeWOpm7qR50c7
         HKt7GjLUPlg/bnAOC5AO/h3qSacoIScWQ3CdJ81lVxhIyn75xRtkWjVki09r3/m+hBXk
         DelFUWExdsInl+IeYJsOHJ7ugIM9o56oJmrsUezJ0Kawpcf76jLctxPTPVH/jkdk5TRb
         FM0SSxNxeyXuZ0J7Cb0EFJFFq7eFlcYv02mnIp+z90MrIx9Wuw6ytupwe7Sp/FLI/Zxg
         JGo2DYRvWyZ1A+ACnzUotx+blNQyyvfZv2o57G1KpLEcZZUziAis2nYu8VQIzt/Zqr5O
         Pb0A==
X-Forwarded-Encrypted: i=1; AFNElJ+VjNuq5wZuF52LPVbT1hhKqLw+GZCkQEoaFPDbkEN8kuBeoc9jv9/CWjZsZ6f5bBV3iChqAcDJvw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxho9AwdqpqOlUbfpIjP10gUj+pb5hLiSvlaI6B7+lIkWYCtZXd
	NP6rnehVq460FEAInFO/vemDwNWXSphiVpDyCwfnXPfq2sy4bO2uLNe0RJVeZh2QSZAlrDLkajQ
	uo07aVimZeg==
X-Gm-Gg: AeBDies3Wj/QYS/U1c/4AmCR8Wpwnl9SWJCvnxNkWJkv/8eQi0eLlPYPCEi2XpnLPrn
	R2WT82w0M2Nb+IXiAUn1fFgVCYW+lnn/2CMC7jPPFffdmqKgy5ecRRAwVwu/vTk9HvaR5iEw0NA
	mKN2SmW+NOj5G8TD5EgRrKA9KfeUVh3yAO1PDNO1KXE1B6+4PKaViVxuAP48oFI7DIUX+eeJJYx
	Q9OLhDgzkEbkx7ebUpC97nTuXm4/emrX2lxBnHbtJMbqwlCS9Ugn0aQ9VeY1IdF94gtRRr/btT4
	ikjHBD6JfTGe5VJHtFFgPUf1YAx575vEdfK3kD8HHwkFgASZEfsk3HN8Q2ACkb5jqqePJZ08GZD
	+5/bCnOEqB3vEFJAs9OJUC052dXbl0+oxF7VpoD5kqXIVaWXl5Yzemtn6Wzzyy9U0KoY05URRGI
	crd7EDF3UTLJK6dzfCn35topJIcGu6F7DcCiFQhorM6Ufdd78R1FJnA7ITXbVnzCSBY3YXeDG4n
	xoOgHBVG0o=
X-Received: by 2002:a17:907:3e9c:b0:bae:642a:8712 with SMTP id a640c23a62f3a-bb804728367mr28592266b.26.1777325977840;
        Mon, 27 Apr 2026 14:39:37 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb809022348sm9557566b.27.2026.04.27.14.39.37
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:39:37 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-678a526f374so6513281a12.0
        for <linux-um@lists.infradead.org>; Mon, 27 Apr 2026 14:39:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ96W89D8MMxjhqjO6Q6dvAVEBcdRRcSJ0lCg/DW+wi9SMpiTaZrO23TvWBaRanqJUBr5bA4HQHZxg==@lists.infradead.org
X-Received: by 2002:a05:6402:5216:b0:679:1f4f:9d30 with SMTP id
 4fb4d7f45d1cf-679bb04c1a2mr179970a12.4.1777325976937; Mon, 27 Apr 2026
 14:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
 <CAHk-=whC1DZojwdMB1=sJWG2=dsCdfyU8N6tDE1qx50HRZ-WJQ@mail.gmail.com> <20260427222914.1cb2dd3b@pumpkin>
In-Reply-To: <20260427222914.1cb2dd3b@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:39:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
X-Gm-Features: AVHnY4I-AxqvQRk42MegvhKMp_z4sSEpEzhzpgw2GyV2bV8dezSPoI0JTlwB18Y
Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/9] uaccess: Switch to copy_{to/from}_user_partial()
 when relevant
To: David Laight <david.laight.linux@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Yury Norov <ynorov@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, dmaengine@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-fsi@lists.ozlabs.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-fsdevel@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_143940_322754_E6AEEDAF 
X-CRM114-Status: UNSURE (   7.97  )
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

On Mon, 27 Apr 2026 at 14:29, David Laight <david.laight.linux@gmail.com> wrote:
>
> I think there is a slight difference in that the normal copy_to_user()
> will determine the exact offset of the error by retrying with byte copies.

I have this dim memory that we decided that you can't reply on byte
exactness anyway, because not all architectures gave that guarantee
for the user copies.

But that thing came up many years ago, I might mis-remember.

            Linus

