Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eonfm-0007PA-Mj for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Dec 2005 12:01:22 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Eonfk-0008Fw-1g
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Dec 2005 12:01:22 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Re: pcap cross-linking [PATCH]
References: <1134932624.10491.76.camel@localhost.localdomain>
	<200512191716.06370.blaisorblade@yahoo.it>
	<1135017219.15991.131.camel@ant.internal>
In-Reply-To: <1135017219.15991.131.camel@ant.internal>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512201401.03853.rob@landley.net>
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
Date: Tue, 20 Dec 2005 14:01:03 -0600
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Antoine Martin <antoine@nagafix.co.uk>, Blaisorblade <blaisorblade@yahoo.it>

On Monday 19 December 2005 12:33, Antoine Martin wrote:
> I think I'll rebuild it with compartment and build su without pam to
> trim it down even more.
>
> > > (also lib/security so I can get into the chroot)
> >
> > That's for su, right? There are some tools (including "compartment") to
> > combine chroot + su together.
>
> Yep, it's a shame compartment does not ship with all distros.
> chroot without su is pointless (since you can use 'chroot-again' to
> escape) changing uid/guid should really be included in chroot.

This is the first I've heard of it, and after few minutes of googling the best 
I can find on it is this:
  http://www.suse.de/~marc/SuSE.html

Which is from February 2001.

Is that the newest version?

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
