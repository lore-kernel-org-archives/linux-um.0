Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CD2FX-0003oh-KU for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Sep 2004 07:49:39 -0700
Received: from carriage.microbus.com ([195.224.204.205])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CD2FW-0007Ff-LZ for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Sep 2004 07:49:39 -0700
Message-ID: <415C1CFE.3010405@microbus.com>
From: Robbie Dinn <robbie@microbus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] No rule to make target
	`arch/um/os-Linux/sys-i386/registers.c'
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
Date: Thu, 30 Sep 2004 15:49:34 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I have just been building linux-2.6.9-rc2-mm4 + incremental patches
from http://user-mode-linux.sourceforge.net/patches.html downloaded
fresh today.

I think the i386 UML target is broken.

I got a build error when doing make:

robbie@linux-uml:~/linux-2.6.9-rc2-mm4-um> make ARCH=um linux
[snip]
   LD      arch/um/os-Linux/drivers/tuntap.o
   LD      arch/um/os-Linux/drivers/built-in.o
make[2]: *** No rule to make target 
`arch/um/os-Linux/sys-i386/registers.c', needed by 
`arch/um/os-Linux/sys-i386/registers.o'.  Stop.
make[1]: *** [arch/um/os-Linux/sys-i386] Error 2
make: *** [arch/um/os-Linux] Error 2
robbie@linux-uml:~/linux-2.6.9-rc2-mm4-um>

I couldn't find arch/um/os-Linux/sys-i386/registers.c
but I looked in arch/um/os-Linux/sys-x86_64 and found a
one there.

I did

cp arch/um/os-Linux/sys-i386/registers.c 
arch/um/os-Linux/sys-x86_64/registers.c

then recompiled, and it build OK.
The UML kernel even booted too!



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
