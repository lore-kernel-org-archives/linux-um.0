Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CERSn-0005gi-RF for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Oct 2004 04:57:09 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CERSm-0008J8-KV for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Oct 2004 04:57:09 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] uml "ip header error" for large (fragmented) udp
	packets
In-Reply-To: <871xgevj03.fsf@bytesex.org>
Message-ID: <Pine.LNX.4.61.0410041352560.28418@filer.marasystems.com>
References: </ydgn6vAKqzNNA6XYwRcEgI=lge@web.de>
	<200410031711.26138.blaisorblade_spam@yahoo.it>
	<871xgevj03.fsf@bytesex.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
Date: Mon, 4 Oct 2004 13:56:23 +0200 (CEST)
To: Gerd Knorr <kraxel@bytesex.org>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, Lars Ellenberg <Lars.Ellenberg@linbit.com>

On Mon, 4 Oct 2004, Gerd Knorr wrote:

>> Does NFS uses large UDP packets?
>
> Looks like it does.

The NFS message size is normally 4096 + message headers + protocol layers. 
The rsize/wsize mount parameters has a play in this.. (NFS data payload 
size within the NFS RPC message over UDP).

Regards
Henrik


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
