Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CE86w-0004A7-2T for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 03 Oct 2004 08:17:18 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CE83n-0002vb-IC for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 03 Oct 2004 08:17:17 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] uml "ip header error" for large (fragmented) udp
	packets
References: </ydgn6vAKqzNNA6XYwRcEgI=lge@web.de>
In-Reply-To: </ydgn6vAKqzNNA6XYwRcEgI=lge@web.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410031711.26138.blaisorblade_spam@yahoo.it>
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
Date: Sun, 3 Oct 2004 17:11:26 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Lars Ellenberg <Lars.Ellenberg@linbit.com>

On Sunday 03 October 2004 04:36, Lars Ellenberg wrote:
> in the upcomming new heartbeat design of linux-ha, we use relatively
> large udp packets (passing large xml blobs back and forth between the
> nodes). now, cluster development and testing is convenient on UML.
>
> but:
>  uml seems to silently and systematically lose all fragmented
>  udp packets, that is packages larger than mtu, and 1480 byte
>  max for xml blobs just does not work out too good ...

> I investigated a little bit (using two simple perl snippets to
> generate/[not]receive the udp packets), and it turns out that:

>  sending large (up to 64K; fragmented) udp packets
>  using tuntap:
>   HOST -> UML  works.
>   UML  -> HOST nope :(
>   UML <-> UML  nope :( [ neither with mcast or other ]
>
>  looking into /proc/net/snmp on the UMLs and the HOST
>  show on the not receiving side an increase of
>  InHdrError!
>  (it never is reassembled into a proper udp packet)
>
> this is easy to reproduce (because it just happens all the time)
> tested with 2.6.6 and 2.6.8 plus respective UML patches.

Have you tried to use different UML transports (ethertap/uml_switch)- 
tcpdump'ing the traffic - other things? Changing the host version? Increasing 
the MTU somewhere (but seems not to work)? What is strange is that the UML 
code does not even parse the IP header when using tuntap - it only works at 
the Ethernet layer. IIRC, the fragmentation happens at the IP layer...

Also, can you post the scripts you use?

> it seems to me that UML corrupts the ip header of
> fragmented udp packets somehow at sending time.
>
> I wonder, if someone uses nfs over udp on uml, this should
> be a long known issue and turn up loads of hits in a search.
> I did not find a single reference to that problem, though.

Does NFS uses large UDP packets?

> thanks,
>
> 	Lars Ellenberg
>
> please CC me, I'm not subscribed on this list.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
