Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A71CCD183
	for <linux-um@archiver.kernel.org>; Thu,  9 Oct 2025 08:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oOmLRNO4yxmZr9GGl+AUsKcQlyU35gqHSeHKaWhtPwQ=; b=pUi8MPvunOR/fn1QlLLWzwpYIN
	tdg8xzgU2girQL0ASIQTZdZm8KcaRsT0wGf1F3B/P+z+Wl5Twzm5fRoId1yzjMIjPaiq+dyqAoERa
	GhUZPJkNT6tAO7ACeUii6kJSRLrM/V7iphj283nMw+X8rxMP128hg0W6Gmk45ichvXy2qM5MttYHJ
	VUuAk+b5fHm9PMTQ+2RQzQRqRbJBgbLG6NAyrW55JxOiMqAs8KXU+dxdlFTjtEadBOA9J676rcSfr
	rRyejzF/CtiBUvDD0AaLLTIul4e6X3Ebu7G1MPfXpgglT0O/z4vEtJSplu+uQNmqpKoDGLKilOmwy
	oCVPt1CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6mFT-00000005XnH-2Xo8;
	Thu, 09 Oct 2025 08:43:43 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6mFS-00000005XmS-16Ra
	for linux-um@bombadil.infradead.org;
	Thu, 09 Oct 2025 08:43:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=oOmLRNO4yxmZr9GGl+AUsKcQlyU35gqHSeHKaWhtPwQ=; b=lhRx7b65upfq2OhBVrjQeT82hk
	dCPCJxtL3eGW+njIYgW/vjqnesHkER9S+UniHu7zybnX0+FGjR27PJG5F0SOrmC/DSBxYeNiDXVh7
	I9BO61En/UZV/WabQV4KEFN/R2W+WsXmBkTfuIYML+OPS/XglUFJhgzNKr+bXF3w6SJeyro5fkEIC
	gqMdmcS/SUGPL6B4TpL50ivfnHq5MwoYqxe7inOXNZmbU5UKAG7sB3MKKsEbHWTzDoDWtTX7gGEId
	9mHalwjQwZVm+fZkfk5C7Qun1zkuNNDWuH2qIciPSkvQPFSJAIpH7JRf//8O35+f3E1ffSKX4QkOw
	4bghUYrg==;
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6mFO-00000001JK4-2cKE
	for linux-um@lists.infradead.org;
	Thu, 09 Oct 2025 08:43:40 +0000
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-71d71bcac45so7656057b3.0
        for <linux-um@lists.infradead.org>; Thu, 09 Oct 2025 01:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759999416; x=1760604216; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOmLRNO4yxmZr9GGl+AUsKcQlyU35gqHSeHKaWhtPwQ=;
        b=C6BOkosjlHa5VkwhZfh4j+ONXYtGY72PJsF2FjfJap1x36ou7RfHimBT88ck1DLlus
         d44YI4r6TgGfy+qaA1Y5pBcm7gj+imB3YubptbNvteMRFJdsy0vrmDDZz9uvnJfuaeld
         Uc5T5tfGMzNWl9HXcb+a63wHTkS43zEfdIQ3zdWg8M4DZBFrws0DaUoSnhuES65wDk6h
         4mrTN/xHnZU3YojS5vfnAJvTy9UFCp91iREx3Ub4DK13pGEpX41A8Jb8iC6R7EOCTKe+
         WoYnb7d1dxF+vt2+NDAdsyOmVWLxvvRK+KPOzAngAXE/CZ+oTlgQPLSD0DdlchQ1KuSi
         FGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759999416; x=1760604216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOmLRNO4yxmZr9GGl+AUsKcQlyU35gqHSeHKaWhtPwQ=;
        b=JUqUe0QpkzFGcgTQhq8V40L9iRq91jQoDdYizowyFDisQTGRL9a7IgpWy1MCkTOAQb
         544vW/sTQ92GNfn0BMl0K6DiNfYSm7hPZNwOQeiPeBhQDM042y0gw2WtUbLRKzJjMEpo
         hz+2LXL5TvvHlkzK+PdfBmTVpQNI550TAGMO+tO+5poPo0ETqdb6n4wp0fpKb3tINvfY
         iMw9t7fpuAWVC529qgb+URv1PyxjRwg1TFGZ8tnc++6XlwUEH0ttzDo1X6PYyEUHW+lZ
         HakeHSnbbH8tR6aYvchyb20RBBMWwMHx4pCEgiJO87m16Hck2qAp2zG8eZDtZiggebhB
         f4cg==
X-Forwarded-Encrypted: i=1; AJvYcCWxKWI0KXJ7NnOM6Fo1Z1Sy1ixKp1/rql5INxWORS7j51A09zMijA+ynhZykBa2fdq0V1enGsCx3g==@lists.infradead.org
X-Gm-Message-State: AOJu0YyH5YhZnWwkBjAGAQNTzgdScxxHjBexuyKhtIJaIhsFOHL3eSk1
	jtOAszDr3io/NQMGHmoltWlpQuG1YGB8JrSGGKK3P6Rrt/RvI8dBUW4KTkmIvNhPKMWjYrZaJ4F
	I4UBcYzJcsQjfDWVwGiKXkrYw5USY2qA=
X-Gm-Gg: ASbGnctaQdstifsipGiCRpx8pUnKBWxSGtQhdWT1gX9yDG8vJ6Y74WXu1gTHMPpLU2e
	/k8IER1elAyjv04XPb6O92YLQ/urhyuT2PIJ0OmgUYrFlOOGzVi324ZiX0rfRCihNgQCdPIDU8Y
	FqFYIlnusMqdOa16sTLuCyJUyEOvmGsDsO369w6OdrQjH0C6xXCrUYC/4muvQwCAGqvnDKyUXmq
	K8sNJL437lHmrgXRCRN6vTNujEsKBVI5zvtQ+TTNQ==
X-Google-Smtp-Source: AGHT+IHqqt7JHMFlL5DEMxX8/4fuWke6o7x715NV65SuEycRYAp5q8y3uA9SPr+Cccah/gPAgRpT2LfWBS7AmxUm0/4=
X-Received: by 2002:a05:690e:146:b0:635:4ece:20a9 with SMTP id
 956f58d0204a3-63ccb91d5e0mr4410660d50.46.1759999415603; Thu, 09 Oct 2025
 01:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250918152830.438554-1-nschichan@freebox.fr> <20250918195806.6337-1-safinaskar@gmail.com>
 <CAHNNwZAzecVcJXZmycX063-=p-M5jVkfStfgYVKJruOFo7y9zg@mail.gmail.com>
 <CAPnZJGDwETQVVURezSRxZB8ZAwBETQ5fwbXyeMpfDLuLW4rVdg@mail.gmail.com> <CAHNNwZC7gC7zaZGiSBhobSAb4m2O1BuoZ4r=SQBF-tCQyuAPvw@mail.gmail.com>
In-Reply-To: <CAHNNwZC7gC7zaZGiSBhobSAb4m2O1BuoZ4r=SQBF-tCQyuAPvw@mail.gmail.com>
From: Askar Safin <safinaskar@gmail.com>
Date: Thu, 9 Oct 2025 11:42:59 +0300
X-Gm-Features: AS18NWA7xuLtf9pobQHoPGHI9uL9SjsnEaZg-EuuD52zBO81KbUszIYBPPZ5wRY
Message-ID: <CAPnZJGAp-wG+9wDmmisfpxvFbRtXkG-RipAuZe=fi1BWy-3G-Q@mail.gmail.com>
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
To: Nicolas Schichan <nschichan@freebox.fr>
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
X-CRM114-CacheID: sfid-20251009_094338_954116_764020D8 
X-CRM114-Status: GOOD (  12.85  )
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

On Mon, Sep 22, 2025 at 5:29=E2=80=AFPM Nicolas Schichan <nschichan@freebox=
.fr> wrote:
> > Then in September 2026 I will fully remove initrd.
>
> Is there a way to find some kind of middle ground here ?

I still plan to fully remove initrd in September 2026.
Maintainers will decide whether they will merge my patchset.
You may try to convince them.

> I can send a patch for that but first I need to sort out my SMTP
> issues from the other day.

If you still have mail issues, consider applying for @linux.dev email,
they are free for Linux devs ( https://linux.dev/ ).

Also, I just tried to test whether your use case is still supported in
mainline (i. e. uncompressed initrd with root=3D/dev/ram0).
It turned out that on modern kernels you need to enable
recently introduced CONFIG_BLK_DEV_WRITE_MOUNTED to
make this work.
So, make sure to enable this when upgrading kernel.

--=20
Askar Safin

