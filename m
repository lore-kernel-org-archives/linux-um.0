Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWMaa-0002Ja-MA for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Nov 2004 14:23:16 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CWMaL-0002UD-OW for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Nov 2004 14:23:15 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [patch 3/4] uml: remove most devfs_mk_symlink
	calls
References: <20041119011337.74CDD7B9C9@zion.localdomain>
	<87sm726j2h.fsf@aka.i.naked.iki.fi>
In-Reply-To: <87sm726j2h.fsf@aka.i.naked.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411222325.17269.blaisorblade_spam@yahoo.it>
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
Date: Mon, 22 Nov 2004 23:25:17 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Nuutti Kotivuori <naked@iki.fi>

On Monday 22 November 2004 15:43, Nuutti Kotivuori wrote:
> blaisorblade spam wrote:
> > Since now we have evidence of less and less users using devfs, we
> > think that it will not cause too much problems.

> Just checking - these changes do not remove support for using UML with
> devfs, only removing automatic symlink creations, am I right?
Yes, exactly.

> We still depend on devfs working quite heavily, so I'm just making
> sure.
I'd suggest to also stop using /dev/ubd/0 symlinks and going directly 
to /dev/ubd/disc.../disc (whatever), since the first one could soon go away 
(I've deferred that at least for now).

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
