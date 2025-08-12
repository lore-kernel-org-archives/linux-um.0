Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80318CA0EE0
	for <linux-um@archiver.kernel.org>; Tue, 12 Aug 2025 16:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mM1oIijYsTieBVXwDdbk88e2RvtyWnf8BqoF2nILFwk=; b=gXDu0P1GTVyNBJubzcvreNAynl
	UBq3cqaBgMaN+hnKvqxNCAvPVUES2aFs/6p+TgvQE8mCNy4J5YZ9fQdLSTTGDFpyhZcm2Ztz9BtO4
	kPrsetdRLl2603nU+5Ztew1jP4H59SECfcUTCl8saYwcNNWX2qFJfvSAr+6RhlKn0ufcxxr5/X4O8
	/XHxBR7rZnZd8JGDJaWqF8MGLZuzWhuB5iXPUn2JQ+h05Mt1hZDw155DHO+Hkx5uId3ArwBQH289w
	Od73+6ma5VS3jjWXp9amvDPsir3bTUImSabwpF6FotYZYNc9T+4RiXv3tj0rObW5eWH0Kl3VonUV4
	7ZMddE9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulrjV-0000000BJfM-3tI6;
	Tue, 12 Aug 2025 16:20:17 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulmr6-0000000AZCb-0Aet;
	Tue, 12 Aug 2025 11:07:49 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-73de140046eso364178b3a.1;
        Tue, 12 Aug 2025 04:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754996867; x=1755601667; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mM1oIijYsTieBVXwDdbk88e2RvtyWnf8BqoF2nILFwk=;
        b=iqzPveYoRu+5bHwVfGhSGpgBAqCJ1wPrg2bcbD0Y3nVT7zHY8rzICBba1sTbHgmZ0Z
         pCMbjrtTHjJ/MunflKHrAjMmBaOt+zcTY5b1IuAafwp+8VD0Jt9i6fxvVj78mOfwPhNn
         MJbnmHeY7MYud+K95IzD9VHBySu/hUdZh3gY4AOae97IxH9VzpBEOGUkzPVL+sifaHBu
         o0wbjvz5uRSBzN1Z/pLKLs3NAzgbVa/GxF9wcU/0d4gmePPSS2r3ZsQBQioX93KdzFJw
         tdyRI1UGd6ozUiHTwZYEXUw91nPz/464Q3pcPsdhVx5ojFA0KYt6/aVtYjt2azhXhrkE
         h7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754996867; x=1755601667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mM1oIijYsTieBVXwDdbk88e2RvtyWnf8BqoF2nILFwk=;
        b=VQ3AZHbi4fB9/peia8r2rZuiwUPGTAH0F78IZyx/WUHsiLw9aw7k1bTl8kaBk372fD
         4eYc03WZzq+5E/GFGRVn+wBzDBndA6MyNHiGwQW0Pzty5PlO+d+HP45Zj50fT4r6QeK9
         lxpyYth8UemROz60P8J4MdymjuC2iWQdRakfYob/7INjNFV9Wqkqz7eErfl7D4aR7PF3
         3NQZ7ex8NGc+T0c8zS2OlEP+i9gVLGZ9ZMpEsgor4LPgpFrtQ3XruJ4RR0wCAGedwThX
         BxWvTdFNpCY1zgoZ3qTPZfTF/pI/5PXeVMEM+s3Pk56bBFVPra1MCSuUJJBcPAhXf+QF
         TJJw==
X-Forwarded-Encrypted: i=1; AJvYcCVcsbzJ/YqNcF05v+MLrTL+TZ3n1TmsIe6uNQUqdTOOSCmnH3rIN9j9yKLCzjA5J6jH716CIUwoUHU=@lists.infradead.org, AJvYcCWgfyvPepTxqr5i/IeOYDn+/QALcs1KUoYVK2zRBVNBNzhoMk3UCKi+xdP36W3vDQDdyHbH4+ksfsQksjeTSFqS@lists.infradead.org, AJvYcCXogtfPCdpdMAAkx4nbezslCY5MhMAnUN2f/DY92/7jdaGV+lCf1UlBnuxj0VnumBLf1krmarJT27iwfrk=@lists.infradead.org
X-Gm-Message-State: AOJu0YxzwixcdBJzexqav2N+IhgTl2safF14hPKFWTEJRiBdduhuwmTu
	S3fdF4i26UQarMpVXd0LSNuQjUvMGVV/rmbq2ZcGype65r/ONJ2HnikDkCg3NahnMGpGwYYYzD2
	k1kfWn/kXcJDcG22o+kvskQhpxBe6+78=
X-Gm-Gg: ASbGncsX5Nm4XzDZAdF3KtU1bQGYjs1y8Xuq2F2GKbIMRYc7ybuiz4zKuAsvHtnBQy/
	a/ZfNpdrSRymXkq1+vlWdGFLVHGAbuRxDjdmflCS/qi0afWZkkw5SMkaeEqIKb/3jG0s7DVga0C
	FNofJ+89I/UGogqXoNrJEhPVqYvVZCNbvsvnWeZv/wq3ifSvMhGajK8mH+c/Qr0/FuBV06/vBws
	cOjDY8emQHkvy6OfpQ=
X-Google-Smtp-Source: AGHT+IGLTgav5Ly0pJQ7DxONlyuqSGpB75/R07ZLvB4KvAdVZt2KEevtP/u+Z9PPdrxzblYTwfgzUXYmCR2PQbfj+a0=
X-Received: by 2002:a17:903:1a70:b0:240:5c13:979a with SMTP id
 d9443c01a7336-24306da5537mr4831165ad.9.1754996867136; Tue, 12 Aug 2025
 04:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250812-vdso-absolute-reloc-v4-0-61a8b615e5ec@linutronix.de>
In-Reply-To: <20250812-vdso-absolute-reloc-v4-0-61a8b615e5ec@linutronix.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 12 Aug 2025 13:07:34 +0200
X-Gm-Features: Ac12FXz75fv-5GwEH7lTNJ0yhooMj6nwQ9IaaKPBS7pSI2ZcZDdB8Ex-5Z7LxRg
Message-ID: <CANiq72nV62c8cVBzke73OH-sfLdgerDBGrLKTmT83+OQtK6PjA@mail.gmail.com>
Subject: Re: [PATCH v4 00/24] vdso: Reject absolute relocations during build
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Kees Cook <kees@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-mm@kvack.org, linux-um@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
	linux-mips@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Jan Stancek <jstancek@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Alexandre Ghiti <alexghiti@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_040748_078555_DB65C10E 
X-CRM114-Status: GOOD (  12.16  )
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

On Tue, Aug 12, 2025 at 7:44=E2=80=AFAM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> Kbuild and Rust folks: This contains custom definitions of hostprog
> bindgen and rust library commands.
> These are currently only defined inside the subsystem directory.
> Let me know if they should go into scripts/Makefile.host.

Glad to see more Rust host progs :)

Keeping them local may be a bit easier initially to land, I guess
(e.g. no docs), and then we can generalize when needed later.

By the way, for consistency with elsewhere, probably we want
`HOSTRUSTLIB` -> `HOSTRUSTC L`. Though I am thinking to remove the `L`
anyway since eventually a lot of code will be "lib".

Cheers,
Miguel

