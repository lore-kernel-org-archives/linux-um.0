Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D9AC3DA4A
	for <linux-um@archiver.kernel.org>; Tue, 20 Aug 2024 01:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J5Wu1obaVVIh98VUfFJoSH8iTiA4TVMtHy8zZl6wgS4=; b=dmWRQhB2ryfPvaNIZ4VplbvGJE
	ieeZIWcIsiGh4mTQwGg4YC/8yBCdFlrVR0oAcnIh80K/27ZlPyiM3QKYaLOOO8wGil02BN61axM1x
	3vQPnFTPFcQV1l4mhjzB9gjIJWce4r2JNYfJqR+teebT7UIhbFB7rx7SMcakZW+26/yWIjknoXozo
	AWtlz5/C8m735cOAFeMG5T37BWmT3rZu8U8yjg+30bHvPOCpoK/JWKWFxAU41Rkdt5Fzb0F6Mk3jS
	/HDqjkfga9LX2fh/KVO6blInRgETQ17LLwHyxraPkMTphBKzi7YtJI5otZhNFhn3bhE0cLDp3NB3D
	cOvPyVMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgDUj-00000003PBZ-1gxl;
	Tue, 20 Aug 2024 01:17:09 +0000
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgDUg-00000003PAc-3mzT
	for linux-um@lists.infradead.org;
	Tue, 20 Aug 2024 01:17:08 +0000
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a8643235f99so75109066b.3
        for <linux-um@lists.infradead.org>; Mon, 19 Aug 2024 18:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724116625; x=1724721425; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J5Wu1obaVVIh98VUfFJoSH8iTiA4TVMtHy8zZl6wgS4=;
        b=T/Pk1nbE3a1VGbRINrMORYFQXaT3n6m/+oXRFVRJcqtDHWXYwqqIYwWab0OLfBfEp9
         f13bXUkler9eqXolkZV/uAiJSL4dQ+75IEjRKIPojqKpgtQuFtPLtMHVIDTuAa8AE468
         RCpxZ/MUPd2Qcvg9ufDjXL4L/ZA6ursoH75mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724116625; x=1724721425;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5Wu1obaVVIh98VUfFJoSH8iTiA4TVMtHy8zZl6wgS4=;
        b=C3EEhinbgWYLMxLgpGR63/YcVvuvb2YmIbt/6PHyFAVaRVwkvUhPdVAJrgZzgeGp8G
         0Qm3oXH2qb5WrQ8wu/ONvci1fpKnSXA6yV8kKNcNDCDbCN7hrYeEr9c1nO/EVCTrHVV3
         SWyp0v4DTFJ8QAxrxyOvd2nNb0Cf3APN90UT/ym8Q1f8p7EeSHViXyQlncPmCGn4BjT2
         4+eUaMb8MGIivoUQb4mv3G0MvhNjuLMqidUSnZqqAGFw3dpJxfb6/WcrfVvxwoDfy85W
         hpTtgWF5xivKKRNyZtzcG3ytufqCQ+ztEp9lffUR+NkOAgzphofd+wOsaNHfGLOQlX1Z
         oDng==
X-Forwarded-Encrypted: i=1; AJvYcCWCYd6jB8DWzZdqkwAI75PA1mMu/3sB0k60iABj0qs/eS3UxO9P0aEyJG9oWxDSnK0CyJhX6s2lN7jhjh80ed73T+zj6anH9GtZtRK1
X-Gm-Message-State: AOJu0YzlBG3kDL76tR7vYA3O8ZzkwuIzV5N6UuYYGmEP0SS9P11m6N1R
	MAqAaB0NXEorBqcNQrhSHIO0ceZlZqMalgWox4locVkVeuzLtWbRhwR+HI2yzQjBHdpIrSgJYU7
	IRl8M8Q==
X-Google-Smtp-Source: AGHT+IHPBKIdobys9AkKO+PK9MirW/Gg91alESfuTuYTonw1IiP7NXGLR3lndhLyJi7V0bvvHr8sgA==
X-Received: by 2002:a17:906:c103:b0:a77:e55a:9e87 with SMTP id a640c23a62f3a-a8647b0a2afmr38212566b.48.1724116624667;
        Mon, 19 Aug 2024 18:17:04 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383949e45sm702130666b.145.2024.08.19.18.17.04
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 18:17:04 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8643235f99so75108166b.3
        for <linux-um@lists.infradead.org>; Mon, 19 Aug 2024 18:17:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAAEwHPgLK1lRNVqjVPx3v2BECBZd2XndprFVmvouOnJwgGz4X7oB2Xtpz4XfYoEacPEGjRAETP+PfTCZYdLb8//Ge9hECidzhIQQB
X-Received: by 2002:a05:6402:1d50:b0:5b8:f69b:65e8 with SMTP id
 4fb4d7f45d1cf-5bf0cfbca19mr536978a12.0.1724116301657; Mon, 19 Aug 2024
 18:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240812082605.743814-1-mpe@ellerman.id.au> <20240819185253.GA2333884@thelio-3990X>
 <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>
 <20240819195120.GA1113263@thelio-3990X> <CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
 <CAHk-=wjzYKrwSDK3PFMC1C2x37aKzEuC7dVxg0kGt8h+vjZfjQ@mail.gmail.com> <20240819180548.9f5dac3ac0bd09a26c0d0948@linux-foundation.org>
In-Reply-To: <20240819180548.9f5dac3ac0bd09a26c0d0948@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 19 Aug 2024 18:11:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiyxQMG7gK5d=_UEcHF2PV3EoCFrENEhRvJH9Qsk7cOeA@mail.gmail.com>
Message-ID: <CAHk-=wiyxQMG7gK5d=_UEcHF2PV3EoCFrENEhRvJH9Qsk7cOeA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct vm_special_mapping
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu, jeffxu@google.com, 
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org, npiggin@gmail.com, 
	oliver.sang@intel.com, pedro.falcato@gmail.com, linux-um@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon <linux-hexagon@vger.kernel.org>, 
	Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240819_181706_970508_1AFBC807 
X-CRM114-Status: GOOD (  12.37  )
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

On Mon, 19 Aug 2024 at 18:05, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> >
> > I forgot to actually attach that "this". Here it is. For real, this time.
>
> Thanks.  Do you think your one-liner remains desirable with this fix in
> place?

That patch actually removes the whole 'legacy_special_mapping_vmops'
that my one-liner then removed the '.close' field from, so no - my
one-liner just becomes a non-issue.

NOTE! That patch of mine *will* conflict with Michael's patch series,
since my patch to remove legacy_special_mapping_vmops was done on top
of my current -git tree. But it should be an obvious conflict, in that
it just means that the addition of .close never happens.

               Linus

