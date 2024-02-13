Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F4B5C4829A
	for <linux-um@archiver.kernel.org>; Tue, 13 Feb 2024 17:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U8sdSIzef20qjLYADsjPc/FWWyfyItBl7kEGNmo8QOE=; b=KRQwSexuaZBcyzNFP/5xMoEQZ0
	RixGuKHG/9S6+8DVid6b4lAwP/1RHKvmJa24eLQKsNOLtuK1ifHGZYB+JYgash8E43bpF2DzfzcHB
	0+0fd+Y5g/Iv+l4F+xSDeDwVpNfCoS3CPttbCPW5iOT7aBUpPtqMSVhsZkRNQyf5dTQJPvQlorB16
	po6MFrnR6Gt8sjlSVi6wf9Z+Ztqvt8ib7sM1H7T1yayUP/Gwk6aJTcTaHml7nkwCQpYkvw1KTQVFz
	wr2KvAlnRkvsfc1AXgj3wJIO8kNyyhvJET/0MhrXbPAAcCFosNZKCJmqp2UU+qfnmauBGMjAESRXS
	WYnSbL1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZwxD-0000000ACj9-1HwQ;
	Tue, 13 Feb 2024 17:52:23 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZwx9-0000000ACiH-2a2z;
	Tue, 13 Feb 2024 17:52:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 08ADBCE1D83;
	Tue, 13 Feb 2024 17:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D0EC433B1;
	Tue, 13 Feb 2024 17:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707846735;
	bh=L8FC9DVO0Mg3A15dXzRFV/FVQ7qBDm65d4gp1EA3LVs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=daxJyUTOygGsSs/Ac0C/RS+vBvjT/1OTIQY0OFsLXyg/qVAC9zQVSgdMg5WnyLGM/
	 gdaRq59lek46Ry+Jxj0SH/yjhMw216i1oEawpKa7Xrxx6ZsWt5BJoW8dr6GOuZSSs9
	 SbACEIWrB1LROLgcDZpe37bRsJO/raRjwIx+hNR/XBCn1FKxYfZMJIejONxoulwpiV
	 QCbelNCiNug+7eWsobbzEPtB7X5eZly6u2MGRL4aQgZ+EfG+AdsVFIq1uQiTi8OYTx
	 49n/n7UrCuFgv3YDGT8KLYOpCg1M2yuJ2ZhVvqYVr0Wlx+183OrsBkgSCcGwN20W9F
	 E2O78WbM+JQhQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d0cdbd67f0so65893111fa.3;
        Tue, 13 Feb 2024 09:52:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUVWKKz2JNhFHFDnVW+NNc/T+QLuNnmdsDj11Dm2i6ufnbT56dMgX0bo5sE0HxbdqLesV9/qDSZQO4Mx5tBtnqK0gXCnyRtC64CIVxvxoP8HSAsk8Q+NWG6V9KXproAAzZ8Q6jJpchUiRIWuhy0m7v43a4=
X-Gm-Message-State: AOJu0YycKbPQSdDR+fs0wgmb13lAT36xnFL+soD0kt+q+UDmRpuW2TaP
	yLFdhfy9kyracseq7bx7PFPKJ1OY18xD9eIsgm3smj6WXXMv/lrgn+9ssu4UA7Z3szYCRx2LTJ9
	QOxcLctPXF3zcEVyjZr5mVVcTfA==
X-Google-Smtp-Source: AGHT+IHuJy9IhWrPjMlCvqKJHMknK0u5AfC6XtdFikCh6p+qjoUnM3Y3a9lEYpei+DOe2y5nhijH2ca4zis+r3nNpfE=
X-Received: by 2002:a2e:9992:0:b0:2d0:fd1e:c588 with SMTP id
 w18-20020a2e9992000000b002d0fd1ec588mr297630lji.9.1707846733488; Tue, 13 Feb
 2024 09:52:13 -0800 (PST)
MIME-Version: 1.0
References: <20240202195909.3458162-1-sboyd@kernel.org> <20240202195909.3458162-8-sboyd@kernel.org>
 <CABVgOS=A8BQ6HHpBKFqg-N10ckk2XYavaS-MPXvZ0wenrVm=1g@mail.gmail.com>
 <89892ecd6b1b043db58258705c32b02b.sboyd@kernel.org> <CAMuHMdUuP5Ya2gU3V_ET=Ji_+yx+jr7eCch5uDJSqvQN9jJM3g@mail.gmail.com>
 <2185a3cc3152a0b9a94b0c64353bc9a1.sboyd@kernel.org>
In-Reply-To: <2185a3cc3152a0b9a94b0c64353bc9a1.sboyd@kernel.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 13 Feb 2024 17:52:00 +0000
X-Gmail-Original-Message-ID: <CAL_JsqLrRXdPZ+u9XG960V7sXECBi5Ko7BYdreftYz-O=Hwieg@mail.gmail.com>
Message-ID: <CAL_JsqLrRXdPZ+u9XG960V7sXECBi5Ko7BYdreftYz-O=Hwieg@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] of: Add KUnit test to confirm DTB is loaded
To: Stephen Boyd <sboyd@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, David Gow <davidgow@google.com>, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240213_095220_030025_F45CBE61 
X-CRM114-Status: GOOD (  27.69  )
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

On Fri, Feb 9, 2024 at 8:59=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> wrot=
e:
>
> Quoting Geert Uytterhoeven (2024-02-05 11:55:29)
> > On Mon, Feb 5, 2024 at 8:19=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> =
wrote:
> > > Quoting David Gow (2024-02-02 20:10:17)
> > > > On Sat, 3 Feb 2024 at 03:59, Stephen Boyd <sboyd@kernel.org> wrote:
> > > > > Add a KUnit test that confirms a DTB has been loaded, i.e. there =
is a
> > > > > root node, and that the of_have_populated_dt() API works properly=
.
> > > > >
> > > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > > Cc: Frank Rowand <frowand.list@gmail.com>
> > > > > Cc: David Gow <davidgow@google.com>
> > > > > Cc: Brendan Higgins <brendan.higgins@linux.dev>
> > > > > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > > > > ---
> > > >
> > > > This looks pretty good to me test-wise, though it still fails on m6=
8k.
> > > > (Everything else I tried it on works, though I've definitely not tr=
ied
> > > > _every_ architecture.)
> > > >
> > > > aarch64: PASSED
> > > > i386: PASSED
> > > > x86_64: PASSED
> > > > x86_64 KASAN: PASSED
> > > > powerpc64: PASSED
> > > > UML: PASSED
> > > > UML LLVM: PASSED
> > > > m68k: FAILED
> > > > > $ qemu-system-m68k -nodefaults -m 1024 -kernel .kunit-all-m68k/vm=
linux -append 'kunit.enable=3D1 console=3Dhvc0 kunit_shutdown=3Dreboot' -no=
-reboot -nographic -serial stdio -machine virt
> > > > > [11:55:05] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D dtb (2 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > > > [11:55:05] # dtb_root_node_found_by_path: EXPECTATION FAILED at d=
rivers/of/of_test.c:18
> > > > > [11:55:05] Expected np is not null, but is
> > > > > [11:55:05] [FAILED] dtb_root_node_found_by_path
> > > > > [11:55:05] # dtb_root_node_populates_of_root: EXPECTATION FAILED =
at drivers/of/of_test.c:28
> > > > > [11:55:05] Expected of_root is not null, but is
> > > > > [11:55:05] [FAILED] dtb_root_node_populates_of_root
> > > > > [11:55:05]     # module: of_test
> > > > > [11:55:05] # dtb: pass:0 fail:2 skip:0 total:2
> > > > > [11:55:05] # Totals: pass:0 fail:2 skip:0 total:2
> > > > > [11:55:05] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D [FAILED] dtb =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > Ah yeah I forgot to mention that. m68k fails because it doesn't call =
the
> > > unflatten_(and_copy)?_device_tree() function, so we don't populate a
> > > root node on that architecture. One solution would be to make CONFIG_=
OF
> > > unavailable on m68k. Or we have to make sure DT works on any
> > > architecture. Rob, what do you prefer here?
> >
> > I guess the latter?
> > Alpha, hexagon, parisc, s390, and sparc are also lacking calls
> > to unflatten.*device_tree().
> >
>
> sparc does that on purpose. Perhaps it's simplest to call
> unflatten_device_tree() if of_root is still NULL after setup_arch()
> returns.
>
> ---8<---
> diff --git a/init/main.c b/init/main.c
> index e24b0780fdff..02f5cf8be6c1 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -97,6 +97,8 @@
>  #include <linux/jump_label.h>
>  #include <linux/kcsan.h>
>  #include <linux/init_syscalls.h>
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
>  #include <linux/stackdepot.h>
>  #include <linux/randomize_kstack.h>
>  #include <net/net_namespace.h>
> @@ -895,6 +897,8 @@ void start_kernel(void)
>         pr_notice("%s", linux_banner);
>         early_security_init();
>         setup_arch(&command_line);
> +       if (!of_root)

of_root is another thing I'd like to remove direct access to. That
check could be inside unflatten_device_tree().

> +               unflatten_device_tree();

That's back to what Frank had essentially and I wanted to avoid.

I think I'd just disable the tests on the above arches and let them
opt-in. I could be convinced otherwise though.

Rob

