Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6010CA5FA5
	for <linux-um@archiver.kernel.org>; Thu,  1 Oct 2026 10:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qhjkz5LGIQ5OQf96jD8ObHxGuARoVZWuTiE3aF/pzBw=; b=kC3zodh+ykPjUBBVU9X/JRyVA8
	yINjFvonnF2WaZppratni/MnAB7TVHe9hqOxp8JvTPihRBsGobKSI+hqQH3xrF5CckumkmEHsnuPA
	Wj7/3aPjdP6tGGucCohn20hWtg2DZpgy6JeAz11LjDqrtdoWH2K4yGeFwm0cH6LIpbtTuCgiApaoj
	coK+NUCMBXdCVOf+dVC041Lu7ZvTfkWr8SvtDKQrHYuG8n0d3RB5awNFZdyxqjB0ZCokqaWFUYGkS
	mJUT2ddmwDawWFcJG8VzaT40TrQUGu0jIx8aRn9ttIRAoL7bF4ot9emapwM/CWa5NmiwKcV5OEBev
	PtFNT6KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCDc6-00000008Si1-1qCy;
	Thu, 01 Oct 2026 10:02:06 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCDc4-00000008Sgh-18YL
	for linux-um@lists.infradead.org;
	Thu, 01 Oct 2026 10:02:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Qhjkz5LGIQ5OQf96jD8ObHxGuARoVZWuTiE3aF/pzBw=;
	t=1790848924; x=1792058524; b=q9xORyBFdeqEevl/UX33zAnMfcWG+XBCs5zegiqKHUZH6Ju
	5wCCPwNMmHnsfcaTDHVt6H51pwxv29XEOmgzf1o7RRbqrpc6gtj6DVGRbAjM5pfFfyTwtnnvOr41G
	s6X7yJgUvYp+Jy7/3gWhw3U4Lxdb0Rb762GsBOtbSKS9uuC86yUyWN9avQ1MYuLnTuhEAynaTQzis
	VZ7aGtsVm0ZThmo9laJAY2ojuiP48G+a0FLTQ0sBtH8N6Gao5BvBePl77iq2HXttXMXaFdjRaUgFu
	b2u31x7BlhVL1pWxqHabR/VId0z+3qX1Rb4gvrsgjyfoD6bV3j/vrkqpfdvUOXMA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xCDbn-000000001cC-1VvD;
	Thu, 01 Oct 2026 12:01:47 +0200
Message-ID: <94759bed23f00d2044005e36be6f72f297e092f0.camel@sipsolutions.net>
Subject: Re: [PATCH v4 1/2] selftests: run tests on nommu architecture
From: Johannes Berg <johannes@sipsolutions.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, "David Hildenbrand (Arm)"
	 <david@kernel.org>
Cc: Hajime Tazaki <thehajime@gmail.com>, linux-mm@kvack.org,
 liam@infradead.org, 	rbm@suse.com, akpm@linux-foundation.org,
 luto@amacapital.net, 	brendan.jackman@linux.dev, liuhangbin@gmail.com,
 corbet@lwn.net, kees@kernel.org, 	broonie@kernel.org, mhocko@suse.com,
 rppt@kernel.org, shuah@kernel.org, 	surenb@google.com, vbabka@kernel.org,
 wad@chromium.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-um@lists.infradead.org, 
	geert@linux-m68k.org, daniel@thingy.jp
Date: Thu, 01 Oct 2026 12:01:45 +0200
In-Reply-To: <ar4br2vW7yZGd3gt@gremlin>
References: <20260929235711.2287931-1-thehajime@gmail.com>
	 <20260929235711.2287931-2-thehajime@gmail.com>
	 <bda5eeaa-7868-4d4a-9026-9e99347afd7c@kernel.org>
	 <ar4br2vW7yZGd3gt@gremlin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261001_030204_321815_FF13DF27 
X-CRM114-Status: GOOD (  16.09  )
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

On Thu, 2026-10-01 at 09:42 +0100, Lorenzo Stoakes (ARM) wrote:
> On Thu, Oct 01, 2026 at 09:08:33AM +0200, David Hildenbrand (Arm) wrote:
> > On 9/30/26 01:57, Hajime Tazaki wrote:
> > > Architectures lacking MMU don't support fork(2) syscall and only
> > > vfork(2) is available with limitations.  Thus, we cannot run kselftes=
t
> > > on nommu architecture as is.
> > >=20
> > > This commit addresses this issue with the following changes:
> > >=20
> > > - on test run stage, avoid calling timeout command when NOMMU=3D1 var=
iable
> > >   added to environmental variable, since timeout command uses fork
> > >   syscall which nommu platform doesn't support.
> > > - describe the difference of nommu tests in the document.
> > >=20
> > > So command line to build/execute tests for nommu should be like below=
:
> > >=20
> > >  $ make ARCH=3Dum NOMMU=3D1 O=3Dbuild kselftest-all TARGETS=3Dnommu
> > >  $ make ARCH=3Dum NOMMU=3D1 O=3Dbuild kselftest-install TARGETS=3Dnom=
mu
> > >  $ NOMMU=3D1 ./build/kselftest/kselftest_install/run_kselftest.sh -p =
\
> > >    -c nommu
> >=20
> > Is there a way we could derive that from the environment in one of thes=
e cases?
>=20
> I thought maybe uname could help but our LLM overlords tell me no.

Hajime originally wanted uname to indicate it, but that caused
regressions elsewhere, so we dropped that commit. I guess we could put
_something_ back?

> It pointed at something though.
>=20
> In fs/proc/meminfo.c:
>=20
> #ifndef CONFIG_MMU
> 	show_val_kb(m, "MmapCopy:       ",
> 		    (unsigned long)atomic_long_read(&mmap_pages_allocated));
> #endif
>=20
> So MmapCopy in /proc/meminfo tells us definitively, weirdly enough.

Hyrum's law and all that, but I guess it's not highly likely to (want
to) change :)

johannes

