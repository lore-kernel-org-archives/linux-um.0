Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cc9XL-0006Vs-My for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Dec 2004 13:39:51 -0800
Received: from pike.sandelman.ca ([205.150.200.164])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1Cc9Wq-0001eK-QU
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Dec 2004 13:39:51 -0800
Subject: Re: [uml-devel] Re: What to do with uml_switch? 
In-Reply-To: Message from "Steve Schmidtke" <steve_schmidtke@hotmail.com> 
	of "Wed,
	08 Dec 2004 19:36:25 GMT." <BAY24-F39F020DFE0870A8FDC91DC83B60@phx.gbl>
References: <BAY24-F39F020DFE0870A8FDC91DC83B60@phx.gbl> 
Message-ID: <9866.1102541879@marajade.sandelman.ottawa.on.ca>
From: Michael Richardson <mcr@sandelman.ottawa.on.ca>
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
Date: Wed, 08 Dec 2004 16:37:59 -0500
To: Steve Schmidtke <steve_schmidtke@hotmail.com>
Cc: kraxel@bytesex.org, blaisorblade_spam@yahoo.it, uml@uxu.ch, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----


>>>>> "Steve" == Steve Schmidtke <steve_schmidtke@hotmail.com> writes:
    Gerd> Hmm, I don't think it is a good idea to put that kind of
    Gerd> testing code into the switch daemon.  I'd make the switch
    Gerd> daemon behave as close as possible to a real switch, then use
    Gerd> the normal tools you use for real networks as well.  I think
    Gerd> uml_switch should just support a monitor port which will see

    >> Not practical, not reliable.

    Steve> Why not reliable?  A monitor port is a diagnostic tool, and

  What would I connect to the monitor port? Another UML? 

  This is the part that isn't practical.
  My test cases sometimes have as many as 7 networks. Remember that we
have 170 test cases, and growing. Remember that we may have packets akin
to "ping-of-death", that may cause the Linux network stack to "oops".
  (this isn't a good, but that's the point of regression tests... is to
make sure that old bugs do not get re-introduced)

  So, we have to start the UMLs for each test, as they may have died.
To make it simple, we start/stop all of the UMLs each time.

  The reason for having the ability to capture and play-back pcap files
in the uml_netjig is to eliminate the need to run as many UMLs.

    Steve> There is no reason you would need to use Linux as your packet
    Steve> source:

    Steve>   cat tcpdump.pcap | switch_mon_tool --socket /tmp/uml.mon
    Steve> --delay 100ms

    Steve> is the type of functionality I'm shooting for (above example
    Steve> not to be taken literally).

  Great. That works for 1 network.

  Now, how do you replay packets where you need an actual time sequence
diagram to make it work? I.e.
	   - send packet A on network 1
	   - send packet B on network 2
	   - send packet C on network 1
	   - send packet D on network 2

  In most cases, we have found round-robin amount input sources works
well, but in that we are disappointed with. 

  Further, remember that you may want to single step the packet sources,
because, you may spend *HOURS* in the debugger (with the UML in
question). That's hard with the method you proposed.

- -- 
]       ON HUMILITY: to err is human. To moo, bovine.           |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [






-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Finger me for keys

iQCVAwUBQbd0NIqHRg3pndX9AQEZFgQA5vDKTWQviO9NSLr9Y6Pkvq23KQbWPop2
GyR04q/ALPlMSbdPqsJfHFsqCXLZF/gmftZH6Cp52XpXX4AO7+7x47aUDG7SW2ug
WxYjBJVqHBgBSJQNHkpcXwswqJPV4fidMyiN0X60PtmW+o6hMa/NXr9LPFcElwVw
FiEFd3ONQ7U=
=F82m
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
