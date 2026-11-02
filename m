Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B8F606A327
	for <linux-um@archiver.kernel.org>; Mon,  2 Nov 2026 18:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LC8C1kVh;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=EJKWsVQc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=; b=LC8C1kVhQiBMwW2NRR/sks2iCH
	lTYobdHc+xRpgmzP8LsScghUHYNYgM6QWSCW2zu/aucZ5JVHEBD+0Vyjfoj0djzBN7p0eATGmmx75
	uLossdjwW9FLIPJA9Ds2YyMgHm1sku5qxNIc8LNYRrzjsPf9yKsZsAk+011W4qj+SiZqRaFAYxFXK
	nFxahP6BzIw+ZMnVTJ57n8iNgSqBNnk9HDDND9AmqplPj4hvrGVVLBNKUaGrT/NixFc8wo28wVNIP
	h8J8ziD2QLFCe/GkO/v3tVzHJBxbsYRHa7kNZs4/cjaAaCWIZ/N967KCEqFxjL0zj6rCx7374PG4I
	Zaif219w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNwQb-0000000HYc5-439E;
	Mon, 02 Nov 2026 18:06:41 +0000
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNwQX-0000000HYat-3Z77
	for linux-um@lists.infradead.org;
	Mon, 02 Nov 2026 18:06:39 +0000
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-3ab28f3e4dcso37264721fa.0
        for <linux-um@lists.infradead.org>; Mon, 02 Nov 2026 10:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793642794; x=1794247594; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
        b=EJKWsVQceK9fDrmWhYB4cfM8nwUCFFC3RQEOtgxsIAEWeZFxvrQysTOpJ+KXrzaeP9
         k4kb/bdBCUbBbmGiNZcTPLNNPbxcFM9niLRbiaxYxvAkZ9G+zGuPatNKXMBKF4/jX9yX
         lIz5EN83VFfHuUXYnTT8m7ZFMZ/IgtdMpcKU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793642794; x=1794247594;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
        b=wJUBLFxoxyVkF4zE5991FR+bGnmgCU/ji4uhsuCoKblATVxu6Cj9FAtVuu44c6RRBy
         jq8Sv+BX9OZOEEefC5edGz32IoyfUjYFqzrNkHAedhHpZSSZR90Eh3zlgUy4KyqtyqKO
         CREbtgMjL0cw3/yIlDaMTDzC4IaOyNIdXXEYMkKV2PYH2bfZHuqn/JOj7jMuUyovatlk
         SPfK+h3OHkm5UTL8XD8Yw+NiXe3FlVWlHWOqBTSgjB0ijj7CxaXvnfMbXQcMjhI7tXDn
         7DeMrJCAWUM4AszyU2KHv1G+xvru8CfEwonB9a5HgylN/ChWdurKdo5Iezk4KTV4os2z
         8ygA==
X-Forwarded-Encrypted: i=1; AKwUvBybWnw7hBYJxeLXz2+ehdwc/c4Sh37TVuUrRQ1LSopQ6RHpyX81s9xUllHjZqwE8aGiIkH8YdCkzg==@lists.infradead.org
X-Gm-Message-State: APuU4Z/RjpTSQdgiJwjxSTw1xaXN6XUaFmlcHOYQZDkSlm/oWdRVpuD4
	ZthJeSrmXDOf9zd03Xs0g3rdRYi50KwUnKR3NFysL67K1tAisPdRBvpQbABvZlPnf936p12tixN
	loY0xr83QpQ==
X-Gm-Gg: AYBFou2q7QEK6dNhb+CKGUDyzJVBYNlfp7/0UK2QW2JGgOVTo14Vgx++VImuD+BmCcf
	/nwhJIFwQ8XXUpCsS4caLo4vemDDhdjbigukVEFzFC1hLeTYt/9vaYoLMjLgZANGr38hvp52JYH
	g5UXljbDVkEEfi7VkQ+vOrOMC16618FS3hsQszqr8VVAkVqcefEw1h1Dv7oVmfuP2fkOYzSt32R
	Ji1gaqBOoBbDeT36bwN4ZBlWGWFmvnwQ4WEo5ISB/PGSPB2jZSX2cEm8fdH5qHxdXM8qJQyK7Wu
	pHdBHzSdEJ5DV9/3YowHRhGO94UxkueWUNv1iwZgKFhxFT1T5z5Q1tgufdShwq2nC8eXw5dA5yw
	msQJBGMIu96/19Zu2UD90bQR6zXqn6wCpjt2cR2B5S9AW0jsxeAJqefBvz3wQlGB3lTuk/UtL9m
	wOz2P03Rlz87hZi5xI9yCbFTZIdMDHyLb/AQ2FwS6XsN8OuktDH9DTgH0baTYXNuStJv1beEQpe
	QV4ytCRawFGoSFWAkSs8FFkkcUqk7LkAV/Lix/V+3feObXgzcbFxO72QEyc2vLcF1RhpxKVISdc
	LrGGG3LCcRL2YPMDZzR/Nv93U04mfLNPEgLK0k7JTlpLS5qvwVjUtOpPct8bgxZmBhMvANg3IxZ
	mrt4nafyLL2tBiT9NEF10u1w=
X-Received: by 2002:a05:651c:1544:b0:3a6:62bb:906e with SMTP id 38308e7fff4ca-3aca58366c1mr32946831fa.20.1793642793727;
        Mon, 02 Nov 2026 10:06:33 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3acd5c25826sm867671fa.11.2026.11.02.10.06.33
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 10:06:33 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5bfbc25a76aso4764938e87.0
        for <linux-um@lists.infradead.org>; Mon, 02 Nov 2026 10:06:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBz7Y4uHKp65UWJBSRG1dRFM++M1wLfecYNGyx6NZRHYbxeoHEYC0FeIv9ghEa5CiufxVP5Q3LEzLw==@lists.infradead.org
X-Received: by 2002:a17:907:d94:b0:c2d:c80e:8366 with SMTP id
 a640c23a62f3a-c4ca7426f6emr874452266b.0.1793642348398; Mon, 02 Nov 2026
 09:59:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org> <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
In-Reply-To: <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Nov 2026 09:58:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
X-Gm-Features: AclHuK_qZTBVsLQIdymgRHScSFenC6XsGggUDmcuOugjrSTbuVkeASUmC_hYPZo
Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
Subject: Re: [PATCH RFC 01/38] PCI/proc: don't truncate the position of config
 space accesses
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
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_100637_956717_F4DA988F 
X-CRM114-Status: GOOD (  10.35  )
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

On Mon, 2 Nov 2026 at 06:22, Christian Brauner <brauner@kernel.org> wrote:
>
> proc_bus_pci_write() truncates the file position to an int. A pwrite()
> at an offset like 0xfffff000 turns it negative [..]

I think this would actually be better with rw_verify_area() just
checking a per-file maxbytes.

We already have that logic for lseek and friends - using that fairly
hacky combination of s_maxbytes and !unsigned_offsets().

We should combine s_maxbytes and unsigned_offsets() at file open time
into f_maxbytes and check that not just at lseek but in
rw_verify_area.

And then things like proc_bus_pci could set it's size limit in one single place.

Hmm?

                   Linus

