Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ApXG6-0000NX-Sw
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 07 Feb 2004 10:32:50 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1ApXG6-0002AG-A6
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 07 Feb 2004 10:32:50 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402071933.22071.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] remap_file_pages change for UML
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 7 Feb 2004 19:33:22 +0100
To: Ingo Molnar <mingo@elte.hu>
Cc: user-mode-linux-devel@lists.sourceforge.net

It was you the author of that change? I've read of it in some of the -mm 
announcement that I no more find. I even thought I dreamt it, but I found 
this sentence in the 2.6.1-mm1 announcement:

Dropped the remap_file_pages() and prefault work - it is suspected of causing 
stability problems.

That work is not directly related to UML, but I somewhere (from you?) read 
about the idea of using that to solve the need for UML to mmap pages one at a 
time. And that seems meaningful enough to me.

I would like to discuss it here, because maybe there could be other ways to 
solve it (I had one idea, but it is probably bad - so for now I don't post 
it).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
