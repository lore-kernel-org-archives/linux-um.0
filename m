Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRkju-00010t-Ex for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Apr 2006 23:46:38 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FRkju-0008BR-2K
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Apr 2006 23:46:38 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [RFC][PATCH] include /usr/lib/uml in PATH
References: <20060402173445.GB5108@inferi.kami.home>
	<200604040239.45495.blaisorblade@yahoo.it>
	<20060405211153.GE8583@inferi.kami.home>
In-Reply-To: <20060405211153.GE8583@inferi.kami.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604070845.39534.blaisorblade@yahoo.it>
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
Date: Fri, 7 Apr 2006 08:45:38 +0200
To: Mattia Dongili <malattia@linux.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>, Jeff Dike <jdike@addtoit.com>

On Wednesday 05 April 2006 23:11, Mattia Dongili wrote:
> On Tue, Apr 04, 2006 at 02:39:44AM +0200, Blaisorblade wrote:
> > On Sunday 02 April 2006 21:54, Mattia Dongili wrote:
>
> [...]
>
> > Thanks for the patch, we'll possibly apply it, but we need to reimplement
> > (or copy and fix from glibc) a two-phase execvp(). I've not done it
> > because I've felt unconfortable with the idea but it's the better I could
> > think of for now.
>
> Hmm. I see.
>
> > However, probably the patch can be merged anyway, or at least its idea...
>
> [...]

> > *) I'd agree with Geert, but you're indeed correct for that...
> > *) Saying "19" gets a "NO"

> I'm sorry... damn lazy programmers :)

> > #define UML_LIB_PATH ":/usr/lib/uml"

> what about a config option instead? CONFIG_UML_NET_PATH

Don't think so, that's not supposed to be changed according to any config 
option or I can't see that. Unless on 64-bit system that's /usr/lib64/uml, 
and in that case it makes sense to have CONFIG_XXX = 
"/usr/lib/uml" (without :, add them only in the source, i.e. insulate details 
away).

> > 19 -> strlen(UML_LIB_PATH)
> > in snprintf, "PATH=%s:/usr/lib/uml" -> "PATH=%s" UML_LIB_PATH
> >
> > (using string literal concatenation)

> here's an updated patch, I added a check for current PATH=="" to avoid
> touching the PATH variable when empty (again, kind of keeping the same
> behaviour of a clean execvp, I mean it makes no sense to append
> /usr/lib/uml and not /bin:/usr/bin too).

In that case, you should append both IMHO - empty PATH and no PATH should be 
treated the same way, I think.

I'm not sure we need to cope with such strange settings, but doing it isn't 
bad.

Btw, as a last note - we don't use sizeof(char), I don't know if that size is 
mandated by the C standard but anyway I've never seen anything like 
sizeof(char) in the Linux kernel.

> Description:
> append /usr/lib/uml to the existing PATH environment variable to let
> execvp search uml_net in FHS compliant locations.

> Signed-off-by: Mattia Dongili <malattia@linux.it>

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
