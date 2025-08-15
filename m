Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EABCCA0EE4
	for <linux-um@archiver.kernel.org>; Fri, 15 Aug 2025 17:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:Message-ID:To:From:CC:In-Reply-To:Subject:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=HSuqWusYtC3hY8ploe0KH7jPL7SusiQWfMM3CIlvAWY=; b=n/AhNB7IfrubSOqBAh8U9nnFwD
	hWvGaN7AvG+3Vs3jeG65UpXo4HqGXFQXIw7rj8gJFThPtQxurJ93DI3HxoO7xraqAEQhPQKuP3Yx9
	tOXxPSkYZPzyXsi3kTA05TvoPt0W8Q9fps0ME0pRJVK11PsFXw1tlwKLHPWUeDreL1bCQDFA0fN4F
	6+yflolbNm2YyEbntTAgijdqz9BCMqztJDMot3EXoFmWqt9ESFpUGX3DUGLlniv8ia8yZUpW2FrT/
	6QObS/oORukxGf+Oz6NK31Biuap87N845Kf2qpBhp7/ZFuD0rZfrQf+/H7IFMj4QFFR7/mBg/iKPE
	aye4J2+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umxo9-0000000348E-0gru;
	Fri, 15 Aug 2025 17:01:37 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umw1m-00000002o66-2Ehs
	for linux-um@lists.infradead.org;
	Fri, 15 Aug 2025 15:07:35 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-76e2e614b84so2125184b3a.0
        for <linux-um@lists.infradead.org>; Fri, 15 Aug 2025 08:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1755270454; x=1755875254; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HSuqWusYtC3hY8ploe0KH7jPL7SusiQWfMM3CIlvAWY=;
        b=0f7X2Ra7vUeX+bf1SEVRHpWhqVW/SCKhE8jFsD7vlb4wTp6rtIYKpNuj0LLP/arsqg
         XnRCibI7FqQD1N3yyR0G6n91/grOYPoD52g+MiYONGKtgQi+Y2V4VtZpMleWDrUxmkpI
         zKak5RebbHKLZn0JXe5lhq5yIL2vH2KVcTIcB3tCcYv9V+Hg3HSfdvgxE7WIX69f1afN
         R9hNeo4/vayAvR1atXv34J4fx/fjfpI2+LOuMkY3r8fyLkXMQUYJfFD40Lgb5F1SQ2ta
         xM0CShJSdAYn9f7DArDVIHpy47kaGtcc6zJtdppC0cXto/wnJCOhw9LP6irThVlTQzHv
         OR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755270454; x=1755875254;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSuqWusYtC3hY8ploe0KH7jPL7SusiQWfMM3CIlvAWY=;
        b=lecAPumh51LnHiGNkn0lwda7U/UNSiyFiyLC5nLTgcFoWZqppwjNinQUIDy4lcDYEZ
         toZZoJmeHaiX81bgsDcrls2tdR3NGMENBI0pdvGJ4TyWmXbRyrjyaBetVoOF5GFrjaTw
         FIkHebK3yLxNJ2lKhQgk/Q8jlzGm+cx4vKiEa2Y2w8I7WyOsu3+M/xQaSkUfrus1OUnp
         adFVREZofdEOz856cowIAjUEe2rttrsUQnNzGDcowdvRv5PIlzA8nOwCrPM2ayW+eVjE
         fYP1R/fIl5TAuUeOQkSDiRN+v4chlpmfTI5StQOZ0f3dgcvswANTQCu66e6uKpa0n1eg
         2vCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD+lRh42uQKgW15xqroXxMkNbTU8yQsWk23qWVJ1RTiClpHJP/ezAMZExxj4n7HmTwj3jOCUKMnQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yym/qI0Fr1hh87zm4GABv5Ks4/5M1zW6t4uudHamNy3AOFHO/ek
	nDjNsseEX0jQFFBlTdxUtYAECqrmVmP4Sd/TwiL/Tun4IH3/19x4Al5PMIlTLzlQw7Q=
X-Gm-Gg: ASbGnctpw1X1AcDPbAgY+AhLcfZ+GtWbTIVr18eOdSWcFg+K61dPBSkN02SR7PFOhCj
	LeXE06WRtJTlRGREIefn6V41yCOA2Uh6oKnIY2n/R+1LG7pOzNfp4ohgJ8ORNeFdrBlfZ1UzG8K
	dJuBJFaGpyLzp3GiyKBqV/PWHuMez7Wr7pQi6C2nuCwcDGDTlT3JFmkIDm29oOSRWwLBV53+vnU
	BDTA+J3QhrbrSF9wR3tij36qjVXkotdLcsUcacp6APw8W9DKHjyNw+joiYfO8Wyavo+0MlQqW3R
	+nHIqaT8um7uAQiwnqUUQIWCGrWL36/TDYUFFD+/pw3fhS/C/CfXUrT3npxvWwXd2pDrVPXjaPI
	t/n6l7C6jdrJ/k9QOcsmXxIVC+cecOs9qYts=
X-Google-Smtp-Source: AGHT+IGQbGMaqUCBVjgHpE03NJ6lUtJGuN0cfMPLFV18k27l43zYHixLrnt22lRnZXhrjts5z9io5w==
X-Received: by 2002:a05:6a20:1611:b0:23f:f5bf:35d7 with SMTP id adf61e73a8af0-240d3039205mr3462386637.45.1755270453673;
        Fri, 15 Aug 2025 08:07:33 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b472d5e58d0sm1499710a12.23.2025.08.15.08.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 08:07:33 -0700 (PDT)
Date: Fri, 15 Aug 2025 08:07:33 -0700 (PDT)
X-Google-Original-Date: Fri, 15 Aug 2025 08:07:29 PDT (-0700)
Subject: Re: [PATCH v4 18/24] riscv: vdso: Disable LTO for the vDSO
In-Reply-To: <20250812-vdso-absolute-reloc-v4-18-61a8b615e5ec@linutronix.de>
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
Message-ID: <mhng-146EE95D-951E-41BB-898C-033437B27EA3@Palmers-Mini.rwc.dabbelt.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250815_080734_574514_F05F3E1E 
X-CRM114-Status: GOOD (  18.17  )
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

On Mon, 11 Aug 2025 22:44:31 PDT (-0700), thomas.weissschuh@linutronix.de wrote:
> All the other architectures supporting LTO (x86, arm64, loongarch) do not
> use it for the vDSO.
>
> Its is problematic for some upcoming compile-time validation of the
> generated object code.
> The LTO object files do not contain the necessary relocation information
> and -flto-fat-objects is not compatible with clang < 16.
>
> For consistency and to enable the mentioned compile-time checks,
> disable LTO for the vDSO.
> The vDSO heavily uses __always_inline anyways.
>
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Jan Stancek <jstancek@redhat.com>
> ---
>  arch/riscv/kernel/vdso/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> index c19c3c76f7c9f6b2f7523a59269de3b683656323..9f1bf5bae9bd473e43d9fd3022e9e1a185128b73 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -49,7 +49,7 @@ CPPFLAGS_vdso.lds += -DHAS_VGETTIMEOFDAY
>  endif
>
>  # Disable -pg to prevent insert call site
> -CFLAGS_REMOVE_VDSO = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
> +CFLAGS_REMOVE_VDSO = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_LTO)
>  CFLAGS_REMOVE_vgettimeofday.o = $(CFLAGS_REMOVE_VDSO)
>  CFLAGS_REMOVE_getrandom.o = $(CFLAGS_REMOVE_VDSO)
>  CFLAGS_REMOVE_hwprobe.o = $(CFLAGS_REMOVE_VDSO)

Acked-by: Palmer Dabbelt <palmer@dabbelt.com>

Also assuming this goes with the others.  Thanks!

