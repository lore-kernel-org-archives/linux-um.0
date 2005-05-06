Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DTtRY-0000oi-UA	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 May 2005 20:24:00 -0700
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DTtRX-00070A-GK	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 May 2005 20:24:00 -0700
Message-ID: <001901c551eb$eb6dc050$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
References: <002501c5504a$18852c70$0201a8c0@hawk>
Subject: Re: [uml-devel] Status of 2.6.[10-11] constant 1 loadavg?
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
Date: Thu, 5 May 2005 22:30:10 -0500
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: Blaisorblade <blaisorblade@yahoo.it>

> Has the constant "loadavg of 1" bug been resolved, or has the patch been accepted
> into 2.6.12?
>
> Blaisorblade -- it appears to be back.  My recent tests with 2.6.11 vanilla still
> exhibit this problem.

It appears as though uml-fix-update_process_times-call.patch fixes the values in
/proc/stat, but the loadavg of 1 problem still exists.

-Chris



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
