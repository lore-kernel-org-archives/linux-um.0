Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6688ECAC592
	for <linux-um@archiver.kernel.org>; Mon, 22 Sep 2025 12:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J+SHF/H/ko3yid4rtFnrnSWpuzUtjw/lov+46MR1LN8=; b=dgdQzf7dmz/vUdK86t5X91XKqR
	68zF/mp+g8W966va0M2dT1cV7zK8LVhWT653gsLNPeo72Qt6xvC4UUu+mmYk3dMDx3RIWkLudxQ6F
	KnmvwSLEfZBT3A7tR5pIjykoZB6gF8/GM6vgto2QFiELaX4twMXNDf2vaTzqnKDjm/TSjXK13OG4d
	np7AETz2fpbSU7yEBYyTPzS0gD8lpinB78n8qtchzibp0h6AzEv2xzqwDWJfkNJztKYiMKFn5TPXW
	RcOCgwb2SqC0wUiRkNnSdNMggtUyJjuevHgsSGdFS4UkxZy41ZHjdYvLwD8eDN3hLwKLwN9vIAlcC
	DcDx2wwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0fIb-0000000AHW8-1DjX;
	Mon, 22 Sep 2025 12:05:41 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0fIY-0000000AHVk-3Cel
	for linux-um@lists.infradead.org;
	Mon, 22 Sep 2025 12:05:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758542736;
	bh=i8YXMN5Q3402PUiiai3EDlmaoxAVqUXPZ1ERWyiYf34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lVjG4PduqoJK0Mm+tEwYy6qhcdW6bigG28rqwCwF7lHSJaxLVTuJBEXIC8Uj7YyyR
	 /egWXjlVBMasFDwjm2POqOMn3rrbCy6Wj0cyCu9yS9ibl0xN0tUfLhV5yr61FKkDC2
	 QA6QLnqTwQmihuUCG3A1Wn9PMLOUOqWJJOTpsets=
Date: Mon, 22 Sep 2025 14:05:34 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Tiwei Bie <tiwei.bie@linux.dev>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, 
	johannes@sipsolutions.net, benjamin@sipsolutions.net, arnd@arndb.de, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, tiwei.btw@antgroup.com
Subject: Re: [PATCH v2 03/10] um: vdso: Implement __vdso_getcpu() via syscall
Message-ID: <495a5594-8ac6-4b7d-be6b-7c176b741c21@t-8ch.de>
References: <1568f254-7963-4015-91ed-7630d5d87881@t-8ch.de>
 <20250922045020.48158-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250922045020.48158-1-tiwei.bie@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_050538_964701_CD2B6856 
X-CRM114-Status: GOOD (  29.74  )
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

On 2025-09-22 12:50:20+0800, Tiwei Bie wrote:
> On Sun, 21 Sep 2025 22:00:41 +0200, Thomas Weißschuh wrote:
> > On 2025-09-10 13:59:02+0200, Johannes Berg wrote:
> > > On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> > > > From: Tiwei Bie <tiwei.btw@antgroup.com>
> > > > 
> > > > We are going to support SMP in UML, so we can not hard code
> > > > the CPU and NUMA node in __vdso_getcpu() anymore.
> > > 
> > > Correct. But does that mean we actually have to implement it via syscall
> > > in the VDSO? That seems a bit odd? ARM doesn't seem to have getcpu in
> > > the VDSO at all, for example, so could we do the same and just remove
> > > it?
> > 
> > It is my understanding that the UM VDSO exists to cope with old versions
> > of glibc which would fall back to the old vsyscall mechanism if no VDSO
> > was present. That could fall through to the host kernels vsyscalls.
> > See commit f1c2bb8b9964 ("um: implement a x86_64 vDSO").
> > 
> > If this is not necessary anymore, the whole VDSO on UM can probably go
> > away.
> 
> The vsyscall usage was removed from glibc a decade ago:
> 
> https://sourceware.org/git/?p=glibc.git;a=commit;h=7cbeabac0fb28e24c99aaa5085e613ea543a2346
> 
> "This patch removes the vsyscall usage for x86_64 port.  As indicated
>  by kernel code comments [1], vsyscalls are a legacy ABI and its concept
>  is problematic:
> 
>  - It interferes with ASLR.
>  - It's awkward to write code that lives in kernel addresses but is
>    callable by userspace at fixed addresses.
>  - The whole concept is impossible for 32-bit compat userspace.
>  - UML cannot easily virtualize a vsyscall.
> 
>  ......"

Also modern kernels dont even implement the vsyscall page anymore.
At most it is implemented as a stub which will trigger the real syscall
which then gets handled properly.

> The original issue could now be considered resolved. So in v3, we no
> longer turn __vdso_getcpu into a syscall wrapper; we simply removed it.
> Perhaps we could remove the whole VDSO before we implement the "real"
> VDSO. However, its implementation is clean, so keeping it wouldn't hurt
> and it could serve as a useful starting point for the "real" VDSO.

A "real" vDSO would require quite some more infrastructure. And it is
not even clear if such a vDSO will make a difference on UML. In my
opinion if __vdso_getcpu() gets removed, the whole vDSO should go with
it. The code can still be easily restored from git.

Also the functionality to map the host vDSO and vsyscall page into UML
userspace looks very weird and error-prone. Maybe it can also go away.


Thomas

