Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CnEYs-0003qb-5j for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 08 Jan 2005 03:15:14 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CnEYq-0005YG-G8 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 08 Jan 2005 03:15:14 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] 2.6.10 command line longer than 512 characters
References: <Pine.LNX.4.58.0501071105351.22595@cube.iu.hio.no>
	<Pine.LNX.4.58.0501071154410.22595@cube.iu.hio.no>
	<Pine.LNX.4.61.0501071259370.5729@webhosting.rdsbv.ro>
In-Reply-To: <Pine.LNX.4.61.0501071259370.5729@webhosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501081215.04107.blaisorblade@yahoo.it>
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
Date: Sat, 8 Jan 2005 12:15:03 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>, Kyrre M Begnum <Kyrre.Begnum@iu.hio.no>

On Friday 07 January 2005 12:02, Catalin(ux aka Dino) BOIE wrote:
> >> You have a patch at:
> >> http://kernel.umbrella.ro/kpatches/uml-extend-cmd-line-limits.patch

> > Thank you very much. Is this patch coing to find its way into mainstram
> > UML at some point or do I have to look for it in the future too?

> I forwarded it to Jeff and it "saw" the linux-kernel mailing list but no
> reponse from kernel folks.

The UML part is ok, but the general code should be reviewed well and we've had 
no time until now (also there have been holidays in the middle)...

I've added it to my TODO-list, so I hope not to forget it... but it is getting 
too long :-(. It's not obvious because I want to check properly that there is 
no bad side effect of that...

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
