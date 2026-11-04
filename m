Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448836080782
	for <linux-um@archiver.kernel.org>; Wed,  4 Nov 2026 20:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qGlETWc1;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=dAcD4/Eh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=; b=qGlETWc15eE3uhc4Kpmt7Spww/
	H5ZxAXD/DSaBM135cz9qU9YUbsXGtpQ2nMmQrDUoiDQ/Dij5dmHJJZkeOKXCMyLayu+QnZkijIo9k
	vpNhHlS4SBLuZocxkgMb1M5JKfku+YywFr0ApBGdgokx5x9O3pFT8LeOzXYEsJk+ppvJoHPUxjfYy
	w4w9iyc53uRMPUCJYDwgZQ+rqp/8qrbSyzFuOk/C5c8sD2u/bJbu6TqeeHRwmEQF2NZqjMcgHrRu2
	1m5hQ5vXLXePiS6SB2rW/Y52Am6hLmjtTTE5YzjM0IbwrQuHbIa+PSji3mxb2A2H9P37EXI/TLTmW
	UAnrBCVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOhLB-00000006rgk-1iir;
	Wed, 04 Nov 2026 20:12:13 +0000
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOhL8-00000006rgD-3oFV
	for linux-um@lists.infradead.org;
	Wed, 04 Nov 2026 20:12:12 +0000
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-c423b145922so163100366b.3
        for <linux-um@lists.infradead.org>; Wed, 04 Nov 2026 12:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793823129; x=1794427929; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
        b=dAcD4/EhHZH+hut7C9iXuW4KrPlyxMftfkwsgUvBPYv0x9Pck3iXrY9mxgNNN44O96
         inkf5W9O+ttI5lOzdLy0n4VcgjUyBkMaAGU9klbFIMmMkhv/KN0hmfEFfySahl6F7RL5
         WyN3lZPNtn7In5lM5eOYzpXw8XBxQ4K5Z+Pnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793823129; x=1794427929;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
        b=YjTLajdUBKORQooY6FbvAFxxa4FBbjjaGFaAiTKYdS6aTZiC6WOjeT/bhFTZ5IKI4r
         nEQaBnm8hDv7f7HCFn7OVW4nIZThLSE7XtUcO4OHl+o0WVI2pC3UY0LK2x3shQzt5dhD
         v8xZ45+TSnleS5KV/dwljDxx7hvVfLdv0elHG5m7fFfrlKpZSzq3lMhwrHc/ljIOEIXN
         wVn5qZxGp1mi/7s4vvri3UH4pvUU1bTfwm+x5DRP3w48m3R/1Yh7/GJDLMUpwVWYWxDO
         iVzJ5ks0m8QR2tItuDKsSXoyETHaVb+I37dX0A+hoCSIBAUSCC81ErCsAcounj5xSbGJ
         3sIA==
X-Forwarded-Encrypted: i=1; AKwUvBxymZPWIoPpq6kLhHB8koPXtQxGCyh6ZNER12Kg0SYImxw2eX7qeMnbNswIXFRzzUhr6RAsB+v5CQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z99/5VWSQarcQsParzxHAe4EqL4FViuVrJEZ/CfMPdadTvPo2n8
	f7F5uo6zcFBTeZCpMkOx5og79UvqFGYglCyIwQLu51Wo4QrTXdsLLUe0lpdLtKfvWYoYFI3Ks3t
	Gji5hxXcDJQ==
X-Gm-Gg: AYBFou0Q/a92M9jl2bN05w7cJP/NbwhJE1G/cb5lOe1AF+kqAor/BeEJ72cxJbJk3ON
	8lZXSAt5g+qVz7ZP0F79tRKaRdg8iZQ5BkAMf3rJhHtG25E8VKCSNJVGjvQJsXlkBiFlVVM6yfD
	MK3vDoSFDK0yOVr4oaSbdAl8nfhS5SjpS56oRtRpOHFWKZtuTenRD6MVPptoJBXbfLyGnlbslZF
	0VZEtyWdAzaVzqPe7tpunQb2pWtJ5mneHiGqGZ5eiXHDmT8khS95V2BJI8nsez/0qs7X3F6ZkIt
	y6vE1PvbErsH7NcS6WeNK6Lex0zyh5g23wjYVo58RFg8BAlZ57t6s+2HdngJLrajwrwpvbGFII0
	cDe4LwvnTklDeUZ36hfW7aqgqOodCU1rfYrP4hs/x9zLzzTDaH3bITjiOAZ+dXH5qeXq1AY7HR4
	biZECwhzO23UZ1Xq79gxz9B8fhqrQ3JmZ5avwbxHhqCmwxIB7YAFVSxWmI8pbEmOFxoUCMaZOxH
	7txJPbV2teLKMCVmu6ytn9X+CJ85EFs1lXkFap3Ft1kRzHhiZd/y2NYAKtGOKObNLodPK33fr/5
	mibJumEYBkZkRnEk0MvesMMKGbVUoDssE0frkGXnRNR3tHH7uczE/XI9OlsEaaOCeesA0n1bUWP
	8QA==
X-Received: by 2002:a17:907:7290:b0:c3f:7270:10ab with SMTP id a640c23a62f3a-c4ca7a54f7dmr1536415766b.14.1793823128901;
        Wed, 04 Nov 2026 12:12:08 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e466be0sm104239266b.54.2026.11.04.12.12.08
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 12:12:08 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4550d8ab15so176924866b.2
        for <linux-um@lists.infradead.org>; Wed, 04 Nov 2026 12:12:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwmhDs4nyoB7DNrMJfJd5RFnqlds+RXAP0JsRioC3TTNFB/2/+1pv2RHFrT3QO2rMpUSv1LjLx4zg==@lists.infradead.org
X-Received: by 2002:a17:907:60c8:b0:c49:a4b1:9cb1 with SMTP id
 a640c23a62f3a-c4ca795fa50mr1973235866b.3.1793822725121; Wed, 04 Nov 2026
 12:05:25 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104-work-procfs-v2-0-b45cd5789ac5@brauner> <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
In-Reply-To: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 4 Nov 2026 12:05:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
X-Gm-Features: AclHuK9j_YIgrwhhpWOlnull6heAULBd4dgTqoOhUQQjFm_MgoIgrL1vgPfefvI
Message-ID: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 00/30] proc: convert the fs, kernel and mm
 entries (Part 5/7)
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
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
X-CRM114-CacheID: sfid-20261104_121210_955748_847F2AAD 
X-CRM114-Status: UNSURE (   7.59  )
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

On Wed, 4 Nov 2026 at 11:49, Christian Brauner <brauner@kernel.org> wrote:
>
> Part 5/7 of "proc: move procfs to what kernfs does", on top of part 2

Christian - way too many patches, re-sent much too often, cc'd to way
too many people.

Nobody is going to read these repeated resends, and all you are doing
is clogging up peoples mailboxes.

             Linus

