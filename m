Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cc7dK-00053U-In for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Dec 2004 11:37:54 -0800
Received: from bay24-f39.bay24.hotmail.com ([64.4.18.89] helo=hotmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cc7dK-0005cX-8H for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Dec 2004 11:37:54 -0800
Message-ID: <BAY24-F39F020DFE0870A8FDC91DC83B60@phx.gbl>
In-Reply-To: <5810.1102524702@marajade.sandelman.ottawa.on.ca>
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
Date: Wed, 08 Dec 2004 19:36:25 +0000
To: mcr@sandelman.ottawa.on.ca, kraxel@bytesex.org
Cc: blaisorblade_spam@yahoo.it, uml@uxu.ch, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

Michael Richardson wrote:
>     Gerd> Hmm, I don't think it is a good idea to put that kind of
>     Gerd> testing code into the switch daemon.  I'd make the switch
>     Gerd> daemon behave as close as possible to a real switch, then use
>     Gerd> the normal tools you use for real networks as well.  I think
>     Gerd> uml_switch should just support a monitor port which will see
>
>   Not practical, not reliable.

Why not reliable?  A monitor port is a diagnostic tool, and there is no 
reason you couldn't run it in a sychronous mode with the switch, i.e. the 
switch is paused as the monitor inspects an IO event (an input packet) and 
either allows it to proceed or be modified in some way (replaced, dropped, 
etc).

I will agree that it wouldn't be fit for all purposes.  There is obviously a 
delay as a packet must be written to the monitor app for inspection, a 
context switch to the monitor, an ACK written from the monitor, a context 
switch back, and the ACK processed, before a packet can be disposed of.  
Does that make a monitor port impractical?  I don't think so.  The real 
world delay I've been seeing so far on my test monitor doing just that for 
ping round trip times is less than a millisecond.  I havn't tried larger 
packets yet.

On the other hand, once the monitor has ACK'd a packet, the switch and 
monitor app are free to continue processing independently, possibly reducing 
overall delay times.

>   Often, not even possible if you wish to play packets that Linux simply
>can not easily produce.

There is no reason you would need to use Linux as your packet source:

  cat tcpdump.pcap | switch_mon_tool --socket /tmp/uml.mon --delay 100ms

is the type of functionality I'm shooting for (above example not to be taken 
literally).

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
