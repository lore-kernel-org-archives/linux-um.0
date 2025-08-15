Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FC4CA0ED1
	for <linux-um@archiver.kernel.org>; Fri, 15 Aug 2025 16:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:Message-ID:To:From:CC:In-Reply-To:Subject:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=38zqqxNHqbGz3C68JOy9Ugb8wAb711DWGVbxjNinx0U=; b=MWyTyzu7dWG3FWPvqcmpay35Cm
	W5xRZ/+0AJUT7YWvu+XmRCMN7qU2gOVeMkEp7sydkKneEw1JKFulFg9tpqRtgTM7yg7QoPSvRocpC
	RV96nb8QdX+FJ3x//25WYO5nkjm4PPZGTmUKKaGtPviLv/47AGGikG0zj0HqRnNhj7cQLzffZfPRm
	zClhQWRAvUfpkWv69X5Q4PU59xultVgPQOsX74FPC9T3ozT798/bYILRnaNhWAx5EHEtpJAsNxwkN
	54n2baEaGKZm0zilRD5UBdl+npt8TQ30MJ7fBzyOYaGEtS6KafOvktXky53AwU1yxMUOOMqFujBO0
	Hl2PaqCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umxlk-000000032Xz-1RkR;
	Fri, 15 Aug 2025 16:59:08 +0000
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umw08-00000002npB-1oq1
	for linux-um@lists.infradead.org;
	Fri, 15 Aug 2025 15:05:54 +0000
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-b47173749dbso1293866a12.1
        for <linux-um@lists.infradead.org>; Fri, 15 Aug 2025 08:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1755270350; x=1755875150; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38zqqxNHqbGz3C68JOy9Ugb8wAb711DWGVbxjNinx0U=;
        b=eRU4w0v5ntR9PrDOzmPaY3AiO/jlhmhkdbbTvDUw3B5tgZVrifJjv5ooIvlqR4bWsV
         cY6PGMWK8+3dKD+VA7DFPWvOz+u0GCSNqj44p3xZuRzjh/flUrob2Yi+BrtPCA/L8iuo
         +sHQlO+ddfkzI+vrUI4uGlvoD2EMnSnj5/sPBk1FcrnKSdA1uHLe9cnLC6Am9XQZhP8Q
         HHVyjh89KnUxjOJPmJxgKpZTwkzL4afXSagwutu6meXKujioSTSC/P+KWbgDbeRVLt9H
         agIvQMFOwN6qQxxkRE1emMPeolN1VvIK25hXsFY4k/70uih4wUvFsJ3xvtN6caiCfSTC
         +FSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755270350; x=1755875150;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38zqqxNHqbGz3C68JOy9Ugb8wAb711DWGVbxjNinx0U=;
        b=RwfjvZehu5JsY4B6SWwFp+XKAD4FhQgkguNrXOO/t3q8A5Efg6bSu/+BFdNk1HwE4N
         FEJiBU5QcBKef8RknTqUec81pA3LFnBk2dEIeFy7zLraNzMclscQcMd4PCqyHz+9pMSc
         DDf05G6rnzLan4pFB0RVCZHjVdpqBUZSruNv0F5aaggw/kUjSIQ5YrWiAdpXz+vsmEJ1
         GGgdzNt9LQe74cRGBzYiwVt6RC7lcO5rejkp+yYW9QkdsvAYbiexywjtVvssseHnnoDv
         yKrCfK3fu2RhD/T4rO2jC6B7YWCNWuX5dp9tYbeztsUNZF30aPaB3fkYRK1z1RZUE7uA
         ufYw==
X-Forwarded-Encrypted: i=1; AJvYcCXrhlv/12k3w9omrfpfoVO1L6toPt1dNcTbMD/0Gjrg7jqneeBXNV+Uu7Y+SMjT1aoPXZBTe/UQrg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyZo2GrWliVgUFMUSAb2d42/shaLAh886AAiBmdCSwOJakWVLrG
	neQh6Rp5RuR9+aOJnOj64bV2J9Hpq5wX9WZpcIL1jv5Bi4hlNVK8Wr0QuzyGUTsuob0=
X-Gm-Gg: ASbGnctYpYlKMi9f7sGvpAltMkWJLJFZuwz72kUD4NjTkjoOd/Q0DvZaqQqk1lVm38M
	RHic3KlTA/SletGArfIEweFSU2ABc7+wnWhp9PENDpWwi7F17cGQ9gTWJwWIklRLE/UW4JCi5Hu
	791LsCzRNGqh+OjJQ9iS7Py6K4mciKbpcvz7WCyWZP3P6FhpLvAZY5+IUtP5GyYXncVmaKpf1PA
	rtAQp7j2enhQljjBWjfGa0/ZvsZrQSbFSiL1eqWkgEWTnLSJJbsmsloAOdQx/s46hXNNKfj51x0
	eKS2Qxkth9hAmBjw4FnsOJQH/d82rwkd8olcHjHXNN2XUOzivwFjMRX65fSDQdQU8Shhuuy6lPL
	YWA/gT5kRPCpeVE/Ow7iO2RubiVXLRrcDvpw=
X-Google-Smtp-Source: AGHT+IG3gBMogdOr+spUGY65daTLUVfmz5lhgO/opdXo6UimhkccgL0C2Gx+F8DUbrOBq4AI/2z6Vg==
X-Received: by 2002:a17:903:198c:b0:240:a222:230c with SMTP id d9443c01a7336-2446d5af743mr41307075ad.12.1755270349908;
        Fri, 15 Aug 2025 08:05:49 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2446cadf96fsm16286885ad.41.2025.08.15.08.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 08:05:49 -0700 (PDT)
Date: Fri, 15 Aug 2025 08:05:49 -0700 (PDT)
X-Google-Original-Date: Fri, 15 Aug 2025 08:05:47 PDT (-0700)
Subject: Re: [PATCH v4 06/24] riscv: elf: Move relocation constants to UAPI
In-Reply-To: <20250812-vdso-absolute-reloc-v4-6-61a8b615e5ec@linutronix.de>
CC: Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
  Alexandre Ghiti <alex@ghiti.fr>, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
  justinstitt@google.com, luto@kernel.org, tglx@linutronix.de, vincenzo.frascino@arm.com,
  kees@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
  hpa@zytor.com, richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
  linux@armlinux.org.uk, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
  maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
  chenhuacai@kernel.org, kernel@xen0n.name, hca@linux.ibm.com, gor@linux.ibm.com,
  agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, tsbogend@alpha.franken.de,
  ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
  bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
  tmgross@umich.edu, dakr@kernel.org, nicolas.schier@linux.dev, linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-mm@kvack.org, linux-um@lists.infradead.org,
  linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
  linux-s390@vger.kernel.org, linux-mips@vger.kernel.org, rust-for-linux@vger.kernel.org,
  linux-kbuild@vger.kernel.org, jstancek@redhat.com, acme@redhat.com, alexghiti@rivosinc.com,
  thomas.weissschuh@linutronix.de
From: Palmer Dabbelt <palmer@dabbelt.com>
To: thomas.weissschuh@linutronix.de
Message-ID: <mhng-5B6E084E-60EE-440E-BFF9-5E81AAC9A473@Palmers-Mini.rwc.dabbelt.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250815_080552_473925_04FF876C 
X-CRM114-Status: GOOD (  11.93  )
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

On Mon, 11 Aug 2025 22:44:19 PDT (-0700), thomas.weissschuh@linutronix.de wrote:
> These constants are useful for cross-platform userspace, for example to
> process ELF files during kernel cross-compilation.
>
> Move them from the kernel-private architecture-specific header to the UAPI.
>
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>  arch/riscv/include/uapi/asm/elf.h | 66 ---------------------------------------
>  include/uapi/linux/elf-r.h        | 66 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+), 66 deletions(-)

Acked-by: Palmer Dabbelt <palmer@dabbelt.com>

I'm going to assume you want to take these all together though some 
other tree, thanks!

