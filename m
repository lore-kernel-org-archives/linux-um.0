Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF11F8FA88
	for <linux-um@archiver.kernel.org>; Tue, 21 Apr 2026 15:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wvINAongtjjCgb6wY+xC1FvDJfOPl2KahZDKoEuClv4=; b=PUF6EJHYCKwZxlQ6NAGbx3hZq4
	DeDwXhvBk9PDH3wiCyOabZsvxzBMcj49R37i70NIa/ZCuK5ZBLqg4GXgl8+oH1L508HIxgN7DiAs6
	i+0MH3n7bpRw1ZUBC8dQVN6bXuvV8A3hKKiDEZgeVUCdHC+wtj1dweuWd0+Zk9+06gjKMeTHUYB9w
	iceChlIPjbTd50lhzJ6qZYsNlb4elzOdiiADOwhySQV7f/nWV2lcvX4bf2ujTcCu5gHoqdjKFXTAP
	/6nv/VpCQONCcmFxHIGchf6aQ5HTtH59GIXZFZrKSNTnqJRJEdHx1dh2b6PQlojN7f916VX8NUc7Z
	Edw5csAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFCcJ-00000008oJ4-15jD;
	Tue, 21 Apr 2026 15:02:23 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFCcH-00000008oIx-3gXE
	for linux-um@lists.infradead.org;
	Tue, 21 Apr 2026 15:02:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 03C0F6001A;
	Tue, 21 Apr 2026 15:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D904C2BCB0;
	Tue, 21 Apr 2026 15:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776783740;
	bh=Mpbkj6yOe1GN3X5YpgKdXjzi0Cn1sKwaB2ZCYJvR0x0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WmXxT4bq/jdUGylFLv9mGVtoKFbMm7IOdxmOVuBB4b28dU69dWhDMkm+T9Q+DWJ0r
	 CVQJzqTUXa6/q+rkvq9bnfrBbUn2y7JSgNuJU5z3RSSkWOMVzFV2Dpkzi03eVVa2xx
	 3K1hHh/TFZ0xkeDU+lUw3kmjwigck9NeVyuP/fWA=
Date: Tue, 21 Apr 2026 17:02:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: achill@achill.org, akpm@linux-foundation.org, broonie@kernel.org,
	conor@kernel.org, f.fainelli@gmail.com, hargar@microsoft.com,
	jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
	linux@roeck-us.net, lkft-triage@lists.linaro.org,
	patches@kernelci.org, patches@lists.linux.dev, pavel@nabladev.com,
	rwarsow@gmx.de, shuah@kernel.org, sr@sladewatkins.com,
	stable@vger.kernel.org, sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Sasha Levin <sashal@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
	rcu@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH 6.18 000/198] 6.18.24-rc1 review
Message-ID: <2026042155-handcuff-stunner-1318@gregkh>
References: <20260420153935.605963767@linuxfoundation.org>
 <20260421095549.47476-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421095549.47476-1-ojeda@kernel.org>
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

On Tue, Apr 21, 2026 at 11:55:49AM +0200, Miguel Ojeda wrote:
> On Mon, 20 Apr 2026 17:39:39 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.18.24 release.
> > There are 198 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 22 Apr 2026 15:38:57 +0000.
> > Anything received after that time might be too late.
> 
> Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
> for loongarch64:
> 
> Tested-by: Miguel Ojeda <ojeda@kernel.org>
> 
> For UML (x86_64) I am seeing:
> 
>     In file included from arch/um/kernel/asm-offsets.c:3:
>     In file included from ./arch/x86/um/shared/sysdep/kernel-offsets.h:5:
>     In file included from ./include/linux/crypto.h:18:
>     In file included from ./include/linux/slab.h:16:
>     In file included from ./include/linux/gfp.h:7:
>     In file included from ./include/linux/mmzone.h:1538:
>     In file included from ./include/linux/memory_hotplug.h:7:
>     In file included from ./include/linux/notifier.h:16:
>     In file included from ./include/linux/srcu.h:59:
>     ./include/linux/srcutiny.h:14:10: fatal error: 'linux/irq_work_types.h' file not found
>        14 | #include <linux/irq_work_types.h>
>           |          ^~~~~~~~~~~~~~~~~~~~~~~~
>     1 error generated.
> 
> Caused by commit 95721c9fb3a1 ("srcu: Use irq_work to start GP in tiny
> SRCU"). The header seems to simply not be there, i.e. either the
> `#include` is changed or commit c809f081fe40 ("irqwork: Move data struct
> to a types header") is backported.
> 
> Cc: Joel Fernandes <joelagnelf@nvidia.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Boqun Feng <boqun@kernel.org>
> Cc: Sasha Levin <sashal@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Zqiang <qiang.zhang@linux.dev>
> Cc: rcu@vger.kernel.org
> 
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: linux-um@lists.infradead.org

Thanks, I'll just drop this commit from 6.18 and older trees for now.

greg k-h

