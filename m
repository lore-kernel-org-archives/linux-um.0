Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EgRak-0001S0-FN for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 10:49:38 -0800
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user51765)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EgRag-0001tV-Vc
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 10:49:38 -0800
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<200511260033.25661.blaisorblade@yahoo.it>
	<200511260444.29470.rob@landley.net>
	<200511271738.39880.blaisorblade@yahoo.it>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <200511271738.39880.blaisorblade@yahoo.it>
	(blaisorblade@yahoo.it's
	message of "Sun, 27 Nov 2005 17:38:38 +0100")
Message-ID: <87y83a6i4n.fsf@amaterasu.srvr.nix>
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
Date: Sun, 27 Nov 2005 18:49:28 +0000
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Rob Landley <rob@landley.net>, user-mode-linux-devel@lists.sourceforge.net, Chris Lightfoot <chris@ex-parrot.com>

On Sun, 27 Nov 2005, blaisorblade@yahoo.it whispered secretively:
> (as an aside, I do despise learning *so* fast... I wouldn't be able to use 
> socket() without manuals, and there's a lot of stuff I'd like to learn well. 
> And I'd really like to _start_ and finish even a little project on my own... 
> it's years I don't start coding some fun project up).

The BSD socket layer is so irregular that I think *everyone* needs to refer
to the manuals when using it, unless they write networking apps in C every
few days.

>> google dar linux:
>> Some french disk archiving tool, apparently.  I generally just use tarballs
>> or rsync.
> 
> It's clear Nix is using some calculation program (not sure what's it).

I'm using both matlab/octave *and*, when running backups, said French disk
archiver. The source is gradually being Anglicised so that the developer
base can rise a bit :)

It has numerous advantages over tar and rsync if, like me, you're stuck using
a pile of CD-R[W]s as your backup medium.

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
