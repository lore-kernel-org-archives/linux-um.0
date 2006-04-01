Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FPUud-0006vf-Hd for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 31 Mar 2006 17:28:23 -0800
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FPUuc-00053m-6E
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 31 Mar 2006 17:28:23 -0800
Message-ID: <442DD733.6030808@theshore.net>
From: "Christopher S. Aker" <caker@theshore.net>
MIME-Version: 1.0
Subject: Re: [uml-devel] Kernel panic - not syncing: Kernel mode signal 7
References: <442DA85B.1060804@theshore.net>
	<200604010018.42600.blaisorblade@yahoo.it>
In-Reply-To: <200604010018.42600.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Fri, 31 Mar 2006 19:28:19 -0600
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

Blaisorblade wrote:
> On Saturday 01 April 2006 00:08, Christopher S. Aker wrote:
>> I'm posting this for posterity.  I've asked the user to upgrade to
>> 2.6.16.1-bs1 for now.  He's hit this twice in the last month...
> 
>> http://www.theshore.net/~caker/uml/kernels/2.6.15-linode16
> 
>> Kernel panic - not syncing: Kernel mode signal 7
> 
> SIGBUS, aka /tmp (or wherever the memory is hosted, i.e. $TMP) full on the 
> host.
> 
>> 89ae3778: [<8001f41c>] bus_handler+0x59/0x5b

I mount a tmpfs directory exclusively for each UML the same size as the 
mem= parameter.  Something fishy is going on with this particular host, 
now that I look at the other UML console, a number of them have hit this...

# uname -a
Linux host20.linode.com 2.6.11-rc4-1-bigmem64 #2 SMP Sun Feb 20 04:57:53 
EST 2005 i686 i686 i386 GNU/Linux
[root@host20 root]# uptime
  20:24:54  up 392 days, 57 min,  4 users,  load average: 0.46, 0.56, 0.66

I just noticed one of the drives is failing which has a swap partition 
on it.  That probably explains it.  I'll remove that from the equation.

Thanks,
-Chris


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
