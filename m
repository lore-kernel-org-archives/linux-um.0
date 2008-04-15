Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JlsFk-0002Au-WD for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Apr 2008 13:59:45 -0700
Received: from an-out-0708.google.com ([209.85.132.240])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JlsFh-0000mD-Id
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Apr 2008 13:59:44 -0700
Received: by an-out-0708.google.com with SMTP id b38so612333ana.6
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 15 Apr 2008 13:59:40 -0700 (PDT)
Message-ID: <cfa94dc20804151359h6dc1bf20l1c2bab38f734a595@mail.gmail.com>
Date: Tue, 15 Apr 2008 13:59:39 -0700
From: "Ryan Finnie" <ryan@finnie.org>
In-Reply-To: <87y77elx37.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Content-Disposition: inline
References: <87k5jcqmh8.fsf@hades.wkstn.nix>
	<20080414144052.GA7186@c2.user-mode-linux.org>
	<87y77elx37.fsf@hades.wkstn.nix>
Subject: Re: [uml-devel] Lockups with the fixed timer code :/
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Nix <nix@esperi.org.uk>
Cc: Jeff Dike <jdike@addtoit.com>, Thomas Gleixner <tglx@timesys.com>, user-mode-linux-devel@lists.sourceforge.net

On Tue, Apr 15, 2008 at 12:47 PM, Nix <nix@esperi.org.uk> wrote:
>  > The problem is NTP adjusting the multiplier part of the clock-provided
>  > cycles-to-ns conversion function.  UML pretended to have a ns clock,
>  > with a multiplier of 1.  When NTP adjusted that down in order to slow
>  > down the clock, that became 0, and time stopped.
>
>  ... hang on, wouldn't this only happen if you had NTP running on your
>  guest? (I don't. For that matter, *why* would you have NTP running on
>  your guest? The guest just gets the time of day from the host anyway!)

Yes, ntpd would be required to trigger (or anything that adjusts mult,
but I can't think of anything other than ntpd that would.

(Anyway, this would be my doing; I was the only who reported the
hanging a few weeks ago, and Jeff had been banging on on my test
server, where with a dozen or so guests running concurrently, at least
one of them would trigger within an hour.  And the reason I have ntpd
running on UML guests is I use the same deployment script for both UML
guests and physical dedicated servers.)

RF

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
