Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3905CCD187
	for <linux-um@archiver.kernel.org>; Thu,  9 Oct 2025 11:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mzeWOdj3lBj+Ke0QviDFWI2aF1kcLsskxWN0A79AnHU=; b=cS3Gv2bHitP5Oy8/A+mEndZy+Y
	ke2GEJpmmiHDDekLjcayYaSfaIlaJcjZvqpUpMNtjZWX4qlAoK2tv6Ee9Ln8vxCukQNjsjL8OG8dE
	Zq2bI/rIN5IEjxGZgVZA7+/xILpS6+0u5ZZVYyjjtg2v/VHZu+0ndPtto4C8PdXLoouK8L2xFVeFo
	NkpJjJraMCK2ydOwao6YycqFaUxW20njAov0Wo4WDTWCUab8LtUijL+7gGaHzrd9lFz6CtGJ2Mg/l
	qow6njbfCxyn/Rn1bxlyorbaVyhq1gqg+s1osLDBuf7dB1FQixsv+goAU4d0eB7ZZxuW6wezZuu4J
	vDuXcPAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6ogS-00000005wdQ-0Igc;
	Thu, 09 Oct 2025 11:19:44 +0000
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6ogO-00000005waj-3d2x
	for linux-um@lists.infradead.org;
	Thu, 09 Oct 2025 11:19:42 +0000
Received: by mail-yx1-xb136.google.com with SMTP id 956f58d0204a3-635fde9cd06so849522d50.0
        for <linux-um@lists.infradead.org>; Thu, 09 Oct 2025 04:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760008779; x=1760613579; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzeWOdj3lBj+Ke0QviDFWI2aF1kcLsskxWN0A79AnHU=;
        b=LlMl+VGPFUjNmiyZL4Il+6N5kU7lsur5gQtbN8QvDuQMK+V7fzrQQfoaD5xEjaMJC1
         oRWNhcgaVE6Own2LyrIix2iPL4B1HPMwnUS2Izv8c6n9owxYeh7JfJDB+XW+9Jh8lbnJ
         Ubac8g7epzggu2yx0yM6v+SCTP0NRs0dADSz97JOooRtfEdj2tR4+JUT5DA8LasX7sNv
         Jc3u/ZoWvpBwkMoQBh6EJldxOlntoWQHyEm0N4Rfy3B+X0Aquz1IxjTSwZJritH/EVM8
         u33jkP4R/T8jHLXgROxZ8pTakX32qlPW0g44jKnCOTeCFkNFR65L4/b8FESYfbQ7Pqt/
         BIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760008779; x=1760613579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzeWOdj3lBj+Ke0QviDFWI2aF1kcLsskxWN0A79AnHU=;
        b=a8vCJve/lfGGOr48nZtKe7d0qc5rd5ejy2L2egzYOZKgKyjwQjB2vQzujx0aTAE0b7
         yozzOVRx+zaILXcbpeRpGcKXdp5AUO1JZeqWYzifbxCQfsD3blLuIfsQw7KgiQfOIAHZ
         rnQqQdvBuCDIWNVQu+Ye61A3ONoLJdVSHHfirM/YWGDIjzCu3BqemR6KJY430p7c2sBK
         QVFJOLk5RXhACEpcpQUS9LPYPi4XQXfc4/a2Bf1j3woZfVFCzOAiH5++psEIXgB9MBhP
         Sm4sXiugRkPMym85WPXe2t2XDmoLIV1DEUagp242gplC8FC8hSbYRe1JowAK/tkXrB2y
         pdrQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9pkin0eccZTfu8Oii/zBcvwVfYMRJxHrD5SIoI/YfeN0zIU2rMTCNZc7whe34qNk4146QtlyWTw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzfQtwkdpnmtc/ULWwvrCL6OtoKvJrrEXQlXln68mupBT53Ugee
	G/YFXDiJP7N8u/XNh/kw02cbCOfRq9fQHVcIbI55RPsGu7jPVR2NKHNePaB1gmkvCaUrf6SHpMh
	fHN0pvf5MFkM4FJmY8YluNAtdVXP2VY4=
X-Gm-Gg: ASbGncuebQb/hw7d7TFNmknSZFyLLpOCeMPxD4Mw9phIXq8cJ1cXQNyyx4sfTnFQ7pC
	YqgZ/dBB2fQ2VqqbeuxYq+lfr3hoxD5e1ZW6PBelkPJvW57fcvKgISP9Zjst5qyewlKCRyP4Y/b
	IxdU21an0Nb3yW0FLCdi8jHh+UjuaswqCZqKFFrHJNCccwFG8d1m6bVM0dVuGTbKZ1YQowHoSf2
	AQUb61oRzAm9pwnPpxzb4qD4D3bCq4=
X-Google-Smtp-Source: AGHT+IE5U7JyGi1AmeLjDi25hUOta+sU2hpJbVTN9Ai63ARDyOdLqRjdCN3h5Wr4u+tqZlHZJ+/pg/7Xr5jCWFq4BIc=
X-Received: by 2002:a53:d048:0:10b0:63b:8e80:c017 with SMTP id
 956f58d0204a3-63ccb672a0emr6807745d50.0.1760008779377; Thu, 09 Oct 2025
 04:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250913003842.41944-1-safinaskar@gmail.com> <20250913003842.41944-29-safinaskar@gmail.com>
 <20250913054837.GAaMUFtd4YlaPqL2Ov@fat_crate.local> <20250913055851.GBaMUIGyF8VhpUsOZg@fat_crate.local>
In-Reply-To: <20250913055851.GBaMUIGyF8VhpUsOZg@fat_crate.local>
From: Askar Safin <safinaskar@gmail.com>
Date: Thu, 9 Oct 2025 14:19:03 +0300
X-Gm-Features: AS18NWAGN6ExXhEWeXK-ERFvGpf6JdjWShiWpIPYOnPjMCR9bXVHwIY8E_1WxIc
Message-ID: <CAPnZJGBwFqNAybORpTtRfjtGwMQiBtd+rATD=mh8ZgE3owT_ow@mail.gmail.com>
Subject: Re: [PATCH RESEND 28/62] init: alpha, arc, arm, arm64, csky, m68k,
 microblaze, mips, nios2, openrisc, parisc, powerpc, s390, sh, sparc, um, x86,
 xtensa: rename initrd_{start,end} to virt_external_initramfs_{start,end}
To: Borislav Petkov <bp@alien8.de>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
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
X-CRM114-CacheID: sfid-20251009_041940_944186_5DF90151 
X-CRM114-Status: UNSURE (   7.79  )
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

On Sat, Sep 13, 2025 at 9:00=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrot=
e:
> Ooh, now I see it - you have virtual and physical initramfs address thing=
s. We
> usually call those "va" and "pa". So
>
> initramfs_{va,pa}_{start,end}

Okay, I will call external_initramfs_{va,pa}_{start,end}
(after I will remove initrd, which will happen after a year)

"external" means "bootloader-supplied" as opposed to builtin initramfs.

--=20
Askar Safin

