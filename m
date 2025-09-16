Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1089DCAC597
	for <linux-um@archiver.kernel.org>; Tue, 16 Sep 2025 01:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d4rwn8y0vRJNvu8C079VdIgUQlj+kBjL5HuZ7smgp/E=; b=XkQGBsWat+XTUyv//h/dxk+u0y
	6podhynrJfmxP8Hsmw4CbMCVpTSimZ0bu2u2igBE3zKZbLzdLouotrkSmLkqqEUuRs6eGwtEl4mtK
	zGFggK5pLLEC3J0YjC8hLOMasa8CFQIOkMoplbL6yI64BrfWfuHeyY3BJuNQaXeqi935AT/eprnvj
	2CEEr/B41D5otxIBH7NUO/ekGKuLZKrnaUoKbmIJElF/9fScJyt5jZRPCiXmnT3GwwadWloyABDEG
	ZpaQdtH0Ley4pYtZBSf4NO2MeEIzTDfjUOqLYKdPxroqN6cTZgkb1ev+TL40H/3rt+oQlsnaxTaos
	Opre0daQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyK8O-000000067Dg-0k8H;
	Tue, 16 Sep 2025 01:05:28 +0000
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyK8L-000000067BL-1aAy
	for linux-um@lists.infradead.org;
	Tue, 16 Sep 2025 01:05:26 +0000
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-ea3f9e9f782so2366173276.1
        for <linux-um@lists.infradead.org>; Mon, 15 Sep 2025 18:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757984724; x=1758589524; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4rwn8y0vRJNvu8C079VdIgUQlj+kBjL5HuZ7smgp/E=;
        b=aT2vcyNK+8b9Z6sFaw7lJiZGASnH0agFEdUyn4XBleVj9J8VpDihbfmzkTa7WBCniM
         Fvl6ocq8wrSTgLaGbGHVXSAc0z3nJX42HLZQIE0Sbvbu9+rorF/NG2ZQj+Pz1EO5rAWk
         xV1tMU/Xl46ioqDzTEfvluOm2y52VA2V6g8o3rIYgYqQZD1zPrOAlqAQ+nad7azsbkl9
         3SXTDcwhi/odNYBYfbYIv2EqR3kn/5rfwaYlwLS7iKx9vYndm72Cgjhx0Eo9w6Lhnlxn
         Yj0cmYSkAVEJTuWgo2rGedu4jCjHhoqR6b7RR12fJkeSwjQ2QOJZCVYdHfm+1vla/01M
         L0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757984724; x=1758589524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4rwn8y0vRJNvu8C079VdIgUQlj+kBjL5HuZ7smgp/E=;
        b=LQOGmpQlo3K7mMHsXYzUA8buQCs4iPiMH0IHPERh+RIJLfvZVrupmmACn26/n2s1IH
         hD+GFS6cA7vDn+o8M00lu6n/LMtLkZqh1AOA4FpoCS0wklj0p8Ph63C/ps/LTV+qlpJA
         bWcXjtOVM21qjVHzJp5TeNaAO4PiPpENKprPSnaZjnMPqo/GJzDNBKSHwkAjKoaa5ze0
         ywdTW9llL0+lwsrJVKGSZpoaXy2uV4wYMequCTxWsqIddP+JWfKptUerDRfDGtbBSLV0
         HwaNz+4CPSRSVU2oidC/XdDLUx6520YDH1zrAVJOjxpQMpbxN2Tk+SqIgIfLXHXj/HmI
         C2eA==
X-Forwarded-Encrypted: i=1; AJvYcCWrsCr5LVJd8axp5A36xTpUBj4KCoxTEh2mzkXuxo+P6/ktcJkdnRJ1gTRDI+FI84SwdaWY9kFgKA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy6nY7FDlSubQSBqodYE9AMxK7w1haP+4ICtuDWeKzRTCiO1qiW
	2yoDQ+mI/f9g2zT69a/IzkeEQVWZqYIqwee6LElOywZ+z9wlfwqAom3Yj5CS3O1XVJO6+K+o1Yo
	2hLfCfRo8ikaqJ/dCMlhIIM3jjWEvTfQ=
X-Gm-Gg: ASbGncvA/5STcSRHEFC6rIiaeELf5A/7c+Pk6yJFoCmYkkhIwQLwkTi55wVb4o7eLJg
	wAyslJEa74Q1XrZ1sCq/TY9ZRrLjAN2VNx8XI7adpH7XIddfunU9qNw5IRY4jMkcPn8aVi+lhMd
	6kM3p/48DlrYmu2Bp4/BuyS1l3l+04Eu7zVv4xlRXgiiis6bZEp+RODl05AwDAcp+mGymauoLP8
	OtV7pX3ytNKR4K+zQ==
X-Google-Smtp-Source: AGHT+IFaJEo1gVHkPCEaCD3vWYjtreYFiQ2WOrRU9CIpbMyg97OVJtr/v3uxdpG+fiXE68E0IfjXLuECnr1bsw09sPQ=
X-Received: by 2002:a05:6902:2b02:b0:e98:9926:e5ca with SMTP id
 3f1490d57ef6-ea3d9a6c911mr10729577276.36.1757984723469; Mon, 15 Sep 2025
 18:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250913003842.41944-1-safinaskar@gmail.com> <20250915-modebranche-marken-fc832a25e05d@brauner>
In-Reply-To: <20250915-modebranche-marken-fc832a25e05d@brauner>
From: Askar Safin <safinaskar@gmail.com>
Date: Tue, 16 Sep 2025 04:04:47 +0300
X-Gm-Features: Ac12FXwuxsP2xoupllcCoDiRw8q2uuerrvP566PgC2Qr6qfMP36Zqdrto9P8zEU
Message-ID: <CAPnZJGAjfpHZn_VzU3ry9ZV6OUS0RN2iWos153_oM_PhVbMgVg@mail.gmail.com>
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Rob Landley <rob@landley.net>, Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, 
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
X-CRM114-CacheID: sfid-20250915_180525_414305_F6F962DF 
X-CRM114-Status: GOOD (  10.42  )
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

On Mon, Sep 15, 2025 at 4:34=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> Split it up into multiple patch series. Send a first series that
> focusses only on removing the generic infrastructure keeping it as
> contained as possible. Only do non-generic cleanups that are absolutely
> essential for the removal. Then the cleanups can go in separate series
> later.

Ok, I will do this.
I will send a minimal patchset with arch/ changes kept to absolute minimum
or even absent. Nearly all of the changes will be in init/ and docs.
Hopefully it will pass via the VFS tree.

If it gets to kernel release, I will consider sending more patchsets.


--=20
Askar Safin

