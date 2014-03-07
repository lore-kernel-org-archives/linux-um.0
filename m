Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1WLzeh-00007C-CQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Mar 2014 18:37:59 +0000
Received: from ivanoab3.miniserver.com ([89.200.143.206])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WLzeg-00012z-BT
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Mar 2014 18:37:59 +0000
From: anton.ivanov@kot-begemot.co.uk
Date: Fri,  7 Mar 2014 18:37:47 +0000
Message-Id: <1394217468-734972-2-git-send-email-anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <1394217468-734972-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
References: <1394217468-734972-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 2/3] BUG: Memory corruption on startup
To: user-mode-linux-devel@lists.sourceforge.net
Cc: richard@nod.at

From: Anton Ivanov <antivano@cisco.com>

The reverse case of this race (you must msync before read) is
well known. This is the not so common one.

It can be triggered only on systems which do a lot of task
switching and only at UML startup. If you are starting 200+ UMLs
~ 0.5% will always die without this fix.

Signed-off-by: Anton Ivanov <antivano@cisco.com>
---
 arch/um/include/shared/os.h |    1 +
 arch/um/kernel/physmem.c    |    1 +
 arch/um/os-Linux/file.c     |    6 ++++++
 3 files changed, 8 insertions(+)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 89b686c1..3c9738d 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -136,6 +136,7 @@ extern int os_ioctl_generic(int fd, unsigned int cmd, unsigned long arg);
 extern int os_get_ifname(int fd, char *namebuf);
 extern int os_set_slip(int fd);
 extern int os_mode_fd(int fd, int mode);
+extern int os_fsync_file(int fd);
 
 extern int os_seek_file(int fd, unsigned long long offset);
 extern int os_open_file(const char *file, struct openflags flags, int mode);
diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index f116db1..30fdd5d0 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -103,6 +103,7 @@ void __init setup_physmem(unsigned long start, unsigned long reserve_end,
 	 */
 	os_seek_file(physmem_fd, __pa(&__syscall_stub_start));
 	os_write_file(physmem_fd, &__syscall_stub_start, PAGE_SIZE);
+	os_fsync_file(physmem_fd);
 
 	bootmap_size = init_bootmem(pfn, pfn + delta);
 	free_bootmem(__pa(reserve_end) + bootmap_size,
diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index b049a63..c879b12 100644
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -237,6 +237,12 @@ void os_close_file(int fd)
 {
 	close(fd);
 }
+int os_fsync_file(int fd)
+{
+	if (fsync(fd) < 0) 
+	    return -errno
+	return 0;
+}
 
 int os_seek_file(int fd, unsigned long long offset)
 {
-- 
1.7.10.4


------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

