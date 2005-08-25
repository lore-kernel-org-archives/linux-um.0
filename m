Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E8KBw-0000Wd-Gt	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 25 Aug 2005 09:03:00 -0700
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E8KBv-0004Xo-Ax
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 25 Aug 2005 09:03:00 -0700
Message-ID: <430DEBAA.3090801@theshore.net>
From: "Christopher S. Aker" <caker@theshore.net>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: host kernel dump on 2.6.11.12-skas3-v8.2
References: <20050824155845.80549.qmail@web30709.mail.mud.yahoo.com>
	<430C9A3D.8010104@athon.me.uk> <430D9435.2090809@rimuhosting.com>
In-Reply-To: <430D9435.2090809@rimuhosting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Date: Thu, 25 Aug 2005 11:02:50 -0500
To: Peter <peter.spamcatcher@rimuhosting.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Peter wrote:
 > Hi.  I just got this kernel dump on one particular host server that has
 > been giving me some grief - it has paniced 3 times over the last month.
 >
 > Would anyone on the list care to take a guess whether this looks like a
 > hardware, skas or vanilla kernel problem.  Any recommendations 
appreciated.

Lots of reports of this very bug on LKML, so I wouldn't think it's SKAS 
specific.  I didn't dig far enough to determine if it's been fixed past 
2.6.11.12.  Let us know how the hunt goes :)

http://marc.theaimsgroup.com/?t=111524392800005&r=1&w=2
http://marc.theaimsgroup.com/?t=111124107100001&r=1&w=2
http://marc.theaimsgroup.com/?t=110591026500001&r=1&w=2
http://marc.theaimsgroup.com/?t=111100740400005&r=1&w=2
http://marc.theaimsgroup.com/?t=111141951900001&r=1&w=2

BTW, Were you able to see the other panics?  Were they the same?

-Chris


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
