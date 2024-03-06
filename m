Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E754C5475B
	for <linux-um@archiver.kernel.org>; Wed,  6 Mar 2024 16:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D7JdIeS9zNSJ+HV+qdpk2QYV7GDhHiD75PCrvSyuiH4=; b=EBuyt20ZkbHpwBlxWA5JNvdGCL
	TLdqYx2Rg4/TBWWvhESF2jOcCnKtblgXAl/POyvbeTYS8O+8dWFg0nGg6LJIEcl82gkSO5VdS0GHB
	5P1+u186cqaJCkREbLVD0kgzQv14J4kt4PSBHRXpHKo7oVDT+JkYrUYmyGk248mKRaYExwKC0ux//
	501SKDNDFv6MSdoc9O5hgK3/ISdkVefmTCyb6H1oYSUSw1GdgiE2sMTozw50JzNSQedABe2+c+Wfi
	qxb3n5694HZu0130QFPf1rxvKZPku/+ScEJ1ZuyBGsaywqDy7O1mGB2syRGmlfrQsj7xxPQBA6/gi
	COixWkXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhu3t-00000000zcE-194C;
	Wed, 06 Mar 2024 16:24:09 +0000
Received: from mail-ot1-f54.google.com ([209.85.210.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhu3n-00000000zYM-0rwK;
	Wed, 06 Mar 2024 16:24:04 +0000
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e4f8f140c1so760873a34.2;
        Wed, 06 Mar 2024 08:24:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709742241; x=1710347041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7JdIeS9zNSJ+HV+qdpk2QYV7GDhHiD75PCrvSyuiH4=;
        b=fOxqZh9FFDMvcxcCGBXJM6Kd/zMRcSH1dDwuJwALvLrlOC+2CCvAcwBRnf6S+NLY+P
         ZLNfh96lsja0+yz1xTLYpJn9QKoVz2Y6USewoCR3uZMoGROKx8/oEcXIH6+nov/bIodu
         kcZypmFiquX9tzfEMBtpQ1aog6cZcf0U99nPVLFLd7zrP+h6ZjwrY5HZIIHEqt37WfCs
         hwytnjiwXqcXkUMxMSo6ca2uNo0EO4lC9l0JWPwaPVHyT8Qel5KDllJnBAeny8uevskW
         7ixmdob3tUdc8ssIYNdLSfbky1BU+o3DAJoGWdj+CTc+dXHKhIm9KULoB1Sg2urJBfpK
         sFzA==
X-Forwarded-Encrypted: i=1; AJvYcCWZoyeDNdLGdAhI7KIN7DvFx0JtAkSfhKemFabEu0N/SE4L/QCqKiPgvFI2+gQn0XSklG6qL9TdCZNzWymLxQTBNjX8zWiZWEUQCnYNLldDFjAAGlQmYqrpUXQYuowWzdnZNn3yGO7MgaQnOBh71IlPe+AxFv01PT1YrDKpgwflzEPFtkVEmXgkXeDkW9Qm1M9CM0jUt3IvhzTzq8lucRbcPo4VkQ6eYkAUWTunrugbi92Vik1BAEI=
X-Gm-Message-State: AOJu0YzVWuGHTZ8EXbcgsLhqaO3nOgwtagZ2EhiOgjYtc5U2QkVc5JAT
	QDeetcQs8PUx37HfcZ/DPUiCgA3/juG1DuczAjM/y3nxOAPbJCmuas5L2ejhLyI=
X-Google-Smtp-Source: AGHT+IEg7RKdvp17nubURVI5AaHsimjVdIyrmbc/xIhM4frTax7jaj4D3eGc/dMdrYU3uE5ZWDY4ww==
X-Received: by 2002:a05:6830:61b:b0:6e4:b891:c9eb with SMTP id w27-20020a056830061b00b006e4b891c9ebmr6038023oti.30.1709742241019;
        Wed, 06 Mar 2024 08:24:01 -0800 (PST)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id c20-20020a9d6c94000000b006e4fc5cda6dsm409712otr.49.2024.03.06.08.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 08:24:00 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a0b1936400so3239539eaf.2;
        Wed, 06 Mar 2024 08:24:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVIzb+vw6dD+7OhVjiGVsPfWzzIoE4g19PrJwCzuB4qCkQbk8XTLKLA945qsyx/eScHH4rRqH1se5FEvAb2okAZQJ2UD08tFW9vPshVhKPg2g9KYMCt9dcMIdrV0khOdU7YbxMnKJFuGL2guCOnQ4UHb8la1BRzpbpRGcBzJdPF64a8PXtk5h8huLHuPqKqDJxXmuRD8S8uDvEjFedlWzQOoGwIQkud9uTiuGwMun9OGvTmYBi6/ic=
X-Received: by 2002:a25:580b:0:b0:dcf:c7ef:e4e0 with SMTP id
 m11-20020a25580b000000b00dcfc7efe4e0mr11968959ybb.1.1709742220242; Wed, 06
 Mar 2024 08:23:40 -0800 (PST)
MIME-Version: 1.0
References: <20240306141453.3900574-1-arnd@kernel.org> <20240306141453.3900574-4-arnd@kernel.org>
In-Reply-To: <20240306141453.3900574-4-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 6 Mar 2024 17:23:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU5ut09=b+5Qti6CD17XOOmsm+VtfA7TKac7qHNOBC2-A@mail.gmail.com>
Message-ID: <CAMuHMdU5ut09=b+5Qti6CD17XOOmsm+VtfA7TKac7qHNOBC2-A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arch: define CONFIG_PAGE_SIZE_*KB on all architectures
To: Arnd Bergmann <arnd@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Kees Cook <keescook@chromium.org>, 
	Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Michal Simek <monstr@monstr.eu>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Palmer Dabbelt <palmer@dabbelt.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Andreas Larsson <andreas@gaisler.com>, 
	Richard Weinberger <richard@nod.at>, x86@kernel.org, Max Filippov <jcmvbkbc@gmail.com>, 
	Andy Lutomirski <luto@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Kieran Bingham <kbingham@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>, 
	Stafford Horne <shorne@gmail.com>, Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_082403_310609_190B3546 
X-CRM114-Status: GOOD (  18.06  )
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

On Wed, Mar 6, 2024 at 3:15=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Most architectures only support a single hardcoded page size. In order
> to ensure that each one of these sets the corresponding Kconfig symbols,
> change over the PAGE_SHIFT definition to the common one and allow
> only the hardware page size to be selected.
>
> Acked-by: Guo Ren <guoren@kernel.org>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> Acked-by: Stafford Horne <shorne@gmail.com>
> Acked-by: Johannes Berg <johannes@sipsolutions.net>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> No changes from v1

>  arch/m68k/Kconfig                  | 3 +++
>  arch/m68k/Kconfig.cpu              | 2 ++
>  arch/m68k/include/asm/page.h       | 6 +-----

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

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

