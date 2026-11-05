Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA22C606A31B
	for <linux-um@archiver.kernel.org>; Thu,  5 Nov 2026 10:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NHctyTMY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=LrgDMUrSYXpYgkAhfsYKg0ebb/uLgOfOMhqzX4yL0j4=; b=NHctyTMY1Kq2DTZ/f0jYl8Van4
	jDGgHVQDrmkHPWyLWmTM4J3oxmr8XrMpphTbV1MdpwrtlyAzFqMyohakVCNZcjw7nXkNcvIIFeSV5
	Lrm5Ium7jcDlIVG9DtBdjwwuLP20Kchj394VpXU7s5gHnBhaaXsnMUq0KXpN5QXgDUQfKYRis9RfJ
	aoIW6qCGMNbC7JSzQY5O9Ma3Dbt95NKtQgNN+Hpz2bVm/3gcc7cG1P0E/t0Ypn3X7iqOvcyMT6hH6
	0N4EjQDqoQjGr+qx7YzK2rbOmhZ0GsuKx69/nQG1SFuVthiREg1vV/KpnVZKGa7L0+EmoKEA+fZ0w
	X86M+e8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOuHf-00000008Nrt-3hv4;
	Thu, 05 Nov 2026 10:01:27 +0000
Received: from mail-qt1-f182.google.com ([209.85.160.182])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOuHd-00000008NqY-3x9z
	for linux-um@lists.infradead.org;
	Thu, 05 Nov 2026 10:01:27 +0000
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5364042eecfso22723081cf.2
        for <linux-um@lists.infradead.org>; Thu, 05 Nov 2026 02:01:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872884; x=1794477684;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LrgDMUrSYXpYgkAhfsYKg0ebb/uLgOfOMhqzX4yL0j4=;
        b=sz1aP7vhG4Cm1WrKm/Csv0pPTojWiqjAPH7My+GaluyCOxdR9SchSO7weDAgiwGw0S
         KBgzKf1ThR+sp3qlDgSOtE04gIZ2Av0duUwXIKVlFtSRR8lF+VDkL0tO4Ib4PDhsoNrz
         xQiO5dsTd9XgHhRRF1kNL1aP/YgXZR9c4wqOaObnTt9HxDMNyg+QBWanVeU/32URVUXk
         25mb2NjFPCVyxEM2cfOjeRA8y61Ay+rnbp+YuS0M9Tow2K7dCPvhNCZvyVKGLO9USLKN
         +KvcPYxEqixi3cmlQhQ77PoJQI9bOrskqtI+IDS/4eXG+WAcN45ugl5kuB4BsxQcdeoP
         8Wuw==
X-Forwarded-Encrypted: i=1; AKwUvBy5IEm0CKUGyt5iUU/H8RZrKFYGeKNjd94eJMaPLVQPVafWSrv66HZJk2myNR9ByQ3PHyVFLXdvXQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z/YHiUVhkZyU969i8umcngExdACfWCOLQbhEDVzUvqzUNOX1iAu
	fdJx+sFyhggB0fIVDS4XxuR+BFStiSIa7Htdk2R36HvAxztLINqfqdv9AxH6bip4/p4=
X-Gm-Gg: AYBFou2u0OlOR7m35IoCMoi81M98/S1cZC3ESRSXMx27js+iZ/19/u2g31xSJB92nx2
	T/muRhZmO8TTsxWmLRbm7CfvzQrdfzKfIZnzjK8r7pjWBAiXo1+9FzxYPinxRQk8rt91DtfFhCd
	n+lQLUZY8pmZfF6Cq2WTlWxSrGb3IxiJNEC4DtWeuTZq8HoIygSVuzVHYB6o9k+02xXcwNFnOuO
	hr7GNQKhlTCRwnMvq9oYVz/gbTlw6issrKUNkbYXCph4BG83328wqJ7T/aNFSAJ9h5IIC73Q1DE
	r1AJR56dmivWKr2P/nl2mEzKeKQqcAr6PoQizDw8/r4pHQPjJVQzy78Dvam0uPtDv5wVpC/rDGx
	CWKQKm1kszN56n/bdUvj48xoUMi9j9cvqfgPid8abr5W/zuwsqHwnaPYE8Ds5FsCtYURbrHyE9M
	dpckY1DgIdpYE+GJi/rh0CXn0mcl/JB4q/23hFG7/eRI65nOgE0pR3sltczXwxfDEROH/uCe/hz
	cbBAFh8/IIAZI97OhhKYccnFqrsD7PQRlmE9297a49GiziBFvmHRXsW9XTCOkb+JMDc6xWqmDLe
	csAWpDW5Afq13ttFXS9lHMr42s1S3HxcR4ud1cLoP4J3oBRCSHu36lsski/oYemnkA/VSQ==
X-Received: by 2002:a05:622a:393:b0:535:bb7a:884b with SMTP id d75a77b69052e-542b62a4c8bmr315069611cf.27.1793872884292;
        Thu, 05 Nov 2026 02:01:24 -0800 (PST)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b0d07599dsm47233491cf.2.2026.11.05.02.01.23
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:01:23 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5365d26ccbdso19497791cf.0
        for <linux-um@lists.infradead.org>; Thu, 05 Nov 2026 02:01:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBy2WJMg8fnugwcm5QwKdHvV5WxxcAqKB0AZemSYVvB7SXv6b8sB7RHiNoC7BHCa2R/O3vKfIF/peQ==@lists.infradead.org
X-Received: by 2002:a05:6102:5108:b0:7cc:56a:58e5 with SMTP id
 ada2fe7eead31-7d072d84a58mr8269567137.37.1793872526219; Thu, 05 Nov 2026
 01:55:26 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org> <20261104-work-procfs-drivers-v2-2-245e54e87116@kernel.org>
In-Reply-To: <20261104-work-procfs-drivers-v2-2-245e54e87116@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:55:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVHxQvKnJyKHrOZhaOg9Rn2hMeRU1JnMFFEEi31FPZaGg@mail.gmail.com>
X-Gm-Features: AclHuK_UsJ1nGicdWEWcMLQAICTi1A7pGF3yhNkxXkXRPqohle17eXAHHNBsR6k
Message-ID: <CAMuHMdVHxQvKnJyKHrOZhaOg9Rn2hMeRU1JnMFFEEi31FPZaGg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 02/26] zorro: let procfs copy out reads
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
X-CRM114-CacheID: sfid-20261105_020126_071615_07BFCB5F 
X-CRM114-Status: GOOD (  16.77  )
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

On Wed, 4 Nov 2026 at 20:43, Christian Brauner <brauner@kernel.org> wrote:
> Implement ->proc_read_buf() so procfs copies what is read from
> /proc/bus/zorro/<slot> to userspace after it unpinned the entry.
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

