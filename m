Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9256DCAC5BB
	for <linux-um@archiver.kernel.org>; Fri, 10 Oct 2025 04:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j7qS0AM3lX7OGhXSFEYS6mkC3EKNzPxshbg7hLZcah0=; b=soSivPw4yNEi1fTj+o9oqDon8q
	GSxU7NweGgzF2ncu+M6df6sGfu0F5MZ6GC6F6DMRP2f9UO7euocTuK/V89MY3AU4byzdZgc87Aggg
	wsKBtGoTKijTwRIss5YhG8jq3N8QC0MdQDbCGRR0OMgU9Cdp0dYb8HL/svwzOb+c367CZPt3bUe7g
	XyC1ZpOyy4Yfq6tqLMDTOYFgW3cq7pM+DR7geNd9lncjuGNi5gNGlCu5Y/8cmo6FFfvx+uijrBS3H
	9cGVFHLrf32R7pDyZh5Yk8pf+pp4M5hJdcbKpTd9SltoaRKLXoVxWJn2sGYajgkZf9a3Y4HWUSUDz
	AkyxcxiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v75Cc-00000007gKc-0Pfe;
	Fri, 10 Oct 2025 04:58:02 +0000
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v75CY-00000007gIN-3fP5
	for linux-um@lists.infradead.org;
	Fri, 10 Oct 2025 04:58:01 +0000
Received: by mail-yx1-xb12d.google.com with SMTP id 956f58d0204a3-63bc1aeb427so1693683d50.3
        for <linux-um@lists.infradead.org>; Thu, 09 Oct 2025 21:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760072278; x=1760677078; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7qS0AM3lX7OGhXSFEYS6mkC3EKNzPxshbg7hLZcah0=;
        b=byZ6t6wrDWSM3IddaYudPoR6XYlS7rynO3IjgiQPfI2Ml35UyMwNN53dYO102kEBt9
         o6/WD7QMEip9m8poYQsQL/UPW3lnIaf5cfUJa4ET61KFoYrOKqPwiffDvhnzCkSXcLss
         iq+5EM1cXwqvyIsuzbKxPyj6QLqX00yE0YGBqDzAtuWc9Rz10N3BKLQwlxH+U4/Y7OqF
         jOK0+z7HS5oIKUQ+jyFw1NW6eQLbhWBbQ+g8DMB7NzieN1x7xuOwvbe1QGKRRq9WTRrk
         iWpXNqv0vlUHRXEl+/1iuOMv/jMaXN2PiDVXkt1kgubaVjxf1YERjzHdbNofm9AiCjFu
         mmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760072278; x=1760677078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7qS0AM3lX7OGhXSFEYS6mkC3EKNzPxshbg7hLZcah0=;
        b=PQyMA4yYpGKoooyiN1EnszKiSuwtOTVVhQQek8YWoFgD3sFxoJyzwMx5SxuINoAR4T
         zoaZpveePZFLfX5cXZiuPm8L5ZUoOEy+GKZMjU2IoTuw7zlhWn+yoSrX2ZxftUwUGie3
         L48ugdsv4wFdR875Q3WULkswGC8SZ6hvK3TbzWMEukNrAzQnzkBA9UHNbZrn2vInWLDa
         axPrcOkL6Y8x7xX45BOWfC94x2UDCpUV8xuwinBtfZ1LexFDOLnNLV/I+MrerNhrn73B
         lldT8P8s70LRedSi8SWjfevuhP748v8azLRQ066VBNlNz28AJ7/XJn0tPybQZiCIL7GY
         dq5g==
X-Forwarded-Encrypted: i=1; AJvYcCVeddJehcUw0xII/ST5FVba7OBNlw2p52XTPiBnaeUHKXwQ0hrwgaZICUM4/9iuDn3LJQaTIfrWcA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxGyoaT9MKYP3fBfuOJ1bTVefqyxsIfnIXNIOVIyTtVIHUfkgu3
	46JB+hyubjOoBykNE2PY2utKC4lwWqrg3b+/9Puk8OgHX/OC1oYRgDLhWwWMtzsKfOpULd6qxiy
	yjz4hAQaJa/DWsOXfn3nHTAhbSX5Fcp8=
X-Gm-Gg: ASbGncs+skPgn/noCXZspNTmkUKcHDjrXgq216kyb0V1dg+qq09B8F1WhT3R7Xu8dfk
	tvb8gJcgaleRbwT0a/JsrK4+8afhI1wHcy8bXhKrsyAYyRPqwa6IvGwHYAbIjer89GMf7LhlP25
	U5AWI0FfLMgKg+AjFDBtE+hrBwAXgrwQA3rnrlp6tR9hHclTCtkY+Rb1vqW0JGW6/EEu6pOQ9xH
	nqFEyw24v9RlLJCsF/YxleGQQ==
X-Google-Smtp-Source: AGHT+IHqDciv7GAPYfMGdKr9Fwuo5GT168N8GcrpsJ5KozP5HqYqg/LDALxuogvzJXgNCm6zrA+DoCqu7lr8uhQrVc0=
X-Received: by 2002:a53:5009:0:b0:636:2420:d3ce with SMTP id
 956f58d0204a3-63ccb93456dmr7466309d50.51.1760072277565; Thu, 09 Oct 2025
 21:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAHNNwZC7gC7zaZGiSBhobSAb4m2O1BuoZ4r=SQBF-tCQyuAPvw@mail.gmail.com>
 <20250925131055.3933381-1-nschichan@freebox.fr>
In-Reply-To: <20250925131055.3933381-1-nschichan@freebox.fr>
From: Askar Safin <safinaskar@gmail.com>
Date: Fri, 10 Oct 2025 07:57:21 +0300
X-Gm-Features: AS18NWAQwCKadWHXCZjVUBNaD3TaKIilJiJAQzSbvGFaYuFuE8UDpW1_H3riB-k
Message-ID: <CAPnZJGBPyONjJoM6cskxysDnN4pxWuWJCK5A6TgikR2xHsrN5Q@mail.gmail.com>
Subject: Re: [PATCH-RFC] init: simplify initrd code (was Re: [PATCH RESEND
 00/62] initrd: remove classic initrd support).
To: nschichan@freebox.fr
Cc: akpm@linux-foundation.org, andy.shevchenko@gmail.com, axboe@kernel.dk, 
	brauner@kernel.org, cyphar@cyphar.com, devicetree@vger.kernel.org, 
	ecurtin@redhat.com, email2tema@gmail.com, graf@amazon.com, 
	gregkh@linuxfoundation.org, hca@linux.ibm.com, hch@lst.de, 
	hsiangkao@linux.alibaba.com, initramfs@vger.kernel.org, jack@suse.cz, 
	julian.stecklina@cyberus-technology.de, kees@kernel.org, 
	linux-acpi@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, mcgrof@kernel.org, 
	mingo@redhat.com, monstr@monstr.eu, mzxreary@0pointer.de, 
	patches@lists.linux.dev, rob@landley.net, sparclinux@vger.kernel.org, 
	thomas.weissschuh@linutronix.de, thorsten.blum@linux.dev, 
	torvalds@linux-foundation.org, tytso@mit.edu, viro@zeniv.linux.org.uk, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251009_215758_933034_BAACB8CD 
X-CRM114-Status: UNSURE (   7.16  )
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

On Thu, Sep 25, 2025 at 4:12=E2=80=AFPM <nschichan@freebox.fr> wrote:
> - drop prompt_ramdisk and ramdisk_start kernel parameters
> - drop compression support
> - drop image autodetection, the whole /initrd.image content is now
>   copied into /dev/ram0
> - remove rd_load_disk() which doesn't seem to be used anywhere.

I welcome any initrd simplification!

> Hopefully my email config is now better and reaches gmail users
> correctly.

Yes, I got this email.

--
Askar Safin

