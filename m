Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BiPd9-0002qO-Fv for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jul 2004 20:31:27 -0700
Received: from mout2.freenet.de ([194.97.50.155])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1BiPd8-0000Qb-QC
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jul 2004 20:31:27 -0700
From: Michael Koehne <kraehe@copyleft.de>
Subject: Re: [uml-devel] Unable to handle kernel paging request ...
Message-ID: <20040708033126.GA10586@bakunin.copyleft.de>
References: <200407071945.30015.blaisorblade_spam@yahoo.it>
	<200407071929.46294.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407071945.30015.blaisorblade_spam@yahoo.it>
	<200407071929.46294.blaisorblade_spam@yahoo.it>
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
Date: Thu, 8 Jul 2004 05:31:26 +0200
To: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

Moin BlaisorBlade,

> >   I've talked to people on IRC, and they dont encounter those kind of
> >   ext3 crashes on 2.6 kernels. I dont had a camera for a screenshot,
> >   but dump was in ext3 area.
> What you mean with "ext3 crash"? "The dump was in ext3 area"? I don't 
> understand you, sorry.

  the crash 2.6.1+SKAS happened on file system operations on the host,
  while UML systems had been up and running - I first seen them once
  on find, and twice on rsync directory file walks on the host. I
  upgraded to 2.6.6+SKAS and they occured seldom. My server moved
  housing also, and is now hosting the UMLs. So I only know that its
  a seldom condition that is ext3_ related, but might be related to
  the UML patch - as others dont tell about so many panics - but does
  not require an UML to touch /proc/mm.

  Yesterday I noticed some points at the kernel panic, that started at
  postmaster at crontab time, and had a lot of ext3 pointers - but I
  did'nt had the patiens to write 3 pages of kernel panic ;(

> Well, the UML patch should have no influence, if you don't run UML on it (if 
> it happens after you have run UML at least once, there is still a chance

  the patch host-skas3-2.6.6-v1.patch is applied and running - but 
  /proc/mm was virgin - as there was no UML started on this machine
  for some days.

> >   or 34896138 May 25 20:45 linux-2.6.6.tar.bz2
> >    +    16182 May 25 20:35 host-skas3-2.6.6-v1.patch

  I'll stick to that combo for some more days (because of laziness ;)
  and hope to be more patient writing down the kernel panic next time.

> the second one is safe enough 
> (though somebody experience memory leaks... as reported on 
> http://www.user-mode-linux.org/~blaisorblade; however, they seldom happen).
 
  *hm* whats the current 'best practice patch' for 2.6.x ? 

  an rsync copy of my server's UML to my laptop's UML is a nice thing I
  wont want to miss anymore, even if the Double-NAT between them was a
  bit confusing at first - and 2.4.22 SKAS server and 2.4.22 UML are
  stable like a rock - at least in my ubd over ext3 over md-raid1
  on a Dual processor environment.

> You say in the title "Unable to handle kernel paging request". It means you 
> got a panic... Have you saved somewhere the complete message? Have you 
> checked if it's inside /var/log/messages?
  
  its not in any logs - as it was ext3 related on the host file system,
  if I managed to understand the dump. The process was postmaster running
  from cron on the host - there was no UML running since boot and the
  trace mentioned a lot of ext3_ <something>.

> Does "dump was in ext3 area" means 
> that the call trace mentioned ext3_ <something>? If it speaks about 
> __init_new_context, proc_mm or such things then the SKAS patch is likely to 
> be at fault, if not it's unlikely...

  I'll look at those more closely if it happens again, any other
  pointers so I could sort out UML related areas here ?

  I'll also might find the time to try a more actual kernel+skas combo
  before - as the crash is seldom, on a machine, I'm using regulary for
  about 2-4 full load hours from compiler per day with normal background
  processes in the other time.

Bye Michael
-- 
  mailto:kraehe@copyleft.de             UNA:+.? 'CED+2+:::Linux:2.4.22'UNZ+1'
  http://www.xml-edifact.org/           CETERUM CENSEO WINDOWS ESSE DELENDAM


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
