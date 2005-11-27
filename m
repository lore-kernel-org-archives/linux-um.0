Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EgSQy-0004CF-Kl for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 11:43:36 -0800
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user18282)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EgSQx-00036d-3S
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 11:43:36 -0800
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<200511271837.14625.blaisorblade@yahoo.it>
	<873bli7xbp.fsf@amaterasu.srvr.nix>
	<200511272010.03698.blaisorblade@yahoo.it>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <200511272010.03698.blaisorblade@yahoo.it>
	(blaisorblade@yahoo.it's
	message of "Sun, 27 Nov 2005 20:10:02 +0100")
Message-ID: <87u0dx7u76.fsf@amaterasu.srvr.nix>
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
Date: Sun, 27 Nov 2005 19:43:25 +0000
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Rob Landley <rob@landley.net>, Chris Lightfoot <chris@ex-parrot.com>

On Sun, 27 Nov 2005, blaisorblade@yahoo.it whispered secretively:
> Plus, for deep troubleshooting (mainly for kernels) init=/bin/sh is useful.

init=/bin/busybox/sh is also useful for those cases when you've futzed
your libc. :)

>> > No - the kernel doesn't allow storing the full set of infos which are
>> > added by mount there. And frankly I don't want the kernel to do that.
> 
>> Why not? It should. Only root can call mount(), so there's no real
>> danger that some attacker will stick megabytes of stuff in there.
> 
> Yep, but I don't like the kernel to become a configuration repository... it's 
> conceptually similar to the in-kernel Win32 registry (though it's smaller, 
> yep).

Well, except that it's just storing, er, data about mount points. It
*already* has to store that!

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
