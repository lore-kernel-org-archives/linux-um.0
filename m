Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8xRt-00062h-85 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 01:25:49 -0800
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D8xRr-0002Vm-CC for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 01:25:49 -0800
Subject: Re: [uml-devel] Re: tun/tap network throughput problem
References: <3524bf1f05030712562d547e1c@mail.gmail.com>
	<87psya4btv.fsf@aka.i.naked.iki.fi>
	<3524bf1f050308084246dc9341@mail.gmail.com>
	<87u0nm2fow.fsf@aka.i.naked.iki.fi>
	<3524bf1f05030810517057e99d@mail.gmail.com>
From: Nuutti Kotivuori <naked@iki.fi>
In-Reply-To: <3524bf1f05030810517057e99d@mail.gmail.com> (Young Koh's
	message of "Tue, 8 Mar 2005 13:51:19 -0500")
Message-ID: <87psy92mst.fsf@aka.i.naked.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Wed, 09 Mar 2005 11:25:38 +0200
To: Young Koh <young.koh@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Young Koh wrote:
>> In general, there's nothing to limit how many packets get queued to
>> the interface queue - if something sends a million packets, that is
>> how many packets are queued to the interface. However, for TCP,
>> there
>
> interesting. then, the UDP sending rate should be solely determined
> by system performance regardless of what kind of the network
> interface used, cause the rate will be determined by how fast the
> application enqueues packets to the device queue, which is an
> internal data structure in the kernel, right? when i measured UDP
> sending rate in the host machine, it was about 650Mbits/s. that
> means the throughput of data transfer from an application to the
> kernel internal structure is only 650Mbits/s? but, when i measured
> UDP sending rate with loopback device (sending packets to
> 127.0.0.1), it was about 5,000Mbits/s, which is a lot faster. should
> they, i mean, the sending rates for eth0 and lo, be the same? (maybe
> lo uses special queuing mechanism?)

Almost, but not quite. When packets are queued to the lo interface,
they are handled immediately, synchronously even. When packets are
queued to the eth0 interface, they get queued and the hardware
interrupts trigger their processing. This means that the userland
process is constantly being interrupted by the hardware sending
packets, where as in the lo case it can just fire away as it wants.

However, the speed difference seems too large to be simply caused by
that - so I am wondering a bit about the test tool, if it might manage
to do something special. Perhaps there is a way to see if the queue is
full from an UDP socket somehow, perhaps select does not return write
availability or something. Or perhaps it simply asks how much data is
in buffers - but I thought that only worked for receiving and TCP. I
would need to look into this a bit further.

-- Naked


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
