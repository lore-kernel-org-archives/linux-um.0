Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8PHP-000137-Ej for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 12:56:43 -0800
Received: from rproxy.gmail.com ([64.233.170.197])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D8PHN-0006nB-VZ for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 12:56:43 -0800
Received: by rproxy.gmail.com with SMTP id z35so2085562rne
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 07 Mar 2005 12:56:40 -0800 (PST)
Message-ID: <3524bf1f05030712562d547e1c@mail.gmail.com>
From: Young Koh <young.koh@gmail.com>
Reply-To: Young Koh <young.koh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] tun/tap network throughput problem
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
Date: Mon, 7 Mar 2005 15:56:39 -0500
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

i was running an expriment to measure network throughput of UML.
physical machine A and B are connected with gigabit network. and UML
runs on machine A. i'm sending bulk UDP packets from UML to machine B
using ttcp network throughput benchmark program.
i'm using 2.4.26 for both UML and host. (skas + sysemu patched)

i modified UML kernel code to get high performance a little bit, and i
got some gain with TCP and UDP throughput. but the problem arises when
i send large UDP packets with high sending rate. when i send 16K-sized
UDP packets with rate of 500Mbits/s, receiving rate at machine B was
about the same (~500Mbits/s), i mean, no problem. but when i send
16K-sized UDP packets with higher rate of more than 700Mbits/s, the
receiving rate drops to 150Mbits/s. (MTU = 1500)

i'm using tun/tap + bridge. so, i checked tap0 and eth0 device status,
but no packet drop reported (using ifconfig). i also checked the
number of packets received and sent. tap0 at host side received around
60007 packets, and eth0 at machine A sends 505536 packets during that
experiment. eth0 at machine B receives 505533 packets. so, it looks
like between tap0 and eth0, packets are being dropped somehow. (the
reason of dropping rapidly from 700 to 150 is the entire UDP packet
will be lost even if one of the fragmented packets is lost, i think)

i used tcpdump to check any trouble with UDP checksum because i saw
some posting about bug of bad UDP checksum when a UDP packet is
fragmented, but no checksum failure reported. (and it works well with
the lower sending rate)

i found other postings discussing queues of tun/tap devices when
packets are coming to UML kernel and between two UML machines. but i
couldn't find posting about packets from UML to other machine, even
though they are all related, it looks.

anybody has any idea where packets are being dropped and how i can solve it?

thank you,


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
