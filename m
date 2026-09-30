Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EFBCA5FBA
	for <linux-um@archiver.kernel.org>; Wed, 30 Sep 2026 10:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:In-Reply-To:Date:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=5ciPoU9g0L9TxJi7K6B543D4kgHHCBTjDma4BORePb8=; b=nBVYLzI/XPuYuk
	pwwK9OXuT4F9htn084W062PJmnhSLg5wm1YHT4/+23pBVs1b1u090YvfyQYPmg3xgqt3dZiBRD65h
	6hxRsIIQvSyRZ6vXsAnWJLoykgUXBoU1FtOXscMb7sJJEWe5DoE36OWLhV9gnQ7Qe5rV6rEg3pm2C
	eM52f/bMkgWEmZw8TKq207qiD84mkYaOXcZEmfhyV+dXN3gvHcqd9f16N2ByOfwAIB+U7G5jP5w78
	nE5T5ia3vCt6NOdGx53Gzk0S7csAG0Qxff8B2DJtqNwMyWvgXCO9IG51ZKUbECZqakkBjy3k30ycu
	yTXbSZus8euUb4yJsrmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBrS3-00000005kEb-1GPU;
	Wed, 30 Sep 2026 10:22:15 +0000
Received: from mail-oi1-f200.google.com ([209.85.167.200])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBrRz-00000005kE4-2d42
	for linux-um@lists.infradead.org;
	Wed, 30 Sep 2026 10:22:13 +0000
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4ea4c979030so5098446b6e.0
        for <linux-um@lists.infradead.org>; Wed, 30 Sep 2026 03:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790763730; x=1791368530;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5ciPoU9g0L9TxJi7K6B543D4kgHHCBTjDma4BORePb8=;
        b=2yEo+weNeFnd5EYEg3M+GC6yU4NlKP9VjJpC/OLGCeZjUv/wDRZiyHoJzvkih8n1v8
         Fhi8G1aa3jotU/lO0jXDRwO8waAjMbEOdjmUnJlNTfFTO1gv9oazrzM/qDHBxLETuQTu
         Q2NgM/hn94BlmV0uwFlkXfy3r7JSIpcN6It42WlN6uxOf3v0uc2ahv2EZZLOTCllZddW
         3XM76Uetqf+bFlrj4tOkL6m/fAVqzBQe0NsEtM9Dj45eHOVnv1RlqZd8LeaqaroWSYDJ
         UIqjRDBihnYAuEUBQ1sf6CGVslPQXwWKn9igU6D2W9JSztAonHcbkbj6CfsSxc5KAADY
         an5g==
X-Forwarded-Encrypted: i=1; AKwUvBwl7/imD4ABqSuNOMXhThegNH6IzjP5EkGR4yeU1KuRskQrpur5DxI1wUM/9O1As6/sO1KBAc6PQw==@lists.infradead.org
X-Gm-Message-State: AFuF++kCxHS/+3zIFpAY5DnWoG0XwdJjJDoKrEyNhOSt17yYxaWbb9nU
	3/jvtPAsdI+YwxbxGZBNXIwEDaWYUXd8SD0UxxMdx8+5O6oqp7Y91opmaktEbkn0WswYL8+w7Ar
	DN4utlP2/6jhGkOS8bdylFzsWzB+Oj5aNU0tgE7qUpJSQWbRt/7jcLLebf9o=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c3d7:b0:4cb:f21c:a794 with SMTP id
 5614622812f47-4f1b5dd6029mr744708b6e.28.1790763730224; Wed, 30 Sep 2026
 03:22:10 -0700 (PDT)
Date: Wed, 30 Sep 2026 03:22:10 -0700
In-Reply-To: <20260929034158.1455429-1-neilb@ownmail.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6abce2d2.64639fcc.9812d.000c.GAE@google.com>
Subject: [syzbot ci] Re: multiple-filesystems: prepare for changes to VFS locking
From: syzbot ci <syzbot+cifa06034fce36fce1@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, amir73il@gmail.com, anton.ivanov@cambridgegreys.com, 
	baolin.wang@linux.alibaba.com, brauner@kernel.org, cem@kernel.org, 
	coda@cs.cmu.edu, codalist@coda.cs.cmu.edu, fuse-devel@lists.linux.dev, 
	hughd@google.com, hyc.lee@gmail.com, jack@suse.cz, jaharkes@cs.cmu.edu, 
	jlayton@kernel.org, joel.granados@kernel.org, johannes@sipsolutions.net, 
	kees@kernel.org, leitao@debian.org, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-um@lists.infradead.org, 
	linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, miklos@szeredi.hu, 
	neilb@ownmail.net, ntfs@lists.linux.dev, richard@nod.at, 
	viro@zeniv.linux.org.uk
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260930_032211_700071_463B6791 
X-CRM114-Status: GOOD (  10.88  )
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

syzbot ci has tested the following series

[v1] multiple-filesystems: prepare for changes to VFS locking
https://lore.kernel.org/all/20260929034158.1455429-1-neilb@ownmail.net
* [PATCH 1/7] VFS/xfs/ntfs: drop parent lock across d_alloc_parallel() in d_add_ci()
* [PATCH 2/7] shmem: use d_duplicate()
* [PATCH 3/7] coda: don't d_drop() early.
* [PATCH 4/7] configfs: remove d_add() calls before configfs_attach_group()
* [PATCH 5/7] hostfs: don't d_drop() before d_splice_alias() in hostfs_mkdir()
* [PATCH 6/7] procfs: drop parent lock for d_alloc_parallel() in iterate_shared()
* [PATCH 7/7] ovl: stop using lookup_one() in ovl_iterate().

and found the following issue:
WARNING in __d_instantiate

Full report is available here:
https://ci.syzbot.org/series/b87296ff-c49f-416e-834c-a886ea8bd6c3

***

WARNING in __d_instantiate

tree:      linux-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next
base:      3879f51857325da9bf3cfb073280257cd16ae067
arch:      amd64
compiler:  Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
config:    https://ci.syzbot.org/builds/dd8fcfa5-13f0-458f-bd3b-9c06d4d67a78/config
syz repro: https://ci.syzbot.org/findings/fdffe42d-ac1a-40d9-b05c-014808f5b0ec/syz_repro

------------[ cut here ]------------
d_in_lookup(dentry)
WARNING: fs/dcache.c:2197 at __d_instantiate+0x3f4/0x700 fs/dcache.c:2197, CPU#1: syz.0.17/5823
Modules linked in:
CPU: 1 UID: 0 PID: 5823 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__d_instantiate+0x3f4/0x700 fs/dcache.c:2197
Code: 03 41 80 f6 01 41 0f b6 ce c1 e1 0d 09 c1 89 0b 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d e9 03 26 96 09 cc e8 0d 84 75 ff 90 <0f> 0b 90 e9 7f fd ff ff e8 ff 83 75 ff 41 81 cc 00 00 01 00 e9 34
RSP: 0018:ffffc900038d73a0 EFLAGS: 00010293
RAX: ffffffff825242a3 RBX: ffff8881b4eef380 RCX: ffff888169801e00
RDX: 0000000000000000 RSI: 0000000001000000 RDI: 0000000000000000
RBP: 0000000001000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff5200071ae6c R12: 0000000000280000
R13: dffffc0000000000 R14: ffff8881bc29f3e0 R15: ffff8881bc29f3e4
FS:  00007f15d1af96c0(0000) GS:ffff8882a8cc9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000001000 CR3: 00000001bd5c4000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 d_make_persistent+0x8e/0x180 fs/dcache.c:3139
 shmem_mknod+0x2d4/0x340 mm/shmem.c:3851
 shmem_whiteout mm/shmem.c:3982 [inline]
 shmem_rename2+0x267/0x430 mm/shmem.c:4022
 vfs_rename+0xbd9/0xef0 fs/namei.c:6219
 ovl_do_rename_rd fs/overlayfs/overlayfs.h:371 [inline]
 ovl_check_rename_whiteout fs/overlayfs/super.c:593 [inline]
 ovl_make_workdir fs/overlayfs/super.c:713 [inline]
 ovl_get_workdir+0x93d/0x1980 fs/overlayfs/super.c:836
 ovl_fill_super_creds fs/overlayfs/super.c:1449 [inline]
 ovl_fill_super+0x1702/0x4360 fs/overlayfs/super.c:1561
 vfs_get_super fs/super.c:1405 [inline]
 get_tree_nodev+0xbb/0x150 fs/super.c:1424
 vfs_get_tree+0x92/0x2a0 fs/super.c:1947
 fc_mount fs/namespace.c:1198 [inline]
 do_new_mount_fc fs/namespace.c:3772 [inline]
 do_new_mount+0x319/0xdc0 fs/namespace.c:3848
 do_mount fs/namespace.c:4181 [inline]
 __do_sys_mount fs/namespace.c:4397 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4374
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f15d0b9e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f15d1af9028 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f15d0e25fa0 RCX: 00007f15d0b9e159
RDX: 0000200000000440 RSI: 0000200000000100 RDI: 0000000000000000
RBP: 00007f15d0c3506b R08: 0000200000000080 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f15d0e26038 R14: 00007f15d0e25fa0 R15: 00007ffe9e1b3308
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a fix for this bug, please reply with `#syz test`
(on a separate line) and attach the patch to the email.

Notes:
- The patch will be applied on top of the tested series (as an
  incremental fix).
- To test a new version of the whole series, please send it directly
  to syzbot@lists.linux.dev.
- Arguments like custom git repos and branches are not supported.

