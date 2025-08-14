Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E42EC87FCF
	for <linux-um@archiver.kernel.org>; Thu, 14 Aug 2025 00:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-id:Date:References:
	In-reply-to:Subject:Cc:To:From:MIME-Version:Content-Transfer-Encoding:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Csjwyj5ZH/DO6P7w1OAhzIBESzjb3mDbR08hZTbIuk8=; b=krWsoSJpfnb6WxvX03PJCP6dQk
	kZimzY4Sy+XCCe909rsBWZlvzn7d0j922IReRJqdlUjVALGrZ6NjW/ucNo/Mf8Uym0TcXaAe4ysab
	xGf/N2R5sLL321JDCvlATwhDiQDJdmOBtCIAQzFBLflRVbqT8l+dfiJyiZa1uC/RLX9Zu+P7QK9wN
	ZNXLGI0xePvz0dQD/c2SUMluQeJZyOm/R7ZWv07J9Y/Cuir41oonlNLQ2uQhJxMI66J7OIR6jUTef
	PVTBXOv3L9l53DjHmRd+hilcuw85GhGXabORLr8YIhQ+UsjpQ2hvJ6gGLvRRwjbqlxwyqdqASlMrx
	dlDF9QLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umMI2-0000000FRP9-06A9;
	Thu, 14 Aug 2025 00:57:58 +0000
Received: from neil.brown.name ([103.29.64.221])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umMI0-0000000FROX-18kg;
	Thu, 14 Aug 2025 00:57:57 +0000
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1umMH3-005gzt-L3;
	Thu, 14 Aug 2025 00:56:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "David Howells" <dhowells@redhat.com>,
 "Marc Dionne" <marc.dionne@auristor.com>, "Xiubo Li" <xiubli@redhat.com>,
 "Ilya Dryomov" <idryomov@gmail.com>, "Tyler Hicks" <code@tyhicks.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>, "Steve French" <sfrench@samba.org>,
 "Namjae Jeon" <linkinjeon@kernel.org>, "Carlos Maiolino" <cem@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
 netfs@lists.linux.dev, ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
 linux-um@lists.infradead.org, linux-nfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/11] VFS: use d_alloc_parallel() in lookup_one_qstr_excl().
In-reply-to: <20250813051957.GE222315@ZenIV>
References: <>, <20250813051957.GE222315@ZenIV>
Date: Thu, 14 Aug 2025 10:56:58 +1000
Message-id: <175513301880.2234665.7949166216437739702@noble.neil.brown.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_175756_307948_37C6D264 
X-CRM114-Status: GOOD (  11.22  )
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

On Wed, 13 Aug 2025, Al Viro wrote:
> On Tue, Aug 12, 2025 at 12:25:13PM +1000, NeilBrown wrote:
>=20
> > + * If it is d_in_lookup() then these conditions can only be checked by t=
he
> > + * file system when carrying out the intent (create or rename).
>=20
> I do not understand.  In which cases would that happen and what would happen
> prior to that patch in the same cases?
>=20

NFS (and I think it is only NFS) returns NULL from ->lookup() without
instantiating the dentry and without clearing DENTRY_PAR_LOOKUP if
passed "LOOKUP_CREATE | LOOKUP_EXCL" or "LOOKUP_RENAME_TARGET".

So when e.g. filename_create() calls lookup_one_qstr_excl() the result could
be a d_in_lookup() dentry.  It could be that the name exists on the
server, but the client hasn't bothered to check.  So determining that
the result wasn't ERR_PTR(-EEXIST) does NOT assure us that the name
doesn't exist.

The intent needs to be attempted, such as when do_mknodat() goes on to
call e.g.  vfs_create().  Only once that returns an error can we know if
the name existed.

i.e. the API promise:

+ *   Will return -EEXIST if name is found and LOOKUP_EXCL was passed.

must be understood against the background that the name might not be
found due to the lookup being short-circuited and not attempted.
The other promise:

+ *   Will return -ENOENT if name isn't found and LOOKUP_CREATE wasn't passed.

is currently safe from confusion, but I can imagine that one day a
LOOKUP_UNLINK intent could allow a filesystem to short-circuit the
lookup in do_unlinkat() and simply send an UNLINK request to a server
and return the result.

So I thought it worth highlighting the fact that these errors are
best-effort, and that d_in_lookup() is a real possibility.

NeilBrown

