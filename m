Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQpaF-0008FO-Aw for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 May 2004 08:35:47 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BQpaE-0007dr-KH for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 May 2004 08:35:46 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] [PATCH] host context switch reduction
In-Reply-To: <00c801c43e7e$f0262690$2000000a@schlepptopp>
Message-ID: <Pine.LNX.4.44.0405201727230.11053-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Thu, 20 May 2004 17:35:10 +0200 (CEST)
To: roland <for_spam@gmx.de>
Cc: Henrik Nordstrom <uml@hno.marasystems.com>, Laurent Vivier <LaurentVivier@wanadoo.fr>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Thu, 20 May 2004, roland wrote:

> mh - maybe i don`t understand you completely right here - but - for me, most hogging
> processes in uml produces a gazillion of context-switches on the host.

Only if the hoggin process is doing syscalls..

> if i run getpid on the host, i cannot see (vmstat) a noticeable raise in the amount 
> of context switches.

Correct, as normally there is no context switch in a syscall on the host.

> if i run getpid inside an uml - i see cs on the host raise from ~400 to ~230000 !!

Yes.

> the same getpid in a sysemu-patched uml/host results in a raise from ~400 to ~173000 cs - 
> so this is noticeably better.

Good.

> similar things happen with other "hogs" (idle state is always ~400 cs on host, cs rate
> is from vmstat output on the host) :
> 
> "while true; do /bin/true; done"
> host:         ~ 2000
> uml:          ~ 24000
> uml-sysemu:   ~ 17000

This is not a CPU hog. This is a syscall hog. Not as intense as the getpid
hog as there is more overhead, but still..

> "while true; do find /; done"

Same here..

Try

   strace -f sh -c "while true; do /bin/true; done"

and you'll see the very high syscall rate in such hog.


Here is a silly example of a pure CPU hog:

perl -e 'while (1) {}'


Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
