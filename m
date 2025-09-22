Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68778CAC5A7
	for <linux-um@archiver.kernel.org>; Mon, 22 Sep 2025 04:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rwgsf+oOu+Cs2yHtuw1gc40ABzClXDU5V0q0ZXbaVqg=; b=xTp5np5sCS2c1f+n5kaGTgBHY2
	REtnOtcJdQzPLll4wK0w0iydxh4dWHAdLTjC9X1IkroSal7vLweeo7FRu3yUV64Iir6h9mfxRCu/B
	hCNIOLe5Lo4q69mzJT0itWaw/K6e5U0NSZU4Mtel+wPCEbgHT9vcas1LgNX6DUWC2+n28yJtE6r8w
	LNxWK3Qd4vZUYxZqVxcKhA6TNRZONYlSPn+CqgZJUQb3qwhWgDTFCAi2tYQHuM4pvtlsArRq7kPYc
	pEkqVCy1oQque1Cr32fQeKlh9ay2tVAugx6vQsZ6jqY5VGs+rWaWt2xo0g557CxNd1oJ/uT28av8I
	uGG40RwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0YWA-00000008pfb-2loE;
	Mon, 22 Sep 2025 04:51:14 +0000
Received: from out-184.mta0.migadu.com ([2001:41d0:1004:224b::b8])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0YW7-00000008pbw-1Aly
	for linux-um@lists.infradead.org;
	Mon, 22 Sep 2025 04:51:13 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758516655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rwgsf+oOu+Cs2yHtuw1gc40ABzClXDU5V0q0ZXbaVqg=;
	b=tSKKE5uZia5W1YJpJE1LHPCwdzQLSumM+IE2wmINU4dYzOgcgOHeCvBuqdTZDW3EUnr08x
	NfcIgYeZ/QQKZYxcWcpp1DKZLlX3eTLp2hSF+cJ2bThYggumrmQXwOpJDKG68Mt9uLCbPV
	9drP/z0vnulkh8W871WrSMCPdsO9OSo=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: linux@weissschuh.net
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	benjamin@sipsolutions.net,
	arnd@arndb.de,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: Re: [PATCH v2 03/10] um: vdso: Implement __vdso_getcpu() via syscall
Date: Mon, 22 Sep 2025 12:50:20 +0800
Message-Id: <20250922045020.48158-1-tiwei.bie@linux.dev>
In-Reply-To: <1568f254-7963-4015-91ed-7630d5d87881@t-8ch.de>
References: <1568f254-7963-4015-91ed-7630d5d87881@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250921_215111_454450_DC215EDF 
X-CRM114-Status: GOOD (  21.54  )
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

On Sun, 21 Sep 2025 22:00:41 +0200, Thomas Weißschuh wrote:
> On 2025-09-10 13:59:02+0200, Johannes Berg wrote:
> > On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> > > From: Tiwei Bie <tiwei.btw@antgroup.com>
> > > 
> > > We are going to support SMP in UML, so we can not hard code
> > > the CPU and NUMA node in __vdso_getcpu() anymore.
> > 
> > Correct. But does that mean we actually have to implement it via syscall
> > in the VDSO? That seems a bit odd? ARM doesn't seem to have getcpu in
> > the VDSO at all, for example, so could we do the same and just remove
> > it?
> 
> It is my understanding that the UM VDSO exists to cope with old versions
> of glibc which would fall back to the old vsyscall mechanism if no VDSO
> was present. That could fall through to the host kernels vsyscalls.
> See commit f1c2bb8b9964 ("um: implement a x86_64 vDSO").
> 
> If this is not necessary anymore, the whole VDSO on UM can probably go
> away.

The vsyscall usage was removed from glibc a decade ago:

https://sourceware.org/git/?p=glibc.git;a=commit;h=7cbeabac0fb28e24c99aaa5085e613ea543a2346

"This patch removes the vsyscall usage for x86_64 port.  As indicated
 by kernel code comments [1], vsyscalls are a legacy ABI and its concept
 is problematic:

 - It interferes with ASLR.
 - It's awkward to write code that lives in kernel addresses but is
   callable by userspace at fixed addresses.
 - The whole concept is impossible for 32-bit compat userspace.
 - UML cannot easily virtualize a vsyscall.

 ......"

The original issue could now be considered resolved. So in v3, we no
longer turn __vdso_getcpu into a syscall wrapper; we simply removed it.
Perhaps we could remove the whole VDSO before we implement the "real"
VDSO. However, its implementation is clean, so keeping it wouldn't hurt
and it could serve as a useful starting point for the "real" VDSO.

Regards,
Tiwei

