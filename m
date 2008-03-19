Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jc4Aq-00080V-Kw for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Mar 2008 12:42:09 -0700
Received: from lana.hrz.tu-chemnitz.de ([134.109.132.3])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jc4Ap-00052s-84
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Mar 2008 12:42:08 -0700
Received: from csn-server.csn.tu-chemnitz.de ([134.109.101.249]
	helo=gondor.middle-earth.priv)
	by lana.hrz.tu-chemnitz.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.66) (envelope-from <chkr@plauener.de>) id 1Jc4Al-00046O-2S
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Mar 2008 20:42:03 +0100
Message-ID: <47E16C87.8080705@plauener.de>
Date: Wed, 19 Mar 2008 20:41:59 +0100
From: Christian Krause <chkr@plauener.de>
MIME-Version: 1.0
Subject: [uml-devel] small patch for small install problem of uml_utilities
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
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

During packaging of uml_utilities I've found a small problem during 
"make install":

in tools-20070815/humsify/Makefile the binary is installed via
"install -o 0755 $(BIN) $(DESTDIR)$(BIN_DIR)".
It looks like that "-o" is just a typo and that the intention was to set 
the mode with "-m 0755" and not the owner (with -o 0755, which makes no 
sense ;-) ).

Here is my patch I've used to fix the problem. Probably you can apply it 
to the official sources as well:

diff -uNr tools-20070815.orig/humfsify/Makefile 
tools-20070815/humfsify/Makefile
--- tools-20070815.orig/humfsify/Makefile       2006-05-25 
20:37:01.000000000 +0200
+++ tools-20070815/humfsify/Makefile    2008-03-19 20:29:50.000000000 +0100
@@ -4,7 +4,7 @@

 install:
        install -d $(DESTDIR)$(BIN_DIR)
-       install -o 0755 $(BIN) $(DESTDIR)$(BIN_DIR)
+       install -m 0755 $(BIN) $(DESTDIR)$(BIN_DIR)

 clean:
        rm -f *~


Thanks & Best regards,
Christian

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
