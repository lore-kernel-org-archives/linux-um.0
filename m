Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CaQvG-0006oN-Mp for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Dec 2004 19:49:26 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CaQvF-0003bK-8T for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Dec 2004 19:49:26 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412040452.32722.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] What to do with uml_switch?
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
Date: Sat, 4 Dec 2004 04:52:32 +0100
To: Gerd Knorr <kraxel@bytesex.org>, Steve Schmidtke <steve_schmidtke@hotmail.com>, Felix =?iso-8859-15?q?M=FCri?= <uml@uxu.ch>, Michael Richardson <mcr@marajade.sandelman.ottawa.on.ca>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

It is apparent that something is wrong with uml_switch (though I don't know 
the code and I'm not going to express technical opinion, only "management" 
one).

I've just seen about a dozen patches to Steve Schmidtke, two different 
rewrites from Gerd and Felix, and a request from Michael to merge some code 
(uml_netjig) from OpenSWAN/FreeSWAN (IIRC) into it; and it could be something 
very interesting for SuSE customers, I think - I only know that Open/FreeSWAN 
it's about VPN, nothing more - so maybe Gerd could be interested in this.

Michael, could you start posting it here, instead that to Jeff (maybe you did 
and I didn't notice, if it was time ago, but now it's the moment to repost 
it).

Felix, even if your newer code is not yet "releasable", it can help anyway... 
even just describing the changes you did and why... design ideas are more 
important than code itself sometimes.

Steve, merging at least the earlier of your patches (they are splitup The 
Right Way(tm)) might be done soon, without lots of discussions.

If you feel so, you might split uml_switch from the rest (but remember the 
user point of view - two packages doubles the setup time).

Anyway rename the uml_router folder to uml_switch, please... time to fix it!

Clearly, Jeff is current working on completely different things, and it's a 
right thing for him to do - he is not the "I'll do everything about UML" boy, 
and time is short.

It is not even the "UML dictator". So I asked him if someone else could take 
over the maintainance of uml_switch, and he basically agreed.

The only doubt is:

1) he wants to appoint somebody he really trusts as the uml_switch maintainer.

2) I think that, within the UML community, there are enough experienced 
developers that can work together and get it right themselves, even deciding 
for a CVS development model, even because userspace code has different 
stability requirements from kernelspace one (not that uml_switch can be 
faulty, just it's easier to make it correct than with UML).

This, in the most abstract form, is a well-known debate - think to "The 
Cathedral and The Bazaar" by Eric S. Raymond.

I was simply astonished when I read "Think to users as co-developers". I've 
never been against that, but reading it so clearly explained made me think.

Now, I've not started distributing SKAS patches because someone told me to do 
that. Ingo Molnar was working on it on incompatible ways, so I took his work 
and made it backwards compatible, did some other cleanups and published it 
all over. Then it become more and more serious... and one week ago Jeff said 
"I've just been happy with you taking over the maintainership over it".

If you are good guys (and you are), I think you can sort out by discussing it 
here (I'm just against the creation of a separate ML for that development - 
things don't work that way).

So, the ball is over to you. In this moment, Gerd Knorr seems the one who has 
the time and the position (working in SuSE) to manage it well (he can push 
updates to its users and so on, for instance) but it's just my little 2 
cents.

Or you might use our wiki (http://uml.harlowhill.com/) as distribution 
center... how much of you didn't ever know it exists? Well, it being so 
unknown is the biggest bug we experience now.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
