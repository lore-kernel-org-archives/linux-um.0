Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DfQ06-000609-Sl	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 15:23:18 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DfQ05-0007IY-W2	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 15:23:18 -0700
Message-Id: <200506062008.j56K8962008952@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/5] UML - compile fixes for gcc 4
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
Date: Mon, 06 Jun 2005 16:08:09 -0400
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This is a bunch of compile fixes provoked by building UML with gcc 4.  There
are a bunch of signedness mismatches, a couple of uninitialized references,
and a botched C99 structure initialization which had somehow gone unnoticed.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc/arch/um/drivers/chan_user.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/drivers/chan_user.c	2005-05-26 17:16:46.000000000 -0400
+++ linux-2.6.12-rc/arch/um/drivers/chan_user.c	2005-05-28 21:54:51.000000000 -0400
@@ -168,7 +168,7 @@ static int winch_tramp(int fd, struct tt
 		printk("winch_tramp : failed to read synchronization byte\n");
 		printk("read failed, err = %d\n", -n);
 		printk("fd %d will not support SIGWINCH\n", fd);
-		*fd_out = -1;
+                pid = -1;
 	}
 	return(pid);
 }
@@ -186,7 +186,7 @@ void register_winch(int fd, struct tty_s
 	if(!CHOOSE_MODE_PROC(is_tracer_winch, is_skas_winch, pid, fd,
 			     tty) && (pid == -1)){
 		thread = winch_tramp(fd, tty, &thread_fd);
-		if(fd != -1){
+		if(thread > 0){
 			register_winch_irq(thread_fd, fd, thread, tty);
 
 			count = os_write_file(thread_fd, &c, sizeof(c));
Index: linux-2.6.12-rc/arch/um/drivers/net_user.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/drivers/net_user.c	2005-05-26 17:16:46.000000000 -0400
+++ linux-2.6.12-rc/arch/um/drivers/net_user.c	2005-05-28 21:54:51.000000000 -0400
@@ -32,7 +32,7 @@ int tap_open_common(void *dev, char *gat
 	return(0);
 }
 
-void tap_check_ips(char *gate_addr, char *eth_addr)
+void tap_check_ips(char *gate_addr, unsigned char *eth_addr)
 {
 	int tap_addr[4];
 
Index: linux-2.6.12-rc/arch/um/drivers/slip.h
===================================================================
--- linux-2.6.12-rc.orig/arch/um/drivers/slip.h	2005-03-02 02:38:37.000000000 -0500
+++ linux-2.6.12-rc/arch/um/drivers/slip.h	2005-05-27 12:47:29.000000000 -0400
@@ -12,8 +12,8 @@ struct slip_data {
 	char *addr;
 	char *gate_addr;
 	int slave;
-	char ibuf[ENC_BUF_SIZE];
-	char obuf[ENC_BUF_SIZE];
+	unsigned char ibuf[ENC_BUF_SIZE];
+	unsigned char obuf[ENC_BUF_SIZE];
 	int more; /* more data: do not read fd until ibuf has been drained */
 	int pos;
 	int esc;
Index: linux-2.6.12-rc/arch/um/drivers/slip_proto.h
===================================================================
--- linux-2.6.12-rc.orig/arch/um/drivers/slip_proto.h	2005-03-02 02:38:12.000000000 -0500
+++ linux-2.6.12-rc/arch/um/drivers/slip_proto.h	2005-05-27 13:18:45.000000000 -0400
@@ -12,7 +12,8 @@
 #define SLIP_ESC_END         0334	/* ESC ESC_END means END 'data'	*/
 #define SLIP_ESC_ESC         0335	/* ESC ESC_ESC means ESC 'data'	*/
 
-static inline int slip_unesc(unsigned char c,char *buf,int *pos, int *esc)
+static inline int slip_unesc(unsigned char c, unsigned char *buf, int *pos, 
+                             int *esc)
 {
 	int ret;
 
Index: linux-2.6.12-rc/arch/um/drivers/slirp.h
===================================================================
--- linux-2.6.12-rc.orig/arch/um/drivers/slirp.h	2005-03-02 02:38:06.000000000 -0500
+++ linux-2.6.12-rc/arch/um/drivers/slirp.h	2005-05-27 12:49:19.000000000 -0400
@@ -24,8 +24,8 @@ struct slirp_data {
 	struct arg_list_dummy_wrapper argw;
 	int pid;
 	int slave;
-	char ibuf[ENC_BUF_SIZE];
-	char obuf[ENC_BUF_SIZE];
+	unsigned char ibuf[ENC_BUF_SIZE];
+	unsigned char obuf[ENC_BUF_SIZE];
 	int more; /* more data: do not read fd until ibuf has been drained */
 	int pos;
 	int esc;
Index: linux-2.6.12-rc/arch/um/drivers/stderr_console.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/drivers/stderr_console.c	2005-03-02 02:38:17.000000000 -0500
+++ linux-2.6.12-rc/arch/um/drivers/stderr_console.c	2005-05-27 12:20:59.000000000 -0400
@@ -22,9 +22,9 @@ static void stderr_console_write(struct 
 }
 
 static struct console stderr_console = {
-	.name		"stderr",
-	.write		stderr_console_write,
-	.flags		CON_PRINTBUFFER,
+	.name		= "stderr",
+	.write		= stderr_console_write,
+	.flags		= CON_PRINTBUFFER,
 };
 
 static int __init stderr_console_init(void)
Index: linux-2.6.12-rc/arch/um/include/mconsole.h
===================================================================
--- linux-2.6.12-rc.orig/arch/um/include/mconsole.h	2005-03-02 02:38:07.000000000 -0500
+++ linux-2.6.12-rc/arch/um/include/mconsole.h	2005-05-27 12:26:55.000000000 -0400
@@ -56,7 +56,7 @@ struct mc_request
 	int as_interrupt;
 
 	int originating_fd;
-	int originlen;
+	unsigned int originlen;
 	unsigned char origin[128];			/* sockaddr_un */
 
 	struct mconsole_request request;
Index: linux-2.6.12-rc/arch/um/include/net_user.h
===================================================================
--- linux-2.6.12-rc.orig/arch/um/include/net_user.h	2005-03-02 02:38:33.000000000 -0500
+++ linux-2.6.12-rc/arch/um/include/net_user.h	2005-05-27 13:16:30.000000000 -0400
@@ -35,7 +35,7 @@ extern void *get_output_buffer(int *len_
 extern void free_output_buffer(void *buffer);
 
 extern int tap_open_common(void *dev, char *gate_addr);
-extern void tap_check_ips(char *gate_addr, char *eth_addr);
+extern void tap_check_ips(char *gate_addr, unsigned char *eth_addr);
 
 extern void read_output(int fd, char *output_out, int len);
 
Index: linux-2.6.12-rc/arch/um/include/os.h
===================================================================
--- linux-2.6.12-rc.orig/arch/um/include/os.h	2005-05-26 17:16:48.000000000 -0400
+++ linux-2.6.12-rc/arch/um/include/os.h	2005-05-28 21:54:56.000000000 -0400
@@ -136,7 +136,7 @@ extern int os_seek_file(int fd, __u64 of
 extern int os_open_file(char *file, struct openflags flags, int mode);
 extern int os_read_file(int fd, void *buf, int len);
 extern int os_write_file(int fd, const void *buf, int count);
-extern int os_file_size(char *file, long long *size_out);
+extern int os_file_size(char *file, unsigned long long *size_out);
 extern int os_file_modtime(char *file, unsigned long *modtime);
 extern int os_pipe(int *fd, int stream, int close_on_exec);
 extern int os_set_fd_async(int fd, int owner);
Index: linux-2.6.12-rc/arch/um/include/user_util.h
===================================================================
--- linux-2.6.12-rc.orig/arch/um/include/user_util.h	2005-05-26 17:16:47.000000000 -0400
+++ linux-2.6.12-rc/arch/um/include/user_util.h	2005-05-28 21:55:18.000000000 -0400
@@ -41,9 +41,6 @@ extern unsigned long highmem;
 extern char host_info[];
 
 extern char saved_command_line[];
-extern char command_line[];
-
-extern char *tempdir;
 
 extern unsigned long _stext, _etext, _sdata, _edata, __bss_start, _end;
 extern unsigned long _unprotected_end;
Index: linux-2.6.12-rc/arch/um/os-Linux/elf_aux.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/os-Linux/elf_aux.c	2005-05-27 13:11:16.000000000 -0400
+++ linux-2.6.12-rc/arch/um/os-Linux/elf_aux.c	2005-05-27 13:12:20.000000000 -0400
@@ -45,7 +45,11 @@ __init void scan_elf_aux( char **envp)
 				elf_aux_hwcap = auxv->a_un.a_val;
 				break;
 			case AT_PLATFORM:
-				elf_aux_platform = auxv->a_un.a_ptr;
+                                /* elf.h removed the pointer elements from
+                                 * a_un, so we have to use a_val, which is 
+                                 * all that's left.
+                                 */
+				elf_aux_platform = (char *) auxv->a_un.a_val;
 				break;
 			case AT_PAGESZ:
 				page_size = auxv->a_un.a_val;
Index: linux-2.6.12-rc/arch/um/os-Linux/file.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/os-Linux/file.c	2005-05-26 17:16:48.000000000 -0400
+++ linux-2.6.12-rc/arch/um/os-Linux/file.c	2005-05-28 21:54:56.000000000 -0400
@@ -363,7 +363,7 @@ int os_write_file(int fd, const void *bu
 		       (int (*)(int, void *, int)) write, copy_to_user_proc));
 }
 
-int os_file_size(char *file, long long *size_out)
+int os_file_size(char *file, unsigned long long *size_out)
 {
 	struct uml_stat buf;
 	int err;



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
