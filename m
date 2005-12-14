Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EmN0q-00052e-8l for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Dec 2005 19:09:04 -0800
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EmN0o-0005ba-L2
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Dec 2005 19:09:04 -0800
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EmMyX-0007ZU-1c for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Dec 2005 04:06:41 +0100
Received: from dslb-082-083-008-185.pools.arcor-ip.net ([82.83.8.185])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 14 Dec 2005 04:06:41 +0100
Received: from skoehler by dslb-082-083-008-185.pools.arcor-ip.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 14 Dec 2005 04:06:41 +0100
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Message-ID: <439F8C0A.2000302@upb.de>
References: <1134008028.32598.52.camel@localhost.localdomain>	<1134153592.29209.2.camel@localhost.localdomain>	<200512110034.43397.rob@landley.net>	<200512111701.31229.blaisorblade@yahoo.it>
	<87fyowsjkg.fsf@amaterasu.srvr.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <87fyowsjkg.fsf@amaterasu.srvr.nix>
Subject: [uml-devel] Re: tls: set_thread_area failed
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
Date: Wed, 14 Dec 2005 04:05:46 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>, Antoine Martin <antoine@nagafix.co.uk>

> e2fsprogs-1.38/misc/fsck.c:check_all() repeatedly invokes fsck_device(),
> which invokes execute(), which does a perfectly normal fork()/exec().
> No threads here. Nor is there use of aio_*(), which might use threads
> (well, POSIX allows it).

Sorry, and what's the conclusion?

fork() calles set_thread_area()?



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
