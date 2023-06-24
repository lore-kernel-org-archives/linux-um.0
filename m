Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A6DEB64DA
	for <linux-um@archiver.kernel.org>; Sat, 24 Jun 2023 21:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZXWpctb+ZP8CW5X38ixb58/7ZU28wDmnsIKdtvPSCP0=; b=qg7Ygx6GqvkTzL
	nL2+v1FVoPyecOyYOCmTH9IkW49fMBS1B9zW+bGjTmYh3vNk6Ut2fR2nVz2oyUOsWWfP0C/q6+Ure
	FnwL7MZCfcI0ZGSQekRP7zW73ILMsu4bK/u85tNeaKB2ZGbLMtoGMeem1t67xrBjhtc4h1rwFW5z0
	V3/HF7pC/DNKkn+ItyUkXqxnJ9IvH7GsK+iKwVJ3uziosPnB4YuZBRJID8QfGTH+DhlosWepf149U
	TxF+6ReGu3VD6LL57SIluMbAFBAMhlMte7ndK9n2D9rm5pl6+g6qp6vABrI9J/fHsPAdCSQYjTvp9
	1UaA1kKgo7UAZand1P5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDB8t-006gXX-26;
	Sat, 24 Jun 2023 21:50:03 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDB8p-006gWB-3B
	for linux-um@lists.infradead.org;
	Sat, 24 Jun 2023 21:50:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=s1qvKNUhL7ufRI+EGhO8Bz+Fk1fzOg7JIKE6GUV340o=;
	t=1687643397; x=1688852997; b=nApY4da91rSDJnVZabhQpVSMGR3UcN7A8UX9vD+DvYkKsv2
	xMvHS3VZVeOW6LZtzTvBf7jgyO5KUrSbVgXN5I4f+H6qU2vLHhGmwDrojpXmGyhsSKItXXCy14cuE
	0yZAkKe4F/d9yrIcNFbv8LNnfBFtxDghs3KaGnQ7ArtKndimt6TWUzd35axXTbGPhgzi4oXOE3zx4
	gRqd6oDhfO1tyoohLIDPxkuKKzGVRvhrEYZ6I9DE8TIT2iniqplALrlcJbCqWtGiA205OPZDsXBJ/
	KFg4l6ehMsq2jKYgBAvZqigU01rvIssK5epN9hTRfC7A5bnBDMmCLcDU9XdHjF+g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qDB8h-00Gr6h-1G;
	Sat, 24 Jun 2023 23:49:51 +0200
Message-ID: <43343c41b72c38637a9cf17dbc0856a96d4dd3ea.camel@sipsolutions.net>
Subject: Re: UML for arm64
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Berg <benjamin@sipsolutions.net>, Rob Herring <robh@kernel.org>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov
	 <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Date: Sat, 24 Jun 2023 23:49:50 +0200
In-Reply-To: <b5ca5d46a0323048debf00ffd9e1574df675d93e.camel@sipsolutions.net>
References: <20230622192247.GA2278576-robh@kernel.org>
	 <dc5704a5d452f7432313170ed900975b2b72354f.camel@sipsolutions.net>
	 <69707b721698594f96899c050871bcbb3594a9a1.camel@sipsolutions.net>
	 <CAL_JsqKTb4QQGj6z2LB9tNFpwCRg5avdK=oQ7qzMjw1oWNBrvw@mail.gmail.com>
	 <ef180d8f1b69b95b51d324e0631807aeb6bcd09d.camel@sipsolutions.net>
	 <b5ca5d46a0323048debf00ffd9e1574df675d93e.camel@sipsolutions.net>
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230624_145000_161794_C758192E 
X-CRM114-Status: GOOD (  29.18  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Sat, 2023-06-24 at 22:05 +0200, Benjamin Berg wrote:
> On Sat, 2023-06-24 at 15:15 +0200, Johannes Berg wrote:
> > On Fri, 2023-06-23 at 16:34 -0600, Rob Herring wrote:
> > > 
> > > > 
> > > > Either way, the old patchset will give you a good idea about how it all
> > > > works, the changes are mostly in the details. I am happy to push out a
> > > > new version sooner rather than later if it might help with any efforts
> > > > on your side.
> > > 
> > > From a quick scan, it looks like there's some cleanups in the series
> > > which would be helpful without seccomp parts. One of the initial
> > > issues I've found is UML using older ptrace interfaces which arm64
> > > doesn't implement. PTRACE_GETREGS for example.
> > > 
> > 
> > I don't think that completely gets rid of PTRACE_GETREGS though, and if
> > I remember correctly, we really kind of need that there?
> 
> The SECCOMP code should not need any ptrace at all.
> 

Indeed. For the record, I was referring to "some cleanups in the series"
not getting rid of PTRACE_GETREGS entirely :-)

There are indeed some instances of PTRACE_GETREGS removed in your
patches, however, I believe that they're still needed (in ptrace mode)
after that. If that's true, then it seems like the ptrace mode can't
really be ported to arm64.

Then again, a bunch of the stuff you removed there is for detecting
sysemu support, which is documented to only exist on x86, which I'm not
sure is true because arm64 defines PTRACE_SYSEMU[_SINGLESTEP] and
TIF_SYSCALL_EMU and then the generic ptrace code should actually
implement it?

However, PTRACE_GETREGS is still invoked unconditionally in the
userspace() loop afaict, and thus it can't actually work?


So seems that the best bet for other architectures anyway would be
seccomp mode anyway, since that's pretty well supported across
architectures.

You have some endianness bugs in the BPF code for 64-bit code though, it
only works on little endian ;-)

But there are good reasons to use it anyway, vs. ptrace.

> All it does is
> read/write the mcontext that is generated by the host. I think there
> was just some mangling there to map the basic registers into the format
> that UML expects internally (floating point, SSE, etc. are just copied
> directly though).

Yeah that sounds about right.

> > Though then again it's all been a while, and I only faulted the seccomp
> > mode back in in discussions with Benjamin. Looks like we've found a
> > potentially nicer way to make it secure than his secret-based approach,
> > and in fact in a way that should even make it SMP-safe, at least in
> > theory, obviously a lot of infrastructure is missing to make it SMP in
> > the first place.
> 
> Yeah, the idea with FD passing and CLONE_VM without CLONE_FILES does
> indeed seem very promising both for a secure SECCOMP model and SMP
> support specifically.

I don't believe we'll get SMP support easily one way or the other, but
it's nice to know that seccomp mode won't actively break it :-)

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
