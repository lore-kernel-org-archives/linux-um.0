Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JwCYD-0000bZ-77 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 May 2008 01:41:29 -0700
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JwCYB-000739-6N
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 May 2008 01:41:28 -0700
Message-ID: <482AA5AE.3000900@saunalahti.fi>
Date: Wed, 14 May 2008 11:41:18 +0300
From: Sakari Ailus <sakari.ailus@saunalahti.fi>
MIME-Version: 1.0
References: <4821B5FC.40307@vulnscan.org>	<20080509154552.GH10169@c2.user-mode-linux.org>
	<48255FC4.4040805@vulnscan.org>
In-Reply-To: <48255FC4.4040805@vulnscan.org>
Subject: Re: [uml-devel] umls unresponsive & consuming 100% cpu time
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: "Bram Matthys (Syzop)" <syzop@vulnscan.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

Bram Matthys (Syzop) wrote:
> Thanks for your reply.
> 
> $ grep HZ .config
> CONFIG_HZ=100
> # CONFIG_NO_HZ is not set
> 
> I've applied your patch against my 2.6.25 (vanilla)...
> patching file arch/um/os-Linux/time.c
> patching file arch/um/kernel/time.c
> Hunk #1 succeeded at 74 (offset -1 lines).
> Hunk #2 succeeded at 82 (offset -1 lines).
> and recompiled etc..
> 
> I saw vincent's issue, and when I set the time like 5 seconds back.. the UML
> freezes and uses 100% cpu and doesn't respond at all. This is however not
> entirely the same as what I had, because i still had it somewhat responsive...

Hi,

I think I have experienced the same problem. I don't have time now to 
investigate it further, but I have some info which may or may not be 
useful in debugging. So this is mainly just FYI.

I have three UML instances running on a host. First, they all were 
unresponsive simultaneously using all CPU time they could get. After a 
while they became responsive again. I could log in through SSH. The 
funny thing is that the date command showed correct date and time (as 
far as I remember, can't test it now as they are hung again) while the 
time in bash prompt was constant showing the time around the initial 
hang, which is the same on all three instances.

I think there was some NTP related activity on the host while this 
happened. The time the UMLs were showing was 23:xx:xx, don't know 
exactly. :(

---
May 13 22:58:56 retiisi ntpd[20630]: synchronized to 192.26.119.7, stratum 2
May 13 22:58:56 retiisi ntpd[20630]: time reset -5.151310 s
May 13 22:58:56 retiisi ntpd[20630]: kernel time sync enabled 0001
May 13 22:58:52 retiisi kernel: set_rtc_mmss: can't update from 1 to 58
May 13 22:58:56 retiisi last message repeated 4 times
May 13 22:59:27 retiisi kernel: set_rtc_mmss: can't update from 1 to 59
May 13 22:59:40 retiisi last message repeated 13 times
May 13 22:59:41 retiisi kernel: set_rtc_mmss: can't update from 2 to 59
May 13 22:59:59 retiisi last message repeated 18 times
May 13 23:02:29 retiisi ntpd[20630]: synchronized to 192.26.119.7, stratum 2
---

The host is 2.6.24 (skas4) and the clients are vanilla 2.6.24. Oh dear, 
I seem to have CONFIG_NO_HZ enabled...

-- 
Sakari Ailus
sakari.ailus@saunalahti.fi

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
