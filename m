Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A83CAC5A0
	for <linux-um@archiver.kernel.org>; Sat, 20 Sep 2025 03:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wLR5A4WVJygISPHG42IIvYb+LPD25B9I3WH7jC2e5xU=; b=m1bXXMO0K1o9jTVmQagOVH+iVx
	u1cnqAFqfe7R2szMLEG99vdAeHJMEaokxI5ol6e+5jVNR9G83e4ALnGCFY6tL2Iev6O/JIOZXL9Dt
	HcnVne6ICPkYzexZXfqDPgf1UmokwGF3qpBQdwCbSKvw99opX9+YOE7UMz+TDloyeL5ow9M+igpGE
	WXJmSaPFUSBrT380BMNf5l/o1W+W9/9Km9GdaApLrpq6jVib7Gy7I0IylUzyqaJ3NF/QUmMPSqUyC
	wZtXRXvOTM7W6+OHERppbsaRlNrFvGj4vbOwdMBaDr/Uipf52qUQ3YPPpGBP0+HiFtsyaQC4v7gtg
	bIvoc4mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzohH-00000004gck-1drc;
	Sat, 20 Sep 2025 03:55:39 +0000
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzohD-00000004gae-3p6U
	for linux-um@lists.infradead.org;
	Sat, 20 Sep 2025 03:55:38 +0000
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-ea5bc345eddso2257562276.1
        for <linux-um@lists.infradead.org>; Fri, 19 Sep 2025 20:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758340534; x=1758945334; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLR5A4WVJygISPHG42IIvYb+LPD25B9I3WH7jC2e5xU=;
        b=LOBZL0WJkbfdvSEIhDYYVJqbnDIy5O/FGjT8qeBG6cFhsDNoXlkGLLCTUHFXB2U1i1
         2h0CbS1ZWGzYFdwusgU+QOfCfqkJpY00odG9uXpOQ7yh6YAylJsVmwi0rTcxxT48h0cV
         6royviXFGGZ/eIgxCV/otVVM3cQ1XwVyQmYObEOLpjnnCiyHR9UaYx778o4JDFZE9mgr
         CxRjom846231CMq8OssPqFVxTzgJFtlBluWwB1kaVwNU019p0upJ+dN0C14lSfRIy+Uh
         cFa7HAUKfRAiIv1UgnKZMbdhBH9m2I8lsCSxNISo+KTZiHNfTTCxHEze37Fb4pccFHGP
         HMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758340534; x=1758945334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLR5A4WVJygISPHG42IIvYb+LPD25B9I3WH7jC2e5xU=;
        b=cQbQT6mQIisrh6hsUCPc47epjQn+gc+mwORyFECm+pQ+kAEZY+CKaVcjPoi0Sv7Xfu
         DWpXgRgCk53EKFrSRJU+eUJJd8LEkaYkDvnIUVJV6y4D4KSTZLjhvUgoAtOS1QrmWbjE
         koLZ1SQeciCr0fXOSFkR0rBvwc6YmiOw6WV2I8QWmfoz7kKflV6qaRoOWa9ejUJpG3KS
         CCYtIAtTiyAvTNdUTifYGwAyB1AQLfjOC4+vCjqCBX8j8H9uiObNNMtnK3eBZTbwMDqh
         Vs79SdyTRjc5L5niJKgO2uPNqtLxJUkvlV5VelfC5RP8tixkbChoDJTQTo7Wyeglf2l3
         cK5g==
X-Forwarded-Encrypted: i=1; AJvYcCWkPtzvL7hF1AaFk42FEjRWey8gKgvRbV54dUGSzVQneJ5noHzXZeb73D1LFJQj+BtFHCX/Xqnnxw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzJ9A/BBgLxTC+xkRUQwuNzz3vTDMLMTq1XBw7REBCqf8LFWKl9
	LCTSXY0Ebqw8y1hOrqbvzzXfHU2XbTxGWVhh+DpBN0bQ2LRdhb1123hKLHG0FdQCjdr0FbeaV4+
	1PCuq0c5uZZLDobFV9ppMFjnuTMWaai4=
X-Gm-Gg: ASbGncucn1dRUb+wN7GR/6QoRUX10LDbLU0jz+NNfuZ2KF4Jb/iAvo/lL/53klpFpva
	wle5g6eQ9GMCEF0rfsGHB3zqRR8eI0ipDbSTjk3rhcMDEUeMtPOLr9TPpEP3UzLOxVElhszTOK5
	iJc7cMDWXF6Rm5ZmAi1QKElNrn5T1Ubd/oeOdkTlcvRGK9N59zHJJ7nAFQH+YQUb0+u3R5OgunI
	eFJ428=
X-Google-Smtp-Source: AGHT+IH7cxRQcDAWrx6iopGK0fgAvvotX/SwRt/T/KElvH4XQULrd96czgOrVv1CSvA0vDpbRNCMKcVlhfdowxEBryU=
X-Received: by 2002:a53:b3c5:0:b0:622:4818:ce38 with SMTP id
 956f58d0204a3-6347f610c7emr3546092d50.37.1758340534336; Fri, 19 Sep 2025
 20:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250918152830.438554-1-nschichan@freebox.fr> <20250918195806.6337-1-safinaskar@gmail.com>
 <CAHNNwZAzecVcJXZmycX063-=p-M5jVkfStfgYVKJruOFo7y9zg@mail.gmail.com>
In-Reply-To: <CAHNNwZAzecVcJXZmycX063-=p-M5jVkfStfgYVKJruOFo7y9zg@mail.gmail.com>
From: Askar Safin <safinaskar@gmail.com>
Date: Sat, 20 Sep 2025 06:54:58 +0300
X-Gm-Features: AS18NWCqg0xtU5KiNe17DWjmiPCEbBI_FSj5NCOyDGZFj_7oFaRqSu7O_vUKCrA
Message-ID: <CAPnZJGDwETQVVURezSRxZB8ZAwBETQ5fwbXyeMpfDLuLW4rVdg@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20250919_205535_985178_14F6B1F9 
X-CRM114-Status: UNSURE (   7.06  )
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

On Fri, Sep 19, 2025 at 6:25=E2=80=AFPM Nicolas Schichan <nschichan@freebox=
.fr> wrote:
> Considering that the deprecation message didn't get displayed in some
> configurations, maybe it's a bit early at the very least.

I changed my opinion.
Breaking users, who did not see a deprecation message at all,
is unfair.
I will send a patchset soon, which will remove initrd codepath,
which currently contains deprecation notice. And I will put
deprecation notice to
other codepath.

Then in September 2026 I will fully remove initrd.

> SMTP server I used wasn't authenticated to google, so all gmail
> recipients were dropped. Hopefully this work better today.

Yes, this time I got your email

--=20
Askar Safin

