Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQpLG-0004jC-1V for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 May 2004 08:20:18 -0700
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BQpLE-00056U-Qc for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 May 2004 08:20:17 -0700
Message-ID: <00c801c43e7e$f0262690$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <Pine.LNX.4.44.0405201609240.7143-100000@filer.marasystems.com>
Subject: Re: [uml-devel] [PATCH] host context switch reduction
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
Date: Thu, 20 May 2004 17:27:17 +0200
To: Henrik Nordstrom <uml@hno.marasystems.com>
Cc: Laurent Vivier <LaurentVivier@wanadoo.fr>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

> What can be said is that applications running on the host is by far not as 
> dependent on context switching responsiveness to "feel good", and a CPU 
> hog in one UML does not cause any noticeable amount of extra context 
> switches, not much different from a CPU hog on the host in terms of 
> performance.

mh - maybe i don`t understand you completely right here - but - for me, most hogging
processes in uml produces a gazillion of context-switches on the host.

if i run getpid on the host, i cannot see (vmstat) a noticeable raise in the amount 
of context switches.

if i run getpid inside an uml - i see cs on the host raise from ~400 to ~230000 !!
the same getpid in a sysemu-patched uml/host results in a raise from ~400 to ~173000 cs - 
so this is noticeably better.

similar things happen with other "hogs" (idle state is always ~400 cs on host, cs rate
is from vmstat output on the host) :

"while true; do /bin/true; done"
host:         ~ 2000
uml:          ~ 24000
uml-sysemu:   ~ 17000

"while true; do find /; done"
host:        up to ~ 24000 (alternating very much - didn`t measure average value)
uml:         up to ~ 60000 ( " )       
uml-sysemu:  up to ~ 48000 ( " )

"dd if=/dev/urandom of=/dev/null"
host:        no noticeably differnce
uml:         ~ 16000
uml-sysemu   ~ 8500

regards
roland



----- Original Message ----- 
From: "Henrik Nordstrom" <uml@hno.marasystems.com>
To: "roland" <for_spam@gmx.de>
Cc: "Laurent Vivier" <LaurentVivier@wanadoo.fr>; "Jeff Dike" <jdike@addtoit.com>; <user-mode-linux-devel@lists.sourceforge.net>
Sent: Thursday, May 20, 2004 4:12 PM
Subject: Re: [uml-devel] [PATCH] host context switch reduction


> On Thu, 20 May 2004, roland wrote:
> 
> > if i run a getpid-loop inside one uml, the other uml`s behaviour becomes
> > quite sluggish - this doesn`t seem to have a relation to laurents patch - i
> > just recognized this for the first time, because i never did getpid-loops
> > inside a uml. :)
> 
> I would suspect this is due to the high dependency on context switching by 
> UML in system calls.. but I do not have a clearcut explanation.
> 
> What can be said is that applications running on the host is by far not as 
> dependent on context switching responsiveness to "feel good", and a CPU 
> hog in one UML does not cause any noticeable amount of extra context 
> switches, not much different from a CPU hog on the host in terms of 
> performance.
> 
> Regards
> Henrik
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
