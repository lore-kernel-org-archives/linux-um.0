Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A92BC4452B
	for <linux-um@archiver.kernel.org>; Mon, 20 Jul 2026 22:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OFKHaLiuiIMT2s5Bf3SZwWbn7++lylaBZHxfNpeM7Fk=; b=Se/Bea7QxdqKVxgdtlUfH+6zkY
	NKOK1dW3XREmrOdPYss6oJltboUNrEuiB2gkyXuapO1GWZPQX14M8kzPa48WdubNrruRVVd2LTVNg
	/XNbgb9Wx6RuTMkY1u7uPATOk1b01V4Gih7vsfhpzFjPJWL76ybOEXgqWGAjpwZwGuh/yZ26D6Ryc
	xgAyZK2lhrKch/72YyenDcZ/26hxvNxvnM82zcsY7DgTuyYVuU7E7R5A9S82GGcw4g0cPxX8O+tRg
	TcVfW8WvkZ6OFV1YF0jgZs26Ttcez0Q7POvLzDcuqIx/y05SISdOQ1gPTeti6TagNxIteJIyZlGhV
	hQfT/JOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlw39-00000007zfi-3aq3;
	Mon, 20 Jul 2026 22:01:23 +0000
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlw34-00000007zdW-3UGY
	for linux-um@lists.infradead.org;
	Mon, 20 Jul 2026 22:01:21 +0000
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-698bf053053so11991046a12.3
        for <linux-um@lists.infradead.org>; Mon, 20 Jul 2026 15:01:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784584875; cv=none;
        d=google.com; s=arc-20260327;
        b=AOtoFb5DfJ5qoZ9B2KZ++Rbe/oIAxS6ENFKwa+CP1Og3E91WYRLiRfBYeZyeZYgVU1
         40nsEOjgVfY70wAay6J/ieDxEIC2eOleMLZbyyxEclGREnRgBo935UsITboZWZ81EGYu
         DwjiQcDFs4XfdCVNAYgI31tTvkaSq14Fa1TBFNu9KfarEndqS4WHgZfr1MIOXN6FVyQf
         zlLTw7Z0Rd3Cz7zwAYVLI0TsTMNdjjptvymc3Z65UA6N5myGc7v9VhbF0VpNd1z/q1xp
         Z9oZatWaHsjkM1ESzSIfOrnwIhuWG0MLKzEzPhRMwod8YySNwCnfpqA5yErhO3G7DbbK
         PTqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OFKHaLiuiIMT2s5Bf3SZwWbn7++lylaBZHxfNpeM7Fk=;
        fh=nq/1CXUxYCNyykc+7T/6q+76WIr5QDy6i6nSA+Tm4Hk=;
        b=mzRBYQF7a0l2drgwxu4PLj+lBeK+WyfekHzd6kFcUF6Nu14AzHSwWxVmYNzi3hqgqn
         +GOSvBpUR7vvnOveIVUXX0iVT9i3twAdqG+1eESVdHiWXn9UR90d7FalAuYDIc3BR22z
         oxEbnuxD+qYq9Q3qHjfhwzMw7MqJ03oRqrPf5rNC8twcsjYUssRNtsnY+UopC0VtFC89
         rc9m2oE9l13k8QEm+4hYr8541idRhh2wKP5syyDs9UP7g6Ec6iqxKJOU8GF+nCNeKQOm
         AQS90KdeqWQQS2jrdi3RyKrh8BtbrpbZmKkRw0MpMXMF4IZ6pdFEhg03wFuS8pfu9TsP
         aSvg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784584875; x=1785189675; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OFKHaLiuiIMT2s5Bf3SZwWbn7++lylaBZHxfNpeM7Fk=;
        b=ATpqX8nFGkX06O96CHYqFHGEGRBgYNqOEPwq4kPkLTSA/Kydea1A9Sc86hGItNaha6
         4HIk3H628+93eLJ5+YBXaYoiAAiUUHCHF8luTOlUsnBAlwjppLn6QyHdKojpdENE5lZE
         51of4GqAr4KD1C3NHHAxAGQo6xJygmj7nHRv05PAZz+DxH8rsa4qbKEI2uubPT7176NW
         SbRDNm8g8BXN1ghIKeboyPKFQ6+lD6OVyej5AnWx+o+txvXNXIEW7IEKniuqHLN76uiw
         AuOGwvRVpBpYJUTgKj20JdcLcFG7wA8dm2yxsAJ5HpRBlUSYkf7qhiija3Ztu3vElrJJ
         cPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784584875; x=1785189675;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OFKHaLiuiIMT2s5Bf3SZwWbn7++lylaBZHxfNpeM7Fk=;
        b=dZhYtY158r+2l7nEZTVlotwtELcqkNlc1KbiwUI5gurLIVHVHjlM0d3pNU/l8JmTs6
         7f3qtitt5oVU7hSqCdTQ93HgA+FoV9mqwX4um3+wsQ3a4Q1GCztH4umQcJmdIh7dydpA
         HMCcYisTQAo2/4GU2osqu/sBwQzQnmEfsGw09/1xMEKwnPVlQWKB19kE64HfHRAms6nm
         2M9wsffBIF5FYLYFBHnyhHuCNbwPP3/Ew0frA0VAb2/ItU0P3wONCYi6HFmHJaakQ+cv
         XK90bpLHzDDljvOI/Ta+uS3gYpccYZczFvlJx/guz8ofvkInTTCSPA3wPfD7BZkCR1Zd
         NAag==
X-Forwarded-Encrypted: i=1; AHgh+RqV14l61pDW4vyJJgcvS/3tZNlk+0NrslDMO7e4+bkg+so6l80+NpqgbpdDlhSlduWK8i+ocnhCIg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyW423nNyt5XbdJ6XdzqTvYuYHH71r1Pl3QjIhkp51NQbXtBUhz
	RsAgtfiELuT8Vsa5enipkkj2OIvpcseIm3vi7JfN533x4h7+hwgkfn0skoq8+tnGCcxFmYh1s/V
	Hq3toqEZW0Mtu5VbTCUh372EJpdo6rEs=
X-Gm-Gg: AR+sD10CcOvT52rPXuoMBeU/zECFI4lIw2chJp03+LV2C8E2xEUlc/zj/+ak5tnzkdE
	NhsgKU2Hv8lzo2Q/tgQ+NiX39hdfwWFqlHBzC+5AFFQ4YUuvxDrHU02zImXyb+Wx2FnBeC0jgJE
	ihvjdnvkxcHmlEXWLisjsLIYkH54Ze0v0b8HHxET8U047x24zq3qCuuUYZKNnW+NkhtgZjJ4/+1
	9kZ1UbvaI38RtQm6U4CQWAg7BwdABxSFn3QGgEhTg6dNj31B9L+aXIaKfTLLIPZwk2xXD8fmSvF
	bD89AwPrajMj3oAXqaWhJ6JfOPdl85A=
X-Received: by 2002:a05:6402:2356:b0:674:5b2c:d42c with SMTP id
 4fb4d7f45d1cf-69e6525c770mr6536246a12.3.1784584875096; Mon, 20 Jul 2026
 15:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260707181957.433213175@kernel.org> <CA+=Fv5TDNH8+JAojV9_W36kUkEE68uiA00FQ7i0vJunebqs1sA@mail.gmail.com>
 <87wluplb6k.ffs@fw13>
In-Reply-To: <87wluplb6k.ffs@fw13>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Tue, 21 Jul 2026 00:01:03 +0200
X-Gm-Features: AUfX_mw5696pn_wiz_LjCaJHiFU9IchwhNNUbBWmuIdhtqSFIK3TJnj9-atYCBw
Message-ID: <CA+=Fv5Sd5+-K3-MOiEc2N8z_5CoLQPVPUwjiugSj3u8cBWJXXQ@mail.gmail.com>
Subject: Re: [patch 00/18] entry: Consolidate and rework syscall entry handling
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, linux-arm-kernel@lists.infradead.org, 
	linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-arch@vger.kernel.org, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_150118_916229_A7E61F08 
X-CRM114-Status: GOOD (  20.49  )
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

Thomas,

On Mon, Jul 20, 2026 at 9:21=E2=80=AFPM Thomas Gleixner <tglx@kernel.org> w=
rote:
>
>
> Similar to what Peter and me suggested in the related discussion
> vs. s390 which has a similar issue, you can just have a dedicated
> syscall_return member in your pt_regs struct, which is preset to -ENOSYS
> and operate on that. You have an unused padding entry there which means
> it won't even change the size.
>

Thanks, that makes sense in principle.

One complication is that my Alpha GENERIC_ENTRY branch already reuses that
former pt_regs padding slot, while keeping the pt_regs size and stack
alignment unchanged. The extra syscall-entry bookkeeping I needed so far li=
ves
in thread_info rather than adding more fields to pt_regs.

So the padding slot is not free in my current branch. I can still look at
whether a dedicated syscall_return scratch value would be cleaner, but the
tested version currently handles this by setting the default -ENOSYS result
only on the no-dispatch path, after generic entry processing, and only if
ptrace/seccomp/BPF did not already provide a return value.

>
> You were on CC for the V2, no?
>

Sorry, I must have missed that.

> The whole pile including Jinjie's seccomp bypass fix is in
>
>     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry
>
> and is targeted for the 7.3 merge window.
>

Great!

> If you want to base your stuff on that for 7.3, I can add a tag which
> makes it immutable so it can be pulled into the alpha tree.
>

Yes, please. There is still some ongoing testing/review of my Alpha
GENERIC_ENTRY series, but assuming it is ready in time for the 7.3 merge
window, an immutable tag would be very helpful.

Magnus

