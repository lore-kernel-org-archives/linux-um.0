Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJobZ-0004pq-HQ for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Oct 2004 00:40:25 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CJobY-0008SH-Si
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Oct 2004 00:40:25 -0700
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] Re: [uml-user] Host processes never terminate on
	2.6.9rc3 host (stuck in ptrace_stop)
Message-ID: <20041019072608.GD3052@bytesex>
References: <4173F1FD.6080004@colitti.com>
	<200410182118.09005.blaisorblade_spam@yahoo.it>
	<20041018212612.GA3052@bytesex>
	<200410190023.14067.blaisorblade_spam@yahoo.it>
	<Pine.LNX.4.61.0410190847370.10629@filer.marasystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410190847370.10629@filer.marasystems.com>
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
Date: Tue, 19 Oct 2004 09:26:09 +0200
To: Henrik Nordstrom <uml@hno.marasystems.com>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, Lorenzo Colitti <lorenzo@colitti.com>, Massimo Rimondini <rimondin@dia.uniroma3.it>

On Tue, Oct 19, 2004 at 08:59:53AM +0200, Henrik Nordstrom wrote:

> If the tracing parent is still alive the natural thing would be to save 
> the signal as pending and notify the parent when the child is restarted. A 
> SIGKILL to a traced process in my opinion should not kill the traced 
> process without allowing the tracing parent to veto on the signal.

Well, if you don't ptrace a process you can't catch/veto the SIGKILL as
well, so why you should be able to do that while ptracing?  Beside that
neither the process itself is killed nor the ptracing parent is notified
on SIGKILL.

When the process is _not_ ptraced the SIGKILL works just fine
(unconditionally, no matter whenever the process is stopped or not).
IMHO the behavior should be the same when the process is traced.

  Gerd

-- 
return -ENOSIG;


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
