Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jkhnq-0003UX-A6 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Apr 2008 08:38:06 -0700
Received: from qb-out-0506.google.com ([72.14.204.237])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jkhnp-0004ch-B7
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Apr 2008 08:38:06 -0700
Received: by qb-out-0506.google.com with SMTP id c8so917455qbc.4
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 12 Apr 2008 08:38:04 -0700 (PDT)
Date: Sat, 12 Apr 2008 23:34:23 +0800 (CST)
Message-Id: <20080412.233423.112727172.xiyou.wangcong@gmail.com>
From: WANG Cong <xiyou.wangcong@gmail.com>
Mime-Version: 1.0
Subject: [uml-devel] [Patch] UML: Make three functions static
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net


Make the following three functions static, since they don't need to be
global.

arch/um/drivers/mcast_kern.c::mcast_setup()
arch/um/drivers/mconsole_user.c::mconsole_reply_v0()
arch/um/drivers/port_user.c::port_pre_exec()

Compile testing passed.

Cc: Jeff Dike <jdike@addtoit.com>
Signed-off-by: WANG Cong <wangcong@zeuux.org>

---
 arch/um/drivers/mcast_kern.c    |    2 +-
 arch/um/drivers/mconsole_user.c |    2 +-
 arch/um/drivers/port_user.c     |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/mcast_kern.c b/arch/um/drivers/mcast_kern.c
index 822092f..8c4378a 100644
--- a/arch/um/drivers/mcast_kern.c
+++ b/arch/um/drivers/mcast_kern.c
@@ -58,7 +58,7 @@ static const struct net_kern_info mcast_kern_info = {
 	.write			= mcast_write,
 };
 
-int mcast_setup(char *str, char **mac_out, void *data)
+static int mcast_setup(char *str, char **mac_out, void *data)
 {
 	struct mcast_init *init = data;
 	char *port_str = NULL, *ttl_str = NULL, *remain;
diff --git a/arch/um/drivers/mconsole_user.c b/arch/um/drivers/mconsole_user.c
index 13af2f0..f8cf4c8 100644
--- a/arch/um/drivers/mconsole_user.c
+++ b/arch/um/drivers/mconsole_user.c
@@ -39,7 +39,7 @@ static struct mconsole_command commands[] = {
 /* Initialized in mconsole_init, which is an initcall */
 char mconsole_socket_name[256];
 
-int mconsole_reply_v0(struct mc_request *req, char *reply)
+static int mconsole_reply_v0(struct mc_request *req, char *reply)
 {
 	struct iovec iov;
 	struct msghdr msg;
diff --git a/arch/um/drivers/port_user.c b/arch/um/drivers/port_user.c
index addd759..d269ca3 100644
--- a/arch/um/drivers/port_user.c
+++ b/arch/um/drivers/port_user.c
@@ -153,7 +153,7 @@ struct port_pre_exec_data {
 	int pipe_fd;
 };
 
-void port_pre_exec(void *arg)
+static void port_pre_exec(void *arg)
 {
 	struct port_pre_exec_data *data = arg;
 
-- 
1.5.2.4


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
