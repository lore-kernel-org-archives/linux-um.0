Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2BFCAC59F
	for <linux-um@archiver.kernel.org>; Wed, 17 Sep 2025 18:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Pv4dFUExNQfPloEDat7jfEF9BkjeLOy7zrinjdnc80=; b=Xl+1BD0Z8cjkpTCP+hSFEOBIbE
	mBawhfcuLsziSAsQ8y1OwxMEkLxWgRyQyxGp7AMJiIyMqXguMS3yRG2liL2xQdwJqUzOSlG9DEXFP
	czr1rvsW6S8r7oROnr2bxg+xdU8dG97+GqlJfMGc2zYh7Vvi97/xsmY/f2tNgBMoBesYjqp0EH6b6
	6S9lIcNIaZ6upoqCX6pXsQXZ3a1yZJjzGLQpi10yH/4LsYE02Ep9werSlj1zMbPP14etbDW/OA+bl
	TdLjslfZUaB7RSULJ2enFlZkoysgRdAbEUEGMKu1F9widk1yvDscBg7nPm7+7WIJTPZ36pGajNjpa
	R+aK+97A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uywSZ-0000000DmKh-0CZB;
	Wed, 17 Sep 2025 18:00:51 +0000
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uywSV-0000000DmGz-2N2R
	for linux-um@lists.infradead.org;
	Wed, 17 Sep 2025 18:00:49 +0000
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5720df4acc5so83170e87.3
        for <linux-um@lists.infradead.org>; Wed, 17 Sep 2025 11:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1758132044; x=1758736844; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Pv4dFUExNQfPloEDat7jfEF9BkjeLOy7zrinjdnc80=;
        b=Agaxb47fWWscp5fHcKjWx1BUlEcMARV6BL8Hiey9V7JOeiCJOnHvuGhhwvjAx23Lih
         p9oEOCyrZgbOn3ETKICp1ccv/Z+q0M0YAkkmFn/FszIe0ScFA+tZq4/EuXv/UZDR2QTY
         fha+oGwCTgiEYDZ/1yyO62mz0YzbauhvVSxTC9yqV6DbYJ9xboXziVT+2tnOA0pb5Xew
         Lz5nupiiGYTL0eKkz3fBQBgbtVKSyf6i1Q4s+v5nUkNhnIyqUa9x7R0eKTTitjWkwqlx
         DI0rQW4KXV/AQVDG31rJZvQsMQ/1bcNuKI2p7SWv/hZ28tMlJt87EpK5YCK1otPxQJya
         ohYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758132044; x=1758736844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Pv4dFUExNQfPloEDat7jfEF9BkjeLOy7zrinjdnc80=;
        b=BSNiG5G/2RNnsLnqv239nP3MseZPRR6cpD91VIwtGoJUS3DFlYAqWWgQgYK8hw9Q9B
         fFsFcSVZ2wC7HJm5rDKJCIOsVO5aeOjZOMJ/BR9/wL2XkwLFi44nD//OwNsKi2X3q3iN
         lyV+k0JirX3vGtEintyeq5Zw3Msj1Gn2j3m7ubzCP28wnj0VBZVbCHljkbUPxJmwHMi8
         jcCsYn9BA/9iLA31LBqyFmOzSjejoSip+AB3k9fUeuGOd1zAUAryHZz3VQznE19ZYyAt
         mqRuHTbAE+lB4RChUWp+Zt0xi4G+/hrX29vpDyDT6GCF+sbcDdJ2NlBNWf5z15FsRjnO
         /1nw==
X-Forwarded-Encrypted: i=1; AJvYcCXslcPG82QPEn+zoAAfuWmRkIdJNi5bpefhJtjGiCQbo6f6WcdbbQ3FoXPNg4EA8hDos39UMRIXtw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzGJkzGRYmNRdw4ej2OcKCPo5GnyvzCwEVf4+szemqm1A3IwV59
	bdmVek47RaspdDvS8G+200XnF6KHWG4HowRVWs2fsK4JD5ny49RGFrHKzafiWLNInR9gy5VFnwt
	No7NPE5J4H0T+iywDaqDBUDACdZ85wySiQ/tndYeC
X-Gm-Gg: ASbGncuj+1h8kLt/5fmcVO1cgCQId1s4f8NK5hxQh+YxttCqxPTYYuE+Dc+ywY1o+aq
	jPynL+Wwqrp87QUeOW3R5L+1dkgchrEyxr2UF9WCPxfAVSKm7bR+RDSHC4n5YzGBCM7SiquoTt6
	UkoUPkMoghRKsEAW0fGr+o8q52GUu7FuaN6hI7em6co3DlpRZzi6aI1QR8cUfkE8mrY1gLsCclv
	6rmIA==
X-Google-Smtp-Source: AGHT+IGI+xF2OSgRbI6+fabXiqu9Xwuf5bxWYwnja/rNGOUuSmNzhH42MNUAKuR34Ox7ov8nmiujA9clDhMS84oRbmU=
X-Received: by 2002:ac2:4e09:0:b0:576:d217:3f2f with SMTP id
 2adb3069b0e04-57796b5e819mr1028160e87.3.1758132043747; Wed, 17 Sep 2025
 11:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250912223937.3735076-1-safinaskar@zohomail.com> <0342fbda-9901-4293-afa7-ba6085eb1688@landley.net>
In-Reply-To: <0342fbda-9901-4293-afa7-ba6085eb1688@landley.net>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 17 Sep 2025 11:00:32 -0700
X-Gm-Features: AS18NWAGwakGZ9zjxjq7MnfN8O7ZgOJb6fmKIJ0JIML7P3j0NnlDZ27eNb5S7Es
Message-ID: <CALCETrXHxOkHoS+0zhvc4cfpZqJ0wpfQUDnXW-A-qyQkqur-DQ@mail.gmail.com>
Subject: Re: [PATCH 00/62] initrd: remove classic initrd support
To: Rob Landley <rob@landley.net>
Cc: Askar Safin <safinaskar@zohomail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Eric Curtin <ecurtin@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, 
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
X-CRM114-CacheID: sfid-20250917_110047_616790_D4C26D90 
X-CRM114-Status: GOOD (  15.20  )
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

On Mon, Sep 15, 2025 at 10:09=E2=80=AFAM Rob Landley <rob@landley.net> wrot=
e:

> While you're at it, could you fix static/builtin initramfs so PID 1 has
> a valid stdin/stdout/stderr?
>
> A static initramfs won't create /dev/console if the embedded initramfs
> image doesn't contain it, which a non-root build can't mknod, so the
> kernel plumbing won't see it dev in the directory we point it at unless
> we build with root access.

I have no current insight as to whether there's a kernel issue here,
but why are you trying to put actual device nodes in an actual
filesystem as part of a build process?  It's extremely straightforward
to emit devices nodes in cpio format, and IMO it's far *more*
straightforward to do that than to make a whole directory, try to get
all the modes right, and cpio it up.

I wrote an absolutely trivial tool for this several years ago:

https://github.com/amluto/virtme/blob/master/virtme/cpiowriter.py

it would be barely more complicated to strip the trailer off an cpio
file from some other source, add some device nodes, and stick the
trailer back on.  But it's also really, really, really easy to emit an
entire, functioning cpio-formatted initramfs from plain user code with
no filesystem manipulation at all.  This also makes that portion of
the build reproducible, which is worth quite a bit IMO.

--Andy

