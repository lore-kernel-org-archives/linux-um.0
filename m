Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ar9NA-0005kq-Qd
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 11 Feb 2004 21:26:48 -0800
Received: from erizo.shearer.org ([210.10.97.33] helo=shearer.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.30)
	id 1Ar9KT-0008QI-9q
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 11 Feb 2004 21:24:01 -0800
From: Dan Shearer <dan@shearer.org>
Message-ID: <20040212052823.GA4203@erizo.shearer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Subject: [uml-devel] Which UPS simulator?
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
Date: Thu, 12 Feb 2004 15:58:23 +1030
To: user-mode-linux-devel@lists.sourceforge.net
Cc: selinger@mathstat.uottawa.ca

I propose using a standard UPS interface as a way for mconsole to
trigger a full system shutdown. I don't know the UPS market well and am
hoping someone can point me a to a more open protocol that what I've
found so far. This doesn't solve the bigger problem of UML control from
mconsole, but it addresses one immediate need.

The key thing is that this doesn't require the user of the uml to use
any special software or configurations, which in turn means I don't have
to give anyone any more training than a URL for standard Linux UPS
software.

http://quasar.mathstat.uottawa.ca/~selinger/ups/simulator.c is easy to
find. It mostly implements an informally documented protocol
(http://quasar.mathstat.uottawa.ca/~selinger/ups/belkin-universal-ups.html)
and is GPLd. Some slight mods in how the communications happen and this
could be how mconsole talks to a ups daemon listening on one of the
virtual serial ports. Not sure if this includes upsd that comes with
many distros however this UPS is listed as supported at
http://eu1.networkupstools.org.

Anyone know of a simulator for a more open/more appropriate UPS protocol
that is understood by more than one of the open source UPS daemons?

-- 
Dan Shearer
dan@shearer.org


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
