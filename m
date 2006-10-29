Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GeGrc-0001c7-KI for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Oct 2006 12:02:36 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GeGrZ-0007n1-Q6
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Oct 2006 12:02:36 -0800
Date: Sun, 29 Oct 2006 12:02:24 -0800
From: Andrew Morton <akpm@osdl.org>
Message-Id: <20061029120224.d25e3204.akpm@osdl.org>
In-Reply-To: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
References: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH 00/11] UBD driver little cleanups for 2.6.19
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sun, 29 Oct 2006 20:17:23 +0100
"Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:

> Many cleanups for the UBD driver; these are mostly microfixes, I was waiting to
> finish and reorder also locking fixes (the code works, it is only to resplit,
> reproof-read and changelogs must be written) but I decided to send these ones
> for now. The rest will maybe be merged for 2.6.20.

None of this really looks like -rc3 material.  Why do you think it's
serious enough to justify late inclusion?

I'm not particularly fussed about UBD though - if you and Jeff particularly
want this lot in 2.6.19 then the world won't end.

"[PATCH 03/11] uml ubd driver: var renames" didn't apply due to
dummy_device_release not being present, which doesn't inspire confidence. 
What tree are you patching?


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
