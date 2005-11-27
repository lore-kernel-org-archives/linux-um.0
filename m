Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EgRur-0002WC-3X for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 11:10:25 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EgRuo-00072S-EF
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 11:10:25 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<200511271837.14625.blaisorblade@yahoo.it>
	<873bli7xbp.fsf@amaterasu.srvr.nix>
In-Reply-To: <873bli7xbp.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511272010.03698.blaisorblade@yahoo.it>
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
Date: Sun, 27 Nov 2005 20:10:02 +0100
To: Nix <nix@esperi.org.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net, Rob Landley <rob@landley.net>, Chris Lightfoot <chris@ex-parrot.com>

On Sunday 27 November 2005 19:35, Nix wrote:
> On Sun, 27 Nov 2005, blaisorblade@yahoo.it whispered secretively:

> > Nice move to disable init=/bin/sh. Really. Next one is moving kdelibs
> > into the kernel?

> Nah, AIUI the initramfs runs *first*;

> it's its job to parse those parts 
> of the kernel parameters.

Ehy, initramfs is virtually empty by default...

Also, I didn't expect initramfs to parse that, but rather to prepare things 
and later let the kernel do the usual stuff - something different would 
surprise me.

Plus, for deep troubleshooting (mainly for kernels) init=/bin/sh is useful.

> > No - the kernel doesn't allow storing the full set of infos which are
> > added by mount there. And frankly I don't want the kernel to do that.

> Why not? It should. Only root can call mount(), so there's no real
> danger that some attacker will stick megabytes of stuff in there.

Yep, but I don't like the kernel to become a configuration repository... it's 
conceptually similar to the in-kernel Win32 registry (though it's smaller, 
yep).
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
