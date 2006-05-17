Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FgLhr-0006wM-FZ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 May 2006 06:04:51 -0700
Received: from 245-051.dyn-fa.pool.ew.hu ([193.226.245.51]
	helo=dorka.pomaz.szeredi.hu)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FgLhq-0008Gu-44
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 May 2006 06:04:51 -0700
Message-Id: <E1FgLhI-0001eK-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Subject: [uml-devel] klibc build broken on UML
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
Date: Wed, 17 May 2006 15:04:16 +0200
To: linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net, hpa@zytor.com, akpm@osdl.org

I get this on 2.6.17-rc4-mm1:

  CHK     include/linux/compile.h
/usr/src/quilt/linux/scripts/Kbuild.klibc:60: /usr/src/quilt/linux/usr/klibc/arch/um/MCONFIG: No such file or directory
usr/klibc/Kbuild:71: usr/klibc/arch/um/Makefile.inc: No such file or directory
make[2]: *** No rule to make target `usr/klibc/arch/um/Makefile.inc'.  Stop.
make[1]: *** [_usr_klibc] Error 2
make: *** [usr] Error 2

Miklos


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
