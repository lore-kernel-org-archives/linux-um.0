Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7bmD-0000Is-57 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Mar 2005 08:05:13 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1D7bm8-0004PK-5f for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Mar 2005 08:05:12 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] UML freezes at hdd-intensive processes
References: <37436.128.176.89.137.1109846512.squirrel@128.176.89.137>
In-Reply-To: <37436.128.176.89.137.1109846512.squirrel@128.176.89.137>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503051633.16983.blaisorblade@yahoo.it>
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
Date: Sat, 5 Mar 2005 16:33:16 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Oliver Baltz <info@oliverbaltz.de>

On Thursday 03 March 2005 11:41, Oliver Baltz wrote:
> Hi @all,
>
> my UML hangs while intensive processes that use the HDD. For example:
> rgrep, upgrade,...
>
> UML-Hostsystem: 2.4.27-1-386, Intel ICH5 SATA 150-Controller
> UML: 2.4.26-3um-1
>
> Any ideas?
Tell us the result:

grep CONFIG_BLK_DEV_UBD_SYNC .config

And search CONFIG_BLK_DEV_UBD_SYNC in the archives at marc.theaimsgroup.com. 
The problem was discussed for 2.6 only, the solution also applies to 2.4 
(almost surely).
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
