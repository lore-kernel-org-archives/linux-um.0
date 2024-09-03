Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8B1CD13CF
	for <linux-um@archiver.kernel.org>; Tue,  3 Sep 2024 09:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V6Ts8UeyZzyhtsfr4GKAWGTzPe6MoHhPae1lOHa7ehM=; b=DlbBKeIQeXA5N09oxeuecgRxNO
	MXu+N0CLlzJkJh2t5jSRe20Bd1yN80tkL+PBldZyYx7ZUT+YRDr2X8dxhdjdJ6KNQcjg/99JBCHPF
	VNYPQL78qxz1nFsAjTPWRxVKMocrTE1+UkKNMgaYGQDUW0l7HM/eNL4eYRSbtnAEsaqD11NFncpJE
	x/73RMuEvgwiinaRJ9adaI5ALWgu5rpYLmkRiQjs5jTs7kVE5W6AiHuGUIikGHmSWKpFpUbplA3uW
	1PjPCUSWbcNFc7HQbHDIGJ3NqG80QO7aWIkc/vNoqhveeldhHkozmELsUNZi40u9SpcLcCUtmI8x4
	yl1P6VYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slQ5V-0000000HDyr-3FAP;
	Tue, 03 Sep 2024 09:44:37 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slPqy-0000000H9QM-3EeV;
	Tue, 03 Sep 2024 09:29:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 9DFE8A42623;
	Tue,  3 Sep 2024 09:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C6AC4CEC5;
	Tue,  3 Sep 2024 09:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725355775;
	bh=V6Ts8UeyZzyhtsfr4GKAWGTzPe6MoHhPae1lOHa7ehM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B2+DIvPMxoKjhFD7wiF+7h0l/cf/7MYT3BR0Zhx9vp7HBRO4mfIxwB9KqYB/sTeeC
	 1G81qhU92qnFCiE/jliReBCBu6b2qHvBBHBVRrSMDGFA+JwuXas7widUz6aFtvxdkF
	 4tjHzOkHd6/ex/78UYqR6cDfYnFj/Pq5XqY4K3a0iXYisf626Hp7/acc1DOSY/a6cg
	 a2POT1sITjmIyfszLS/XUbkntiO3MqghfOGuiOpgHz9jatyaXxIOGO9cYBAqqbwA/B
	 15wIL94JzUdR+NZ65E3bnzn2/+w0/WyZpdfxs3YRDoguIILWF4YT/rse1cCgfc4OyQ
	 fg09k/DSfw2nw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5343eeb4973so7815124e87.2;
        Tue, 03 Sep 2024 02:29:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8mly9lAGlfnlByf9qY68XE/MX4peY1Y2cJCg+eQKp8STjoPzO799BlUEtbLAkQZKeeMrDw5DDTuSGmlrLqyXw@lists.infradead.org, AJvYcCUjiiaCaYT7uWcHDFV7MP26/BcV/xobpSJvA09yR7TPhv1xql75c266x7RRQy7ng+hHIvZbDGP+z5o=@lists.infradead.org
X-Gm-Message-State: AOJu0YzLmxeLqin7AFJgOWWjp+eegibQnhM0ffQbQ0g8HhyTr82Oj4VB
	oljNGV2y2lBVYqanto9tGwc0q/e9fNhUvwoQcKvUakb4LAaEdztD4MCdlhFTPp1j4GeMM4uoRlp
	rapSHcHqtw+utXHxlMddglmHyXaM=
X-Google-Smtp-Source: AGHT+IHCtdlG38E/0l7FYyhNp/Eh+agXUP/x4m9X1sDISAuGOfE6COrF1RVXR4n+XrSU6Tf+eKwYmtlidm1SXvGzdlM=
X-Received: by 2002:a05:6512:108f:b0:533:4785:82ab with SMTP id
 2adb3069b0e04-53546b223d3mr10683476e87.1.1725355774159; Tue, 03 Sep 2024
 02:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240828083605.3093701-1-vegard.nossum@oracle.com>
 <875xrd7h88.fsf@mail.lhotse> <d1bb2638-2e0e-44ef-b8da-9746ed532ed1@oracle.com>
In-Reply-To: <d1bb2638-2e0e-44ef-b8da-9746ed532ed1@oracle.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 3 Sep 2024 18:28:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT84K0RgDfLoOOLjtyCqsS19bASXRv43HF8P=C9obJPVA@mail.gmail.com>
Message-ID: <CAK7LNAT84K0RgDfLoOOLjtyCqsS19bASXRv43HF8P=C9obJPVA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: use objcopy to generate asm-offsets
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-omap@vger.kernel.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_022936_962461_50BC7C6B 
X-CRM114-Status: GOOD (  20.68  )
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

On Tue, Sep 3, 2024 at 4:21=E2=80=AFPM Vegard Nossum <vegard.nossum@oracle.=
com> wrote:
>
>
> On 03/09/2024 01:45, Michael Ellerman wrote:
> > Vegard Nossum <vegard.nossum@oracle.com> writes:
> >> Remove the sed script and compile the C source listing structs and
> >> offsets to an object file (instead of assembly code) that embeds C sou=
rce
> >> directly. Then extract the C source using objcopy.
> >>
> >
> > I threw some builders at this and hit a few errors:
>
> Thanks, I also got the ones from kernel test robot and figured something
> was going a bit wrong.
>
> There are several issues: clang wants - instead of /dev/stdout as an
> argument to objcopy, and then gcc has some bugs that prevent the numbers
> from appearing correctly on some architectures, also I had an extra # in
> the COMMENT() macro which only resulted in an error on some
> architectures. I've attached a tentative v2 that fixes these issues, but
> I'm still trying to figure out why m68k is giving me slightly different
> output for include/generated/asm-offsets.h and why the arc assembler
> fails.
>
> In the end I'm wondering if this patch is really worth it, given all the
> failures and little workarounds :-| If I can sort out the last few
> failures I'll submit it as an RFC.

This patch has zero benefit.

The current way (preprocess + sed) is faster than
your way (preprocess + compile + objcopy) and works
independently of tool quirks.








--
Best Regards
Masahiro Yamada

