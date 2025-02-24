Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48ED9C021B2
	for <linux-um@archiver.kernel.org>; Mon, 24 Feb 2025 02:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k0z3ryzhlvwNnSY3M6NnkZyLrFw5ndXGZMxfWSNU7WE=; b=fi0EhdyBcmg831ZggdZWh6xgNE
	8DQFQ2vLRXj+eGTsk3c/JpraaetF4vi6yFTtogTkdQ6fF8FFqkAl6jTpsaGFFEJ7mTIMP6oV8NAZh
	AC66BPM94DSdNSn9y3ZzqBWw2WMP50/TZkZk1wUWvXnCzR/cK6lDq8d2AEhfs9q5v59D7G1kh+9Zn
	Bf7pwhRGxYYWi9Km+wGZVyz237WfycRQJOirTvBOmft/q6KMlUF1KoORm5DSP2WSxlzOUpOlLHAli
	fdqNBQNxeklh/J67K4cjCztLqvxhp/ZWje3KQbbpq/H7zPtYlpY/LvvULUDstuhkeB8gjtsHofYKY
	5vVcyZIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmNus-0000000C7yB-1wGb;
	Mon, 24 Feb 2025 02:09:54 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmNul-0000000C7x8-1fiS
	for linux-um@lists.infradead.org;
	Mon, 24 Feb 2025 02:09:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k0z3ryzhlvwNnSY3M6NnkZyLrFw5ndXGZMxfWSNU7WE=; b=KmAN0t4ASfNyIO+14Tkdl6eWeS
	3h5f4U0OMObgauHsGHOggSvN3IH3kD9JEbHZkJw8V7XjINOSuY8bQ0KCoigDzT86A7uoqZ8sniL8p
	GcMQqi6DKiE0f287Qex4A3N4QmCmQiSYYLGz5ify3Xc26tT4EoicFpfO1qAhQP8TCUmj+lTLm91ic
	p1+A7yprmhsdpoGC58opaV8NVRBjyRTc7YzzcwHbbSaTkaZZ44ZfWX0NRBdhOCU2Fy+oer18kF+Wi
	oPMB34w48UifiegznLm57ZSPgJCDuN5xgqsbQ+u/CKZtTWDFRL0Q6LujN5ezl+BCpZiZrLvR0P0TD
	TAL7/hQA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmNuX-00000006aXB-3Rl4;
	Mon, 24 Feb 2025 02:09:33 +0000
Date: Mon, 24 Feb 2025 02:09:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>, Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-um@lists.infradead.org, ceph-devel@vger.kernel.org,
	netfs@lists.linux.dev
Subject: Re: [PATCH 1/6] Change inode_operations.mkdir to return struct
 dentry *
Message-ID: <20250224020933.GV1977892@ZenIV>
References: <>
 <20250222041937.GM1977892@ZenIV>
 <174036084630.74271.16513912864596248299@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174036084630.74271.16513912864596248299@noble.neil.brown.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250223_180947_434557_D4CEBA3B 
X-CRM114-Status: GOOD (  14.94  )
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

On Mon, Feb 24, 2025 at 12:34:06PM +1100, NeilBrown wrote:
> On Sat, 22 Feb 2025, Al Viro wrote:
> > On Fri, Feb 21, 2025 at 10:36:30AM +1100, NeilBrown wrote:
> > 
> > > +In general, filesystems which use d_instantiate_new() to install the new
> > > +inode can safely return NULL.  Filesystems which may not have an I_NEW inode
> > > +should use d_drop();d_splice_alias() and return the result of the latter.
> > 
> > IMO that's a bad pattern, _especially_ if you want to go for "in-update"
> > kind of stuff later.
> 
> Agreed.  I have a draft patch to change d_splice_alias() and
> d_exact_alias() to work on hashed dentrys.  I thought it should go after
> these mkdir patches rather than before.

Could you give a braindump on the things d_exact_alias() is needed for?
It's a recurring headache when doing ->d_name/->d_parent audits; see e.g.
https://lore.kernel.org/all/20241213080023.GI3387508@ZenIV/ for related
mini-rant from the latest iteration.

Proof of correctness is bloody awful; it feels like the primitive itself
is wrong, but I'd never been able to write anything concise regarding
the things we really want there ;-/

