Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJnyq-0000ES-Nv for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Oct 2004 00:00:24 -0700
Received: from marasystems.com ([83.241.133.2] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CJnyp-0000m5-UQ for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Oct 2004 00:00:24 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] Re: [uml-user] Host processes never terminate on
	2.6.9rc3 host (stuck in ptrace_stop)
In-Reply-To: <200410190023.14067.blaisorblade_spam@yahoo.it>
Message-ID: <Pine.LNX.4.61.0410190847370.10629@filer.marasystems.com>
References: <4173F1FD.6080004@colitti.com>
	<200410182118.09005.blaisorblade_spam@yahoo.it>
	<20041018212612.GA3052@bytesex>
	<200410190023.14067.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
Date: Tue, 19 Oct 2004 08:59:53 +0200 (CEST)
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: Gerd Knorr <kraxel@bytesex.org>, user-mode-linux-devel@lists.sourceforge.net, Lorenzo Colitti <lorenzo@colitti.com>, Massimo Rimondini <rimondin@dia.uniroma3.it>

On Tue, 19 Oct 2004, BlaisorBlade wrote:

> Can you try using SIGCONT, please? Even the patch changelog clearly says that
> you must kill -CONT before kill -KILL (actually, a kill -CONT may make the
> process notice the SIGKILL), and that behaviour can be reproduced, I think,
> on every kernel version. There has been a thread on this (t-mode processes)
> on uml-devel. Quite frankly, I do not know the question myself - but people
> seem to agree that this is a correct behaviour.

The t-mode thread is about stopped traced processes where the tracing 
parent have gone away (killed or whatever). There it can be argued if it 
is sane to delay the SIGKILL only because the process is stopped. It would 
be more natural to KILL the process in this specific case.

If the tracing parent is still alive the natural thing would be to save 
the signal as pending and notify the parent when the child is restarted. A 
SIGKILL to a traced process in my opinion should not kill the traced 
process without allowing the tracing parent to veto on the signal.

Regards
Henrik


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
