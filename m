Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CDwEP-0001Vh-Bn for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 02 Oct 2004 19:36:13 -0700
Received: from nudl.linbit.com ([212.69.162.21] helo=mail.linbit.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CDwDE-0007CS-KM for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 02 Oct 2004 19:36:13 -0700
Received: from minna.local (dialin-212-144-197-016.arcor-ip.net
	[212.144.197.16])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id E46301430C
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun,  3 Oct 2004 04:34:54 +0200 (CEST)
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
Message-ID: </ydgn6vAKqzNNA6XYwRcEgI=lge@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] uml "ip header error" for large (fragmented) udp packets
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
Date: Sun, 3 Oct 2004 04:36:01 +0200
To: user-mode-linux-devel@lists.sourceforge.net


in the upcomming new heartbeat design of linux-ha, we use relatively
large udp packets (passing large xml blobs back and forth between the
nodes). now, cluster development and testing is convenient on UML.

but:
 uml seems to silently and systematically lose all fragmented
 udp packets, that is packages larger than mtu, and 1480 byte
 max for xml blobs just does not work out too good ...

I investigated a little bit (using two simple perl snippets to
generate/[not]receive the udp packets), and it turns out that:

 sending large (up to 64K; fragmented) udp packets
 using tuntap:
  HOST -> UML  works.
  UML  -> HOST nope :(
  UML <-> UML  nope :( [ neither with mcast or other ]
 
 looking into /proc/net/snmp on the UMLs and the HOST
 show on the not receiving side an increase of
 InHdrError!
 (it never is reassembled into a proper udp packet)
 
this is easy to reproduce (because it just happens all the time)
tested with 2.6.6 and 2.6.8 plus respective UML patches.

it seems to me that UML corrupts the ip header of
fragmented udp packets somehow at sending time.

I wonder, if someone uses nfs over udp on uml, this should
be a long known issue and turn up loads of hits in a search.
I did not find a single reference to that problem, though.

the way it is now we probably need to reanimate some of our old
boxes to form a real test cluster. and believe me, that is no fun :(

if some kind soul would be able to fix that...
would make cluster testing as we do it
so much more convenient :-)

thanks,

	Lars Ellenberg

please CC me, I'm not subscribed on this list.


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
