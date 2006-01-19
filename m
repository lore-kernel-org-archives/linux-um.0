Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzhJs-0004JA-4m for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 Jan 2006 13:27:48 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EzhJp-0002Ev-Ej
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 Jan 2006 13:27:48 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <200601191535.47682.blaisorblade@yahoo.it>
	<20060119204216.GA9773@ccure.user-mode-linux.org>
In-Reply-To: <20060119204216.GA9773@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601192227.42474.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: Remove l1-shift from the patchset
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
Date: Thu, 19 Jan 2006 22:27:42 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thursday 19 January 2006 21:42, Jeff Dike wrote:
> On Thu, Jan 19, 2006 at 03:35:47PM +0100, Blaisorblade wrote:
> > Again, please, remove the "l1-shift" patch from the patchset.

> Forgot to ask - do you want uml-add-tls-support-debug-check-never-works
> deleted as well?

> I have it removed from my patchset, as it doesn't look like it really
> does anything.

Yep, that load_TLS call isn't needed, as I thought even when I wrote it (I was 
looking for solutions which I didn't find). That's fine for me...
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
