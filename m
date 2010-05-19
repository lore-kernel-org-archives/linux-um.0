Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <antoine@nagafix.co.uk>) id 1OEiqV-000829-BX
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 May 2010 12:57:59 +0000
Received: from mamba.nagafix.co.uk ([194.145.196.68] helo=mail.nagafix.co.uk)
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OEiqT-0004CX-TR for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 May 2010 12:57:59 +0000
Received: (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: antoine@nagafix.co.uk)
	by mail.nagafix.co.uk (Postfix) with ESMTPSA id 7AFD96999
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 19 May 2010 13:57:50 +0100 (BST)
Message-ID: <4BF3E049.4060900@nagafix.co.uk>
Date: Wed, 19 May 2010 19:57:45 +0700
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
Subject: [uml-devel] something broke hppfs
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
To: user-mode-linux-devel@lists.sourceforge.net

   LD      fs/hostfs/hostfs.o
   LD      fs/hostfs/built-in.o
   CC      fs/hppfs/hppfs.o
fs/hppfs/hppfs.c: In function 'hppfs_fill_super':
fs/hppfs/hppfs.c:721: error: dereferencing pointer to incomplete type
make[2]: *** [fs/hppfs/hppfs.o] Error 1
make[1]: *** [fs/hppfs] Error 2
make: *** [fs] Error 2


------------------------------------------------------------------------------

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

