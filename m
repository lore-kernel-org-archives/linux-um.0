Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DTjl4-0001GE-9F	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 May 2005 10:03:30 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DTjkz-0003ij-IU	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 May 2005 10:03:30 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Scheduling latency in UML
References: <29D15BBCA340DA4D8146D38B4924FC7A104FE4@zcarhxm0.corp.nortel.com>
In-Reply-To: <29D15BBCA340DA4D8146D38B4924FC7A104FE4@zcarhxm0.corp.nortel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505051857.11780.blaisorblade@yahoo.it>
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
Date: Thu, 5 May 2005 18:57:11 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Majid Salame <msalame@nortel.com>

On Wednesday 04 May 2005 22:45, Majid Salame wrote:
> Has anyone measured the worst case scheduling latency in UML?
I think no.
> What is the main cause of process starvations in UML, To what degree is the
> UML scheduler is efficient?
There is currently no kernel preemption support, so it works as if 
CONFIG_PREEMPT is disabled.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
