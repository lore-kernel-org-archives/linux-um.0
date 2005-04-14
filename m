Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DMBJA-0004VY-HN for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Apr 2005 13:51:28 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DMBIt-0004qZ-Tt for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Apr 2005 13:51:28 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] resizing root_fs
References: <000501c53fde$626198a0$0201a8c0@lualele>
In-Reply-To: <000501c53fde$626198a0$0201a8c0@lualele>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504142303.43628.blaisorblade@yahoo.it>
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
Date: Thu, 14 Apr 2005 23:03:43 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: itamar <itamar@ispbrasil.com.br>, uml-user <user-mode-linux-user@lists.sourceforge.net>

On Wednesday 13 April 2005 06:07, itamar wrote:
> dd if=/dev/zero of=root_fs.ext3 bs=1 count=1 seek=40G conv=notrunc
Right enlarging command, it seems.
> [root@router conacci]# resize2fs -p root_fs.ext3
> resize2fs 1.36 (05-Feb-2005)
> resize2fs: File too large while trying to determine filesystem size

This old resize2fs has a problem because the file is >= 2G (or something like 
that), it seems... probably truncating the file to a more normal size and 
retesting will work, so you possibly hit a resize2fs bug... at least so I 
guess. It's strange though, but I don't see any other possible explaination.

> [root@router conacci]#

> how to resize this file ?

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
