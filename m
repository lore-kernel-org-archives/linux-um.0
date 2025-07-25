Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A955C87FCE
	for <linux-um@archiver.kernel.org>; Fri, 25 Jul 2025 12:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qp0FR4UyItNaK0TRhYPgeWY1WUABO6EmhJjCYjThBXo=; b=UvNrFTcH6QyHB8qE+gtwPAkQsp
	DrfgWwIqwoKQiNVqbtUlHuLVjyfA3y//Fh+/xgvE6TaFbJV2z0OEGbAlzssWTonORB3ju+c4lb3wa
	u3pmMv8tT4AcVnuS5akIecVKcMr2HDDB/K5heUflcBP3UDBp7enOOT4NvYpoN/q3ASnhUEPfvrab2
	R0EYMVbKY3QcUrAf5toP1EmJ8fpZG8K7e1gfZAIqXLNGG8kQB6GD3poTtQtPxUfP7h6ENDjBdwOh4
	VIwDv0GBMQ5oSvazBvjVJGqkveQ0Dz01cRGwxuWMKS9CgfV/juB1rwWq5JJ03ayHwoXHQ5ODR6NYU
	MVfEysaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufH8n-00000009mIu-3YPX;
	Fri, 25 Jul 2025 12:03:09 +0000
Received: from out-180.mta0.migadu.com ([91.218.175.180])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufGp0-00000009jxZ-1YpD
	for linux-um@lists.infradead.org;
	Fri, 25 Jul 2025 11:42:43 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753443745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qp0FR4UyItNaK0TRhYPgeWY1WUABO6EmhJjCYjThBXo=;
	b=dYEth2oZ+c/yBgpOKbWhge9d7R7cFqF32OIsg9yCXJEijhNYbVWmLK9V8y2mBu76f3zQhp
	/g3oFRbB8upgbFu6SkAquKLwwgoVtbn+J6PYRblHF6YeoF36laIrFs7mu8s7JiblqihZW/
	iGL4vRqL0ZLnNIkCLQcRFTyBFwCbreU=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard.weinberger@gmail.com
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: Re: [RFC PATCH 0/4] um: Add SMP support
Date: Fri, 25 Jul 2025 19:42:04 +0800
Message-Id: <20250725114204.1122115-1-tiwei.bie@linux.dev>
In-Reply-To: <CAFLxGvxiCzLEYX2yuexgidUZ1fgtF5F988X2Cz4L_7ni1JYKXA@mail.gmail.com>
References: <CAFLxGvxiCzLEYX2yuexgidUZ1fgtF5F988X2Cz4L_7ni1JYKXA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250725_044242_555248_EA5AD645 
X-CRM114-Status: GOOD (  16.10  )
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

On Thu, 24 Jul 2025 23:21:49 +0200, Richard Weinberger wrote:
> On Sun, Jul 13, 2025 at 7:25 PM Tiwei Bie <tiwei.bie@linux.dev> wrote:
> > Here are some steps to try out SMP support in UML:
> >
> > 1. Build UML with CONFIG_SMP=y and, for example, CONFIG_NR_CPUS=8.
> >
> > 2. Launch a UML instance with, for example, 8 virtual CPUs.
> >
> >  $ ./linux mem=16G ncpus=8 nohz=n seccomp=on init=/bin/sh \
> >            ubd0=$your_rootfs_image
> 
> That's pretty cool! The implementation looks *much* simpler than I
> have expected.

Thanks! :)

> 
> Can you please explain a little more the details behind it?
> e.g. Why ptrace is not supported?
> Does it support true SMP (IOW SMP within the kernel)?

Yeah, SMP within the kernel is supported. SMP across different
guest processes is also supported. Currently, the limitation is
that multi-threading within the same guest process doesn't support
true SMP in userspace, as it would require converting the stub into
a multi-threaded implementation. Technically, ptrace could also be
supported, but it would require redesigning the stub as well.

The general design is that each UML virtual CPU is represented as
a host thread. Similar to other architectures, the kthreads and
normal threads (when running in kernel mode) can be scheduled and
executed simultaneously on these CPUs (i.e., on these host threads).
However, the userspace code of normal threads still runs within
their corresponding single-threaded stubs (there is a bug in this
part in this series, which will be fixed in the next version).

> 
> I gave it a try on my machine and noticed that the UML process eats a
> lot of CPU time
> on the host side.
> Tracing showed that some (not all) CPU threads perform these syscalls
> over and over:
> rt_sigprocmask(SIG_UNBLOCK, 0xe081bdf0, NULL, 8) = 0
> rt_sigprocmask(SIG_BLOCK, 0xe081bdf0, 0xe081be70, 8) = 0
> timer_gettime(2, 0xe081bdd0)

Sorry for the confusion. That was a bug. I've fixed it. I'll send out
the new version this weekend.

Regards,
Tiwei

