Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Vegard Nossum <vegard.nossum@oracle.com>
Date: Wed, 16 Dec 2015 21:59:56 +0100
Message-Id: <1450299596-10780-1-git-send-email-vegard.nossum@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] uml: fix hostfs mknod()
To: Richard Weinberger <richard@nod.at>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

An inverted return value check in hostfs_mknod() caused the function
to return success after handling it as an error (and cleaning up).

It resulted in the following segfault when trying to bind() a named
unix socket:

  Pid: 198, comm: a.out Not tainted 4.4.0-rc4
  RIP: 0033:[<0000000061077df6>]
  RSP: 00000000daae5d60  EFLAGS: 00010202
  RAX: 0000000000000000 RBX: 000000006092a460 RCX: 00000000dfc54208
  RDX: 0000000061073ef1 RSI: 0000000000000070 RDI: 00000000e027d600
  RBP: 00000000daae5de0 R08: 00000000da980ac0 R09: 0000000000000000
  R10: 0000000000000003 R11: 00007fb1ae08f72a R12: 0000000000000000
  R13: 000000006092a460 R14: 00000000daaa97c0 R15: 00000000daaa9a88
  Kernel panic - not syncing: Kernel mode fault at addr 0x40, ip 0x61077df6
  CPU: 0 PID: 198 Comm: a.out Not tainted 4.4.0-rc4 #1
  Stack:
   e027d620 dfc54208 0000006f da981398
   61bee000 0000c1ed daae5de0 0000006e
   e027d620 dfcd4208 00000005 6092a460
  Call Trace:
   [<60dedc67>] SyS_bind+0xf7/0x110
   [<600587be>] handle_syscall+0x7e/0x80
   [<60066ad7>] userspace+0x3e7/0x4e0
   [<6006321f>] ? save_registers+0x1f/0x40
   [<6006c88e>] ? arch_prctl+0x1be/0x1f0
   [<60054985>] fork_handler+0x85/0x90

Let's also get rid of the "cosmic ray protection" while we're at it.

Fixes: e9193059b1b3 "hostfs: fix races in dentry_name() and inode_name()"
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: stable@vger.kernel.org
---
 fs/hostfs/hostfs_kern.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git fs/hostfs/hostfs_kern.c fs/hostfs/hostfs_kern.c
index 2ac99db..5a7b322 100644
--- fs/hostfs/hostfs_kern.c
+++ fs/hostfs/hostfs_kern.c
@@ -730,15 +730,13 @@ static int hostfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode,
 
 	init_special_inode(inode, mode, dev);
 	err = do_mknod(name, mode, MAJOR(dev), MINOR(dev));
-	if (!err)
+	if (err)
 		goto out_free;
 
 	err = read_name(inode, name);
 	__putname(name);
 	if (err)
 		goto out_put;
-	if (err)
-		goto out_put;
 
 	d_instantiate(dentry, inode);
 	return 0;
-- 
1.9.1

