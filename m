Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bbj23-0003wR-3q for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Jun 2004 09:49:31 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1Bbj22-0007WH-HC for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Jun 2004 09:49:30 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] 2.6.x x86_64 skas3 patch?
References: <Pine.LNX.4.58.0406190934090.5995@jackhammer.localdomain>
In-Reply-To: <Pine.LNX.4.58.0406190934090.5995@jackhammer.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406191900.13676.blaisorblade_spam@yahoo.it>
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
Date: Sat, 19 Jun 2004 19:00:13 +0200
To: Rus Foster <rghf@fsck.me.uk>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Alle 10:35, sabato 19 giugno 2004, Rus Foster ha scritto:
> Hi All,
>  Now I know jdike has got 64 bit UML running but I will be dammened if I
> can find the skas3 patch for 2.6.x hosts on x86_64. Does it even exist of
> was jdike using 2.4.x?
>
> Rus

None, there does not exist a SKAS patch for the host. Currently x86_64 seems 
to run in SKAS mode without a host SKAS patch. Or better, I've seen two 
changes in the patch which remove two uses of that patch...

Nevertheless, most of the performance improvement does not need a host SKAS 
patch. It's only purpose is to avoid creating zilion of threads on the host 
as in TT mode (which indeed is a bit costly).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
