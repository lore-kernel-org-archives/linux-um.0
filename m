Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF47BCCD183
	for <linux-um@archiver.kernel.org>; Fri, 10 Oct 2025 03:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pa2OhCNI6n3Mf2P8BAMZLHp7akXwtALOTxVawJZtfK8=; b=PYIWRng44QfJMRRdR6i3AvNwPk
	lOObcZ0qSssHM/pBw9pVVu8J5BL9isAy7gVD0lJT3NkgosW+5VQGibJcG+GQbjRRtm8SsgcQ9dWL9
	vvtxnDYrtRUjFrIBhqgzkD/cgiTUkwD51q1QXuuIerznPK32ODRlgf9tzm4hQnYxFjhtPKCzBlwp6
	Ts3pxk4xR90vrYRZSC3a6BZu16I5XbBZGjXj4irSNp6DhO6+DbEbUDcDdQU6LBjsGVt3DZqRhoILd
	9Tx0ryOL38gze0RJLvs6kq19Nx0HjjTeX3UwkHKFOxQ8nWjqeZUFScgqD/3HLQNFuscYjXFDdSb4Y
	T0T67how==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v73gf-00000007YaQ-166K;
	Fri, 10 Oct 2025 03:20:57 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v73gd-00000007YZK-0Fhe
	for linux-um@bombadil.infradead.org;
	Fri, 10 Oct 2025 03:20:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Pa2OhCNI6n3Mf2P8BAMZLHp7akXwtALOTxVawJZtfK8=; b=qjL9Tr/3DJloj+oagiAlwhGe61
	8tXnjBSHl9I4QxRyo6YEYJH2m/7UzpUQwz+NvFcyrSi80GhtdM2wpnQTo/IagAQrZwPS939bbK3n/
	89LC32gWxsc5e8J5TdnGCQ54KY4MN6iU+hFH1kXQKc/31O9xvVIO24+DkbtuOkHYwAI0cphzLuvew
	ueEqVaIGe82YAsv78gt/EfWacTqUk0Ns6wWdeOKlh08WgxKba+pSJrAWTlK04W0gHcCfxl33qBX9g
	5APprFFY2AbkwjvZdhqFJP0HUq8dD4mevoifht8/jhHjsjmdvi7DxcXz/he/XhN2134akPw+ar/nx
	hklK04cg==;
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v73e8-00000001sXD-3D8s
	for linux-um@lists.infradead.org;
	Fri, 10 Oct 2025 03:19:20 +0000
Received: by mail-yx1-xb129.google.com with SMTP id 956f58d0204a3-635355713d9so1592067d50.3
        for <linux-um@lists.infradead.org>; Thu, 09 Oct 2025 20:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760066297; x=1760671097; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pa2OhCNI6n3Mf2P8BAMZLHp7akXwtALOTxVawJZtfK8=;
        b=Spr5/3J3VbF8CacjJAo/CAgkR43pCUXEWCCMzsbqrXJL+oekLCyIETpLuPxGhf2L5F
         j/vV/5yzwQSLfevSsD2YujPt1Vf6j1sZ6iidxx0aNYetML7HeYGwD2US0ZhFxmjgzQtJ
         ZqsuTjt7l0GBRY6SuxH6TZ/h+bMjX8Y5z/qavypqSNQ/FKz2KzAsujiLKiFq8ULAAiR3
         n2Y38WUQ8KI+FL7n0SsYg5UiSMX3rVSM1XvBVvd8Luz0ceCwlYisk/EY6omGGJ/LGKwY
         /5LAPuDw7LaK9d9oXFlvuVrwvcjuZ5MM83oWqX4bpW4xVtaiP6FzNq5xWyPxsrOmTFyY
         3mHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760066297; x=1760671097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pa2OhCNI6n3Mf2P8BAMZLHp7akXwtALOTxVawJZtfK8=;
        b=vIvD+PkBIPulBzgWTKv/5tco2QRnowHPCzLZSQoO8pArFdQW3DNhsv6vzJX/1RaC+p
         kbGFNzZsfJRBVncCFIx4GleEDPLiKlgdlWzm518NEwQtmHPqTR+ga8MDJ7Nb75kZOH4+
         MzP9UkWMrGFc2wMoq3ZBNNhrKLFaRrmyzYPQxFZVy1RtBeSVv2ZMhcK6Cv43ikbrD7kD
         SGSIx0uAXmmz5mTKZTJlWZHBJUpDv7oNA1SLmEU6CTVKMdYXgNTWPTz366zv1iLTkRHB
         /Ud1NNBNa6p7E26hi4zFhGM32wMiLXSHwFA2SDgSHFayofAqIDCbkDDFUiI3qCWV1qmM
         r6qA==
X-Forwarded-Encrypted: i=1; AJvYcCWou5W6KoJFsz2RBtCOmNuFHUtO60opB9SYAxIu6iqVx3krgScjLIPWN4rhn8JeKxEZCLecyarqgA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxRiJmR/xnmvJLeAmrCsZ8Dtm3yQNmEbQl7UhqAnU33rwweLcOc
	h5uH8BSN2Cv6bWHb1wAxyTpk9uiIMwbRSks15Siqvc2aovnEmTTNB+Xn9wk9qKlIMpdzEP3pGLc
	rvT+xAkCLDMzvNbDyRhpoj+dgyIBsNxQ=
X-Gm-Gg: ASbGncspOLIxf6TCzIHyPPwTTxspc7odPCrv4KPrIYxP9c+HY8H35YA8e2HSOIV0ckT
	9iwuhv3kAZhhruBYlH3x5mv7qWyJcUnE/B/Z1utjASPRdaSzIn9PTrWEqx8nyQ9TqAXi+SlNqkd
	LKSOrvbAHcAA8cmBd7vGvQxVOlcBPDsh5dLfJ7iROz/bGlgh0qyEg9MUhpvWc0cPm9jY9oBKZ2G
	sjrXfNHmzhlqpmhDH70U/05oQ==
X-Google-Smtp-Source: AGHT+IFTQdXvlZxDoBIwCyChBgf2ijvKjPOXu3xyloDy3VewP6H31eXx2tdJ5Y2sZs04pWqa6kN09Zh4TAMeP3pYKTk=
X-Received: by 2002:a05:690e:1587:10b0:63c:e90c:a6d8 with SMTP id
 956f58d0204a3-63ce90cac96mr2654086d50.44.1760066297220; Thu, 09 Oct 2025
 20:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250913003842.41944-1-safinaskar@gmail.com> <20250913003842.41944-3-safinaskar@gmail.com>
 <053f39a9-06dc-4fbd-ad1b-325f9d3f3f66@csgroup.eu>
In-Reply-To: <053f39a9-06dc-4fbd-ad1b-325f9d3f3f66@csgroup.eu>
From: Askar Safin <safinaskar@gmail.com>
Date: Fri, 10 Oct 2025 06:17:41 +0300
X-Gm-Features: AS18NWCm5nh3vfq5EIpD-J_OKHQvi_8uVbgLjcXTz6TnQl9pdn9vqNDRLNkppRk
Message-ID: <CAPnZJGC9avy1s=xFS5Tg6obS+RB3zw4yWsUBw9g=Vt09S6j88w@mail.gmail.com>
Subject: Re: [PATCH RESEND 02/62] init: remove deprecated "prompt_ramdisk"
 command line parameter, which does nothing
To: Christophe Leroy <christophe.leroy@csgroup.eu>
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
X-CRM114-CacheID: sfid-20251010_041915_795685_0AD74F9C 
X-CRM114-Status: UNSURE (   9.34  )
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

On Mon, Sep 15, 2025 at 2:16=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Squash patch 1 and patch 2 together and say this is cleanup of two
> options deprecated by commit c8376994c86c ("initrd: remove support for
> multiple floppies") with the documentation by commit 6b99e6e6aa62
> ("Documentation/admin-guide: blockdev/ramdisk: remove use of "rdev"")

Will do in v2.

--=20
Askar Safin

