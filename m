Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTNnp-0003Tz-Ba for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 May 2004 09:32:21 -0700
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BTNno-0000PN-Cl for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 May 2004 09:32:20 -0700
Message-ID: <11a101c44409$2f7dbb20$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <pan.2004.05.17.20.30.18.825415@sipsolutions.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [uml-user] odd ping problems
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
Date: Thu, 27 May 2004 18:39:30 +0200
To: user-mode-linux-user@lists.sourceforge.net, Johannes Berg <johannes@sipsolutions.de>
Cc: user-mode-linux-devel@lists.sourceforge.net, caker@theshore.net, michel@pollet.net, Jeff Dike <jdike@addtoit.com>

hi!
i`m able to reproduce this with 2.6.6-uml and tuntap/bridged network setup (on 
2.6.6 skas host).
this seems to have no relation to the swap/paging related ping delay issue - it 
seems to be a completely different one.
it only happens when "largepinging" from host to uml - not vice versa.

> The uml is idle during all the time, it reacts to my ssh session
> and the normal console. In fact, if I generate other network traffic
> (cat'ing a file in my ssh session), the uml will respond to the large
> ping.
your uml responds to the large ping? mine doesn`t respond to large pings
at all.

regards
roland


----- Original Message ----- 
From: "Johannes Berg" <johannes@sipsolutions.de>
To: <user-mode-linux-user@lists.sourceforge.net>
Sent: Monday, May 17, 2004 10:30 PM
Subject: [uml-user] odd ping problems


> Hi,
> 
> Just observed this on
>   host:  2.6.3 with skas
>   guest: debian uml package (2.4.24-1um)
> 
> johannes:~$ ping uml
> PING uml (172.17.16.100) 56(84) bytes of data.
> 64 bytes from uml (172.17.16.100): icmp_seq=1 ttl=64 time=1.00 ms
> 64 bytes from uml (172.17.16.100): icmp_seq=2 ttl=64 time=0.538 ms
> 64 bytes from uml (172.17.16.100): icmp_seq=3 ttl=64 time=0.519 ms
> 64 bytes from uml (172.17.16.100): icmp_seq=4 ttl=64 time=0.530 ms
> 64 bytes from uml (172.17.16.100): icmp_seq=5 ttl=64 time=0.529 ms
> 64 bytes from uml (172.17.16.100): icmp_seq=6 ttl=64 time=1.92 ms
> 64 bytes from uml (172.17.16.100): icmp_seq=7 ttl=64 time=0.499 ms
> 64 bytes from uml (172.17.16.100): icmp_seq=8 ttl=64 time=6.64 ms
> 64 bytes from uml (172.17.16.100): icmp_seq=9 ttl=64 time=1.36 ms
> 64 bytes from uml (172.17.16.100): icmp_seq=10 ttl=64 time=0.519 ms
> 64 bytes from uml (172.17.16.100): icmp_seq=11 ttl=64 time=0.528 ms
>  
> --- uml ping statistics ---
> 11 packets transmitted, 11 received, 0% packet loss, time 10027ms
> rtt min/avg/max/mdev = 0.499/1.327/6.642/1.738 ms
> 
> johannes:~$ ping uml -s 60000
> PING uml (172.17.16.100) 60000(60028) bytes of data.
>  
> --- uml ping statistics ---
> 5 packets transmitted, 0 received, 100% packet loss, time 20042ms
> 
> johannes:~$ ping uml
> PING uml (172.17.16.100) 56(84) bytes of data.
> 64 bytes from uml (172.17.16.100): icmp_seq=2 ttl=64 time=10008 ms
> 64 bytes from uml (172.17.16.100): icmp_seq=3 ttl=64 time=9008 ms
> 64 bytes from uml (172.17.16.100): icmp_seq=4 ttl=64 time=8008 ms
> 64 bytes from uml (172.17.16.100): icmp_seq=5 ttl=64 time=7009 ms
> 64 bytes from uml (172.17.16.100): icmp_seq=6 ttl=64 time=6009 ms
> 64 bytes from uml (172.17.16.100): icmp_seq=7 ttl=64 time=5009 ms
> 64 bytes from uml (172.17.16.100): icmp_seq=8 ttl=64 time=4008 ms
> 64 bytes from uml (172.17.16.100): icmp_seq=9 ttl=64 time=3009 ms
> 64 bytes from uml (172.17.16.100): icmp_seq=10 ttl=64 time=2009 ms
> 64 bytes from uml (172.17.16.100): icmp_seq=11 ttl=64 time=1010 ms
> 64 bytes from uml (172.17.16.100): icmp_seq=12 ttl=64 time=2.67 ms
>  
> --- uml ping statistics ---
> 12 packets transmitted, 11 received, 8% packet loss, time 11007ms
> rtt min/avg/max/mdev = 2.676/5008.647/10008.979/3162.981 ms, pipe 11
> 
> After this it'll react fine to my pings, until again I send it a very
> large one. That blocks it for a while again, and I get behaviour like
> above. Notice the large delay, until all the sudden all packets arrive
> (ping sends one every second, but the first 12 arrive at the same time).
> Sometimes, instead of all arriving late, the packets are simply dropped.
> 
> The uml is idle during all the time, it reacts to my ssh session
> and the normal console. In fact, if I generate other network traffic
> (cat'ing a file in my ssh session), the uml will respond to the large
> ping.
> 
> Is this a known problem?
> 
> More information:
> The uml has iptables enabled, and drops every icmp packet but "ping pong
> destination-unreachable time-exceeded", but I can reproduce exactly the
> same behaviour if I flush all chains and set all policies to "accept".
> 
> I am using
>     eth0=daemon,,,/var/run/uml-utilities/uml_switch.ctl
> 
> The strace looks similar to what I had before, when I suspended my laptop
> while uml was running.
> 
> Basically, during the pinging with a small packet, the uml will do:
> recvfrom(7, "...", 1514, 0, NULL, NULL) = 98
> <rt_sigprocmask unblock + block>
> gettimeofday
> <rt_sigprocmask unblock + block * 9>
> recvfrom(7, "...", 1514, 0, NULL, NULL) = -1 (EAGAIN)
> <rt_sigprocmask unblock + block * 6>
> ioctl(7, SNDCTL_TMR_TIMEBASE or TCGETS, 0xa021b3a4) = -1 EINVAL
> <rt_sigprocmask unblock + block * 15>
> sendto(7, "...", 98, 0, {sa_family=AF_UNIX, path=@}, 110) = 98
> 
> From the first recvfrom to the sendto it takes about 5673 usecs.
> 
> For the fragmented packets, the recvfrom sequence (lots of receives of
> course) takes 15138 usecs. But before the next sendto it takes more than 3
> seconds, there are other recvfroms inbetween, and some waitpid stuff, and
> ptrace, ... It also sleeps for a while, sequences like
> 22:17:31.647087 nanosleep({10, 0}, 0)   = ? ERESTART_RESTARTBLOCK (To be restarted)
> 22:17:31.657382 --- SIGALRM (Alarm clock) @ 0 (0) ---
> 
> Thats about all I can say here, I got the data with
>   strace -tt -p <pid>
> 
> johannes
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: SourceForge.net Broadband
> Sign-up now for SourceForge Broadband and get the fastest
> 6.0/768 connection for only $19.95/mo for the first 3 months!
> http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
> _______________________________________________
> User-mode-linux-user mailing list
> User-mode-linux-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-user
> 


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
