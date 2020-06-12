Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jjpDx-00073e-Sv
 for linux-um@lists.infradead.org; Fri, 12 Jun 2020 19:20:23 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <000000000000d788c905a7dfa3f4@google.com>
Date: Fri, 12 Jun 2020 14:15:51 -0500
In-Reply-To: <000000000000d788c905a7dfa3f4@google.com> (syzbot's message of
 "Fri, 12 Jun 2020 02:24:11 -0700")
Message-ID: <87mu58p02g.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: [PATCH] proc: Use new_inode not new_inode_pseudo
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: syzbot <syzbot+7d2debdcdb3cb93c1e5e@syzkaller.appspotmail.com>
Cc: sfr@canb.auug.org.au, b.a.t.m.a.n@lists.open-mesh.org, jack@suse.cz, mareklindner@neomailbox.ch, sw@simonwunderlich.de, linux-um@lists.infradead.org, jdike@addtoit.com, amir73il@gmail.com, a@unstable.cc, linux-kernel@vger.kernel.org, davem@davemloft.net, syzkaller-bugs@googlegroups.com, richard@nod.at, netdev@vger.kernel.org, kuba@kernel.org, linux-fsdevel@vger.kernel.org, alex.dewar@gmx.co.uk, akpm@linux-foundation.org, adobriyan@gmail.com, sven@narfation.org, anton.ivanov@cambridgegreys.com


Recently syzbot reported that unmounting proc when there is an ongoing
inotify watch on the root directory of proc could result in a use
after free when the watch is removed after the unmount of proc
when the watcher exits.

Commit 69879c01a0c3 ("proc: Remove the now unnecessary internal mount
of proc") made it easier to unmount proc and allowed syzbot to see the
problem, but looking at the code it has been around for a long time.

Looking at the code the fsnotify watch should have been removed by
fsnotify_sb_delete in generic_shutdown_super.  Unfortunately the inode
was allocated with new_inode_pseudo instead of new_inode so the inode
was not on the sb->s_inodes list.  Which prevented
fsnotify_unmount_inodes from finding the inode and removing the watch
as well as made it so the "VFS: Busy inodes after unmount" warning
could not find the inodes to warn about them.

Make all of the inodes in proc visible to generic_shutdown_super,
and fsnotify_sb_delete by using new_inode instead of new_inode_pseudo.
The only functional difference is that new_inode places the inodes
on the sb->s_inodes list.

I wrote a small test program and I can verify that without changes it
can trigger this issue, and by replacing new_inode_pseudo with
new_inode the issues goes away.

Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/000000000000d788c905a7dfa3f4@google.com
Reported-by: syzbot+7d2debdcdb3cb93c1e5e@syzkaller.appspotmail.com
Fixes: 0097875bd415 ("proc: Implement /proc/thread-self to point at the directory of the current thread")
Fixes: 021ada7dff22 ("procfs: switch /proc/self away from proc_dir_entry")
Fixes: 51f0885e5415 ("vfs,proc: guarantee unique inodes in /proc")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/proc/inode.c       | 2 +-
 fs/proc/self.c        | 2 +-
 fs/proc/thread_self.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index f40c2532c057..28d6105e908e 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -617,7 +617,7 @@ const struct inode_operations proc_link_inode_operations = {
 
 struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
 {
-	struct inode *inode = new_inode_pseudo(sb);
+	struct inode *inode = new_inode(sb);
 
 	if (inode) {
 		inode->i_ino = de->low_ino;
diff --git a/fs/proc/self.c b/fs/proc/self.c
index ca5158fa561c..72cd69bcaf4a 100644
--- a/fs/proc/self.c
+++ b/fs/proc/self.c
@@ -43,7 +43,7 @@ int proc_setup_self(struct super_block *s)
 	inode_lock(root_inode);
 	self = d_alloc_name(s->s_root, "self");
 	if (self) {
-		struct inode *inode = new_inode_pseudo(s);
+		struct inode *inode = new_inode(s);
 		if (inode) {
 			inode->i_ino = self_inum;
 			inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
diff --git a/fs/proc/thread_self.c b/fs/proc/thread_self.c
index ac284f409568..a553273fbd41 100644
--- a/fs/proc/thread_self.c
+++ b/fs/proc/thread_self.c
@@ -43,7 +43,7 @@ int proc_setup_thread_self(struct super_block *s)
 	inode_lock(root_inode);
 	thread_self = d_alloc_name(s->s_root, "thread-self");
 	if (thread_self) {
-		struct inode *inode = new_inode_pseudo(s);
+		struct inode *inode = new_inode(s);
 		if (inode) {
 			inode->i_ino = thread_self_inum;
 			inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

