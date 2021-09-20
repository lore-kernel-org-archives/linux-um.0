Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from zeniv-ca.linux.org.uk ([2607:5300:60:148a::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSQuN-003BP1-9g
 for linux-um@lists.infradead.org; Mon, 20 Sep 2021 21:33:07 +0000
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mSQuM-005yer-G2
 for linux-um@lists.infradead.org; Mon, 20 Sep 2021 21:33:02 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 14/15] um: header debriding - os.h
Date: Mon, 20 Sep 2021 21:33:00 +0000
Message-Id: <20210920213301.1424730-14-viro@zeniv.linux.org.uk>
In-Reply-To: <20210920213301.1424730-1-viro@zeniv.linux.org.uk>
References: <YUj9S+S4Gd86mM6N@zeniv-ca.linux.org.uk>
 <20210920213301.1424730-1-viro@zeniv.linux.org.uk>
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
To: linux-um@lists.infradead.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/include/shared/os.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 96d400387c93e..d01304354a525 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -159,20 +159,11 @@ extern int os_create_unix_socket(const char *file, int len, int close_on_exec);
 extern int os_shutdown_socket(int fd, int r, int w);
 extern void os_close_file(int fd);
 extern int os_rcv_fd(int fd, int *helper_pid_out);
-extern int create_unix_socket(char *file, int len, int close_on_exec);
 extern int os_connect_socket(const char *name);
 extern int os_file_type(char *file);
 extern int os_file_mode(const char *file, struct openflags *mode_out);
 extern int os_lock_file(int fd, int excl);
 extern void os_flush_stdout(void);
-extern int os_stat_filesystem(char *path, long *bsize_out,
-			      long long *blocks_out, long long *bfree_out,
-			      long long *bavail_out, long long *files_out,
-			      long long *ffree_out, void *fsid_out,
-			      int fsid_size, long *namelen_out,
-			      long *spare_out);
-extern int os_change_dir(char *dir);
-extern int os_fchange_dir(int fd);
 extern unsigned os_major(unsigned long long dev);
 extern unsigned os_minor(unsigned long long dev);
 extern unsigned long long os_makedev(unsigned major, unsigned minor);
@@ -232,7 +223,6 @@ extern char *get_umid(void);
 /* signal.c */
 extern void timer_set_signal_handler(void);
 extern void set_sigstack(void *sig_stack, int size);
-extern void remove_sigstack(void);
 extern void set_handler(int sig);
 extern void send_sigio_to_self(void);
 extern int change_sig(int signal, int on);
@@ -266,7 +256,6 @@ extern int os_timer_create(void);
 extern int os_timer_set_interval(unsigned long long nsecs);
 extern int os_timer_one_shot(unsigned long long nsecs);
 extern void os_timer_disable(void);
-extern void uml_idle_timer(void);
 extern long long os_persistent_clock_emulation(void);
 extern long long os_nsecs(void);
 
@@ -290,8 +279,6 @@ extern int is_skas_winch(int pid, int fd, void *data);
 extern int start_userspace(unsigned long stub_stack);
 extern int copy_context_skas0(unsigned long stack, int pid);
 extern void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs);
-extern int map_stub_pages(int fd, unsigned long code, unsigned long data,
-			  unsigned long stack);
 extern void new_thread(void *stack, jmp_buf *buf, void (*handler)(void));
 extern void switch_threads(jmp_buf *me, jmp_buf *you);
 extern int start_idle_thread(void *stack, jmp_buf *switch_buf);
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

