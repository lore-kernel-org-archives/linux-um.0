Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51022C25B78
	for <linux-um@archiver.kernel.org>; Tue, 28 May 2024 11:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z12QkY4jMSxnwrl0h/ae7+gNOuSbevEAZx3Q6ZKgWvM=; b=dGs57gmukjklIjA/E64fvAeV2m
	RFGrHMlrOQbQZMC3v0pT4r0572UH8AXbjdwz0/WaDZ6D86ytFkXrCIL5VlefF0W9nMt4x1HIG60lp
	Iwza98txXsf5v8PPreKaayq0apJt6U36F5wgklgYAnIXzveRDKrVTXjeC10WedmEt8JjfcEwtqeBq
	AfyDOz0SAwYjvGTANDsHOUlEjNXeLM5biuXZmkUj36TmwcTKWv7UImpQZhVZYVdcgiR30Z+mnEQPV
	vdTNuzYfuT7T9V8uMYKnphh0HSr90ovkgQGd1sldKMrI/LYxFtO66toifDdqcAnciliE27P6aDu8i
	i+93VX+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBvSp-00000000TXn-0f7B;
	Tue, 28 May 2024 11:57:59 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBvSm-00000000TXH-3QyI
	for linux-um@lists.infradead.org;
	Tue, 28 May 2024 11:57:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Z12QkY4jMSxnwrl0h/ae7+gNOuSbevEAZx3Q6ZKgWvM=;
	t=1716897475; x=1718107075; b=KE+6Ut51CU5jOORCiyi5qaU2ltbGn3OpDDqhSYrtjPBfAk+
	BCJq5uG6H+/HTXGc8H1Gg/3C2VAvn5Jpd+TZJ3uxJNykRmNry1LMDmFA66KMA68H9EXcvhVjZFdfP
	G2WGspUY0NhbWjQbXY1tNE3HwMTzpXMmKk/FSyxc6c2B4wQljVMyG5e6BZ0jhE+XYBkoNDKe9UxLj
	8ZxYm+Tnw8p8yeJY23acjg+up7KTFUvvfpjhCCckIQwMXBYYVLJUSW+YZIzw/Xu8RQqNSH/u/Uuf2
	UZ+IHvP6xrUwx6b3VpgJ7G5ivymLlZUDQLyGG6VcYg4OGpUgzKAJCjyw0suieIgg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sBvSh-0000000ELEQ-03vY;
	Tue, 28 May 2024 13:57:51 +0200
Message-ID: <4a9d3075304f39b818009081d496b0f245bad450.camel@sipsolutions.net>
Subject: Re: [PATCH 3/5] um: Do a double clone to disable rseq
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, benjamin@sipsolutions.net, 
	linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Date: Tue, 28 May 2024 13:57:49 +0200
In-Reply-To: <5f5505da-ba67-421e-b0f5-6a5c19955f27@antgroup.com>
References: <20240528085419.1964424-1-benjamin@sipsolutions.net>
	 <20240528085419.1964424-4-benjamin@sipsolutions.net>
	 <5f5505da-ba67-421e-b0f5-6a5c19955f27@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240528_045756_959086_FFE9A65E 
X-CRM114-Status: GOOD (  13.22  )
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

On Tue, 2024-05-28 at 18:16 +0800, Tiwei Bie wrote:
> On 5/28/24 4:54 PM, benjamin@sipsolutions.net wrote:
> > From: Benjamin Berg <benjamin.berg@intel.com>
> >=20
> > Newer glibc versions are enabling rseq support by default. This remains
> > enabled in the cloned child process, potentially causing the host kerne=
l
> > to write/read memory in the child.
> >=20
> > It appears that this was purely not an issue because the used memory
> > area happened to be above TASK_SIZE and remains mapped.
>=20
> I also encountered this issue. In my case, with "Force a static link"
> (CONFIG_STATIC_LINK) enabled, UML will crash immediately every time
> it starts up. I worked around this by setting the glibc.pthread.rseq
> tunable via GLIBC_TUNABLES [1] before launching UML.
>=20
> So another easy way to work around this issue without introducing runtime
> overhead might be to add the GLIBC_TUNABLES=3Dglibc.pthread.rseq=3D0 envi=
ronment
> variable and exec /proc/self/exe in UML on startup.
>=20

It's also a bit of a question what to rely on - this would introduce a
dependency on glibc behaviour, whereas doing the double-clone proposed
here will work purely because of host kernel behaviour, regardless of
what part of the system set up rseq, how the tunables work, etc.

johannes

