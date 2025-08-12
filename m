Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D36CA0EE4
	for <linux-um@archiver.kernel.org>; Tue, 12 Aug 2025 23:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wazcssxlta8eoPdiDkAktby9xI1C1XASS74Fx2Nc3Lk=; b=djM3jBqLg0/oAfVVCIfhQtTFfG
	RwsZrEhv0dILxOaMbcQDCGipKtD2UoMTxplUqOG7kNw9jOLc9XQyZEVuQd1xTWH5XFlAoDKUHVxz9
	QYYMG1w3BtbmfqIa2hLzGCV1UU1eTArJZRyu4HkKHElDY1xzUf1ha7VDjrVVAVYKoNdt5nmwQfRwe
	D7ev5AvSz/7prTHCnPOqrtm7xJB3swcJVvjqvl9yzDIZwnBaIF6ttoEO9f18nYMCOlFZxliU7NJb1
	7lmY4DoaB+fSF2gB3IU8BR9IBcxC6Zen0+vwkL1v5AwMIEquWBj0NknWWBv35ICDVFijvEhuMJHZA
	ijChZ2gQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulyoQ-0000000CE7m-34CO;
	Tue, 12 Aug 2025 23:53:50 +0000
Received: from neil.brown.name ([103.29.64.221])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulyoD-0000000CDxz-0IZ3;
	Tue, 12 Aug 2025 23:53:39 +0000
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ulynI-005Y1s-6o;
	Tue, 12 Aug 2025 23:52:41 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
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
	Carlos Maiolino <cem@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org,
	netfs@lists.linux.dev,
	ceph-devel@vger.kernel.org,
	ecryptfs@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] VFS: prepare for changes to directory locking
Date: Tue, 12 Aug 2025 12:25:03 +1000
Message-ID: <20250812235228.3072318-1-neil@brown.name>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_165337_113090_6C70DDA4 
X-CRM114-Status: GOOD (  15.37  )
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

This is the first of 3 sets of patches which, together, allow
filesystems to opt-out of having the directory inode lock held over
directory operations (except readdir).
- This set creates some new APIs in the VFS and makes a few changes in
  callers either because they are trivial (patch 08) or because they
  involve a flag-day change (patches 06, 07, and 09).
- The second set rolls the new APIs out to all non-VFS code which 
  invokes directory operations.
- The third (which isn't yet bug-free) changes the implementation
  of these APIs to make the use of inode_lock() optional.

I imagine these three set landing in three different merge windows,
though some of the second set could get in the same window as the first.

The patches are listed below and are available at 
   https://github.com/neilbrown/linux
in branch pdirops.

This first set adds and updates APIs with three particular goals:
1/ centralising all lookup and locking for directory ops.  This
  includes a variety of dentry_lookup() calls with done_dentry_lookup(),
  and rename_lookup() with done_rename_lookup().
2/ Removing the use of d_drop() during a directory operation (it is
   OK for d_drop to happen at the end).  As the goal is for locks
   to be based on the dentry, a dropped dentry will no longer protect the name.
   The only change in this patch set is 08 which changes d_splice_alias()
   and d_add() to not require a preceding d_drop(), and then removes
   the unnecessary d_drop()s.
3/ No blocking in d_alloc_parallel() within readdir() (iterate_shared()) requests.
   We will need to invert the ordering between d_alloc_parallel() and
   inode_lock(), so blocking in d_alloc_parallel() to, e.g., prime the
   dcache during readdir must be avoided.  The last patch introduces
   new interfaces that can be used instead and explains them.
   Patches 9 and 10 prepare for this.

Please review and consider for 6.18.

Thanks,
NeilBrown

 [PATCH 01/11] VFS: discard err2 in filename_create()
 [PATCH 02/11] VFS: introduce dentry_lookup() and friends
 [PATCH 03/11] VFS: add dentry_lookup_killable()
 [PATCH 04/11] VFS: introduce dentry_lookup_continue()
 [PATCH 05/11] VFS: add rename_lookup()
 [PATCH 06/11] VFS: unify old_mnt_idmap and new_mnt_idmap in
 [PATCH 07/11] VFS: Change vfs_mkdir() to unlock on failure.
 [PATCH 08/11] VFS: allow d_splice_alias() and d_add() to work on
 [PATCH 09/11] VFS: use global wait-queue table for d_alloc_parallel()
 [PATCH 10/11] VFS: use d_alloc_parallel() in lookup_one_qstr_excl().
 [PATCH 11/11] VFS: introduce d_alloc_noblock() and d_alloc_locked()

Future patches:

set 2:
 devtmpfs: use new dentry locking APIs
 audit: use new dentry locking APIs
 debugfs: use new dentry locking APIs.
 binderfs: use new dentry locking APIs.
 binfmt_misc: use new dentry locking APIs.
 kernel/bpf: use new dentry locking APIs.
 devpts: use new dentry locking APIs.
 ipc/mqueue: use new dentry locking APIs.
 s390/hypfs: use new dentry locking APIs.
 security: use new dentry locking APIs.
 tracefs: use new dentry locking APIs.

 ecryptfs: use dentry_lookup_continue() in lock_parent()
 ecryptfs: use rename_lookup()

 fs/proc: Don't look root inode when creating "self" and "thread-self"
 proc: use d_alloc_locked() and lock_lookup()

 bcachefs: use new dentry locking APIs
 exfat: use d_splice_alias(), don't d_drop()
 coda: don't d_drop() early.
 smb/server: use new dentry locking APIs.
 nfsd: use new dentry locking APIs.
 cachefiles: use new dentry locking APIs.
 btrfs: use dentry_lookup_killable()
 fuse: use new dentry locking APIs.
 sunrpc/rpc_pipe: use new dentry locking APIs.
 xfs: use new dentry locking APIs.

 ovl: use is_subdir() for testing if one thing is a subdir of another
 ovl: introduce ovl_upper_dentry_lookup() and use it.
 ovl: switch from parent_lock() to dentry_lookup_continue() except for rename.
 ovl: use dentry_lookup_killable() in ovl_check_whiteouts()
 ovl: split ovl_tempname() out from ovl_lookup_temp().
 ovl: Change ovl_lookup_temp() to use ovl_upper_dentry_lookup()
 ovl: Change all rename code to use rename_lookup_noperm()
 ovl: don't dget_parent() in ovl_lookup_real_one()
 ovl: use new APIs in ovl_lookup_real_one()
 ovl: use new dir apis in ovl_cache_update()

 NFS: remove d_drop() from nfs_atomic_open()
 nfs: use d_alloc_noblock() in silly-rename

 afs: use d_splice_alias() in afs_vnode_new_inode()
 afs: use d_time instead of d_fsdata
 afs: don't unhash/rehash dentries during unlink/rename
 AFS: use new dir access APIs.

set 3:
 VFS: make various namei.c functions static.
 VFS: Remove lookup_one() and lookup_noperm()
 VFS: Introduce S_DYING which warns that S_DEAD might follow.
 VFS: lift d_alloc_parallel above inode_lock
 VFS: provide alternative to s_vfs_rename_mutex
 VFS: Add ability to exclusively lock a dentry
 VFS: use new dentry locking for open/create/remove/rename
 VFS: allow a filesystem to opt out of directory locking.
 NFS: allow concurrent dir ops.


