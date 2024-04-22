Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977C1C4345F
	for <linux-um@archiver.kernel.org>; Mon, 22 Apr 2024 07:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bz1yuBXt0f8pg06aa88VDWOnm9LYepq/KFLywudpYOE=; b=Rp4uVGBxxSVdwU6uebvoCBv3of
	M7x15me03XBqRe0MCDG8QKZxi03qUgOxKRNfh4NrvSzQiVx1CuVm++7Tlx0YvYOFPeonUdfCRkVgL
	gjlaWp48Cmv9oAMWugOvXfq0fQUCKoYt6nhFsh4UQdc4gtJc2bLJ4S5uzQB5bK7KyuWpJOBhrlMFP
	mkqGgMCdK93UEgW+Sp4ohRVb7tgf6MJnadYaVNsTR/gCr9F+D3OpN1T+Tq9piq87Og6SW9QMRbVgW
	cg5myun1kHSRPUZvr8g0H5lXUpVBaPtJ1MSXx1JldlyLWSRSljY2HCOic7EyPHOuEGxKm4QDPj/s4
	hR4wHX0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryoJO-0000000CTjb-3LIj;
	Mon, 22 Apr 2024 07:42:02 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryoJL-0000000CTij-0L0B
	for linux-um@lists.infradead.org;
	Mon, 22 Apr 2024 07:42:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bz1yuBXt0f8pg06aa88VDWOnm9LYepq/KFLywudpYOE=;
	t=1713771718; x=1714981318; b=X1x/w91DeH9h1PeYgbhuhXuyydLbksDrlPBOe1lR6dld53P
	1prwK5iPnjSkxZI1EqfFksc8op7mXqlyon/C15Gx+SZOoZMU6LTv38nfH0+jbLVoiqy3RnDN9AKlv
	KIn7LeGBKWcGzgBxWqlcCNV4w9X4+4H+EmzYEky4BoM6VggHcwuHH+A4PixpNzq1tp2m2kzuyz1HB
	zNQfVqO6q0js+7rLLsngmnT2lULh5tPJ0NDdt9jfAcPi3DCvBbnYM4fGBAaynpogVhOKmXVdH02JW
	GPnDJOkZBcWKd6HzkQv3vVmM/UjIL26tHMTSTPOqnP1DDHG0T22Oca1vuG7UEFWw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1ryoJI-00000000aUS-1j3w;
	Mon, 22 Apr 2024 09:41:56 +0200
Message-ID: <4aeca286d181797b7fb02a7fea6bc62a8f616589.camel@sipsolutions.net>
Subject: Re: [PATCH 00/12] Rework stub syscall and page table handling
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, linux-um@lists.infradead.org
Date: Mon, 22 Apr 2024 09:41:54 +0200
In-Reply-To: <e213cf20-bf70-4e53-a5f2-5ec88cfa6ff5@antgroup.com>
References: <20240418092327.860135-1-benjamin@sipsolutions.net>
	 <e213cf20-bf70-4e53-a5f2-5ec88cfa6ff5@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240422_004159_139392_3601F22C 
X-CRM114-Status: GOOD (  14.58  )
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

Hi Tiwei,

On Mon, 2024-04-22 at 10:35 +0800, Tiwei Bie wrote:
> On 4/18/24 5:23 PM, benjamin@sipsolutions.net=C2=A0wrote:
> > From: Benjamin Berg <benjamin.berg@intel.com>
> >=20
> > This patchset reworks the stub syscall handling and also redos how page
> > table updates are tracked and synchronized. Some of this originated in
> > the SECCOMP patchset, but it became clear that these refactorings make
> > sense independently as they result in a considerably fewer page faults.
>=20
> I saw your SECCOMP patchset. It's pretty cool! Just wondering if you're a=
bout
> to post a new version soon. :)

I am planning to work on it again, but it is not very high on my
priority list. So, could be quite soon or some months :-)

In the ARM support thread ("UML for arm64"), there were some ideas to
use FD passing in order to protect memory mappings better. Doing that
should allow the SECCOMP approach to scale to SMP and will also
simplify the security model.

Making those changes will take a bit of thought and experimentation.
Nothing really big though, it pretty much boils down to using sockets
for (some of) the synchronization and replacing mprotect with mmap so
the FD can authorize the operation.

> PS. Just FYI, gVisor also implemented a SECCOMP based platform which is
> also very interesting:
>=20
> https://gvisor.dev/blog/2023/04/28/systrap-release/
> https://github.com/google/gvisor/tree/master/pkg/sentry/platform/systrap

It is a good choice if you want to catch syscalls and do some custom
handling in userspace. Just annoying that it is still stuck on classic
BPF :-)

Benjamin

