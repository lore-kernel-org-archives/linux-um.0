Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpFcz-0001Ng-8z for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 16:47:49 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CpFcv-0001Pq-NL for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 16:47:48 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] 2.6.10-um, /proc/stat is missing information
References: <001901c4f9ca$f72825d0$0201a8c0@hawk>
In-Reply-To: <001901c4f9ca$f72825d0$0201a8c0@hawk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501140150.08487.blaisorblade@yahoo.it>
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
Date: Fri, 14 Jan 2005 01:50:08 +0100
To: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>
Cc: "Christopher S. Aker" <caker@theshore.net>

On Friday 14 January 2005 00:52, Christopher S. Aker wrote:
> I just verified this on a Debian install and an FC2 install.
>
> Moving from 2.6.9-bb4 to 2.6.10-um vanilla, top reports either 100% user,
> or 100% idle.
>
> [2.6.10] # cat /proc/stat
> cpu  645 1 0 0 0 0 0
> cpu0 645 1 0 0 0 0 0
> intr 63462 54820 0 174 10 8270 93 0 0 0 0 1 94 0 0
> ctxt 108849
> btime 1105659428
> processes 1542
> procs_running 2
> procs_blocked 0
>
> [2.6.9-bb4] # cat /proc/stat
> cpu  407 0 1989 7536 252 28 1
> cpu0 407 0 1989 7536 252 28 1
> intr 15430 10185 0 48 1 5035 134 0 0 0 0 0 27 0 0
> ctxt 10966
> btime 1105660071
> processes 1501
> procs_running 1
> procs_blocked 0
>
> Looks like some information is missing from /proc/stat in 2.6.10.
>
> -Chris
Try retesting after applying update-process-times.patch (the one for the crash 
you were seeing): that patch was not merged by maintainers in mainline, 
though IIRC it was sent in the right time frame (maybe because they weren't 
marked as urgent, or because they were a lot of patches, which is also 
possible).

About this, we should try for the future (even if this one was a special case, 
having to merge tens of invasive patches for security purposes is not nice) 
to merge big things only before -rc1 and -rc2, since after those releases 
things must calm down. This recommendation must be updated with changes in 
the release cycle followed by Linus, obviously.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
