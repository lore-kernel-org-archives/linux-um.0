Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20041019071826.GC3052@bytesex>
References: <4173F1FD.6080004@colitti.com>
	<200410182118.09005.blaisorblade_spam@yahoo.it>
	<20041018212612.GA3052@bytesex>
	<200410190023.14067.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410190023.14067.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: [uml-user] Host processes never terminate on 2.6.9rc3
	host (stuck in ptrace_stop)
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
Date: Tue, 19 Oct 2004 09:18:26 +0200
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, Lorenzo Colitti <lorenzo@colitti.com>, Massimo Rimondini <rimondin@dia.uniroma3.it>

> Can you try using SIGCONT, please? Even the patch changelog clearly says that 
> you must kill -CONT before kill -KILL (actually, a kill -CONT may make the 
> process notice the SIGKILL), and that behaviour can be reproduced, I think, 
> on every kernel version.

Sending the -CONT after -KILL doesn't work.
Other way around would be racy ...

> That said, I'll give a look to the patch. Have you CC'ed the patch author on 
> your report?

Yes.

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
