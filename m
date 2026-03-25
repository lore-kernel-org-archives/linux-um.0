Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D673FEC0F4
	for <linux-um@archiver.kernel.org>; Wed, 25 Mar 2026 01:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XPVOLvrIIEOfu5g5CChI9oR0hIwo1hqCCzApx/PbUc0=; b=qNzXSWTT7gDnIi+iOHi1tSLqod
	kYgmXQFNB8GGrYfBOve2u1a/XSG9gnTC03LYYaq3nD0x8t961nRy5K5oHBPrPaY8HIdpKyz1E6dlE
	5SNxLt5HvN8MYHnD5ATGDvgrrgJBRl9qvabpGbsj/K4yHuhmdRhZwqxJFSRMmWjlkcGqp9Kqo+Fga
	jjwUokY/y0KvfYkyRv27hz6KU3bM+gN3gWNIeOo6agd8UBJyBBPaM1Jo/Hgyz7iVCJT2OVmIHi8PI
	ozFbPNWCGq2z0nU8/dInKWlS4Q8FKTHOFv589ticwTXmkughv7XnVa0Tb06UF3TVWYwJXBR2WSyzQ
	wzoEXnuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5CfR-00000002Qx0-13xE;
	Wed, 25 Mar 2026 01:04:17 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5CfO-00000002Qw3-311o
	for linux-um@lists.infradead.org;
	Wed, 25 Mar 2026 01:04:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id F310D43F65;
	Wed, 25 Mar 2026 01:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B7AC19424;
	Wed, 25 Mar 2026 01:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774400652;
	bh=xuio0iUNCd9Dsa7TTkNCacQ8OxsZcaqyEFOvTKUEK6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N+IXTww2TQ6aT0wzvLKu3u2se94ZDbvY9MgeE8OZ/jn6e3j/Wgp8Y+DZNoOr7GRKJ
	 Rz0KgBmWU8vuOpjZf+xalWcZ4/unyUJAKlIsQ+bCAP1vRgxlwgSJSuxyRS5xmjauvq
	 gxgwPnswNQnKs+TLKkywzsgN6X3+jOkuU6dsDxdBa1hL+/E0l1TW7JBPn7XsQL+qE3
	 9Ctk/M+DkzLcPVDfowZ5GxDIrx5iEHhNsmww7j0NBpCixDeuEKH4NSY+115Cvy4fQx
	 cbUeBsTbznRc00Da62Hj0py6zFCXymI73KJoMa27lzFxg9GYXj8QcsCJOcQUOVdcbt
	 4EmnvPD2x68Mg==
From: Miguel Ojeda <ojeda@kernel.org>
To: gregkh@linuxfoundation.org
Cc: achill@achill.org,
	akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	hargar@microsoft.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@nabladev.com,
	rwarsow@gmx.de,
	shuah@kernel.org,
	sr@sladewatkins.com,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Miguel Ojeda <ojeda@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH 6.18 000/212] 6.18.20-rc1 review
Date: Wed, 25 Mar 2026 02:04:01 +0100
Message-ID: <20260325010401.62938-1-ojeda@kernel.org>
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260324_180414_778094_C78B8F1D 
X-CRM114-Status: GOOD (  12.59  )
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

On Mon, 23 Mar 2026 14:43:41 +0100 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.20 release.
> There are 212 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 25 Mar 2026 13:44:33 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

For UML, I am seeing:

    In file included from kernel/fork.c:108:
    In file included from ./include/linux/unwind_deferred.h:6:
    In file included from ./include/linux/unwind_user.h:6:
    ./arch/x86/include/asm/unwind_user.h:23:12: error: no member named 'flags' in 'struct pt_regs'
       23 |         if (regs->flags & X86_VM_MASK)
          |             ~~~~  ^
    ./arch/x86/include/asm/unwind_user.h:23:20: error: use of undeclared identifier 'X86_VM_MASK'
       23 |         if (regs->flags & X86_VM_MASK)
          |                           ^
    ./arch/x86/include/asm/unwind_user.h:26:7: error: call to undeclared function 'user_64bit_mode'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
       26 |         if (!user_64bit_mode(regs))
          |              ^

We probably need at least:

  aa7387e79a5c ("unwind_user/x86: Fix arch=um build")

Or perhaps the split of the guards added later.

Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>

Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org

I hope that helps!

Cheers,
Miguel

