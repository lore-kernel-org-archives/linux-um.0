Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BKf24-0000wL-NN for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 May 2004 08:07:00 -0700
Received: from www.tuxrocks.com ([64.62.190.123] helo=tuxrocks.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BKf24-0005VF-Bs
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 May 2004 08:07:00 -0700
From: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: [uml-devel] UML kernel panic
In-Reply-To: <Pine.LNX.4.44.0405031659340.15869-100000@filer.marasystems.com>
Message-ID: <Pine.LNX.4.44.0405030903300.18483-100000@tuxrocks.com>
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
Date: Mon, 3 May 2004 09:06:27 -0600 (MDT)
To: Henrik Nordstrom <uml@henrik.marasystems.com>
Cc: roland <for_spam@gmx.de>, user-mode-linux-devel@lists.sourceforge.net

On Mon, 3 May 2004, Henrik Nordstrom wrote:
> On Mon, 3 May 2004, Frank Sorenson wrote:
> 
> > Any ideas on what's causing UML kernel panics, and thoughts on how to fix
> > it would be greatly appreciated.  Can the UML kernel panics be caused by
> > host kernel or system problems, or is it likely a UML kernel problem, or
> > is there something else?
> 
> What does the panics say? Preferably including a gdb backtrace..

The panics are "Segfault with no mm"

gdb backtraces can be found here:
http://sco.tuxrocks.com/uml/trace6.txt
http://sco.tuxrocks.com/uml/trace7.txt

A copy of the config file (2.4.24-2 UML kernel) is here:
http://sco.tuxrocks.com/uml/config


Thanks for the help,

Frank
---------------------------------------------------------------------------
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
