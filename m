Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FQZag-0002xm-Db for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Apr 2006 17:40:14 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FQZac-0004rm-F7
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Apr 2006 17:40:14 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [RFC][PATCH] include /usr/lib/uml in PATH
References: <20060402173445.GB5108@inferi.kami.home>
	<Pine.LNX.4.62.0604022027190.15153@pademelon.sonytel.be>
	<20060402195409.GA3695@inferi.kami.home>
In-Reply-To: <20060402195409.GA3695@inferi.kami.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604040239.45495.blaisorblade@yahoo.it>
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
Date: Tue, 4 Apr 2006 02:39:44 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Mattia Dongili <malattia@linux.it>, Geert Uytterhoeven <geert@linux-m68k.org>, Jeff Dike <jdike@addtoit.com>

On Sunday 02 April 2006 21:54, Mattia Dongili wrote:
> On Sun, Apr 02, 2006 at 08:29:12PM +0200, Geert Uytterhoeven wrote:
> > On Sun, 2 Apr 2006, Mattia Dongili wrote:
>
> [...]
>
> > > --- a/arch/um/os-Linux/helper.c	2006-04-02 16:32:38.340801686 +0200
> > > +++ b/arch/um/os-Linux/helper.c	2006-04-02 16:34:13.454745936 +0200
> > > @@ -22,6 +22,9 @@ struct helper_data {
> > >  	int fd;
> > >  };
> > >
> > > +/* PATH variable to find uml helpers  installed in FHS compliant
> > > locations */ +static char *alt_path =
> > > "PATH=:/bin:/usr/bin:/usr/lib/uml";
> >
> >                                  ^
> > Woops, this puts the current directory first in your path, which is
> > probably
>
> Urgh! that was just the default path straight from the execle manpage.
> The attached patch reimplements the thing appending /usr/lib/uml only
> once before starting UML. Still using the above PATH if no PATH variable
> exists as execle behaves in the same way.

Thanks for the patch, we'll possibly apply it, but we need to reimplement (or 
copy and fix from glibc) a two-phase execvp(). I've not done it because I've 
felt unconfortable with the idea but it's the better I could think of for 
now.

In practice, we must avoid any memory allocation after a fork or clone on the 
host, because we use the kernel allocator and after a fork() it can't be 
used.

I'm unsure whether using the libc allocator would work in that case but mixing 
two memory allocators is something I'd never do unless impossible to avoid 
(and indeed, the current code does that and I haven't many ideas; however, 
int this case it can be avoided, by performing the PATH lookup before the 
fork()).

However, probably the patch can be merged anyway, or at least its idea...

*) I'd agree with Geert, but you're indeed correct for that...
*) Saying "19" gets a "NO".

#define UML_LIB_PATH ":/usr/lib/uml"
19 -> strlen(UML_LIB_PATH)
in snprintf, "PATH=%s:/usr/lib/uml" -> "PATH=%s" UML_LIB_PATH

(using string literal concatenation)

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
