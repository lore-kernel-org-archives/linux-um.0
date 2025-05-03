Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72AEC369C2
	for <linux-um@archiver.kernel.org>; Sat,  3 May 2025 17:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UfBITuSYGFjANNp0rWCWBGhPofXTaDFt3Gv2JIctka8=; b=UCFB0SInoPguEs2pp85bSyIN2r
	8B25VicePY9NAnPTPaoEudLqBvPUCxpUOz52flFKFe/1XAhQsWtRJSZWQKUDFtejnynGbmKbg7h8T
	LL3zOsVrsgpfMnsb0BI6EcG2byY3FUN1+Uzh67poubDvDYP/0ppRNUsDTs2G4vwbjvpS8C9wsvOvy
	01CLkCOQTh+Sj4oULJnhkelCWgXe6d/maCW3gDjxW69JQJJa3izNMMrOVT89oGmUMh5RXT2yHOVkl
	CnYHuKelbCDtFPZd0MyEc4uiZal/6tQRmw2Z1dLnnLG/fFQlxWXbvCtjVo+yX3Byl7xlpdVMw5AEd
	vK17j2iQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBGe1-00000004JAG-0KYH;
	Sat, 03 May 2025 17:27:21 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBGdx-00000004J9d-48Be
	for linux-um@lists.infradead.org;
	Sat, 03 May 2025 17:27:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 397DD5C3FA5;
	Sat,  3 May 2025 17:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032C2C4CEE3;
	Sat,  3 May 2025 17:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746293236;
	bh=afYEBQ54OVfQ8bXwdjP2yZIT46gbP/p+Xv9cI/7InNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pdfHbD+DYSJqOcPBc2NPyBDCetpA605SdGiW/iyPj3iwbOIwv4+/0Qi3LGbhTrVIk
	 MF3svDxvy34K6HBKOyIVIkmgBuXy8rwzqjCZcnAOdAxRz4S6czbI1I5ctYTO5Z6z9u
	 jNEUEAkWmW8F1VCIIFLDvbY65HAUsqKWJJKwlfWHJ76GylT373e6pD9mEz4VyjJYKN
	 jPHuQfazFlpLGKEvzl23vKaNvuoK7FTc5+56VVHuS4KcC3E224KE4gzalZypbueCRM
	 3ByCFixh6yY/tExKEPWXm1M0r/2tKOLQTc3JaSq0H9TUCVJWpzoj9SznzwurxLhe2V
	 VoTCfZLPmok1g==
Date: Sat, 3 May 2025 10:27:11 -0700
From: Kees Cook <kees@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kbuild@vger.kernel.org, Justin Stitt <justinstitt@google.com>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-um@lists.infradead.org
Subject: Re: [PATCH v2 2/3] randstruct: Force full rebuild when seed changes
Message-ID: <202505031026.6FB74507@keescook>
References: <20250502224512.it.706-kees@kernel.org>
 <20250502225416.708936-2-kees@kernel.org>
 <CAK7LNATDbxc+3HQ6zoSk9t-Lkf4MSNmEUN6S5EqoVWnBQw_K6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNATDbxc+3HQ6zoSk9t-Lkf4MSNmEUN6S5EqoVWnBQw_K6g@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250503_102718_062523_286C6397 
X-CRM114-Status: UNSURE (   8.25  )
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

On Sat, May 03, 2025 at 03:13:06PM +0900, Masahiro Yamada wrote:
> On Sat, May 3, 2025 at 7:54 AM Kees Cook <kees@kernel.org> wrote:
> > +$(obj)/randstruct_hash.h $(obj)/randstruct.seed: $(gen-randstruct-seed) FORCE
> >         $(call if_changed,create_randstruct_seed)
> [...]
> So, this rule is executed twice; for randstruct_hash.h and for randstruct.seed
> 
> randstruct_hash.h and randstruct.seed will contain different hash values.
> 
> I recommend keeping the current code.

Agreed -- getting stuff into generated is much preferred. Thank you!

-- 
Kees Cook

