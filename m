Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Et8JW-0006ER-0X for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Jan 2006 10:52:18 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Et8JR-0002it-Cc
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Jan 2006 10:52:18 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: pcap cross-linking [PATCH]
References: <CGEGKKNGBDKPCKOKKGFEIEBACDAA.brocka@sterlingcgi.com>
	<200512231711.27326.blaisorblade@yahoo.it>
	<200512291412.26158.rob@landley.net>
In-Reply-To: <200512291412.26158.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601011951.58543.blaisorblade@yahoo.it>
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
Date: Sun, 1 Jan 2006 19:51:58 +0100
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Anthony Brock <brocka@sterlingcgi.com>

On Thursday 29 December 2005 21:12, Rob Landley wrote:
> On Friday 23 December 2005 10:11, Blaisorblade wrote:
> > One question: would
> >  chroot(chroot_dir);
> >  chdir("/");
> > work equally well?
> > I've not seen it used so I wonder (a bit) if there can be some hidden
> > bug.
>
> http://www.ussg.iu.edu/hypermail/linux/kernel/0511.2/0185.html

So? I've read this message, but my (original) main question was:
is 
> >  chroot(chroot_dir);
> >  chdir("/");
the same as 
> >  chdir(chroot_dir);
> >  chroot(".");
?

Maybe there was a misunderstanding, but the answer to the question is still 
"it seems yes, until somebody shows me I'm wrong".

I know that yes, chroot() has all the other problems (like the "root can 
escape" described in man 2 chroot, or the one by Linus).

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
