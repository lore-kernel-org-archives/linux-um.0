Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C1DCAC58D
	for <linux-um@archiver.kernel.org>; Thu, 11 Sep 2025 04:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pqdhY7qUs1EroFfnj/5dwIqEXqJOyy/7eKGa3EKk0TQ=; b=OyoDIiGG49UpcYSbCIsP5E5uTr
	u4tWjVGINgt3oGjwSr42InC+HQtWfdsG6kS0/xRBWwYWA3i5ktPqADmk2KVB2oU3nmuSW+rLuMWEf
	fQoqCjJaLaFvI2/0KHK6WKLrqOyptB5YQInMoDJxik3cxdHP5z9AkcoQ1qO1DYDYbsx3SKhJWJDDN
	rv7L0UCD0m097tj9dIEcs0VtMbWXw9n2hsigliUHVNl//JYoezxoE9sNVCKNTd9qlgX0L8rvcE6ZH
	g5+hpjCgkFtfsy7JBvaJPLDD1Q60+NEkWtUMpR9aVSEtrj8/sgVr+yHtsW3uYbUi7s8GsJGHFyTJD
	Ph4SrzSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwYwM-00000000oId-0HS6;
	Thu, 11 Sep 2025 04:29:46 +0000
Received: from out-182.mta0.migadu.com ([2001:41d0:1004:224b::b6])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwYwI-00000000oGn-3H8G
	for linux-um@lists.infradead.org;
	Thu, 11 Sep 2025 04:29:44 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757564976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pqdhY7qUs1EroFfnj/5dwIqEXqJOyy/7eKGa3EKk0TQ=;
	b=vtbCSJJt2CpJX67adu0e89qQmbWQzvYrLc2ZKQ1YC4BOuEY3znuhN2cW9Qni058020Shj9
	3aj1k/Z4fhAY6wSg6+RYHyABqLVXnFHm7mH8ZcmHkFYZNpcfDk6X8uZRyEfrBAvZhiBKuE
	yGtwx3DQLt1VAQo7QS1Z6bGj7K/exjI=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: johannes@sipsolutions.net
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	benjamin@sipsolutions.net,
	arnd@arndb.de,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: Re: [PATCH v2 03/10] um: vdso: Implement __vdso_getcpu() via syscall
Date: Thu, 11 Sep 2025 12:29:10 +0800
Message-Id: <20250911042910.2834585-1-tiwei.bie@linux.dev>
In-Reply-To: <d28c9690341715fff04fbc01fd80723a30195f23.camel@sipsolutions.net>
References: <d28c9690341715fff04fbc01fd80723a30195f23.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250910_212943_568590_8D8B3D22 
X-CRM114-Status: GOOD (  11.05  )
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

On Wed, 10 Sep 2025 13:59:02 +0200, Johannes Berg wrote:
> On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> > From: Tiwei Bie <tiwei.btw@antgroup.com>
> > 
> > We are going to support SMP in UML, so we can not hard code
> > the CPU and NUMA node in __vdso_getcpu() anymore.
> 
> Correct. But does that mean we actually have to implement it via syscall
> in the VDSO? That seems a bit odd? ARM doesn't seem to have getcpu in
> the VDSO at all, for example, so could we do the same and just remove
> it?

Good idea. I checked the implementations in glibc and musl, and
they automatically fall back to the syscall when __vdso_getcpu is
not available:

https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/sysdep-vdso.h;h=5a33871872da9ccef36293c3ca5eba6503f956e6;hb=HEAD#l36
https://git.musl-libc.org/cgit/musl/tree/src/sched/sched_getcpu.c?h=v1.2.5#n32

I will just remove it in the next version.

Regards,
Tiwei

