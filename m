Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EfjKa-0001Ma-B5 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Nov 2005 11:34:00 -0800
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user69799)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EfjKZ-00022p-OB
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Nov 2005 11:34:00 -0800
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<87sltkkc7i.fsf@amaterasu.srvr.nix>
	<pqTCNcAZweUM.k//fYyReDcBiXgpOuNcx7w@sphinx.mythic-beasts.com>
	<200511251003.42328.rob@landley.net>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <200511251003.42328.rob@landley.net> (Rob Landley's message of
	"Fri, 25 Nov 2005 10:03:42 -0600")
Message-ID: <87k6ewikte.fsf@amaterasu.srvr.nix>
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
Date: Fri, 25 Nov 2005 19:33:49 +0000
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Chris Lightfoot <chris@ex-parrot.com>

On Fri, 25 Nov 2005, Rob Landley uttered the following:
> A) mlock would be a bad thing.  Not only is it a trivial DOS waiting to happen 
> but I like the UML physmem being swapped out under memory pressure.  I just 
> don't want uselessly writing it to disk over and over in the absence of any 
> memory pressure whatosever to consume all I/O bandwidth to no purpose, which 
> is the effect when it's not on tmpfs.

Maybe this is a stupid question, but... why do *any* systems other than
extremely memory-constrained ones not mount tmpfs on /tmp? It seems to
me to have numerous advantages and no disadvantages.

In fact, even when you're memory-constrained, if you *have* diskspace that
you could spend on /tmp, you can swap to it instead, and spend the space
on virtual memory when you're not spending it on /tmp.

So, er, why?

-- 
`Y'know, London's nice at this time of year. If you like your cities
 freezing cold and full of surly gits.' --- David Damerell



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
