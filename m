Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B6E1f-0008CR-5I for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Mar 2004 11:26:55 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B6E1b-0001Dk-Ox for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Mar 2004 11:26:52 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] [RFE] con=port
In-Reply-To: <c3skqj$st3$1@sea.gmane.org>
Message-ID: <Pine.LNX.4.44.0403242025580.1316-100000@filer.marasystems.com>
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
Date: Wed, 24 Mar 2004 20:26:43 +0100 (CET)
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-15?Q?Sven_K=F6hler?= <skoehler@upb.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, 24 Mar 2004, [ISO-8859-15] Sven K=F6hler wrote:

> Another point would be security. Even if UML only binds to 127.0.0.1,=20
> the port is accessable by any user logged in. But i have no clever idea=20
> for that.

The solution to that is to not use TCP. Use named pipes instead.

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
