Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CzkNZ-000188-AL for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Feb 2005 15:39:17 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CzkNW-0003TN-K1 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Feb 2005 15:39:17 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] SMP sworking in tt mode
References: <420D4040.5060301@auto.ucl.ac.be>
In-Reply-To: <420D4040.5060301@auto.ucl.ac.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502120038.17642.blaisorblade@yahoo.it>
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
Date: Sat, 12 Feb 2005 00:38:17 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Vincent Guffens <guffens@auto.ucl.ac.be>

On Saturday 12 February 2005 00:31, Vincent Guffens wrote:
> hi everyone,
>
> I read on the UML kernel site that SMP might be broken, so I gave it a
> try with linux-2.4.24-um1 to see how it would look like. I only try it
> with tt mode.
>
> In fact, the only modification that has to be done to get it to compile
> is simply to add CONFIG_NR_CPUS in the config.in file (The very simple
> patch is below).
>
> And that was it, now I have a brand new 16 cpus machine, as shown below
> (with four processes running)
>
>   3:36pm  up 4 min,  4 users,  load average: 0.04, 0.02, 0.00
> 37 processes: 33 sleeping, 4 running, 0 zombie, 0 stopped
> CPU0 states: 14.3% user,  7.3% system,  0.0% nice, 77.2% idle
> CPU1 states: 15.3% user,  7.2% system,  0.0% nice, 76.3% idle
> CPU2 states:  0.1% user,  0.1% system,  0.0% nice, 99.3% idle
> CPU3 states: 18.1% user,  8.1% system,  0.0% nice, 73.1% idle
> CPU4 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
> CPU5 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
> CPU6 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
> CPU7 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
> CPU8 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
> CPU9 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
> CPU10 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
> CPU11 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
> CPU12 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
> CPU13 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
> CPU14 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
> CPU15 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
> Mem:    28936K av,   28340K used,     596K free,       0K shrd,      32K
> buff
> Swap:       0K av,       0K used,       0K free                   22580K
> cached
>
>    PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
>    156 root      14   0   376  376   316 R    14.4  1.2   0:01 md5sum
>    155 root      11   0   376  376   316 R    12.6  1.2   0:01 md5sum
>    154 root      13   0   376  376   316 R    12.2  1.2   0:01 md5sum
>    153 root      10   0   920  920   728 R     0.1  3.1   0:00 top
>
>
>
> I also tried with 32 processors, rebooted many times and let it run a
> few hours. I had it hang and panic a few times but I think it was
> because a make clean must be done before recompiling with SMP enable.
>
> Also, all the interrupts seem to be handled by CPU0 (according to
> /proc/interrupt), even after changing the prof_cpu_mask in /proc.
>
> Is there something to do to make other processors handle interrupt ?
I don't know, but I read in the "25 Jul 2002" entry of 
http://user-mode-linux.sourceforge.net/diary.html that Jeff wanted to do what 
you see on purpose.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
