Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BU4W7-00012y-7k for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 May 2004 07:08:55 -0700
Received: from main.gmane.org ([80.91.224.249])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BU4W6-0005s1-5g for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 May 2004 07:08:54 -0700
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1BU4W3-0002RI-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 29 May 2004 16:08:51 +0200
Received: from pd9e5833c.dip.t-dialin.net ([217.229.131.60])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 29 May 2004 16:08:51 +0200
Received: from skoehler by pd9e5833c.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 29 May 2004 16:08:51 +0200
From: =?ISO-8859-15?Q?Sven_K=F6hler?= <skoehler@upb.de>
Message-ID: <c9a5hf$k05$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] humfs + xattr-support
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
Date: Sat, 29 May 2004 16:07:39 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

do you remember the idea to store file-metadata in the file-attributes? 
I don't know how Jeff liked it, but some people thought, that this 
should wait until reiserfs3 has support for file-attrbutes or reiser4 is 
released - well, support for ACLs and file-attributes with reiserfs3 is 
in the upcoming kernel 2.6.7. Simply add "acl,xattr" to the fstab.


Sven




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
