Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1El5gF-0008Kz-LX for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Dec 2005 06:26:31 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1El5gD-0004GN-IB
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Dec 2005 06:26:31 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] tls: set_thread_area failed
References: <1134008028.32598.52.camel@localhost.localdomain>
	<200512091852.15906.blaisorblade@yahoo.it>
	<1134153592.29209.2.camel@localhost.localdomain>
In-Reply-To: <1134153592.29209.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512101526.17891.blaisorblade@yahoo.it>
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
Date: Sat, 10 Dec 2005 15:26:17 +0100
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Friday 09 December 2005 19:39, Antoine Martin wrote:
> On Fri, 2005-12-09 at 18:52 +0100, Blaisorblade wrote:
> > On Thursday 08 December 2005 03:13, Antoine Martin wrote:
> > > I'm still trying to get a regular FC4 image to boot with the latest x86
> > > tls support code.
> >
> > Mainline kernel or with jdike patchset?

> Latest jdike from sf

> > > (since Gentoo works fine)
> > > but this is what I get:
> > > # fsck.ext3 -a /dev/ubda
> > > set_thread_area failed when setting up thread-local storage
> > > Segmentation fault

> > > Is this glibc? Any ideas?

> > Yes, I see that on Debian Sarge too. Don't ask me why fsck uses thread,
> > but it seems to do that.

> I wasn't even thinking about that! So true, why on earth would fsck
> require threading!?

> > Also, different glibc are more or less happy in using modify_ldt() rather
> > than set_thread_area() - it seems that latter is better.

> Ahh, is it planned 
What?
> or do I have to make heavily modified distro images? 
I'm not suggesting that...

And, hold on this - Jeff has made a big progress on this, diagnosing what had 
been happening.

I'm not sure how well it works, but in the incrementals page there's the new 
result. Give it a run and tell us the result, if it works it might go in 
2.6.15-bs and 2.6.16.
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
