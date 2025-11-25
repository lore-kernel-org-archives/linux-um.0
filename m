Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48E7CFD37A
	for <linux-um@archiver.kernel.org>; Tue, 25 Nov 2025 09:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GXLccTeFCDdjuoMYhv4QFhbEFAmqGetz8KK1Yo7k1Qk=; b=citR9uxc/C1pzCqMODNtI3MtYT
	FVjQplCHCb1XjdXwXeGjJgIgS84h2rRpwRMxKjImhuEnFp+9wiInpg6mbYq/CsevzDJ8Wv6HRufzD
	F6yj+HzR+QVJ9pul1CVCtuJ+JAMoqQzWVZwHFhMJQzTUbJi47qBb1mnhCp2wg83oMm7Mo67msMx2B
	bd8HavNnTETMYmCp7U0KVl7mygZ8fpzJjnBB/vDzGFkgKgwhZIX1M3f55mV3pf2vRvkx2aPKCZ8Kq
	Ez7e1wWrkLplu2agraGAdy8ixT35dU1owjtAbt2/yIk4rApk2taC4mw9bZfwjH/qKUDD7WLuPnFlL
	/yXaVXzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNppB-0000000D43Y-49hj;
	Tue, 25 Nov 2025 09:59:05 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNpp9-0000000D42W-1nh0
	for linux-um@lists.infradead.org;
	Tue, 25 Nov 2025 09:59:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=GXLccTeFCDdjuoMYhv4QFhbEFAmqGetz8KK1Yo7k1Qk=;
	t=1764064743; x=1765274343; b=VLCeGBxLSHJdnjqQkD0n9mn2dulOBDWgLDKd9qyk4jCJhz2
	pxhy/h3jUTq2mzKqnEk+vuTFlOY7UrqvOJUATl44pvQNs5sc5YN7X0TiEilG5TfNvHeMp+qSygZcQ
	6zYtxnU534HSVoAerGmgYdt7WUIEx3+gdTEk3JbWq2wt/UOHPFS5087TrfJG+76Dlrx9pyZJJFcKv
	4hUwvhWBmAExet2a9wXIzkvVhWqhUFvT3xdbaNQCnk62Q20XcMHqO6ZcACFcAyKvJYXTw1BJ1sHKl
	wGa2MmFT/wSpHKMK/B1CgkP/d/mwPi4P56XEV6axIL/SBzhcDBPl8KRm3SpyLlFw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vNpp0-0000000Bi6Q-2VF1;
	Tue, 25 Nov 2025 10:58:55 +0100
Message-ID: <defcec3945fbc37e90070b030bf1596b11b6d926.camel@sipsolutions.net>
Subject: Re: [PATCH v13 00/13] nommu UML
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: hch@infradead.org, linux-um@lists.infradead.org, ricarkol@google.com, 
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org
Date: Tue, 25 Nov 2025 10:58:53 +0100
In-Reply-To: <m2bjl7y6mv.wl-thehajime@gmail.com> (sfid-20251112_095303_672501_9A7DDF36)
References: <cover.1762588860.git.thehajime@gmail.com>
		<aRGs8lPjH22NqMZc@infradead.org>	<m2framxerm.wl-thehajime@gmail.com>
		<0a84c16f862026c82271c0adbc91d98b812a78b4.camel@sipsolutions.net>
	 <m2bjl7y6mv.wl-thehajime@gmail.com> (sfid-20251112_095303_672501_9A7DDF36)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_015903_467601_45DE5D0B 
X-CRM114-Status: GOOD (  35.94  )
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

On Wed, 2025-11-12 at 17:52 +0900, Hajime Tazaki wrote:
> > >   What is it for ?
> > >   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >  =20
> > >   - Alleviate syscall hook overhead implemented with ptrace(2)
> > >   - To exercises nommu code over UML (and over KUnit)
> > >   - Less dependency to host facilities
> >=20
> > FWIW, in some way, this order of priorities is exactly why this hasn't
> > been going anywhere, and every time I looked at it I got somewhat
> > annoyed by what seems to me like choices made to support especially the
> > first bullet.
>=20
> over the past versions, I've been emphasized that the 2nd bullet (testing=
)
> is the primary usecase as I saw several actually cases from mm folks,
>=20
> https://lists.infradead.org/pipermail/maple-tree/2024-November/003775.htm=
l
> https://lore.kernel.org/all/cb1cf0be-871d-4982-9a1b-5fdd54deec8d@lucifer.=
local/
>=20
> and I think this is not limited to mm code.

Not sure there's much value in testing much else in no-MMU, but sure,
I'll give you that it's useful for testing.

> other 2 bullets are additional benefits which we observed in a
> comment, and our experience.

But are they really _worthwhile_ benefits? A lot of this design adds
additional complexity, and it doesn't really seem necessary for the
testing use case. Making it faster is nice, but it's not like the
speedup really is 20x for arbitrary tests, that's just for corner cases
like "sit in a loop of gettimeofday()". And for kunit there's no syscall
boundary at all, so there's no speedup.

> > I suspect that the first and third bullet are not even really true any
> > more, since you moved to seccomp (per our request), yet I think design
> > choices influenced by them persist.
>=20
> this observation is not true; the first bullet is still true even
> using seccomp.  please look at the benchmark result in the patch
> [12/13], quoted below.

> [snip]

So thanks for the correction. If that's the case, however, it means the
speedup can't be due to the syscall boundary itself (seccomp) but must
rather be due to some pagefault/mapping handling issue? Which would be
inherent in no-MMU, even taking an approach of using two host processes
rather than embedding everything into one.

> > However, I'm not yet convinced that all of the complexities presented i=
n
> > this patchset (such as completely separate seccomp implementation) are
> > actually necessary in support of _just_ the second bullet. These seem t=
o
> > me like design choices necessary to support the _first_ bullet [1].
>=20
> separate seccomp implementation is indeed needed due to the design
> choice we made, to use a single process to host a (um) userspace.

That sounds misleading or even wrong to me, I'd say it's due to putting
the (um) userspace in the same host process as the kernel space?

> I don't see why you see this as a _complexity_, as functionally both
> seccomp handling don't interfere each other.

The complexity isn't so much in the separate code, which is a small
factor, but in the "put everything into the same process" aspect of it.
That has consequences around the host context state handling, things we
didn't really need to consider before suddenly become crucially
important. In the current (with-MMU) design, we only need to worry about
being able to correctly switch between userspace tasks/threads within a
userspace mm (host) process. With the no-MMU design you propose, we also
need to be able to correctly switch between kernel and userspace tasks
within the same single (host) process.

I think this is a pretty significant difference, and saying "there's no
complexity here" is simply pretending it isn't a relevant difference. I
believe you're not even handling this correctly right now in this patch
set, specifically wrt. the GS register which has been pointed out
before, but I wouldn't say that I even have a complete picture in my
head over what state handling would be necessary and sufficient.

So yeah, I think this warrants taking another look as to whether or not
the approach of putting everything into the same host process is even
worth it. I tend to believe that it isn't, given the use cases. And if
you say the speedup still is with seccomp, that kills the speed argument
too.

> > I've thought about what would happen if we stuck to creating a (single)
> > separate process on the host to execute userspace, and just used
> > CLONE_VM for it. That way, it's still no-MMU with full memory access,
> > but there's some implicit isolation between the kernel and userspace
> > processes which will likely remove complexities around FP/SSE/AVX
> > handling, may completely remove the need for a separate seccomp
> > implementation, etc.
>=20
> this would be doable I think, but we went the different way, as
> using separate host processes (with ptrace/seccomp) is slow and add
> complexity by the synchronization between processes, which we think
> it's not easy to maintain in the future.

Which one is it then, slow or not? Not sure I follow. You just said you
do have seccomp when comparing speeds, so that in itself doesn't make it
slow. What synchronization? It'd (have to) be CLONE_VM, but that
actually _simplifies_ state transfer/synchronization, and we already
have (to have) state transfer between different userspace threads in the
same host process for the with-MMU case.

johannes

