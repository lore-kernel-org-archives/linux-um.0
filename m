Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DF0D10C16
	for <linux-um@archiver.kernel.org>; Sun, 27 Oct 2024 09:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nkfi5PyJgxSfTGF7gaF03XDp0KqDrm+uiMXmjz4aPPU=; b=bCj4YrRK895APndfoBLUJXxap8
	p1takdebf0lx9pfkKUV9LmGns6uqRxpILT861xmYHXz+3zOeUXdMoXa5PrHUSVMv/0Tc4Shp/W+c4
	BuSjCeOjJ5fZJ8df8hkwbRM6HODEZ+7wbldap2LxXKBcmLksPj9wjr653UlqdNuyhNLK3MNRHjTe3
	Z6/cmnwVdYXbwOwfGj6Y53sVJJpv13GqGSloAxVIeVyCHe9kgiShF8/GJaZRDsMkSz1FiWSGOr9d6
	cQAvVmBdV1DWuKPSWgBHUdF0HuqaMqZ4mc4kvmX7JRRX2Lpd9RUKTYu8iBggVRdNJtSd9Qt/RcucI
	LluC46iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4zqG-00000007vg7-06iN;
	Sun, 27 Oct 2024 09:45:48 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4zqE-00000007vfP-1Tvo
	for linux-um@lists.infradead.org;
	Sun, 27 Oct 2024 09:45:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Nkfi5PyJgxSfTGF7gaF03XDp0KqDrm+uiMXmjz4aPPU=;
	t=1730022344; x=1731231944; b=RxoGHw0iRQ5Gh4Nlyaj6hD9+pS+j6XXNLcF8viPmgWBr+b/
	3JMIM4qVSLdItjQGcftJEfgwVwFDUCNsc/uxfoRlPC9ltAx90rIuZ7XqmmlU7xHJBrtzxXzzHRFt5
	/wpq7oQDDaKyWE2W45y+KXO9EErW3vocQimbhaHyV6d20ps5BISEOPX7ZUvYQ15oFbGPW2S/+Rq1V
	ahdH+LBsWfHkTb5eHp+l/GY2fgcjpGTlzAUX6cs4w5FH2MH+awgzFuL74r9uftLx6BAoc6kmy0PwW
	ivPwjkA1S24gR26aZH5j0dUompkDLGROiWaqHk9SbTluoeo9iu+dQ5V6JmYQ07ZA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t4zq8-00000006D7n-3qOW;
	Sun, 27 Oct 2024 10:45:41 +0100
Message-ID: <44b4a8f1eec8fad1a9c7cb293bff9fcf7985cdb6.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 05/13] x86/um: nommu: syscall translation by zpoline
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, ricarkol@google.com
Date: Sun, 27 Oct 2024 10:45:39 +0100
In-Reply-To: <m21q03iae4.wl-thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
		<2f3537884533232ab2ef2937e392d32736527bdc.1729770373.git.thehajime@gmail.com>
		<75c9b237111431362458ced4c5213b74ca8fcb13.camel@sipsolutions.net>
		<m2r084nxu6.wl-thehajime@gmail.com>
		<6769bac56b1d20233dae036aba2067da3eaf7779.camel@sipsolutions.net>
	 <m21q03iae4.wl-thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241027_024546_433524_ABDD5B15 
X-CRM114-Status: GOOD (  11.10  )
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

On Sat, 2024-10-26 at 16:36 +0900, Hajime Tazaki wrote:
>=20
> Originally our patchset had a whitelist-based seccomp filter (w/
> SCMP_ACT_ALLOW), but dropped from this RFC as I found that 1) this is
> not the !MMU specific feature (it can be generally applied to all UML
> use cases), and 2) we cannot prevent a syscall (e.g., ioctl(2)) from
> userspace which is white-listed in our seccomp filter, thus the newly
> introduced filter may not be perfect.
>=20
> the maintenance of the whitelist is also not easy; the syscall used in
> one version is renamed at some point in future (what I faced is
> SCMP_SYS(open) should be renamed with SCMP_SYS(openat)).

Sure, agree that would be awful. However, only kernel code should be
making real host syscalls, never userspace code, so you should be able
to filter simply based on address? Since it's NOMMU there's a single
process and a single address space, and userspace binaries always have
to be in certain places, I'd think?

This should be cheap since
 (a) it's not doing anything with (guest) syscalls that were already
     rewritten by zpoline (they don't exist as host syscalls)
 (b) while the real host syscalls made by the kernel would still be
     checked by the filter program, it'd just return "sure that's OK"
     and not redirect anything

johannes

