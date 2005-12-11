Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ElKvl-0005lu-Al for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Dec 2005 22:43:33 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1ElKvi-0004r5-0v
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Dec 2005 22:43:33 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] tls: set_thread_area failed
References: <1134008028.32598.52.camel@localhost.localdomain>
	<200512091852.15906.blaisorblade@yahoo.it>
	<1134153592.29209.2.camel@localhost.localdomain>
In-Reply-To: <1134153592.29209.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512110034.43397.rob@landley.net>
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
Date: Sun, 11 Dec 2005 00:34:43 -0600
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Antoine Martin <antoine@nagafix.co.uk>, Blaisorblade <blaisorblade@yahoo.it>

On Friday 09 December 2005 12:39, Antoine Martin wrote:

> > > Is this glibc? Any ideas?
> >
> > Yes, I see that on Debian Sarge too. Don't ask me why fsck uses thread,
> > but it seems to do that.
>
> I wasn't even thinking about that! So true, why on earth would fsck
> require threading!?

fsck -A does all filesystems in fstab in one run, and the single case 
apparently defaults to one thread.

I didn't say it was a good design... :)

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
