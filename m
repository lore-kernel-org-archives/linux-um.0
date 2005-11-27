Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EgPYL-0003UY-64 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 08:39:01 -0800
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EgPYG-0006C9-1H
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 08:39:01 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<200511260033.25661.blaisorblade@yahoo.it>
	<200511260444.29470.rob@landley.net>
In-Reply-To: <200511260444.29470.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511271738.39880.blaisorblade@yahoo.it>
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
Date: Sun, 27 Nov 2005 17:38:38 +0100
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Nix <nix@esperi.org.uk>, Chris Lightfoot <chris@ex-parrot.com>

On Saturday 26 November 2005 11:44, Rob Landley wrote:
> On Friday 25 November 2005 17:33, Blaisorblade wrote:

> > - back in 2.4, tmpfs on /tmp broke mkinitrd since it tried to loop-mount
> > the new initrd, which was in /tmp. And loop-mount over tmpfs didn't work.
>
> I vaguely remember this being fixed. :)

Yep, it was, but at 2.4.18 (my first kernel) it wasn't yet.

> > He had never known that "mount" lists mounts...
>
> I try not to assume that people know everything there is to know about
> Unix.

I've done my share of stupid things, but he's _payed_ as a sysadmin (though 
he's actually a programmer) and I learned this time ago, and since I started 
using Linux <=3.5 years ago, time ago means at the very beginning ... he 
_should_ know that. However he had backups - which shows he's well 
intentioned.

(as an aside, I do despise learning *so* fast... I wouldn't be able to use 
socket() without manuals, and there's a lot of stuff I'd like to learn well. 
And I'd really like to _start_ and finish even a little project on my own... 
it's years I don't start coding some fun project up).

> And the default seems to be that /tmp ain't tempfs, but /dev/shm is.

I argue for that too...

> > (Btw, the problem was that he added a new external disk, but labeled it
> > /boot, like an existing /boot partition , so mount -a choked with
> > "duplicate label '/boot'" and it stopped before mounting /home).

> He's using Red Hat, isn't he? :)

Yes...

> (Been there, done that, moved the darn labels to /dev/hda4 and such. 
> Wouldn't recommend that with SCSI because the scsi bus detects devices via
> chicken entrails and then enumerates them in sequence (with no gaps) on a
> first come first served basis.  With ATA, /dev/hdd3 means second
> controller, slave device, third partition, and that doesn't move unless you
> physically unplug it from its connector cable, no matter what else you plug
> in.  The whole _reason_ Red hat has this boot label stuff is some people
> have an unreasoning love of SCSI devices. :)

Well, it makes sense anyhow, and though it's unusual and it sucks for the 
user, it would be much more meaningful to use labels rather than partitions 
(when repartitioning the same can happen - and I've seen the bloody hell 
happen with partition tables


> google dar linux:
> Some french disk archiving tool, apparently.  I generally just use tarballs
> or rsync.

It's clear Nix is using some calculation program (not sure what's it).

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
