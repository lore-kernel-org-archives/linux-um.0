Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7CAC87FCF
	for <linux-um@archiver.kernel.org>; Thu, 14 Aug 2025 01:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IQGF8DRgPVwAOQowZ25KwckiYB1Wy4XRBJu7WhzZ8EM=; b=XapAnNDvZIUwYLyLZfz4K0OUWk
	VNH1/pUZKQiY+D3Ilgcq3T4yd8ovKmQfMTRAEjQKovKiWvYa/1Og1q83aUmCRso+nPiIUZomgDloG
	LsAWXxKizzEqI0jjxPLi65rAgs9ZxGVr410DiIZprTlh2fU0c9csXUaNJOhpIamdbunp2PMxvgdzC
	ah249k27YiPn72jrQiMd37fktcbnRtxi5NN3vhch5UgNBUzDNmh9mzWRGNYks0+694be5xeBsrM++
	lvTums41DqmeD+HbKTRdJxWIy/OzeV4RgQAryAPRexN0K2OwHC0DYp9d8zJMw99tRxAY7k3c9hdEL
	d7Q1U9Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umNBk-0000000FXfz-3f40;
	Thu, 14 Aug 2025 01:55:32 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umMxo-0000000FWV8-1FOs;
	Thu, 14 Aug 2025 01:41:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IQGF8DRgPVwAOQowZ25KwckiYB1Wy4XRBJu7WhzZ8EM=; b=hIGFYU4Vt+WCaZlWzgIl5A5CU0
	De4amhi2m7jG04nG/1NaPJ3AbWQoRkxTG93NyvhlWysu/cZLcnCOcSPRfD1hYYD2ECCQWEXbCypJE
	GZLpnWK2oa2yS2wTOOkCqGEE3FF282LK2IU9gp/GXaQhYsBLB+DMsIZV1c8b7fOH/iThG/hr2l6b/
	mUsQGhR+GwqCB+WuomF8STNbrl2krzf7kaurEkJo8XTzKdGW4DbjxCXqipSd+Ill8PMu8SyZ5+e+Y
	B1WaauvEqWph/ur0ux8bCaPZBT+OZQCASMY+FNQGLzf9fxeeDjmbzKeoP5W42VcZwGtsD8GW2y34N
	oYVC2XiQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umMxW-0000000FNlW-1mZZ;
	Thu, 14 Aug 2025 01:40:50 +0000
Date: Thu, 14 Aug 2025 02:40:50 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Tyler Hicks <code@tyhicks.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org, netfs@lists.linux.dev,
	ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
	linux-um@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] VFS: add rename_lookup()
Message-ID: <20250814014050.GL222315@ZenIV>
References: <>
 <20250813043531.GB222315@ZenIV>
 <175507227245.2234665.4311084523419609794@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175507227245.2234665.4311084523419609794@noble.neil.brown.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_184108_345159_7BCD5755 
X-CRM114-Status: GOOD (  22.64  )
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

On Wed, Aug 13, 2025 at 06:04:32PM +1000, NeilBrown wrote:

> There is a git tree you could pull.....
> 
> My API effectively supports both lock_rename() users and
> lock_rename_child() users.  Maybe you want to preserve the two different
> APIs.  I'd rather avoid the code duplication.

What code duplication?  Seriously, how much of the logics is really shared?
Error checking?  So put that into a common helper...
 
> > This is too fucking ugly to live, IMO.  Too many things are mixed into it.
> > I will NAK that until I get a chance to see the users of all that stuff.
> > Sorry.
> > 
> 
> Can you say more about what you think it ugly?
> 
> Are you OK with combining the lookup and the locking in the one
> function?
> Are you OK with passing a 'struct rename_data' rather than a list of
> assorted args?
> Are you OK with deducing the target flags in this function, or do you
> want them explicitly passed in?
> Is it just that the function can use with lock_rename or
> lock_rename_child depending on context?

Put it that way: you are collapsing two (if not more) constructors
for the same object into one.  That makes describing (and proving,
and verifying the callers, etc.) considerably more painful, with very
little gain to be had.

You are not so much modifying rename_data as creating an object - "state
ready for rename".  The fact that you use the same chunk of memory
to encode the arguments of constructor is an implementation detail;
constraints on the contents of that chunk of memory are different both
from each other and from the resulting object.

In effect, you have a weird union of several types here and the fact
that C type system is pretty weak does not help.  Having separate
constructors at least documents which rules apply; conflating them is
asking for trouble.

It's the same problem as with flags arguments, really.  It makes proofs
harder.  "I'm here" is a lot easier to deal with than "such and such
correlations hold between the values of such and such variables".

If we have several constructors (and they can easily share common helpers
- no problem with that), we can always come back and decide to fold them
into one; splitting is a lot harder, exactly because such flags, etc.,
do not stay local.  I've done both kinds of transformations and in the
"split" direction it ended up with bloody painful tree-wide analysis -
more often than not with buggy corner cases caught in process.

Let's not go there; if, in the end of process, we look at the result and
see that unifying some of them makes sense - good, it won't be hard to do.
But making it as "flexible" as possible as the first step pretty much
locks you into a lot of decisions that are better done when the final
state is seen - and possibly had been massaged for a while.

