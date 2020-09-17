Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 00/13] Allow readpage to return a locked page
Date: Thu, 17 Sep 2020 16:10:37 +0100
Message-Id: <20200917151050.5363-1-willy@infradead.org>
MIME-Version: 1.0
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
To: linux-fsdevel@vger.kernel.org
Cc: linux-cifs@vger.kernel.org, Richard Weinberger <richard@nod.at>, ecryptfs@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org, linux-mtd@lists.infradead.org, v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org

Linus recently made the page lock more fair.  That means that the old
pattern where we returned from ->readpage with the page unlocked and
then attempted to re-lock it will send us to the back of the queue for
this page's lock.

Ideally all filesystems would return from ->readpage with the
page Uptodate and Locked, but it's a bit painful to convert all the
asynchronous readpage implementations to synchronous.  These ones are
already synchronous, so convert them while I work on iomap.

A further benefit is that a synchronous readpage implementation allows
us to return an error to someone who might actually care about it.
There's no need to SetPageError, but I don't want to learn about how
a dozen filesystems handle I/O errors (hint: they're all different),
so I have not attempted to change that.

Please review your filesystem carefully.  I've tried to catch all the
places where a filesystem calls its own internal readpage implementation
without going through ->readpage, but I may have missed some.

Matthew Wilcox (Oracle) (13):
  mm: Add AOP_UPDATED_PAGE return value
  9p: Tell the VFS that readpage was synchronous
  afs: Tell the VFS that readpage was synchronous
  ceph: Tell the VFS that readpage was synchronous
  cifs: Tell the VFS that readpage was synchronous
  cramfs: Tell the VFS that readpage was synchronous
  ecryptfs: Tell the VFS that readpage was synchronous
  fuse: Tell the VFS that readpage was synchronous
  hostfs: Tell the VFS that readpage was synchronous
  jffs2: Tell the VFS that readpage was synchronous
  ubifs: Tell the VFS that readpage was synchronous
  udf: Tell the VFS that readpage was synchronous
  vboxsf: Tell the VFS that readpage was synchronous

 Documentation/filesystems/locking.rst |  7 ++++---
 Documentation/filesystems/vfs.rst     | 21 ++++++++++++++-------
 fs/9p/vfs_addr.c                      |  6 +++++-
 fs/afs/file.c                         |  3 ++-
 fs/ceph/addr.c                        |  9 +++++----
 fs/cifs/file.c                        |  8 ++++++--
 fs/cramfs/inode.c                     |  5 ++---
 fs/ecryptfs/mmap.c                    | 11 ++++++-----
 fs/fuse/file.c                        |  2 ++
 fs/hostfs/hostfs_kern.c               |  2 ++
 fs/jffs2/file.c                       |  6 ++++--
 fs/ubifs/file.c                       | 16 ++++++++++------
 fs/udf/file.c                         |  3 +--
 fs/vboxsf/file.c                      |  2 ++
 include/linux/fs.h                    |  5 +++++
 mm/filemap.c                          | 12 ++++++++++--
 16 files changed, 80 insertions(+), 38 deletions(-)

-- 
2.28.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

