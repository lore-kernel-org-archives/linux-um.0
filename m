Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWbme-0001Fm-3f for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 06:36:44 -0800
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CWbmc-0002Sv-Ha for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 06:36:43 -0800
Subject: Re: [uml-devel] Re: [patch 3/4] uml: remove most devfs_mk_symlink
	calls
References: <20041119011337.74CDD7B9C9@zion.localdomain>
	<87sm726j2h.fsf@aka.i.naked.iki.fi>
	<200411222325.17269.blaisorblade_spam@yahoo.it>
From: Nuutti Kotivuori <naked@iki.fi>
In-Reply-To: <200411222325.17269.blaisorblade_spam@yahoo.it> (Blaisorblade's
	message of "Mon, 22 Nov 2004 23:25:17 +0100")
Message-ID: <87k6sc7hu6.fsf@aka.i.naked.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Tue, 23 Nov 2004 16:36:33 +0200
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

Blaisorblade wrote:
> I'd suggest to also stop using /dev/ubd/0 symlinks and going
> directly to /dev/ubd/disc.../disc (whatever), since the first one
> could soon go away (I've deferred that at least for now).

We run devfsd and have configured the /dev/ubd0 and /dev/ubd/0 style
symlinks there.

Thanks,
-- Naked


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
