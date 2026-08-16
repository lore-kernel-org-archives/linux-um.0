Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA920C5DF66
	for <linux-um@archiver.kernel.org>; Sun, 16 Aug 2026 19:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ax9QAkqjq8ZT8lYEqGiad9tvtGJKVe529ycKM6j5uUc=; b=4VCB0enECPZplrTwZCWJoYEYWc
	bDfZTezt/Hu0BFB5p1zFRJbafgSxaFzhya7g0OI7K+AZ2xNlWkURPKtBV7fnAdEk3dAAl5fAiZVbL
	GqBYzMNrqydo+k8iwk11k1JnuryH/I/WT/Cj1o8fedY7oUrLm+KR/y2zQngp1gBIVTxVJMKQ3KVWb
	7NVkGjEi+Qd8sY2fqdmCYlDJ24O5RAvlvz20lVupf9IsIMIr4oU0OCwn/XXg5dGbc5oEMeA/raXID
	3hMi7IhgaDJgmUMzGU7V/Sern/zxhTjxatZ/bR8FfNM3dwuwYPVaaLeDWqnhr0vqFwmCGw5Oj3Mty
	FBV+Py0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvgoa-000000052ja-1DmT;
	Sun, 16 Aug 2026 19:46:40 +0000
Received: from mailout.nod.at ([116.203.167.152] helo=lithops.sigma-star.at)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvgoV-000000052j3-4AEW
	for linux-um@lists.infradead.org;
	Sun, 16 Aug 2026 19:46:38 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 465262698F9;
	Sun, 16 Aug 2026 21:46:24 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id bh5QazcZrNNR; Sun, 16 Aug 2026 21:46:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id BE8882698FA;
	Sun, 16 Aug 2026 21:46:23 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xuMQ8NcWvSU7; Sun, 16 Aug 2026 21:46:23 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 9C5442698F8;
	Sun, 16 Aug 2026 21:46:23 +0200 (CEST)
Date: Sun, 16 Aug 2026 21:46:23 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: contact@zalexdev.com
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-um <linux-um@lists.infradead.org>
Message-ID: <1076510330.148098.1786909583435.JavaMail.zimbra@nod.at>
In-Reply-To: <afe5075686534c5c781e93c19fe77d28@zalexdev.com>
References: <afe5075686534c5c781e93c19fe77d28@zalexdev.com>
Subject: Re: [RFC] um: an arm64 subarch for User Mode Linux
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF153 (Linux)/8.8.12_GA_3809)
Thread-Topic: an arm64 subarch for User Mode Linux
Thread-Index: 8eghKM0bfQMwyYhQH8j0R3/QLDuMNw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260816_124636_337946_4D8C7F5C 
X-CRM114-Status: GOOD (  21.26  )
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

----- Urspr=C3=BCngliche Mail -----
> Von: contact@zalexdev.com
> I have ARCH=3Dum SUBARCH=3Darm64 working -- 33 patches on uml/next. Befor=
e
> sending that many to the list I would like to know if it is wanted, and
> in
> what shape.
>=20
>   https://github.com/zalexdev/linux-um-arm64   (branch um-arm64)
>=20
> Boots Alpine and Debian at 4K and 16K pages, SECCOMP and ptrace
> userspace,
> loadable modules.

Nice. :-)
=20
> The part I want an opinion on is syscall interception on hosts without
> PTRACE_SYSEMU, since 5.3 is a recent floor for arm64 and phones ship
> 4.19.
> There the guest syscall is cancelled by writing -1 to NT_ARM_SYSTEM_CALL
> at
> a PTRACE_SYSCALL stop. That fails under a seccomp filter, though: arm64
> reports the ptrace stop before running seccomp, so the filter sees the
> -1
> and an Android app sandbox kills the tracee. So the third path
> substitutes
> getppid(2) for the guest's call -- the call still does not run, but a
> syscall does execute on the guest's behalf. Is that acceptable? nosysemu
> and nocancel select the fallbacks on any host, so they are testable
> without a 4.19 machine.

Well, it's reasonable to require a non-ancient host kernel.

> Modules reuse arch/arm64/kernel/module.c and module-plts.c instead of a
> second copy, the way arch/x86/um does. That does mean pulling two files
> out
> of arch/arm64.
>=20
> Two changes are performance only. The stub handoff skips FUTEX_WAKE when
> nobody is parked and spins against CNTVCT_EL0 before parking; anonymous
> faults are batched onto the handoff that was happening anyway.
> Snapdragon
> 870, SECCOMP mode, medians of 7 interleaved rounds:
>=20
>   syscall  9.841 -> 1.987 us
>   openat  20.223 -> 4.501 us
>   fault   24.592 -> 11.076 us
>=20
> Known problems: no 32-bit compat, UP only, and "BUG: Bad rss-counter
> state
> ... type:MM_FILEPAGES val:1" once per exiting process under Debian but
> not
> under Alpine on the same kernel. I have not found that one and would not
> expect it merged as is.
>=20
> About a third of the patches are not arm64 -- generic um/ fixes and two
> x86
> ones, including a missing 32-bit stub_seccomp_save_state -- but they sit
> on
> top of the subarch commit and do not apply alone. I can rebase them into
> a
> separate series first if that is more useful.
>=20
> I cannot commit to maintaining this long-term. Happy to respin or split
> it
> however you want; say the word and I will send the series with
> git send-email.

Patches are welcome, but don't expect others to do the hard work.

Thanks,
//richard

