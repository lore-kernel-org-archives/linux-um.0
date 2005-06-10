Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dgrtp-0003T5-3K	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Jun 2005 15:22:49 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1Dgrtl-0007OX-8H	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Jun 2005 15:22:49 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] hostfs permissions
References: <quack.20050609T2234.87is0msrl6@meow.quarl.org>
	<200506101803.21108.blaisorblade@yahoo.it>
	<quack.20050610T1314.87aclyvuim@quack.cs.berkeley.edu>
In-Reply-To: <quack.20050610T1314.87aclyvuim@quack.cs.berkeley.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506110026.24655.blaisorblade@yahoo.it>
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
Date: Sat, 11 Jun 2005 00:26:24 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Karl Chen <quarl@cs.berkeley.edu>

On Friday 10 June 2005 22:14, Karl Chen wrote:
> >>>>> On 2005-06-10 09:03 PDT, Blaisorblade  writes:
>     >> Hostfs seems to make everything owned by root -- even files
>     >> created by non-root users.
>
>     Blaisorblade> So you are running uml as root?
>
>     Blaisorblade> Or you are running UML as non-root but with
>     Blaisorblade> hostfs as root filesystem?
>
> I'm running uml as non-root (that's part of the reason for using
> UML, so I can do everything as non-root), and not using hostfs as
> the root file system.  I just need to share one directory tree,
> and some processes inside the uml need to run as non-root.
Ok, in this case there's probably a simpler road: simply use a 2.4.27-1bs 
kernel. The implemented behaviour is that all created files will have the ID 
they have on the host, i.e. the ID of the user running UML.
>     Blaisorblade> 1) HUMFS, implementing the ideal behaviour below
>
> Humfs looks promising; I'm investigating - thanks.

>     >> I would be happy if there were uid and gid mount options as
>     >> many other fs types have -- to treat all files in the
>     >> entire mount as owned by a particular user/group.
>
>     Blaisorblade> Well, I'm going to add those options to UML 2.6
>     Blaisorblade> but I'll be able to work on this only next
>     Blaisorblade> week... However this should not be too much
>     Blaisorblade> work.
>
> Great! Thanks!  Let me know if I can help with anything.

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
