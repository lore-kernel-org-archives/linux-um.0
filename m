Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [uml-devel] Re: [uml-user] UML "Distro" ?
In-Reply-To: <87brewe7lq.fsf@bytesex.org>
Message-ID: <Pine.GSO.4.61.0410211451460.614@waterleaf.sonytel.be>
References: <053e01c4b6f4$93f48e90$2000000a@schlepptopp>
	<87brewe7lq.fsf@bytesex.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Thu, 21 Oct 2004 14:52:29 +0200 (MEST)
To: Gerd Knorr <kraxel@bytesex.org>
Cc: roland <for_spam@gmx.de>, user-mode-linux-user@lists.sourceforge.net, User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

On Thu, 21 Oct 2004, Gerd Knorr wrote:
> "roland" <for_spam@gmx.de> writes:
> > What do you think ?
> > 
> > ( ) Ohhhh - nooooo, not another Distro!
> > ( ) probably useful to make setup/usage of UML easier
> > ( ) becoming useless, if skas/sysemu go into vanilla kernel
> 
> [x] Distributions already working on it ;)
> 
> SuSE ships uml + skas-patched kernels for quite some time.  The other
> stuff also slowly moves forward to better UML support, the yast2
> installer runs just fine within a UML environment for example.
> 
> Debian also has uml packages (havn't tested them through).

Put AFAIK the standard Debian kernels don't contain the SKAS patch. They do
ship kernel-patch-skas as a separate package.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
