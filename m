Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A5UxD-0007Q1-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 03 Oct 2003 11:47:03 -0700
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A5UxC-00076E-5U
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 03 Oct 2003 11:47:02 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7Rcf/Mo61TpKtcY"
Message-Id: <200310032048.27028.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Errno handling bug
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 3 Oct 2003 20:48:27 +0200
To: user-mode-linux-devel@lists.sourceforge.net



--Boundary-00=_7Rcf/Mo61TpKtcY
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I posted this patch some time ago, but it was hidden inside an unrelated 
thread. It applies to .22-[345]um
**Description**
On the i386 arch(and I think others, too) the translation from 
return value(of calls like open(), fork()...) to errno setting is done in 
include/asm-i386/unistd.h. Instead, 
UML doesn't do it. I'm posting a patch to correct this in 
include/asm-um/unistd.h for mainline, but I think that parts of the rest of 
Uml will have to be changed, probably, to conform to the new(and correct) 
semantic.
**Why it IS needed**
Code inside the kernel relies on this behaviour. It's a things archs must do. 
So, it will have to end up in, at some point.
**Tested**
Yes, but not everything is clear. Stability is ok, but some error messages I 
get are strange:
modprobe: modprobe: Can't locate module char-major-10-135
request_module[char-major-10-135]: waitpid(26,...) failed, errno 0
Which however seems to be either fine or not related directly to this: waitpid 
returns 0 when no child is found, and maybe this happens here. However this 
is not clear to me.

If you agree that this patch will have to go in, I'll complete it with 
complete checking for errno. But I think I'll need a working version of 
-4um(I'm going to test -5um), since I think that version has added/changed 
also much uses of errno.
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN

--Boundary-00=_7Rcf/Mo61TpKtcY
Content-Type: text/x-diff;
  charset="us-ascii";
  name="errno.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="errno.patch"

--- linuxUm/include/asm-um/unistd.h.notfixed	2003-09-17 13:30:42.000000000 +0200
+++ linuxUm/include/asm-um/unistd.h	2003-09-17 19:15:58.000000000 +0200
@@ -33,7 +33,11 @@
 	set_fs(KERNEL_DS);			\
 	ret = sys(args);			\
 	set_fs(fs);				\
-	return ret;
+	if (ret < 0) {				\
+	  errno = -ret;				\
+	  return -1;				\
+	}					\
+	return 0;
 
 static inline long open(const char *pathname, int flags, int mode) 
 {

--Boundary-00=_7Rcf/Mo61TpKtcY--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
