Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EtAKQ-0002SF-Ec for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Jan 2006 13:01:22 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EtAKP-0006e7-4n
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Jan 2006 13:01:22 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Re: pcap cross-linking [PATCH]
References: <CGEGKKNGBDKPCKOKKGFEIEBACDAA.brocka@sterlingcgi.com>
	<200512291412.26158.rob@landley.net>
	<200601011951.58543.blaisorblade@yahoo.it>
In-Reply-To: <200601011951.58543.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601011501.20289.rob@landley.net>
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
Date: Sun, 1 Jan 2006 15:01:20 -0600
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Anthony Brock <brocka@sterlingcgi.com>

On Sunday 01 January 2006 12:51, Blaisorblade wrote:

> So? I've read this message, but my (original) main question was:
> is
>
> > >  chroot(chroot_dir);
> > >  chdir("/");
>
> the same as
>
> > >  chdir(chroot_dir);
> > >  chroot(".");
>
> ?

All chroot does is change the / value.  It doesn't recalculate .. for the 
current directory, so if you don't chdir after the chroot you may wind up 
with .. pointing someplace it shouldn't. 

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
