Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68AC9CAC5BB
	for <linux-um@archiver.kernel.org>; Fri, 10 Oct 2025 04:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zKp2kw3Tfj/wI+7DBmKCMChAalHVoRdliS5fwx1zm9s=; b=pK8Gevx1ko1TKrVe0eeo/nHdFK
	sojd02DagzHqJeElj8vP1fZ/BIvMd4tPEulruz+RXCVmg+gUz0fE7uYGI42yyXnZOVUfJdtk3nUGW
	mUtsn9vbGXYKB/JPRww83Um0h2rQCRl2PdrxueJrU3lzqK+FTna/BaeUQNLWzUn8mAnHIuFT48+IV
	OjRH1HMOxVMMzVFW2oLgTjL7zJywOXkoFL/bjJAqRNe59wYUPPVaR9QXRvDc8jnFjQqYjExHsZGcQ
	gyMcF6ORESrzMPUmjEW8REYFNUxLhnnfU8zCn3YZyTvrLfJT4/BTWOkBCiaEPNdszAz4pwKOMz/NA
	HIqXuZ3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v74Pw-00000007dQ5-3dX9;
	Fri, 10 Oct 2025 04:07:44 +0000
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v74Ps-00000007dNi-4AwG
	for linux-um@lists.infradead.org;
	Fri, 10 Oct 2025 04:07:43 +0000
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-723ad237d1eso15366357b3.1
        for <linux-um@lists.infradead.org>; Thu, 09 Oct 2025 21:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760069260; x=1760674060; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKp2kw3Tfj/wI+7DBmKCMChAalHVoRdliS5fwx1zm9s=;
        b=Gg0zpDaQBr2D0XPqVXsPPKRLAEm13BuvnCSQYHsm8Hm2BCUw/idUy4NGOizF8t05i7
         tCwGEdYjG4Gmy25YlC7LGlgi08pC02Q22WD6emqwNK3FPKTD4vJfHu24qt7yvSh4jU2r
         8llQVkgWTzXI7PCMiqzv94sQlqCPv0aJEnt/NBX7yeQxya36/WxGH+j45CkJ2mHs1VxM
         1s219F+zGqml3zWkuRm0omMICOfP5/AR/90GOUdqWadAuSnbSpfU4msxRs4fGG6l93B6
         oLBhUggsg55gC6M0ZQ5Zp667LxBJ1nUAAm8fJYTEh4gpIbj9gYiSbIcjBMYW4JQLWdw6
         E5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760069260; x=1760674060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKp2kw3Tfj/wI+7DBmKCMChAalHVoRdliS5fwx1zm9s=;
        b=vxRlZ+N6uoDyXB85Li2JZ00+VbGxNLly1/EY7QFvGfEHhLDqtq5lmal+KsmPjkEKfU
         N8DaleTqttp/NApUhdOuYXkaTvk6Z5FU605LQFjPJbhDQ21qU5QuMEqciJgN3IjZ2ts+
         UbKkv3L6DdQhPG7z635DjpDvZ2aHV3udfXrYrZDaaBut0deJoJRNTxaFnqn1w9G1pceL
         HAiedBHWKdWuzV1Q676ngg4VLLGwuwcTjUT+giUmwa3AWAIOjO8XmCHMHeyW6TGiUqhP
         azjd/K4jUK2BjmrkbSJB5AkxoErc2gBy7jAqOIK4sHvKVodJRbqF3zfn+4GWGB8Ru755
         IKlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsSmHZCyst76UI6MwscLwaUNxEz8j8u2KIhS3dkA50tHWLDdaS2RQXi6gDcyeC8fa9iv+z8cApxA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwGAO21GjRMinXVs7YfSou59CvAVuhfqKP+1To/Kk97Z+iB7I6t
	xzqDJmU0nHcDUjflx8IOLEDTwcj51FjRNbziXWVyncjT5yrDygAiVKy7V9PwNVcZe7SUIdEPCD7
	Y1JC4TC8Va/EQNpYKrg7eEPLVx8sXo/Q=
X-Gm-Gg: ASbGncuHQplyZWkvXy2uxExieazmP6VQpXX77NDxhmahrqzpIy3t8POOFatJZ/k5ZZV
	bQGhvthL2RJrPNqIa8jTxQd6EcozHWeAh8bwIk71xm/g/X5Jpdv1abvA3Gl3zZiqeF3wFGcQxUL
	BctkUZ1l9RX7R/N6e+pYQ7qR1KNKl3cPiZvOaAg1cOZ4aHR0IQurf6KoI1RSptGGPDH/iqbvWQw
	T+iOSLSaKuMw1zs4uMsu0g5VQ==
X-Google-Smtp-Source: AGHT+IFQERg8mTh7nax6OaWavJ8DgllCOHm5p0zLQR54uFFNlwqM0wGCA+Q/Rj/bdvDMe/rRbnhyAA7hAcefbtq0UHo=
X-Received: by 2002:a53:ca49:0:b0:633:a883:3d1b with SMTP id
 956f58d0204a3-63ccb87491emr6995599d50.6.1760069259733; Thu, 09 Oct 2025
 21:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250913003842.41944-1-safinaskar@gmail.com> <20250913003842.41944-29-safinaskar@gmail.com>
 <20250916030903.GA3598798-robh@kernel.org>
In-Reply-To: <20250916030903.GA3598798-robh@kernel.org>
From: Askar Safin <safinaskar@gmail.com>
Date: Fri, 10 Oct 2025 07:07:02 +0300
X-Gm-Features: AS18NWBct1j-7S8OHD6pljCYd2aEZxR7vcCRPjZz3T1pRcQcUgdDoCBWxEfbyM8
Message-ID: <CAPnZJGAvQirGTJTiTxumn8sAJ5KYDv8+MUTBmEW2fYX+r2RE3Q@mail.gmail.com>
Subject: Re: [PATCH RESEND 28/62] init: alpha, arc, arm, arm64, csky, m68k,
 microblaze, mips, nios2, openrisc, parisc, powerpc, s390, sh, sparc, um, x86,
 xtensa: rename initrd_{start,end} to virt_external_initramfs_{start,end}
To: Rob Herring <robh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Eric Curtin <ecurtin@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Rob Landley <rob@landley.net>, 
	Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org, 
	Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org, initramfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, 
	"Theodore Y . Ts'o" <tytso@mit.edu>, linux-acpi@vger.kernel.org, Michal Simek <monstr@monstr.eu>, 
	devicetree@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251009_210741_039927_ADF4E524 
X-CRM114-Status: UNSURE (   7.29  )
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

On Tue, Sep 16, 2025 at 6:09=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
> There's not really any point in listing every arch in the subject.

Ok, I will fix this.


--=20
Askar Safin

