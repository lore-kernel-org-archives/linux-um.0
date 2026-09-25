Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01265C9832A
	for <linux-um@archiver.kernel.org>; Fri, 25 Sep 2026 21:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LZBkr4Ro3niOwydI3OdaV1WcaDVvXJ8dIflx3msX2no=; b=bRTv4ShGlYswFrSUw9hitn0YOb
	6gjefvL6E6AdW3GGZeOBilhRHk2HHhgb4w0Mgcir9wY3spnGYS6sCrlSyYhYxvu7XpjlYxq7kxJcJ
	sIPDgMnzA4gO5veCPnlb1d2qo4iZZD0llHdIfIILJpMClJ3RnsiIqo4xpg8wfuCs3mRSJT40xxDia
	YcvGGD5gNQxWKHuo4DmoJfsvcn4EsDnctS2fWSk815eZHWK05lyRrfZmQT3Kl44Xt5SwdddflqnmA
	4DHXBwSwupTcAPwaM5wZ49Ep2OhLekGInsqxUUeEdvtKDtemy6SLjNZ4At9iViGmuIbM4wZSluFPH
	gfUB5W1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xADQm-0000000EUfW-0CQt;
	Fri, 25 Sep 2026 21:26:08 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xADQj-0000000EUf3-3cHU
	for linux-um@bombadil.infradead.org;
	Fri, 25 Sep 2026 21:26:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=LZBkr4Ro3niOwydI3OdaV1WcaDVvXJ8dIflx3msX2no=; b=i4BK0LxgDfBjcLtLWXedQaUzXm
	VEIOlITQqoQxmslPhAayUuwJ50Rj7VR9ux5UCY0wLfOojENfDKsjc9xqIzdZhVcLEkjn74bxRDNtY
	A+G7qK3EDT0ynyV934KnLrwzg9M9t71EeJw/uv2aI8F4L3H5GiFKy9gtlR2VJCEOv9NZ4sNaLXTp6
	MJeUm/8ua1r2C+o3bMY/Ujcw87ntJvGgBBNgtoO+om76boioA6ux3MMvwC0AJzxB0MjFKatVBgHFx
	a8H2zKo39p9DFtuRtxbX5JPtCN7tdZrzfijqmfaGPWIrkIMKNUq19xW+cc9LAP+Xj1sUfMBBiz8cA
	Zitf2blg==;
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1xADQg-0000000HNSe-3427
	for linux-um@lists.infradead.org;
	Fri, 25 Sep 2026 21:26:04 +0000
Received: by mail-wm2-x11.google.com with SMTP id 5b1f17b1804b1-49e83a388f8so9074595e9.1
        for <linux-um@lists.infradead.org>; Fri, 25 Sep 2026 14:26:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790371560; cv=none;
        d=google.com; s=arc-20260327;
        b=ekJGgofAwBUo1+lJG4LS5M7U7jPK6TlOUvF/Sh+bcZ6Y6n9xgci1VRdYPjs4xrspTc
         LXPUlaEn/bTgPqTazMeHVM/7xEbBniFfNVhh/f0Fq7POAlmLc1Sn2sVrhj3Z70oPvXiv
         jJxTf0xyguoKKFeI1SGpT41RIafSsoIDFz8P1zIdeBw08d3xN9fexN6DTfBOekFG6LWY
         x+PnX7BqLlef9kSMZuT6x+d0iHKVd1Lgk+bzqmRyIFKPfV+60TinwR6nkB6iWLYn03tK
         /KxlfaNa+o8Jn+TZeN+U27/gujALEw/acBFAl9nzi/pbJnZfFmk44v1D3wpm0vmKGzES
         +stg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LZBkr4Ro3niOwydI3OdaV1WcaDVvXJ8dIflx3msX2no=;
        fh=D6exujPbINPE+ln85EYM7LFjijEs4FjFnCMukMZtHW4=;
        b=Y8c+BkAi/UCaoUVTAGM4Oi6Fakz+JFaHGN4TU+UBxWeCeucgk+BIYdXkKuixI21EhG
         4E4swe/v1/kZcdhKyoLCwCLlwv0gN8mW0vDwyibIhK0MUNmzl6caRd+OKAzqCPXxQ5WI
         3qqf6+KW3zuJnXTHrGTdkCtkEL9tPn0OGhG5bBxMm5C33ADO1KUk5tuBpn2FqzOyNs6n
         krPFOlizgt+42G+EcgESJtQ1rpff8h/YX9TaDd6Fs/TBMkV1m42wYOSY3GQQ0GC/2god
         bvTRBZhUa5XIgRABf5MhzGIOaxS/asWxrAy/RJYWtRlnQsjc+ItzUc/KSMCfl2UX9seP
         Wb+Q==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790371560; x=1790976360; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LZBkr4Ro3niOwydI3OdaV1WcaDVvXJ8dIflx3msX2no=;
        b=S9eFB1rruya3TEma7PiB+K9JUbXQKpfo2a3p1W3MEXhPXPf6i1ZBoI4YnXOrvAzVeh
         2v+KvGG+BU3+gy68u389V3/PA6zvNvvAcsmenDGml4qcSZgGyK9LuYNe2PB1yUtjFAHN
         mRy7Cvs6aFt6Fg9PwIHadpXDCX/ds90O1PY8iCeqbHXtUzqHoUsEIIN/46B+DXblOlCQ
         2iZyKyZXdz5YvTeigUTMar32p2hecqQ4y/9JzEH3pHZ3ZEPfijMBReFtAbDhiL1d0AGW
         6TUeP3a49w5idP7DAx4Ln2GXmxRziCZKA/AAdeDdhnmIQJBp2d7OTTy8aCrVHHDofXDZ
         3BYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790371560; x=1790976360;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LZBkr4Ro3niOwydI3OdaV1WcaDVvXJ8dIflx3msX2no=;
        b=Rio7W13oBq/x6eXl9bZxeMALSxl6khKFxIlcc4a3O73prafzHEwiFPDlW7VAJcflyd
         0SQaP//yScgEf4KOjQbkn1QP4OmRsUtGhHTnv40P54gRCy8d0Ly5i3mMWpl3vbGnfkjO
         oX0NN0iXO8633q6ohjIHoWVDeXCnD0bakKMb6yANaJri6TMJqFMeecCrKGMJ3JthZW6M
         vLXH1Q1uI10mbF14MKxpNEqq6LqVPwa09nfC9WPflI8Xnm7+0tq5nfiydvPJNTMRF5Od
         4LW6CftWmZKcWa+SPjAy7qgNLgWnhxRbTYqIp5bQMCakaD7RJZuADlKMefmUrt6O/UKv
         cOOw==
X-Forwarded-Encrypted: i=1; AKwUvByZCf+1DLDTJSNXiWmwfaBoYYhKoJQlTeIbGmXvEv0xZP9zUZTh+ME+Ev74l5LsQyCnMgGO5fPUVw==@lists.infradead.org
X-Gm-Message-State: AFuF++nJNmQ9UI3tstmtuE/MWqIZOU7wiQlg/a6Jb8Gbxha8MZT9/e84
	rh3ni1p93AOsU4rUF68MeR/7LLcQ2a+391HNzCINZ9Jgx7bpYi4GNPlNi7+13BHVwf7zhDQHHOG
	+Ok906RnuNXynWZtxS3luFGdeyww7nkmSCsWsmKnD
X-Gm-Gg: AYBFou3nCCknSjzgyb+MYgrvhd+K5BRg+NeGsEc4fHWxptmtbSWLU8VEwboVhopUjYx
	YgXfA8pFRQpfm+0gMiUvK2D0Xh1x3ZKaRr8lddOEY+ZMyAvArzmI0llRg2x+OttEU40qip6Udpn
	3CxOyOT8a2veoHtNA4omJO72r57Puhk6DhCvhCmvLb5XNMurxnoa+i2YTDuWbTYp9h09+O8ExaY
	9J7uXkB8u5BTj8xyyJ5InHYso8rjXDUuTLKMwe6coFUir0iJ0HaUysrkyDaS2RZlMzW7Vog2J1w
	rhnpza7PgsSegMJunfrZkJG5SI/HqNzRbaTRqaTl2D8pGlw32HmokSpa0GyaozS70JpZl/ouaEK
	X4B07VTtpdtG0TQ/SB2vl0p8kqyKdI2UctL2sx/lhQ5erh3qWQr6/z9YBoyFWvPuMc3ATepnv9E
	/NOHkT7w==
X-Received: by 2002:a05:600c:a16:b0:49f:eddb:bcb1 with SMTP id
 5b1f17b1804b1-49feddbbe6dmr72387875e9.25.1790371559677; Fri, 25 Sep 2026
 14:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260821-ptrace_uapi-v1-1-3de8638a29f2@google.com> <e801211b4c71ddd919fa5d7b9c859b86addf3fb7.camel@sipsolutions.net>
In-Reply-To: <e801211b4c71ddd919fa5d7b9c859b86addf3fb7.camel@sipsolutions.net>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 25 Sep 2026 14:25:47 -0700
X-Gm-Features: AclHuK-P_xUsgO3opj_R1RrEcEd0-ijVSs2NhvjFANGxEbSXnfoNvN06zC1Vukc
Message-ID: <CAKwvOdkMK9Tj=JgsPeQj6_Xtx3FgZK2SWTSJVU_BJ7G17pDC2w@mail.gmail.com>
Subject: Re: [PATCH] x86: uapi: ptrace: guard register offset macros with
 __ASSEMBLER__ or __FRAME_OFFSETS
To: Johannes Berg <johannes@sipsolutions.net>, Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Nathan Chancellor <nathan@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260925_222602_957609_6033E1C4 
X-CRM114-Status: GOOD (  13.03  )
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

On Thu, Sep 24, 2026 at 7:54=E2=80=AFAM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Fri, 2026-08-21 at 15:45 -0700, Nick Desaulniers wrote:
> >
> >  arch/x86/um/asm/ptrace.h               | 4 +---
> >  arch/x86/um/ptrace_32.c                | 1 +
>
> This seems like a simple adjustment for what you need to do in x86, so
> that's OK, but I don't think we'll take this through the UML tree.

Appreciated! I agree, maybe with Oleg's review this can go via the x86 tree=
?

>
> But for UML you can have my
>
> Acked-by: Johannes Berg <johannes@sipsolutions.net>
>
> johannes



--=20
Thanks,
~Nick Desaulniers

