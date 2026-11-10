Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8FC606A338
	for <linux-um@archiver.kernel.org>; Tue, 10 Nov 2026 01:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NGviM67G;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=aeXbQxEh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=; b=NGviM67GmrLpxekHzjjbLk4xs9
	VB+bTg0gHED8cPj7CJ/0BUHgee9C/awCv8w9LiaAenk2h7d0i+fwKl6kb/cqWtdHv/XGqKWtg5w1Q
	LE1XHgg9nRzTQ/xNSRDSLlWVN1PNE0BqFut/ml4+zz/8+iI5xAWjU808X+mswRoT3AI2l6BuX0z9P
	LuKNs5F6pFFbg3xOXuc79ZPhw3yVB0edktr1vgirL1zsM4sEWMmHPm80n3ukW4kTkR8UEtr0m5pBp
	OF16hrkmJdTvLfjjXSxyLgnVILTgVAdXn6h3vGKq918rpeUdyQKEUhPI7ZyRKlzmGdlZhy9kdszeR
	oZtVRpFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQaZN-000000024Mx-25Xi;
	Tue, 10 Nov 2026 01:22:41 +0000
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQaZI-000000024HN-1n2M
	for linux-um@lists.infradead.org;
	Tue, 10 Nov 2026 01:22:37 +0000
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-c450ab1483cso245934466b.3
        for <linux-um@lists.infradead.org>; Mon, 09 Nov 2026 17:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794273754; x=1794878554; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
        b=aeXbQxEhLh+JCl6Nmze886ivek3b2tGT2WywGFr/2I65SUzL04MnevvO9yCVWFTwN4
         7KD5diNDVWxCcyYKd1ZLezEImwWjvtnkT/FtUr51K71hqe6Newz7DVo6FMsj6uSbFeKM
         TbgdibjG2uK1g5aJ0YHl+LFEZt+k3DfUxUz1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794273754; x=1794878554;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
        b=tYvXqW4ag+0Nba+2uXx8+4bdN5gklA6nNJqdeJ0tcGap/AqXCWqRmFKLJAwtza9Qbp
         UcwpxhpuKpazs0lfAk/v9rCgQ7bdMQIaXKTcp5LJEm2vBxp1DYv5IHnUnW9PDo7u4d+y
         v2yTSNwO+qbF4gI+04hXjF9IkaSK/KBZl1o5zloo0YS4ClHXsiXm6OXBDocGq7iicqKD
         q2u/Bzdo9EIVDlQ8v6uSKIFQT4a3sz8YkuNPOCim60kL6VeQuVP656TkMbRXhf/1r5Hp
         TVJ5I4pf1jRB47VNJiNlJ9Rx+ZvVbvh38iOCaXUwnjGm963SnshfgykSr4tTI25htk8x
         /ygw==
X-Forwarded-Encrypted: i=1; AL+hErE810yIWK+I6pioFi+GiuaodSFMmihU9DUvEptbgnE6ulRREXiZozTZW20Z7TnlnX7vnjIR7T0Pxg==@lists.infradead.org
X-Gm-Message-State: APuU4Z8+27XKmqMok735gB4krQxFP3D3Fhj5gQb3AjRmIEyhcxiD9KwD
	UxmCaNcP44Rhr9aLHrCgFpENIuntQ8vwTDZXgAfsuYHozoUmejhndR2v8FVozS5jaon5Adcr5fC
	VCTS4+quGQQ==
X-Gm-Gg: AYBFou3SXa1G5wTSFjnY/5m8fAt2Rxvjn5gBTR6JPL1ZK2xRpURoK9icS7xHertMk3O
	t2ef3uQn0fyoMFd9PyIga9JgcyxVJT8jv4Rhtb/Io9DmdNDibKhtMGk5+1SMPsxFS0NIgpYqaNa
	+f+xSaiMy48UGREGCO/X0GxL6xJInzqmBXwlTacWtZokleDhNBWsBdrOB1rkTsTmdnmk3h+kGFt
	HheHdnVh2X/YGL0F3mRB7BUumxp+lH8+HMqRZkSLNUakgYXihBoNIrBwVX+eTsD0aIRJ/KPtVeW
	ZTYonxXomyi2pVQchBY3g5gzLitAKGYxZGdT6b1fpSzIlUKydGx+TbiUy+XRO0SDeKuup3yehvA
	eJaQFmsNiZaEtfnJ7l4RQegJV+Zv7IFLY4RAg62Z27qCFVsGioFXID9urw1pR8TUZrKfWnUaxeW
	R9BQ6CjvEk+iYStgAGtO0wbSt/j3FVchiHN+16njxXaNRJBtG2r7jCX/T3+r8WdkRNi3Rlsy9wZ
	Icx4TRzjzAQHc/tJCXG9NzZn9JJs3hHB3x0sHN/JC3wQT8axDYrPD5Agclrtou36BLnKB7Eu5ha
	8WY4fZIa/+KqH3YYCFhVGHj8xD8G/i9CzRR7R8uGneaL0A3BLwBff4X0L/6xP1tv5+T2QRje+5k
	izuDuvnsbCTxy0xMRkOtLtqw=
X-Received: by 2002:a17:907:849:b0:c4d:31f7:28e6 with SMTP id a640c23a62f3a-c50496a40b4mr83799266b.29.1794273754451;
        Mon, 09 Nov 2026 17:22:34 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a61bc3fsm42061466b.53.2026.11.09.17.22.34
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 17:22:34 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4cdc606b47so217335066b.0
        for <linux-um@lists.infradead.org>; Mon, 09 Nov 2026 17:22:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHA5i06+bGPs8cDac/04TgAv+QyeP9xMx1vltEBGwG1b86auETKAjbwPGcHMj8VFJXlXaPZHjZLMQ==@lists.infradead.org
X-Received: by 2002:a17:907:9451:b0:c41:1750:59a2 with SMTP id
 a640c23a62f3a-c50495dfbd5mr87253466b.12.1794273275844; Mon, 09 Nov 2026
 17:14:35 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
 <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
 <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner> <20261108185953.28054fb3@pumpkin>
 <alpine.DEB.2.21.2611090504170.17804@angie.orcam.me.uk> <20261109214558.0d9d5228@pumpkin>
In-Reply-To: <20261109214558.0d9d5228@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Nov 2026 17:14:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whsA3tKcUCBJDj_vmJ11rVGT9rivgnKjGRgMO21CPmCxg@mail.gmail.com>
X-Gm-Features: AclHuK-x8jcOOQUqd2amGoGEAKER9jIFGaeL4LxxWAd0cGV7dz_RR64PtDogpPU
Message-ID: <CAHk-=whsA3tKcUCBJDj_vmJ11rVGT9rivgnKjGRgMO21CPmCxg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
To: David Laight <david.laight.linux@gmail.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Christian Brauner <brauner@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
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
X-CRM114-CacheID: sfid-20261109_172236_496149_6D19E8CC 
X-CRM114-Status: UNSURE (   9.82  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.8 (-)
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 9 Nov 2026 at 13:46, David Laight <david.laight.linux@gmail.com> wrote:
>
> Just that the cast would have to be:
>         u8 *foo = (u8 *)bar;
> where 'bar' is 'char *', and I don't think you need a cast there when
> char is unsigned.

.. and just to clarify: 'char' is always unsigned in the kernel on all
architectures since commit 3bc753c06dd0 ("kbuild: treat char as always
unsigned") back four years ago...

            Linus

