Return-Path: <linux-kernel-owner@vger.kernel.org>
From: ira.weiny@intel.com
Subject: [PATCH RFC PKS/PMEM 44/58] drivers/xen: Utilize new kmap_thread()
Date: Fri,  9 Oct 2020 12:50:19 -0700
Message-Id: <20201009195033.3208459-45-ira.weiny@intel.com>
In-Reply-To: <20201009195033.3208459-1-ira.weiny@intel.com>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Ira Weiny <ira.weiny@intel.com>, Stefano Stabellini <sstabellini@kernel.org>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, kexec@lists.infradead.org, linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org, devel@driverdev.osuosl.org, linux-efi@vger.kernel.org, linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-um@lists.infradead.org, linux-ntfs-dev@lists.sourceforge.net, reiserfs-devel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-nilfs@vger.kernel.org, cluster-devel@redhat.com, ecryptfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-afs@lists.infradead.org, linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, xen-devel@lists.xenproject.org, linux-cachefs@redhat.com, samba-technical@lists.samba.org, intel-wired-lan@lists.osuosl.org
List-ID: <linux-um.lists.infradead.org>

From: Ira Weiny <ira.weiny@intel.com>

These kmap() calls are localized to a single thread.  To avoid the over
head of global PKRS updates use the new kmap_thread() call.

Cc: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/xen/gntalloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/gntalloc.c b/drivers/xen/gntalloc.c
index 3fa40c723e8e..3b78e055feff 100644
--- a/drivers/xen/gntalloc.c
+++ b/drivers/xen/gntalloc.c
@@ -184,9 +184,9 @@ static int add_grefs(struct ioctl_gntalloc_alloc_gref *op,
 static void __del_gref(struct gntalloc_gref *gref)
 {
 	if (gref->notify.flags & UNMAP_NOTIFY_CLEAR_BYTE) {
-		uint8_t *tmp = kmap(gref->page);
+		uint8_t *tmp = kmap_thread(gref->page);
 		tmp[gref->notify.pgoff] = 0;
-		kunmap(gref->page);
+		kunmap_thread(gref->page);
 	}
 	if (gref->notify.flags & UNMAP_NOTIFY_SEND_EVENT) {
 		notify_remote_via_evtchn(gref->notify.event);
-- 
2.28.0.rc0.12.gb6a658bd00c9


