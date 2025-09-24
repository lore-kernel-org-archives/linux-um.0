Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2228BCAC5B1
	for <linux-um@archiver.kernel.org>; Wed, 24 Sep 2025 16:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+elp/mgEwQHUPO2/veHl6cFeD7QMzkxV3mT27B/vMe0=; b=m3P/gNwCJxDq0e/Eya74XN8Q84
	alrW/I1G3F2C2hHZm7gNdSwYxoGWdyJ2K9g0u+18UYBYEo4FtC4dYNhQCjntlAfLUauxDVk3wb4wL
	2oseV7XViOJAVri8OsmksnlwZCLgs1JBadxP7sxwDTmkmDpL6ppGf7bUzB561tk1DhkMinFmrZlYX
	DI70VrT60Frc/IASOBMZE09PtyUZ/EOrbija9Suwuakm6ctnij+dAbSkc8ngNCyvW83GzzExyLACa
	m/Fgc8KsZNBtj08wvNoISkOXY+YIUvUxeagVhFWVChy53jbeqEzRJ8s/UDOaEC/bv105zBOyIGJ1/
	APEER7rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1SC2-00000001dd1-0M0C;
	Wed, 24 Sep 2025 16:18:10 +0000
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1SBz-00000001dZU-0mXz
	for linux-um@lists.infradead.org;
	Wed, 24 Sep 2025 16:18:08 +0000
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4d41154079aso213201cf.0
        for <linux-um@lists.infradead.org>; Wed, 24 Sep 2025 09:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758730685; x=1759335485; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+elp/mgEwQHUPO2/veHl6cFeD7QMzkxV3mT27B/vMe0=;
        b=gakQqHPZzhqukTiSs1diXISX6JRML3Uep8JDB4dtVrMyHgJ6XQc/fAwHZ603wwMP0G
         LN0b0SMU9MvTm4gPW1OZuiQeK+OC7mC8hkOMJ57sa6I8uy1uOgJO8syErT8NliKjjisr
         jXnDTt1hH8O+wzDytxnGI7gmwu7lnOVTbUH2MolLqvzwVDDRlHm/hD6YqyyHDVMSXOin
         KEWCdc01bcqIcPAE9XbNBV7Agmzwcl9TY+W5+7EFmxsdGxO9K8KFeOLoDbvY6ml3Pz7W
         JgyPeESZBCIu4VExPHM7JCnm9wEH+AYaTUh2unL2VaygGGqpPIw53Ycad+Lt/Zi7T4HQ
         8JTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758730685; x=1759335485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+elp/mgEwQHUPO2/veHl6cFeD7QMzkxV3mT27B/vMe0=;
        b=L6J6+siShA96gy7VRhv5qt8rGaXJqNScBUUwH9kAOD9A0WTK09gfbZMynweVwRCrT0
         L3YQrf+MzhXAHbhVBhiwc3ZWj2eUSpdXjk+OG/4PY5jVAeU3V21j/5GiXxTee02Cx6ev
         KJHDmcuYLYcIwVPfrL0t9/CV7DUsFBvZxAfGQsoh05qQ7ubs61+XQeQozMdGskkiUR2m
         w1i6wQhEI0Yl/vhIBq526SMhGw0LdcA+hrUc8icKTnF8q5RJ8KlPrfGX6WKid/CYOq6W
         oDbBjEhCA55HMObII1fV9Mv3/MSOkuUYda0bp3lwRIe9qcbNT6UjFfQSbb0eqiy7eXO6
         LTUw==
X-Forwarded-Encrypted: i=1; AJvYcCUIQ1hzkK1jp4/bDaPX5E/ad6DvmxlP+IZ0p5YxZbKpa5O5te/HNY4L1FewpgyKHOYvw/qwa2XH+A==@lists.infradead.org
X-Gm-Message-State: AOJu0YxEqvkeu86G7S9UTvpYB0j8zxki3AP9TxB9Y+Rnq0wzDq2GJwHv
	ANB2BWRtdQ1A0e0ImeTHrmsF+UNsypH2hszwQ8t3+oaXxNnUHbAhpUBz7LUKRsXtE8wC+Popz4Z
	QTY03O+kmlXyueLbXH4F/svH9hcjVhMg=
X-Gm-Gg: ASbGncvp84/S2QhjyOz33rgZ5puwobdQPv+PJGWpMZm0QaAS/U7SWUEAZnaMtSmVLLq
	ZgZ0PqBqu1H1g5Ohf/AyUeNv/JO87oaS1s1Xvg1e8KbdhVAs+aWymDHX47dn94329jrnZuMJPx5
	7M/R5+Qr7xpcBeXrgHcIUwmTQlaFhIC+orF5v9xr+L6fElWsfTm7WbxCU1WOlnI3cWxJWagAVzV
	i/A869PEEEL/e2/OUSZxYiXISit9NUwpsqJDhqh
X-Google-Smtp-Source: AGHT+IHrjx0XfB3NQHdqBt66Ox1dwY4oj3I0wMxztSwqqFAAkQnhEkK0QBLdnresO+RuCvDJitimjmBRn2YZHsgZxpk=
X-Received: by 2002:a05:622a:3d2:b0:4d9:ea03:74f8 with SMTP id
 d75a77b69052e-4da473535b8mr6186491cf.16.1758730685377; Wed, 24 Sep 2025
 09:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250913003842.41944-1-safinaskar@gmail.com> <ffbf1a04-047d-4787-ac1e-f5362e1ca600@csgroup.eu>
In-Reply-To: <ffbf1a04-047d-4787-ac1e-f5362e1ca600@csgroup.eu>
From: Alexander Patrakov <patrakov@gmail.com>
Date: Thu, 25 Sep 2025 00:17:39 +0800
X-Gm-Features: AS18NWB-xeGoRDKYPj3kUYXUnKXLhFMFvvc0QyoLpOeKcP1DsD-enKeBhlulfsI
Message-ID: <CAN_LGv3Opj9RW0atfXODy-Epn++5mt_DLEi-ewxR9Me5x46Bkg@mail.gmail.com>
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Askar Safin <safinaskar@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
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
X-CRM114-CacheID: sfid-20250924_091807_237224_C65FCECE 
X-CRM114-Status: GOOD (  20.76  )
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

On Tue, Sep 23, 2025 at 8:22=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 13/09/2025 =C3=A0 02:37, Askar Safin a =C3=A9crit :
> > [Vous ne recevez pas souvent de courriers de safinaskar@gmail.com. D=C3=
=A9couvrez pourquoi ceci est important =C3=A0 https://aka.ms/LearnAboutSend=
erIdentification ]
> >
> > Intro
> > =3D=3D=3D=3D
> > This patchset removes classic initrd (initial RAM disk) support,
> > which was deprecated in 2020.
> > Initramfs still stays, and RAM disk itself (brd) still stays, too.
> > init/do_mounts* and init/*initramfs* are listed in VFS entry in
> > MAINTAINERS, so I think this patchset should go through VFS tree.
> > This patchset touchs every subdirectory in arch/, so I tested it
> > on 8 (!!!) archs in Qemu (see details below).
> > Warning: this patchset renames CONFIG_BLK_DEV_INITRD (!!!) to CONFIG_IN=
ITRAMFS
> > and CONFIG_RD_* to CONFIG_INITRAMFS_DECOMPRESS_* (for example,
> > CONFIG_RD_GZIP to CONFIG_INITRAMFS_DECOMPRESS_GZIP).
> > If you still use initrd, see below for workaround.
>
> Apologise if my question looks stupid, but I'm using QEMU for various
> tests, and the way QEMU is started is something like:
>
> qemu-system-ppc -kernel ./vmlinux -cpu g4 -M mac99 -initrd
> ./qemu/rootfs.cpio.gz
>
> I was therefore expecting (and fearing) it to fail with your series
> applied, but surprisingly it still works.
>
> Therefore is it really initrd you are removing or just some corner case
> ? If it is really initrd, then how does QEMU still work with that
> -initrd parameter ?

The QEMU -initrd parameter is a misnomer. It can be used to pass an
initrd or an initramfs, and the kernel automatically figures out what
it is. What you are passing is an initramfs (a gzipped cpio archive
with all the files), which is a modern and supported use case.

--=20
Alexander Patrakov

