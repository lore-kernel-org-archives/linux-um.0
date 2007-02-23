Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HKfHT-0005CV-Nv for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Feb 2007 10:36:32 -0800
Received: from smtp.andrew.cmu.edu ([128.2.10.82])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HKfHS-000178-AT
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Feb 2007 10:36:31 -0800
Received: from [192.168.0.179] (HARTMANIS.ECE.CMU.EDU [128.2.134.76])
	by smtp.andrew.cmu.edu (8.13.6/8.13.6) with ESMTP id l1NIaRtf020085
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 23 Feb 2007 13:36:27 -0500
Mime-Version: 1.0 (Apple Message framework v752.3)
Message-Id: <16D2BFFB-B00F-4C9D-82E4-9194D37FA95D@cmu.edu>
From: Bryan Parno <parno@cmu.edu>
Date: Fri, 23 Feb 2007 13:36:12 -0500
Subject: [uml-devel] Kernel access to user memory in SKAS
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
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

	I'm interested in mediating accesses by the UML guest kernel to  
memory used by the UML guest processes.  At present, I'm looking at a  
scenario using SKAS3, so the kernel has an address space distinct  
from that of the user processes.  I guess I'm a bit confused as to  
how the guest kernel actually manages to touch guest process memory  
(e.g., for copying system call arguments).  Looking through /arch/um/ 
kernel/skas/uaccess.c, it appears that all of these accesses devolve  
to performing a strncpy or memcpy, but I don't see a translation from  
an address in the user's address space to one in the kernel's address  
space.  Does this happen somewhere else, or am I misunderstanding  
SKAS?  Looking through the documentation on the site, I was unable to  
find any diagrams or explanations for how the guest kernel actually  
lays out memory in its address space.  Any comments or suggestions  
would be greatly appreciated!


                        Bryan




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
