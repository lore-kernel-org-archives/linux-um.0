Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CcCBj-0002vS-NU for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Dec 2004 16:29:43 -0800
Received: from bay24-f35.bay24.hotmail.com ([64.4.18.85] helo=hotmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CcCBF-0000mv-9D for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Dec 2004 16:29:43 -0800
Message-ID: <BAY24-F35756E3C80A5A70F07558B83B70@phx.gbl>
In-Reply-To: <9866.1102541879@marajade.sandelman.ottawa.on.ca>
From: "Steve Schmidtke" <steve_schmidtke@hotmail.com>
Subject: Re: [uml-devel] Re: What to do with uml_switch?
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
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
Date: Thu, 09 Dec 2004 00:28:00 +0000
To: mcr@sandelman.ottawa.on.ca
Cc: kraxel@bytesex.org, blaisorblade_spam@yahoo.it, uml@uxu.ch, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net



Michael Richardson wrote:
>     >> Not practical, not reliable.
>
>     Steve> Why not reliable?  A monitor port is a diagnostic tool, and
>
>   What would I connect to the monitor port? Another UML?

A program that can inspect and/or create packets --  uml_netjig but with a 
modular API.

>     Steve>   cat tcpdump.pcap | switch_mon_tool --socket /tmp/uml.mon
>     Steve> --delay 100ms
>
>     Steve> is the type of functionality I'm shooting for (above example
>     Steve> not to be taken literally).
>
>   Great. That works for 1 network.
>
>   Now, how do you replay packets where you need an actual time sequence
>diagram to make it work? I.e.
>	   - send packet A on network 1
>	   - send packet B on network 2
>	   - send packet C on network 1
>	   - send packet D on network 2

Thinking out loud, I envision somone being able to write a monitor app that 
would allow a session like this:

  host:$> vmon_switch -i
  Welcome to vapour_monitor version -0.01
  Interactive mode ready.
  > verbose
  verbose mode on.
  >  connect swA /tmp/uml.mon1
  swA connected ok.
  > connect swB /tmp/uml.mon2
  swB connected ok.
  > connect swC /tmp/uml.mo3
  swC connect failed: /tmp/uml.mo3
  > connect swC /tmp/uml.mon3
  swC connected ok.
  > pcap source infile tcpdump.pcap
  infile opened for reading ok.  infile record: 1
  > pcap dest outfile traffic.pcap
  outfile opened for writing ok.
  > pcap dump swA outfile
  dumping switch swA, sending to outfile.
  > pcap single input swA
  1 packets to switch swA ok.  infile record 2.
  > pcap single input swB
  1 packets to switch swB ok.  infile record 3.
  > pcap close outfile
  outfile closed, 10 packets.
  > pcap rewind infile
  infile record 1.
  > pcap single infile swC
  1 packets to switch swC ok.  infile record 2.
  ** EOF from swA **
  > pcap delay 100 ms
  send interval set to 100 milliseconds
  > pcap send infile swC
  ..... 5 packets to switch swC ok.  input position 7.
  > quit
  vapour_monitor Exiting...
  host:$> tcpdump -n -r traffic.pcap

I put way too much time and effort into that example, but it was useful to 
think through.  The point is, a port allows the complexity of diagnostic 
code and traffic analysis to reside externally in the monitor app, and not 
be coded in the switch (the flip side is that the monitor apps don't have to 
know how the switch works).  If "switch_mon_tool" is unsuitable, it can be 
replaced by "vmon_switch" in a heartbeat -- without modifying or even 
restarting uml_switch.

Steve Schmidtke




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
