Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EppWE-0004sE-HI for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Dec 2005 08:11:46 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EppWA-00029I-Ps
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Dec 2005 08:11:46 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: pcap cross-linking [PATCH]
References: <CGEGKKNGBDKPCKOKKGFEIEBACDAA.brocka@sterlingcgi.com>
In-Reply-To: <CGEGKKNGBDKPCKOKKGFEIEBACDAA.brocka@sterlingcgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512231711.27326.blaisorblade@yahoo.it>
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
Date: Fri, 23 Dec 2005 17:11:26 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Anthony Brock <brocka@sterlingcgi.com>

On Thursday 22 December 2005 18:57, Anthony Brock wrote:
> I don't think the attachment made it into the email.
It was in the previous one but I had forgot to describe it - sorry for the 
misunderstanding.

> However, I am 
> attaching one that we've used with good success. It allows us to also
> specify a "nice" level for the UML kernel in addition to the chroot-setuid.
Nice tool, well written.

Only one minor complaint: you do the following sequence (excluding error 
paths):

	chdir(chroot_dir);
	chroot(chroot_dir);

this will fail needlessly if a relative path is used.

Replacing the chroot with chroot(".") would be better, IMHO.

One question: would 
	chroot(chroot_dir);
	chdir("/");
work equally well?
I've not seen it used so I wonder (a bit) if there can be some hidden bug.
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
