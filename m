Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mout.kundenserver.de ([212.227.126.130])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iTBw9-000169-R7
 for linux-um@lists.infradead.org; Fri, 08 Nov 2019 21:36:59 +0000
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 12/16] hostfs: pass 64-bit timestamps to/from user space
Date: Fri,  8 Nov 2019 22:32:50 +0100
Message-Id: <20191108213257.3097633-13-arnd@arndb.de>
In-Reply-To: <20191108213257.3097633-1-arnd@arndb.de>
References: <20191108213257.3097633-1-arnd@arndb.de>
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
To: y2038@lists.linaro.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Colin Ian King <colin.king@canonical.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>

The use of 'struct timespec' is deprecated in the kernel, so we
want to avoid the conversions from/to the proper timespec64
structure.

On the user space side, we have a 'struct timespec' that is defined
by the C library and that will be incompatible with the kernel's
view on 32-bit architectures once they move to a 64-bit time_t,
breaking the shared binary layout of hostfs_iattr and hostfs_stat.

This changes the two structures to use a new hostfs_timespec structure
with fixed 64-bit seconds/nanoseconds for passing the timestamps
between hostfs_kern.c and hostfs_user.c. With a new enough user
space side, this will allow timestamps beyond year 2038.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/hostfs/hostfs.h      | 22 +++++++++++++---------
 fs/hostfs/hostfs_kern.c | 15 +++++++++------
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/fs/hostfs/hostfs.h b/fs/hostfs/hostfs.h
index f4295aa19350..69cb796f6270 100644
--- a/fs/hostfs/hostfs.h
+++ b/fs/hostfs/hostfs.h
@@ -37,16 +37,20 @@
  * is on, and remove the appropriate bits from attr->ia_mode (attr is a
  * "struct iattr *"). -BlaisorBlade
  */
+struct hostfs_timespec {
+	long long tv_sec;
+	long long tv_nsec;
+};
 
 struct hostfs_iattr {
-	unsigned int	ia_valid;
-	unsigned short	ia_mode;
-	uid_t		ia_uid;
-	gid_t		ia_gid;
-	loff_t		ia_size;
-	struct timespec	ia_atime;
-	struct timespec	ia_mtime;
-	struct timespec	ia_ctime;
+	unsigned int		ia_valid;
+	unsigned short		ia_mode;
+	uid_t			ia_uid;
+	gid_t			ia_gid;
+	loff_t			ia_size;
+	struct hostfs_timespec	ia_atime;
+	struct hostfs_timespec	ia_mtime;
+	struct hostfs_timespec	ia_ctime;
 };
 
 struct hostfs_stat {
@@ -56,7 +60,7 @@ struct hostfs_stat {
 	unsigned int uid;
 	unsigned int gid;
 	unsigned long long size;
-	struct timespec atime, mtime, ctime;
+	struct hostfs_timespec atime, mtime, ctime;
 	unsigned int blksize;
 	unsigned long long blocks;
 	unsigned int maj;
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 5a7eb0c79839..e6b8c49076bb 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -549,9 +549,9 @@ static int read_name(struct inode *ino, char *name)
 	set_nlink(ino, st.nlink);
 	i_uid_write(ino, st.uid);
 	i_gid_write(ino, st.gid);
-	ino->i_atime = timespec_to_timespec64(st.atime);
-	ino->i_mtime = timespec_to_timespec64(st.mtime);
-	ino->i_ctime = timespec_to_timespec64(st.ctime);
+	ino->i_atime = (struct timespec64){ st.atime.tv_sec, st.atime.tv_nsec };
+	ino->i_mtime = (struct timespec64){ st.mtime.tv_sec, st.mtime.tv_nsec };
+	ino->i_ctime = (struct timespec64){ st.ctime.tv_sec, st.ctime.tv_nsec };
 	ino->i_size = st.size;
 	ino->i_blocks = st.blocks;
 	return 0;
@@ -820,15 +820,18 @@ static int hostfs_setattr(struct dentry *dentry, struct iattr *attr)
 	}
 	if (attr->ia_valid & ATTR_ATIME) {
 		attrs.ia_valid |= HOSTFS_ATTR_ATIME;
-		attrs.ia_atime = timespec64_to_timespec(attr->ia_atime);
+		attrs.ia_atime = (struct hostfs_timespec)
+			{ attr->ia_atime.tv_sec, attr->ia_atime.tv_nsec };
 	}
 	if (attr->ia_valid & ATTR_MTIME) {
 		attrs.ia_valid |= HOSTFS_ATTR_MTIME;
-		attrs.ia_mtime = timespec64_to_timespec(attr->ia_mtime);
+		attrs.ia_mtime = (struct hostfs_timespec)
+			{ attr->ia_mtime.tv_sec, attr->ia_mtime.tv_nsec };
 	}
 	if (attr->ia_valid & ATTR_CTIME) {
 		attrs.ia_valid |= HOSTFS_ATTR_CTIME;
-		attrs.ia_ctime = timespec64_to_timespec(attr->ia_ctime);
+		attrs.ia_ctime = (struct hostfs_timespec)
+			{ attr->ia_ctime.tv_sec, attr->ia_ctime.tv_nsec };
 	}
 	if (attr->ia_valid & ATTR_ATIME_SET) {
 		attrs.ia_valid |= HOSTFS_ATTR_ATIME_SET;
-- 
2.20.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

