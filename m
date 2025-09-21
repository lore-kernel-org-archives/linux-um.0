Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B010CAC5A7
	for <linux-um@archiver.kernel.org>; Sun, 21 Sep 2025 20:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=caQHPgCXyjN0OiPmjHbAkRmNSI5CrE8LsAuSnzO0U54=; b=ImBNLct7XQr3H4BTe68zgkUDq6
	jPOT5cx+f8YZBiYV5W+ldycm6RP/+YVTh2jl5I9jfg9qgTjokJdXWxfqAz5vRU7Q3pquhEFSAe58A
	UZEsNUOH/+r2m/QjBvmXA7j/rJEKvxNTuu3W9cQzk1Bb7Jrqx1EgQI0H3OPJAA/oQeqtaUU5yCMSN
	I1+YYBEHH7utSiJg3p0pg+zhqU0U1i24YewMTZh9ilNduaX3ejHmOuq9ycsAknn7Sz2jOeysOlAHt
	uoEBtcy2nZ1O0rorm0PRgan4KsKP83aOja9wHEyh2fpyrMauPUqsRPsEGj9EHAPtr7ynkJuECQ0mI
	wXXSKjSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0QEp-000000087iE-14dh;
	Sun, 21 Sep 2025 20:00:47 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0QEm-000000087hP-3CZY
	for linux-um@lists.infradead.org;
	Sun, 21 Sep 2025 20:00:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758484841;
	bh=WMCOeDIKrlJVUUux6y2tkqoyhVNipRT1bzBjnTbdAwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o93W3Wql+RRMWUfu3qFSLeT/pQNT3Uo2J00nLzyeV/pdKyH8/UcQVpEVqsXSus2mp
	 YaPM2gT1StDbWDmvDzLWCV8+4aAeYn5fGvBb71Db9MMGZXY75KQ1y+a3HRCkqVck1P
	 ulzjW+7cXIREH1UPAB24dkTXy9YDG6IsQGVeURek=
Date: Sun, 21 Sep 2025 22:00:41 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	benjamin@sipsolutions.net, arnd@arndb.de, tiwei.btw@antgroup.com
Subject: Re: [PATCH v2 03/10] um: vdso: Implement __vdso_getcpu() via syscall
Message-ID: <1568f254-7963-4015-91ed-7630d5d87881@t-8ch.de>
References: <20250810055136.897712-1-tiwei.bie@linux.dev>
 <20250810055136.897712-4-tiwei.bie@linux.dev>
 <d28c9690341715fff04fbc01fd80723a30195f23.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d28c9690341715fff04fbc01fd80723a30195f23.camel@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250921_130044_955116_CEFA6466 
X-CRM114-Status: GOOD (  13.03  )
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

On 2025-09-10 13:59:02+0200, Johannes Berg wrote:
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

It is my understanding that the UM VDSO exists to cope with old versions
of glibc which would fall back to the old vsyscall mechanism if no VDSO
was present. That could fall through to the host kernels vsyscalls.
See commit f1c2bb8b9964 ("um: implement a x86_64 vDSO").

If this is not necessary anymore, the whole VDSO on UM can probably go
away.


Thomas

