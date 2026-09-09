Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CECC79FB6
	for <linux-um@archiver.kernel.org>; Wed,  9 Sep 2026 19:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1ydOjuoTgA1JS+qa07cHIVSm0i9RHzfwwnuAwNBt4m4=; b=oIKH7iEjNZS4YPkdzs1W1MpJy+
	jOBo2o3tHKrye2vSBs3h1cMQqg311pYAUO2UaKK1f9FUwlNM09wye92WUOm5uxHw1H+brx0NS89bG
	9gw133Y3LNH3Syi7GDoTxgrL1FMxrS5gHuJ5xqjPSf5542RR1Hb0K7jrHDbQFxaJiPcSjijJcuLrS
	5WTsBlploZT7GzT/hWwGOG15M8Il8sQ/hbRmI2L/TZp95/WrE02gCL0zxSV3Jf26IXm1dYK/rS+hV
	SJZdwvuTSPwc137qWw8VTUL/FlccNPH+msrJ7cK/NLsWoxNA1gc0FsQUH/at8PuKJmIW/VbIcLyoe
	Tk4CxViA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4O7t-0000000Cjo2-3GpJ;
	Wed, 09 Sep 2026 19:38:33 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4O7s-0000000Cjmm-2yEV
	for linux-um@bombadil.infradead.org;
	Wed, 09 Sep 2026 19:38:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=1ydOjuoTgA1JS+qa07cHIVSm0i9RHzfwwnuAwNBt4m4=; b=jr8hBJShDSsbAEeUpEAUnpPoVg
	l3mWHA0r7c94zZvvnfOWLtsl104FS4Mo8VrKBnW08jerceN7A1o9cWRk8rT6bFnFx+eMsHVxr4rW9
	Y5EfefPysjVZ5PWRCqnFxr4SOrArjVvW2D05Fx4Y7zPkjdwOITsD7QIkLLQz3EsWkCP7Yf7ojsuMI
	Nh45G4rWk+bagFAa0K0/HgDQlkFtwS79W5RVYN/jEWemCz04+fAo3Gg2diJgK72N/bmU+dQPxGQ3L
	c2vuObDElPjNaCtDEaRfJv+RapIk87OaaxwVFjkmBk4PcpiCtrJFiFhGuIQHKIPPRIHYIixhkB7dY
	5fMKRY7A==;
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x4O7n-00000001bmU-2fsn
	for linux-um@lists.infradead.org;
	Wed, 09 Sep 2026 19:38:30 +0000
Received: by mail-pj2-x10.google.com with SMTP id 98e67ed59e1d1-39666bed442so1074838a91.3
        for <linux-um@lists.infradead.org>; Wed, 09 Sep 2026 12:38:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788982705; cv=none;
        d=google.com; s=arc-20260327;
        b=eG9jX27CQzuneHGSJGEUPU1uJ4pch3bLO/U5aP9PIJpscdSfDQchamg08GSEOAWFVH
         7PUd4OkM8lhjcu9Mx96r2zSzMLaCvBr3o89UCxVpL/SqnejhtA81vypnSFSO5y+fqNL6
         v83l3iyrEddzHlyh0rKf8uSR3ldaQ8wcDiQKjo35lfQzVcT0oFoVTUgwAJwgs20ZfS/K
         758AAHb5ZALm7VHjD1R+8ShAyPU7wnw3dSivDbTSBN5YOV/IJ8GMm42svwAdQcX+GK3k
         YFQHf2xZWNZLbqVHzAuhtXNwTDbi1EEgCNolvOcHDuloTS929vHGmkE1c63keSG3c2Ha
         2cGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1ydOjuoTgA1JS+qa07cHIVSm0i9RHzfwwnuAwNBt4m4=;
        fh=sWitKmrmnvJHrK++7KyG9xzbDHPvy0B58WstrxRh7pw=;
        b=erJsXFp7k7AzkAZ6ZHmGsLkmO6lDNkn4VYvM5OWxDIVDuEC8g8QlqyhDXJqfpfpdlF
         BOr459Q7QXGdDnjBK+ubLecBk3TgubUsU6afn8cnu63LI3IwA9RfN+/CTWbJdCAguf9x
         srSUoFmxGloOJsmDBGEoX+OrMLPU3bGqI4YinXRLdm8y7K0+oVT0awunI+GpGQUYtsNQ
         EAWbbtSepWWo87y31vvP9FhF4VuloFafNng5VeafTsboRtyqv9HOkql/pv829C3R5TvF
         R+qudGJ02+qVkyrDiAFpCFXFP6JvHU3vavcnVdxkb8cl+DUuhm4UGAX6LMvAIWQOA1fX
         eQng==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788982705; x=1789587505; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1ydOjuoTgA1JS+qa07cHIVSm0i9RHzfwwnuAwNBt4m4=;
        b=oQ/42/TKaEJpG8HsR9rWP6oREz+V8DxDp73UeBzl+eB18br57uJp2//LH3Z8H20fG2
         MmgzBluFKJYtp+fxifJ86uyt9Ddhe2YzBAutI+fZpR/7oPtun15NVv7wajZQJPlBSvPQ
         3b8jrwyiEJaWSPqhG4mQ9vE/O2mxX0JKrU+XoAwjse0wutacomQnC0i+bils4wpbv+aB
         xUKcRohu7OMOSvKV6aEJJkVjxsxrhwKGK7J0ndkuqUw4eUZojV/e6WJGAPEjx/o4QBt0
         4Bbmpx1xgjL1vgUqe8AIYx9A9Zz42/wTHxmpwdnxNwwOPQGm3RnTkq+H7DOsOM/xa4wf
         j2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788982705; x=1789587505;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1ydOjuoTgA1JS+qa07cHIVSm0i9RHzfwwnuAwNBt4m4=;
        b=MsbbfW/ZIZ6hFDeJaaCSsp/lWdzjwAapIOTnFTxPNOJgFsYZaGcVkIWGjsBH6I6Sth
         WQmtc+zMp5Cez2j1S9uWN9A6rs7VvdcoRKygDPIzbxsINXR8Iw/tacefLporKBFCRvUX
         ewWT1oXdTMJA9vDZDt63clEq1xmEAfs8rmjsm6wOjgBhqlnn9UyYbWaN0lqll9yzmhhQ
         LFRBpdYmdAThRL3/77s0s1/2sRZBVyszpMrg5bxwAQ0T38MYKSczLm7VGmFgtGWeyu7E
         LsBraCX0eficwl4cKiqcDPUis58dYmdIVLPU14byg8/U7p7+/AEtUHMdqPQyANUHhqF6
         xN2A==
X-Forwarded-Encrypted: i=1; AKwUvBx/A7VMZLgTdCxC0JBo/ZVnhVCgyVZ8CyNw2krkQGi/zivluq2KRiCSSBTN4HkzenexV4YgAAjNtg==@lists.infradead.org
X-Gm-Message-State: AFuF++kJ/CAzHfWHp3AHrTEhRMMGiQzdGp74qqBNOY5T8UhmXDZxZfr7
	+Xg3XVUhGA8aK90ggTq8Updmn9MFe1TRE/b51FpK5szz+Igi6vsrhOdcS5wCUoL2Bd0JsLmHZzZ
	cfVa1D6eW7settGZ0MhWLkuXHM99qiT8=
X-Gm-Gg: AYBFou16ULHgukVRXgzEhr8h7Gb2ZfvyebHBlQSm2R1EjffmFeMOjf4Hzlgtbj5k/nH
	ndSxyqo3EgGo/HsTLYmczNyr+nomDLACXdq4rKPBRi4a60g3Ao2GvvQV2buGyQpooCcp4QRKt1q
	qNCxOHyIGXv9vvInQNHFlcAYlrbuc2fAhx6V4r+poobu7Ex+NPLVg59eBgsS3m0MnfIFeeDcjRj
	qO9LE+vbqMv0Oz5kevtfPgFUEp+k8IRVKRD+L2WBIWwxUUDvXwIzXPjaYPH6N7niOJB4fNwohRV
	82AWVNg2Hle8woG45tx9yN7aylUmeA01dyzTegUGzn0yjSszFHaE5Uojb/Ec+gkHGzFJLQ70vdj
	dR3dg7R5IYdGDPkpKWiSkv7QQOSYWYs4KMZakA4el82xjyGM1SDmHK+yuni9R0HIoZoAJ3VHeE7
	8ZBlq5k1CubXczs5DIbyv3i5AN61uCrgSZvWV7RYmjr7E5WNieqLM=
X-Received: by 2002:a17:90b:3fcc:b0:39b:3505:c72f with SMTP id
 98e67ed59e1d1-39d77b83048mr824934a91.6.1788982705356; Wed, 09 Sep 2026
 12:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-12-3a93791af1cf@linutronix.de>
 <20260908071911.GU4120091@noisy.programming.kicks-ass.net> <ABBC0C50-847F-406A-B426-55D0C2BE15EA@zytor.com>
In-Reply-To: <ABBC0C50-847F-406A-B426-55D0C2BE15EA@zytor.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 9 Sep 2026 21:38:11 +0200
X-Gm-Features: AcwNN1V9A4D3jn7pum7crGv8bcA9jfLyy60O95H9hOe-jZGhQ7AzCwKSAv7z5Dg
Message-ID: <CANiq72=T1487Y7TpAa4c2eTJFMLHoe5Qc7+tRkbkmvrDjfmuvw@mail.gmail.com>
Subject: Re: [PATCH v5 12/24] vdso: Add the vdsocheck tool
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andy Lutomirski <luto@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Kees Cook <kees@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Christophe Leroy <chleroy@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Nicolas Schier <nsc@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-mm@kvack.org, 
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	linux-s390@vger.kernel.org, linux-mips@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Jan Stancek <jstancek@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_203827_787156_A0859482 
X-CRM114-Status: UNSURE (   9.11  )
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

On Wed, Sep 9, 2026 at 9:33=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrote=
:
>
> It was going to happen, and now we'll have to suffer the instability of r=
ust...

What instability?

Cheers,
Miguel

