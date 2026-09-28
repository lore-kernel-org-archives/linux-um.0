Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CC4CA5FA1
	for <linux-um@archiver.kernel.org>; Mon, 28 Sep 2026 16:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Idi5LKEyTFs2voreuzbcbppZ5nLIeoJ5tGdhI+MVBSA=; b=TWO9LtilYF6pDs2eXpj2/sJbi2
	G1d+7T9VDrVxb5HQPy6fleYncy9hkviLSm1GXhuB77fj975wWNWpxYjfrbBziI1ihPr6w/brvxlpN
	C9E9QFRgivUWKbcCl25VO/SQ+JfdP7ZsFqRuL9SWnQOEnIaJEyISB5zb2x9mTdwGrecV9AP4EVZGl
	dRtaIjqzcvnZzOEhB8zgPkkugxVCo9owRiWwNcGc6AaPZwmtgXQxRgVwAZPP6hcgj9bPYVpt7rc9V
	/Vy2swkI9um3MivQjUoKmNRcI2wyDjwHT0kO4SViklSVPvDuStfjM+YAdDWoZl5JnqiwM8OcFcWG2
	7LEV4LVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBE5J-000000010Ii-1zyt;
	Mon, 28 Sep 2026 16:20:09 +0000
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBE5G-000000010HM-0XKk
	for linux-um@lists.infradead.org;
	Mon, 28 Sep 2026 16:20:08 +0000
Received: by mail-wr2-x10.google.com with SMTP id ffacd0b85a97d-48439feca17so2475301f8f.1
        for <linux-um@lists.infradead.org>; Mon, 28 Sep 2026 09:20:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790612402; cv=none;
        d=google.com; s=arc-20260327;
        b=PAlBWANOuiXIz3nMMZNTYh2xcHA/+n2JAhur6hfn0RR9WSxquEYXTbJ3XJT58Xlzjv
         RpVGFl2tTEhLhtpzUnGBlDeSXUVgUbtssxa0OQMObXjrB5A9XrT3J+/PST7jBa4SmYYS
         Ce1wdYXnmkwOX5iZhbuc6y6LIiY5rhUythTk3/pk7RJ/52BIPheRILDQpvu9eWezeIuD
         h29TDMlwwRICpAtrOl/XZ9c3CIEdcRHPJhWOU2E8wk/cxcyP2erWX3Xsv/C+Kz3PoI4I
         O/TjJ7uG/SbqpDGGDQnjhYFER2obsCNgtpQk4Cmf3Y5qOyRLcF5hCuqBOWqqDjctHFwL
         nWkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Idi5LKEyTFs2voreuzbcbppZ5nLIeoJ5tGdhI+MVBSA=;
        fh=nQbj3QzfY5dgKdAA/J7pKGrdNc5Sk38ImEeV3/CrhBE=;
        b=p2GMh+LcohXcJcLMlBJsYaA6UJIw3AvBihVyj6A5nuusvddtUcUTgFlmth8+RJmUlF
         Zh0Ib2RVyRyz8TBJMjrnfUxlwo2JTcQ2IFuj/ATxZ+vy0B/AjjUG52Tz2K/okF/SnBtM
         3OpEQ4uxdRIUo9jnjYMIaPyGZlp4XzzMVgBIve+h2/qM/TrczPI1LVjSAH7R+Iw4kjgF
         Gj++X9MHFf90zSoh0PHtHbVb3ddmhZsM/Z7cCOmpLZ2MaCxepve5hRe8PHDZxjPuU7OI
         6amMPCUg7+mPEgJzoMuEGx2U6epUns+t7btwhHg4478boBrVue1h4L6OySjXb1e8146c
         fW8A==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790612402; x=1791217202; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Idi5LKEyTFs2voreuzbcbppZ5nLIeoJ5tGdhI+MVBSA=;
        b=LvN6bCoOg546NEh/Fl/+xNj8F2J7jafFo2Rm9E0EtPfcSsmu0pBSlL088N4zptdeRP
         I3Jgr78nOowbfSxS5UWj8Z9sijKYXvZ/AqhxoqcpxGxE1GBBED8q26ETs0FSmMUXOrP2
         M/YURy0L3oyaxQPc0aXF0DcbcqdkQFrwr4HwogBfPnst1Mk8pMrRp2eGrmdoANGkdMDH
         AItUkjzD0DeEH7cDUM/7OuP0t8tonPPTKJhzLxS9PyVvCHwiGX3UFRIEm073kiBs3jwT
         C0RZxczGwOL7Yw60pvS5C5cL5zqOeSTNkrPNtSJy3m/rUrPUfM9zG+HNvXZiNojKRMtA
         3ALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612402; x=1791217202;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Idi5LKEyTFs2voreuzbcbppZ5nLIeoJ5tGdhI+MVBSA=;
        b=Uiuc0LlTkimsXGdCIpcWw46SDt2HNs/la9BE6qH3YIrRRIQ8+EJagCT6+pYmkUWJY2
         xSx4qEKooUpTQuNpcwe96xrnWBMBCi8L/YALVXSkCw5nXLjgW/AyWYWg4mdmcrol6L0C
         dgxb0nPrOg1vWnz1scagWPUSUgqbU9D5ZtU05pA0KfK9FyGaABNRsEKIYGxUzE6pXtiZ
         GcFg0cysvugsGoF0ywgNYD3qfHevjnG9T9u8e3xHCswkhLLS/VE4WO+v6KhDHJ2n4UvF
         MQ19lP9iT2B30fMB3qPOArbFVeCtt8Zwg4tzhRnA6siSu1AEDqtegfomK7sNmpgswrnn
         Jjkw==
X-Forwarded-Encrypted: i=1; AKwUvBzc2wzuiqNnd0Xjpc7osOhG+tS5Nr3xX2vwt0vocV9sOgoknBWNv0JKbLr/Gl0692JvR/zWIBCnvg==@lists.infradead.org
X-Gm-Message-State: AFq9FYJ88sIHI2KMX6Q7N9SXeqnCYl5zIEk83RtJC+a8lu0IPKTDcmXU
	SaYSwq3VzPaZA5Qxgah1GVawYQo/9HjY405J2UnDgJApCs5k+PtjMVk5BysLRgh0QkDc47GGD3X
	zBWSWRsaQQuEIZhSN0Zhh3K5ruNkYH6JsO6uK9q4W
X-Gm-Gg: AYBFou2NFcQS4ncMzSfAo67G3e5ubCrOUtpnEhLFJqbM+WWgjWaknx3FKzGnGztF1St
	3c5wgiQHsnaj71sFbQM6uihRENdsACUOj1jcd9BXQo+z5oBNePsSXm3+vczBY7YoZm/ixg8UGi/
	FlnIXewPYD70C8wwjsSuDegB1HfFBYvcpJGzgtpyg+BUvx/12guY3Rl8iTfiOOhV/K57swSFnAx
	sO7VySAJva+480rpFlJxZo++HlLAU6b1Y98M58CMHS0uzv5dXkqnyW+8of8C1Qc/6bKQGDYLGuY
	tIX2dyGAU7HBJrEXuYktmLBGVHp7FjeVJhAPFf3qI9Re9n6HaA1puY8DJ9ke+KU3TCTyMax0cxE
	OQHXN3k4QXJMj+ZeMpa/0auafexrq/CZ5XhefZ15AtPzO5a9VOmFgsQ0=
X-Received: by 2002:a05:6000:41ee:b0:487:1ac0:32af with SMTP id
 ffacd0b85a97d-4887197853fmr26855385f8f.51.1790612401692; Mon, 28 Sep 2026
 09:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260821-ptrace_uapi-v1-1-3de8638a29f2@google.com>
 <e801211b4c71ddd919fa5d7b9c859b86addf3fb7.camel@sipsolutions.net>
 <CAKwvOdkMK9Tj=JgsPeQj6_Xtx3FgZK2SWTSJVU_BJ7G17pDC2w@mail.gmail.com> <20260926195145.GBargiUSEEqjWPpuaK@fat_crate.local>
In-Reply-To: <20260926195145.GBargiUSEEqjWPpuaK@fat_crate.local>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 28 Sep 2026 09:19:49 -0700
X-Gm-Features: AclHuK80ygbd3wiyZigI_Z6HIjLwZPQopGivmPnn4hRCPTRgq5S7ll5QQxv7VJs
Message-ID: <CAKwvOdn2U5xy5T3kc3epPX74nr6ja4NBFVGCqLD4GPwKYX6hBg@mail.gmail.com>
Subject: Re: [PATCH] x86: uapi: ptrace: guard register offset macros with
 __ASSEMBLER__ or __FRAME_OFFSETS
To: Borislav Petkov <bp@alien8.de>, Elliott Hughes <enh@google.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Oleg Nesterov <oleg@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Nathan Chancellor <nathan@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_092006_182842_126F3427 
X-CRM114-Status: GOOD (  17.75  )
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

On Sat, Sep 26, 2026 at 12:52=E2=80=AFPM Borislav Petkov <bp@alien8.de> wro=
te:
>
> On Fri, Sep 25, 2026 at 02:25:47PM -0700, Nick Desaulniers wrote:
> > On Thu, Sep 24, 2026 at 7:54=E2=80=AFAM Johannes Berg <johannes@sipsolu=
tions.net> wrote:
> > >
> > > On Fri, 2026-08-21 at 15:45 -0700, Nick Desaulniers wrote:
> > > >
> > > >  arch/x86/um/asm/ptrace.h               | 4 +---
> > > >  arch/x86/um/ptrace_32.c                | 1 +
> > >
> > > This seems like a simple adjustment for what you need to do in x86, s=
o
> > > that's OK, but I don't think we'll take this through the UML tree.
> >
> > Appreciated! I agree, maybe with Oleg's review this can go via the x86 =
tree?
>
> Do we want it in stable too even if it is not really stable material so t=
hat
> userspace does not have to upgrade kernels just for this?

I don't think so.  Android, say, is not going to upgrade kernels just for t=
his.

>
> Or are they simply copying upstream UAPI headers from the latest kernel s=
o
> that stable backports don't matter?

Right.  IIUC, bionic doesn't have N copies of UAPI headers (one for
each branch of stable), just 1 copy which they do move to newer kernel
versions when they need something. (enh@ can correct me precisely).

>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette



--=20
Thanks,
~Nick Desaulniers

