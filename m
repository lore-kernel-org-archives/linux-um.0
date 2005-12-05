Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EjImV-0005dH-9T for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Dec 2005 08:01:35 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EjImO-00016n-1v
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Dec 2005 08:01:35 -0800
Received: from localhost.localdomain (localhost [127.0.0.1])
	by grelber.thyrsus.com (8.13.4/8.13.4) with ESMTP id jB5HaiDi005787
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 5 Dec 2005 12:36:49 -0500
From: Rob Landley <rob@landley.net>
Message-Id: <200512042003.48511.rob@landley.net>
In-Reply-To: <1133443051.6110.32.camel@noti>
References: <1133443051.6110.32.camel@noti>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [uml-devel] Fwd: Re: [PATCH 0/4] linux-2.6-block: deactivating
	pagecache for benchmarks
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 4 Dec 2005 18:03:48 -0800
To: user-mode-linux-devel@lists.sourceforge.net

Hey Jeff, you wanted the ability to shrink all the caches and free
up memory for the hotpluggy thing?

This is deeply, deeply cool.  (If kmail ate the spaces again, you can find
the original message on linux-kernel...)

Rob

----------  Forwarded Message  ----------

Subject: Re: [PATCH 0/4] linux-2.6-block: deactivating pagecache for benchmarks
Date: Thursday 01 December 2005 19:25
From: Andrew Morton <akpm@osdl.org>
To: Dirk Henning Gerdes <mail@dirk-gerdes.de>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org

Dirk Henning Gerdes <mail@dirk-gerdes.de> wrote:
>  For doing benchmarks on the I/O-Schedulers, I thought it would be very
>  useful to disable the pagecache.

That's an FAQ.   Something like this?


From: Andrew Morton <akpm@osdl.org>

Add /proc/sys/vm/drop-pagecache.  When written to, this will cause the kernel
to discard as much pagecache and reclaimable slab objects as it can.

It won't drop dirty data, so the user should run `sync' first.

Caveats:

a) Holds inode_lock for exorbitant amounts of time.

b) Needs to be taught about NUMA nodes: propagate these all the way through
   so the discarding can be controlled on a per-node basis.

c) The pagecache shrinking and slab shrinking should probably have separate
   controls.


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 fs/Makefile            |    2 -
 fs/drop-pagecache.c    |   62
 +++++++++++++++++++++++++++++++++++++++++++++++++ include/linux/mm.h     |  
  5 +++
 include/linux/sysctl.h |    1
 kernel/sysctl.c        |    9 +++++++
 mm/truncate.c          |    1
 mm/vmscan.c            |    3 --
 7 files changed, 79 insertions(+), 4 deletions(-)

diff -puN /dev/null fs/drop-pagecache.c
--- /dev/null 2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/fs/drop-pagecache.c 2005-12-01 17:20:55.000000000 -0800
@@ -0,0 +1,62 @@
+/*
+ * Implement the manual drop-all-pagecache function
+ */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/fs.h>
+#include <linux/writeback.h>
+#include <linux/sysctl.h>
+#include <linux/gfp.h>
+
+static void drop_pagecache_sb(struct super_block *sb)
+{
+ struct inode *inode;
+
+ spin_lock(&inode_lock);
+ list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+  if (inode->i_state & (I_FREEING|I_WILL_FREE))
+   continue;
+  invalidate_inode_pages(inode->i_mapping);
+ }
+ spin_unlock(&inode_lock);
+}
+
+static void drop_pagecache(void)
+{
+ struct super_block *sb;
+
+ spin_lock(&sb_lock);
+restart:
+ list_for_each_entry(sb, &super_blocks, s_list) {
+  sb->s_count++;
+  spin_unlock(&sb_lock);
+  down_read(&sb->s_umount);
+  if (sb->s_root)
+   drop_pagecache_sb(sb);
+  up_read(&sb->s_umount);
+  spin_lock(&sb_lock);
+  if (__put_super_and_need_restart(sb))
+   goto restart;
+ }
+ spin_unlock(&sb_lock);
+ printk("shrunk pagecache\n");
+}
+
+static void drop_slab(void)
+{
+ int nr_objects;
+
+ do {
+  nr_objects = shrink_slab(1000, GFP_KERNEL, 1000);
+  printk("shrunk %d cache objects\n", nr_objects);
+ } while (nr_objects > 10);
+}
+
+int drop_pagecache_sysctl_handler(ctl_table *table, int write,
+ struct file *file, void __user *buffer, size_t *length, loff_t *ppos)
+{
+ drop_pagecache();
+ drop_slab();
+ return 0;
+}
diff -puN fs/Makefile~drop-pagecache fs/Makefile
--- devel/fs/Makefile~drop-pagecache 2005-12-01 16:41:22.000000000 -0800
+++ devel-akpm/fs/Makefile 2005-12-01 16:41:22.000000000 -0800
@@ -10,7 +10,7 @@ obj-y := open.o read_write.o file_table.
   ioctl.o readdir.o select.o fifo.o locks.o dcache.o inode.o \
   attr.o bad_inode.o file.o filesystems.o namespace.o aio.o \
   seq_file.o xattr.o libfs.o fs-writeback.o mpage.o direct-io.o \
-  ioprio.o pnode.o
+  ioprio.o pnode.o drop-pagecache.o

 obj-$(CONFIG_INOTIFY)  += inotify.o
 obj-$(CONFIG_EPOLL)  += eventpoll.o
diff -puN include/linux/mm.h~drop-pagecache include/linux/mm.h
--- devel/include/linux/mm.h~drop-pagecache 2005-12-01 16:41:22.000000000
 -0800 +++ devel-akpm/include/linux/mm.h 2005-12-01 17:01:57.000000000 -0800
 @@ -1078,5 +1078,10 @@ int in_gate_area_no_task(unsigned long a
 /* /proc/<pid>/oom_adj set to -17 protects from the oom-killer */
 #define OOM_DISABLE -17

+int drop_pagecache_sysctl_handler(struct ctl_table *, int, struct file *,
+     void __user *, size_t *, loff_t *);
+int shrink_slab(unsigned long scanned, gfp_t gfp_mask,
+   unsigned long lru_pages);
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff -puN include/linux/sysctl.h~drop-pagecache include/linux/sysctl.h
--- devel/include/linux/sysctl.h~drop-pagecache 2005-12-01 16:41:22.000000000
 -0800 +++ devel-akpm/include/linux/sysctl.h 2005-12-01 16:41:22.000000000
 -0800 @@ -182,6 +182,7 @@ enum
  VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space
 layout */ VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
  VM_SWAP_PREFETCH=29, /* int: amount to swap prefetch */
+ VM_DROP_PAGECACHE=30, /* int: nuke lots of pagecache */
 };


diff -puN kernel/sysctl.c~drop-pagecache kernel/sysctl.c
--- devel/kernel/sysctl.c~drop-pagecache 2005-12-01 16:41:22.000000000 -0800
+++ devel-akpm/kernel/sysctl.c 2005-12-01 16:41:22.000000000 -0800
@@ -783,6 +783,15 @@ static ctl_table vm_table[] = {
   .strategy = &sysctl_intvec,
  },
  {
+  .ctl_name = VM_DROP_PAGECACHE,
+  .procname = "drop-pagecache",
+  .data  = NULL,
+  .maxlen  = sizeof(int),
+  .mode  = 0644,
+  .proc_handler = drop_pagecache_sysctl_handler,
+  .strategy = &sysctl_intvec,
+ },
+ {
   .ctl_name = VM_MIN_FREE_KBYTES,
   .procname = "min_free_kbytes",
   .data  = &min_free_kbytes,
diff -puN mm/truncate.c~drop-pagecache mm/truncate.c
--- devel/mm/truncate.c~drop-pagecache 2005-12-01 16:49:06.000000000 -0800
+++ devel-akpm/mm/truncate.c 2005-12-01 16:49:13.000000000 -0800
@@ -256,7 +256,6 @@ unlock:
     break;
   }
   pagevec_release(&pvec);
-  cond_resched();
  }
  return ret;
 }
diff -puN mm/vmscan.c~drop-pagecache mm/vmscan.c
--- devel/mm/vmscan.c~drop-pagecache 2005-12-01 16:58:30.000000000 -0800
+++ devel-akpm/mm/vmscan.c 2005-12-01 17:00:39.000000000 -0800
@@ -181,8 +181,7 @@ EXPORT_SYMBOL(remove_shrinker);
  *
  * Returns the number of slab objects which we shrunk.
  */
-static int shrink_slab(unsigned long scanned, gfp_t gfp_mask,
-   unsigned long lru_pages)
+int shrink_slab(unsigned long scanned, gfp_t gfp_mask, unsigned long
 lru_pages) {
  struct shrinker *shrinker;
  int ret = 0;
_

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

-------------------------------------------------------

-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
