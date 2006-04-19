Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FW9JL-0001A3-Mu for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Apr 2006 02:49:23 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FW9JJ-0007Rw-TR
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Apr 2006 02:49:23 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [RFC][PATCH] include /usr/lib/uml in PATH
References: <20060402173445.GB5108@inferi.kami.home>
	<20060407165205.GE23715@inferi.kami.home>
	<20060409125221.GB7503@SteX>
In-Reply-To: <20060409125221.GB7503@SteX>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200604191152.10992.blaisorblade@yahoo.it>
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
Date: Wed, 19 Apr 2006 11:52:10 +0200
To: user-mode-linux-devel@lists.sourceforge.net, stefano.melchior@openlabs.it
Cc: Mattia Dongili <malattia@linux.it>, Geert Uytterhoeven <geert@linux-m68k.org>, Jeff Dike <jdike@addtoit.com>

On Sunday 09 April 2006 14:52, Stefano Melchior wrote:
> On Fri, Apr 07, 2006 at 06:52:05PM +0200, Mattia Dongili wrote:
> Dear all,

> > > > > #define UML_LIB_PATH ":/usr/lib/uml"

> > > > what about a config option instead? CONFIG_UML_NET_PATH

> > > Don't think so, that's not supposed to be changed according to any
> > > config option or I can't see that. Unless on 64-bit system that's
> > > /usr/lib64/uml, and in that case it makes sense to have CONFIG_XXX =
> > > "/usr/lib/uml" (without :, add them only in the source, i.e. insulate
> > > details away).

> > Yes, that was what I meant. However it's probably not worth the effort
> > yet.


> > Description:
> > append /usr/lib/uml to the existing PATH environment variable to let
> > execvp search uml_net in FHS compliant locations.
>
> at this point, is it the case to have also this patch for the
> uml-utilities in order to install uml-net directly on the FHS complaint
> path (uml-net):

It is likely a correct patch (didn't proof-read, seems very reasonable) but:

a) make sure it can work on amd64 (/usr/lib or /usr/lib64?)
b) I'll do this in at least 6 months from now, or users will scream - or I'll 
add a compatibility symlink in /usr/bin for a while.

Debian did it the hard way IIRC (don't remember if only for the default 
location of uml_switch socket or also for this), and problems resulted for 
people with self-compiled kernels.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
