Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701F6CAC5A8
	for <linux-um@archiver.kernel.org>; Mon, 22 Sep 2025 14:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zds9c11i5EPuC+LW5E2qVk5slu7nHVv1cCYASY1uK64=; b=Tj7R+R/mDDtoDfsp8J+FxTy6U3
	jtLGLH9InV6ZhhFp8jwWl4KLGImdwRWAWkuYE8cp3j+GUWVF28Cp87tDvqAMrX/2xkVg449CnD231
	iy2s2efRg8xsxNlFcOIYjxm6Zqvi4fjlLmT6Fw3D941cr/jKbTvjn7JuSvdzUS6gSibTGsuKu3AcS
	EnoSuWmlr5pOoxi7l8HzJGQwWELK1YPie7T+sGyVaI4n4Nt+AszTxDUrWMuh0oQclFwhI7rZ+xbja
	0yvBjeEqP1kMbytWsj3UZcmatGFVpziSHxYKhOVtzknq7Xs0oL7mUfFa7YuEJfFZC93r2JcZuqYFB
	+v4njdVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0hXS-0000000Afm9-42lq;
	Mon, 22 Sep 2025 14:29:10 +0000
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0hXP-0000000Afk1-1nnc
	for linux-um@lists.infradead.org;
	Mon, 22 Sep 2025 14:29:09 +0000
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-55ce508d4d6so3950509e87.0
        for <linux-um@lists.infradead.org>; Mon, 22 Sep 2025 07:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1758551345; x=1759156145; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zds9c11i5EPuC+LW5E2qVk5slu7nHVv1cCYASY1uK64=;
        b=P1ieyf2nIp2RpJk542YbXtX4cx12sh1wQ1iyNp6MCcE5vKczUKlsucJZcLwhqsHYD9
         5dIbM++7m7znKd5VQNwI8epOEPYmJlaRC2cTEOfWhxaKba+u5YRmkQC78BZb0vtv0mqQ
         U0k6GcRTXShatB8rN6MXqtPmjVmX/CjQJEmqCmywe22jIs40nxfuK2gnGfmH1sjwZBos
         J/BbhfA4mqEuSX/TX8VEjv5aMCQ49Bcla/NzNxRndwrd1fmv/c2P/stei8P6UEtGQCm9
         cWRgfwXPYBwZUZKWV5eMd11IJSXH6nvlNP+kTKIoJOKr+sR2dhBiwS4jbFIdLn0pzqIh
         /wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758551345; x=1759156145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zds9c11i5EPuC+LW5E2qVk5slu7nHVv1cCYASY1uK64=;
        b=Vz0Ur4YZREpRX9q8fwQim4bDW7yMejacEU01NgAVn/h/G4J4yeMAVJDLLAbnMmggy8
         Rxq8kitYj+0VBNSdD6c1YDsehIMXCcQm9y6abUj1mLh0t2QSdq+OfFjyYcq42axOyqAx
         lxKOGaht3Dr8Fvg5AYIZ2zL6mO54SlC02R85F84F6pElIY/kkmKuHOd9OjeWyE2b7lRX
         A8vAOW/p+F5IwsDGEUdadBxAmZIqXEsiGyoxLQECcfXB2ZJDNFwNluYOhRhwY7oOHVqg
         /nzJy1aT4axexe2nbS8OSidbSaACdRArKp9JLJHAIbhQr/L53l+W17K0+8RqvrchiwbH
         y7yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCDQRfzRpFDUhkPmeEdHcYMpsv2qUgEKLyHQAch+fvfVRay71DI4GWKcMJGPSodtfPzkU6fcO71A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw4Lrj3dCsxrgGMlULPpH79QBEdtPVNrXXftOZ/VojmZqYTLDJy
	zSoNxDElHujBrb6WUlWpCTDnist5vUiJmpz7gLLVTZMFUxfYEMjeJc90X/8WHiBt9O8+H7uvQeU
	/atYMtTXo6J/YHGav8R+csX7Uy5waY3Hp+rt9u5Qrjg==
X-Gm-Gg: ASbGnctudzOuifDuijGrkebjNtg1GaXaIFmA6c7t+JVkQY8vL7PZexHSbuR4YRF6QLn
	F1GwZVtCehiZl4ug+e3C/lt/hWTxX8EsNx4eKokxYQExGIm9Mcy31qppl9hy/zs1r3ZOHLv3r5M
	7mMtkUvxladhFnP1tzRJXFw24fdWsLOS/Qh7HP8kE5Ehv7qJuF9+9IDhNAqIuqpe/zG4RhJ+J20
	e7DU8a90YnUNi0=
X-Google-Smtp-Source: AGHT+IF9Kx0YHTgWZximr8IphichwJGTQ/wmiFKfxBKU7xEPIwY53K1eZ5EsUZqb+vcW1xAllqgOcQU2VEEacURTmEE=
X-Received: by 2002:a05:6512:4389:b0:57b:478b:d8a6 with SMTP id
 2adb3069b0e04-57b478be162mr3313173e87.35.1758551344116; Mon, 22 Sep 2025
 07:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250918152830.438554-1-nschichan@freebox.fr> <20250918195806.6337-1-safinaskar@gmail.com>
 <CAHNNwZAzecVcJXZmycX063-=p-M5jVkfStfgYVKJruOFo7y9zg@mail.gmail.com> <CAPnZJGDwETQVVURezSRxZB8ZAwBETQ5fwbXyeMpfDLuLW4rVdg@mail.gmail.com>
In-Reply-To: <CAPnZJGDwETQVVURezSRxZB8ZAwBETQ5fwbXyeMpfDLuLW4rVdg@mail.gmail.com>
From: Nicolas Schichan <nschichan@freebox.fr>
Date: Mon, 22 Sep 2025 16:28:52 +0200
X-Gm-Features: AS18NWBjmNA3KBj8cPrgwDAVm5OX9a5odWP7LbRlHvhoE96nP3yo2_PGoZ1JbG8
Message-ID: <CAHNNwZC7gC7zaZGiSBhobSAb4m2O1BuoZ4r=SQBF-tCQyuAPvw@mail.gmail.com>
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
To: Askar Safin <safinaskar@gmail.com>
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
X-CRM114-CacheID: sfid-20250922_072907_558060_1E7BB90E 
X-CRM114-Status: GOOD (  22.97  )
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

[resending to the lists and Cc, sorry I initially replied only to Askar]

On Sat, Sep 20, 2025 at 5:55=E2=80=AFAM Askar Safin <safinaskar@gmail.com> =
wrote:
> On Fri, Sep 19, 2025 at 6:25=E2=80=AFPM Nicolas Schichan <nschichan@freeb=
ox.fr> wrote:
> > Considering that the deprecation message didn't get displayed in some
> > configurations, maybe it's a bit early at the very least.
>
> I changed my opinion.
> Breaking users, who did not see a deprecation message at all,
> is unfair.
> I will send a patchset soon, which will remove initrd codepath,
> which currently contains deprecation notice. And I will put
> deprecation notice to
> other codepath.

Thanks

> Then in September 2026 I will fully remove initrd.

Is there a way to find some kind of middle ground here ?

I'm lead to believe that the main issue with the current code is that
it needs to parse the superblocks of the ramdisk image in order to get
the amount to data to copy into /dev/ram0.

It looks like it is partly because of the ramdisk_start=3D kernel
command line parameter which looks to be a remnant of the time it was
possible to boot on floppy disk on x86.

This kernel command line allows to look for a rootfs image at an
offset into the initrd data.

If we assume now that the rootfs image data starts at the beginning of
the initrd image and is the only part of the initrd image this would
indeed remove a lot of complexity.

Maybe it would be possible to remove the identify_ramdisk_image()
function and just copy the actual size of /initrd.image into
/dev/ram0. This would allow any file system to be used in an initrd
image (no just romfs, cramfs, minixfs, ext2fs and squashfs), and this
would simplify the code in init/do_mounts_rd.c greatly, with just the
function rd_load_image() and nr_blocks() remaining in this file.

I can send a patch for that but first I need to sort out my SMTP
issues from the other day.

Regards,

--=20
Nicolas Schichan

