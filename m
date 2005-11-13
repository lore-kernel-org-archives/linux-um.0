Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eb64Y-0001dG-VX for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Nov 2005 16:50:18 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Eb64Y-0006ol-O7
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Nov 2005 16:50:19 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Re: Why did oldconfig's behavior change in 2.6.15-rc1?
References: <200511121656.29445.rob@landley.net>
	<200511121731.25982.rob@landley.net>
	<Pine.LNX.4.61.0511130042530.1610@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0511130042530.1610@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511121850.01690.rob@landley.net>
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
Date: Sat, 12 Nov 2005 18:50:01 -0600
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org

On Saturday 12 November 2005 17:49, Roman Zippel wrote:
> Hi,
>
> On Sat, 12 Nov 2005, Rob Landley wrote:
> > Why did oldconfig switch off CONFIG_MODE_SKAS?  It didn't do that before.
> > Hmmm...  Rummage, rummage...  Darn it, it's position dependent.  _And_
> > version dependent.
>
> It's _not_ position dependent, but the behaviour with multiple equal
> symbols is undefined.

I just want a minimally expressed config.  I've jumped through a number of 
hoops trying to get "allnoconfig plus these symbols" to work.

Setting .config to my symbol list and doing old config prompts a lot, doing 
yes "" | oldconfig sets lots of crap by default (since not all default values 
are n), and doing yes "n" | oldconfig goes into an endless loop every time 
it's prompting for a number or some such.  You have to start with 
allnoconfig.  Appending the new symbols and re-running oldconfig worked for a 
number of versions, until now.  Now you have to insert the new symbols at the 
beginning.

I could presumably also work around the new breakage via following allnoconfig 
with a sed -i invocation to remove the appropriate "# blah is not set" lines 
before appending the symbols.  (Of course it means that the config symbol 
list has to be fed into a for loop instead of being expressed in the same 
format as config, which sucks deeply.  Insert at the beginning works until it 
changes again...)

> > Ok, now I have to put the new entries at the _beginning_.  Appending them
> > doesn't work anymore, it now ignores any symbol it's already seen, so you
> > can't easily start with allnoconfig, switch on just what you want, and
> > expect oldconfig to do anything intelligent.
>
> Now you can put them in allno.config instead and allnoconfig will do the
> right thing.

Testing...

Ok, that worked.  Weird and totally unituitive name for a miniconfig, but oh 
well.

Is this documented anywhere?

Rob


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
