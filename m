Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BsS7Y-0005sn-W2 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 Aug 2004 13:12:20 -0700
Received: from zsc3s004.nortelnetworks.com ([47.81.138.65])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BsS7Y-0002m9-NB for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 Aug 2004 13:12:20 -0700
Received: from zsc3c028.us.nortel.com (zsc3c028.us.nortel.com [47.81.138.28])
	by zsc3s004.nortelnetworks.com (Switch-2.2.6/Switch-2.2.0) with
	ESMTP id i74KC8m14328
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 4 Aug 2004 13:12:08 -0700 (PDT)
Message-ID: <411142B4.7000603@nortelnetworks.com>
From: Joe Marzot <gmarzot@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Q: UML thread communication - scheduling oddness
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
Date: Wed, 04 Aug 2004 16:10:28 -0400
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Randy Macleod <macleodr@nortelnetworks.com>


We are seeing some sub-optimal behaviour (at least for our use) for 
communication between several UMLs. It appears the responsiveness of a 
given UML to application level network messaging is a function of how 
busy the serverside UML is.

That is, if I run a little busy loop

  /mnt/plankton/stress --cpu 1 --io 1

on the server side, the round trip time for messages is greatly 
*improved*. without this activity and a basically dormant server side 
UML the round trip times show considerable variabilty with gaps on the 
order of seconds.

Now for the question:

Can some one explain the event mechanism and communication pathways for 
network packets(using tuntap networking) delivered to the UML kernel and 
then for the kernel to a userspace process?

It looks like the kernel thread is responsive enough because if we do 
simple pings they don't suffer from the huge gaps as the user based 
pings do. I would like to understand how the kernel thread wakes up to 
grab the packets from the tap device and then how it notifies the user 
space thread to deal with it...ultimately maybe there is something we 
can do to make the userspace thread have less latency (other than 
running my dummy busy thing from above of course).

thanks for any help in understanding.

regards, Giovanni

ps. We are using 2.4.2x with 2.4.24-1 patch in skas mode



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
