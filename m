Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzGPC-0004q9-JO for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 08:43:30 -0800
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EzGP6-0000UK-Q8
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 08:43:30 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] arch/um/include/kern_util.h:35: error:
	'CONFIG_NR_CPUS' undeclared
References: <20060116171447.GA15932@suse.de> <20060118130403.GA21457@suse.de>
	<20060118143742.GB5154@ccure.user-mode-linux.org>
In-Reply-To: <20060118143742.GB5154@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601181743.04311.blaisorblade@yahoo.it>
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
Date: Wed, 18 Jan 2006 17:42:56 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Olaf Hering <olh@suse.de>

On Wednesday 18 January 2006 15:37, Jeff Dike wrote:
> On Wed, Jan 18, 2006 at 02:04:04PM +0100, Olaf Hering wrote:
> > These definitions are gone from glibc 2.4, has to be fixed in uml.

I guess that using the same values is hackily guaranteed to work for binary 
compatibility, right?

> Yeah, we knew that was going to be fragile.  Needs fixing.

This sort of things is what autoconf is for. However we shouldn't use that, 
and probably not its ideas... in the past we've used grep into headers (for 
hostfs, a stat field had been renamed).

Btw, while about setjmp/longjmp: they save only a few registers, not all ones 
(and obviously not EAX and the return value); in fact GCC docs says that 
local variables should be marked as volatile or risk being destroyed.

What about this? Inserting an asm volatile clobbering all unsaved registers 
(what I thought for long time)? Or taking the libc implementation and suiting 
it for our use, solving the above problem?

We do such things for context switch in the traced process, doing it for us 
should be simpler (but it's in assembler).
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
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
