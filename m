Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8zg0-0004In-07 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 03:48:32 -0800
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D8zfz-0006eA-8H for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 03:48:31 -0800
Subject: Re: [uml-devel] Re: tun/tap network throughput problem
References: <3524bf1f05030712562d547e1c@mail.gmail.com>
	<87psya4btv.fsf@aka.i.naked.iki.fi>
	<3524bf1f050308084246dc9341@mail.gmail.com>
	<87u0nm2fow.fsf@aka.i.naked.iki.fi>
	<3524bf1f05030810517057e99d@mail.gmail.com>
	<87psy92mst.fsf@aka.i.naked.iki.fi>
From: Nuutti Kotivuori <naked@iki.fi>
Message-ID: <8765012g6q.fsf@aka.i.naked.iki.fi>
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
Date: Wed, 09 Mar 2005 13:48:29 +0200
To: Young Koh <young.koh@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Nuutti Kotivuori wrote:
> Young Koh wrote:
>> when i measured UDP sending rate in the host machine, it was about
>> 650Mbits/s. that means the throughput of data transfer from an
>> application to the kernel internal structure is only 650Mbits/s? 
>> but, when i measured UDP sending rate with loopback device (sending
>> packets to 127.0.0.1), it was about 5,000Mbits/s, which is a lot
>> faster. should they, i mean, the sending rates for eth0 and lo, be
>> the same? (maybe lo uses special queuing mechanism?)

[...]

> However, the speed difference seems too large to be simply caused by
> that - so I am wondering a bit about the test tool, if it might
> manage to do something special. Perhaps there is a way to see if the
> queue is full from an UDP socket somehow, perhaps select does not
> return write availability or something. Or perhaps it simply asks
> how much data is in buffers - but I thought that only worked for
> receiving and TCP. I would need to look into this a bit further.

I just made a trivial test program in ocaml:

,----[ ocamlopt -o udptest unix.cmxa udptest.ml ]
| let data = String.make 15000 ' ';;
| try
|   let dst = Unix.inet_addr_of_string Sys.argv.(1) in
|   let port = int_of_string Sys.argv.(2) in
|   let addr = Unix.ADDR_INET(dst, port) in
|   let sock = Unix.socket Unix.PF_INET Unix.SOCK_DGRAM 0 in
|   let _ = Unix.connect sock addr in
|   let total = ref 0 in
|   let starttime = Unix.gettimeofday () in
|     for i = 1 to 10000 do
|       let ret = Unix.send sock data 0 (String.length data) [] in
|         total := !total + ret
|     done;
|     let endtime = Unix.gettimeofday () in
|       print_endline ("Time: " ^ (string_of_float (endtime -. starttime))
|                      ^ " Total: " ^ (string_of_int !total))
| with Unix.Unix_error(e, f, a) ->
|   print_endline ("Error: " ^ (Unix.error_message e))
`----

Then ran it against localhost and an external host (with packets being
dropped at input, so we do not get connection refused back):

,----
| $ ./a.out 127.0.0.1 1024
| Time: 0.352205991745 Total: 150000000
| 
| $ ./a.out 172.20.0.1 1024
| Time: 0.478994131088 Total: 150000000
`----

So in the localhost case, the throughput is over 3 gigabits per
second, and in the case of the remote host, it is over 2 gigabits per
second. This seems more in line of what it should be. The network here
is a mere 100Mbit network - so the dropped counters in eth0 (seen with
tc) fly up during the test.

So, it is probable that your test software either manages to throttle
itself in case of network congestion, or simply only counts packets
that are not dropped, somehow.

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
