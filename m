Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6C2D32D9A
	for <linux-um@archiver.kernel.org>; Tue, 12 Nov 2024 12:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zvGM/dFC7sceI4qZceCqeynGhYWBOFt56Cn5duEmL1s=; b=pYHA0/HZL4+m9VUW5YgHWIPAyL
	YdMw4VUjn6ougTf0ypTLaqjA+Ity56834uw5adzRqGLOzV6k8163vDxUtV2855llYK8/z8vR++kL4
	evHiwSXqv7xJGeuAtMLsNYwNYXplTYCiugdznrkxfRGj5InXjdaFhKB2UL1lg5AVeICSwl9zsUPGD
	LTUeGWVkBjouWTm+8SS67oYt4inZgpfBKmQnE/6OgnY/IK5TJnB4+2uu/ruItw5PZfn1CHyiNJ5q8
	iaaeeEJOeJ/C/V6lBKEs68Y05xlnhrPJUvZz1nvX0KVjAdBCSxOWFjFOn3RCkNRtUsKjayysu+7cT
	K8/UyL5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAqKO-00000003Rna-0AJr;
	Tue, 12 Nov 2024 12:49:04 +0000
Received: from mail-yw1-f171.google.com ([209.85.128.171])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAqK6-00000003Riy-1Ze8
	for linux-um@lists.infradead.org;
	Tue, 12 Nov 2024 12:48:48 +0000
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6eacc99a063so54155007b3.3
        for <linux-um@lists.infradead.org>; Tue, 12 Nov 2024 04:48:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731415722; x=1732020522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvGM/dFC7sceI4qZceCqeynGhYWBOFt56Cn5duEmL1s=;
        b=hKnFbiKcPjHszuXN5BeeVAGTcArMhPH4/VT8B64JX3aYlvqFFWpl3qLLpzPoKb/dmh
         qo3QD6unXkBL5w9hvUmZGA6IPA+DiiXFHd5pTaxwiBjk++m21zqiwGv3VGzvUBx9bQc6
         JEKFmWhV0Bxo7CtZdhDGAF09pEgcE9cted1VEvLHBHklJYiVIY94En7oNxOsU23bpFQl
         4Y/E2fXMb7AensH2bV4xNlG82l8FzIBCl0qARxv5FSkGcM6Cu7H7jH9RVZfBrYT254+t
         X/BK33muUEtuYU53nWdn6onbKXI0WhhT4yEYzqEYatLexlXebK7iOh4PRr8u6A8WT4I+
         xQ/A==
X-Gm-Message-State: AOJu0YzvWZBw/8PfDabsWlrqfvZI7j8MCZIMqH5uGSa9gN3uAlgVHwI0
	zw1TklAuKGhBPUiBqqmP2RwC4bluQ5ybR4xsuISsRtklX1JE//gD749s3Ya8
X-Google-Smtp-Source: AGHT+IE/4nU7YRXyENQcnjQqeA48YCH8faH+LB7FkydS6veyEo4P+6qwavj1mhndnLFV6XPFsBZUIA==
X-Received: by 2002:a05:690c:6408:b0:6e2:f61e:8c9 with SMTP id 00721157ae682-6eaddf9751cmr176960027b3.30.1731415722254;
        Tue, 12 Nov 2024 04:48:42 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eaceb65622sm24832157b3.82.2024.11.12.04.48.40
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 04:48:41 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ea7c9227bfso56746607b3.2
        for <linux-um@lists.infradead.org>; Tue, 12 Nov 2024 04:48:40 -0800 (PST)
X-Received: by 2002:a05:690c:f91:b0:6e3:156e:a917 with SMTP id
 00721157ae682-6eaddda4438mr172338577b3.14.1731415720325; Tue, 12 Nov 2024
 04:48:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1731290567.git.thehajime@gmail.com> <ea2a3fb86915664d54ba174e043046f684e7cf8c.1731290567.git.thehajime@gmail.com>
In-Reply-To: <ea2a3fb86915664d54ba174e043046f684e7cf8c.1731290567.git.thehajime@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 Nov 2024 13:48:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU+Lyj3C-P3kQMd6WfyjBY+YXZSx3Vv6C2y9k__pK45vg@mail.gmail.com>
Message-ID: <CAMuHMdU+Lyj3C-P3kQMd6WfyjBY+YXZSx3Vv6C2y9k__pK45vg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/13] x86/um: nommu: elf loader for fdpic
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com, Liam.Howlett@oracle.com, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241112_044846_454913_B58A8FC2 
X-CRM114-Status: GOOD (  19.69  )
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

Hi Tazaki-san,

On Mon, Nov 11, 2024 at 7:28=E2=80=AFAM Hajime Tazaki <thehajime@gmail.com>=
 wrote:
> As UML supports CONFIG_MMU=3Dn case, it has to use an alternate ELF
> loader, FDPIC ELF loader.  In this commit, we added necessary
> definitions in the arch, as UML has not been used so far.  It also
> updates Kconfig file to use BINFMT_ELF_FDPIC under !MMU environment.
>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-mm@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> Signed-off-by: Ricardo Koller <ricarkol@google.com>

Thanks for your patch!

> --- a/fs/Kconfig.binfmt
> +++ b/fs/Kconfig.binfmt
> @@ -58,7 +58,7 @@ config ARCH_USE_GNU_PROPERTY
>  config BINFMT_ELF_FDPIC
>         bool "Kernel support for FDPIC ELF binaries"
>         default y if !BINFMT_ELF
> -       depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !MMU)
> +       depends on ARM || ((M68K || RISCV || SUPERH || UML || XTENSA) && =
!MMU)

s/UML/X86/?

>         select ELFCORE
>         help
>           ELF FDPIC binaries are based on ELF, but allow the individual l=
oad

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

