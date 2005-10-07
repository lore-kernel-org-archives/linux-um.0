Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ENtDV-0002JY-Mj	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Oct 2005 07:28:57 -0700
Received: from mail.nagafix.co.uk ([213.228.237.37])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1ENtDT-0003z9-3C
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Oct 2005 07:28:57 -0700
From: Antoine Martin <antoine@nagafix.co.uk>
Content-Type: text/plain
Message-Id: <1128695313.15932.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] 2.6.13-bs3 amd64 compilation broken?
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
Date: Fri, 07 Oct 2005 15:28:33 +0100
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>, Blaisorblade <blaisorblade@yahoo.it>

I tried twice to be sure, but compile fails near the end:

 CC      arch/um/sys-x86_64/stub_segv.o
arch/um/sys-x86_64/stub_segv.c: In function `stub_segv_handler':
arch/um/sys-x86_64/stub_segv.c:41: warning: implicit declaration of
function `container_of'
arch/um/sys-x86_64/stub_segv.c:41: error: parse error before "struct"
make[1]: *** [arch/um/sys-x86_64/stub_segv.o] Error 1
make: *** [arch/um/sys-x86_64] Error 2

Antoine



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
