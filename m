Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4550CAC58E
	for <linux-um@archiver.kernel.org>; Fri, 12 Sep 2025 00:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EZxU73zTx/9g+dWjgY/xVOQON0jaT8APRpXiMYNVZyc=; b=HcKpO9Gm22JYa7McETKeYDnGno
	CVDR8mCSLFnyCO04p54eFRiNOdwWpM2x+TJMc9K3LmWl3S4NC/JeDV+gSwrODf2Y+IrF6yu8RzqYQ
	W5LD4xVXxmeMjLTP7MVHnIJocFXw2Q3fOcCFX89Jy9eHzF84JuWKOoWeaTSZRJ5i8oKy+t900hFv4
	5pbythMhTqmx26kk9UtHmwv6U46L0cGCBmWSVJl9uP7ee7JmAJ2Q5rWLI7vYUY68sVujwzbZfEWuC
	zTaWhKVkyGg5kYyCU3o1xzNtpt1qo2ENXNvlpXd4oH63YiN9HPRdUQj28ZEq77z2Bhy3/1gUWTIa8
	qXL3G7ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwrhE-000000065Mu-2bnE;
	Fri, 12 Sep 2025 00:31:24 +0000
Received: from out-178.mta0.migadu.com ([2001:41d0:1004:224b::b2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwrhA-000000065MU-3B6R
	for linux-um@lists.infradead.org;
	Fri, 12 Sep 2025 00:31:23 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757637074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EZxU73zTx/9g+dWjgY/xVOQON0jaT8APRpXiMYNVZyc=;
	b=hpNzexgmJhu8VyBysEyHt3YLiXdHNjA6/43xJrjFF8XDfRdNDiA2za4rG6vaCf9mrodWZ1
	Rsb69FTkg9bMCXFpWE0BoJ1zXFLXrGYoKGHtF9zqYP7wp1wsNW9pLMG5AFpDIRfS95o7Cd
	HxvnJBa910jt61gODQpFumI47JnXbsI=
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
Date: Fri, 12 Sep 2025 08:30:54 +0800
Message-Id: <20250912003054.2564842-1-tiwei.bie@linux.dev>
In-Reply-To: <75ba2109fcdfb8a1629fdf5f6b4e58694b975c9f.camel@sipsolutions.net>
References: <75ba2109fcdfb8a1629fdf5f6b4e58694b975c9f.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_173121_345932_3BE709BD 
X-CRM114-Status: GOOD (  26.47  )
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

Hi,

On Thu, 11 Sep 2025 10:06:53 +0200, Benjamin Berg wrote:
> On Thu, 2025-09-11 at 09:37 +0200, Benjamin Berg wrote:
> > On Thu, 2025-09-11 at 12:34 +0800, Tiwei Bie wrote:
> > > On Wed, 10 Sep 2025 14:15:28 +0200, Johannes Berg wrote:
> > > > On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> > > > > From: Tiwei Bie <tiwei.btw@antgroup.com>
> > > > > 
> > > > > Turn signals_enabled, signals_pending and signals_active into
> > > > > thread-local variables. This enables us to control and track
> > > > > signals independently on each CPU thread. This is a preparation
> > > > > for adding SMP support.
> > > > 
> > > > [...]
> > > > 
> > > > > +static __thread int signals_enabled;
> > > > 
> > > > How much glibc infrastructure does __thread rely on? More
> > > > specifically:
> > > > Some time ago we had a discussion about building UML as a nolibc
> > > > binary,
> > > > what would that mean for the __thread usage here?
> > > 
> > > We would need to parse TLS data (PT_TLS) from the ELF file
> > > ourselves
> > > and properly set up TLS when creating threads using clone().
> > 
> > I guess right now we cannot use PER_CPU variables in these files.
> > However, my expectation that this is possible when using nolibc, and
> > then it should be simple enough to replace the __thread.

Good idea!

> 
> That said, I do believe that the allocations from the libc itself are
> problematic. A lot of the mappings from UML are there already (i.e. the
> physical memory is mapped). However, I believe the vmalloc area for
> example is not guarded.
> 
> So when pthread allocates the thread specific memory (stack, TLS, ...),
> we really do not know where this will be mapped into the address space.
> If it happens to be in an area that UML wants to use later, then UML
> could map e.g. vmalloc data over it.
> 
> Now, it could be that (currently) the addresses picked by pthread (or
> the host kernel) do not actually clash with anything. However, I do not
> think there is any guarantee for that.

Indeed. The mmap from libc (pthread, shared libs, ...) can potentially
conflict with UML. The reason it has been working on x86_64 so far might
be that we did this in linux_main():

	task_size = task_size & PGDIR_MASK;

The current layout is:

shared libs and pthreads are located at 7ffxxxxxxxxx
TASK_SIZE                             = 7f8000000000
VMALLOC_END                           = 7f7fffffe000 (which is TASK_SIZE-2*PAGE_SIZE)

However, on i386, the risk of conflicts looks much higher:

TASK_SIZE   = ffc00000
VMALLOC_END = ffbfe000

......
f7c00000-f7c20000 r--p 00000000 08:01 9114                               /usr/lib32/libc.so.6
f7c20000-f7d9e000 r-xp 00020000 08:01 9114                               /usr/lib32/libc.so.6
f7d9e000-f7e23000 r--p 0019e000 08:01 9114                               /usr/lib32/libc.so.6
f7e23000-f7e24000 ---p 00223000 08:01 9114                               /usr/lib32/libc.so.6
f7e24000-f7e26000 r--p 00223000 08:01 9114                               /usr/lib32/libc.so.6
f7e26000-f7e27000 rw-p 00225000 08:01 9114                               /usr/lib32/libc.so.6
f7e27000-f7e31000 rw-p 00000000 00:00 0 
f7fbe000-f7fc0000 rw-p 00000000 00:00 0 
f7fc0000-f7fc4000 r--p 00000000 00:00 0                                  [vvar]
f7fc4000-f7fc6000 r-xp 00000000 00:00 0                                  [vdso]
f7fc6000-f7fc7000 r--p 00000000 08:01 9107                               /usr/lib32/ld-linux.so.2
f7fc7000-f7fec000 r-xp 00001000 08:01 9107                               /usr/lib32/ld-linux.so.2
f7fec000-f7ffb000 r--p 00026000 08:01 9107                               /usr/lib32/ld-linux.so.2
f7ffb000-f7ffd000 r--p 00034000 08:01 9107                               /usr/lib32/ld-linux.so.2
f7ffd000-f7ffe000 rw-p 00036000 08:01 9107                               /usr/lib32/ld-linux.so.2
fffdd000-ffffe000 rw-p 00000000 00:00 0                                  [stack]

Ideally, we could completely eliminate the dependency on libc. Before that,
perhaps we could reserve a region of address space for UML with mmap(PROT_NONE).

Regards,
Tiwei

