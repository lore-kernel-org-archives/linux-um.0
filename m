Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B54FD0C5EC
	for <linux-um@archiver.kernel.org>; Fri, 25 Oct 2024 09:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s+rptcQVLk5AQCLqm4kCtfbCihoYFUVCdCtGR5skrh4=; b=hwUzSTybtu9u6JtCu7y+f4ol3D
	lWCpyzq1Vj5o7OxceO05vh19S0Frz4yGHKW0w7yx3DOcjkMvqSLzaRphB3ZjTpDWSZM/HrUYCeY/q
	50Djw18rzBE/PS+mME1//VbBkAwzHhXq1fvadW/+s1MEHf5PmRgDgl18OCRqpjhllpokmHevRAb+i
	iRKP/52JHF61BDUVrstzVu4C0IFieFkrxzEBygc1z6Do+O0jyvHKKft4lZyjP2QTywkIm2114eTTF
	4sCendexVy6oNu+TFfjna1h3313eBdLxpUbclf+3YBKM4Fmnhf7uPeJIdYRGpmOYsCF2S7jypU2ex
	kVFeyxKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4GOo-000000037wU-08QG;
	Fri, 25 Oct 2024 09:14:26 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4GOl-000000037vg-2pBJ
	for linux-um@lists.infradead.org;
	Fri, 25 Oct 2024 09:14:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=s+rptcQVLk5AQCLqm4kCtfbCihoYFUVCdCtGR5skrh4=;
	t=1729847663; x=1731057263; b=gzqUF3CUGv2PjbP/LqVVd1repnu8jOZRBEYKH82pGaN/cbB
	nx1AKbC4HnYdFG7nxwc58oy1ZgGNukO6Uo8A+OB5zDGMHQjMpE8ppQ9vO/TymvLsEQq5uaX9TLWsn
	zB7lYEfjMFs3SHF1bT+D+pc7Lci3gQK115pAUfb45OMPPqaUdj/EvW8hGcM7hRbEErUX8jhiiZDuZ
	kWV9QYtUAcADNrrmj3G4HCoHkDDAdCqvh1X4fb6oeQATz+hm7QnWHcqIl2cae97EMjoIVel7FQfYb
	ZOmUo2N2LfE1p8H4dZlI8U4iqaAHzTOYUDbqRO4Zc1lV0y4/x0y2FJSb63FjbsAg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t4GOj-00000004SHO-0LIp;
	Fri, 25 Oct 2024 11:14:21 +0200
Message-ID: <c845db1d921d42f969a6a7ff6ce76f76aa901ed3.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 04/13] x86/um: nommu: syscall handling
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org, 
	jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: ricarkol@google.com
Date: Fri, 25 Oct 2024 11:14:19 +0200
In-Reply-To: <1a39a239b4a34d2f613ab1ffc62c80967a2f57fb.1729770373.git.thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
	 <1a39a239b4a34d2f613ab1ffc62c80967a2f57fb.1729770373.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_021423_741282_E47BDBCF 
X-CRM114-Status: UNSURE (   8.79  )
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

On Thu, 2024-10-24 at 21:09 +0900, Hajime Tazaki wrote:
>=20
> +++ b/arch/x86/um/do_syscall_64.c
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/kernel.h>
> +#include <linux/ptrace.h>
> +#include <kern_util.h>
> +#include <sysdep/syscalls.h>
> +#include <os.h>
> +
> +#ifndef CONFIG_MMU

This seems unnecessary, you don't build the file with CONFIG_MMU in the
first place.

> +++ b/arch/x86/um/entry_64.S
> @@ -0,0 +1,88 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <asm/errno.h>
> +
> +#include <linux/linkage.h>
> +#include <asm/percpu.h>
> +#include <asm/desc.h>
> +
> +#include "../entry/calling.h"
> +
> +#ifdef CONFIG_SMP
> +#error need to stash these variables somewhere else
> +#endif
> +
> +#ifndef CONFIG_MMU

same here.

> +++ b/arch/x86/um/shared/sysdep/syscalls_64.h
> @@ -25,4 +25,8 @@ extern syscall_handler_t *sys_call_table[];
>  extern syscall_handler_t sys_modify_ldt;
>  extern syscall_handler_t sys_arch_prctl;
> =20
> +__visible void do_syscall_64(struct pt_regs *regs);
> +extern long __kernel_vsyscall(int64_t a0, int64_t a1, int64_t a2, int64_=
t a3,
> +			      int64_t a4, int64_t a5, int64_t a6);
> +
>=20

but maybe that should be ifdef'ed?

johannes

