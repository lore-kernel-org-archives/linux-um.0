Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CanIY-0007Jf-0t for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 04 Dec 2004 19:42:58 -0800
Received: from pike.sandelman.ca ([205.150.200.164])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CanIX-0000TA-2K
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 04 Dec 2004 19:42:57 -0800
In-Reply-To: Message from Blaisorblade <blaisorblade_spam@yahoo.it> of "Sat,
	04 Dec 2004 04:52:32 +0100."
	<200412040452.32722.blaisorblade_spam@yahoo.it> 
References: <200412040452.32722.blaisorblade_spam@yahoo.it> 
Message-ID: <29928.1102218163@marajade.sandelman.ottawa.on.ca>
From: Michael Richardson <mcr@marajade.sandelman.ottawa.on.ca>
Subject: [uml-devel] Re: What to do with uml_switch?
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
Date: Sat, 04 Dec 2004 20:42:43 -0700
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: Gerd Knorr <kraxel@bytesex.org>, Steve Schmidtke <steve_schmidtke@hotmail.com>, Felix =?iso-8859-15?q?M=FCri?= <uml@uxu.ch>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----


>>>>> "Blaisorblade" == Blaisorblade  <blaisorblade_spam@yahoo.it> writes:
    Blaisorblade> Michael, could you start posting it here, instead that
    Blaisorblade> to Jeff (maybe you did and I didn't notice, if it was
    Blaisorblade> time ago, but now it's the moment to repost it).

  I can repost it if you like. 
  Give me a day to find my patches again.

  uml_netjig is a tool which does the following:
  
  1) moves packets using "daemon" mode a la uml_switch.
  2) has an expect-friendly command line interface 
  3) can create *multiple* switches and keep them seperate
  4) can record all packets to a .pcap file
  5) can play packets from a .pcap file at a given rate 
     (or under command line interface control)
  6) can optionally answer ARP queries for imaginary nodes.
  7) can talk to tuntap device(s) as uml_switch could.

  My patches refactor uml_switch to get uml_netjig + uml_switch'

    Blaisorblade> Felix, even if your newer code is not yet
    Blaisorblade> "releasable", it can help anyway... even just
    Blaisorblade> describing the changes you did and why... design ideas
    Blaisorblade> are more important than code itself sometimes.

  Please tell me what your code does...

    Blaisorblade> Steve, merging at least the earlier of your patches
    Blaisorblade> (they are splitup The Right Way(tm)) might be done
    Blaisorblade> soon, without lots of discussions.

  I have a lot of refactoring patches.
  I am willing to spend the time getting consensus among people who
have done other things, and integrating their patches with mine.

  See http://www.sandelman.ottawa.on.ca/SSW/freeswan/fsumltesting/
for an OLS paper on how uml_netjig was (and continues to be) used.
  We invoke about 170 tests every night on the Openswan code base.
some use as many as 7 UMLs connected via uml_netjig to get the job
done. 

- -- 
]       ON HUMILITY: to err is human. To moo, bovine.           |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Finger me for keys

iQCVAwUBQbKDsoqHRg3pndX9AQHAlQP8COxACR4RJFG6lvmhyGTwU0AVi0Xnm53k
1fVm6EfEhXid/vde5RbzM1aoKqA9fCOWJ5GyCVZltNxr1S8P9nuHb9UK7BkNQUKd
ezbjPZ55irSn+yonyOwT/ljHbzh/lFd5kxO5BmregjoRZdOUtqXfHAqQupX6lBix
XJiG4UVo5pk=
=wYSb
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
