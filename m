Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8jnf-0004w2-PU for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Mar 2005 10:51:23 -0800
Received: from rproxy.gmail.com ([64.233.170.205])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D8jne-0005N2-Dp for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Mar 2005 10:51:23 -0800
Received: by rproxy.gmail.com with SMTP id z35so229205rne
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 08 Mar 2005 10:51:19 -0800 (PST)
Message-ID: <3524bf1f05030810517057e99d@mail.gmail.com>
From: Young Koh <young.koh@gmail.com>
Reply-To: Young Koh <young.koh@gmail.com>
Subject: Re: [uml-devel] Re: tun/tap network throughput problem
In-Reply-To: <87u0nm2fow.fsf@aka.i.naked.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3524bf1f05030712562d547e1c@mail.gmail.com>
	<87psya4btv.fsf@aka.i.naked.iki.fi>
	<3524bf1f050308084246dc9341@mail.gmail.com>
	<87u0nm2fow.fsf@aka.i.naked.iki.fi>
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
Date: Tue, 8 Mar 2005 13:51:19 -0500
To: Nuutti Kotivuori <naked@iki.fi>
Cc: user-mode-linux-devel@lists.sourceforge.net

Hi,

> In general, there's nothing to limit how many packets get queued to
> the interface queue - if something sends a million packets, that is
> how many packets are queued to the interface. However, for TCP, there

interesting. then, the UDP sending rate should be solely determined by
system performance regardless of what kind of the network interface
used, cause the rate will be determined by how fast the application
enqueues packets to the device queue, which is an internal data
structure in the kernel, right? when i measured UDP sending rate in
the host machine, it was about 650Mbits/s. that means the throughput
of data transfer from an application to the kernel internal structure
is only 650Mbits/s? but, when i measured UDP sending rate with
loopback device (sending packets to 127.0.0.1), it was about
5,000Mbits/s, which is a lot faster. should they, i mean, the sending
rates for eth0 and lo, be the same? (maybe lo uses special queuing
mechanism?)

thank you very much!

-Young


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
