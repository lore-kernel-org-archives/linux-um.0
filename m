Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A9Adg-0006o7-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 13 Oct 2003 14:54:05 -0700
Received: from web20307.mail.yahoo.com ([216.136.226.88])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A9Adg-0000SD-Hx
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 13 Oct 2003 14:54:04 -0700
Message-ID: <20031013215233.5560.qmail@web20307.mail.yahoo.com>
From: nitin rpr <nitin_rpr@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [uml-devel] 2.6 uml status
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
Date: Mon, 13 Oct 2003 14:52:33 -0700 (PDT)
To: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net

Hi All,
I have few questions about 2.6-uml:

1. it looks like uml options are there in
2.6-test7,does it mean we don't have to apply any
patch to kernel to get UML support. I tried to compile
kernel using 'make linux ARCH=um', i couldn't compile.
Any thought on this?

2. From the website, I found that umls has problem
when it is compiled with module support and suggested
woraround was to change the gccm has thie problem
being fixed. I am running test5 with available UML
patch, but I have never got success when I try to
compile with module support.

Any help on these issues will be highly appreciable.

Thanks,
nitin




__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
