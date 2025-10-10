Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E5ECCD184
	for <linux-um@archiver.kernel.org>; Fri, 10 Oct 2025 02:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SUvjTYrAKggs3w1tKlxCJydt04WX0hyij5ZVnNtO2rY=; b=f4G3rxzDSpZRIzh+3WvGk6zZaq
	zdbLSIl0185iTP3zKIg7EKUMdlhFKSJDS2y+I6mATd1xSlnFGgOsQx2M+8IMoY+zxwI3JjQPObk4T
	/iPd6svwDlPvQ0Qxx5xMr05oRp84XjXBysQ5TTiR2W6RPLYx8ALE0qBcp74EOOuEQzNzODkTk6rAV
	jEu/wAx3Wg/PAK4sXl4EqQwEtqvEf3U9cjWwLJR9jsESmmaL08Rvv/2PTpzi5gtOdO0GyCzcctqcp
	iK/8GrPEhfRww6kM6W5VzpLdFfrC1qtrtaWRD3h048ZbXRphO6ZylOEDOcfzpJwSKUzQRB+33XHp3
	Vxn3Zemw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v73BV-00000007WXx-2g32;
	Fri, 10 Oct 2025 02:48:45 +0000
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v73BT-00000007WWn-39Ki
	for linux-um@lists.infradead.org;
	Fri, 10 Oct 2025 02:48:44 +0000
Received: by mail-yx1-xb12b.google.com with SMTP id 956f58d0204a3-633be3be1e6so2501656d50.1
        for <linux-um@lists.infradead.org>; Thu, 09 Oct 2025 19:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760064523; x=1760669323; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUvjTYrAKggs3w1tKlxCJydt04WX0hyij5ZVnNtO2rY=;
        b=nn70f5QF3gnIFo96OLfM9AXsi306gRPjkR5MQ1WgRwMxQhlGQ4uTK0OMQgXQ5NuF1T
         TEKTfv56Ew9qDwVKro9r4NzdlRy4umYWPKZb6iUpmajuxe3CfDE5xqPxL0PkBbDroIOh
         i1gucFxOywYyh65NprHvcEXRXUqZjy9c10CjXMgYm4wLMOND7Hy9xB4fmke6C253Qbxv
         DORAI+SzQ4kT2yBLhUKff8wA+AvB4xaVfiWb9Tz3EA1Cn0R8ov4Cfd6f2GHEYiu9X7zQ
         +ocsJ7vcJQcXW82XrbnEHuWF5jU3tgQgH5MfUMqeb//eWalvzdN4eaCmkJzfOtHPEXdl
         QeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760064523; x=1760669323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUvjTYrAKggs3w1tKlxCJydt04WX0hyij5ZVnNtO2rY=;
        b=dT4Lrh6YcN0X2nXISnDgOP6bnaHMKV7AfJLL5M0tfVIu7DjB5bPOVI1IaklQoB9Ebb
         9ER2aBhiGrNmXDZEW2OfE/MNqCFybw2cxuQY9eSV+f5unXmahTo0aJwcjRc/aFaRskLy
         Wrjry4SiwY7DnAAdUW7jFsju11xh8fHsjSoh+dSnwo3Pef4AhAg9NjNgeiV/UadFMTdr
         8aZs9C1CMGxQJXJESm4m6g6HeAfuA+oKzfUHfzfd+Wn02UdER7MMN+f8ZE8hvJPJwtG3
         dStwoNcb6sPKKLFBg/Wf6CJHtnOr7S5+z0MXvcytadnrHwMNbeEDo+6aJZKKatgoiyJA
         fXuA==
X-Forwarded-Encrypted: i=1; AJvYcCVPFTU4XC4fVDblAOr18qcHefL2pXgsHBW0g+ainD4tGZ+qFgwnErpvmQBUOfh+K9Lo7XIoN0hz0w==@lists.infradead.org
X-Gm-Message-State: AOJu0YynCDhTpjaYmNbjcvVoOonLeqfXcUqBwT2gSpLJ6gmQ7QIC4fjD
	rhHJVHuqy/7Bfm3VeUg6hV2C0rHUOdZXlR+AuDfNQTVL9SZaledHgUC+mc51DSkuLh1jMjmOyqq
	HDQHJCa1Aw+PhTLQA3G1q+1+ATyI1A3k=
X-Gm-Gg: ASbGncsZ4JQpW2SudmR1g9pQNRpOvQBBqy3/UICZW/4E83DsvwDoWlulNQQUwBFHWe4
	flUr3Rpjpm/xsUPYljAEqriEnRA+9Bcz25l/fMRlXkefqVYpqWq5ckIOqchBNcs/KmtRg2OK2UO
	PjmGq3bjGceB+IZRV7zyJ1IuFlgbJa0bc/07NW9eMiBgWsnXOzJCs9su0nLRhD9H597kwWJ1vv9
	FRGYytGAxwVSSpauW0cjl+OELaIa2tGViHAy+lpbQ==
X-Google-Smtp-Source: AGHT+IE/ruZR0Nl+gZjd7KSfaZ+4Yt5azf8Eoz6teA2EZ5XcCIQ6BBXF8AxOCZshaSTrV+l7WDzDAJYCcqNIJ+IMELc=
X-Received: by 2002:a53:cd0e:0:b0:635:4ed0:571e with SMTP id
 956f58d0204a3-63ccc4fd4b5mr7697871d50.22.1760064522649; Thu, 09 Oct 2025
 19:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250913003842.41944-1-safinaskar@gmail.com> <20250913003842.41944-22-safinaskar@gmail.com>
 <a079375f-38c2-4f38-b2be-57737084fde8@kernel.org>
In-Reply-To: <a079375f-38c2-4f38-b2be-57737084fde8@kernel.org>
From: Askar Safin <safinaskar@gmail.com>
Date: Fri, 10 Oct 2025 05:48:06 +0300
X-Gm-Features: AS18NWC-iakvkxLfUlO1LRxakg0fg4KV7Trw_hsIF2wxGpnmpWZvHTCQ7Z3GaoE
Message-ID: <CAPnZJGDK08eDWaMTmvVQwkAAThUvgB0XgAapqqV4_ZmWeay-iw@mail.gmail.com>
Subject: Re: [PATCH RESEND 21/62] init: remove all mentions of root=/dev/ram*
To: Krzysztof Kozlowski <krzk@kernel.org>
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
X-CRM114-CacheID: sfid-20251009_194843_800013_D26AE033 
X-CRM114-Status: UNSURE (   8.38  )
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

On Sun, Sep 14, 2025 at 1:06=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
> Please wrap commit message according to Linux coding style / submission
I will do this for v2

> To me your patchset is way too big bomb, too difficult to review. You
v2 will be small.

--
Askar Safin

