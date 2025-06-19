Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA29CC7115A
	for <linux-um@archiver.kernel.org>; Thu, 19 Jun 2025 15:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3RjQ8vjMHty4FIlfcvQC7sTXic9WNUusceBrZsCmd2A=; b=Mcx9k638A18zgSQET1UrPY/dFd
	pIy9cXLZtmfOH0qnug/e1+0Pa9Xye+Js88x97kIyMdvJTsSuVKO75x616b+5ILbIXj6tA3qoyHn+G
	KVzPWAenxh7Y4ms9/lvY0fabbbnFaPwFMsh9DjW1ippTpbWR/A2+2yLJ8XSlE12G1SDvxxsDrbaOr
	Dn/MMR53CQw+yuHCHd07QOLO/VJt4L9pSjyUW6VVqDki2PtKsRgdsZE5X1DtxOH0IxFnONi5zoNsd
	AFHb1xdluzmQEveIBB5mcgs5ShzFDZEGc+Xq0JmUxGw+3YPRlp04uiTXouN/YtELCzsVpJsUv4gxq
	qyOS+GAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSHUk-0000000DWXK-3cj7;
	Thu, 19 Jun 2025 15:48:06 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSEXc-0000000D4vF-3L5R
	for linux-um@lists.infradead.org;
	Thu, 19 Jun 2025 12:38:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3RjQ8vjMHty4FIlfcvQC7sTXic9WNUusceBrZsCmd2A=;
	t=1750336732; x=1751546332; b=ZQpTzh9EAtDOKFFX+DjWCoZSQPXYQs8G5gJBidipH9espHb
	UVeCbzYSzIbkKXp0EcO9pGpgFJNKvgN6qWBg8PFILp+1NlOCBdJzCsALrRL40OdUCbcquUk0xMkUR
	cFPd9AMXUvFEpveHcdu9X+QDOSD5PCMPAQn7zsOTgVhOhM7F2gK21jA19Ihj+h4ck/34xPFV+p4/r
	JAG+sMqnFSSxJ7lCXUlB2lX5Zh8wkf7zw8YvbYsplm+glNWfZg9uvCgoQndslwtPWVgp+0bLcSgS3
	jB2nFz6Y2HdIOBwHyGFoGB77ylNBlgjDHEA5uASUWeYl6pGVDs2kWLTVHvoCZNSQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uSEXY-000000014Eu-2Jtm;
	Thu, 19 Jun 2025 14:38:48 +0200
Message-ID: <2231a777eef3cdb339fe98af4618f958ed658df6.camel@sipsolutions.net>
Subject: Re: [PATCH v9 07/13] um: nommu: configure fs register on host
 syscall invocation
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com,
 Liam.Howlett@oracle.com, 	linux-kernel@vger.kernel.org
Date: Thu, 19 Jun 2025 14:38:47 +0200
In-Reply-To: <m28qln6huv.wl-thehajime@gmail.com> (sfid-20250619_142254_743735_97A005BF)
References: <cover.1750294482.git.thehajime@gmail.com>
		<2863dab9b3f9d6536b73623398a3f39e4ae70957.1750294482.git.thehajime@gmail.com>
		<412c514334ac14a992cab3e7b86170b96d60be1c.camel@sipsolutions.net>
	 <m28qln6huv.wl-thehajime@gmail.com> (sfid-20250619_142254_743735_97A005BF)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250619_053852_832941_01AAF155 
X-CRM114-Status: GOOD (  24.89  )
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

On Thu, 2025-06-19 at 21:22 +0900, Hajime Tazaki wrote:
>=20
> On Thu, 19 Jun 2025 19:40:49 +0900,
> Benjamin Berg wrote:
> >=20
> > On Thu, 2025-06-19 at 10:04 +0900, Hajime Tazaki wrote:
> > > As userspace on UML/!MMU also need to configure %fs register when
> > > it is
> > > running to correctly access thread structure, host syscalls
> > > implemented
> > > in os-Linux drivers may be puzzled when they are called.=C2=A0 Thus i=
t
> > > has to
> > > configure %fs register via arch_prctl(SET_FS) on every host
> > > syscalls.
> >=20
> > Really, I still think that we should "just" get rid of libc
> > entirely
> > inside UML. That would avoid so many weird/potential issues =E2=80=A6
>=20
> I'm not sure if I understand your point.
>=20
> Q1) what do you mean by 'get rid of libc entirely' here ?
> =C2=A0=C2=A0=C2=A0 do you mean the following code block adds the dependen=
cy ?
> + int os_arch_prctl(int pid, int option, unsigned long *arg2)
> + {
> +=C2=A0	return syscall(SYS_arch_prctl, option, arg2);
> + }
>=20
> I guess this can be replaced with inline assembly instead of using
> libc's one.=C2=A0 but this is the code under os-Linux, which I thought
> we're
> allowed to use the host code ?
>=20
> Q2) "That would avoid so many weird/potential issues =E2=80=A6"
> I'm new to this;=C2=A0 I'm wondering what kind of issues did you see ?

Oh, I am just being annoyed by libc in general in UM. It isn't specific
to this patchset.

An example is that we need to keep malloc() working for libc. Which I
would think is kind of weird. Or we had issues because libc turned on
rseq and that was inherited into userspace, causing random crashes and
such.

> > Doesn't change the fact that FS/GS needs to be restored when doing
> > thread switches and such. Though one might be able to do it
> > entirely
> > within arch_switch_to then.
>=20
> I believe this is already done in arch_switch_to.=C2=A0 This particular
> patch does the control to the host context.

OK, need to look at that again a bit. I haven't really wrapped my mind
around how everything fits together, so I probably got some stuff
wrong.

Benjamin

