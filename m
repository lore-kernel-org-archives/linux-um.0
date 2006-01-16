Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EyJt3-0003L8-GS for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Jan 2006 18:14:25 -0800
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EyJsy-0002eD-Nu
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Jan 2006 18:14:25 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <43CA5642.9060205@gentoo.org>
In-Reply-To: <43CA5642.9060205@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601160314.05831.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: -bs patchset still useful for users?
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
Date: Mon, 16 Jan 2006 03:14:03 +0100
To: Daniel Drake <dsd@gentoo.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sunday 15 January 2006 15:03, Daniel Drake wrote:
> Hi Paolo,

> As you know, Gentoo package and distribute your -bs patchset.

> I know you (and the other usermode maintainers) have been feeding lots
> upstream lately, so I'm wondering whether the -bs patchset is still
> useful for UML users, or whether vanilla 2.6.15 can act as a suitable
> replacement?

Vanilla can do, however -bs has one little additional feature (mconsole-exec) 
and contains all bug fixes written after the release (only few important ones 
go to -stable, they're very restrictive and some -bs patches don't fix 
critical "regressions"/crashes).

In fact, most times 2.6.n-bs is entirely merged in 2.6.(n+1).

> Thanks,
> Daniel

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
