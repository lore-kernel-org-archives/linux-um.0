Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dglvi-00027W-35	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Jun 2005 09:00:22 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1Dglv9-0000MW-Dt	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Jun 2005 09:00:21 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] hostfs permissions
References: <quack.20050609T2234.87is0msrl6@meow.quarl.org>
In-Reply-To: <quack.20050609T2234.87is0msrl6@meow.quarl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506101803.21108.blaisorblade@yahoo.it>
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
Date: Fri, 10 Jun 2005 18:03:20 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Karl Chen <quarl@cs.berkeley.edu>

On Friday 10 June 2005 07:34, Karl Chen wrote:
> Hi, I'm doing some large-scale security experiments on Debian
> security.  I'm using UML to do the whole thing on a cluster.

> Hostfs seems to make everything owned by root -- even files
> created by non-root users.
So you are running uml as root?

Or you are running UML as non-root but with hostfs as root filesystem? In this 
case you're possibly seeing the result of a trick made to make it work 
well... but I don't know if that trick is present in the UML version you're 
using.

> I'm currently using 2.4.26-3 (Debian 
> package).
Hmm, in that case
> I found a few posts via Google mentioning a patch to 
> fix this, but no other information.  What is the modified behavior
> of hostfs permissions?  Has this been integrated into a newer
> version, or is it in cvs, or if not, are there plans to?
Well, there are:
1) HUMFS, implementing the ideal behaviour below
2) a patch posted by somebody for when UML is run by root, to allow created 
files to get the UID of the process creating it inside UML.

> [I think the ideal behavior, if UML is running as non-root, would
> be if there were a temporary mapping of ownership (e.g. so chown
> works) -- but that would be a lot of work to implement.]
Well, this work has been started but is currently stalled because of other 
ongoing work, however I hope we'll resurrect that shortly.
> I would be happy if there were uid and gid mount options as many
> other fs types have -- to treat all files in the entire mount as
> owned by a particular user/group.

Well, I'm going to add those options to UML 2.6 but I'll be able to work on 
this only next week... However this should not be too much work.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
