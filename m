Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19ucn1-0001eM-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 03 Sep 2003 11:55:35 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19ucn0-0004Wr-Mr
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 03 Sep 2003 11:55:34 -0700
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] hostfs as root 
In-Reply-To: <18250.1062613374@marajade.sandelman.ottawa.on.ca>
Message-ID: <Pine.LNX.4.44.0309032052390.1118-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 3 Sep 2003 20:55:30 +0200 (CEST)
To: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, 3 Sep 2003, Michael Richardson wrote:

>   But, did this change between 2.4.19-47 and 2.4.20-8?

Not that I know of, but some timing may have changed making the problem of 
the dual permission layers more apparent compared to earlier..

As I said I mostly use hostfs in read-only mode, and sometimes in 
read-write for plain filetransfer purposes, so I barely if ever run into 
this kind of issues other than when playing around testing what would 
happen..

Regards
Henrik



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
