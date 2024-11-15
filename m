Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AE3D6DDED
	for <linux-um@archiver.kernel.org>; Fri, 15 Nov 2024 10:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bXI6fuggzdZCZ/ppCSWW4upNvYKbxFVvk+TKXXlz4o8=; b=N2GiatZzv00HqYzDgQqQqKfyns
	fymcXnwpNZwTbF8nf//yHsdwdz/HtIZ7sPqqZFS7uw6ajdbeVf9P4L14AZHoy0p4KaB2flDU/3rs+
	nJxtIrtxeS4OrS6V/skQZr04FdLe0UQQXDgvBN+DebE4lRY8h1GOoCw404ioh5YgenEd5g4WOGf46
	H6yikhfyA1+3d/3w2fPTV2Tg1jr2nVzfFJ61bHTZyCSDA7VTfycftMUHwnMBBGJoG9R2l82V0Z6ba
	TJ5lUFkSYHZ9jLIajCJdu2P3pPOSN39bk15xEtMW/m4/bSWgsv18gsR5DuZhIVqrgRC5GMKiNd64T
	Z9HQlZ/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBtJn-00000002JKM-2Kxh;
	Fri, 15 Nov 2024 10:12:47 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBtJl-00000002JJq-1sP6
	for linux-um@lists.infradead.org;
	Fri, 15 Nov 2024 10:12:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bXI6fuggzdZCZ/ppCSWW4upNvYKbxFVvk+TKXXlz4o8=;
	t=1731665563; x=1732875163; b=ownh66Diej7F0sfpklOu7QmS2LgTJr4UCMsClLREiiTaY94
	L4Vx+utG+CLbZDV8aB/trt3b4pJS270F36X+AElj071Zq7hYZgIYAmsbbVblS6PG8kJgjcS0LcjZe
	g9p50z9btgs2DIsNdL9vPNAWadItAkvSc/t7P/mVerQ7Ra57HQnbx9u9DaoAoLob8w9a0jkUkDwmv
	w1IaGTyT3IEO74EkG6P/pNaSszH4JwAwurVWnHVY0Flo6CYLu6HIVx/0t4S1jDEKswh2LmoxO/kxq
	hYe8KjkoOInHpozNRFKae8wGCRth5kLMQPehFnr0rN5/e7rFFsXSa8hQDXgKx+JA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tBtJg-00000005W46-0P21;
	Fri, 15 Nov 2024 11:12:40 +0100
Message-ID: <c85bd71e0f4797edf2635cf4059699d1a3862218.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2 00/13] nommu UML
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org
Cc: ricarkol@google.com, Liam.Howlett@oracle.com
Date: Fri, 15 Nov 2024 11:12:39 +0100
In-Reply-To: <cover.1731290567.git.thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
	 <cover.1731290567.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241115_021245_506626_D74F24C1 
X-CRM114-Status: GOOD (  22.91  )
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

On Mon, 2024-11-11 at 15:27 +0900, Hajime Tazaki wrote:
> This is a series of patches of nommu arch addition to UML.  It would
> be nice to ask comments/opinions on this.

So I've been thinking about this for a while now...

To be clear, I'm not really _against_ it. With around 1200 lines of
code, it really isn't even big. But I also don't know how brittle it is?
Testing it is made somewhat difficult with the map-at-zero requirement
too.


And really I keep coming back to asking myself what the use case is?

Is it to test something for no-MMU platforms more easily? But I'm not
sure what that would be? Have any no-MMU platform maintainers weighed in
on this, have they even _seen_ it? Is that interesting? Is it more
interesting than testing an emulated system with the right architecture?
With it this way you'd probably have to build the right libraries and
binaries for x86-64 no-MMU, does such a thing already exist somewhere?

It also doesn't look like it's meant to replace LKL? But even LKL I
don't really know - are people using it, and if so what for? Seems
lklfuse is a thing for some BSD folks?

Is there something else to use it for?

If it's the first (test no-MMU) then it probably should be smarter about
not really relying on retpoline. Why is the focus so much on that
anyway? If testing no-MMU was the most important thing then probably
you'd have started with seccomp, and actually execute the syscalls from
that, to not have all those restrictions that come from rewriting
binaries, rather than ignoring the whole thing. Though of course you did
add a filter now, but I think it'll just crash?
So I could perhaps see this use case, but then I'd probably think it
should be more generic (i.e. able to execute all no-MMU binaries
including ones that may be using JIT compilation etc.) and not _require_
retpoline, but rather use it as an optimisation where that's possible
(i.e. if you can map at zero)?

If the use case instead of more LKL-type usage, I guess I don't really
understand it, though to be honest I also don't really fully understand
LKL itself, but it always _seemed_ very different.

Somewhat hyperbolically, I'm wondering if it's just a tech demo for
retpoline?

So I dunno. Reading through it again there are a few minor things wrt.
code style and debug things left over, but it's not awful ;-) I'd also
prefer the code to be more clearly "marked" (as nommu), perhaps putting
new files into a nommu/ directory, or something like that. But that's
pretty minor.

Still it's in a lot of places and chances are it'll make bigger
refactoring (like seccomp mode) harder. Perhaps if at all it should come
after seccomp mode and use that to execute syscalls if zpoline can't be
done, and to catch all the cases where zpoline doesn't work (you have
that in the docs)?

What do others think? Would you use it? What for?

johannes

