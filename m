Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544D2606D802
	for <linux-um@archiver.kernel.org>; Thu,  5 Nov 2026 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fwdcU4YE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=SqrTjgENN7Dfs+HehxbKPgACeb32UvvfMAFijNHd6N4=; b=fwdcU4YEH3RdnuOm1u3SNsNjQy
	vEE7oRVoqKY30bBLVO47P+DR9URLBeHGFsKIMWobEgJp48fhwHezDyoOqp5GKKDPzPwriR8xB+1Cc
	tedlMKIf6dlWu1LCoGz4maDHs+ovERyZ+X/RUL5eF2xrYfDY/xBYsPnwa/nNvhadPeuGhicUR5iMH
	tDyKCDc+A72/vnTkL4brlJtfvxYWp5KLc3sdsBVxGx2RXQC8OGaWW8h94ek1Mf7akOpzEQ8iVYC/h
	1RmlDOxRL9uSLCLyN+N/dzBIWH6S+bnnyfZ+VItILXui6eYIF0B/Q2ghegkNG2L442uRMhg6Bb6CY
	mjLJM1zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOu9U-00000008Msb-2XcO;
	Thu, 05 Nov 2026 09:53:00 +0000
Received: from mail-qv1-f53.google.com ([209.85.219.53])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOu9R-00000008MrJ-0EoI
	for linux-um@lists.infradead.org;
	Thu, 05 Nov 2026 09:52:58 +0000
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91c6ce60697so22126666d6.3
        for <linux-um@lists.infradead.org>; Thu, 05 Nov 2026 01:52:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872376; x=1794477176;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SqrTjgENN7Dfs+HehxbKPgACeb32UvvfMAFijNHd6N4=;
        b=s8DdCjpBj6WpJ27Q+/yDZnlZbQR5sGt03aBOmKJwBH1/BUSNVF5RTAPGgvKLZc5K2/
         n9EaiCrZtkgpBe1PqrfY0PqICM1MzJJyDHwdUnZ4Cz4Puenzd4FjI+UfOqv/VNGpnhJa
         l0rO27ZNXjpcEQWOj1U2UWvTAhvkZq9tIpPnJiFk4sZhcVLPZEN8CC4tHRFz6mEx/rHa
         CZ0u8kDq7vMrhrD6904bgJQqs1ugWMdyFHg4wEahbGrjGnVOCFporQQW+XJgUosSodVR
         a+rAfQNEG0YuIkWA+gQK7ynYkV0E54ODfVtgOh/LXUloZ3iad+asKxtNHftOSWV8g0U6
         HOGA==
X-Forwarded-Encrypted: i=1; AKwUvBwzqeyc0QU2ar2x8jSdIP/TnENsXzS71flyaWdJSzfA5fmT3/lK3C+eSFivCJUav0vKiDqdIyUMvQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z+uJKPHC2xsK/dzCX6sLaaVcKy/3eEb5/j/wM6UmZEMHlaFzKbd
	xmqcKeUfiFq4kIqG1R780dQVfKD9T4rtBJzUH0f+WqlvdEO1wGHMkAkkKJU2F55jxfA=
X-Gm-Gg: AYBFou2nGg2ejNz40HKi02gxfBJZ/K7JPowkrk6EZRAkbnJUBE6lpH5wa7HrfBRH5se
	KCQdptRsZD60YwMJ7osJuY/ZNGjUGJ4rHzljUWz/qpFaxZwCO4iTACknmuM0CG2TAmWiv/rKeit
	RaJPzE5jJu2b8+eGvCPGZilgeNHUY29apAQrifPVvmKkmspfZA1pvYUDkbC+uPHmPeXiAxd4gxT
	kwJA2Hi4jrSV4tP4DT1Zanmbaut8cehsTB7k/svMHbD+WilOdvbCp8xAaCQUrI/RWMS6CL+6odL
	O3rx4L6SoJdzv1/l2mfq1QaTMWTy2lKCefrNwIlTYvobBN/cB0TsQukh/G8lCUKslTCjZTtZYd1
	pzFRGYENSIqinf8pIgDyLBVrrjp22iN/xpFGquEBnAnS75wXsmjT4LoROmHWjI8SsRDY0TNmx7S
	gIoAKKnsTw3M434fRkYuGsg9zBvT8sPNLGEq1FCe6xF5BttxQe5B0RtAEknWmEHdnKoX2aVDlv5
	Fmun00cb9zm7985pa69AP2NH9qXpXnwNYLRILCx2PIhFkQyxF2FZu1pvO88XPz2XFtVUR4eOWy+
	uf7P+9uu5H/xkPFJ1cXdiuim975O0mE2bRT+Suy2TY75Hs9RtlKkpNCte0tjUZZH2IGlBkghdAZ
	o/fgTQ9t/Uf5pOIs=
X-Received: by 2002:a05:6214:4804:b0:91c:925c:e859 with SMTP id 6a1803df08f44-91ca4b3321fmr312596276d6.34.1793872375357;
        Thu, 05 Nov 2026 01:52:55 -0800 (PST)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e939fc1d9sm21870636d6.18.2026.11.05.01.52.54
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 01:52:54 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-53c4b82919fso21018821cf.0
        for <linux-um@lists.infradead.org>; Thu, 05 Nov 2026 01:52:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBytI7MRufnPMh5xwBwZSq9iAVhbte46ffKQWWaYNiIECZ34Mxnm+qA8Yk/6B10U9hXwMdrm1jcfKw==@lists.infradead.org
X-Received: by 2002:a05:6102:3ec5:b0:7cc:2bb7:131d with SMTP id
 ada2fe7eead31-7d072baa484mr7324212137.9.1793871885062; Thu, 05 Nov 2026
 01:44:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org> <20261104-work-procfs-bugfixes-v2-10-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-10-021c84d852e0@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:44:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUy1RYKG0g8OWss3AD-jyYx3DXL0K7ABYkFUdxTxZ9VdQ@mail.gmail.com>
X-Gm-Features: AclHuK9D-nB8icBns0zdoQH8fV1cfUPJ6LOey8o_VlUZpDIGqKC4cFf8-j5-HdE
Message-ID: <CAMuHMdUy1RYKG0g8OWss3AD-jyYx3DXL0K7ABYkFUdxTxZ9VdQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 10/51] zorro: size the proc files like what they serve
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net, 
	jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, 
	samba-technical@lists.samba.org, sparclinux@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_015257_221408_01BA3440 
X-CRM114-Status: GOOD (  16.36  )
X-Spam-Score: -1.6 (-)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 4 Nov 2026 at 20:18, Christian Brauner <brauner@kernel.org> wrote:
> The files under /proc/bus/zorro hand out a struct ConfigDev and seek
> within that, but their size says sizeof(struct zorro_dev). Say
> sizeof(struct ConfigDev).
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

