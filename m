Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BRW1H-00072Q-9D for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 May 2004 05:54:31 -0700
Received: from pop.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BRW1G-0002NK-LT for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 May 2004 05:54:30 -0700
Message-ID: <046001c43ffc$e9b52d90$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <200405210556.i4L5uIX19375@lifewood.com>
	<004101c43f3b$497c26b0$dd02a8c0@ferraro>
	<20040521174707.GA7508@ccure.user-mode-linux.org>
	<005001c43f79$bcfce6e0$dd02a8c0@ferraro>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [uml-user] mem=64M, mem=128M, mem=ANYTHING ignored??
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
Date: Sat, 22 May 2004 15:01:34 +0200
To: uml <uml@dot1q.net>, user-mode-linux-user@lists.sourceforge.net
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

success, too.

the error definitely seems  to be a compile issue.
if i compile with -O2, uml just uses the 32M memory default
if i compile with -O1, uml uses the param "mem=..." the right way

furthermore, with O2
- there are left 5 "linux" processes running, after shutting down uml
- if i do a "killall linux" 2 of them being terminated, 3 still left running
  i need to kill them with "kill -9 pid"
- the terminal becomes unusable after shutdown - need to issue an "reset" on 
  that terminal to have it working right again

with O1
- there is only 1 "linux" process being left (still bad because i need to kill 
  that to boot again)
- the terminal behaves correctly after shutdown 

mhhh - don`t know how much "improvement" does "O2" in favour of "O1" - but
who should we ask now, to help hunting this "bug" ?
gcc folks ?

regards
roland




----- Original Message ----- 
From: "uml" <uml@dot1q.net>
To: <user-mode-linux-user@lists.sourceforge.net>
Sent: Friday, May 21, 2004 11:22 PM
Subject: Re: [uml-user] mem=64M, mem=128M, mem=ANYTHING ignored??


> SUCCESS.
> 
> I wish I had kept the original .config file that was giving me problems
> because I'd have run a diff against it to see what was throwing the errors.
> 
> I changed several things at once, however, so I am unsure as to what did it.
> I'm going to retrace through my steps to see if I can reproduce the error on
> this system and post what I discover here.  I'm going to try to
> reincorporate -O2 instead of using -O1 as well.
> 
> Additionally, the UML now shuts down cleanly without any extra 'linux'
> threads running.  Memory is recognized correctly as well and it's running a
> 2.6.6-1 uml kernel.
> 
> Thanks for the help and ideas, hopefully I'll be able to contribue some
> diagnostics for someone else in my position who's willing to search this
> group. =)
> 
> 
> ----- Original Message ----- 
> From: "Jeff Dike" <jdike@addtoit.com>
> To: "uml" <uml@dot1q.net>
> Cc: <user-mode-linux-user@lists.sourceforge.net>
> Sent: Friday, May 21, 2004 1.47 PM
> Subject: Re: [uml-user] mem=64M, mem=128M, mem=ANYTHING ignored??
> 
> 
> > On Fri, May 21, 2004 at 09:55:34AM -0400, uml wrote:
> > > On node 0 totalpages: 8192
> > >   DMA zone: 8192 pages, LIFO batch:2
> >
> > > Kernel command line: ubd0=cow1 mem=128M root=98:0
> >
> > Ummmm, strange.  It certainly works here:
> >
> > On node 0 totalpages: 32768
> >   DMA zone: 32768 pages, LIFO batch:8
> >
> > Kernel command line: ubd0=cow,/home/jdike/roots/debian_22 con0=fd:0,fd:1
> con1=none con=pts ssl=pts umid=debian mem=128M root=98:0
> >
> > That was with 2.6.6.  There are no obvious typos in your command line, but
> > it's giving you the default 32M.
> >
> > Can you show us the command line at the shell prompt?
> >
> > Jeff
> >
> >
> > -------------------------------------------------------
> > This SF.Net email is sponsored by: Oracle 10g
> > Get certified on the hottest thing ever to hit the market... Oracle 10g.
> > Take an Oracle 10g class now, and we'll give you the exam FREE.
> > http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
> > _______________________________________________
> > User-mode-linux-user mailing list
> > User-mode-linux-user@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/user-mode-linux-user
> >
> >
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 10g. 
> Take an Oracle 10g class now, and we'll give you the exam FREE.
> http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
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
