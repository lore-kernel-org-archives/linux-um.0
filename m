Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Alh6r-0006TD-W5 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2004 20:15:25 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Alh6r-0002DU-4d
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2004 20:15:25 -0800
Message-Id: <200401280439.i0S4dJZw005512@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Mapping con=pts to a port instead of con=port 
In-Reply-To: Your message of "Sat, 24 Jan 2004 15:34:40 +1030."
	<20040124050440.GF4203@erizo.shearer.org> 
References: <20040124050440.GF4203@erizo.shearer.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Tue, 27 Jan 2004 23:39:19 -0500
To: Dan Shearer <dan@shearer.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

dan@shearer.org said:
> The same effect can be achieved with termnetd, with the advantage of
> your in.telnetd solution that you aren't building in complexity that
> doesn't belong to UML, but without the clomp-clomp finesse telnetd
> achieves :-) 

Yeah, but it has uncleanlinesses of its own (like the need to generate a config
file on the fly), but it's cleaner than what I have now.

My major problem with it is that attaching consoles to ports will stop working
for some number of users if I switch to termnetd, and I'm willing to put up
with some amount of nastiness inside UML if it increases the size of the 
userbase that UML works for out of the box.

That concern would be somewhat assuaged if UML were generally installed with
packages that could be made to depend on termpkg, but I think that's not the
case.

				Jeff



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
