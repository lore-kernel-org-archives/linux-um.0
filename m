Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEQt7-00065g-Dt for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Oct 2004 04:20:17 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CEQt5-0001yq-BZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Oct 2004 04:20:17 -0700
Subject: Re: [uml-devel] uml "ip header error" for large (fragmented) udp
	packets
References: </ydgn6vAKqzNNA6XYwRcEgI=lge@web.de>
	<200410031711.26138.blaisorblade_spam@yahoo.it>
From: Gerd Knorr <kraxel@bytesex.org>
In-Reply-To: <200410031711.26138.blaisorblade_spam@yahoo.it>
Message-ID: <871xgevj03.fsf@bytesex.org>
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
Date: 04 Oct 2004 13:07:56 +0200
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Lars Ellenberg <Lars.Ellenberg@linbit.com>

BlaisorBlade <blaisorblade_spam@yahoo.it> writes:

> > I wonder, if someone uses nfs over udp on uml, this should
> > be a long known issue and turn up loads of hits in a search.
> > I did not find a single reference to that problem, though.
> 
> Does NFS uses large UDP packets?

Looks like it does.  I can ack that issue for the NFS case.  NFS over
tcp does fine (which seems to be the default, so I didn't notice until
now).  NFS over udp works, is very slow through and I get plenty of
"nfs server not responding" + "nfs server ok" messages in the syslog.
Looks like it doesn't loose all packets, but enougth to slowdown it
drastically and trigger timeouts on the client side.

That is (kernel) nfs server on the host machine, uml being connected
via tuntap networking and mounting /home using NFS.

  Gerd

-- 
return -ENOSIG;


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
