Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EkmQJ-0002yg-IF for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Dec 2005 09:52:47 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EkmQI-00048L-4q
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Dec 2005 09:52:47 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] tls: set_thread_area failed
References: <1134008028.32598.52.camel@localhost.localdomain>
In-Reply-To: <1134008028.32598.52.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512091852.15906.blaisorblade@yahoo.it>
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
Date: Fri, 9 Dec 2005 18:52:15 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Antoine Martin <antoine@nagafix.co.uk>

On Thursday 08 December 2005 03:13, Antoine Martin wrote:
> I'm still trying to get a regular FC4 image to boot with the latest x86
> tls support code.
Mainline kernel or with jdike patchset?
> (since Gentoo works fine) 
> but this is what I get:
> # fsck.ext3 -a /dev/ubda
> set_thread_area failed when setting up thread-local storage
> Segmentation fault

> Is this glibc? Any ideas?

Yes, I see that on Debian Sarge too. Don't ask me why fsck uses thread, but it 
seems to do that.

Also, different glibc are more or less happy in using modify_ldt() rather than 
set_thread_area() - it seems that latter is better.

> Thanks
> Antoine

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
