Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC82CD3420
	for <linux-um@archiver.kernel.org>; Mon,  2 Sep 2024 21:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=po+MmfD4nq5cLkClRRslOxFglpMwsYkFajj19L5Hzi0=; b=i5+oXwEfKANFTYbdlFTi5Bhgdy
	L0S0ktUwo/4WvwQbmLFaeqsRABsykMbFMGp9ReJLxc9oEuA7k6VAMRSJq78wa7VrmjqSzEVlUAdCg
	IwG901d2d0GwaHRqn90hfmPl46GJy1vVFhx+IL1fKtqaX9voUCui/LAbNTypLlXPMGq//ggndkXCa
	SjXuLErr5Mp/LzgTDFyg6r5tZPuL+5hDn2Rl8q9ERY5ZZuBKquT5Eql1P1oy//tFmEaVoKR99Azgq
	1DNBy9oXfyz3DjiyOiXQQ/RjPNprUuhYwpMK4BpZ9mrbwRJEqY1T33r2Z1+t/hutLIFhfP5qv/lTj
	bAzXTbMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slECn-0000000FYOL-1sLX;
	Mon, 02 Sep 2024 21:03:21 +0000
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slECk-0000000FYNW-0FEF
	for linux-um@lists.infradead.org;
	Mon, 02 Sep 2024 21:03:19 +0000
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5353d0b7463so7764101e87.3
        for <linux-um@lists.infradead.org>; Mon, 02 Sep 2024 14:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725310995; x=1725915795; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=po+MmfD4nq5cLkClRRslOxFglpMwsYkFajj19L5Hzi0=;
        b=V6gt8GjBB/+TCb785iwrPtElX3TG2Z8vlRTqh3RtHBUO1M/xxCj/Cx6uo8hv/vyQin
         400/O5uJvL6P9z1gFNkGGmCzQ6ecrgnZkQVRxkIBq2n6n9Yc4+2Zp+UPCEBYdZsiVIdv
         J31kwcwvH4JwpkIEuS6XmfAj8fYCQKyxNU2U8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725310995; x=1725915795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=po+MmfD4nq5cLkClRRslOxFglpMwsYkFajj19L5Hzi0=;
        b=U+rmDwuW5K9qBuKPdNJb0aLmoIXm4c5vcaxh2jyBq77HuMNpRRROK3weZD40rHO2YO
         NNUbPOed6YiVSaPi+pwFsGMz8mdraFhldQc38SmDyECJGXsCHvuEUoUTmCHr6+feFCwv
         Imat6AZ+NlRN6SgdL9oL8pWLb78hh4AKd1Wd/8jx3bgWq64zLO/byyAoWAkDmB9jM4eO
         mKSM9PQJYbjoUQ/19dDdUhho0xRM+HinUI4+bLvXsz6397xtkJoQuPL8EoU4JvxI6ZCA
         wora6Ke7y4C1f5eoHjZnFjLvud9SCxa8DSOTdZB4VhjEIToQK9cWRu9iKcrQeSnn1VT8
         km2g==
X-Forwarded-Encrypted: i=1; AJvYcCU3IFEkmlQ57gIC2oXaDlnsEuPwOHUzx5ZSWwPb66GeRLPTPSO6FsvuiQZsZHPhRickbCwrulqwfA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw7R7YwMUFxB6NHk12WNbnM10MCRU5LV2o7sz8QolaAcK+46Uqm
	uZ4UxQC3GDOotES3n6cDPfQ6BdSnhSdaS9nlpbTjTR5LRHhsVLRIVrxct66XTyzqTRDbLPaTo+P
	dROUKkQ==
X-Google-Smtp-Source: AGHT+IHn4HL/Oq3WhP/gPS2U1uD8XzcEP59GYBOpO4fIFcp7aeMUS8qk0bwVnTGhl7KiMqFDgWBgKw==
X-Received: by 2002:a05:6512:318a:b0:52e:d0f8:2d43 with SMTP id 2adb3069b0e04-53546b3627amr969954e87.17.1725310994954;
        Mon, 02 Sep 2024 14:03:14 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feb9f7sm600121866b.42.2024.09.02.14.03.13
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 14:03:13 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8683dc3b17so284167466b.3
        for <linux-um@lists.infradead.org>; Mon, 02 Sep 2024 14:03:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXwzls4QkWywA2y9S2fCogIpPrnBFNGv75RF5GPouG1IuUMC1YkoVoGonhXMpfMO99fCM6RAakU3w==@lists.infradead.org
X-Received: by 2002:a05:6402:34d6:b0:5c2:5d34:a45a with SMTP id
 4fb4d7f45d1cf-5c25d34a63fmr2793579a12.2.1725310993097; Mon, 02 Sep 2024
 14:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240812082605.743814-1-mpe@ellerman.id.au> <20240819185253.GA2333884@thelio-3990X>
 <yt9dy149vprr.fsf@linux.ibm.com> <20240902134953.e834bc2e57d36b1d3b1397e4@linux-foundation.org>
In-Reply-To: <20240902134953.e834bc2e57d36b1d3b1397e4@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Sep 2024 14:02:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjD0XLhkzou89J-TK=L6B88pFoNYxN1uTWRQB3U5Czywg@mail.gmail.com>
Message-ID: <CAHk-=wjD0XLhkzou89J-TK=L6B88pFoNYxN1uTWRQB3U5Czywg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct vm_special_mapping
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sven Schnelle <svens@linux.ibm.com>, Nathan Chancellor <nathan@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, 
	christophe.leroy@csgroup.eu, jeffxu@google.com, Liam.Howlett@oracle.com, 
	linux-kernel@vger.kernel.org, npiggin@gmail.com, oliver.sang@intel.com, 
	pedro.falcato@gmail.com, linux-um@lists.infradead.org, 
	linux-s390@vger.kernel.org, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240902_140318_141964_B85A1079 
X-CRM114-Status: GOOD (  11.12  )
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

On Mon, 2 Sept 2024 at 13:49, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> uprobe_clear_state() is a pretty simple low-level thing.  Side-effects
> seem unlikely?

I think uprobe_clear_state() should be removed from fork.c entirely,
made 'static', and then we'd have

        area->xol_mapping.close = uprobe_clear_state;

in __create_xol_area() instead (ok, the arguments change, instead of
looking up "mm->uprobes_state.xol_area", it would get it as the vma
argument)

That's how it should always have been, except we didn't have a close() function.

Hmm?

            Linus

