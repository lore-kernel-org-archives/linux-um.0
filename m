Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ego2I-00008v-96 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Nov 2005 10:47:34 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ego2H-0002FG-1I
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Nov 2005 10:47:34 -0800
Received: from localhost (localhost [127.0.0.1])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 5FF5844D76
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 28 Nov 2005 18:47:11 +0000 (GMT)
Received: from mail.nagafix.co.uk ([127.0.0.1])
	by localhost (viper.nagafix.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 32353-13 for
	<user-mode-linux-devel@lists.sourceforge.net>; 
	Mon, 28 Nov 2005 18:47:09 +0000 (GMT)
Received: from ant.internal (88-96-60-221.dsl.zen.co.uk [88.96.60.221])
	by mail.nagafix.co.uk (Postfix) with ESMTP id EA14E442B7
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 28 Nov 2005 18:47:08 +0000 (GMT)
From: Antoine Martin <antoine@nagafix.co.uk>
Content-Type: text/plain
Message-Id: <1133203631.2899.10.camel@ant.internal>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] 2.6.15-rc2-mm1: sysrq.o error: dereferencing pointer to
	incomplete type
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
Date: Mon, 28 Nov 2005 18:47:11 +0000
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

  CC      arch/um/sys-x86_64/syscalls.o
  CC      arch/um/sys-x86_64/sysrq.o
arch/um/sys-x86_64/sysrq.c: In function `__show_regs':
arch/um/sys-x86_64/sysrq.c:19: error: dereferencing pointer to
incomplete type
arch/um/sys-x86_64/sysrq.c:19: error: dereferencing pointer to
incomplete type
make[1]: *** [arch/um/sys-x86_64/sysrq.o] Error 1
make: *** [arch/um/sys-x86_64] Error 2




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
