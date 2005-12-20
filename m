Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eoo2k-0000UE-0T for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Dec 2005 12:25:06 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Eoo2g-0002f9-V9
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Dec 2005 12:25:05 -0800
Subject: Re: [uml-devel] Re: pcap cross-linking [PATCH]
From: Antoine Martin <antoine@nagafix.co.uk>
In-Reply-To: <200512201401.03853.rob@landley.net>
References: <1134932624.10491.76.camel@localhost.localdomain>
	<200512191716.06370.blaisorblade@yahoo.it>
	<1135017219.15991.131.camel@ant.internal>
	<200512201401.03853.rob@landley.net>
Content-Type: text/plain
Message-Id: <1135110291.4622.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Date: Tue, 20 Dec 2005 20:24:50 +0000
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Blaisorblade <blaisorblade@yahoo.it>

On Tue, 2005-12-20 at 14:01 -0600, Rob Landley wrote:
> On Monday 19 December 2005 12:33, Antoine Martin wrote:
> > Yep, it's a shame compartment does not ship with all distros.
> > chroot without su is pointless (since you can use 'chroot-again' to
> > escape) changing uid/guid should really be included in chroot.
> 
> This is the first I've heard of it, and after few minutes of googling the best 
> I can find on it is this:
>   http://www.suse.de/~marc/SuSE.html
> 
> Which is from February 2001.
> 
> Is that the newest version?
Probably, all it does is: chroot / change uid/gid:
chroot(chroot_path)
setgid(set_group)
setuid(set_user)
Looking at it, there is very little code in there - which is a good
thing! Less likely to go wrong.

Antoine



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
