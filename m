Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Efg3V-0007d9-FI for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Nov 2005 08:04:09 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Efg3U-0007ei-3V
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Nov 2005 08:04:09 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<87sltkkc7i.fsf@amaterasu.srvr.nix>
	<pqTCNcAZweUM.k//fYyReDcBiXgpOuNcx7w@sphinx.mythic-beasts.com>
In-Reply-To: <pqTCNcAZweUM.k//fYyReDcBiXgpOuNcx7w@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511251003.42328.rob@landley.net>
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
Date: Fri, 25 Nov 2005 10:03:42 -0600
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Chris Lightfoot <chris@ex-parrot.com>, Nix <nix@esperi.org.uk>

On Friday 25 November 2005 09:03, Chris Lightfoot wrote:
> On Fri, Nov 25, 2005 at 02:56:49PM +0000, Nix wrote:
> > You could certainly do just that with POSIX shm :)
>
> Another option is to mlock the memory, which should
> prevent paging, but requires root. I have a patch which
> does this using a helper binary, if people would like it.

A) mlock would be a bad thing.  Not only is it a trivial DOS waiting to happen 
but I like the UML physmem being swapped out under memory pressure.  I just 
don't want uselessly writing it to disk over and over in the absence of any 
memory pressure whatosever to consume all I/O bandwidth to no purpose, which 
is the effect when it's not on tmpfs.

B) Still requires root.  The suid root helper program is only available in 
exactly the same circumstances in which you can just ask the admin to mount 
tmpfs somewhere for you.

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
