Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CbOac-0002B6-9a for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Dec 2004 11:32:06 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CbOab-0000V6-Au for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Dec 2004 11:32:06 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] RE: What to do with uml_switch?
References: <BAY24-F30259BA099D39BC383A19D83B30@phx.gbl>
In-Reply-To: <BAY24-F30259BA099D39BC383A19D83B30@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412062035.40672.blaisorblade_spam@yahoo.it>
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
Date: Mon, 6 Dec 2004 20:35:40 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Steve Schmidtke <steve_schmidtke@hotmail.com>, kraxel@bytesex.org, uml@uxu.ch, mcr@marajade.sandelman.ottawa.on.ca, jdike@addtoit.com

On Sunday 05 December 2004 21:00, Steve Schmidtke wrote:
> Blaisorblade wrote:
> >It is apparent that something is wrong with uml_switch (though I don't
> > know the code and I'm not going to express technical opinion, only
> > "management" one).

> Yes, the fact that a core file has sat in the directory for almost 2 years
> says something. :)

> >Steve, merging at least the earlier of your patches (they are splitup The
> >Right Way(tm)) might be done soon, without lots of discussions.

> Thanks.  I havn't noticed any problems with the changes I've made so far.

> >If you feel so, you might split uml_switch from the rest (but remember the
> >user point of view - two packages doubles the setup time).

> Who is this directed to?  Who is the maintainer at the moment anyways?

It's (un)maintained by Jeff Dike, i.e. he's the last one updating the version 
on sf.net (you might call that "official version" - but I'm against the 
"official version" concept). Actually, you can guess he has no time to do 
anything else than bugfixes on it. We haven't yet managed to build one single 
2.4 up-to-date UML tree (i.e. with both *all* security fixes and the work 
against 2.6.9 host). Currently probably the stablest version seems to be one 
of the 2.6.9 incarnations (either it or -bb4).

> >If you are good guys (and you are), I think you can sort out by discussing
> >it
> >here (I'm just against the creation of a separate ML for that development
> > - things don't work that way).

> >So, the ball is over to you. In this moment, Gerd Knorr seems the one who
> >has
> >the time and the position (working in SuSE) to manage it well (he can push
> >updates to its users and so on, for instance) but it's just my little 2
> >cents.

> I'd be happy with Gerd as maintainer.  I'd nominate myself, but I have no
> system that I can dedicate to the project.  I also have a hard time saying
> no to interesting ideas.

Which is bad about stability... however you share that with Jeff Dike, it 
seems :-)

> Steve Schmidtke

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
