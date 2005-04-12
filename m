Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DLP0H-0002E4-Cx for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Apr 2005 10:16:45 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DLOzx-0002Dj-DB for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Apr 2005 10:16:45 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] My personal -devel tree snapshotted out on my
	homepage!
References: <200504082020.18943.blaisorblade@yahoo.it>
	<cbec11ac0504101619cfd1bf1@mail.gmail.com>
In-Reply-To: <cbec11ac0504101619cfd1bf1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504121923.34999.blaisorblade@yahoo.it>
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
Date: Tue, 12 Apr 2005 19:23:34 +0200
To: Ian McDonald <imcdnzl@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Monday 11 April 2005 01:19, Ian McDonald wrote:
> With this patch applied to 2.6.11.7 it is my first kernel that
> compiles straight off :-)
Ok, that's the -bs tree, not the one I announced here (the -devel one) but 
it's ok anyway.
> It does not apply one patch because it is already applied which is fine.
Yes, I merged that, it's the va_copy fix.
> I did a quick test against 2.6.12-rc2 and it didn't like that at all
> (many rejected patches). That is to be expected though as that is not
> the target but it does mean a reasonable amount of work ahead for
> Paolo :-(
No; luckily, I'm mainly working on -rc2 and I've backported the needed stuff 
to 2.6.11.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
