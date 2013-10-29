Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Tue, 29 Oct 2013 22:06:04 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <20131029190604.GA21820@longonot.mountain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131025144452.GA28451@ngolde.de>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [patch] uml: check length in exitcode_proc_write()
To: Jeff Dike <jdike@addtoit.com>
Cc: Fabian Yamaguchi <fabs@goesec.de>, security@kernel.org, user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, user-mode-linux-user@lists.sourceforge.net, Nico Golde <nico@ngolde.de>

We don't cap the size of buffer from the user so we could write past
the end of the array here.  Only root can write to this file.

Reported-by: Nico Golde <nico@ngolde.de>
Reported-by: Fabian Yamaguchi <fabs@goesec.de>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/arch/um/kernel/exitcode.c b/arch/um/kernel/exitcode.c
index 829df49..41ebbfe 100644
--- a/arch/um/kernel/exitcode.c
+++ b/arch/um/kernel/exitcode.c
@@ -40,9 +40,11 @@ static ssize_t exitcode_proc_write(struct file *file,
 		const char __user *buffer, size_t count, loff_t *pos)
 {
 	char *end, buf[sizeof("nnnnn\0")];
+	size_t size;
 	int tmp;
 
-	if (copy_from_user(buf, buffer, count))
+	size = min(count, sizeof(buf));
+	if (copy_from_user(buf, buffer, size))
 		return -EFAULT;
 
 	tmp = simple_strtol(buf, &end, 0);

------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

