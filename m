Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wv79-0008El-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 19:53:51 -0700
Received: from sat.sws.net.au ([202.5.161.49] ident=postfix)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19wv77-0005mA-Sj
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 09 Sep 2003 19:53:51 -0700
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
Subject: Re: [uml-devel] uml-patch-2.6.0-test5
References: <200309092235.h89MZU2J005307@ccure.karaya.com>
In-Reply-To: <200309092235.h89MZU2J005307@ccure.karaya.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tIpX/pDKHVGYpxK"
Message-Id: <200309101253.33028.russell@coker.com.au>
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
Date: Wed, 10 Sep 2003 12:53:33 +1000
To: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net



--Boundary-00=_tIpX/pDKHVGYpxK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 10 Sep 2003 08:35, Jeff Dike wrote:
> This patch updates UML to 2.6.0-test5.  There were a couple of bug fixes,
> but no functional changes in this patch.

The attached patch is needed on top of that for compiling UML with SE Linux 
support.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_tIpX/pDKHVGYpxK
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- include/asm-um/common.lds.S.orig	Wed Sep 10 04:33:15 2003
+++ include/asm-um/common.lds.S	Wed Sep 10 04:34:53 2003
@@ -78,6 +78,8 @@
   __uml_initcall_end = .;
   __init_end = .;
 
+  SECURITY_INIT
+
   __exitcall_begin = .;
   .exitcall : { *(.exitcall.exit) }
   __exitcall_end = .;

--Boundary-00=_tIpX/pDKHVGYpxK--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
