Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Subject: Re: [uml-devel] video mode reprogrammed!
In-Reply-To: <Pine.LNX.4.58.0410151043400.17537@blackhole.kfki.hu>
Message-ID: <Pine.LNX.4.58.0410151218360.17537@blackhole.kfki.hu>
References: <Pine.LNX.4.58.0410151043400.17537@blackhole.kfki.hu>
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
Date: Fri, 15 Oct 2004 12:27:12 +0200 (CEST)
To: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

On Fri, 15 Oct 2004, Jozsef Kadlecsik wrote:

> When experimenting with UML (linux-2.4.26) on my laptop, I successfully
> attached a console to a free tty channel.
>
> However, UML immediately reprogrammed the BIOS to switch to a video mode,
> where only a small portion in the middle of the screen is used only.

Oh my, that was me and nothing's wrong with UML.

I used tty8 for the UML console. When switching to it, first I must had
hit Fn+F8 instead of Alt+F8: Fn+F8 toggles screen expansion on or
off, which I was not aware of.

Sorry for wasting yout time.

Best regards,
Jozsef
-
E-mail  : kadlec@blackhole.kfki.hu, kadlec@sunserv.kfki.hu
PGP key : http://www.kfki.hu/~kadlec/pgp_public_key.txt
Address : KFKI Research Institute for Particle and Nuclear Physics
          H-1525 Budapest 114, POB. 49, Hungary


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
