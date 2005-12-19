Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EoNnT-0000uL-5n for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Dec 2005 08:23:35 -0800
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EoNnR-0004H1-DP
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Dec 2005 08:23:35 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] skas3 (almost) works on amd64?
References: <200504181134.53390.markc@renta.net>
	<1113844082.11747.33.camel@cobra>
	<1134932639.10491.78.camel@localhost.localdomain>
In-Reply-To: <1134932639.10491.78.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512191723.19829.blaisorblade@yahoo.it>
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
Date: Mon, 19 Dec 2005 17:23:19 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Antoine Martin <antoine@nagafix.co.uk>

On Sunday 18 December 2005 20:03, Antoine Martin wrote:
> (..)
>
> > > I can't speak to how stable it was. I'm pretty sure I wasn't using
> > > Skas,

> > It isn't skas as the skas3 code hasn't been ported to x86_64 yet.

> Or has it?

Wait a moment - I remember informing somebody (probably you) that all 32-bit 
Slackware-based root_fs work in SKAS3 mode very well on 64-bit hosts.

And you saying "yes it works, I know this".

SKAS64 support is implemented in the SKAS patch, but IIRC not in the guest 
kernel - there are just a few things to fix up (for instance 
using /proc/mm64), but I gave up as I hadn't found a solution to SKAS32-on-64 
problems, and the changes were boring to do, and impossible to get right 
without a testing possibility.

Actually, there is even some information I saved on a bug interfering here - 
i.e. a description from Bodo Stroesser.

I've not found the time to do my homeworks on the subject (aka studying the 
SYSENTER instruction) and then go studying that description.
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
