Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AtWHu-0000yX-0v
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 18 Feb 2004 10:19:10 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AtWD6-0000G7-9j
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 18 Feb 2004 10:14:12 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] 2.6.3-rc2-uml1 Kernel mode panic
References: <Pine.LNX.4.44.0402142159580.5528-100000@sparrow>
In-Reply-To: <Pine.LNX.4.44.0402142159580.5528-100000@sparrow>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402171709.44913.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 17 Feb 2004 17:09:44 +0100
To: William Stearns <wstearns@pobox.com>, ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Alle 04:06, domenica 15 febbraio 2004, William Stearns ha scritto:
> Good evening, Jeff,
> 	I got a Kernel panic from the above kernel; sorry to say my
> compiler won't let me include all the debugging information that would
> have made this report useful.  :-(
>
> Kernel panic: Kernel mode fault at addr 0x0, ip 0x40101f94

Could you run with that kernel this loop on a shell:

while cat /dev/null; do cat /dev/null; done

This loop deterministically panics 2.6.2 and 2.6.3-rc2 UML kernels I have 
here(and if the configuration stays the same, even the corrupted values stay 
the same!). However nobody has yet seen it elsewhere.

Also this one "works":
while /bin/true; do /bin/true; done
(please avoid replacing /bin/true with true, since the second one is a shell 
builtin while I need a lot of forks to crash UML).

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
