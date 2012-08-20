Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sage@inktank.com>) id 1T3VAQ-0006cx-Mv
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Aug 2012 16:49:30 +0000
Received: from cobra.newdream.net ([66.33.216.30])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T3VAP-000868-Io for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Aug 2012 16:49:30 +0000
Date: Mon, 20 Aug 2012 09:49:23 -0700 (PDT)
From: Sage Weil <sage@inktank.com>
Message-ID: <alpine.DEB.2.00.1208200947470.9242@cobra.newdream.net>
MIME-Version: 1.0
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
Subject: [uml-devel] build error on 3.6-rc1 and later
To: jdike@addtoit.com, richard@nod.at, user-mode-linux-devel@lists.sourceforge.net

I'm getting

arch/um/os-Linux/time.c: In function 'deliver_alarm':
arch/um/os-Linux/time.c:117:3: error: too few arguments to function 'alarm_handler'
In file included from arch/um/os-Linux/time.c:13:0:
arch/um/os-Linux/internal.h:1:6: note: declared here

on 3.6-rc1 and later.  FWIW I blindly added an extra NULL argument and it 
seems to behave:

diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index f602385..0748fe0 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -114,7 +114,7 @@ static void deliver_alarm(void)
        skew += this_tick - last_tick;
 
        while (skew >= one_tick) {
-               alarm_handler(SIGVTALRM, NULL);
+               alarm_handler(SIGVTALRM, NULL, NULL);
                skew -= one_tick;
        }
 
sage

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

