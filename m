Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BRW5P-0008JV-8P for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 May 2004 05:58:47 -0700
Received: from pop.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BRW5O-00047x-OJ for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 May 2004 05:58:46 -0700
Message-ID: <048e01c43ffd$829f72e0$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
Subject: Re: [uml-devel] /dev/fd/62: No such file or directory 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Sat, 22 May 2004 15:05:51 +0200
To: uml@hno.marasystems.com
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

Works here using UML 2.6.6-1um (SuSE9.1) on a 2.6.4 based host(SuSE 9.1), too
strange..

----- Original Message ----- 
From: "Henrik Nordstrom" <uml@hno.marasystems.com>
To: "roland" <for_spam@gmx.de>
Cc: "Jeff Dike" <jdike@addtoit.com>; <user-mode-linux-devel@lists.sourceforge.net>
Sent: Thursday, May 20, 2004 8:51 PM
Subject: Re: [uml-devel] /dev/fd/62: No such file or directory


> On Thu, 20 May 2004, roland wrote:
>
> > my UML is 2.6.6  (but i have seen this on other 2.6.x, too) - it uses devfs
> > host seems irrelevent - i have seen this on 2.4 and on 2.6 hosts
>
> Works here using UML 2.4.26-1um on a 2.4 based host..
>
> Regards
> Henrik
>

----- Original Message ----- 
From: "roland" <for_spam@gmx.de>
To: "Jeff Dike" <jdike@addtoit.com>
Cc: <user-mode-linux-devel@lists.sourceforge.net>
Sent: Thursday, May 20, 2004 8:28 PM
Subject: Re: [uml-devel] /dev/fd/62: No such file or directory


> Hi !
> I have dig into this and made a repro-case:
>
> #!/bin/bash
> while IFS=- read line ; do
>  echo $line
> done < <(cat /etc/hosts)
>
> on HOST this prints the contents of /etc/hosts
> on UML this gives:
> ./test: line 4: /dev/fd/62: No such file or directory
>
> it seems,  bash process substitution has problems within UML (at least within my uml)
>
> i have googled a little bit - maybe this gives a hint:
> http://groups.google.de/groups?hl=de&lr=&ie=UTF-8&th=d6142de0d1ec5cd&rnum=2
> http://groups.google.de/groups?hl=de&lr=&ie=UTF-8&th=161582ba6e79f8c7&rnum=3
> http://groups.google.de/groups?hl=de&lr=&ie=UTF-8&th=94e9a60998cb724c&rnum=3
>
> anybody able to reproduce ?
>
> my UML is 2.6.6  (but i have seen this on other 2.6.x, too) - it uses devfs
> host seems irrelevent - i have seen this on 2.4 and on 2.6 hosts
>
> regards
> roland
>
>
>
>
>
>
> ----- Original Message ----- 
> From: "Jeff Dike" <jdike@addtoit.com>
> To: "roland" <for_spam@gmx.de>
> Cc: <user-mode-linux-devel@lists.sourceforge.net>
> Sent: Thursday, May 20, 2004 2:40 AM
> Subject: Re: [uml-devel] /dev/fd/62: No such file or directory
>
>
> > for_spam@gmx.de said:
> > > can anybody give me a hint, what`s the problem, and how to (probably)
> > > fix this ?
> >
> > Can you trace these back to the system call within which these happen?
> >
> > Figuring out which command in which script causes it, and putting a strace
> > in front of it should do the trick.
> >
> > Jeff
> >
>
> Hi !
> I`m getting the following errors with uml 2.6.6 (2.6.4 had that, too) and suse9 rootfs during boot (see below).
> can anybody give me a hint, what`s the problem, and how to (probably) fix this ?
> networking basically works - but i have to setup the defaultroute manually afterwards and soooo many errors during boot really
don`t
> give a good "feeling" :)
>
> regards
> roland
>
>
> Master Resource Control: previous runlevel: N, switching to runlevel: 3
> Setting up network interfaces:
>     lo        /sbin/ifup: line 119: /dev/fd/62: No such file or directory
> /sbin/ifup: line 540: /dev/fd/62: No such file or directory
> /sbin/ifup: line 1: /dev/fd/62: No such file or directory
> /sbin/ifup: line 1: /dev/fd/61: No such file or directory
> /sbin/ifup: line 171: /dev/fd/62: No such file or directory
> /etc/sysconfig/network/scripts/ifup-route: line 1: /dev/fd/62: No such file or directory
> /etc/sysconfig/network/scripts/ifup-route: line 433: /dev/fd/62: No such file or directory
> done
>     eth0      /etc/sysconfig/network/scripts/ifup-route: line 1: /dev/fd/61: No such file or directory
> /sbin/ifup: line 119: /dev/fd/62: No such file or directory
> /sbin/ifup: line 540: /dev/fd/62: No such file or directory
> /sbin/ifup: line 171: /dev/fd/62: No such file or directory
> /sbin/ifup: line 1: /dev/fd/62: No such file or directory
> /sbin/ifup: line 1: /dev/fd/61: No such file or directory
> IP/Netmask: 100.1.7.247 / 255.255.252.0
> /etc/sysconfig/network/scripts/ifup-route: line 1: /dev/fd/62: No such file or directory
> /etc/sysconfig/network/scripts/ifup-route: line 433: /dev/fd/62: No such file or directory
> done
> /etc/sysconfig/network/scripts/ifup-route: line 1: /dev/fd/61: No such file or directory
> /etc/sysconfig/network/scripts/ifup-route: line 433: /dev/fd/62: No such file or directory
> /etc/sysconfig/network/scripts/ifup-route: line 1: /dev/fd/61: No such file or directory
> /etc/sysconfig/network/scripts/ifup-route: line 1: /dev/fd/62: No such file or directory
>
>
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
