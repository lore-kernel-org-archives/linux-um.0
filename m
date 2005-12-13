Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EmItY-0005J3-MN for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Dec 2005 14:45:16 -0800
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user29129)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EmItV-0002Tq-UI
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Dec 2005 14:45:16 -0800
Subject: Re: [uml-devel] tls: set_thread_area failed
References: <1134008028.32598.52.camel@localhost.localdomain>
	<1134153592.29209.2.camel@localhost.localdomain>
	<200512110034.43397.rob@landley.net>
	<200512111701.31229.blaisorblade@yahoo.it>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <200512111701.31229.blaisorblade@yahoo.it>
	(blaisorblade@yahoo.it's
	message of "Sun, 11 Dec 2005 17:01:30 +0100")
Message-ID: <87fyowsjkg.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Tue, 13 Dec 2005 22:45:03 +0000
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Rob Landley <rob@landley.net>, user-mode-linux-devel@lists.sourceforge.net, Antoine Martin <antoine@nagafix.co.uk>

On Sun, 11 Dec 2005, blaisorblade@yahoo.it whispered secretively:
> On Sunday 11 December 2005 07:34, Rob Landley wrote:
>> On Friday 09 December 2005 12:39, Antoine Martin wrote:
>> > I wasn't even thinking about that! So true, why on earth would fsck
>> > require threading!?

It doesn't, at least not as of e2fsprogs-1.38.

>> fsck -A does all filesystems in fstab in one run, and the single case
>> apparently defaults to one thread.
>>
>> I didn't say it was a good design... :)

e2fsprogs-1.38/misc/fsck.c:check_all() repeatedly invokes fsck_device(),
which invokes execute(), which does a perfectly normal fork()/exec().
No threads here. Nor is there use of aio_*(), which might use threads
(well, POSIX allows it).

> In fact, I expect a core Unix utility to be grown up in the good old Unix 
> school, i.e. fork() and exec()!

It is. :)

> We met The One* Unix coder thinking "I like new things!".

Thankfully, Ted Ts'o is not a Nazgul (despite his close involvement in
the flashy new things of Kerberos and IPSec).

-- 
`I must caution that dipping fingers into molten lead
 presents several serious dangers.' --- Jearl Walker


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
