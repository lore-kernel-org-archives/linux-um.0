Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Axvlp-0006UZ-Nu for User-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Mar 2004 14:20:17 -0800
Received: from zcars04f.nortelnetworks.com ([47.129.242.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AxvZs-0004l0-2A for User-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Mar 2004 14:07:56 -0800
Message-ID: <4043B42A.10803@nortelnetworks.com>
From: Chris Friesen <cfriesen@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] problems with UML, issues with includes
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
Date: Mon, 01 Mar 2004 17:07:38 -0500
To: Jeff Dike <jdike@addtoit.com>, User-mode-linux-devel <User-mode-linux-devel@lists.sourceforge.net>



I'm having issues with UML.

I've got a rootfs that used to work with an older UML.  With 2.4.24, I 
try and boot with the following arguments:

./linux-2.4.24  mem=256M con0=fd:0,fd:1 con=pts ubd0=test,rootfs debug 
msp_view=build_neptune_2.0_int11

The msp_view thing causes additional mounts to be created at init time. 
  However, I get a bunch of errors in my console window when I try to 
log in:

ed Hat Linux release 8.0 (Psyche)
Plankton/CELP 2.5.0 - Kernel 2.4.24-1um on an i686

(none) login: Registering fd 47 twice
Irqs : 3, 3
Ids : 0xa022c3f8, 0xa022c3f8
Registering fd 47 twice
Irqs : 3, 3
Ids : 0xa022c3f8, 0xa022c3f8



If I then keep going, I end up with a whole bunch of lines like:

Failed to forward -1359446016 to pid 16452, err = 9


As part of my efforts to try and debug this, I wanted to dump out the 
names of the processes that were calling os_set_owner().  Accordingly in 
  um/os/file.c I included <linux/sched.c> and wrote some code with 
appropriate locking around the tasklist_lock so that I could match the 
pid against the process name.

When I compiled, it grabbed the sched.h from /usr/include rather than 
from the kernel build, and everything blew up.

So I guess I'm asking for help on two fronts.  1) How do I fix the build 
process to pick up the kernel includes (and why doesn't it do that by 
default?).  2) Any ideas why I'm getting the descriptor thing?

Thanks,

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
