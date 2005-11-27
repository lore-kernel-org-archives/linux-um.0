Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EgPia-00041A-8j for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 08:49:36 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EgPiQ-0008L0-W9
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 08:49:32 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<87br08iglz.fsf@amaterasu.srvr.nix>
	<200511251631.41518.rob@landley.net>
In-Reply-To: <200511251631.41518.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511271748.53872.blaisorblade@yahoo.it>
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
Date: Sun, 27 Nov 2005 17:48:53 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>, Nix <nix@esperi.org.uk>, Chris Lightfoot <chris@ex-parrot.com>

On Friday 25 November 2005 23:31, Rob Landley wrote:
> On Friday 25 November 2005 15:04, Nix wrote:
> > The ~/.kde directory doesn't contain temporary files, but persistent
> > state:
>
> ~/.kde/share/apps/kmail/lock is persistent state?
>
> I do know that half the time the darn battery runs out and kde suddely
> shuts down my desktop without the courtesy of even _warning_ me first (oh
> it pops up a window three seconds before doing it), kmail doesn't have a
> chance to zap this file before being killed and thus I have to drill down
> and zap the sucker by hand or it'll refuse to run when I boot back up.
>
> Circa Red Hat 9, konqueror's cache files were under .kde.  I have no idea
> what the junk in .kde/share/apps/kpdf is for...
>
> But I take your point.  They've instituted a policy and tried to clean this
> up.  Similarly, .bash_history, .bittorrent, .DCOPserver*, .mcop, and all
> the other fun stuff written into home must be considered persistent state.
>
> > and the same is true of /var/spool,
>
> Doesn't /var/spool/cups contains files spooled to the printer?  (I dunno,
> the only printer in the house is hooked up to my fiance's windows machine.)

Spool *is* persistent... this is why cups is a daemon. Indeed, when you power 
on a printer and it starts printing without further action, you (or the 
average user, or me for a couple of seconds) say "it's a daemon's fault!"...

> > > things like vi would create temporary files in /tmp,
> >
> > /var/tmp, because the entire point of those files was to survive a
> > reboot.
>
> Is it?  I thought it was to support undo.


> Files that live for brief instants never get written out to disk anyway.
> That's why there's the delay before dirty pages in the page cache are
> scheduled for writeout.  So tmpfs doesn't help there.

That's not entirely correct for performances - the file could not get written 
out, but on most filesystems (excluding XFS, Reiser4 and some experimental 
ext3 version) a few preparatory steps (block allocation, for instance, and 
that involves poking through free list bitmaps and is even computationally 
intensive*) are done. Delayed allocation was invented exactly for that.

* on a RAID array with ext3, in a benchmark, it limited writeout speed downto 
300 Mb/s instead of 500 Mb/s (See OLS 2005, ext3 paper).

> > - users. A *lot* of my users dump temporary crud in /tmp:

> *shrug*.  The truly transient stuff never leaves the page cache, no matter
> what the filesystem.  (Especially if you mount with noatime, which is the
> norm these days.)

I've seen it rarely used... only Gentoo suggests that.

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
