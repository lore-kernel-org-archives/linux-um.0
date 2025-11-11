Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BE6CCFA18
	for <linux-um@archiver.kernel.org>; Tue, 11 Nov 2025 08:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gp9/9y3RyInbo1zHhoe1nnmyp2UIryqOQflQEaRXeV8=; b=IL+p342o3Lzg3JHaLS7BzvX0Us
	V8cxgtyaggggFg4C/OCJVOnWjdj1WrFkI2KdSF3LqSOECpF2ViZVkBwL89If4RU8W214Ug/nvW5TX
	Ikx8lcBocW3BkS0ZNoMT6KIg//lSkAyOdGwiC48rYBrVJoOffnKZ53sOAyf58tOJkzCP63Zv+sypv
	4iGWCMvObk1+L+iOgjP5cB9cE4JLULjIYeUUHoHR4wIadZqvSKgU+E2APMPu82hEqKm5d7aKyM0pL
	Rdsgmh7mFdR9//O1jBLzma8lW/wimxdgysDrpl8SajsW5pv9WWGT5eYidnFjfiu4BNuXbSbv5aaul
	A7j0i+gA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIjJp-00000006jWg-0Gyw;
	Tue, 11 Nov 2025 08:01:37 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIjJm-00000006jW3-2wNq
	for linux-um@lists.infradead.org;
	Tue, 11 Nov 2025 08:01:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gp9/9y3RyInbo1zHhoe1nnmyp2UIryqOQflQEaRXeV8=;
	t=1762848094; x=1764057694; b=NJf3b4L3y0sRdi3sFVAHVoCszFFpijLqCrmFZSWv1AEQlIP
	v/Ssj1Hs5YjWRHA8W3wJtK1wegJALWoQhl6m22wGY9bcFM5E7hiQPJnfttKDcg0Pj5rWAw5SC9wnM
	p71WSePYyADPta7x0SQN7xc4AKMFpR1elpCWIFyWrfM35TBjHeVih2bppAdccK3mC379J0fY14uMV
	HcN5ALryYsFx5m3xzr6lN7OcsDNpDscawc7Oub7fa1H/K2xGqi/93uIP+QnxZD6NjmPevUudjah4S
	ySsMDYExtRNbHstHMM7Vj2cFlkyqZYDR42ZQfGpNVTCLDomi2jv7d8+xSU9rqCnA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vIjJd-0000000F38R-3cdE;
	Tue, 11 Nov 2025 09:01:26 +0100
Message-ID: <0a84c16f862026c82271c0adbc91d98b812a78b4.camel@sipsolutions.net>
Subject: Re: [PATCH v13 00/13] nommu UML
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, hch@infradead.org
Cc: linux-um@lists.infradead.org, ricarkol@google.com,
 Liam.Howlett@oracle.com, 	linux-kernel@vger.kernel.org
Date: Tue, 11 Nov 2025 09:01:25 +0100
In-Reply-To: <m2framxerm.wl-thehajime@gmail.com>
References: <cover.1762588860.git.thehajime@gmail.com>
		<aRGs8lPjH22NqMZc@infradead.org> <m2framxerm.wl-thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_000134_745209_79B812EC 
X-CRM114-Status: GOOD (  15.92  )
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

On Mon, 2025-11-10 at 21:18 +0900, Hajime Tazaki wrote:
>=20
>   What is it for ?
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  =20
>   - Alleviate syscall hook overhead implemented with ptrace(2)
>   - To exercises nommu code over UML (and over KUnit)
>   - Less dependency to host facilities

FWIW, in some way, this order of priorities is exactly why this hasn't
been going anywhere, and every time I looked at it I got somewhat
annoyed by what seems to me like choices made to support especially the
first bullet.

I suspect that the first and third bullet are not even really true any
more, since you moved to seccomp (per our request), yet I think design
choices influenced by them persist.

People are definitely interested in the second bullet, mostly for kunit,
and I'd be willing to support them in that to some extent.

However, I'm not yet convinced that all of the complexities presented in
this patchset (such as completely separate seccomp implementation) are
actually necessary in support of _just_ the second bullet. These seem to
me like design choices necessary to support the _first_ bullet [1].

[1] and then I suppose the third, which I'm reading as "doesn't need
seccomp or ptrace", but I'm not really quite sure what you meant


I've thought about what would happen if we stuck to creating a (single)
separate process on the host to execute userspace, and just used
CLONE_VM for it. That way, it's still no-MMU with full memory access,
but there's some implicit isolation between the kernel and userspace
processes which will likely remove complexities around FP/SSE/AVX
handling, may completely remove the need for a separate seccomp
implementation, etc.

It would, on the other hand, make it completely non-viable to achieve
the first and third bullets, so given your pursuit of those, one some
level I understand the design right now. I'm yet to be convinced,
however, that those are even worthy goals for (upstream) UML, what use
case would that enable that we really need? Especially considering that
over a longer perspective, NOMMU architectures _are_ on their way out,
and UML will certainly follow once that happens, it won't be the last
remaining NOMMU architecture.

So the only value I see in this is for testing over the net couple of
years, which really doesn't need any sort of significant optimisation or
less reliance on host facilities.

Where do you see this differently?

johannes

