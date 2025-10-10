Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4A0CCD18D
	for <linux-um@archiver.kernel.org>; Fri, 10 Oct 2025 04:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QekwWSNZM13jRboBgI+VcoYsXugGuoxwasNpiteDkcg=; b=3hSs0C/qpuNBskYVmLOVJ63qjt
	KkpWTkp0YTJBnyTSjfJBbY38oW0K6LVss66LPAJo5/ZhH98kMCDkinisa0FJW9EFN3+/EQD9F5RJm
	PNjR9zX3c6OS4fdTPpBOGYJKd67kUYABsD2G5RcC5y/DRPImBdcuHa5nyPEXfBX08KP42hLbS8RWv
	q40IWGWfMfeIbTFOpC15lUzng7D9H/Ln90potsfDnB/yVaB9rhY5jMCqgPs1AbgkaDl8aguVBR3pK
	5+MTewRPDPrF1JbwszGJ4lmwiSh/A5VrGK0xCLRDAaQF4e0zvKr2kXFx/q0NTNhMAwm57Hu+PJVEu
	qwRCF/Fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v74Rr-00000007dlA-2A8H;
	Fri, 10 Oct 2025 04:09:43 +0000
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v74Ro-00000007dik-0Oov
	for linux-um@lists.infradead.org;
	Fri, 10 Oct 2025 04:09:42 +0000
Received: by mail-yx1-xb130.google.com with SMTP id 956f58d0204a3-6353ff1a78dso1599551d50.0
        for <linux-um@lists.infradead.org>; Thu, 09 Oct 2025 21:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760069379; x=1760674179; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QekwWSNZM13jRboBgI+VcoYsXugGuoxwasNpiteDkcg=;
        b=PGMEb5C0TDzFP/RAVyzqFdeH5N2/zr9r2MEf6PHAbkm6wok3cB1LyYrx25qG02P1cm
         0CvYRKZkwsV/LTbLWORgPkXGl1nv3k7h7qcUXXbVOqKk8C43ab+wyFcJpfH4Q20qEUi8
         RdQrEU8B2XGEdBo+0qE0U0fPpasNKhslJ4nhVaWTIq7P5whH+jtQg+vKHvQP1GQJ9T/Y
         gk4zbpPGTqbCj2hit5n7gbm3XeTrG5lqu7Jn/F0IHg3SWw41TdmE7OdnOEp/CteoriS+
         af0UZ3ax40ew4TgUC3DQqSTYEzMPBGEcw0sC/25WiO3WYsQmMmvGV/x7SZvMlTZenaIh
         aYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760069379; x=1760674179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QekwWSNZM13jRboBgI+VcoYsXugGuoxwasNpiteDkcg=;
        b=s5Gv+7LVUVPKg7jwZu+Jq6mJzOsjaaUTOd0f10TwPPCb03oyZUh65cVBbtHOmFYw0F
         /R9bxmgvYev3uPZwecBLo5QaSKWwKp6WrWPwvi/cd28i0u+MLmC0tmzz10erla/bm0Vs
         t/N2ZFN6BhDmIwRkm7YmACob9lFBA1sknfOLUPWcu3mf4rTQtJjX2QScco0Mqbp6iJNP
         ZMHfzm95zgZe9JUUsK6NuRUxVGO4GkeFtfU3n5C4KCV3Gh4TPmDviZFJh4s4r+Swnsvg
         bdhgy0FXPCzlJiEMh99hMjxGef8JXK7Evc3kZ+dXJFOjR1xrqckWfPry6A9q/9klU69w
         qqWA==
X-Forwarded-Encrypted: i=1; AJvYcCVoe9ehHm5D1mFOteQS+2KyN7JtD4jQyXhmuhNhiM61y5Xdmx7yrDG1TjL7jnrF2jPldCtbQHV9fQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw+myQLQhWCYppW9yclWmNBSMqp57M/AF+IlKRg6is45kchvkFV
	wG1Fw+kXrHGCIv5aZHC00keUxhTl/PjO19zwbbLI7yblu8FgsvJgVU6w4uauD430eCblZNTErok
	9L2KQ5hLpoGGPQxoxcf70U4Agc/CDWqgklyTwNBI=
X-Gm-Gg: ASbGncuxiLo434VqEVG5C86KdOjFcJilCLrrkBKbJltVXS0wDVvSWAuxanDkXylv7nG
	QDO8+XMca2tQgMMNb5ce13OnBiEEuivd3ehQKtSR7OkDhD14Fx8C2vkN+wdOItZjqTT32Dt/Y61
	wdB2GVdGGSNtJ8CK1D62FQtPrntUfCvl6DlGuxijB/PACUN9ZiEPcZhPRsvIHKbTymM5i0jpG5H
	vGhYBi5YwWyiLtuGaUi3bGyzwKoy0q0TsBb
X-Google-Smtp-Source: AGHT+IEKzDZJ3mg1FFWOqowFJqWLj/+dmJPdM199pmmtVcavFH/YLuoH0hEdsvn7dHSOiTNw/3Aomiv0DcOjJivXzrY=
X-Received: by 2002:a53:e946:0:b0:636:17d6:a30 with SMTP id
 956f58d0204a3-63ccb82410bmr7618496d50.15.1760069378763; Thu, 09 Oct 2025
 21:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250913003842.41944-1-safinaskar@gmail.com> <A08066E1-A57E-4980-B15A-8FB00AC747CC@jrtc27.com>
In-Reply-To: <A08066E1-A57E-4980-B15A-8FB00AC747CC@jrtc27.com>
From: Askar Safin <safinaskar@gmail.com>
Date: Fri, 10 Oct 2025 07:09:02 +0300
X-Gm-Features: AS18NWDxe32nrD4BfQQFhIe3tEEfxrwgJsYQo_BWhSUPsy5CceSv7QOcZ20roI0
Message-ID: <CAPnZJGAKmgySY_RK0kmGTgwUh9hw4FSrVR+LoJCbD_RmJZe6RA@mail.gmail.com>
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
To: Jessica Clarke <jrtc27@jrtc27.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Eric Curtin <ecurtin@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Rob Landley <rob@landley.net>, 
	Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org, 
	Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org, initramfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, 
	"Theodore Y . Ts'o" <tytso@mit.edu>, linux-acpi@vger.kernel.org, Michal Simek <monstr@monstr.eu>, 
	devicetree@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251009_210940_169239_0F023DBB 
X-CRM114-Status: UNSURE (   8.27  )
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

On Tue, Sep 16, 2025 at 8:08=E2=80=AFPM Jessica Clarke <jrtc27@jrtc27.com> =
wrote:
> I strongly suggest picking different names given __builtin_foo is the
> naming scheme used for GNU C builtins/intrinsics. I leave you and
> others to bikeshed that one.

Thank you! I will fix this.

--=20
Askar Safin

