Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12E1F8925C
	for <linux-um@archiver.kernel.org>; Tue, 21 Apr 2026 11:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lFeteiYg9QeDvk8T1N18atyupocQdS9GNRfR8QKBIAo=; b=uqGGMpsCwpO1bFZLOYqQKYyaOr
	qK1hWmW5f+w1NDmdFSB5Q7oWSJITtlip1kIqZ0lJI9IegRRqEblTjL5TPFOZYTzjbdTvbMKDu9x04
	IllOyn1TGhTxh7C0TCQcsGTgWTWX9MVYbyMZKimSgAKdpd6DpluUEpioh3tnd4WDvWHT9uCkamMc0
	GcdZEvghYCaaI7V6mk3qiJItWlt5PWYkTFWYs5nIVzmH85pYXAH1X75f1tVxMHMLHm9i9J5ZLjfHL
	rN9t72KI2imeo89W+OWf57DkyPJU69SYiWdxezNmZlAiIC7HsQFHwT9VlGFyV7NbJpy94i1MMu2WF
	ea/Lb6qA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wF90t-00000008Um3-0P2J;
	Tue, 21 Apr 2026 11:11:31 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wF90q-00000008Ulh-1seW
	for linux-um@lists.infradead.org;
	Tue, 21 Apr 2026 11:11:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id F0F79400FB;
	Tue, 21 Apr 2026 11:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE79C2BCB0;
	Tue, 21 Apr 2026 11:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776769885;
	bh=EUCP/+wIyjuuFsUEyg5Q933mW+t/e6mkILgKhGl+IIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mbTl5fZmFcBU5tYSBryBs6wfkQxkyJwj6zyC9pv83aHjCcgTKfCMDZvGFMkDuU5A8
	 FEnCZSkBSXWx7s41ioY+4hZWiFYS3HyvH2KUpE0J4zHqjwCFVAikqd9ls4kf0p93uV
	 BZak5ObgHRI9Gxu2aKoK1xpo0pjI/eK1Qi77TQPVg+lHlyGT76wc8+TYtiUNgglqnP
	 reWN6chojkAvkicTb3bYEJxcMTmtW9mRJU6A5qRwtb8+SSE7sxmag/RuUnPPB0+fFX
	 z3j1boww3uG48U2bRYLly9Jab3TxwKWU/BzeGfn1EE0uhf0439miKf5/fwkDNvksIU
	 k956mzhJQQp0A==
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
	Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	rcu@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	Benno Lossin <lossin@kernel.org>,
	Gary Guo <gary@garyguo.net>
Subject: Re: [PATCH 6.12 000/162] 6.12.83-rc1 review
Date: Tue, 21 Apr 2026 13:11:11 +0200
Message-ID: <20260421111111.57059-1-ojeda@kernel.org>
In-Reply-To: <20260420153927.006696811@linuxfoundation.org>
References: <20260420153927.006696811@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260421_041128_551014_A165627C 
X-CRM114-Status: GOOD (  15.06  )
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

On Mon, 20 Apr 2026 17:40:32 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.83 release.
> There are 162 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 22 Apr 2026 15:38:55 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

For UML (x86_64), I am also seeing the same issue as for 6.18.y:

    ./include/linux/srcutiny.h:14:10: fatal error: 'linux/irq_work_types.h' file not found
       14 | #include <linux/irq_work_types.h>
          |          ^~~~~~~~~~~~~~~~~~~~~~~~

Please see the details at:

    https://lore.kernel.org/stable/20260421095549.47476-1-ojeda@kernel.org/

Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Zqiang <qiang.zhang@linux.dev>
Cc: rcu@vger.kernel.org

Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org

We also still have the many missing safety comments Clippy warnings we
recently discussed:

    warning: unsafe block missing a safety comment
        --> rust/kernel/init/macros.rs:1015:25

Benno/Gary: I am tempted to just `#![allow(...)]` them for now (but if
you plan to add the comments soon, please let me know!).

Cc: Benno Lossin <lossin@kernel.org>
Cc: Gary Guo <gary@garyguo.net>

Thanks!

Cheers,
Miguel

