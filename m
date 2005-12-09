Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EknA9-0005mp-Hj for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Dec 2005 10:40:09 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EknA8-0005RV-9p
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Dec 2005 10:40:09 -0800
Subject: Re: [uml-devel] tls: set_thread_area failed
From: Antoine Martin <antoine@nagafix.co.uk>
In-Reply-To: <200512091852.15906.blaisorblade@yahoo.it>
References: <1134008028.32598.52.camel@localhost.localdomain>
	<200512091852.15906.blaisorblade@yahoo.it>
Content-Type: text/plain
Message-Id: <1134153592.29209.2.camel@localhost.localdomain>
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
Date: Fri, 09 Dec 2005 18:39:52 +0000
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, 2005-12-09 at 18:52 +0100, Blaisorblade wrote:
> On Thursday 08 December 2005 03:13, Antoine Martin wrote:
> > I'm still trying to get a regular FC4 image to boot with the latest x86
> > tls support code.
> Mainline kernel or with jdike patchset?
Latest jdike from sf
> > (since Gentoo works fine) 
> > but this is what I get:
> > # fsck.ext3 -a /dev/ubda
> > set_thread_area failed when setting up thread-local storage
> > Segmentation fault
> 
> > Is this glibc? Any ideas?
> 
> Yes, I see that on Debian Sarge too. Don't ask me why fsck uses thread, but it 
> seems to do that.
I wasn't even thinking about that! So true, why on earth would fsck
require threading!?

> Also, different glibc are more or less happy in using modify_ldt() rather than 
> set_thread_area() - it seems that latter is better.
Ahh, is it planned or do I have to make heavily modified distro images?

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
