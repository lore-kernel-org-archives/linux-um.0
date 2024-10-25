Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71EBD0BB56
	for <linux-um@archiver.kernel.org>; Fri, 25 Oct 2024 15:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8yIu3+BAY6E62p5EtR84qIl6mz+TAcS8fG9rQk7WRNw=; b=CxgXVcFReimjVLNH4GYe8t3TDM
	cStFBdwPmsGlNmISwCJl6/S4kiyGPC2uNkX63F3sihAqnNuQTVUu36tXknKi457hTlnvJwyAwVfRA
	HSjZtXMULTAs9yiMI09g0V/a0y1PKgf3PcLdkfihYHyJKYywi0yzm4kUHJHsSUZyqo91U30qaZb5S
	Z9JAmI2v/0Vc2vNZhrZjvvvUTPuMEfOlFpbSz0PD30m+52C98KS92qtvuY1B0pcFJWiqvzoFyQwtt
	seKmhbUlFzofiXIxFSdtCN//UbFFqZS1kvmx2fJrWoVRISSZ9X8WpiBUciwIPa4FLp91K31EBlYj/
	X6nzsMjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4MLg-00000004Gdw-3tD6;
	Fri, 25 Oct 2024 15:35:36 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4M1w-00000004BkD-36Ls
	for linux-um@lists.infradead.org;
	Fri, 25 Oct 2024 15:15:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8yIu3+BAY6E62p5EtR84qIl6mz+TAcS8fG9rQk7WRNw=;
	t=1729869311; x=1731078911; b=Yoo1HAW/qRDlCV85PUYBk0hUECYk7gse/OYrIFn2Zf3hH3t
	SN3m+QlrOD+M6VFA0kArckufhA3sU+ZPa4FQHhqG1hXogrItCX85jYrFu5Rqab0y7+scUmEnqnjU8
	O+6xParlAdkbWd9PSOY7xx8QNeCvI/+zeLuSj9NpG7lJIP4Fx4IFSfV+xyrPt/rLCjaa74QEjoimP
	YWCpNFGD0fIiawO7I+IDtAe0tK/jffDEvuLYdHcKDF6msaQXBygc1qBnJjA8P2FHRB7sfj8j7mVTe
	MIFu+upUY4v/8bCYjDSH7sEKaJNA8U8kKfDMCauXRtFC0oPilAhb2DiJXvIGoiXA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t4M1r-00000004ac8-2Udu;
	Fri, 25 Oct 2024 17:15:07 +0200
Message-ID: <f99740357776ef3b44d0df61e2ad5a22149431e6.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 03/13] um: nommu: memory handling
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, ricarkol@google.com
Date: Fri, 25 Oct 2024 17:15:06 +0200
In-Reply-To: <m2ttd0nxzp.wl-thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
	 <304383e5c9b2bba18678598bbdacadc9126d8f74.1729770373.git.thehajime@gmail.com>
	 <d84f04d9a60d4dffa81fe5d0f73646032f1294f1.camel@sipsolutions.net>
	 <m2ttd0nxzp.wl-thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_081512_800265_F608A749 
X-CRM114-Status: GOOD (  13.26  )
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

On Fri, 2024-10-25 at 21:55 +0900, Hajime Tazaki wrote:
> >=20
> > Should that really do _nothing_? Perhaps it's not called at all in no-
> > MMU, but then you don't need it, but otherwise it seems it should do
> > something even if it's just panic()?
>=20
> it is called also in !MMU.  I'll think to figure out how the function
> is shared.

Feels like it should do something then? Why not print like before? If it
happens in userspace we kill it, otherwise not sure what even happens...

> > 	mmap64(....
> > 	       MAP_SHARED | MAP_FIXED |
> > 		IS_ENABLED(CONFIG_MMU) ? MAP_ANONYMOUS : 0,
> > 	       ...);
>=20
> since this is part under os-Linux and we cannot use kconfig.h (IIUC)
> feature (e.g., IS_ENABLED). but I'll reformat it to simplify instead
> of duplicating same lines.

Oh, missed that, sorry

still I guess putting

#ifndef CONFIG_MMU
	| MAP_ANONYMOUS
#endif

might be nicer.

johannes

