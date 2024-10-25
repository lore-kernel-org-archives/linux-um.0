Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9854BD0C5EB
	for <linux-um@archiver.kernel.org>; Fri, 25 Oct 2024 08:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qJSFjIpnl6Nk8kryfd+s56qg6w0ha2aCPbFyn5Yc4wY=; b=zpum3wkSOamnH7SwJ7R50+DLJB
	kymAWFEVEl7pNXDggw/jVloH2WCaITphNnwOmfZWuAEC9MNxpQoiU/TkwEaW9ikNhXUguTsZTHcUl
	u2EDdXhIOwzZZlkVBdhgZPkk/okqSGm5Z5LFTxkFGnUZ39JPHmr0KFKD7RoEQfUYPwgV8TgCVaG38
	hCCG0oavpD8BrCkcgSX8K9EntJtSCtwZuBCTd59Y3rtroU2ODCb08G2UwlNG5Dml8BjmiG0lGx7Vn
	I/+ks2CYwKdCzKlKWbKKIXqF11k7z7obJaG6+DUPYre3rVOZal1po48AA2Jkuv+kief2fGutr3JP0
	cerY08Fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4G7x-000000033zU-09tS;
	Fri, 25 Oct 2024 08:57:01 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4G7t-000000033z6-3eog
	for linux-um@lists.infradead.org;
	Fri, 25 Oct 2024 08:56:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qJSFjIpnl6Nk8kryfd+s56qg6w0ha2aCPbFyn5Yc4wY=;
	t=1729846617; x=1731056217; b=MSlidkqlD1jOv9frMj0dTTPoAk+r+tr5WKpHQy/xkM+aPSP
	AuxDEN0eZDRY+iFK/vPuPGcM9qTOaBfu0VysnNsDPUat6b1mCgWzGhoA2vnBrmCDQJe+5LWGaZY6/
	gPDXKyXr+S9LXXEnhNLBBiz9B3lG26ByyVuHlNcgOBaxfx9jePb+iTXOkfLMIzPuT4Tkd+9RblCn5
	5ye8HMQM+YKsXeOJXqbczexr+KZM7fdQQX5lkRu7AlwdUfvP06/KZNW/Vdn6aAG7ikPKR29lNgDCm
	R1nCG8A4zqFaKa1exC/5weNc8d+wB6C/0iuj1v3qY0re+fXBxeGEhn2urR1RVgxg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t4G7p-00000004RoO-0ixE;
	Fri, 25 Oct 2024 10:56:53 +0200
Message-ID: <d24d5197bff15d64e6ac14f538f9718403e478f6.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 02/13] x86/um: nommu: elf loader for fdpic
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org, 
	jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: ricarkol@google.com, Eric Biederman <ebiederm@xmission.com>, Kees Cook
 <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org
Date: Fri, 25 Oct 2024 10:56:51 +0200
In-Reply-To: <db0cc5bc7e55431f1ac6580aa1d983f8cfc661fb.1729770373.git.thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
	 <db0cc5bc7e55431f1ac6580aa1d983f8cfc661fb.1729770373.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_015657_931128_799DE9A2 
X-CRM114-Status: GOOD (  10.20  )
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

On Thu, 2024-10-24 at 21:09 +0900, Hajime Tazaki wrote:
>=20
> +#ifndef CONFIG_MMU
> +#include <asm-generic/bug.h>

Not sure that makes so much sense in the middle of the file, no harm
always having it?
>=20
> +static inline const struct user_regset_view *task_user_regset_view(
> +	struct task_struct *task)

What happened to indentation here ;-)

static inline const ..... *
task_user_regset_view(....)

would be far easier to read.

> +++ b/arch/x86/um/asm/module.h
> @@ -2,23 +2,6 @@
>  #ifndef __UM_MODULE_H
>  #define __UM_MODULE_H
> =20
> -/* UML is simple */
> -struct mod_arch_specific
> -{
> -};
> -
> -#ifdef CONFIG_X86_32
> -
> -#define Elf_Shdr Elf32_Shdr
> -#define Elf_Sym Elf32_Sym
> -#define Elf_Ehdr Elf32_Ehdr
> -
> -#else
> -
> -#define Elf_Shdr Elf64_Shdr
> -#define Elf_Sym Elf64_Sym
> -#define Elf_Ehdr Elf64_Ehdr
> -
> -#endif
> +#include <asm-generic/module.h>
> =20
>  #endif

That seems like a worthwhile cleanup on its own, but you should be able
to just remove the file entirely?

johannes

