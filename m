Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AAf0J-0000CY-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 17 Oct 2003 17:31:35 -0700
Received: from postman2.arcor-online.net ([151.189.0.188] helo=postman.arcor.de)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 1AAezt-0005l9-HQ
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 17 Oct 2003 17:31:09 -0700
Received: from basil.home.vitoni.de (dsl-082-082-127-008.arcor-ip.net [82.82.127.8])
	(authenticated bits=0)
	by postman.arcor.de (8.12.9/8.12.9) with ESMTP id h9I0T8gj005835
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 18 Oct 2003 02:29:09 +0200 (MEST)
Received: from vitoni.de (hal-9000 [192.168.127.11])
	by basil.home.vitoni.de (Postfix) with ESMTP id 1C3C488CD8
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 18 Oct 2003 02:29:08 +0200 (CEST)
Message-ID: <3F908967.D6633EFB@vitoni.de>
From: Victor <user-mode-linux-devel@vitoni.de>
MIME-Version: 1.0
Subject: [uml-devel] skas, block devices
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
Date: Sat, 18 Oct 2003 02:29:27 +0200
To: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

I am fairly new to uml so please excuse me if this is not the place to
put my questions, or if these questions are already answered.
I searched a bit but didn't found what I was looking for.

1. skas:
What about including it into the UML-patch. This way there would be only
one patch to apply and the source could just be copied to have to trees
(one as host, one uml).
A nicer solution would be the possibility to create a uml out of the
source by using a different config file, but I don't know about
conflicts between static drivers and driver modules or uml / host linux.

Is there a roadmap for skas4?


2. block devices:
A nice feature would be the possibility to use disk dumps as a block
device. It would help to test automatic installations or distros which
rely on normal filesystems or device. Something like "linux
hda=hda-dump" would save some ubdX.

My favourite use case would the transfer of my harware linux
router/firewall into a uml environment. I could do it with udbS




-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
