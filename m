Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJped-00046L-1t for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Oct 2004 01:47:39 -0700
Received: from marasystems.com ([83.241.133.2] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CJpec-0007LA-74 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Oct 2004 01:47:38 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] Re: [uml-user] Host processes never terminate on
	2.6.9rc3 host (stuck in ptrace_stop)
In-Reply-To: <20041019072608.GD3052@bytesex>
Message-ID: <Pine.LNX.4.61.0410191045020.11373@filer.marasystems.com>
References: <4173F1FD.6080004@colitti.com>
	<200410182118.09005.blaisorblade_spam@yahoo.it>
	<20041018212612.GA3052@bytesex>
	<200410190023.14067.blaisorblade_spam@yahoo.it>
	<Pine.LNX.4.61.0410190847370.10629@filer.marasystems.com>
	<20041019072608.GD3052@bytesex>
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
Date: Tue, 19 Oct 2004 10:47:13 +0200 (CEST)
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Henrik Nordstrom <uml@hno.marasystems.com>, BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, Lorenzo Colitti <lorenzo@colitti.com>, Massimo Rimondini <rimondin@dia.uniroma3.it>

On Tue, 19 Oct 2004, Gerd Knorr wrote:

> Well, if you don't ptrace a process you can't catch/veto the SIGKILL as
> well, so why you should be able to do that while ptracing?

You can't, but the tracer can.

> Beside that neither the process itself is killed nor the ptracing parent 
> is notified on SIGKILL.

The tracing parent should get notified as soon as it tries to continue the 
child. If not there is a bug in my opinion.

> When the process is _not_ ptraced the SIGKILL works just fine
> (unconditionally, no matter whenever the process is stopped or not).

Correct. The process is then under the normal UNIX conditions where 
SIGKILL is unconditional.

> IMHO the behavior should be the same when the process is traced.

Here I do not agree, but it is my opinion.

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
