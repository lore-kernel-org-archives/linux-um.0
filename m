Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] Workaround for bug #851759 -  SuSE YAST in textmode
 does not work
In-Reply-To: <1070843660.31073.84.camel@wopr.tektonic.net>
Message-ID: <Pine.LNX.4.44.0312081034150.9997-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 8 Dec 2003 10:40:27 +0100 (CET)
To: Matt Ayres <matta@tektonic.net>
Cc: roland <for_spam@gmx.de>, user-mode-linux-devel@lists.sourceforge.net, uml-user <user-mode-linux-user@lists.sourceforge.net>

On Sun, 7 Dec 2003, Matt Ayres wrote:

> I don't know about llseek, but access to /dev/random seems to be VERY
> slow from within UML.

That would not be supricing... UML does not have very good random sources
to populate /dev/random and /dev/random very easily gets drained of the
little random information it has.. and in fact the same applies to all
architectures unless your hardware has a random number generator.

Generally /dev/urandom provides sufficient random information for most
purposes. Why are you using /dev/random and not /dev/urandom?

Regards
Henrik



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
