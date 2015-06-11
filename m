Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hwhilse@gmail.com>) id 1Z2yoM-0003U5-78
	for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Jun 2015 09:30:10 +0000
Received: from mail-wi0-f175.google.com ([209.85.212.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z2yoL-00039F-7z
	for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Jun 2015 09:30:10 +0000
Received: by wiwd19 with SMTP id d19so69508085wiw.0
	for <User-mode-linux-devel@lists.sourceforge.net>;
	Thu, 11 Jun 2015 02:30:03 -0700 (PDT)
From: Hans-Werner Hilse <hwhilse@gmail.com>
Date: Thu, 11 Jun 2015 11:29:19 +0200
Message-Id: <1434014960-14774-3-git-send-email-hwhilse@gmail.com>
In-Reply-To: <1434014960-14774-1-git-send-email-hwhilse@gmail.com>
References: <1434014960-14774-1-git-send-email-hwhilse@gmail.com>
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
Subject: [uml-devel] [PATCH v2 2/3] um: Do not use stdin and stdout
	identifiers for struct members
To: User-mode-linux-devel@lists.sourceforge.net

stdin, stdout and stderr are macros according to C89/C99.
Thus do not use them as struct member identifiers to avoid
bad results from macro expansion.

Signed-off-by: Hans-Werner Hilse <hwhilse@gmail.com>
---
 arch/um/drivers/harddog_user.c         | 18 +++++++++---------
 arch/um/drivers/net_user.c             |  6 +++---
 arch/um/drivers/slip_user.c            | 14 +++++++-------
 arch/um/drivers/slirp_user.c           | 16 ++++++++--------
 arch/um/os-Linux/drivers/tuntap_user.c |  6 +++---
 5 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/um/drivers/harddog_user.c b/arch/um/drivers/harddog_user.c
index f99b32a..3aa8b0d 100644
--- a/arch/um/drivers/harddog_user.c
+++ b/arch/um/drivers/harddog_user.c
@@ -9,8 +9,8 @@
 #include <os.h>
 
 struct dog_data {
-	int stdin;
-	int stdout;
+	int stdin_fd;
+	int stdout_fd;
 	int close_me[2];
 };
 
@@ -18,11 +18,11 @@ static void pre_exec(void *d)
 {
 	struct dog_data *data = d;
 
-	dup2(data->stdin, 0);
-	dup2(data->stdout, 1);
-	dup2(data->stdout, 2);
-	close(data->stdin);
-	close(data->stdout);
+	dup2(data->stdin_fd, 0);
+	dup2(data->stdout_fd, 1);
+	dup2(data->stdout_fd, 2);
+	close(data->stdin_fd);
+	close(data->stdout_fd);
 	close(data->close_me[0]);
 	close(data->close_me[1]);
 }
@@ -49,8 +49,8 @@ int start_watchdog(int *in_fd_ret, int *out_fd_ret, char *sock)
 		goto out_close_in;
 	}
 
-	data.stdin = out_fds[0];
-	data.stdout = in_fds[1];
+	data.stdin_fd = out_fds[0];
+	data.stdout_fd = in_fds[1];
 	data.close_me[0] = out_fds[1];
 	data.close_me[1] = in_fds[0];
 
diff --git a/arch/um/drivers/net_user.c b/arch/um/drivers/net_user.c
index cd14157..e697a41 100644
--- a/arch/um/drivers/net_user.c
+++ b/arch/um/drivers/net_user.c
@@ -166,7 +166,7 @@ int net_sendto(int fd, void *buf, int len, void *to, int sock_len)
 
 struct change_pre_exec_data {
 	int close_me;
-	int stdout;
+	int stdout_fd;
 };
 
 static void change_pre_exec(void *arg)
@@ -174,7 +174,7 @@ static void change_pre_exec(void *arg)
 	struct change_pre_exec_data *data = arg;
 
 	close(data->close_me);
-	dup2(data->stdout, 1);
+	dup2(data->stdout_fd, 1);
 }
 
 static int change_tramp(char **argv, char *output, int output_len)
@@ -189,7 +189,7 @@ static int change_tramp(char **argv, char *output, int output_len)
 		return err;
 	}
 	pe_data.close_me = fds[0];
-	pe_data.stdout = fds[1];
+	pe_data.stdout_fd = fds[1];
 	pid = run_helper(change_pre_exec, &pe_data, argv);
 
 	if (pid > 0)	/* Avoid hang as we won't get data in failure case. */
diff --git a/arch/um/drivers/slip_user.c b/arch/um/drivers/slip_user.c
index 55c290d..0d6b66c 100644
--- a/arch/um/drivers/slip_user.c
+++ b/arch/um/drivers/slip_user.c
@@ -55,8 +55,8 @@ static int set_up_tty(int fd)
 }
 
 struct slip_pre_exec_data {
-	int stdin;
-	int stdout;
+	int stdin_fd;
+	int stdout_fd;
 	int close_me;
 };
 
@@ -64,9 +64,9 @@ static void slip_pre_exec(void *arg)
 {
 	struct slip_pre_exec_data *data = arg;
 
-	if (data->stdin >= 0)
-		dup2(data->stdin, 0);
-	dup2(data->stdout, 1);
+	if (data->stdin_fd >= 0)
+		dup2(data->stdin_fd, 0);
+	dup2(data->stdout_fd, 1);
 	if (data->close_me >= 0)
 		close(data->close_me);
 }
@@ -85,8 +85,8 @@ static int slip_tramp(char **argv, int fd)
 	}
 
 	err = 0;
-	pe_data.stdin = fd;
-	pe_data.stdout = fds[1];
+	pe_data.stdin_fd = fd;
+	pe_data.stdout_fd = fds[1];
 	pe_data.close_me = fds[0];
 	err = run_helper(slip_pre_exec, &pe_data, argv);
 	if (err < 0)
diff --git a/arch/um/drivers/slirp_user.c b/arch/um/drivers/slirp_user.c
index c999d18..98b6a41 100644
--- a/arch/um/drivers/slirp_user.c
+++ b/arch/um/drivers/slirp_user.c
@@ -20,18 +20,18 @@ static int slirp_user_init(void *data, void *dev)
 }
 
 struct slirp_pre_exec_data {
-	int stdin;
-	int stdout;
+	int stdin_fd;
+	int stdout_fd;
 };
 
 static void slirp_pre_exec(void *arg)
 {
 	struct slirp_pre_exec_data *data = arg;
 
-	if (data->stdin != -1)
-		dup2(data->stdin, 0);
-	if (data->stdout != -1)
-		dup2(data->stdout, 1);
+	if (data->stdin_fd != -1)
+		dup2(data->stdin_fd, 0);
+	if (data->stdout_fd != -1)
+		dup2(data->stdout_fd, 1);
 }
 
 static int slirp_tramp(char **argv, int fd)
@@ -39,8 +39,8 @@ static int slirp_tramp(char **argv, int fd)
 	struct slirp_pre_exec_data pe_data;
 	int pid;
 
-	pe_data.stdin = fd;
-	pe_data.stdout = fd;
+	pe_data.stdin_fd = fd;
+	pe_data.stdout_fd = fd;
 	pid = run_helper(slirp_pre_exec, &pe_data, argv);
 
 	return pid;
diff --git a/arch/um/os-Linux/drivers/tuntap_user.c b/arch/um/os-Linux/drivers/tuntap_user.c
index 14126d9..c2e6e1d 100644
--- a/arch/um/os-Linux/drivers/tuntap_user.c
+++ b/arch/um/os-Linux/drivers/tuntap_user.c
@@ -47,7 +47,7 @@ static void tuntap_del_addr(unsigned char *addr, unsigned char *netmask,
 }
 
 struct tuntap_pre_exec_data {
-	int stdout;
+	int stdout_fd;
 	int close_me;
 };
 
@@ -55,7 +55,7 @@ static void tuntap_pre_exec(void *arg)
 {
 	struct tuntap_pre_exec_data *data = arg;
 
-	dup2(data->stdout, 1);
+	dup2(data->stdout_fd, 1);
 	close(data->close_me);
 }
 
@@ -74,7 +74,7 @@ static int tuntap_open_tramp(char *gate, int *fd_out, int me, int remote,
 
 	sprintf(version_buf, "%d", UML_NET_VERSION);
 
-	data.stdout = remote;
+	data.stdout_fd = remote;
 	data.close_me = me;
 
 	pid = run_helper(tuntap_pre_exec, &data, argv);
-- 
2.4.2


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

