Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCAACA101F
	for <linux-um@archiver.kernel.org>; Fri, 12 Sep 2025 13:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+ns7H8CB30PHzOE+CLH8DzyRO1n3rgJ84XgwC8jafww=; b=zfJCAcVGxdfdGg62JIJHOR6lrA
	PpJI9QYytIZzyz22WsmljAxeCbymlXNlKZf7oOP2pISGiJq7/oKSLI24ni1HZcNc8Eqw6D6XtXYp4
	Az5uqzMUjEkkgGqfu5wcowjbdWoEkNbxvrdD04YMXQYs1iUMrTqg9jfHmOmNzVpnYa7v44ovX7rKw
	/T+HzOqLBQCWiQPN97PxX0cZ9w7yqOH9KOmYFlcHZSLYtRkCJAZ+Suy2wNSiGm+zs4L2hG49Tx0di
	UENpnEOv05eVbtE7GLH/fVvtpTnsd8VXxiysu0Tbi9Yz/VKyQY3TiA7bGypu72u05ji2krYz2CGTP
	/4I6HO+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ux3pW-00000009ZCA-1cf2;
	Fri, 12 Sep 2025 13:28:46 +0000
Received: from out-179.mta1.migadu.com ([2001:41d0:203:375::b3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ux3pU-00000009Z4N-05MZ
	for linux-um@lists.infradead.org;
	Fri, 12 Sep 2025 13:28:45 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757683707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ns7H8CB30PHzOE+CLH8DzyRO1n3rgJ84XgwC8jafww=;
	b=cmWWpW59hiaPFvHb/tGmBvinl/fxs1nqNO9wiy6G69d+tDQBnuBciv/B3Dr9Mpj7+ZI2Ss
	O3oYzUtE9RXp9zt/xTaG2IMtocMombghGby2kJxyQOECQwdkXsvil/kc1KWbbNyVo/n06D
	gnkn0OmpK90PoogBSiBmEnOVscCQHII=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: benjamin@sipsolutions.net
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	arnd@arndb.de,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: Re: [PATCH v2 04/10] um: Turn signals_* into thread-local variables
Date: Fri, 12 Sep 2025 21:27:53 +0800
Message-Id: <20250912132753.2651038-1-tiwei.bie@linux.dev>
In-Reply-To: <250234d1acd54553bf5f55972d9b05cfccb2cfab.camel@sipsolutions.net>
References: <250234d1acd54553bf5f55972d9b05cfccb2cfab.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250912_062844_201785_D1F62319 
X-CRM114-Status: GOOD (  23.52  )
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

On Fri, 12 Sep 2025 09:58:49 +0200, Benjamin Berg wrote:
> On Fri, 2025-09-12 at 08:30 +0800, Tiwei Bie wrote:
> > On Thu, 11 Sep 2025 10:06:53 +0200, Benjamin Berg wrote:
> > 
> > > [SNIP]
> > > That said, I do believe that the allocations from the libc itself are
> > > problematic. A lot of the mappings from UML are there already (i.e. the
> > > physical memory is mapped). However, I believe the vmalloc area for
> > > example is not guarded.
> > > 
> > > So when pthread allocates the thread specific memory (stack, TLS, ...),
> > > we really do not know where this will be mapped into the address space.
> > > If it happens to be in an area that UML wants to use later, then UML
> > > could map e.g. vmalloc data over it.
> > > 
> > > Now, it could be that (currently) the addresses picked by pthread (or
> > > the host kernel) do not actually clash with anything. However, I do not
> > > think there is any guarantee for that.
> > 
> > Indeed. The mmap from libc (pthread, shared libs, ...) can potentially
> > conflict with UML. The reason it has been working on x86_64 so far might
> > be that we did this in linux_main():
> > 
> > 	task_size = task_size & PGDIR_MASK;
> > 
> > The current layout is:
> > 
> > shared libs and pthreads are located at 7ffxxxxxxxxx
> > TASK_SIZE                             = 7f8000000000
> > VMALLOC_END                           = 7f7fffffe000 (which is TASK_SIZE-2*PAGE_SIZE)
> 
> Uh, right, yes. Because of the masking we are capping ourselves to
> 0x7f8000000000. And then all of the interesting bits (vdso, ...) happen
> to be mapped above that address and are effectively protected. And,
> there is also plenty of space for other allocations technically.
> 
> That is kind of horrible, as it only works because all of this happens
> to be mapped into the top of the address space.

+1.

> But, maybe something to
> just wilfully ignore and only fix as part of a nolibc port?

Sure. Thanks!

Regards,
Tiwei

