Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753F3C77B7C
	for <linux-um@archiver.kernel.org>; Wed, 25 Jun 2025 20:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qDMCLl0gLWhxFwrrJQTHLjaJpteqSIGZmL7tjKy8UQ0=; b=qbwBI6a7wu4LBQzRCZoxvHI/OV
	bn8ebMTpg4e7Bjg9NoYr/ji2/POi5SvvPX+n+pUWiyHCqc8/L01dXadh9Ul+G0pL9wW91a3RQC6s7
	QAj5P1btySqKBsslJDyUd9QZj6ag6P2b17VPtCwqq2MkFXsYQZ3YKaxqOsCWycXH524NWEnLbHtd9
	t8Lw+yRXpOTjjOmYRQ29WK8nX/l+mXaBe8AFk5VV22YwzyuhRG5O2hzPbXOSallcd6TjjCECf2x12
	nh0gBGPqEV+5mzXvTIKoO6ySjPHLmUUmdyuyYjsFhw1I4d34G6AAjsmES7tamjJ7/drZucdOyl4OD
	+IgCfUOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUWq0-00000009rZx-3KH5;
	Wed, 25 Jun 2025 20:35:20 +0000
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUUh3-00000009YQF-3tl8
	for linux-um@lists.infradead.org;
	Wed, 25 Jun 2025 18:17:59 +0000
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-606fdbd20afso240549a12.1
        for <linux-um@lists.infradead.org>; Wed, 25 Jun 2025 11:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1750875476; x=1751480276; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qDMCLl0gLWhxFwrrJQTHLjaJpteqSIGZmL7tjKy8UQ0=;
        b=ga1DRG++kS3PN2C/ZhC5YESEut97AiUJQoXZyTzHE/WTmkw3JzVFMZ867x3aY6q8O+
         YQA+vfyT1lYtUqlcyEA9UaZJwcscoh1c9CrFfLyq5UHMEiCMrbnt6FfXN4ejGYMD4Jn1
         gBMc7WP8AGmtKNzFcj+pXZI80q4vKG+ZQcFX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750875476; x=1751480276;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qDMCLl0gLWhxFwrrJQTHLjaJpteqSIGZmL7tjKy8UQ0=;
        b=r8dwi1DhLBK9vj5cQkCBY3lUqkyW70ru6uqyz3kPW0eySuHkulGNLHmp4EtDrHjmrn
         NlMH4czfHKMf/3se0MPChBwB/cod/MC98vGox94JS14tIYuf06hSxVRh3/dACR138ie9
         ouLWgNi66C33fdaWTVIxZ2NeURdikJelBHXAtLYaE85T4fFrla80bwWE7yra7+Kp02LS
         1zct5+BTdTlNcRCBpQO1gnjGd+82YXsyt5YffFbEjKaZOYGITaIOq35Is6gqTwAVe966
         e4eSFW2Suwy9MSlQvflfCv65vLJMHsgzRGSH0bmEHjzTfKQHS8ZqtKKpvozAL797Z+lj
         MNlw==
X-Forwarded-Encrypted: i=1; AJvYcCUx3PCElow17iOAd1b9AVw4cVULfVScMKVEVOZkZtjkdel/l6UyAKq23YculnfA6IQzTKm1hEYhzg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw5wkFbNt4EjTmq7eKQA6PcYXTG0yROB3Khy/Om+NdLk2fW/X4V
	aZhCyl7qMxjrxAMpmYxR0+vlZ6QQeFfw8CPRtA92n/eVBg1LfYnFI4HPcwFKc/BDEcvzRvlQL0f
	bXH+qOVU=
X-Gm-Gg: ASbGncuBGa3wy4iU9BJH2WBT9PTj4aml/1OlRt3QiJdgpClDdUUw+uKEu1crVt10OE6
	9eq3yliBwQP5VYhdvVPZqvjQChSMe2ZB9Nt8tL2OqqKlsHIZNTJufvBrkroiyEIrcyG71Xp58g3
	P9zwfL1Wp4CHzGfZoLyWmQCjYWshVIMhoTk9bJrhnJvosad324dFZmTNHDh/+gE+baxX5f1JYCi
	nEAR+M9P4Qqx2q7cPrsrl2OFZIWMeY0LvtjheOTeIYc3c016FfwE/kagnmIbDdWVC7CZ+LxULS4
	Ab5Yk4o/ddfdSVf89ZVbmLvbBxylBrPBcJPsndYVvAjZezVhc4xUB9VT2LePjgKTK0n5K3u+bqq
	3p+pUcYLu+BE/oABux7tRSyICAbCG3sPo45/O
X-Google-Smtp-Source: AGHT+IFpQ716pcBl/iRjHfQVxaIQQpnMoIHdPMI+EYOY6s4BFiksjUFhRLQZsMQmbgvl13i1V48MBg==
X-Received: by 2002:a17:907:c24c:b0:ae0:1b44:43c9 with SMTP id a640c23a62f3a-ae0bea97632mr431887966b.60.1750875475568;
        Wed, 25 Jun 2025 11:17:55 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0b2711fa0sm283260566b.92.2025.06.25.11.17.54
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 11:17:54 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so222143a12.2
        for <linux-um@lists.infradead.org>; Wed, 25 Jun 2025 11:17:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVH0ylZA+IhrSw4Ev47ma2CTeKKxmZCIEvpobGX7T4X5PKzKuT3/UuOLN/Bx6/mooWxYE2uQU9RyA==@lists.infradead.org
X-Received: by 2002:a05:6402:4314:b0:60c:4521:aa84 with SMTP id
 4fb4d7f45d1cf-60c4dbfc190mr3579986a12.15.1750875474433; Wed, 25 Jun 2025
 11:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250625121529.42911-3-johannes@sipsolutions.net>
In-Reply-To: <20250625121529.42911-3-johannes@sipsolutions.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 25 Jun 2025 11:17:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjTCAzaw4AXXpxcYc7v7ZjAeyaOOJw7FWXO+gV7v7Cp0g@mail.gmail.com>
X-Gm-Features: Ac12FXymQLV1Fu6a7N97vaofr_LpXmriw35bRKrjBjLtee6ZA9OazdfT-VQM8WI
Message-ID: <CAHk-=wjTCAzaw4AXXpxcYc7v7ZjAeyaOOJw7FWXO+gV7v7Cp0g@mail.gmail.com>
Subject: Re: [GIT PULL] uml-for-6.16-rc4
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_111758_371686_7817494D 
X-CRM114-Status: UNSURE (   8.61  )
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

On Wed, 25 Jun 2025 at 05:15, Johannes Berg <johannes@sipsolutions.net> wrote:
>
>  - reduce stack use with clang 19

Interesting. The patch looks fine, I'm wondering if people made a
clang bug report about this behavior with structure assignments?

Even if most other projects likely don't have issues with stack size,
it looks very non-optimal from a performance standpoint too to create
a pointless temporary copy on the stack.

I assume - but didn't check - that gcc didn't do the same stupid thing
for that code?

          Linus

