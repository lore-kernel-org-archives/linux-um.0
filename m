Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTyhp-0005UF-Gn for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 May 2004 00:56:37 -0700
Received: from [218.189.183.34] (helo=lifewood.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTyhp-0007Je-4E for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 May 2004 00:56:37 -0700
Message-Id: <200405290754.i4T7sZa19953@lifewood.com>
From: "Raymond Wong" <raymond@lifewood.com>
Subject: Re: [uml-devel] No of ubd
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Date: Sat, 29 May 2004 15:48:42 +0800
To: leen.meyer@home.nl, user-mode-linux-devel@lists.sourceforge.net

Is it possible to create more ubd drives?  It is very easy to runhout of drives.

Ray

-----Original Message-----
    From: "Leendert Meyer"<leen.meyer@home.nl>
    Sent: 5/28/04 11:37:19 PM
    To: "user-mode-linux-devel@lists.sourceforge.net"<user-mode-linux-devel@lists.sourceforge.net>
    Subject: Re: [uml-devel] No of ubd
    
    On Friday 28 May 2004 10:13, Henrik Nordstrom wrote:
    > On Fri, 28 May 2004, Raymond Wong wrote:
    > > How many ubd drives are available to use?  8? Or 256?
    >
    > 8, each with 16 partitions.
    
    To create an ubd partition, one does on the host e.g.
    
      dd if=/dev/zero of=rootfs count=1 bs=1G
      mkreiserfs -ff rootfs
    
    But how to make an ubd drive?
    
    Cheers,
    
    Leen
    
    
    -------------------------------------------------------
    This SF.Net email is sponsored by: Oracle 10g
    Get certified on the hottest thing ever to hit the market... Oracle 10g. 
    Take an Oracle 10g class now, and we'll give you the exam FREE.
    http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
    _______________________________________________
    User-mode-linux-devel mailing list
    User-mode-linux-devel@lists.sourceforge.net
    https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
