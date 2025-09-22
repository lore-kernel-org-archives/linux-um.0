Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1848FCAC592
	for <linux-um@archiver.kernel.org>; Mon, 22 Sep 2025 14:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bK8x+dO8BPgki99VqY7scjNxBi8MaDYQH/l8R+RP854=; b=zAJkyADHCPsEJ/L6ut3WCQKxEz
	2AgHfu9wLb5DY4SKBAlok0iBRfH101JfSET3CEslrRkRhAoL+BB5Lc/qtAlV1GXs12T4TDIH+PKwt
	kEcrOb/M/26XaKVcW1wKn3RbjfAKJ8pq3vqHygyUsTKYbVTd9ehYOXJKDtGJ7bABlWj/lpbnTrk3b
	fPtDXtm1q0B/NKNvtke8Y+l047aQvZEWKVdZKXxUA5yT/zzLHLmbOsIFP9hhKBaZqF1P5iyvC6Ls1
	Tx7RhpEtEX7TMgfae9cx0fmdK71swikxmXnBIPG1+EW0cVvdht7+I3ANYFqZrnjZdSDNKT/TsdDa4
	VjQwteMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0h7Q-0000000AbW6-3Ijb;
	Mon, 22 Sep 2025 14:02:16 +0000
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0h7M-0000000AbUB-0clH
	for linux-um@lists.infradead.org;
	Mon, 22 Sep 2025 14:02:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758549729;
	bh=e5PY6U82YwilDEzB4p0kKsmSnXCVDFHMHAYraZzOBuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c/P8qUNNgX72CeMTDluIenBfBLO6g4qqsq/BAOdrH/S0tT0jWbqFWMvGiQJcpC+ck
	 xMptr4GXEzdfZegnDLP1x8QIbJ6EUCgbkfx9xk1/UJhMwTWaLwISzlSzr7GUb5bFq+
	 PBoM4pVwbPUPx2t2C1oQib1DfS7qKG8nPHLFgOSw=
Date: Mon, 22 Sep 2025 16:01:17 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, benjamin@sipsolutions.net, arnd@arndb.de, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, tiwei.btw@antgroup.com
Subject: Re: [PATCH v2 03/10] um: vdso: Implement __vdso_getcpu() via syscall
Message-ID: <21755635-74d4-4fa4-8ffd-371c17630fdf@t-8ch.de>
References: <1568f254-7963-4015-91ed-7630d5d87881@t-8ch.de>
 <20250922045020.48158-1-tiwei.bie@linux.dev>
 <495a5594-8ac6-4b7d-be6b-7c176b741c21@t-8ch.de>
 <76b5ba35f864764100c9a5a00d50d8fa4276cd98.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76b5ba35f864764100c9a5a00d50d8fa4276cd98.camel@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_070212_330704_F02DB55A 
X-CRM114-Status: GOOD (  25.50  )
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

On 2025-09-22 14:12:52+0200, Johannes Berg wrote:
> On Mon, 2025-09-22 at 14:05 +0200, Thomas Weißschuh wrote:
> > > The original issue could now be considered resolved. So in v3, we no
> > > longer turn __vdso_getcpu into a syscall wrapper; we simply removed it.
> > > Perhaps we could remove the whole VDSO before we implement the "real"
> > > VDSO. However, its implementation is clean, so keeping it wouldn't hurt
> > > and it could serve as a useful starting point for the "real" VDSO.
> > 
> > A "real" vDSO would require quite some more infrastructure.
> > 
> 
> What's not "real" about the vDSO now? Yes it just implement syscalls
> after the getcpu removal, but ... it's still a vDSO? I _have_ played
> with getting data into it for the time-travel case, at least.

Right now it does not provide any advantage over a regular syscall.
Essentially it is just overhead. That said, if you do want to make a
real vDSO out of it, I'd be happy to help in that.
(I did most of the recent work on the generic vDSO infrastructure)

> > And it is not even clear if such a vDSO will make a difference on UML.
> 
> Syscall overhead is _huge_ in UML, if it does anything but syscalls it
> will _certainly_ make a difference.

Ack.

> > In my
> > opinion if __vdso_getcpu() gets removed, the whole vDSO should go with
> > it. The code can still be easily restored from git.
> 
> I mean ... on the one hand, sure, it doesn't really do much after this,
> but OTOH it lets userspace actually use that path? So might be useful.

What advantage does userspace have from it?

> > Also the functionality to map the host vDSO and vsyscall page into UML
> > userspace looks very weird and error-prone. Maybe it can also go away.
> 
> Surely host vDSO etc. is never mapped into UML userspace and never is,
> not sure what you're thinking of, but clearly that's wrong as written.

This is how I understand the 32bit implementation using
ARCH_REUSE_HOST_VSYSCALL_AREA and NEW_AUX_ENT(AT_SYSINFO_EHDR, vsyscall_ehdr)
where vsyscall_ehdr comes from the hosts getauxval(AT_SYSINFO_EHDR).
But I didn't actually test this. I'll look at it again, but currently
I'm travelling.


Thomas

