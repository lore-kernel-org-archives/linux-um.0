Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpCzD-0001bP-4w for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 13:58:35 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CpCzC-0001Vb-Bp for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 13:58:35 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20050113210058.94CDC1FB6D@zion>
Subject: [uml-devel] [patch 05/11] uml: for ubd cmdline param use colon as
	delimiter
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
Date: Thu, 13 Jan 2005 22:00:58 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Currently we can use this syntax ubd<n>[<flags>]=file1,file2. However, writing
things as
	ubd0=~/Uml/file1,~/Uml/file2
does not work; in fact, the shell won't expand the second '~', since it's not
at a path beginning; possibly even other shell expansions don't work here. So
simply allow using, instead of the ',' separator, the ':' separator.

The ',' separator can still be used to preserve backward compatibility.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/drivers/ubd_kern.c |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff -puN arch/um/drivers/ubd_kern.c~uml-ubd-use-colon-as-delimiter arch/um/drivers/ubd_kern.c
--- linux-2.6.11/arch/um/drivers/ubd_kern.c~uml-ubd-use-colon-as-delimiter	2005-01-13 03:11:19.623337096 +0100
+++ linux-2.6.11-paolo/arch/um/drivers/ubd_kern.c	2005-01-13 03:11:19.640334512 +0100
@@ -337,6 +337,11 @@ static int ubd_setup_common(char *str, i
 
 	err = 0;
 	backing_file = strchr(str, ',');
+
+	if (!backing_file) {
+		backing_file = strchr(str, ':');
+	}
+
 	if(backing_file){
 		if(dev->no_cow)
 			printk(KERN_ERR "Can't specify both 'd' and a "
@@ -362,13 +367,22 @@ static int ubd_setup(char *str)
 
 __setup("ubd", ubd_setup);
 __uml_help(ubd_setup,
-"ubd<n>=<filename>\n"
+"ubd<n><flags>=<filename>[(:|,)<filename2>]\n"
 "    This is used to associate a device with a file in the underlying\n"
-"    filesystem. Usually, there is a filesystem in the file, but \n"
+"    filesystem. When specifying two filenames, the first one is the\n"
+"    COW name and the second is the backing file name. As separator you can\n"
+"    use either a ':' or a ',': the first one allows writing things like;\n"
+"	ubd0=~/Uml/root_cow:~/Uml/root_backing_file\n"
+"    while with a ',' the shell would not expand the 2nd '~'.\n"
+"    When using only one filename, UML will detect whether to thread it like\n"
+"    a COW file or a backing file. To override this detection, add the 'd'\n"
+"    flag:\n"
+"	ubd0d=BackingFile\n"
+"    Usually, there is a filesystem in the file, but \n"
 "    that's not required. Swap devices containing swap files can be\n"
 "    specified like this. Also, a file which doesn't contain a\n"
 "    filesystem can have its contents read in the virtual \n"
-"    machine by running dd on the device. n must be in the range\n"
+"    machine by running 'dd' on the device. <n> must be in the range\n"
 "    0 to 7. Appending an 'r' to the number will cause that device\n"
 "    to be mounted read-only. For example ubd1r=./ext_fs. Appending\n"
 "    an 's' (has to be _after_ 'r', if there is one) will cause data\n"
_


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
