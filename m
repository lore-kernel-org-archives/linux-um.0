Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EA3606A326
	for <linux-um@archiver.kernel.org>; Thu,  5 Nov 2026 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PI+bvnou
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=n+1lmuZTLENNkpqKh8T8PUriZ63OKZ7RGcjsYNzzAGM=; b=PI+bvnoukimTEyP3rQwzMyMUBd
	MKfeCUBzmO51TVaoim6KjmJWkCV8V9gKP+FTQ/0nWi8Z0pRxnLhg7gRzwaqESsnyL5xgAWLbV1P66
	7RG17uHBxjEjtpJ1voPi3p4e/z/QCB60/uCGrkJeXJm2M6tBWeY6k2n75mH/aIWbdIqOgMSR2i99P
	+hdDvKRIvEojeNBY9jNwJ5g/GAQSicd+F2Fj9JstH7Rt40JwwW5VOjl5z0OwIZI4PcdG+/h9H2WY5
	alkExOj0jc3z16a1K+BcH+86F8RSl7RwnyM3DBrQ7e3KskdVlMRFxwuPStVf6bIiUXirayy/7IMQo
	6Tuo6hEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOuIi-00000008O2R-1ZwZ;
	Thu, 05 Nov 2026 10:02:32 +0000
Received: from mail-qk1-f179.google.com ([209.85.222.179])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOuIg-00000008O17-27xo
	for linux-um@lists.infradead.org;
	Thu, 05 Nov 2026 10:02:31 +0000
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93cc1ab5f6cso198515785a.0
        for <linux-um@lists.infradead.org>; Thu, 05 Nov 2026 02:02:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872949; x=1794477749;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n+1lmuZTLENNkpqKh8T8PUriZ63OKZ7RGcjsYNzzAGM=;
        b=GdBdj+1Td4Kok25LEmke/DC+HU+hiKlZmiWGfbWPc9omovPLz5pIVN1DGbtkpbXerE
         7ubeSZir6R68KYUFh5/H4E+u9qJ3Hs3suUC7aQDlf9fAAi3q/v+Z6c5PbG+aSMhGV4TE
         IqIMeEisD4HW1nji24ny7jtylF0F+xrgdZRAjDvz6Whzt5woc60LtD7h5CxyYgVDXrHo
         h6qDoVxWPKiIyzobyDmPCG4P7NdjbBmiW0F4We0ApQniCl63lGujdGqL4+yzO409GX/l
         2vHkWSckOduVFymZjTmBF5LPAROSG9WRzGI6DQ6GVygbw2YzxasTM0Fh0rkUuPgycr3t
         SrMw==
X-Forwarded-Encrypted: i=1; AKwUvBwTKPAcLKMmJkb0FfqI6o3xTUVKUAVd5a/LVnRMhsp9pSxQlN0CFwg62964rF9B+hL9q9XDLDppRQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z/3p1hOXnOoKoQubPQaTU7csrZKUnVH2tyE1/uMFrk4l3HCV0Xd
	ih0w1Et9b0mmFQWHOPxRHH4P74qvKexOnenjoLxWYxFARdpA7Z6LjFIs7zItvkqfBUI=
X-Gm-Gg: AYBFou1QFqASLUn0U6Ji/D5cUsdUUwL5i3E94pDbo+bMcort6A4UTG61hzXh8AFuKo9
	KsbgACE2hPyFyHBH+6er9FE8qZIpLBzn5Q7gRnSnfrctLqrMXlZzhJnYk9sVzlog0e/gSiwf6UE
	5VWJgNhtZ9CvibXWcAhgkAwa1tuBA2ljauNOfusZOS9QFDL1ZkhSeGoCz9BIxBzmwjaUOpzKpSW
	EPT9psLc0tJk8JFaIxJCZySkJvYC0Npr+YTFsqxUIMjoENeeEp/4gtNKgxLe45FAy2NtYrOMila
	zdpv1EE6pS+qbs3BMgUGhVOlXkjE/Bfq7TAPfiQzACiV6scCQGxHUGtjmskZ1o2OaPTYjT8hB/S
	7XU4T+gDL1YgMPWuMiI+/wyz+fWEMA1x+qi4D3lCOxmlilvYLGjP4evFnKGrWmS/LdjceEQzq4u
	40/w4O9pcfEIKEFuh1AzEOdYxWQRB1QzbAiBJh6PJ+AYq6BKs9+ZXqUoQ4NBIw5DcE1dWLVpG68
	DiZhlZSju4Tghy+53Wq57j1zluopt4eJyA3exH5t+KWYpagmy8k8EFnHk3kp+r44ez4O5lVyeRM
	WEtrOa4cv3iIvS4TSltYbvThcFogo9IjAP0NXEz2R1wt7jToy1WZ/XZqtKmYnxPgbA==
X-Received: by 2002:a05:620a:649a:b0:93c:3d7e:6e90 with SMTP id af79cd13be357-94421677211mr3026342185a.32.1793872949290;
        Thu, 05 Nov 2026 02:02:29 -0800 (PST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com. [209.85.219.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d48556c7sm427684885a.30.2026.11.05.02.02.27
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:02:28 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91c6ce60697so22226906d6.3
        for <linux-um@lists.infradead.org>; Thu, 05 Nov 2026 02:02:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBz1aG1J3uFOgYtYRbMYC3M1HhVJAYTOIrFhYT+uB7Mhb3bp62ReuyArT1GThxsM1yoRCVNnhtnL/Q==@lists.infradead.org
X-Received: by 2002:a05:6102:6449:b0:7cb:bc5e:7dad with SMTP id
 ada2fe7eead31-7d072baa450mr7614890137.10.1793872492413; Thu, 05 Nov 2026
 01:54:52 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104-work-procfs-arch-v2-0-2aeb952c9597@kernel.org> <20261104-work-procfs-arch-v2-4-2aeb952c9597@kernel.org>
In-Reply-To: <20261104-work-procfs-arch-v2-4-2aeb952c9597@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:54:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUNBs_NyhFpXonirMXkYptUWsAizMvVpGHUDLzto1LGJg@mail.gmail.com>
X-Gm-Features: AclHuK_RsrcE7hVRjmpZezBV5tMd490Mza2XAQiqUTgUNqAiHAzRP5z7NIbtMh8
Message-ID: <CAMuHMdUNBs_NyhFpXonirMXkYptUWsAizMvVpGHUDLzto1LGJg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 04/23] m68k/bootinfo: let procfs copy out reads
 of /proc/bootinfo
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
X-CRM114-CacheID: sfid-20261105_020230_549913_448C82B1 
X-CRM114-Status: GOOD (  16.51  )
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

On Wed, 4 Nov 2026 at 20:36, Christian Brauner <brauner@kernel.org> wrote:
> Implement ->proc_read_buf() so procfs copies what is read to userspace
> after it unpinned the entry.
>
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

