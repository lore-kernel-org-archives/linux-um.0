Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BqaOn-0005tL-BG for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Jul 2004 09:38:25 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1BqaOm-0007J6-Sg
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Jul 2004 09:38:25 -0700
Message-Id: <200407301736.i6UHavUE002874@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] uml-patch-2.4.26-2 
In-Reply-To: Your message of "Fri, 30 Jul 2004 15:46:06 BST."
	<20040730144606.GA27236@memset.com> 
References: <200407162019.i6GKJKqa003236@ccure.user-mode-linux.org>
	<20040730074833.GA22488@craig-wood.com>
	<878yd1itow.fsf@amaterasu.srvr.nix>
	<20040730144606.GA27236@memset.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Fri, 30 Jul 2004 13:36:57 -0400
To: Nick Craig-Wood <nick@memset.com>
Cc: Nix <nix@esperi.org.uk>, user-mode-linux-devel@lists.sourceforge.net

nick@memset.com said:
> However I view the above to be a bug in UML - it shouldn't lock up.
> Its entitled to miss events etc though.  gettimeofday(2) isn't
> guaranteed to be monotonic, but unfortunately there isn't a monotonic
> timer (like jiffies) that escapes to user space AFAIK. 

Agreeed.  Try the time-warp patch at 
	http://user-mode-linux.sourceforge.net/patches.html

It WorksForMe (tm).

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
