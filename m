Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B6EMY-0005Lc-6R for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Mar 2004 11:48:30 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B6EMW-0003QH-7V for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Mar 2004 11:48:28 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] [RFE] con=port
In-Reply-To: <4061E412.3060305@upb.de>
Message-ID: <Pine.LNX.4.44.0403242044560.1821-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
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
Date: Wed, 24 Mar 2004 20:48:25 +0100 (CET)
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, 24 Mar 2004, Sven K=F6hler wrote:

> But that limits the clients to Applications that support named pipes. I=20
> think telnet doesn't, and the Java-Application that i had in mind=20
> wouldn't too.

TCP does not have any access controls other than IP. If you need further
low-level access controls then you need to use a scheme which has access
controls such as UNIX domain sockets or named pipes.

Fair?

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
