Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ElTe3-0007uw-PE for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Dec 2005 08:01:51 -0800
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1ElTdy-0007hH-2r
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Dec 2005 08:01:51 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] tls: set_thread_area failed
References: <1134008028.32598.52.camel@localhost.localdomain>
	<1134153592.29209.2.camel@localhost.localdomain>
	<200512110034.43397.rob@landley.net>
In-Reply-To: <200512110034.43397.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512111701.31229.blaisorblade@yahoo.it>
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
Date: Sun, 11 Dec 2005 17:01:30 +0100
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Antoine Martin <antoine@nagafix.co.uk>

On Sunday 11 December 2005 07:34, Rob Landley wrote:
> On Friday 09 December 2005 12:39, Antoine Martin wrote:
> > > > Is this glibc? Any ideas?
> > >
> > > Yes, I see that on Debian Sarge too. Don't ask me why fsck uses thread,
> > > but it seems to do that.
> >
> > I wasn't even thinking about that! So true, why on earth would fsck
> > require threading!?
>
> fsck -A does all filesystems in fstab in one run, and the single case
> apparently defaults to one thread.
>
> I didn't say it was a good design... :)

In fact, I expect a core Unix utility to be grown up in the good old Unix 
school, i.e. fork() and exec()!

We met The One* Unix coder thinking "I like new things!".

* Every reference to "The One Ring" is purely casual and fruit of paranoid 
imagination of the reader. (Yes, you don't know that, but anyhow...)
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
